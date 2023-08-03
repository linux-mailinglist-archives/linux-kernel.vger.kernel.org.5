Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A076F3A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjHCTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjHCTr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:47:57 -0400
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B881FF3;
        Thu,  3 Aug 2023 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=0RACq9NMCN+9wopJJDzqad53or83+Seb+JcQTqyteAU=;
        t=1691092074;x=1691182074; 
        b=kq33FRjxmAL2iJYuNMNlLty4EOoJEXf/apguwJtY5P4V88sU145eGcAAnlsKhjJIvVMi5DHQitEZ8h/3qNjzImvUTiSmF/6a61k+VK+r/7okQ/X0kQ1vI4lt1u9VOjCvcKuPvnCwTpnywuu7B7SyXEsgYFo6/OpGH/8nrVbl8mI=;
Received: from [10.12.4.30] (port=45584 helo=smtp55.i.mail.ru)
        by fallback16.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1qReIZ-004I7p-JY; Thu, 03 Aug 2023 22:47:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=0RACq9NMCN+9wopJJDzqad53or83+Seb+JcQTqyteAU=; t=1691092071; x=1691182071; 
        b=ji1B/RNQYzTC50CHF4HSAoc7EZM3MR/yxe680kYvBmAedakD9PCBJUj0Tk4BFIB4DeBSKxowWwk
        RG74SEDFxnfgQoY/OBr22WkgpxdxYTEnc5/GSedH17JKiJm51penOMWnSXFL0dBPy6JnkUHGs/tTp
        ks1fYtPwY3fNg+rsiY4=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qReIJ-000Y8b-1W; Thu, 03 Aug 2023 22:47:36 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        neil.armstrong@linaro.org, rfoss@kernel.org, andersson@kernel.org,
        quic_khsieh@quicinc.com, quic_vpolimer@quicinc.com,
        quic_rmccann@quicinc.com, quic_jesszhan@quicinc.com,
        liushixin2@huawei.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, danila@jiaxyga.com,
        davidwronek@gmail.com
Subject: [PATCH 1/2] dt-bindings: display/msm: document DPU on SM7150
Date:   Thu,  3 Aug 2023 22:47:23 +0300
Message-ID: <20230803194724.154591-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803194724.154591-1-danila@jiaxyga.com>
References: <20230803194724.154591-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD969E04B5EED670DC864E28ABE09E133B4A5846C191BD37C58182A05F5380850403434C4E83CAFBCFCC0371154B7EC49ABC37BD9D95F0813D09C35240DA3207908
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D43AAFBA4462143CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F907CB39E8CA2E228638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C4DC3A94E990531FE5F480F2563EA2F8117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520CCD848CCB6FE560CC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA99100238FE36DC7A2D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CF7CD7A0D5AA5F256136E347CC761E07C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407978DA827A17800CE7649B83402744A6742DBA43225CD8A89F1B3F1E879BC1E2F16D8C47C27EEC5E9FB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A562383D38FA60F744C6B9CF6467323EFFC21289126A9F8A8DF87CCE6106E1FC07E67D4AC08A07B9B0251EFD5447B32ED69C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFFFC51D7AB0E131C85429A1869283E2444C124F3CF48BEE8179019061DD297C3EA7825560E8A5912C8553022043D0BC9A7D1DDF772BF0A8A51EEF30F80AA15FCFD8EBEDE01CE1B1DA4C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojcir52QaMQ827VfcgMyi3Mg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B7B6FBA8BC574666F8036A48FDA55E384331A046F79FC67F643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4C2CC63398298511D1E4750FD930E01DF28F9632845AEBDC5049FFFDB7839CE9E588CC25E272B312A4B8237A43458167B78B7756247A8256846EA42ECDDC8E1D1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd3RriuhA+6EboYtJCDiDjPg==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DPU hardware found on the Qualcomm SM7150 platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/display/msm/qcom,sm7150-dpu.yaml | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
new file mode 100644
index 000000000000..0d86997ae09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm7150-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM7150 Display DPU
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+  - Danila Tikhonov <danila@jiaxyga.com>
+
+$ref: /schemas/display/msm/dpu-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm7150-dpu
+
+  reg:
+    items:
+      - description: Address offset and size for mdp register set
+      - description: Address offset and size for vbif register set
+
+  reg-names:
+    items:
+      - const: mdp
+      - const: vbif
+
+  clocks:
+    items:
+      - description: Display hf axi clock
+      - description: Display ahb clock
+      - description: Display rotator clock
+      - description: Display lut clock
+      - description: Display core clock
+      - description: Display vsync clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: iface
+      - const: rot
+      - const: lut
+      - const: core
+      - const: vsync
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm7150-dispcc.h>
+    #include <dt-bindings/clock/qcom,sm7150-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-controller@ae01000 {
+        compatible = "qcom,sm7150-dpu";
+        reg = <0x0ae01000 0x8f000>,
+              <0x0aeb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus", "iface", "rot", "lut", "core",
+                      "vsync";
+
+        assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+                          <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                          <&dispcc DISP_CC_MDSS_AHB_CLK>;
+        assigned-clock-rates = <19200000>,
+                               <19200000>,
+                               <19200000>;
+
+        operating-points-v2 = <&mdp_opp_table>;
+        power-domains = <&rpmhpd SM7150_CX>;
+
+        interrupt-parent = <&mdss>;
+        interrupts = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                endpoint {
+                    remote-endpoint = <&dsi0_in>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                endpoint {
+                    remote-endpoint = <&dsi1_in>;
+                };
+
+            port@2 {
+                reg = <2>;
+                endpoint {
+                    remote-endpoint = <&dp_in>;
+                };
+            };
+        };
+    };
+...
-- 
2.41.0

