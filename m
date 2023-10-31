Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA627DD743
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjJaUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJaUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:47:16 -0400
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45075FE;
        Tue, 31 Oct 2023 13:47:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9414AC047A;
        Tue, 31 Oct 2023 21:39:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1698784757; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=qde+JqdKc+CdXiwj1NnhKt7JXBWTzkZQwt6vtInJm6I=;
        b=Ctsut142x+UPHkbQaExq8vH6wrBLxrdBwkrWlNBSSLX3U8Ifb/aQuSfxaIGvK6dPCnWtMG
        wpRxet7sw1C4NRIHM0/W1uCbc2pebe+d5DkYNJoUuJvtGiFTUa9icR6UGsxSKY2PNKeK99
        irCw3tP0VQON276mFf3dIi8NhvcT04Ii4Vw7YSaForqaoUppdMefIpSY/IMqf6ntK9ZHi4
        CydFfjeHY2M8rYYO1J1gIVqXeaiOqxudpUyaLvhTUQbrgJ/E7lQehWG6Dy06gL2LKr/h3r
        sYFr+MLTbjaO69DNmt/lpf0t+fNX0RXQEBIVNAQiXsmxl6BgcrNQDqYEflZ+OQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 04/14] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
Date:   Tue, 31 Oct 2023 21:37:41 +0100
Message-ID: <20231031203836.3888404-5-frieder@fris.de>
In-Reply-To: <20231031203836.3888404-1-frieder@fris.de>
References: <20231031203836.3888404-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There are external pullup resistors on the board and due to silicon
errata ERR050080 let's disable the internal ones to prevent any
unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index f1326bf634a7f..88da7fb71b193 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -421,8 +421,8 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 1f8326613ee9e..2076148e08627 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -237,8 +237,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
-- 
2.42.0

