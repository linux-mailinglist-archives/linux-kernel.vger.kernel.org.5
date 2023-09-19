Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755807A5BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjISIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:09:46 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149C116
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:09:40 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92A261A06A7;
        Tue, 19 Sep 2023 10:09:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 655B61A06AE;
        Tue, 19 Sep 2023 10:09:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 652221820F57;
        Tue, 19 Sep 2023 16:09:36 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marex@denx.de, peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        laurent.pinchart@ideasonboard.com, aford173@gmail.com,
        l.stach@pengutronix.de, Frank.Li@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: [PATCH] arm64: dts: imx8mp: assign parent clock and rate for audio clocks
Date:   Tue, 19 Sep 2023 15:32:55 +0800
Message-Id: <1695108775-22924-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign parent clock for audio AHB and AXI clocks, and assign
clock rate for audio PLL1 and PLL2.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..8a8a2c4aff9f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -734,16 +734,26 @@ clk: clock-controller@30380000 {
 						  <&clk IMX8MP_CLK_A53_CORE>,
 						  <&clk IMX8MP_CLK_NOC>,
 						  <&clk IMX8MP_CLK_NOC_IO>,
-						  <&clk IMX8MP_CLK_GIC>;
+						  <&clk IMX8MP_CLK_GIC>,
+						  <&clk IMX8MP_CLK_AUDIO_AHB>,
+						  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>,
+						  <&clk IMX8MP_AUDIO_PLL1>,
+						  <&clk IMX8MP_AUDIO_PLL2>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_ARM_PLL_OUT>,
 							 <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
-							 <&clk IMX8MP_SYS_PLL2_500M>;
+							 <&clk IMX8MP_SYS_PLL2_500M>,
+							 <&clk IMX8MP_SYS_PLL1_800M>,
+							 <&clk IMX8MP_SYS_PLL1_800M>;
 				assigned-clock-rates = <0>, <0>,
 						       <1000000000>,
 						       <800000000>,
-						       <500000000>;
+						       <500000000>,
+						       <400000000>,
+						       <800000000>,
+						       <393216000>,
+						       <361267200>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.34.1

