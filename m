Return-Path: <linux-kernel+bounces-161924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8B8B5365
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DE21C20F37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80F1755A;
	Mon, 29 Apr 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ZJHLrDfV"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB40C2C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380457; cv=none; b=bWgW9Q+lHr8SOKrTOXqZjMIirCcofFpYgO0wS7mpkguE1OCOs9NqcJ4Tr23e2/hZIcy367phWPRpAUrttO4hfaKF+HxdoCcH5xJ/RndhqiifHHAdhYRourDW6Oa7khuaxgLXovataza7ySquc4NWIRnu1Qd+9QhfLHfH0DoCBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380457; c=relaxed/simple;
	bh=iBfSG1Z55LzWjpgCDWCYWUujtAFFgjE9Z2IZOD3zx94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqbNe3Ti5QPE9wXx4Z03pfHqhWOGnbL+CC8SuppqROEcDCwbsfcgpazWACnSMA/woCXNnCZz7CRGnnvsAJdRBO5GwlX3oj26MvcMn41rQ+XLlqsMEQKldlubhlPtk1N+nPRGh1IAJEbjyhiRCzppcAlekJ5Uk8NUobC43ypSCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ZJHLrDfV; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1McasUO2u8U421McasNcew; Mon, 29 Apr 2024 10:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714380265; bh=iBfSG1Z55LzWjpgCDWCYWUujtAFFgjE9Z2IZOD3zx94=;
	h=From:To:Subject:Date:MIME-Version;
	b=ZJHLrDfVPOAzeM1Bwxb3gwk+yjIP+uOaw+iE5o5TQCmUb5pcJA/nF1vxBCxpTxrGd
	 arsAFJrFrwUbvUevcnGfBm9ZdDfeUgN2a9FB+CzaHJHEXXTgh0A232Qqfj9Te6J5RD
	 u5LAHSaUjBgibhMgfgfo9X2Rl0hcjl+mowHpUvl6QQvwEh97cbNlgBX1fXlrURVoNT
	 L/ahZCXS8MPbtF1xN7lNTumUZoBxrB09I6y2j29CfS2pmgaqcTrbUfUdB9hLnkkWUP
	 wJHIGC/Q/Oo4qW7CVFvdwwXl42Vh75XIfDHoJ7onpVh7A1reIWbmrUf6N6CaUcElxA
	 Qv8U0ySh0wnyg==
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
Subject: [PATCH v7 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Mon, 29 Apr 2024 10:44:19 +0200
Message-Id: <20240429084422.8369-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL4xsqUjG2/KzKynxLSLT/YltDoPaQriW1ShrLPlbrDtT04jHN1UKRXpRGtvgwCBrItj37o9iwd1PMerrUSWHKq8CuR3i/eF+r+bFwDr8nRWDfQGLge/
 MppHEoo7AmTjsDs2J3TYeZ7P2Gst54/0B1vfW3ncXtWMrssbkdrb1pJ+QYiZUC92YtHstWhvmJ1SsWGXTaaLunk1hi7SdbhrY1G3k9iwdGc7IKwv8NOoWdiz
 9EwbT7uM+JdqvA7Qz4CUCPklcPUhOnt5lgAJvimf/mZ+Py7bmj9+dvYjSHyYJHQ8EnIicDjq4pLHCly1+2ogliRKOru7wmod5Q84HZzkNylO3OS7POuF8y2x
 Yy+hAJdxETw7MkCLQtniTbjCD/hvmly0aHMHxd75dQ3mVN4dec5qd3G2HovwNONT3TG3fcapSCdjn4Oh2zIm3MMHP4jJco6w/QeoVwIfLiKKE9UE7fc+iQMZ
 zgk4t+8u7MOfBD9LpmPzmNRpP2JJK41WqhK9e3m/77mgyFlK/tchaFLnh/w=

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


