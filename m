Return-Path: <linux-kernel+bounces-151608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0B8AB118
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD261C214C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DA12F5A1;
	Fri, 19 Apr 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="M6guRH9B"
Received: from smtpcmd0872.aruba.it (smtpcmd0872.aruba.it [62.149.156.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8712EBFB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538390; cv=none; b=AUdDbPq+Cn/QV99m7+Sb3+Lm33qBbb/RmWheie89xH5DgxjBa5vcAIJx77MvVtlvj8NHVXBKzfdxHmCeoQcHmO5/OF8pw4ESHY5DJCJ1d/SsTZgG2Z9uT39vBIhejP2J2jz3N43kWMrLi4T7yaudetvR+FPhHxmMikkYA6hydC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538390; c=relaxed/simple;
	bh=YL0cVfNueetCwAT7UvDjnlJfn4qwAPNXDHmpE9l31co=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIR/6z2lk77li0ECdZHBW0kc8pkXuN+UBFQsyHLGHi2mEaGbB3rpw1ZEb9uSwLqM7HQhzzoJGFqeI9yfBEjdiYTz0cfLoSfV+htDJVyM/WGKJtbvTh6LfBvugv6mww0pkt6kvvHNtfs12yPeURDdXJXtcpg/EaCUkwZxGvU8dFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=M6guRH9B; arc=none smtp.client-ip=62.149.156.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.23.200])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xpYprTscuBZCLxpYprR4s8; Fri, 19 Apr 2024 16:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713538198; bh=YL0cVfNueetCwAT7UvDjnlJfn4qwAPNXDHmpE9l31co=;
	h=From:To:Subject:Date:MIME-Version;
	b=M6guRH9BNHbelpUdDddvhf4J0lyaN7w28cLvwgYycubGci2pZfJL/A7tmmboV7xe4
	 iyl1w4cSqCjQd91EybhkcpSxnNaaqfsDYSbAD7wHJD9glBMWP+YChfzS8jjlDVdi5a
	 a8/O98UYvL6odiR0qfb7ueSTfoGX1sLi/pmi0qMbXiINCNhJccEiIr9DC+aepdWyNt
	 X6AKupGMRVflrgkOKvIMHgYXQLaM9uXFmRRZWljQhDe5GQGWZkMoLSUhprQ1BjC0/t
	 GrMjItZy23SX6JmRe8eAaA+ioBIhWU0ECkn4FYlBMnUhhl2yo6IT+p2fOyhe3eQeUu
	 zTcQX02YYnKUQ==
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
Subject: [PATCH v3 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Fri, 19 Apr 2024 16:49:50 +0200
Message-Id: <20240419144953.8700-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFo4JUBZwzm009nJ7bZbsQToPtL1WuiHrMH5BlyIi9hFk9/DXdbwK2z7r/FGpI/rRoSTXCINQoxNtXxbK1L8fSaRJZJYcs2yoXfyUsWN9jDHMPbJ5JvW
 bEXA/DmyTJyZvcvn2s34qTP5+6B4YL+ZlyVsTvtk4pE+vbY9QQ8ed0A1EtBfbhh5kFMrGGLcdlb9KyCH2eVkZHPcMcuJ2U8HW8ekjJf1omrq3Q+0ERyks/lV
 D5+4OOvxd9Ch17AhHgvnXpdXXe2zu6SFU/hGGmwPOvZe3vAdS1zDPtzhApW1tRI6EJw9ysNaHYLoYRA/qPV0I8DhVAA/wkl5MGLMQl79zKO9jO27neu1EGc3
 c85+KQXZrz4efyiI1GacOLhfUmlyRY30+jdgUNv/b68R6yJ614qF8u4uUdqjV5d37zskvqZoiHOAn/bJipv45E5im5f7ft8IQAddl1q3KIDxfPgailyinQCS
 Hmc7PCv5LT7FQb/GPG0Co2Oa8niG6saDOOD4wMYx9nKIDJlSmWX9V4/5JeV034MsRildFW72mPz8c4+c

Hello all,

this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
a SoM + Evaluation Board combination from Engicam.

The number of patch has diminished to 3, for I dropped the
patch introducing a change in nxp,pca9450 binding which has
been already submitted in regulator tree.

(Dropped also regulator tree maintainers as recipients for
they aren't anymore involved in this patchset)

Thanks in advance,

fabio
---
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
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 347 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 271 ++++++++++++++
 4 files changed, 626 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


