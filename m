Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC527E1C44
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKFIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjKFIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:32:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0D10B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:32:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f613275so31316065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259557; x=1699864357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L5PY42/en56HOSEaNDoQ8YhgG6LpxTKQYjZcAI6kOg=;
        b=gjs+NUoDIeEFTaOqmbT/bdaJ6rF/m6uSgaCweGqgbVLihp1Y+T45IDanTg5Hh4n3FY
         6cCDcWGxy3qlDhb8Z0pCNF3lxcKL6bPzlDPuyuy5iPkQpnk4SZ3jodiofoeJrw3GLjcg
         G20/YWYyvGw3ThYd8jzSRyX5C9zo3hf61SCcbLfr84HC/BavYFRDxz98CdNflnU8sT1T
         ixDakASTUy35jOsaXiJ8X+EIIWsdLQUFcsdTDMEGIg4GP+pJawOMmsLLPwOB5N12vSEB
         /UUhGAvSTLhPzQzcjU3WLTse/TifW2MnNf6sMooRS69rL1d0HPx9NbBsMtwe4Orgimrl
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259557; x=1699864357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4L5PY42/en56HOSEaNDoQ8YhgG6LpxTKQYjZcAI6kOg=;
        b=YHog61Camr7jl2L54JhEZoFahrinRspQvxsxO3i4Ys5QwbxprslCL9EQ4uWsdg0cvn
         k1YLnufgvAMgP2LUaW+yfwkdLa9ClVZgJR0QhEbYlUEpgF3F+EJaLoGUkS+BqVuGjWwy
         ZecAqwB0OFUqQoZEzRMRM7y5ZCOzC2V4X53d4aWQR1kIvMAsSOJ41tNch/jVvxuxFMvM
         1Wf5OM2QySqbGOO2FCn2te/82YyC4drk8FBQ3VKrXjgbrOKKu6ohww1eBYZ3RuXHgHzH
         TGbbxdIj7cgzgffpdPQ51Dtepolamy5FiYsANkrjq8pUq/W8a/dliZJ/6Rqz9S/jLjRF
         9PmA==
X-Gm-Message-State: AOJu0YyCfrjStmosuZMAUNnp9L1OMRoBZLjZAnxMBlv6X/wNgRHAK8MX
        I0esPFo3lroPp3xQ6Q49tTF5+A==
X-Google-Smtp-Source: AGHT+IGrbznX7t5jIfeTuKS8Bx0RWqhMi8RiaBcvyJ9Gld5apm5T+LJAgTz9VSn4QVreAvmlq+tDnA==
X-Received: by 2002:a05:600c:4ed2:b0:408:2f50:f228 with SMTP id g18-20020a05600c4ed200b004082f50f228mr26280209wmq.41.1699259557356;
        Mon, 06 Nov 2023 00:32:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b004063ea92492sm11405241wmi.22.2023.11.06.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:32:36 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:32:30 +0100
Subject: [PATCH v3 1/3] dt-bindings: pinctrl: document the SM8650 Top Level
 Mode Multiplexer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-tlmm-v3-1-0e179c368933@linaro.org>
References: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5756;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uMSkogyLUjiT1f2/kG6Kz73HWvW5olsKB07/R8uDXW8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKSioKOTdxrmnuk6/5y4ZTQYWg8g2m25GaudNBI3
 EDFlLBWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUikogAKCRB33NvayMhJ0SmVD/
 0ReA89L7VG3fEbYrCPY+FdRuZM0/zKDPiO8s3p5L10rc4GLHkeupH5WvM3EpUVRzM0q/uCE4+d/0rr
 sqjFv1zy2Nex8K/RhmtJd6rkIan6cF/kGijSYuDjFWUnxXBaOxutiKPviLu4VDZoYG5rISb0WtFs9K
 AgZDADjiaMT9wKqtD/1KIuGxZ2zbl4vyg5RdD1LEWleCat74HULDeOyicEq8otAsy1z6RRV6csltCH
 g+HTcnzbyk3gc4B1zGdfLEzR7HF29fzc+CiVppcNuyEABxzZDs+7CqBOzBDOhpyp7r6GP7gZGY4ZPL
 DmTG1xOREduVBtVvzPfEC9yn2C3E4doMge3AG2F/HVHiwf8Hk4XdHJy3wfw0l2aQaj8Rha53SHefpu
 cY4S23jmdaVbtrN2nOnlriAtRb7PBrIbMSXTG7ynJnsMJJ64GhaLc7bGscHpVY5J/zXBLUXj1aECzF
 ijB+Tw6a+94+hdwwRZvvDttbRsViS0OJWR1q+NHols/UINlX4dsa07T3kPBSIZ8MyEToS37pRU2DR2
 LEq+8GmKSzg0dIAAWEl4v37iEckSE/EvA5Zv4tfCBwhk2Rgq8Ahab7WKgz1tX1jiyelrRkkYPtMC3b
 jDNxaXOycpkA80s7lLsgX3OQ+X/cIXoIkEOkL1zZTazZhmtcqdBUcCE5Hqgw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Top Level Mode Multiplexer on the SM8650 Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
new file mode 100644
index 000000000000..30432be8fb07
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8650-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM8650 TLMM block
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8650 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8650-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 105
+
+  gpio-line-names:
+    maxItems: 210
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8650-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8650-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8650-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ gpio, aoss_cti, atest_char, atest_usb, audio_ext_mclk0,
+                audio_ext_mclk1, audio_ref_clk, cam_aon_mclk2, cam_aon_mclk4,
+                cam_mclk, cci_async_in, cci_i2c_scl, cci_i2c_sda, cci_timer,
+                cmu_rng, coex_uart1_rx, coex_uart1_tx, coex_uart2_rx,
+                coex_uart2_tx, cri_trng, dbg_out_clk, ddr_bist_complete,
+                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, do_not, dp_hot, gcc_gp1,
+                gcc_gp2, gcc_gp3, gnss_adc0, gnss_adc1, i2chub0_se0,
+                i2chub0_se1, i2chub0_se2, i2chub0_se3, i2chub0_se4,
+                i2chub0_se5, i2chub0_se6, i2chub0_se7, i2chub0_se8,
+                i2chub0_se9, i2s0_data0, i2s0_data1, i2s0_sck, i2s0_ws,
+                i2s1_data0, i2s1_data1, i2s1_sck, i2s1_ws, ibi_i3c,
+                jitter_bist, mdp_vsync, mdp_vsync0_out, mdp_vsync1_out,
+                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync_e, nav_gpio0,
+                nav_gpio1, nav_gpio2, nav_gpio3, pcie0_clk_req_n,
+                pcie1_clk_req_n, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio, qlink_big_enable, qlink_big_request,
+                qlink_little_enable, qlink_little_request, qlink_wmss,
+                qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs, qup1_se0,
+                qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5, qup1_se6,
+                qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4,
+                qup2_se5, qup2_se6, qup2_se7, sd_write_protect, sdc40, sdc41,
+                sdc42, sdc43, sdc4_clk, sdc4_cmd, tb_trig_sdc2, tb_trig_sdc4,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng0, tmess_prng1, tmess_prng2,
+                tmess_prng3, tsense_pwm1, tsense_pwm2, tsense_pwm3, uim0_clk,
+                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
+                uim1_present, uim1_reset, usb1_hs, usb_phy, vfr_0, vfr_1,
+                vsense_trigger_mirnat ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,sm8650-tlmm";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 211>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio60";
+                function = "qup1_se7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio61";
+                function = "qup1_se7";
+                bias-disable;
+            };
+        };
+    };
+...

-- 
2.34.1

