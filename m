Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FD7F1E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjKTU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKTU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:58:46 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD2D2;
        Mon, 20 Nov 2023 12:58:41 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 1724020721;
        Mon, 20 Nov 2023 21:58:38 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Hiago De Franco <hiago.franco@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/3] ARM: dts: imx6qdl-colibri: Add usdhc aliases
Date:   Mon, 20 Nov 2023 21:58:17 +0100
Message-Id: <20231120205818.33120-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120205818.33120-1-francesco@dolcini.it>
References: <20231120205818.33120-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hiago De Franco <hiago.franco@toradex.com>

Add mmc aliases to ensure a consistent mmc device naming across the
Toradex SoM family, with this commit mmc0 is the on-module eMMC
boot device and the not available mmc interfaces are removed.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 11d9c7a2dacb..55c90f6393ad 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -12,6 +12,13 @@ / {
 	model = "Toradex Colibri iMX6DL/S Module";
 	compatible = "toradex,colibri_imx6dl", "fsl,imx6dl";
 
+	aliases {
+		mmc0 = &usdhc3; /* eMMC */
+		mmc1 = &usdhc1; /* MMC/SD Slot */
+		/delete-property/ mmc2;
+		/delete-property/ mmc3;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		brightness-levels = <0 45 63 88 119 158 203 255>;
-- 
2.25.1

