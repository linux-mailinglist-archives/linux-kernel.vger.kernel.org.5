Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD347DC0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJ3ThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJ3Tg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:36:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D442E8;
        Mon, 30 Oct 2023 12:36:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7050734e87.0;
        Mon, 30 Oct 2023 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694614; x=1699299414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsTszCSXFvrVoDKYOUlX0fXU0RZFKqac+kUpQnY46h0=;
        b=W4YQ9fCaKV9tDJKF4uQu/OSDPGxuvJSHdSLodpK9YQ5sChfsfd2lrUAmrlDN6WMTNd
         p/QZ1gwdBS93OwHOsU4dNCPymbtpvHXi4nuS1aWGh3fYAeah8FkJr8jBmAYYq4pVJ3VV
         Ovwgz4f+YfxD4A3YbtoymGdvs8DhIMW9Ngcw8BtKr9xucacBVj9UfeHZIxcUTX8iBArE
         f1Yj1vLGX2XrsJmfyFM/Jv3mCDl5VwR78ILQzf3Tu86Gyl2HviEWlWHoQlLEPFHOIpjF
         LRzPE7QP1UR2ge8dicc6WC1xxZux/AexApqXFYjLmox7sN7PtjhggVyU5L3yNF5nyOWX
         cueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694614; x=1699299414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsTszCSXFvrVoDKYOUlX0fXU0RZFKqac+kUpQnY46h0=;
        b=FS22tgsaaTIgUKNFDYGnGGb8V87Hxo9POyIYMrmzt848sOHYPhwdNpqvb/KS47vTaL
         6qBSmXsDTRMsqP3Osn/fZsLpVks5zoNQOW2JB9x58KFWIovEJfNV5FmrTaWXXZu7lQoh
         4DTlKc4vg1HABWxDN7xOjrAAvkFF4OhuYR4r1YA4JtOcycKenA6CeNrYYpbxeoMxs66T
         AvNusE/t0VABuuwuF3vVWNbllY7AfjLjHNHYIie9pwqNCUuRdLCh565x1pzYivDHXxz2
         ZGPMiSHufBXyVFwVLlIgCJjOwE+t+LhdPkJLG/WLBf7VOx7Xv8AEkllty7BGD/qG5EVR
         0mHQ==
X-Gm-Message-State: AOJu0YxsDpTB+0zBcXfz+4UbAZdYKmDTfWTVCPRskPxkv/pKOc17FJlf
        b/kKXN/UGrdYfvah2R3Yr7Y=
X-Google-Smtp-Source: AGHT+IFB+RKv2I5H6bnmHVz+Aw2ioB6q7i0G0n1NYuRW/nXkfYXYrsukRucFQUg8sOwllWzNENVKKA==
X-Received: by 2002:a05:6512:1107:b0:508:1178:efa4 with SMTP id l7-20020a056512110700b005081178efa4mr9370551lfg.55.1698694613737;
        Mon, 30 Oct 2023 12:36:53 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b0050482b29ac8sm1510781lfl.31.2023.10.30.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:36:53 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:36:39 +0100
Subject: [PATCH 2/6] dt-bindings: mfd: brcm,bcm59056: Add compatible for
 BCM59054
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v1-2-3517f980c1e3@gmail.com>
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
In-Reply-To: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694608; l=4952;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=J5qoqMtHdHEbtDpozL70617xHH15jYDWQN+WwVZOQIk=;
 b=CpQns/5NHRryN35mhzpRZ+QiuHTlaUGPSZFCWeE6W3Z8X9lMl5FOSeWs+7HRasA6qKs7eWOcJ
 8oyHAAdrH3xCipZMdjS0mBZ0GxHEdOmrenJwRdWMVZdvFBP8uxydgTm
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM59054 MFD is fairly similar to the BCM59056, and will use
the same driver. Add compatible and specify the allowed regulator
nodes.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 125 +++++++++++++++------
 1 file changed, 88 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
index 6d6acc9fd312..5b5044867eca 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - "brcm,bcm59054"
       - "brcm,bcm59056"
 
   reg:
@@ -24,43 +25,93 @@ properties:
     type: object
     description: Container node for regulators.
 
-    # The valid regulator node names for BCM59056 are:
-    #   rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
-    #   mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
-    #   csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
-    #   gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
-    #   vbus
-    patternProperties:
-      "^(cam|sim|mmc)ldo[1-2]$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-      "^(rf|sd|sdx|aud|mic|usb|vib)ldo$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-      "^(c|m|v)sr$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-      "^(io|sd)sr[1-2]$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-      "^gpldo[1-6]$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-    properties:
-      "vbus":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: "brcm,bcm59056"
+    then:
+      properties:
+        regulators:
+          # The valid regulator node names for BCM59056 are:
+          #   rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
+          #   mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+          #   csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
+          #   gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
+          #   vbus
+          patternProperties:
+            "^(cam|sim|mmc)ldo[1-2]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(rf|sd|sdx|aud|mic|usb|vib)ldo$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(c|m|v)sr$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(io|sd)sr[1-2]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^gpldo[1-6]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+          properties:
+            "vbus":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+          additionalProperties: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: "brcm,bcm59054"
+    then:
+      properties:
+        regulators:
+          # The valid regulator node names for BCM59054 are:
+          #   rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
+          #   mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+          #   csr, iosr1, iosr2, mmsr, sdsr1, sdsr2, vsr,
+          #   gpldo1, gpldo2, gpldo3, tcxldo, lvldo1, lvldo2
+          patternProperties:
+            "^(cam|sim|mmc)ldo[1-2]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(rf|sd|sdx|aud|mic|usb|vib|tcx)ldo$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(c|mm|v)sr$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^(io|sd)sr[1-2]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^gpldo[1-3]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+            "^lvldo[1-2]$":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+          properties:
+            "vbus":
+              type: object
+              $ref: /schemas/regulator/regulator.yaml#
+
+          additionalProperties: false
 
 required:
   - compatible

-- 
2.42.0

