Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B06754966
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGOOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:37:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DEC2D51
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so4869651e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689431841; x=1692023841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1PfYXnPFUdyoINMSQb8t2+X3rjDb+lX4Py5/7kpDz8=;
        b=zomzmBKeflRbMfpSQoKGf0VGvLR1wjVea2S70CLAJdG1UsSokSpNpzKqAXumCK+7pJ
         SM6xMbU8ZRxh5I68dmxSwQgTwtq+PwelJnfiYD/69bqvkAORlB3GuSvbl+CK/iCq8tL7
         Qex+yaKO2XslQFcG41sfGARcgjQ+C1jfxQBDZQSpJ9PbZ3eRs2jPlbl8/jEg7lmNcJkv
         nixOg8MPLWbtfxpIeNgbb+qPP6cGy9reY9CS5hP/wfDJ1W639q0JjUuX4BjKnryWFrU/
         qnRfgb8zWc1ZvpTWpQkGhkpKlqbizEQ0unEuP+oHl4WfWWXfbKcAzSheyx/oSnHxOmDl
         Uprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689431841; x=1692023841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1PfYXnPFUdyoINMSQb8t2+X3rjDb+lX4Py5/7kpDz8=;
        b=WYp5wJNBmmnn+adKFI1flZFwycPkRblv5RzKV4YAOAxzmcbViUsD9Esbi3GxvMNHQ8
         hAEPx36oOa+e94XwXUu5AY7ug7EhMr0aYggeW+mnMnSuWCH2KPqZusGymTCGK1KprfaV
         MdhUONvhB12Q7H3GfNRsDzD0bn8ug8agHfFvDhot8bmnsy5lW3baX0v+sNYxrEy+TJj3
         MvOjS9lpDACBtY8Ed0EPFtTsGPRNLa0lQ6fjaD5n7dxopbd1wxckRkgPVAl2lj3hpBtX
         p/wrITOMTuJkpaVTNzxwKbNKJPsiDeWGiVBHHvWpCaF8oEcyo2tnQAQbgbY34mKIDPu+
         6KGg==
X-Gm-Message-State: ABy/qLZYBLtgt4GXJkShevliUyyDJZvbxM4yeuZYFlMWEOJjVAQYdm6L
        51NnrvgMRpfNFe4iqYfBSIyGrQ==
X-Google-Smtp-Source: APBJJlENwnPMJhk/Hv3ShtT5c0MjZkoCfipiqxhk1bwJOoWs8NLXDJr9qLT0rQDlEzPLxKnn/MMNHg==
X-Received: by 2002:a05:6512:ad1:b0:4fd:b7fb:c9e9 with SMTP id n17-20020a0565120ad100b004fdb7fbc9e9mr87165lfu.41.1689431841621;
        Sat, 15 Jul 2023 07:37:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b004f858249932sm1927732lft.90.2023.07.15.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 07:37:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 15 Jul 2023 16:37:11 +0200
Subject: [PATCH v3 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org>
References: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689431838; l=2979;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hEZfhI1EGIlmfejCXVFxQDw5yfJpSTVeevTgH6zVb+o=;
 b=smtqGVT2hbELn8tjrn1hDztpZdaIz3pc7WiPLxXkZgqgZ5E9//CxZiIvoOAt5Ik9sz7PUku8w
 Gb2YXdtkfkgDzht6OAufS03cz0dcX1HdSTjdrqCnoGUfV2iu4l3+y5b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
use 'reg' to point to the MPM's slice of Message RAM without cutting into
an already-defined RPM MSG RAM node used for GLINK and SMEM.

Document passing the register space as a slice of SRAM through the
qcom,rpm-msg-ram property. This also makes 'reg' deprecated.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interrupt-controller/qcom,mpm.yaml    | 44 +++++++++++++---------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
index 509d20c091af..b8bd408748e4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -29,6 +29,12 @@ properties:
     maxItems: 1
     description:
       Specifies the base address and size of vMPM registers in RPM MSG RAM.
+    deprecated: true
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the APSS MPM slice of the RPM Message RAM
 
   interrupts:
     maxItems: 1
@@ -64,33 +70,37 @@ properties:
 
 required:
   - compatible
-  - reg
   - interrupts
   - mboxes
   - interrupt-controller
   - '#interrupt-cells'
   - qcom,mpm-pin-count
   - qcom,mpm-pin-map
+  - qcom,rpm-msg-ram
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    mpm: interrupt-controller@45f01b8 {
-        compatible = "qcom,mpm";
-        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-        reg = <0x45f01b8 0x1000>;
-        mboxes = <&apcs_glb 1>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
-        interrupt-parent = <&intc>;
-        qcom,mpm-pin-count = <96>;
-        qcom,mpm-pin-map = <2 275>,
-                           <5 296>,
-                           <12 422>,
-                           <24 79>,
-                           <86 183>,
-                           <90 260>,
-                           <91 260>;
+
+    remoteproc-rpm {
+      compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
+
+        mpm: interrupt-controller {
+            compatible = "qcom,mpm";
+            qcom,rpm-msg-ram = <&apss_mpm>;
+            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&apcs_glb 1>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&intc>;
+            qcom,mpm-pin-count = <96>;
+            qcom,mpm-pin-map = <2 275>,
+                               <5 296>,
+                               <12 422>,
+                               <24 79>,
+                               <86 183>,
+                               <91 260>;
+        };
     };

-- 
2.41.0

