Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EE7E93BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjKMAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjKMAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:52:37 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D31BC0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=TiJf9ojlNhxPnbwNmLPWFg4kCpD3p403c86z54PQPYc=; b=YE3Tog
        PpHPXlwO2TjuqG1Kquj3nAfm+3SUV6FEWjnc1gxJTZPfbLcZnVNrYWuUjZ+3eIkt
        S14S9GpmaIbJ3FKfTtYAa+Nk15KPd2dTNuClf2I6iedbeO5sfYU7QLgm7pbjX7hv
        C5pMdnEMvZFJXXzq2aq+htq4ZG5ZZA54g5P+hDvIvWrXaHMkMA89hLqQ9496m2if
        87MnzjpPF4/AkSOLMrh/gY0gFI9mVgC9AjZlUD3Wa04WM0y/6jYY/fcFdbD6egwA
        4PLCJpqI03zP1C1QALSBOCxH61ifWbA7JvD+joVPJlCPIKNIqTGBNXg+NvgBj8V5
        jjZRDOjVUBVqV/fw==
Received: (qmail 4084506 invoked from network); 13 Nov 2023 01:52:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2023 01:52:31 +0100
X-UD-Smtp-Session: l3s3148p1@OwetFf4JkcIMv8XD
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
Subject: [PATCH v5 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
Date:   Sun, 12 Nov 2023 19:51:50 -0500
Message-Id: <20231113005152.10656-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

