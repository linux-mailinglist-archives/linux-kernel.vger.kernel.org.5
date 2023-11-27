Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B07FA5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjK0QPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjK0QPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:15:10 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01414D64
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:15:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eGK-0001xw-Lc; Mon, 27 Nov 2023 17:15:08 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eGK-00Bz1a-4c; Mon, 27 Nov 2023 17:15:08 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7eGK-00D7y2-0G;
        Mon, 27 Nov 2023 17:15:08 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Date:   Mon, 27 Nov 2023 17:15:01 +0100
Subject: [PATCH] ARM: dts: imx7s: Add on-chip memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-b4-imx7-ocram-v1-1-430a75e3e9db@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAITAZGUC/x2N0QrCMAwAf2Xk2YCtnUV/RXxoutQFtk5SJoOxf
 zfs8Q6O26GxCjd4djso/6TJUg3cpYM8pvphlMEY/NXfnPMRKaDMW8Qla5oxDo9wLxRLoB6sodQ
 YSVPNo1V1nSaTX+Ui2zl5vY/jD5Oi7LZ0AAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roland Hieber <rhi@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: auto@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add the 128 KiB on-chip SRAM at address 0x900000.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 29b8fd03567a..31b14795930b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -183,6 +183,15 @@ soc: soc {
 		interrupt-parent = <&gpc>;
 		ranges;
 
+		ocram: sram@900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x20000>;
+			ranges = <0 0x00900000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&clks IMX7D_OCRAM_CLK>;
+		};
+
 		funnel@30041000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x30041000 0x1000>;

---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231127-b4-imx7-ocram-7d946fb7f4b5

Best regards,
-- 
Roland Hieber, Pengutronix e.K.          | rhi@pengutronix.de          |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

