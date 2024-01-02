Return-Path: <linux-kernel+bounces-14710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C50822109
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133BA1F21349
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E11640C;
	Tue,  2 Jan 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuH+b9LZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D615AFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336897b6bd6so9552569f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704220211; x=1704825011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWRCEPo3uk8PO0iqeS9GD+AGuH5MLy4R7Glqs9RzmNA=;
        b=VuH+b9LZsjaCoaRs/ZLXcDOcfYngSSzhp0I+uHw2vEF+gSWhT0diO13aOxcaxexq7j
         22/t2jYG7PNjBKJiLX+oE2ZGnu7Z1PiMmoPwRT5HFwFNIwN0djNFkBHMzJTWmjX+XsnZ
         aV51w1SeT7Sm8H68Q78zwbjIiQDz+WBY2lbvMASc1aazXNtX5QuapFbE1QxlpF9dxQbD
         oiSKFnlFrNTpMzOe34jrCdRejM68y6s0UsyJxvu4xFxRBY9dw7CXJb7UAEfE77W+SRQ7
         qgbw1YmDeqacrJNpJa/jr76KxFpxs1LERdFl0nkHrOs921HH0BRevIv5imJTG05MlVK/
         QFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220211; x=1704825011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWRCEPo3uk8PO0iqeS9GD+AGuH5MLy4R7Glqs9RzmNA=;
        b=EILSmIZHMW0aGSvojkmPWY5CV7wNfHkotJ7BA3C8aYIph1X11DLYT/4tNG45TLJmGW
         1pXvTF8QOJFEBIGV+zVsZX6TmEM7JXmIWObvtKCpZDY3EUiGadur7TrGxfWbIFjZ0be6
         jDwDvfhH9nwhJnYR0Q3geeyYginE6FH0d8fNmKsJ3g34oDWAQO0zcupLC9Xcf39FlrO+
         wN38sqwyo9aP+Ucu9zNvAgUclbhyiuZ+uuiw1nA2KMJ7lnFqPLAF8qTR/e/BMfEwc/9/
         Pw4TudquPz65MalSOL/9jW73S8cNvYZuNVR1k9ktJAomQDSWxE8s3AeSx5dHzUTPQFUz
         6MyA==
X-Gm-Message-State: AOJu0YwBkj86maABIUZoAFh2Xxp0FpoXZYBmeIInObfJZrcOv+keDBnU
	VB3bewyUXqVSR2BM6BOmuH6r4gOY9KOQlg==
X-Google-Smtp-Source: AGHT+IFX3GSSUEbN6TOB3T8kBbk7okSpo54ycIvJoOBfMFq2gsg7UVxTpK4OdqdeWI02/7yr1jYAbw==
X-Received: by 2002:a05:600c:4514:b0:40d:8397:e6ef with SMTP id t20-20020a05600c451400b0040d8397e6efmr2516168wmo.144.1704220210903;
        Tue, 02 Jan 2024 10:30:10 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id et10-20020a170907294a00b00a2699a54888sm11968835ejc.64.2024.01.02.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:30:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 02 Jan 2024 19:29:49 +0100
Subject: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add missing system-wide
 PSCI power domain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-topic-x1e_fixes-v1-3-70723e08d5f6@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
In-Reply-To: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704220203; l=1514;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=a/TSf4p7qbd3BP7GuDisMtggCpN6jL7pGZHmOCzvoa0=;
 b=Z2+Ub7tjMe4FVBz3xh+JlHpM49o8IStSPlM4cL67eGCib5gN4+iKoJ3Ia03IysXQCJQdWXlPf
 sgDTgFj2DWxAiJ6trozz4GiSpm9w396bLUbh9mOjGL4AnQ7XlCYrX3Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Previous Qualcomm SoCs over the past couple years have used the Arm DSU
architecture, which basically unified the meaning of the "cluster" and
"system". This is however clearly not the case on X1E, as can be seen
by three separate cluster power domains.

Add the lacking system-level power domain. For now it's going to be
always-on, as no system-wide idle states are defined at the moment.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6f75fc342ceb..fc164b9b3ef1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -395,16 +395,24 @@ CPU_PD11: power-domain-cpu11 {
 		CLUSTER_PD0: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
+			power-domains = <&SYSTEM_PD>;
 		};
 
 		CLUSTER_PD1: power-domain-cpu-cluster1 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
+			power-domains = <&SYSTEM_PD>;
 		};
 
 		CLUSTER_PD2: power-domain-cpu-cluster2 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
+			power-domains = <&SYSTEM_PD>;
+		};
+
+		SYSTEM_PD: power-domain-system {
+			#power-domain-cells = <0>;
+			/* TODO: system-wide idle states */
 		};
 	};
 

-- 
2.43.0


