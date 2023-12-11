Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EEA80DE97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjLKWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjLKWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:46:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB826D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so4775860a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702334778; x=1702939578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tt3fy1HqITnzGD9gVyahrYriMR8d/kwCV+7V+BmccAA=;
        b=drMbqAa+Tc+5Pbv215RXIZEosZCVkpED0zvSw0AEiyWXTJbfOn6DJ26fmCEYXQbfOq
         mDuiPJHzOaMAgCkLR5gH/BjnyuhlBw4Kmu+9g8N/vsXMPmnXCA8trN98QaXdIBmJYHjA
         OW/YuaAjjO71VUgA5utxDUS2bQgkqAlf6Eo883mz/3BF32sTNW8/Jud9F6ZanAZvkldQ
         X/V4SH7Wy2t9JM6Tm2NoPW+8nqfe+Ov1s3Btpn6dWnbqelsoHr4xqRJocW5jeRplPYsw
         TVbAu5BeTN5JmuPR55tLc3SuGpYFst3bISkDoHYxvqpAJw7sUxsOP19+1ce0y+iO+DoY
         I2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334778; x=1702939578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt3fy1HqITnzGD9gVyahrYriMR8d/kwCV+7V+BmccAA=;
        b=kDOYkTCqt4rXmZQZZIUr6jHe0TV267SaryKNbi34s6wYTo8rtXqFCw+zAMKrrL2tYc
         hw6S2xFT+4gCHqt6lBMr/UwrONu603sILqIiDERpTZufVmBztZtwfqWEgU8zocd9rOZF
         rFH+9305jwPU7tlPKhdIoyZn6d3XAFo0X4xzQ9uTe+3Ym5R7f7l3LJleE9Hmm4hztCpG
         y4qX1y73TkMi/BR4qioaT7wV30mwGwUJYU70MvQvquNLYbGorq7Tr6c7SFYHG/gi0gfx
         GJQttAzdcPs0cuMO3xJwW2RrKJhw4O4Yj+ew/PeAZLngmysqbVp/aYN1y/SEZ1elLjgD
         NC5Q==
X-Gm-Message-State: AOJu0Yzv0Pcw3Ff5sfa+vONOfe9sqRmGsyvfO1anN/5eDnGbHY6Editn
        tTRb9+tEwm9fqTAackg1Ej8VhQ==
X-Google-Smtp-Source: AGHT+IEKarDHJsw6FsRzP2Gu2UInrsDDgB+2ZNNWZf+M4hA9YJD+7DCdGg3pLVkJmFAEBZNaNNVJLA==
X-Received: by 2002:a50:c313:0:b0:54a:921b:297e with SMTP id a19-20020a50c313000000b0054a921b297emr3555296edb.19.1702334778528;
        Mon, 11 Dec 2023 14:46:18 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm4091789edb.59.2023.12.11.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:46:18 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 12 Dec 2023 00:45:45 +0200
Subject: [PATCH 05/10] dt-bindings: clock: qcom: Document the X1E80100
 Camera Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-x1e80100-clock-controllers-v1-5-0de1af44dcb3@linaro.org>
References: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
In-Reply-To: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6256; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=uKLMhPfFG5xcRYPL8/Ksz+gk45C5FOtDFMcgXE1eLj0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBld5EqB/FfnLcQegcB1D6QfnyJrOOouuv2oQhKy
 1u2YorAXZ+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXeRKgAKCRAbX0TJAJUV
 VqzwEACWopipKNnJs7XD9AVMhR0UK4B55G/nQBxxwus/DWYPNwV11Jf5sr7WE8DXQg0hSwQekpp
 WiPbtolXYl8RRNOfWLRj8+Q6hWpmkWZZeF0EAK7oFcFC6ttZ5wB3onNqUohNROP8luO0Tvn0ewP
 tgPfE0/VHjmfVyk9AZkBwVkyKIuQzNomP0RcfLcEK7XXNL/K9HuZoAPNlpRtIpKtldUZ1GcMyU+
 gVgLUGo1Zghb/VyLSZGufv1PH9/fhADoul1UghFasHgqwWw1apNC2jkoFHL4tbEI2nWCIDo2CEr
 ed5HGMpWKeC98GDAUhqYACa+JibXIjnu+sIg6S4LWl93DkuQb3CvjAE7E+hKsfEKAHi4o3DQO9J
 84hpliAJGnXvwAH5eVR8WMS0RxFsy/92+vyXJsL9IrAFugesDUKbXrDDFAQWfL9cCwYsoPNE71w
 UquFObOF4r8B2RR2ECkVNJu3d/BCCPzIkTlJG8iGudLyICV2KyNZOMQ2dDIqctKQ+WMST1B3t/K
 MSgs7vKAm18kvNX7uxL5IZqd5alfPU1EyX/6mdZLEvgViAcsvaCtTAxOFj9Trx9HwWLo20IL5Jv
 NO+M+CoUj4vAESv8liE4fGtDGiYYTbxt3ST6ixca6m/LlN7zhTfLaCcdvkn0Ff6cDGH7EMjyhgf
 MlhTTkUoatcc7Kg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Camera Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8450-camcc.yaml          |   2 +
 include/dt-bindings/clock/qcom,x1e80100-camcc.h    | 135 +++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index 48986460f994..fa0e5b6b02b8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -17,6 +17,7 @@ description: |
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
     include/dt-bindings/clock/qcom,sc8280xp-camcc.h
