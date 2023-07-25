Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37040760DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjGYJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjGYJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB61FEF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so51793775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690275635; x=1690880435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7K8nxIZpShzeSCTf6xMMLnjngvYy+BOizxURXufMvo=;
        b=BMUow0YPkcyGhHa7QT07tlBD87quCMneQDdzKMvACAbcnhZa71IwmXm++ze/fr2CU6
         0IltiRkiEgZ5sgXBXVyLg80vO1RDzxwvPMbCmmxs/u8pm6FerBuHg1l46uG2nKD4ntrR
         Rlq7UXlqvn4J/psbnCqx37B8/uQ5ij44xXLVxizWZXiDOAJjrwvDlMKtoOemB645QWGi
         ERdVN5dSRBVJIWfPiOGxW2WH2chqlKlYcGyay5wRF1yTiS/w/zzGcwKhs7ed0OA9ZeLi
         GiFpRpXujlf6Q6ckF+7CU+pti8TppkgAZ7kw4gCBsSYL7hGxVQ0x7WiAAE8eDGMpRqbI
         Jc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275635; x=1690880435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7K8nxIZpShzeSCTf6xMMLnjngvYy+BOizxURXufMvo=;
        b=gLa3St+QZ0e8dDlu8Y9CVOwlDNMLq8L/YgMrldoYUFLexF8G5X9TxVUJOQ7JQXBs2b
         2tzdMX0DCpWOkINgVKRsPhdO6OwdCe0dPfpjyWjAWUdIUqAk+sPRWTCIjOFtuDg8zZxN
         2HDmP5QJfVN/EtSnXt+9Lle0vv3kpqfX2Jpsx24jCOOiv0ElGi5eySC3rqbkmOauZkRQ
         tK7Sw1vkqOobpYoTSrQ31+5qLuNRhbhox2iotvcXvMmbDWGf41Gtg25JqQK70wq86fVR
         EnBtjRGJfMYJT6idc4B9CXBx3jCTEqO54nOYVfPqHJGEjrcjTuXvoZbmySmZArIXcIil
         6Jcg==
X-Gm-Message-State: ABy/qLb3FlgyUa5iI8zcBmyHfDbKMQNIpQDEZCADXQ/Rxg6QOqn9jipC
        ZgOQNYXzyzDCiFtfZKZQXgB1yZ3phCGdAd0wE+yY2A==
X-Google-Smtp-Source: APBJJlHTKXNKGKX8QAlbJUxnc46MXgYrlKJ/UA5PdejRBoxCd2mq4Ffib2iDbdmvYeFDqFPITPKTkA==
X-Received: by 2002:a05:600c:ac6:b0:3fc:5606:c243 with SMTP id c6-20020a05600c0ac600b003fc5606c243mr10117259wmr.13.1690275635331;
        Tue, 25 Jul 2023 02:00:35 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003fc015ae1e1sm12648420wmc.3.2023.07.25.02.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:00:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 25 Jul 2023 11:00:28 +0200
Subject: [PATCH v4 1/3] dt-bindings: remoteproc: qcom,sm6375-pas: Document
 remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-topic-6375_rproc-v4-1-d55e8a6d0f5f@linaro.org>
References: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
In-Reply-To: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690275632; l=4377;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Kz6Ktb07wAdLnp1vHpLFn8SJ0/Kt84BenGBICrSQ2Bk=;
 b=B9H7CXHxbMtl85LCvSqaRuOI7eXZto3hApKxU2pjHXfoGSyK+PRUjtHRdGFiHByljh0r49zcC
 OXh2sO2ola4A9Wz14++KnJ6dthqFPBmH9rGug/NhA0hF9HSQ0/m0oTd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6375 hosts an ADSP, CDSP and modem as remote processors. Create
related bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/remoteproc/qcom,sm6375-pas.yaml       | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
new file mode 100644
index 000000000000..60ee3fc7ab5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm6375-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6375 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM6375 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6375-adsp-pas
+      - qcom,sm6375-cdsp-pas
+      - qcom,sm6375-mpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  smd-edge: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-adsp-pas
+            - qcom,sm6375-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+    else:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-cdsp-pas
+            - qcom,sm6375-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+        power-domain-names:
+          items:
+            - const: cx
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc_adsp: remoteproc@a400000 {
+        compatible = "qcom,sm6375-adsp-pas";
+        reg = <0x0a400000 0x100>;
+
+        interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+        clock-names = "xo";
+
+        power-domains = <&rpmpd SM6375_VDD_LPI_CX>,
+                        <&rpmpd SM6375_VDD_LPI_MX>;
+        power-domain-names = "lcx", "lmx";
+
+        memory-region = <&pil_adsp_mem>;
+
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };

-- 
2.41.0

