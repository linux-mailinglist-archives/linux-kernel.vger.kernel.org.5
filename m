Return-Path: <linux-kernel+bounces-159647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5398B318D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958022886EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904A13C673;
	Fri, 26 Apr 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="dw96fj/5"
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6113AD25
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117296; cv=none; b=eZGsvAFwKTGqKdNsUhsSleH2xs2QiX7EyWyk7Yh96dOcz/oNIQdHFmIMWp2PS5QX4X+svqZgaVkQ/iUJ8Zc92a2K9Py1Dwimd0F1G8wumDvas1LpBb+OiaaohGPWRWeaDTAK9Uk6hmXe66vmqSba9EqVbNde7ZNJfUvyGKHqWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117296; c=relaxed/simple;
	bh=kG0sH08nf1lQkdLAh/Se5aSDHgpHWfmeFbkpYB7n+go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7MX4fsM2KPkBOkQU7Yoriz8rzewOI716aR6NC7HleZiLVbRpEv0GRo/rLfw9AGmcFWuTBvzQGNJbOPCAcQBfAsbAizrQDHpYtw0M+HLpMhFYuCopMmxJ1mE42X+o/h3xg/xUwuZnFuDYZLKatEWXCxxNxecmux6F2gABzM69zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=dw96fj/5; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.21.121])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 0GA2s5OJj7AmW0GA2sQ97q; Fri, 26 Apr 2024 09:38:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714117103; bh=kG0sH08nf1lQkdLAh/Se5aSDHgpHWfmeFbkpYB7n+go=;
	h=From:To:Subject:Date:MIME-Version;
	b=dw96fj/5iee+aghzWTOm4dI0qFU3ychT+WtgiicUnxkCjc7g1k5LFmCT3vvwpxNao
	 dbIhNktoTPo+gn12Q+CEYtb5bo3qv81kvmvdaDT77bw5/ZgnRABu1Scis+1i7EjDvm
	 pIw67l79aEdBoyvYpWwHXw20uH+srrzYr/iWwrpy57TCOQdhq3fYE3x8fLMdAJ59w7
	 rID0lcbLV1iTiZWRiLkfzghapud1uiIy4zPEJzEkrUAGOvUY4VNWavF2bPuxYQXXDw
	 uNIa+ToptAA4VACWTmt64BoF+Bmra/DsPN/1Hc6C+OuK5DbtVP3QhJnq7tPsbiKNBs
	 4zd6S1SgD9mrg==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>
Subject: [PATCH v5 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Fri, 26 Apr 2024 09:38:17 +0200
Message-Id: <20240426073820.6466-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOP/R9R9D0dRC011s99UnezOhO224WLuz8m20iBhLh8XM/hLiOX7ktXNTlZyyEDLVmTHEQYTcC0BSZCLfQVotkc8xt9M0NDT47qpeR0DY7eQt0XiR6D0
 Swp71vIaYH+W8FN/WK5ljcTuXRxFM+Par06q7Nz+k521lVJswF8KNi7XGracgoC6SqJWMSvW7vxjT9cCmckb2hYbikd2CTHkPRCpACGsXRheaFr7xfLOwoH6
 kgJczQ5r9RXcwzfSKANtQgnEeiDfcE8lFSpk6/1bgQKB8613y/sjP8sVZ3nusuHfnydk5M+R4pnlo91gLmpHLLCrQ8EkSYPkpGUvAlOEMsYEWbw2V+sRWU2g
 TbqqPRwEw0pD0TwpjmoiifR8fw8fcMnUPy+c8svXhTZ6Cw0DwdiG7WrW4A8iO9Dor5VpXjfOBSi++6Mspx7h52fX9vgBS2B/kLpehLb1cxcdPKtpWz4Js34a
 /Ik5sEc4IPW1Wbki/e6YM9i0ZGegC74Mbmw8ZCoQkgkTD1QPB9/RNF8CrcEfLXO3KEnE9SZr4/qwBsdk

Hello all,

this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
a SoM + Evaluation Board combination from Engicam.

The number of patch has diminished to 3, for I dropped the
patch introducing a change in nxp,pca9450 binding which has
been already submitted in regulator tree.

(Dropped also regulator tree maintainers as recipients for
they aren't anymore involved in this patchset)

This patchset introduces just basic functionality for board.

Thanks in advance,

fabio
---
v4 ---> v5:
	- done some property reorder, indentation fixes,
	  node rename, drop/add new-lines
	- fixed line wrap in 2nd patch commit log
	- added Reviewed-by tag
v3 ---> v4:
        - drop wl_reg_on regulator in favor of
          mmc-pwrseq-simple
v2 ---> v3:
        - fixed dtschema warnings
        - added Acked/Reviewed-by tags
        - removed regulator-always-on on
          bt_reg_on
        - fixed clock rate assignment on
          sgtl5000 node
        - added wdog_b-warm-reset; property in pmic
        - fixed indentation issue
v1 ---> v2:
        - dropped patch updating nxp,pca9450 binding
        - fixed indentation issue
        - fixed missing space issue
        - improved naming of regulator nodes
        - removed unneeded include
        - fixed email recipients


Fabio Aiuto (3):
  dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
  arm64: dts: imx93: add Engicam i.Core MX93 SoM
  arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 343 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 ++++++++++++++
 4 files changed, 620 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


