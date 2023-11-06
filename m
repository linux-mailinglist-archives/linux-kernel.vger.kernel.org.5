Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A797E1C05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjKFI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjKFI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:26:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B0123
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:26:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso58333671fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259166; x=1699863966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbBzRUaTwh8GYrimgkmoqie/wQrKhCpEmGUkDVHjaeU=;
        b=WBLjUOKGRQVP13KIORwwuMBJHBT9OswqtaDJA51YvP48X819Wc0z6iPX1XV2CyTrwS
         P0+T43hBo7a7aweYIxF3kEEfmZ8AKzb6K0Tf3DmNasOKbs53BT0tKv8u+NpdrRUVaj0O
         31VfRFkdq8SX8t6VQBFfjJOYj/bJ4HnUYxIWNB+c9h0Nq06FtdUWHmhb7yYQ7gl0tt1r
         rPyTQmz7RFxasjkwmPGRHOgt81gL9C+M8TB1NrajXx+KXZ1zXcdDuf/3SY0/LzoXqmzM
         rG0yMKlcIpFlbLJvKe6dHOZr2LfXcizHED507XHu3mkTAXeIRYF4mTgWy0EwyNqY0wAw
         Wrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259166; x=1699863966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbBzRUaTwh8GYrimgkmoqie/wQrKhCpEmGUkDVHjaeU=;
        b=MKYXvoUXOkhaxSI0VgNMGppOc4zqadVdeK5sars4xeO0/ZQPbJgVThpeIf4PLBWx0J
         I5yctt3LwscZU0aLC3hlvUXnurOdFtATrnKmDn2yqfS8ghLdfrdbA1Eg6arCoronNY6P
         u8vswtRIwlZaIvu/ZzALzhVdzFVMgCJLoK5W0F0xp2Y3BxYSPz2rYk2W5tv/K8Fh5Y3Y
         H3LseCRJE4iDXBif8zSnYFJU8ejbKoJVZzz8v4FKBLDaCol053eIhb1GUSDWv7Z2dFqK
         +09SElcASCOlIHswU16NSw4OB/lz6gTGMgirsAKuke/vr3DFd7SN1uqfJNne1U8jvdSg
         b+HA==
X-Gm-Message-State: AOJu0Yy8MP4v6VORJnAtEfBbdiQgJPmd+3Gr9S0AQyXwCkhdnl+hI0Sj
        NkKHZ0W3AxsBNEA+78Yq/chwUQ==
X-Google-Smtp-Source: AGHT+IF+GR6kl82R/ZAkz1LIBMwh8chsuLy7FP45r19qxYiPC7yrlXJiDEeSQtiOjjipXNuPBIjhrw==
X-Received: by 2002:a2e:8507:0:b0:2c5:1c9d:7f81 with SMTP id j7-20020a2e8507000000b002c51c9d7f81mr22356950lji.32.1699259166609;
        Mon, 06 Nov 2023 00:26:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm11610663wmb.28.2023.11.06.00.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:26:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:25:57 +0100
Subject: [PATCH v3 04/11] dt-bindings: clock: qcom: document the SM8650 GPU
 Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-clocks-v3-4-761a6fadb4c0@linaro.org>
References: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3616;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oSQB58i2ln7hRAzKAnc8rjnQqsl/3Rv9AGTvOhboBWg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKMWh4I+kcSRh5zQjp4QEi3ir0w7fBxN6d5ZUFsA
 tttulVaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijFgAKCRB33NvayMhJ0Y1pD/
 45BAzzZ456G7x8EmA1+rBlyJwIrX9mqEq45rF1fgDWDrXgAPtg/tHRK6cfzS3dHd5RPXRRdaxuEIKf
 Ad6PiOb/sBlo5YYqsH2Rfo/DYUWnBeb9x1uxht2Yh+H49f+FAoIcWTL+nTe7Ndww6O+jtQCr/1vLs/
 CCqZNedWLOixs7gS2e39OMv4ZnLou8/1387oad5Yg9ZNaeXUj85H9wRtO1T6o8V4MnjIP9nwwr07xe
 TUvhkPSrFazhR7i7nUxDaaqZSwFyZltZdUJP23mOL82ZhDJVPwAkHpUfN9MRwr2RXaiopTVou/N8VE
 tnsYfH4gvCXpb759ytLW4Zj8miligyH5sRdJYLxAtn3NmFqR798+jphvaelK8e+ox4vWKQRIJSvbaL
 xxgGTGOw+FCOGbi8CHf4Hv8wlBpSzekgr3HT4X5mrdwBZo2OmPbUdW9g9Xt54TOmTEUly+OEnpOfPZ
 82kmKVtZq9aTUKokj7pX7FdRAp1jrZvRESSgA7YZykRuHE5o8sHKU8XOJ3FacVD11irkVWT0c/ZszN
 D8H/zggL6f57w2SSz/DivX09GAqOYq9EOdFXjlx7C+zDOXrz+A7kFdygOsmbkZQwQiuYFc55I+FgdH
 CqXw6n8LP6v7f5i9M27BpbKTPepaU+rqs8ZvONUUTmCFnnQGwlsSSN9sal5g==
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

