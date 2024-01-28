Return-Path: <linux-kernel+bounces-41997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C80683FA79
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE041F212A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769EC4CDEC;
	Sun, 28 Jan 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTKFcWth"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14274C3DB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482368; cv=none; b=a0bEMBi6g4eZqmIYyMQb+NhnH80ihHh6ggj2prV2Gxw1U/mnJsOD8vs7QB018Bh6ZxRSE/ZsDZsRXW5AVWaUtPkvx6T7QQoxb5JVd/JVpFSJ0CwyrnKJN4BQFYltWO7RlaNfYu4vHoDVaVcbUQzvwq70yrKiH2BjHYJk0mlrh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482368; c=relaxed/simple;
	bh=RNTWLyTiZiBUhS5TEQLKFH3Bk5qTv5ogmNaSck4H5Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBN7kV+i8pcWhS+mdu/IajBRv9u5uAfwZdWGvXFuTI/sAIyLkLPoVZ8svs55/ZrrnFAXFCtE2AKf1egHm4F/Dmavj8PsSRG9ImkKJUfqJEFvNujmKnYPfNMcDTAZOERUkjwJ15kJoJVswyzBG8AvSdF5ozDcSNdrx6lsx+L0C8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTKFcWth; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a35ba5744e0so27906266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482365; x=1707087165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xX/n0g5EwVAr63DPP+HMCiUOVUpkPp/mNAHdSRNRYg=;
        b=kTKFcWtho4lT5o1PuOC1Vf0/LQCxsYuN3KhRvuRTjY9E42EY6wIGjKUkDTwnhbJmCP
         CINY1DgiE84uiVsPezXVYR78mvO31V1HdJGYCl4oAO9OQ8QeokspmOivswjl4To8NWx+
         auOdUqoV+aVu4XjaUB9nQi2NMbvm1SLPljecPk+5dU8XhI69J2Imto+WkVNWA/Y7Phpv
         j7WiQXDA6fHKp3MBktTXTtt6SbxkpYMeDS8YnOkq6EUtgWnGMRVo5OaTEL2ZatuX/6eZ
         S1yE9IZuMylW2w4u2zezvNg4U0W3Smd5xBfwifjkeOtJ2eTRaHzck+U3ubjTQ5Crs/gE
         2WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482365; x=1707087165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xX/n0g5EwVAr63DPP+HMCiUOVUpkPp/mNAHdSRNRYg=;
        b=HGX03SFrs1UVJexsQmAWf96X2wBICPo9TddjPkvS2Q+io5qJarr3PcK9Krn853JT8W
         yaB0U4T+5V4yHV2oJlyEXN1fsGDfbz5vruE0Vx/59FrDPnFBGo8+8XyNCruvfhTQgZ9A
         7diytoJMfoYCK1TK1RbdmobItYlN9IJMnKAPi/cEhCgMpQeAJKY+Kvxj3/YYh7waCVr1
         05n5Y3DSsRZbIBU58I4cX1gzu8nIOk462IJbjDR5IvzANqLoIq9XgZWq+FLsIpowNqVJ
         cRUhCH3XNKl31JclYAnJ972rysc3bASEe6evMPWp6NIqPPCgBhcyBfDqhpxi7sS48I3a
         S00w==
X-Gm-Message-State: AOJu0Yz2qdvXDvWls9XWpevznShQHIT7eREvAKxflZzlO+3mFH7OaL/K
	n8qXUInrZXQ0JcApXcLZDedFGKzVFJdkByfdrh3ZSOO+SdBw578aW793h9vmQwk=
X-Google-Smtp-Source: AGHT+IHdyPNwtT0CYhBCFVqz4bJo7DU/+LBuLAlBSeYNlazecrVT1vWM6syjs2X0LTOwdQ5+4EQHiw==
X-Received: by 2002:a17:906:5fd7:b0:a30:d4f2:1603 with SMTP id k23-20020a1709065fd700b00a30d4f21603mr3895360ejv.15.1706482364961;
        Sun, 28 Jan 2024 14:52:44 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:44 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:17 +0200
Subject: [PATCH v3 04/10] dt-bindings: clock: qcom: Document the X1E80100
 TCSR Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-4-d96dacfed104@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RNTWLyTiZiBUhS5TEQLKFH3Bk5qTv5ogmNaSck4H5Kg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttqtF9/z+G+lcXXwwDt2i2WKrEVZxywl2ybPV
 9oZtE4A9/+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbarQAKCRAbX0TJAJUV
 VvE6D/wK0gkC7DP7s4FWqctuu0wQ3+GaYIUprn3HbGgPExXEUihV5tsU+yeaDc/4WbB3biguqCM
 ZjMJHJvCD9leNLrmsVofh0KfBQrgswSIc4x7tLzh1/vVwczIMu78n4OKW2csm+9qhF0U7+LE9Rt
 KeMWT77ZPrbVPx545BHVXFnRb+zge7zOpnU8p66U1uswqoPKYXrFIe18fXWWxteT/TQ0edl+a9m
 AP8tjJazDwkpNnAU3hpPr9gbX6xzew+AC2c5igteWNTxoBcIoKOSV/LyCjOiIDT4hP8TuwOaFdA
 w2+PCyXjiru4LB+femSBOTDkFRimw3lc4E/2sURlERJpw7tt1sVz+P89n8P9rtRagVV/3zFdKLa
 JcXUvOVshz1j8ZmJ8w8Lb3IgBsyFzydJE3qI8/QlF5ij4Ue0DL971pUVT0PKCWlBensLTiz5K2S
 4bljZeD+uGIhhkvr+FCWfoFfcHJX79AUz8IHd/s/eN5D0yrIJH/umM1ogyry/bFE90adoT8QzDt
 f35/v2x/jULLEx7uThf7DZ80BpP6V8dL1lMWPDauNWkDTgGbU0+4DMEleL1jJqsIEx4gOoc3dn5
 4f+wL/yGMkvGyyRea9dgcZLMveuJ+DM3KMkRgRAF84XXuT4eGbp4eNEt96OBkHykwq2o6Wv/YCf
 wCkmxO7AW9qN/9g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add bindings documentation for the X1E80100 TCSR Clock Controller.

Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  1 +
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index af16b05eac96..48fdd562d743 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
+          - qcom,x1e80100-tcsr
       - const: syscon
 
   clocks:
diff --git a/include/dt-bindings/clock/qcom,x1e80100-tcsr.h b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
new file mode 100644
index 000000000000..bae2c4654ee2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+
+/* TCSR CC clocks */
+#define TCSR_PCIE_2L_4_CLKREF_EN				0
+#define TCSR_PCIE_2L_5_CLKREF_EN				1
+#define TCSR_PCIE_8L_CLKREF_EN					2
+#define TCSR_USB3_MP0_CLKREF_EN					3
+#define TCSR_USB3_MP1_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_UFS_PHY_CLKREF_EN					6
+#define TCSR_USB4_1_CLKREF_EN					7
+#define TCSR_USB4_2_CLKREF_EN					8
+#define TCSR_USB2_2_CLKREF_EN					9
+#define TCSR_PCIE_4L_CLKREF_EN					10
+#define TCSR_EDP_CLKREF_EN					11
+
+#endif

-- 
2.34.1


