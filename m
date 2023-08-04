Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3D77096D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHDUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHDUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:09:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0410C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:09:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so35967451fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691179755; x=1691784555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zppFytEjzdHvnbASXFRnuQvztJWuz3oKHgr/oM9IyFM=;
        b=uaPvqbdJ+8Sz28g0QMV8w5OoEdrDJRlM3fseWXCAJt/7UPBzNZ5AYJValvIvpDBXU6
         w0fH3gQeRfMQ4mPsM5ClwRCSu2IRbxOdGQBCjzUV21RgK1i0uuD+Z7LEUgK4wUHhH3ZD
         dXxRwe3tvheb9HJVoDgbHria3Apg+AGB3U/4pvMM0dKR8CekSlhMgZ8ioptMlBb8hU3F
         uFXzyZqk7AYJUXLnjnjEJNek5J3h014cJLfrlvQd/BpiLpWXjV1vP093s8uP4tmPp6oG
         XqC/EtWGRotoDOd+H/zdtNx8uwcy65xKFs3D+Zd40UtP8iKQn6yZFt7UIzvIDhOEMLZz
         J45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179755; x=1691784555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zppFytEjzdHvnbASXFRnuQvztJWuz3oKHgr/oM9IyFM=;
        b=CIw7L6ddTVmWAcUWGpq7JBe+AyCuMx6okSZYed/rGoSfoUwcyRnEojtCpjOHKxckAz
         EAttktzUVn2TTVDsfyTNbo6v+LeS2BDfGJjdkn1IVLcR6jsrlUylvn3a2xugkB4bA2Bw
         5VXZlvH0EvMsv8cDzkxM/0RaqtJjJiYrbLHDkM3GLmoG9eRyBOtFXERud/AphCyLIlz/
         uLYRvsJ+7Meald6ZoLhi8tL63S5QsXYVHDxBjhVpOLsytkkp+mdsGLXO+uDexTELz/4+
         G/37VkHXCqfygKUr7ev7V80nNb1dl3Rf5nxRL+Ky7ayhQVEDyHgG5Rfp9PNERzTQnFHP
         V5dA==
X-Gm-Message-State: AOJu0YwSVP3BRPL/BEcWhozuzjE2CbqGO6AqYRRKTROnl545UhINiHiM
        77Rbpg0vXJIisGsoWdJICLFEbw==
X-Google-Smtp-Source: AGHT+IG8BSjBDzziHjw+PUzb2/Vt8+oru2DyEWxz4GlUAhErpY418rmZ1wlzR06q7pEU9Q0GsUIHnA==
X-Received: by 2002:a2e:9316:0:b0:2b9:bcac:7ba6 with SMTP id e22-20020a2e9316000000b002b9bcac7ba6mr2056339ljh.46.1691179754751;
        Fri, 04 Aug 2023 13:09:14 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e97c8000000b002b6fed37b18sm580048ljj.101.2023.08.04.13.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:09:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 04 Aug 2023 22:09:08 +0200
Subject: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org>
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691179750; l=4196;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qPZ+tkyKC+Whn4SENKO8Du3EyX1XBNWI1sx5+8QX9+M=;
 b=XrOc4Lb7+7O/RxyzONJjYO8r9ksbbpY08duzDjb89Qfu5iuQUFWH4iDxA3kgtp5gODXME0wjd
 V2An/YoZJrEC/bxGjyWXa6UjA6yY2AgD/tHWXB1LrczKbQcHyJ1Cjyu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these SoCs implement an IRIS2 block, with SC8280XP being able
to clock it a bit higher.

Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/media/qcom,sm8350-venus.yaml          | 149 +++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml
new file mode 100644
index 000000000000..8a31bce27c18
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8350-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 Venus video encode and decode accelerators
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Venus Iris2 IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-venus
+      - qcom,sm8350-venus
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: core
+
+  power-domains:
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mx
+
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+      - const: video-llcc
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  iommus:
+    maxItems: 1
+
+  video-decoder:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-decoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  video-encoder:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-encoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - power-domain-names
+  - iommus
+  - video-decoder
+  - video-encoder
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
+    #include <dt-bindings/clock/qcom,sm8350-videocc.h>
+    #include <dt-bindings/interconnect/qcom,sm8350.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@aa00000 {
+        compatible = "qcom,sm8350-venus";
+        reg = <0x0aa00000 0x100000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+                 <&videocc VIDEO_CC_MVS0C_CLK>,
+                 <&videocc VIDEO_CC_MVS0_CLK>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core";
+
+        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+        reset-names = "core";
+
+        power-domains = <&videocc MVS0C_GDSC>,
+                        <&videocc MVS0_GDSC>,
+                        <&rpmhpd SM8350_MX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mx";
+
+        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>,
+                        <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>,
+                        <&mmss_noc MASTER_VIDEO_P0 0 &gem_noc SLAVE_LLCC 0>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem",
+                             "video-llcc";
+
+        operating-points-v2 = <&venus_opp_table>;
+        iommus = <&apps_smmu 0x2100 0x400>;
+        memory-region = <&pil_video_mem>;
+
+        status = "disabled";
+
+        video-decoder {
+            compatible = "venus-decoder";
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
+        };
+    };

-- 
2.41.0

