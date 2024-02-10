Return-Path: <linux-kernel+bounces-60417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FE8504A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E5CB2259E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A254BC7;
	Sat, 10 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="tprhgBs2"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA32EAF9;
	Sat, 10 Feb 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574409; cv=none; b=mOe8YsWOhFr9/5F4AxKOEb2FOsAlmH+LnkP10OCmheZY889iFhT07ux7Ux6BsXm3wbA+XS3tO2MhYuacfFIIuu2HYv65TNYut5z4fFEWcIcHgnvXTnVTEcjXySs4M4mB/HDrnazKNxl8W4XhAmPhZ9JAqNIONB/cGF0tLEt8wKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574409; c=relaxed/simple;
	bh=SOuiAaTminz1gLPKRkeSmkVX3LceNMBXyHg/izx49aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQDfWenSys18vnNsi9OPSIVf//OJrIRhfNrGFeIeSCEnWXsH4DV4h6x5C37e978G5CMj5+PBVmyfyLnHAhNsThrK1QzIsVoDmfayhSNqUk78fsaBiShFAFVAConAAR/Ioea7QE+F+oGyUNeBDnZC/+/gh52RngiuXFBTAWD0HRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=tprhgBs2; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707574399; bh=SOuiAaTminz1gLPKRkeSmkVX3LceNMBXyHg/izx49aA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=tprhgBs2u875B9RG4aWfatvOHD5uY4851Ks4f7LKiPW+EeOthQRShpLVsF9k/0v3Z
	 +sr+pequBXGuxdr+jM8axRUPbviBvlUSQgCrTfuhp1VhjE3qPinjcyxc6X/n4csbmH
	 k3j/7PjESI91bokDAxGaFHGQbmmKjehw1iTX+Qog=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 15:12:55 +0100
Subject: [PATCH 1/3] dt-bindings: power: rpmpd: Add MSM8974 power domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v1-1-de9355e6842a@z3ntu.xyz>
References: <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
In-Reply-To: <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=SOuiAaTminz1gLPKRkeSmkVX3LceNMBXyHg/izx49aA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx4R7sRlAuPvwy1H9+FS8pkYR0uNizYT9Ju7TL
 2zRmmpZoCCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZceEewAKCRBy2EO4nU3X
 VmhHEADHZiRtUwwhiEbpZqGJsra9PNWBLJloSI74eKv7q4eoZbNUgj3aI3xmYh2LWVvw+naxSiO
 6arYiOvNTS2YRMkOV9gATOOUKqdvp791JzUEESHE3aXWi0DOu2022Y7i44ayvjw2ytUadwhr5Kp
 ipUU81CRyHiIrVwHQekr5YBPo+YOlw2GkPCBn70GmmA0apm1iAR6cpUzj7NQW5zeXtrM5RdKuST
 67Z/8PhSNlGuCsqT3M5/PdEAP1CLqRVTaL8EWYYCp8TVW9GNR7qMN9HkguNd+MqmFU0cwNGPrbE
 xQOeiwR+ud7YXgv3mJfehxCAvpIW4prXi/ZnJG1/iTPKtJfP2gov5HK4Aln9Ze8X5jCm8OeKEVl
 erZ1L0jEaYSCTsmIZSrrRWpKcINFiOAsVj8PhmPkOZMMOXwdDwXmvfX5pNvyoilkF4qYuPelqoe
 FMM7zomHTFr/+sbsehNx2dNVbscw9Dw95CJUNDVto91A3cZFLE8Bigz+Pbs1Z8tdsZTwWoRZDQF
 FqxhiyHR+gI6g9b2w5aCP4eKdHnuyyDVlznpnU8KeNNDAHwhyInqsOXdq3sC9vxCODRPR2W42w9
 Cm0u0Zd3fuqB8033chY4a8BVuYerjZ4SdpmvXCTdcHukmhCNoi5NurxpKgSDAw1H/9+cSLxZTRP
 y/jF7jHrh7uT16A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatibles and indexes for the rpmpd in MSM8974, both with the
standard PM8841+PM8941 PMICs but also devices found with PMA8084.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
 include/dt-bindings/power/qcom-rpmpd.h                  | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 2ff246cf8b81..929b7ef9c1bc 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -24,6 +24,8 @@ properties:
           - qcom,msm8917-rpmpd
           - qcom,msm8939-rpmpd
           - qcom,msm8953-rpmpd
+          - qcom,msm8974-rpmpd
+          - qcom,msm8974pro-pma8084-rpmpd
           - qcom,msm8976-rpmpd
           - qcom,msm8994-rpmpd
           - qcom,msm8996-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 7f4e2983a4c5..9f0fe60ba745 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -308,6 +308,14 @@
 #define MSM8953_VDDMX		5
 #define MSM8953_VDDMX_AO	6
 
+/* MSM8974 Power Domain Indexes */
+#define MSM8974_VDDCX		0
+#define MSM8974_VDDCX_AO	1
+#define MSM8974_VDDCX_VFC	2
+#define MSM8974_VDDGFX		3
+#define MSM8974_VDDGFX_AO	4
+#define MSM8974_VDDGFX_VFC	5
+
 /* MSM8976 Power Domain Indexes */
 #define MSM8976_VDDCX		0
 #define MSM8976_VDDCX_AO	1

-- 
2.43.0


