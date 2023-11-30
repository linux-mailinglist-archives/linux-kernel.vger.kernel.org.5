Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CE87FF48F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjK3QSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjK3QSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:18:35 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F26D1700;
        Thu, 30 Nov 2023 08:18:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3402DC01DC;
        Thu, 30 Nov 2023 17:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701361118; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=4wc5xlMkQVwPcIfy78SOPNz2f9X1LzOiI43PLTGlKIw=;
        b=HIqDSTpFOvPNcaV3anPh7zEcy3RpJpAPoJ9yc+LRE1KhwmhP2OJhltFzQgAT4/NuyJlQyv
        8Tzn1nLuxp86boeemiwUqvBVWgNtRpTN8Bzgsn7P37J2YbjL9tzcHu70VRrJ8j1383+RQy
        zE5vih9Ohd5/tgq/dWuaSKVGGlU2ca8aXlJiHxNSJ8JjesPWw7dgPVTvMU+mR7EowhmBdl
        wfVUCa09RlgiTKB2XC6eKfncJ2DBXoeWbyQkmRqeWoNQosW/1b8gOG4M6Zjd27n+ITgkDr
        R0yUiB1HQmn07VSJxQRWlmFMJ04omLFBF9QPJvI1UaCVd2RMC4qk0nuZ+FmVUw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 03/14] arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S i.MX8MM
Date:   Thu, 30 Nov 2023 17:16:03 +0100
Message-ID: <20231130161657.556483-4-frieder@fris.de>
In-Reply-To: <20231130161657.556483-1-frieder@fris.de>
References: <20231130161657.556483-1-frieder@fris.de>
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

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 8b16bd68576c0..0730c22e5b6b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -294,8 +294,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 6e75ab879bf59..3e7db968f7e64 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -252,8 +252,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
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