Add bindings documentation for the SM8650 Graphics Clock Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |  2 +
 include/dt-bindings/clock/qcom,sm8650-gpucc.h      | 43 ++++++++++++++++++++++
 include/dt-bindings/reset/qcom,sm8650-gpucc.h      | 20 ++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
index 2320be920a5f..1a384e8532a5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -17,12 +17,14 @@ description: |
     include/dt-bindings/clock/qcom,sm8450-gpucc.h
     include/dt-bindings/clock/qcom,sm8550-gpucc.h
     include/dt-bindings/reset/qcom,sm8450-gpucc.h
+    include/dt-bindings/reset/qcom,sm8650-gpucc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8450-gpucc
       - qcom,sm8550-gpucc
+      - qcom,sm8650-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,sm8650-gpucc.h b/include/dt-bindings/clock/qcom,sm8650-gpucc.h
new file mode 100644
index 000000000000..d0dc457cfe75
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-gpucc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8650_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8650_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_ACCU_SHIFT_CLK		2
+#define GPU_CC_CX_FF_CLK			3
+#define GPU_CC_CX_GMU_CLK			4
+#define GPU_CC_CXO_AON_CLK			5
+#define GPU_CC_CXO_CLK				6
+#define GPU_CC_DEMET_CLK			7
+#define GPU_CC_DPM_CLK				8
+#define GPU_CC_FF_CLK_SRC			9
+#define GPU_CC_FREQ_MEASURE_CLK			10
+#define GPU_CC_GMU_CLK_SRC			11
+#define GPU_CC_GX_ACCU_SHIFT_CLK		12
+#define GPU_CC_GX_FF_CLK			13
+#define GPU_CC_GX_GFX3D_CLK			14
+#define GPU_CC_GX_GFX3D_RDVM_CLK		15
+#define GPU_CC_GX_GMU_CLK			16
+#define GPU_CC_GX_VSENSE_CLK			17
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		18
+#define GPU_CC_HUB_AON_CLK			19
+#define GPU_CC_HUB_CLK_SRC			20
+#define GPU_CC_HUB_CX_INT_CLK			21
+#define GPU_CC_HUB_DIV_CLK_SRC			22
+#define GPU_CC_MEMNOC_GFX_CLK			23
+#define GPU_CC_PLL0				24
+#define GPU_CC_PLL1				25
+#define GPU_CC_SLEEP_CLK			26
+
+/* GDSCs */
+#define GPU_GX_GDSC				0
+#define GPU_CX_GDSC				1
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sm8650-gpucc.h b/include/dt-bindings/reset/qcom,sm8650-gpucc.h
new file mode 100644
index 000000000000..f021a6cccc66
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sm8650-gpucc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_GPU_CC_SM8650_H
+#define _DT_BINDINGS_RESET_QCOM_GPU_CC_SM8650_H
+
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CX_BCR			1
+#define GPUCC_GPU_CC_FAST_HUB_BCR		2
+#define GPUCC_GPU_CC_FF_BCR			3
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		4
+#define GPUCC_GPU_CC_GMU_BCR			5
+#define GPUCC_GPU_CC_GX_BCR			6
+#define GPUCC_GPU_CC_XO_BCR			7
+#define GPUCC_GPU_CC_GX_ACD_IROOT_BCR		8
+
+#endif

-- 
2.34.1

