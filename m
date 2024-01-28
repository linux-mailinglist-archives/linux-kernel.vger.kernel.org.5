Return-Path: <linux-kernel+bounces-41998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53D83FA7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64536B21374
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4794E1DC;
	Sun, 28 Jan 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9c3SlOp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8C4C635
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482370; cv=none; b=pEPdZPYvcNOLoZ08AN4yvWXv4HUZF5zRctb3exuU4L9aVXjz4Mys49WRaDwl1KTBUnoyvUCT5SGIQKfCoeXzTqXYhnUZzul165ss5w+KijIb6BUdZkSxHRX6McYoE7Kv3+b4h4I3iE/3qrvYR3DVzrMrRk1y5IK0/BrxxN/W3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482370; c=relaxed/simple;
	bh=5o9rPc9rPhaIIYD3Qv1YS+E1/PQUOBaulRbsW2qNMng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKy1G4OJHd7hOTKJxCXSvc0tY75rc8Yt5hbXCVbEWKqL3i2oBP5LaacIL/qctfT1x/6yvw/kZTOtuO+Qh6Q36kRhHsSqFlcIRgjptV3Ji+ApLR1oOCrZT4eUx2pmNc5nE492RU2tOvWgteE4dRdMCi/IfXISKzLl/rrARkWGnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9c3SlOp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so409227266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482366; x=1707087166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqvowzPBNes54tkE+QmrMP2CFzr9rwDQb7eM4POy6yQ=;
        b=Z9c3SlOp7OMV04U9SQtpvuJhLZ8S11jlT3Sa2xt7Hg0FahT6rQTV1yI7zRgAdfiJIA
         xrgZeheC/FZoWDLC6TRw9hU3f9OMTQN7yOZG00h3CThGW8GWlTPmyu4lCoyGmGUHbc7U
         IqSFj9Y+rxzBDAnWn0Izzoyhk7h6yyOGyMdd5yqtGJJNrVlXXblgzcuBMm0Am7mz9W0T
         I6WS4EPwtaIFGF+dKAEurz8CtScrX55VqSIA8ViL3YCnNXXwXGTegfCB7ONFdh0Fw3uv
         YtQcIzeibs9tPoyOMu/fS91lBND60cRSxxtZ1CeUJG39RJxlglv5nK8xxlUN83ewdB13
         CyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482366; x=1707087166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqvowzPBNes54tkE+QmrMP2CFzr9rwDQb7eM4POy6yQ=;
        b=CHnFcy3haV+v/gViwYizZbywhwJTfOQ2aoEUkGXGuc1z87UaylxvEY8i24o2Q4H8NJ
         JRpjFTN4vLemqgOQgp3jxoJIJDNbt4ifLOvl+G75aHCCClznhfyTDPXg1zz45EtsMRXV
         tfqD/d7PVOrcLBlLFu0v7UPQwKJ3sF1Hs/Pe1sIX3/L6xxIMEgpiBlLGj3BMa3vB2Fja
         Pq6bKYfFiucwZznx59uWIo5gTvRzTWr1ZYhwZzJ1wbkKWnqrNly8B7yJKWtpx0VLX/TE
         2qhOJx1xL+4F4OqFWxG8WFbi8EzS7gLcFUQ3+cFoX054aCMudqDzsTjHsNUlN4s7T76O
         VP0Q==
X-Gm-Message-State: AOJu0Yzn5JkV28klWRdCUDQ1t5oV/APTmmZnqSCCbEy16VWfRnq7kPF/
	6ULJurB/wNT5vO0ozeOfM1WIIINElF+0xp1s2qiPVh1wsHlGQpjiht3d2ZEnmaQ=
X-Google-Smtp-Source: AGHT+IF7VVav7sMzX9inIOP8PGHF46refnGFjucH3aCKRAw0DZt78wb1ewFYpbrJhDpDUZz9bD3HbA==
X-Received: by 2002:a17:906:3386:b0:a31:6534:1da with SMTP id v6-20020a170906338600b00a31653401damr5518584eja.36.1706482366545;
        Sun, 28 Jan 2024 14:52:46 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:46 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:18 +0200
Subject: [PATCH v3 05/10] dt-bindings: clock: qcom: Document the X1E80100
 Camera Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-5-d96dacfed104@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6323; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=58HK41X2RwoVKAc3y1UdEE+FwgqR6qC/7J65pR95bFk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttquo04y5T+VUivBLdk5wW+FUyCtOZs0ZNDLd
 PGvkzIzQTCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbargAKCRAbX0TJAJUV
 VukWD/0clAgF/jWsn+0MjcJZgUluNyW2rxP4cyJ1f5P3ZnhipPlFNsm7AwT26oofhFYAYIjMMxf
 zQH4F/mCkjt12xUd8CjjQkB3j5S10qFph4TQaVqWei83/z/9MAXoW5vRN+EVZyUWyIfRrEMbH+V
 ybqSa4GqfasuTn0g53Ci94vW14huH+VYq+yadgiETJ8q5SKPeBXxxhO7DCWL+rG9CtoXn5AQqQE
 ZlVOwwMBbt+x2tk+EQ7rZQ8azS+JSRRzan7m9xLAANmNL7OX5X0A2iz3LLidn492akA8Qv38vHi
 4SoOOLw4Hb/kyrnLOh4RTNoiVSiCv9at0AWm48w18Ma5RH8BrzFjMjIOI3rB4NrcEIzIPnpLnPP
 LIglHYxxnqn98r+ao8A8TKoKBtAtetRQ9sL/OR8HxS/uUtqaJqafa6GKpMf90DehSt+LxVDPrUP
 MhwYBb7y8xYDXN0fH+HkZc95KVB2JnoNct/+BUD/a2VsLSUm1tCSpYgb9JsYAyuULDvKZvHNFFm
 BBn5McbPD6ze3f6O09CecGl7SRP9Mp8Tjt5RNRDvLWTSdAS+EtRpox2EPPie3gpn2VX6GNj/aMN
 1neB/i+aR+yLEVJ9CpOzOHyxQzkGfjdAk+8X1WSd2NKICrOmEX2odkOaieDDEP7AC3p4SExZVhM
 GIkjPeztgpnzwJw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add bindings documentation for the X1E80100 Camera Clock Controller.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


