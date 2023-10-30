Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA817DC0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjJ3TmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJ3Tlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:41:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B4BD;
        Mon, 30 Oct 2023 12:41:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50930f126b1so113705e87.3;
        Mon, 30 Oct 2023 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694910; x=1699299710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsTszCSXFvrVoDKYOUlX0fXU0RZFKqac+kUpQnY46h0=;
        b=ImmCauaL2cx0xUGr3e1n7HSNx3TmU2tI7WiAyvRQRDAhMtjJF4CGMAP7vdTNvQthqs
         +aJYDR/v0Ic+0Eofv41uUDMMMr1rX29KnyHz7bgifM7q3BJdTq5n4eE0UM/Rs12a7VwP
         M0yjfe/XbxroWjL0LppoU/tmSXic4DN5URoyPRjHL6BXv4jMnXhuU4Sc9/Bc2upsqx96
         FvF+PJWJKSmSbOc+lxaHuEMWS1gmUUg2DmPi/lcUmgeeJ7/d49lgLpT1dx2vbiYT+g0X
         Ut3tdnkvVLu1pw0GoTCDxPxZn3qZf+QbZ2/fkVXOnEJw3X8P7wKpNyG8Ab4XGl+x0Sdz
         YA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694910; x=1699299710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsTszCSXFvrVoDKYOUlX0fXU0RZFKqac+kUpQnY46h0=;
        b=TdWwThTC2RQq6G3Bak8d3M3HNcyXCHsFRrwidV7a0jzJZc7MUb51Ant23vWqoQW9GP
         wal8D6LVi4XEB/Wm045ToxvdsEN7aBeWNxuoNdbpwLre96pDs8Gy8XPlKd7RsXtJVhAo
         VvkMTrL3RMYtGIiyFMGzpnBe2D+v1g10doVYPFA7xL9254eVCXab0d6LjFKx86CoYaBc
         8a0woufT5xNi4Fw+R4xzDuixIArFSNKT/B/HP9GacJNqVlVJ80FEx7tdekKw2OeKpPgI
         9/dGT81A/cCfzsWZ/InS08ZhNjKjpRWjOupHrAVBqemhAI152SjuOS125ZAa8dzv0y/b
         urFA==
X-Gm-Message-State: AOJu0YyN3BG+bBs2vie4nmnXUunIkb2QlLbVNff08mAJutotUIBf4nTx
        cyqr2o7RrCqyQnvn2m8mmzZ0o8+n2U7LRg==
X-Google-Smtp-Source: AGHT+IGYQoyMZ2H8yEcSdfZq8bBvetLhpTMgf6kX8yku45ElmdjlVHmmTYqp+in7EJYqqhmJszyYjQ==
X-Received: by 2002:a05:6512:3683:b0:507:ba28:1bc5 with SMTP id d3-20020a056512368300b00507ba281bc5mr6645678lfs.3.1698694910355;
        Mon, 30 Oct 2023 12:41:50 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:50 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:44 +0100
Subject: [PATCH v2 2/6] dt-bindings: mfd: brcm,bcm59056: Add compatible for
 BCM59054
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-2-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
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
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=4952;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=J5qoqMtHdHEbtDpozL70617xHH15jYDWQN+WwVZOQIk=;
 b=LHx9ucpq3SWxJ6vasg2DPvwm7bIGrPH0ju2dTB62mEmMJUxxHVvKhNbmxUw6WbgWB7NDaVEsO
 8Iyv36IpHN6Ba0VZxh/EHiNyjt6gM7KznFdrkZp6z73J+GV5eu0g4c+
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

