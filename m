Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBF7E0B59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377963AbjKCW40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377663AbjKCW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:56:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3C7D6A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=TiJf9ojlNhxPnbwNmLPWFg4kCpD3p403c86z54PQPYc=; b=l5gDiE
        J0Y/10+Tr0gW2tra8ruaauzW5TGXXvtazMBns04VQdHcy2KUfRkR5YcJjq+ofCnx
        6uqV8ds+yEYX3uDNly1DjG7GAWbd6x2OoVq3qaKY36VVhEZzv1koMan8JWgzdgVd
        aS9ZG+7ba+pEx0OFpus+p7v0xaQwBOnScr0AHpZeViWw8W3vUXVp7Wj1I8MJdguq
        15iWnXPj2o9JvT3dzqreWoIosMEcU2xmKy1aVFf2aY0TBPF59hYKPlf++9kwm4Sx
        /Iph2xaQlcyiE42Qp/x5R1zLuc9Mz7hRh34Cdu9kAU2QSCA/5AUcjtcD5MwEo3ER
        4eVNYa1G39M1LnWg==
Received: (qmail 1327910 invoked from network); 3 Nov 2023 23:56:13 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2023 23:56:13 +0100
X-UD-Smtp-Session: l3s3148p1@iCk8aUcJCM5ehhrK
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
Date:   Fri,  3 Nov 2023 23:55:59 +0100
Message-Id: <20231103225601.6499-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
References: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas KingFisher board includes a U-Blox Neo-M8 chip. This chip
has a reset pin which is also wired on the board. Introduce a binding to
support this reset pin.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..8e97e475613f 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -41,6 +41,9 @@ properties:
     description: >
       Backup voltage regulator
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - vcc-supply
@@ -49,10 +52,12 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         gnss {
             compatible = "u-blox,neo-8";
             v-bckp-supply = <&gnss_v_bckp_reg>;
             vcc-supply = <&gnss_vcc_reg>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.35.1