+    include/dt-bindings/clock/qcom,x1e80100-camcc.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -27,6 +28,7 @@ properties:
       - qcom,sc8280xp-camcc
       - qcom,sm8450-camcc
       - qcom,sm8550-camcc
+      - qcom,x1e80100-camcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-camcc.h b/include/dt-bindings/clock/qcom,x1e80100-camcc.h
new file mode 100644
index 000000000000..d72fdfb06a7c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-camcc.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_X1E80100_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_X1E80100_H
+
+/* CAM_CC clocks */
+#define CAM_CC_BPS_AHB_CLK					0
+#define CAM_CC_BPS_CLK						1
+#define CAM_CC_BPS_CLK_SRC					2
+#define CAM_CC_BPS_FAST_AHB_CLK					3
+#define CAM_CC_CAMNOC_AXI_NRT_CLK				4
+#define CAM_CC_CAMNOC_AXI_RT_CLK				5
+#define CAM_CC_CAMNOC_AXI_RT_CLK_SRC				6
+#define CAM_CC_CAMNOC_DCD_XO_CLK				7
+#define CAM_CC_CAMNOC_XO_CLK					8
+#define CAM_CC_CCI_0_CLK					9
+#define CAM_CC_CCI_0_CLK_SRC					10
+#define CAM_CC_CCI_1_CLK					11
+#define CAM_CC_CCI_1_CLK_SRC					12
+#define CAM_CC_CORE_AHB_CLK					13
+#define CAM_CC_CPAS_AHB_CLK					14
+#define CAM_CC_CPAS_BPS_CLK					15
+#define CAM_CC_CPAS_FAST_AHB_CLK				16
+#define CAM_CC_CPAS_IFE_0_CLK					17
+#define CAM_CC_CPAS_IFE_1_CLK					18
+#define CAM_CC_CPAS_IFE_LITE_CLK				19
+#define CAM_CC_CPAS_IPE_NPS_CLK					20
+#define CAM_CC_CPAS_SFE_0_CLK					21
+#define CAM_CC_CPHY_RX_CLK_SRC					22
+#define CAM_CC_CSI0PHYTIMER_CLK					23
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				24
+#define CAM_CC_CSI1PHYTIMER_CLK					25
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				26
+#define CAM_CC_CSI2PHYTIMER_CLK					27
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				28
+#define CAM_CC_CSI3PHYTIMER_CLK					29
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				30
+#define CAM_CC_CSI4PHYTIMER_CLK					31
+#define CAM_CC_CSI4PHYTIMER_CLK_SRC				32
+#define CAM_CC_CSI5PHYTIMER_CLK					33
+#define CAM_CC_CSI5PHYTIMER_CLK_SRC				34
+#define CAM_CC_CSID_CLK						35
+#define CAM_CC_CSID_CLK_SRC					36
+#define CAM_CC_CSID_CSIPHY_RX_CLK				37
+#define CAM_CC_CSIPHY0_CLK					38
+#define CAM_CC_CSIPHY1_CLK					39
+#define CAM_CC_CSIPHY2_CLK					40
+#define CAM_CC_CSIPHY3_CLK					41
+#define CAM_CC_CSIPHY4_CLK					42
+#define CAM_CC_CSIPHY5_CLK					43
+#define CAM_CC_FAST_AHB_CLK_SRC					44
+#define CAM_CC_GDSC_CLK						45
+#define CAM_CC_ICP_AHB_CLK					46
+#define CAM_CC_ICP_CLK						47
+#define CAM_CC_ICP_CLK_SRC					48
+#define CAM_CC_IFE_0_CLK					49
+#define CAM_CC_IFE_0_CLK_SRC					50
+#define CAM_CC_IFE_0_DSP_CLK					51
+#define CAM_CC_IFE_0_FAST_AHB_CLK				52
+#define CAM_CC_IFE_1_CLK					53
+#define CAM_CC_IFE_1_CLK_SRC					54
+#define CAM_CC_IFE_1_DSP_CLK					55
+#define CAM_CC_IFE_1_FAST_AHB_CLK				56
+#define CAM_CC_IFE_LITE_AHB_CLK					57
+#define CAM_CC_IFE_LITE_CLK					58
+#define CAM_CC_IFE_LITE_CLK_SRC					59
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				60
+#define CAM_CC_IFE_LITE_CSID_CLK				61
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				62
+#define CAM_CC_IPE_NPS_AHB_CLK					63
+#define CAM_CC_IPE_NPS_CLK					64
+#define CAM_CC_IPE_NPS_CLK_SRC					65
+#define CAM_CC_IPE_NPS_FAST_AHB_CLK				66
+#define CAM_CC_IPE_PPS_CLK					67
+#define CAM_CC_IPE_PPS_FAST_AHB_CLK				68
+#define CAM_CC_JPEG_CLK						69
+#define CAM_CC_JPEG_CLK_SRC					70
+#define CAM_CC_MCLK0_CLK					71
+#define CAM_CC_MCLK0_CLK_SRC					72
+#define CAM_CC_MCLK1_CLK					73
+#define CAM_CC_MCLK1_CLK_SRC					74
+#define CAM_CC_MCLK2_CLK					75
+#define CAM_CC_MCLK2_CLK_SRC					76
+#define CAM_CC_MCLK3_CLK					77
+#define CAM_CC_MCLK3_CLK_SRC					78
+#define CAM_CC_MCLK4_CLK					79
+#define CAM_CC_MCLK4_CLK_SRC					80
+#define CAM_CC_MCLK5_CLK					81
+#define CAM_CC_MCLK5_CLK_SRC					82
+#define CAM_CC_MCLK6_CLK					83
+#define CAM_CC_MCLK6_CLK_SRC					84
+#define CAM_CC_MCLK7_CLK					85
+#define CAM_CC_MCLK7_CLK_SRC					86
+#define CAM_CC_PLL0						87
+#define CAM_CC_PLL0_OUT_EVEN					88
+#define CAM_CC_PLL0_OUT_ODD					89
+#define CAM_CC_PLL1						90
+#define CAM_CC_PLL1_OUT_EVEN					91
+#define CAM_CC_PLL2						92
+#define CAM_CC_PLL3						93
+#define CAM_CC_PLL3_OUT_EVEN					94
+#define CAM_CC_PLL4						95
+#define CAM_CC_PLL4_OUT_EVEN					96
+#define CAM_CC_PLL6						97
+#define CAM_CC_PLL6_OUT_EVEN					98
+#define CAM_CC_PLL8						99
+#define CAM_CC_PLL8_OUT_EVEN					100
+#define CAM_CC_SFE_0_CLK					101
+#define CAM_CC_SFE_0_CLK_SRC					102
+#define CAM_CC_SFE_0_FAST_AHB_CLK				103
+#define CAM_CC_SLEEP_CLK					104
+#define CAM_CC_SLEEP_CLK_SRC					105
+#define CAM_CC_SLOW_AHB_CLK_SRC					106
+#define CAM_CC_XO_CLK_SRC					107
+
+/* CAM_CC power domains */
+#define CAM_CC_BPS_GDSC						0
+#define CAM_CC_IFE_0_GDSC					1
+#define CAM_CC_IFE_1_GDSC					2
+#define CAM_CC_IPE_0_GDSC					3
+#define CAM_CC_SFE_0_GDSC					4
+#define CAM_CC_TITAN_TOP_GDSC					5
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_ICP_BCR						1
+#define CAM_CC_IFE_0_BCR					2
+#define CAM_CC_IFE_1_BCR					3
+#define CAM_CC_IPE_0_BCR					4
+#define CAM_CC_SFE_0_BCR					5
+
+#endif

-- 
2.34.1

