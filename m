Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D447753BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjHIHKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjHIHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:10:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00C1FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:10:40 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1qTdKw-0003NV-7p; Wed, 09 Aug 2023 09:10:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Date:   Wed,  9 Aug 2023 09:10:24 +0200
Message-Id: <20230809071026.3546605-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809071026.3546605-1-m.felsch@pengutronix.de>
References: <20230809071026.3546605-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
corresponding bindings by adding an own entry for it. Adapt the comment
for the "polyhex,imx8mp-debix" binding to make it clear that this should
only be used for DEBIX Model A/B i.MX8MP SBCs.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changelog:

v4:
- adjust commit message
- add Krzysztof rb
v3:
- drop 'deprecated' status and adapt comment instead
v2:
- deprecate polyhex,imx8mp-debix

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..d86004aba1db 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1033,8 +1033,6 @@ properties:
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw7905-2x # i.MX8MP Gateworks Board
-              - polyhex,imx8mp-debix      # Polyhex Debix boards
-              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
               - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
@@ -1068,6 +1066,13 @@ properties:
           - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
           - const: fsl,imx8mp
 
+      - description: Polyhex DEBIX i.MX8MP based SBCs
+        items:
+          - enum:
+              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
+          - const: polyhex,imx8mp-debix             # Polyhex i.MX8MP Debix SBCs
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with Verdin iMX8M Plus Modules
         items:
           - enum:
-- 
2.39.2

