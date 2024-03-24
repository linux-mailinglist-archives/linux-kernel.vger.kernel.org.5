Return-Path: <linux-kernel+bounces-114775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFC88924A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D9F297398
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94461B884B;
	Mon, 25 Mar 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CihZDs/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110321A832;
	Sun, 24 Mar 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323373; cv=none; b=P8FBFzl1QEIWcEbtIhn8EkSv6ly/hiRtxmbHNb7NeilEmkT6Ua6k94V2JRPgO37pEV44s1FTBSvYAK8mvJ6nDgrS4+oak+KVKy7LNyEEDT501FCCZNZlA9FrY40jo+QQvyg++U3r+mXDMox6ZvPqnGvGxV92Cq1wjF4SPIo+nLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323373; c=relaxed/simple;
	bh=saDXBtUPJ2rQPi4TNk0EkS7ba6nG+1OxrXRpJV7qt9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFyi3qAjyNI2KmIA9PAm/jnkbHKFRjxaqtKRP6/EXROeyWi308UZYazkpSB4Cj0PklZM2H1vpKkDMPEn4j/D7src4QZGH9oC9OBIGB9nTifNdxUAIFYTfA/R0GtyJTlv3zAbYDXYl4n3jcQkOnWJq2AMXWkn3V2yX5lUlMVBRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CihZDs/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB2C43394;
	Sun, 24 Mar 2024 23:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323371;
	bh=saDXBtUPJ2rQPi4TNk0EkS7ba6nG+1OxrXRpJV7qt9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CihZDs/hPg7Il+TBciNlOtZ0cPupQ4uXZhPhYNT8OVlzKBSz1OlES+vFZA1H268JC
	 8VbZBdHjP6qTThvUFh/Otg/MVTQSDFTGglhRK3j3QU+GG7eAvP7Gwfbwxpn6EZ4Ub6
	 mWEbWZRb5xT2vFI4iiDwj1HwyoQu/49qeJ5nXy666abXAsQECsOYSBxpEusgtd21bw
	 Ts3LZtdco8xu6QFmNuGujvPLgkwpVVPYdgz7wmJRKvKVQmjkcDZqxRkM/17L1GL8UD
	 CoxXi8jpEU+6Y13lq74nlBdiiq4NmYdxC82w2bzsGAWgU+/JblG3UGE4k3MSQvEJ22
	 96dCDhSoZG+yQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 071/317] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
Date: Sun, 24 Mar 2024 19:30:51 -0400
Message-ID: <20240324233458.1352854-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit f19e5bb91d53264d7dac5d845a4825afadf72440 ]

There are external pullup resistors on the board and due to silicon
errata ERR050080 let's disable the internal ones to prevent any
unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 49d7470812eef..362f9360b4a51 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -275,8 +275,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 42bbbb3f532bc..646615ca4b48b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -220,8 +220,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
-- 
2.43.0


