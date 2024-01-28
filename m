Return-Path: <linux-kernel+bounces-41996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A718483FA75
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DFFB21F83
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDC4C62B;
	Sun, 28 Jan 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3pysaHP"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C514596E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482367; cv=none; b=Bb0lLwD24eaLF/h/JnpDaIPnhS6XtRBsmanxJA24sDfXJiLpyYb/5Xg8/0L5rmknq4diiRNMza21YxA3M4pYP9yty+3tnYMb2sHNEiAAbziRMXHxS8vvEz3ZcmH21y1oLt0xVJoWpf/rvlq0PlLUAv5iIuoUXRJUTvihxQ0rCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482367; c=relaxed/simple;
	bh=MVhUWSY/+upRsPik4dsc/FIDp5JpvuJHiJdLly35s/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSFAJ+4akMzcdUH+/E4/N8Ckn65UYoUTtiOEAi7Famw7bBnOP8phoiWkwRO5crzAU2e7b7Z82R0EmLKDQ+nIych+wCjR20iPvU8P4863KJnq6SXKuiiX+xnEdKggstsgQ4qyrAhDbo7tLNgrgS7FfFjHxiEi6PfRxQWshTnuqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3pysaHP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a354408e6bfso194287566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482363; x=1707087163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oATv8NOQxxuUnkhYBjrPZ5SJTfwj18//AqKtxSW/XOs=;
        b=Y3pysaHPJzq8jnAluW+5zyG5X65xytHm0VNNrd9L9Rg/pAWPeVMo4XXjIO44on5NwS
         OtehhmRY2M4lXNXAmU4f9Z/G/5BfiUiMbJzVBY8UyQw5CdYPrAT2GY5d3mdd1bxJ+uQH
         M23a/Q7Esa+WEIfJt8TZRv5dT/4E1Htig1VamxEffWUOOfs12KPxsl6jqorALJw1p5nb
         FJGnTiSUyxz+T0iRK2g/dvIxvZXohZeB4jAuQkSzKFA8AKNQdJiMUnjb7EqVRTbohE79
         rTC6GRGImrtJnb2eumGuAzrfN5ydDVWXoF/97LKxXGAWjW3y7HuEpXWQvrOfriAI68lB
         XuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482363; x=1707087163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oATv8NOQxxuUnkhYBjrPZ5SJTfwj18//AqKtxSW/XOs=;
        b=IeLZ7NQ9LBPLBrEePgrQJZNNi87d1OanpLRnaF1guX2B1aIcSbkHI7x/Kg6tAndrc4
         PXbEKuwk2gtGWUr7yc/yfi9dmoFMsJD0y/dtWbU60T8/Lp0iaNjv0RcpTxbU/HQukmN7
         TWQZjHHqL3fv/6iwxMndetcel3Qv6u67/J+y5NuzLQwJA9shrU8sii98FVQ9+5Vb9Zlh
         ezVpiIhmwI7NWfY0co1YtVRLtH/lb6CQcihBCZJwpZhHkYTDfS6QxzirlF9dRxZwuDaP
         3X6EOqgkLG59bEqfCEol9sU5wQgwivYtgFqtYEzZtXVTH27lJnGfe6Icb6Kq0jjpxanY
         h28w==
X-Gm-Message-State: AOJu0YzyjCun2DGe3N4BUZMzY3K21UmwcfxHwE2G+WYI0elE4eZTI2uH
	krXTx6vC9DMSPPV/ZPpfxFRoTvaGu+ZXQXV4MJ152p+0pX+Az4wmFD8H06RKWec=
X-Google-Smtp-Source: AGHT+IGNAQQ5wUy17U75B7x5czk4mbe4d2jVSwmNa0jfDZzaEVAsZdQPzt75TXCekn2Dn7+26plF+A==
X-Received: by 2002:a17:906:4ad0:b0:a35:3718:997c with SMTP id u16-20020a1709064ad000b00a353718997cmr4255818ejt.28.1706482363328;
        Sun, 28 Jan 2024 14:52:43 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:43 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:16 +0200
