Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C875F953
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGXOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjGXOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:06:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C69E77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fdd7d09576so6553972e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207598; x=1690812398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIWP/QEBqIwvEO1ZvlsT+hGzgdJVbSKZwvToxKkmWfQ=;
        b=Xs/i2A8+we1PMrkIxfbFFTl2dr3fH5l6IUInS5NV8V5odwhqA/Hf6W6gyE5WnsoYeD
         nba8WJJpzbtZecFBkPyJWbscNTWQWG1TpB5Rc6ScPhzUn77o54kEbAt3+RwUAIlcG9y3
         adPKbbuzjn/Fki1lBU6NUkThB7AeHhJZRupUhAX64NXHwzp5XqMDy9jimx4S/MxVPNmX
         2YHxoZ32p7J0Oro1MEySZSL+M52KMegMqudf/OQ3OhSdRQOIAOMO1gZXGalYQMqQq6zF
         fX0LaJ+Sdu3m6kyHOnUTQUUDH52VWgfQ0c1Xhc2mcxUSnJflhPn9icZp67lg+rZUeZaY
         Cy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207598; x=1690812398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIWP/QEBqIwvEO1ZvlsT+hGzgdJVbSKZwvToxKkmWfQ=;
        b=kvc037ypVefTOAauVU4Jc0XPi1XmZMv00DY/6U8OnRRHVY398gZRRdsU9uszqBMov7
         fbrvezmVc5l/DJDzem2oUi4euQ7MsvDIGb+vsq2tT9wcyQrQv3lwY9PZdFuAH6wie79L
         MBvNr1TpdEpnhqnilZoBRnXKYiElXor/a5px9T7FP0E5Ti1XsN2RwcKCqMffWbG/wwJO
         sysf474eylewffVyb958Fua8EKdm0zQdvaofcM0CDIH2frqjb1+zEyBpzUAjT87qIBvq
         fjI2IFxZ5jx6zAsqYRmOH3w6bjuPtflkH6wDOqtcES3tV7Ho7QgrLvHS+95ywndx3NaD
         bIqw==
X-Gm-Message-State: ABy/qLbieR4VrQ+aQDLUM1b+NeSiaJJX9VyIzf1K2PmnWDKLY9QmcEyg
        O4YVEapUI3RXTuc2JJRVtyXwmA==
X-Google-Smtp-Source: APBJJlHXgZEFOg+fhmLn3/EQ10XQLxKTRfz7x5KLZ7cAncTprx2jJ6nDH3lgd1FO7W4r0ApEw+eWWw==
X-Received: by 2002:a05:6512:234a:b0:4fb:7da3:de4 with SMTP id p10-20020a056512234a00b004fb7da30de4mr6565353lfu.13.1690207598364;
        Mon, 24 Jul 2023 07:06:38 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:32 +0200
Subject: [PATCH v2 6/7] dt-bindings: interconnect: qcom: rpm: Clean up the
 file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-6-e33d5acbf3bd@linaro.org>
References: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=3463;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bGS+wZ4wxJ1M2DOl0T465GxrXnxbIet1hIWF+XoM3Dg=;
 b=O4FGsnB+Bb053iiFvieIbiWq8lRlj/T4OhYDK0G75aWvfDE+1A0TupIu3/YEsSdcvolFBC63h
 /AI/qUj42iACys4I1UJrZI8LirEtRd5Vne3cKn5yiTuGN8XRtOq38c9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recent cleanups and untanglements, remove abusive
direct references to RPM bus clocks, include the rpm-common YAML and
update Georgi's email.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 62 ++--------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 72856b1c4210..157efd47904d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -7,13 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm RPM Network-On-Chip Interconnect
 
 maintainers:
-  - Georgi Djakov <georgi.djakov@linaro.org>
+  - Georgi Djakov <djakov@kernel.org>
 
 description: |
   RPM interconnect providers support system bandwidth requirements through
   RPM processor. The provider is able to communicate with the RPM through
   the RPM shared memory device.
 
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
 properties:
   reg:
     maxItems: 1
@@ -27,57 +30,11 @@ properties:
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
 
-  '#interconnect-cells':
-    description: |
-      Value: <1> is one cell in an interconnect specifier for the
-      interconnect node id, <2> requires the interconnect node id and an
-      extra path tag.
-    enum: [ 1, 2 ]
-
-  clocks:
-    minItems: 2
-    maxItems: 7
-
-  clock-names:
-    minItems: 2
-    maxItems: 7
-
-  power-domains:
-    maxItems: 1
-
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
-  - clock-names
-  - clocks
-
-additionalProperties: false
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8916-bimc
-              - qcom,msm8916-pcnoc
-              - qcom,msm8916-snoc
-              - qcom,qcs404-bimc
-              - qcom,qcs404-pcnoc
-              - qcom,qcs404-snoc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
 
-        clocks:
-          items:
-            - description: Bus Clock
-            - description: Bus A Clock
+unevaluatedProperties: false
 
 examples:
   - |
@@ -87,25 +44,16 @@ examples:
               compatible = "qcom,msm8916-bimc";
               reg = <0x00400000 0x62000>;
               #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
       };
 
       pcnoc: interconnect@500000 {
               compatible = "qcom,msm8916-pcnoc";
               reg = <0x00500000 0x11000>;
               #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-                       <&rpmcc RPM_SMD_PCNOC_A_CLK>;
       };
 
       snoc: interconnect@580000 {
               compatible = "qcom,msm8916-snoc";
               reg = <0x00580000 0x14000>;
               #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
       };

-- 
2.41.0

