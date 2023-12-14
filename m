Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339F68132F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573462AbjLNOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573436AbjLNOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:23:27 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9153A7;
        Thu, 14 Dec 2023 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702563814; x=1734099814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLc79ehLKHzTwYeXZeaPOBNlJM3lI7AeOkDs1ow+EXQ=;
  b=JOsNyT9JDkDM/GTOdbLNup3oBNaA+uEXViCuBCg9KZTyWbttMp2lZkO5
   B2b6Y6po/HhvXRjBhS4SX7P32+1dRX7B5eTySTndaaOY5CB9mesoMWx6e
   VzXyEIWta2FW1+SwgOQtyPQqySHfva20p2D2jRgoBNKRwJ6nR5GR2Atea
   TpKutSeo6/yM+Pvk9rSH5WP9hsjzIvuKCDl3EM0AKZOS84kmnbq9kG3VD
   YUb/i5PH4WZN5xs2ny2j+qXZ1aGVKacRMzmvSmwLGhDGm4PVoM6r7/RP1
   FlNP4C3x/b4VpnKUwc1VK7va4dn3H7TgSpFZFGY40zkZrThN4OaSR9r4X
   A==;
X-IronPort-AV: E=Sophos;i="6.04,275,1695679200"; 
   d="scan'208";a="34512087"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Dec 2023 15:23:30 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 35F43280075;
        Thu, 14 Dec 2023 15:23:30 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: add TQMa8Xx boards
Date:   Thu, 14 Dec 2023 15:23:25 +0100
Message-Id: <20231214142327.1962914-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
References: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8Xx is a SOM series featuring NXP i.MX8X SoC.
They are called TQMa8XQP and TQMa8XDP respectively.
MBa8Xx is an evaluation mainboard for this SOM

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cd87d1afe7b72..918a19d418922 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1231,6 +1231,22 @@ properties:
           - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
+      - description:
+          TQMa8Xx is a series of SOM featuring NXP i.MX8X system-on-chip
+          variants. It is designed to be clicked on different carrier boards
+          MBa8Xx is the starterkit
+        oneOf:
+          - items:
+              - enum:
+                  - tq,imx8dxp-tqma8xdp-mba8xx # TQ-Systems GmbH TQMa8XDP SOM on MBa8Xx
+              - const: tq,imx8dxp-tqma8xdp     # TQ-Systems GmbH TQMa8XDP SOM (with i.MX8DXP)
+              - const: fsl,imx8dxp
+          - items:
+              - enum:
+                  - tq,imx8qxp-tqma8xqp-mba8xx # TQ-Systems GmbH TQMa8XQP SOM on MBa8Xx
+              - const: tq,imx8qxp-tqma8xqp     # TQ-Systems GmbH TQMa8XQP SOM (with i.MX8QXP)
+              - const: fsl,imx8qxp
+
       - description: i.MX8ULP based Boards
         items:
           - enum:
-- 
2.34.1

