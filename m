Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A9D80730F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378994AbjLFOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379102AbjLFOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:48 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2CD44;
        Wed,  6 Dec 2023 06:44:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77FDEC0191;
        Wed,  6 Dec 2023 15:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873883; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=9tDzhWrZuTaKInW57NumdE7scux5IsL/tfSmFVPexRg=;
        b=HP+2WGA2lTX9jZ7iMu98kMGZJuLSt65SAea3jw+Y9GRJdLiEi6UwcYJMo8bEyFNtjwjvF0
        mJ2fG1aUu2/otSybMa6d1TCki1S1qd9df9PUeO5+sDHKbjB1YHbSJ64ragM0jC7JExkkGM
        cZKYMQ9L4Y736vH91Onffn3MLduwcjXCSkxjUk3mBJSbLDZ0vc66R7BFQBFdwnELt8zGhj
        zUIZCRa67B4MoRkDVN3l1KnJ66Ue8keV8JfHwYi/cwGCRte4KPuAvNcw0G4Fj/q6DpMsEP
        DlS6xtaB1wU0TvTYHJ9WX1AworZDJ/JAROnrnlPslaatNsHnNM89Qc1tp5EKWQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 11/14] arm64: dts: imx8mm-kontron: Disable uneffective PUE bit in SDIO IOMUX
Date:   Wed,  6 Dec 2023 15:41:14 +0100
Message-ID: <20231206144201.46911-12-frieder@fris.de>
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
References: <20231206144201.46911-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The PUE bit is only effective if the PE bit is also set. To avoid
confusion, disable the PUE bit if it is not needed.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* none

Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 7c5586efccc59..12f786a72fbd5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -362,7 +362,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
 		>;
 	};
 
@@ -375,7 +375,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
 		>;
 	};
 
@@ -388,7 +388,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
 		>;
 	};
 };
-- 
2.43.0

