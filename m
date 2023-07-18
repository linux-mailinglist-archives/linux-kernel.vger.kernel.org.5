Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E71757730
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGRI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjGRI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:57:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B7FA;
        Tue, 18 Jul 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689670653; x=1721206653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuWS5EBlbidmNbMdZoCDobgf12Z0+c834VJEsJUml0E=;
  b=Tr6RlbwBFswVzPvL8N7vlYMgfhw4XGfYmkAUXT3oZ7cOJJiZTCdvzHbs
   34bY2aEG7QoJIESRH1Hzt945+PR69FUA7F5eHmOgF44CLMGaZ4L6Y5Yqe
   DaBgHcjOxABJSk1xezrZUTHTpztd8pyiI1/4dAiWgJ4Kuw+XoVVOc2Yyt
   cLV5xmzv4aE0YdnsR2/pUcLIyRONhXdHbXtQJWUvaK4xVeazfipHbwhT4
   M/AEsnwM1H0ubc7m0oXxrbZZp5hBMaNuhhW97sOH6FAJilAuYiN9MzI5D
   LYO3kk9rejK19RMRjJQnDGw5H2H7ii3VXDfILFAGw/Xce3S/MzE4jGd3V
   g==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684792800"; 
   d="scan'208";a="31981426"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Jul 2023 10:57:29 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 52CC4280084;
        Tue, 18 Jul 2023 10:57:29 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: arm: add TQMa93xxLA SOM
Date:   Tue, 18 Jul 2023 10:57:20 +0200
Message-Id: <20230718085722.1198862-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
References: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

TQMa93xxLA is a SOM variant in the TQ-Systems GmbH TQMa93xx series using
NXP i.MX93 CPU on an LGA type board.
MBa93xxCA is a starterkit base board for TQMa93xxLA on an adapter board.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..8048c7f6a299 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1219,6 +1219,25 @@ properties:
               - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
           - const: fsl,imxrt1170
 
+      - description:
+          TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
+          using NXP i.MX93 SOC in 11x11 mm package.
+          TQMa93xxLA is designed to be soldered on different carrier boards.
+          TQMa93xxCA is a compatible variant using board to board connectors.
+          All SOM and CPU variants use the same device tree hence only one
+          compatible is needed. Bootloader disables all features not present
+          in the assembled SOC.
+          MBa93xxCA mainboard can be used as starterkit for the SOM
+          soldered on an adapter board or for the connector variant
+          MBa93xxLA mainboard is a single board computer using the solderable
+          SOM variant
+        items:
+          - enum:
+              - tq,imx93-tqma9352-mba93xxca # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM on MBa93xxCA
+              - tq,imx93-tqma9352-mba93xxla # TQ-Systems GmbH i.MX93 TQMa93xxLA SOM on MBa93xxLA SBC
+          - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.34.1

