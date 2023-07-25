Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395577611E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGYK5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGYK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:56:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF24215
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:54:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52227884855so3835440a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690282467; x=1690887267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XvBEhiljLAJfGUeTgW+OPWzjRV1YWWycztsm2LeLB0=;
        b=b9hrnVX60q2msck+zlotnWfv+WZ6UUe6Uz7mE/Vb/cIRkkFqtz4GMg/RjfBwHccixd
         sP8lVu84VCqhiPUkkcxkpghJLxFYLbXTzdascqZgmbjJoIlkKUGWrBXZuqRT5JWzOX7E
         p2GkntswKBF8g/zBsgJqoYy9UD4YgCkzzrQQ+BVwYQSlSI4chmPWv0DK1qNjQF7/NoFG
         fO7OidQS8XYJ52/iGzLEb2/5/Wx0EEQb+puiE66GIAJeeVCfCia0wBOzkxZJdbi1Ei/D
         42KBWqzoxYtCvS9eKAvj8fTaCpRgx6mUvEMSHqDpg99Imf/spk68/9eAbWyNApv1r3fF
         bWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282467; x=1690887267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XvBEhiljLAJfGUeTgW+OPWzjRV1YWWycztsm2LeLB0=;
        b=UWelMTf+sH6SMvNelR/Me1/ubATyVDwq4P4AnTuvRduF+wm7cJvwS81hFj/P8wQVi+
         PBm1DXftrIOYUGnihgN6MNKUEYbM++syR6kgWMn+GlWj3PPJ17dyq6fxe/ISuVSkAXYU
         PKVMMl0Z7wjjmrkydYgJXcj8myAa1OS8cmQ+8+f2EIQFMVAEFUyv60d6YuPOZxpzPjIG
         yyaTIdZg8s15Sr7qbRUyIhR2wnuK+jcpZmeGEn5MwqmODO1FfuQfbHGc8uqSCLDh2bs6
         rkkLHgA4kZixb1CWM7UVP1/Ql9kKG1ksFUxBtbnHvMtTU7wca4zaa0iA1qEd4CO1CTJp
         Xwkw==
X-Gm-Message-State: ABy/qLZYZo277Lr2OwgjuEW1GRRKsFsWaWgiTKssyySyEKunuu6QS5YP
        Wr6l6QlEwyrtRWNMqjHCgzIM1Q==
X-Google-Smtp-Source: APBJJlEBd79V8FzekDC8zmB2dcU2i30PcbnQL6AH3k5NC4ZMeRGeosc90mmA7pJqtzUE02K6QQ4Mpg==
X-Received: by 2002:a17:906:289:b0:99b:237e:6ee with SMTP id 9-20020a170906028900b0099b237e06eemr12860028ejf.30.1690282467322;
        Tue, 25 Jul 2023 03:54:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id xo22-20020a170907bb9600b0098860721959sm7980597ejc.198.2023.07.25.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:54:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robin Gong <yibin.gong@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        - <patches@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 1/2] regulator: dt-bindings: add missing unevaluatedProperties for each regulator
Date:   Tue, 25 Jul 2023 12:54:20 +0200
Message-Id: <20230725105421.99160-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each regulator node, which references common regulator.yaml schema,
should disallow additional or unevaluated properties.  Otherwise
mistakes in properties will go unnoticed.

Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Closes: https://git.codelinaro.org/linaro/qcomlt/kernel/-/commit/1c8aeef8a6e84520b77f0c270d99c8bf692c5933
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml   | 2 ++
 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml  | 2 ++
 Documentation/devicetree/bindings/regulator/pfuze100.yaml     | 4 ++++
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 2 ++
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 1 +
 .../bindings/regulator/richtek,rt4831-regulator.yaml          | 1 +
 .../bindings/regulator/richtek,rtmv20-regulator.yaml          | 1 +
 .../bindings/regulator/richtek,rtq6752-regulator.yaml         | 1 +
 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 2 +-
 Documentation/devicetree/bindings/regulator/ti,tps65090.yaml  | 1 +
 Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml  | 1 +
 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml  | 2 ++
 12 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
index 2e720d152890..0221397eb51e 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -29,10 +29,12 @@ properties:
     patternProperties:
       "^buck[1-4]$":
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         type: object
 
       "^ldo[1-4]$":
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         type: object
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
index f3fcfc8be72f..38475a568451 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -39,11 +39,13 @@ properties:
       ldortc:
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
 
     patternProperties:
       "^ldo[1-4]$":
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
 
       "^buck[1-4]$":
         type: object
diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.yaml b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
index e384e4953f0a..0eda44752cdd 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.yaml
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
@@ -68,18 +68,22 @@ properties:
       "^sw([1-4]|[1-4][a-c]|[1-4][a-c][a-c])$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^vgen[1-6]$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^vldo[1-4]$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^(vsnvs|vref|vrefddr|swbst|coin|v33|vccsd)$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 72b533c3761a..e758093365bc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -111,6 +111,7 @@ properties:
   bob:
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description: BOB regulator node.
     dependencies:
       regulator-allow-set-load: [ regulator-allowed-modes ]
@@ -119,6 +120,7 @@ patternProperties:
   "^(smps|ldo|lvs|bob)[0-9]+$":
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description: smps/ldo regulator nodes(s).
     dependencies:
       regulator-allow-set-load: [ regulator-allowed-modes ]
diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index a8ca8e0b27f8..9ea8ac0786ac 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -110,6 +110,7 @@ patternProperties:
   "^((s|l|lvs|5vs)[0-9]*)|(boost-bypass)|(bob)$":
     description: List of regulators and its properties
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
index d9c23333e157..cd06e957b9db 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
@@ -29,6 +29,7 @@ patternProperties:
   "^DSV(LCM|P|N)$":
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description:
       Properties for single Display Bias Voltage regulator.
 
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
index 446ec5127d1f..fec3d396ca50 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -121,6 +121,7 @@ properties:
     description: load switch current regulator description.
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
index e6e5a9a7d940..ef62c618de67 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
@@ -35,6 +35,7 @@ properties:
       "^(p|n)avdd$":
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         description: |
           regulator description for pavdd and navdd.
 
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index 7d53cfa2c288..c9586d277f41 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -25,8 +25,8 @@ properties:
 patternProperties:
   "^(reg11|reg18|usb33)$":
     type: object
-
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
index 0ae95ac6de57..8ae8de7fe3de 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65090.yaml
@@ -67,6 +67,7 @@ properties:
     patternProperties:
       "^dcdc[1-3]|fet[1-7]|ldo[1-2]$":
         $ref: regulator.yaml
+        unevaluatedProperties: false
         properties:
           ti,enable-ext-control:
             $ref: /schemas/types.yaml#/definitions/flag
diff --git a/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
index c5ea7012c653..ef093344c7bc 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
@@ -64,6 +64,7 @@ properties:
     patternProperties:
       "^sys|sm[0-2]|ldo[0-9]|ldo_rtc$":
         $ref: regulator.yaml
+        unevaluatedProperties: false
 
 allOf:
   - $ref: /schemas/gpio/gpio.yaml
diff --git a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
index 011819c10988..11e378648b3f 100644
--- a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
@@ -29,11 +29,13 @@ properties:
       Initial data for the LDO1 regulator.
     $ref: regulator.yaml#
     type: object
+    unevaluatedProperties: false
 
   micvdd:
     description:
       Initial data for the MICVDD regulator.
     $ref: regulator.yaml#
     type: object
+    unevaluatedProperties: false
 
 additionalProperties: true
-- 
2.34.1

