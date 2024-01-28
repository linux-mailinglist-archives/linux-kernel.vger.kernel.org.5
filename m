Return-Path: <linux-kernel+bounces-41995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0383FA71
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F4B21FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC574BABE;
	Sun, 28 Jan 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxkBmZoN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764093D3AC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482365; cv=none; b=Hwtjlj8fY2lFjHU6yV/aZl/3YVePfPB3Oo+VOrV3nEbbMLFyhEUQaDPzLvpGe7tXDylxtmnOkoJuALnbVhsV/t0O9ZVxOprOewyNBhtGekLwmUsJ4zMuKUApHcuLwpzqKId51t2pYREgeaPgiu/MlaGz5i/TeC1VR3AqSl2uQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482365; c=relaxed/simple;
	bh=vnNZdrva/GeFt81JLdOrHZAe6+/2CrTRGADyIRb3/zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NzzTIMqtAY+FYwh+CgYxapPnEQpciRAFsszAlvi4yRNC44b0ybGDU7XtU5CwSaiUITT05I4t1QXLPf6p4q1l6ueM7hbI7C0Lp5N2ArEA7qko1cQK+1HjTDs9zsVcAvDaQEwCJwyoPk8B2G/jtIW6B1yH3XrDbWeQlsII2WMZjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxkBmZoN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a359446b57dso53113366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482361; x=1707087161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMBye1t5UXcNhXWhmik2JmMhzzuBlYhDgwEz+d1O4h0=;
        b=hxkBmZoNdtrnd/l6htvqBrzAxhAof0103/Ij8jt27dfHS6YHQLuZowasQ57ciQrmRB
         xFepMRJA+bPG3hqwZF3gp1BuyJ933ijI/nE3M+lBsvz7Unnyf0I2tNPFhXj+DuwQMcBp
         t76yhkgrnNHIvJRXwijxl8OJdo8rB1BwKR4+682WwsGWeodrqFTvb3WVNEK8/LV5L1Mn
         f9tynl5qAwbKiZtFPnHAkcPAqa68OQhjdpm+YlB054bzayggiVKvX5mT6i6ME4KXhmNC
         hkAaeysoxQuVOxk+pON3hX7K6f8gzKATbDwKhbo5s5R0a9L/dqQMcEF/I4yL81ylDXnh
         HpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482361; x=1707087161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMBye1t5UXcNhXWhmik2JmMhzzuBlYhDgwEz+d1O4h0=;
        b=lpMPRGJ5Lt5B8WdV4Gn4xCDwQIoWq8DbQKnRXdWRjpdjkC+6XTSpimcHjJ+5kxYP1R
         RmMLMgtPBYInUn/0ItDFd4h7En/5ugAtfs/iKXkMjCLvIjDKKDfwMFTgI8ruNf0tdU0k
         g3laplBzgGALS7FXX/h7ahfIZnYWrlHsPz/KcWSz5eIJOxAYmp1wzzeCvWcD54ahVfSN
         sQnWoXFHlvnqdiq6IQw7gt9gvMxOk49W3gVtmiAB1UGbgvHhmDH45Fp+fdBK1Kogn9a5
         aGLkSBae0R5ajBI+D4G8qI6EEX1Dg79xG2aVeMSdNAstN51Jy862BDfJAzeR/p2VyU3b
         cNxQ==
X-Gm-Message-State: AOJu0YyekeI/HlUoJj2WTdqhSsvdY41EerqdO4Pph+ENktC7fNPHqa+P
	9lWcrcdVKMSgqszTCrpCltESFM4fPLKDqisxmsG3XQirW51j+C6DRpuTgEp7HdQ=
X-Google-Smtp-Source: AGHT+IEOpDJlrUqO0lBvpy9D55idcqnjU/+5K7Ccql0T3h/TRX1a25vDrB+PPXy6rlr4cvJZEsvweg==
X-Received: by 2002:a17:906:f6d5:b0:a35:766e:a0c8 with SMTP id jo21-20020a170906f6d500b00a35766ea0c8mr1727859ejb.8.1706482361698;
        Sun, 28 Jan 2024 14:52:41 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:41 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:15 +0200
