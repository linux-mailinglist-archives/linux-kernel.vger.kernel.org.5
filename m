Return-Path: <linux-kernel+bounces-161994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20F8B5453
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0467B2154F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F90286AE;
	Mon, 29 Apr 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Qm7aHLwO"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5C23746
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383270; cv=none; b=Iakf6XE+TbaMnaRuz+rqApCqlADAyHawBJbUn5UpM1e1Pzxav/DhkehGJzjLEF9lCSU8FbiB35q1Xd/WkunurGseEbrlbDE6VOTCAqkqt57Rm1cAks7Ck/22HSv6hE6qwB6WaT0GMaksPdHWOzoXbupJ/gvcMq8qVpZ7NcQ5MvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383270; c=relaxed/simple;
	bh=jYtPjcFKCu49Meh/96iQOtFJ3WgWReEYMDANoDirFZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxNtU7fUhQ0nlTSeZdvq1YWPAnManTmqJ4hw/JCz2esCeUGLloaG1zIp7d/JnjEqmoM0rARbG+Uj2wwnwJ928r2zkCrxIqqyHMW2Ux4uN7HLO3EYCLug4ghyCJpM4oeYSEB6F+94wb7G+5v6Hx3ebzSXoqTPrUp+FGo9VbuTehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Qm7aHLwO; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1NLxsVDmQ8U421NLxsOAgQ; Mon, 29 Apr 2024 11:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714383078; bh=jYtPjcFKCu49Meh/96iQOtFJ3WgWReEYMDANoDirFZw=;
	h=From:To:Subject:Date:MIME-Version;
	b=Qm7aHLwOPA1QVs35D3wFDBBlLtkwHlytRBQ+kY8iVpCozYQP7x1ztf1Ce4oERhSEl
	 tO7uluXF8JL9wBrdGAu9dtgDmMW01YsR+dXl7pyXR1W5Azk7dzFRnpRRTbE10sfsty
	 itr2WpaRtZ0LYqB7HGParUBZKin/4cahkJCudAqzRcAyK4Wmr3KZBMiwmUzmLNi15l
	 CNMrXlm5KkhMiAEsjydI8YBb6v2zNIGqAz88Sntnuaxs14xI5f+umB117fpysgWdto
	 RiHET7UUNQSwLTHrCVIVYexGAnlwQlCuLUGZSAHNZDfBKuuKwXbo5c/dlPESTMO9L2
	 GyeEBQRjiLmLw==
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
Subject: [PATCH v8 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Mon, 29 Apr 2024 11:31:13 +0200
Message-Id: <20240429093116.9346-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMjEokuSxgu8rdo8B5Qc0dov8DNzpZcvyqv6+gfR2HKlxrQ68OwtsPw4qkPkQEvVb9ieCpuD6onS8zCEfZUo2DzrqdIh/8fRMov3EVHb70alJErf1fym
 eecV1keRTq/FsblcekPrdttk6ifFOScwZ0J7aIifahP6Y4ftTh8NUL6ZD7IIRIJpqEfxYtbP6EdEvrjIMZ1C0n+G/Hty8BM0kjHRTNmkOsf1932Pt42rdoLd
 rITS8Zo8J2NHyYevRUbuJfUKFZ4cjit2KngmkmZKA38ET0V/PnrACw6elmA9YmdszW8Xg4RzVqcF+Gts17osb5/smxv7qQlnh0pNmnUniu1pXk2pco7p18BU
 lvuYDJ0vZ1mxf4rLUcbyHmBlJqLBUU4/kthtfXkXGOoqmVIM0ovXmKWHb1i+Mokaomvd8xerUb0zJ36jT02AFwLRJP0ahih4LneYM+JApYIQq3vmPcE3tkvn
 et9rNdL1HBIhSrx2LEpPRTr/NSJWzAJzuWbgxUy+XVCePnHTLUxD812LC4Q=

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
v7 ---> v8:
	- fixed tag name in commit message
v6 ---> v7:
        - removed max-frequency property in wifi node
        - removed pinctrl-{1,2} in usdhc3 node
v5 ---> v6:
        - added property in lpuart5 node
        - removed unused sai1 node
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
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 321 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 +++++++++++++++
 4 files changed, 598 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


