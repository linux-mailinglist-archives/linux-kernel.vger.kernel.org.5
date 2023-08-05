Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC2771145
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHESFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHESFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:05:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493181A4;
        Sat,  5 Aug 2023 11:05:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so30779645e9.3;
        Sat, 05 Aug 2023 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691258741; x=1691863541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYdoFc7rP2Qn0GrAVsnewk5f2j5o1yVoLkw8kbLJjy0=;
        b=r3Txk5RV5wSnvM9sUhJh/haq7s/rvtUErYBNeUGXZvyxG28S5pVHmusx9El8fjzzOe
         8d+FE5hPEyvs6E8G708I/QCAREgKXVfvQssxNDWoYgjFC91e/qQv7JPBnvHddK5GuU/u
         3r0ciKiuXdQpfn04ssBtDdwhkOrCPgF94itvMf4pV0ee8NBV7gE82gIDTSvSOCiCghQ7
         DI4HZoNJEaQGng6dUKIkv8kUoBRQu/+PB9b4/F6GIOnwnJ5Xk2uTAuT5jpxW0HoCSWc1
         RYStqJSmsIqGj464x8bUbin0bxRPm2TY5Cv9GtH1+nQoBAzbe6Y46Fn19RnmSOmP8Cdb
         pG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691258741; x=1691863541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYdoFc7rP2Qn0GrAVsnewk5f2j5o1yVoLkw8kbLJjy0=;
        b=JADhOCGfwlk4eD3CZxOV6NguLkMFIKLTzj2hwpGRjsIsSunXUAOB7CkAMOnrwsL7AI
         wt9QLwtCFFnSKABVHrTIpzKJz9HD0aIDqm0PzplwOsasW8Y/wfRnCXXd5SFbbax1YV8r
         QeK5Us8PKflMb8djvgyfAT1SLXmDPXP0+/oIoF0hxmHmZcghsXFkCINO3fwsZ3v532gd
         ub38OBd/KJZch2NMGl/mkON6kkQHveXta/ptZ+kd13RUp1X2FPCRs7h2f0eHU0OrS99g
         FN0YMYBaHQkCA5uAP4Udq+4Jh8ba93cSAvSS08L5mrnLWEEL+SxdyuTEKbbrHC3fABmS
         HK8A==
X-Gm-Message-State: AOJu0YwMJ7FXDMikyv6m44QItJEhD2VU/s/QaPp1eOwJ8qjjiQ/C04/u
        tkPLldbg2T2cAoPWoIV/o0kPuctC9IoaDg==
X-Google-Smtp-Source: AGHT+IEhVL7vlQWncytTyM/13d+OkFFEwfUKiR3bSl2fOgd9CDDE30po2p9SosJ2ijsdOWBwvqj4ow==
X-Received: by 2002:a1c:7205:0:b0:3f5:fff8:d4f3 with SMTP id n5-20020a1c7205000000b003f5fff8d4f3mr3949613wmc.7.1691258741186;
        Sat, 05 Aug 2023 11:05:41 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6104000000b003176aa612b1sm5710402wrt.38.2023.08.05.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:05:41 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/5] ASoC: dt-bindings: sun4i-a10-codec: Add binding for Allwinner D1 SoC
Date:   Sat,  5 Aug 2023 21:05:01 +0300
Message-Id: <20230805180506.718364-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805180506.718364-1-bigunclemax@gmail.com>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 SoC has a internal audio codec that similar to previous
ones, but it contains a three ADC channels instead of two, and also has
a separate clocks for ADC and DAC modules.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../sound/allwinner,sun4i-a10-codec.yaml      | 64 ++++++++++++++++---
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
index 78273647f766..cd9e2ca5783c 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
@@ -22,6 +22,7 @@ properties:
       - allwinner,sun8i-a23-codec
       - allwinner,sun8i-h3-codec
       - allwinner,sun8i-v3s-codec
+      - allwinner,sun20i-d1-codec
 
   reg:
     maxItems: 1
@@ -29,15 +30,9 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks:
-    items:
-      - description: Bus Clock
-      - description: Module Clock
+  clocks: true
 
-  clock-names:
-    items:
-      - const: apb
-      - const: codec
+  clock-names: true
 
   dmas:
     items:
@@ -103,6 +98,36 @@ required:
 
 allOf:
   - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: allwinner,sun20i-d1-codec
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: ADC Module Clock
+            - description: DAC Module Clock
+
+        clock-names:
+          items:
+            - const: apb
+            - const: adc
+            - const: dac
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: Module Clock
+
+        clock-names:
+          items:
+            - const: apb
+            - const: codec
+
   - if:
       properties:
         compatible:
@@ -111,6 +136,7 @@ allOf:
             - allwinner,sun8i-a23-codec
             - allwinner,sun8i-h3-codec
             - allwinner,sun8i-v3s-codec
+            - allwinner,sun20i-d1-codec
 
     then:
       if:
@@ -229,6 +255,28 @@ allOf:
               - Mic
               - Speaker
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun20i-d1-codec
+
+    then:
+      properties:
+        allwinner,audio-routing:
+          items:
+            enum:
+              - HP
+              - LINEIN
+              - MIC3
+              - MBIAS
+              - Headphone
+              - Headset Mic
+              - Line In
+              - Line Out
+              - Mic
+              - Speaker
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.2