Subject: [PATCH v3 02/10] dt-bindings: clock: qcom: Document the X1E80100
 Display Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-2-d96dacfed104@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5379; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=S9TmHat1VTKPTNTwEMUe7uLg3aArQF0Wrx9YkgJDDBU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttqqHUG/MAxYmlXy9MhLZPJXvhRo8B/ah0RD9
 Q9h5gljADeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbaqgAKCRAbX0TJAJUV
 VhLFEACyvL6DQ0qg/A13mMu/OP2v38ff7yhiZocDtEB/fWlHJdNH4yQ7L8KZTZj5Ma0SCB58gf3
 g3ej/nhUpferwKfZ7QSzxN5GCDujVpuV/xm3B+Z0YvFmLCyZclpjdio9HDAkpprID0qjYnql7c4
 36xbVZrvA5Ok464Y6MN2cBtBn2oBZ2kjRC+fxpvmisAayszt5EWIDdy8usxEs9d3ZJDqI0DYbHj
 FrX7IR7gH5blzcZ/zx2lSbfzDyxB93Zc5PXMupk+wSbBRnLaHOF80FcsAZPvon+rBLgRzgeigHQ
 C8oXOQU4wDTpbvbCaq7jwFLE/K4sQIitAtt8ERwX8Vb/nOPFlZE0B8g63SyHLQS9EnqpY0bpFYi
 omR0Cl2/47gTsAZ7+/jRhbPReqC7/gcuJYDmpxv+zNmKp+4jtsVYnZcGalF9DKlLIOFolrtc9mF
 /SOmOqWJbiUB0H3+orXg2PsdyuXaF4um6KHda9wx5Gsd4+leqwueMWwdxMZfhuRWay2uWJ6Uk8e
 FzOLE65/XeCJxdwQv8uA9TflejPAy2jrMwRz0GnYw98uacYiJN4BXQ5UneablEMzNuT28++rMu8
 /aSkt6QcamAuxWZqSyznZdayhuL8tXOt7yEd0I3pbotAG7CGwVyZFr0aP9RsOOZhoqjNZHd8bCE
 5q2LZ+WiuvqzhpA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Display Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |  2 +
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   | 98 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index 369a0491f8d6..bad0260764d4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -17,12 +17,14 @@ description: |
   See also:
   - include/dt-bindings/clock/qcom,sm8550-dispcc.h
   - include/dt-bindings/clock/qcom,sm8650-dispcc.h
+  - include/dt-bindings/clock/qcom,x1e80100-dispcc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
+      - qcom,x1e80100-dispcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-dispcc.h b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
new file mode 100644
index 000000000000..d4a83e4fd0d1
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-dispcc.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_DISP_CC_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_ACCU_CLK					0
+#define DISP_CC_MDSS_AHB1_CLK					1
+#define DISP_CC_MDSS_AHB_CLK					2
+#define DISP_CC_MDSS_AHB_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_CLK					4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
+#define DISP_CC_MDSS_BYTE1_CLK					8
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				14
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				15
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			16
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			17
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				18
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			19
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				20
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			21
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		22
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				23
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				24
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				25
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				26
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			28
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				29
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			30
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				31
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			32
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		33
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				34
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				35
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				36
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				37
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			39
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				40
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			41
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				42
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			43
+#define DISP_CC_MDSS_DPTX2_USB_ROUTER_LINK_INTF_CLK		44
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				45
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				46
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				47
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				48
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			49
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			50
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				51
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			52
+#define DISP_CC_MDSS_ESC0_CLK					53
+#define DISP_CC_MDSS_ESC0_CLK_SRC				54
+#define DISP_CC_MDSS_ESC1_CLK					55
+#define DISP_CC_MDSS_ESC1_CLK_SRC				56
+#define DISP_CC_MDSS_MDP1_CLK					57
+#define DISP_CC_MDSS_MDP_CLK					58
+#define DISP_CC_MDSS_MDP_CLK_SRC				59
+#define DISP_CC_MDSS_MDP_LUT1_CLK				60
+#define DISP_CC_MDSS_MDP_LUT_CLK				61
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				62
+#define DISP_CC_MDSS_PCLK0_CLK					63
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				64
+#define DISP_CC_MDSS_PCLK1_CLK					65
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				66
+#define DISP_CC_MDSS_RSCC_AHB_CLK				67
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				68
+#define DISP_CC_MDSS_VSYNC1_CLK					69
+#define DISP_CC_MDSS_VSYNC_CLK					70
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				71
+#define DISP_CC_PLL0						72
+#define DISP_CC_PLL1						73
+#define DISP_CC_SLEEP_CLK					74
+#define DISP_CC_SLEEP_CLK_SRC					75
+#define DISP_CC_XO_CLK						76
+#define DISP_CC_XO_CLK_SRC					77
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+#define MDSS_INT2_GDSC						1
+
+#endif

-- 
2.34.1