Subject: [PATCH v3 03/10] dt-bindings: clock: qcom: Document the X1E80100
 GPU Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-3-d96dacfed104@linaro.org>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3720; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=vLpNxW+lAlbuQp8bP9Fd2lailtB/NBx2GC9/qnTEXIM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttqrfbNyNSW4QtO0s99QREx6Z7JLazWDeMdhW
 Xsdfq6IDxiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbaqwAKCRAbX0TJAJUV
 Vh5YEACi/sAXnLJFtXF0/GIlZuxLvivkvfA4uL6yvgMJUNgbXxfpSzx/S3jclnc54jb+y7qnyen
 NfMQC9lK4Z/ZB4BIa137V/9xxJ5ojzn41gComt+shxJEzZrcQ1BwesT/RApwxh4eJ3Ex/p27/z/
 z/XJEPinaYinhZCpL/E0buLjzrPpkU5498567YRGlLpDUh/ogTBoqyp6NhATWIncfXm6mM9IZa6
 sxqesOZlsY07lRdh2+tNUXpPsWTv2RkUZTZq3Vtrw2DYL813euf6rd0oMd1XNJG1NN4rgXWhMHY
 Rc9a8PwPyV94P6DjfG80g9NiQS5pMSEKbZrzrcoYq/MdsbawSU1WW6efLwy1frPW/zCIEU9UmTr
 2ZF1N4pIvNEeuKOvfAKwPSWZBly7v5hwy2Ken9UV2f0TzY6MDqfm8e+RZskwDrOB1FIP9Fxg3a9
 a7v/wJQGy2XyfWJeu0x5e2h9HJjD/NPbfA5C1ph3UEyJZRLIqrfs2oft5TbPEuDM+KTRq65B5bn
 H4S2QXMmuflsFsr8rHz7njp+kMipii1LzoeWblr2gbI7YSXZmBXuiwN0Ot+70Vojz7DgbBo1q9c
 tgp9T1DmqEmIfE1phAwxlJ99bV7/RkwCiharBDt5Vuuf0koPAW4vuHvCOm2ungzico0sjrec7In
 AYfCLr1aRhkqCEg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Graphics Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |  2 ++
 include/dt-bindings/clock/qcom,x1e80100-gpucc.h    | 41 ++++++++++++++++++++++
 include/dt-bindings/reset/qcom,x1e80100-gpucc.h    | 19 ++++++++++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
index 1a384e8532a5..36974309cf69 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -18,6 +18,7 @@ description: |
     include/dt-bindings/clock/qcom,sm8550-gpucc.h
     include/dt-bindings/reset/qcom,sm8450-gpucc.h
     include/dt-bindings/reset/qcom,sm8650-gpucc.h
+    include/dt-bindings/reset/qcom,x1e80100-gpucc.h
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - qcom,sm8450-gpucc
       - qcom,sm8550-gpucc
       - qcom,sm8650-gpucc
+      - qcom,x1e80100-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-gpucc.h b/include/dt-bindings/clock/qcom,x1e80100-gpucc.h
new file mode 100644
index 000000000000..61a3a8f3ac43
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-gpucc.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_GPU_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_GPU_CC_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK						0
+#define GPU_CC_CB_CLK						1
+#define GPU_CC_CRC_AHB_CLK					2
+#define GPU_CC_CX_FF_CLK					3
+#define GPU_CC_CX_GMU_CLK					4
+#define GPU_CC_CXO_AON_CLK					5
+#define GPU_CC_CXO_CLK						6
+#define GPU_CC_DEMET_CLK					7
+#define GPU_CC_DEMET_DIV_CLK_SRC				8
+#define GPU_CC_FF_CLK_SRC					9
+#define GPU_CC_FREQ_MEASURE_CLK					10
+#define GPU_CC_GMU_CLK_SRC					11
+#define GPU_CC_GX_GMU_CLK					12
+#define GPU_CC_GX_VSENSE_CLK					13
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK				14
+#define GPU_CC_HUB_AON_CLK					15
+#define GPU_CC_HUB_CLK_SRC					16
+#define GPU_CC_HUB_CX_INT_CLK					17
+#define GPU_CC_MEMNOC_GFX_CLK					18
+#define GPU_CC_MND1X_0_GFX3D_CLK				19
+#define GPU_CC_MND1X_1_GFX3D_CLK				20
+#define GPU_CC_PLL0						21
+#define GPU_CC_PLL1						22
+#define GPU_CC_SLEEP_CLK					23
+#define GPU_CC_XO_CLK_SRC					24
+#define GPU_CC_XO_DIV_CLK_SRC					25
+
+/* GDSCs */
+#define GPU_CX_GDSC						0
+#define GPU_GX_GDSC						1
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,x1e80100-gpucc.h b/include/dt-bindings/reset/qcom,x1e80100-gpucc.h
new file mode 100644
index 000000000000..32b43e71a16f
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,x1e80100-gpucc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_X1E80100_GPU_CC_H
+#define _DT_BINDINGS_RESET_QCOM_X1E80100_GPU_CC_H
+
+#define GPUCC_GPU_CC_ACD_BCR					0
+#define GPUCC_GPU_CC_CB_BCR					1
+#define GPUCC_GPU_CC_CX_BCR					2
+#define GPUCC_GPU_CC_FAST_HUB_BCR				3
+#define GPUCC_GPU_CC_FF_BCR					4
+#define GPUCC_GPU_CC_GFX3D_AON_BCR				5
+#define GPUCC_GPU_CC_GMU_BCR					6
+#define GPUCC_GPU_CC_GX_BCR					7
+#define GPUCC_GPU_CC_XO_BCR					8
+
+#endif

-- 
2.34.1


