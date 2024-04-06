Return-Path: <linux-kernel+bounces-133978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EF89ABAB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0FA1F2189A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662933A26E;
	Sat,  6 Apr 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Cbk3VbJJ"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC4E546;
	Sat,  6 Apr 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417782; cv=none; b=At671IaoY6ieu5AyWegTfK/79RPpDfzLDT6xpTTlWuNEcWoNKLTxotkmegoDAqSdEKxbDG+mhGMV7T2Esca0DQBZuHrc9cj8X4tUeNiiu5/L8muDRXrN/bnm3/XRCL1ZWofq0qdKMGUTI3id3z8RGDUbehZzFkYHfTXmyFjI9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417782; c=relaxed/simple;
	bh=FiIAzc8smXeDB0uMdDOcov99hXTLdRr90r37SjHtqig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Of5l2ZMICgfpK/FY8NG4D5nevAkzKKf2vryZKjH3/8dEaeBfCJ1Ad2wR1Yao7g91mEpxokxQVUHG9LhjtTcXhpXSQdeFUPMesPKehgbETyCJSs59T9BeTKGmubywfzjxBVe3p5SMftxre9Bty5NHLPrft3zaKPTU5UYMNR/yqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Cbk3VbJJ; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712417248; bh=FiIAzc8smXeDB0uMdDOcov99hXTLdRr90r37SjHtqig=;
	h=From:Date:Subject:To:Cc;
	b=Cbk3VbJJb9c1v9GY9J6bL9kWRnlMKC/68N5PwjGszKVOAKwaAiLAO28mHo+mONfSt
	 08PIRBwpp/faY7FsHEgnH0BESlxo8aOlqJu/YhAlZx4qXdHIC5V7RYO4p64ba+kZ1Q
	 sRYai9VKSO6tVUtTbXZj8hgZ5mlzjh2BgQLcrwmg=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 06 Apr 2024 17:27:20 +0200
Subject: [PATCH] ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-shinano-vib-v1-1-fdd02af39d56@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIANdpEWYC/x3MTQqAIBBA4avIrBswkf6uEi3UppyNhoIE4t2Tl
 t/ivQqZElOGTVRIVDhzDB3jIMB5E25CPrtBSaWllhNmz8GEiIUtLpLUTKs1VjnoxZPo4ve/7Ud
 rH3OqLf5dAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FiIAzc8smXeDB0uMdDOcov99hXTLdRr90r37SjHtqig=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEWncUxbgDQW6FpzEsC0Wmm6DPek0lWq9RIyML
 p+PMUVtaeqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhFp3AAKCRBy2EO4nU3X
 VjHGEACBBilB9K3nFDtiKW50oKDhrFQ962KPQJwaLlT8/cWcuKF/80FlD0LbzBxerZEuG97XFMX
 9PxMRQYpofEEYsNXtG/1KwXYx9U8faogyHVpuI3W3xeKUtby5YjW8fOYew480ON6aqtoeYlL84k
 +XZu2EaC5mhemCh+JKl/kGQGvknJ6toyy+zSU3WUAunhV/oQ6Ph2Pe3MDCygJVQSQBY8U0oNjyL
 cS29rfpIk000i6vD5yxeonDLrm5sVXYv5qlbjJwbzX8MydPkbS+53B4ls/UhUCqgzysiO19ZM2H
 Vr943Wkn6Al2V6mmQuXlwd/h8sE6lLUVpdpOTFLzIyjqU1/umvVd7jSLB3+P+Rjik95mO36/HvB
 sNHuvDXk+RGJln44gpq362/FWeK1dqQqDQ5NLxB14x0tM8rWHVO1Ju4Bpnjz7WJKIa5Y0WXtPGI
 +God+6f2IMgV39zfwPJcQaLW9JQsRFYlM+HJ5ABokky2Qp6NuccDj0DTYPcXBU4s/ZNi6qmmalL
 xqPMJ7kEVRfE15LKRBgSXAyiJ/Za2zYquhzDWiBd2Jt2xaNDiiPpvJDhgA1j8AOW5Hr/r10Y1++
 e3jOarTcKf7ciRQnOxGlnDq0s4q9fi6gIpR93D4gFaO8UPgTRemrPXQiC01lmORXJdI9AoeQYM+
 1VwtWICIApt1SjA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Enable the vibrator connected to PM8941 found on the Sony shinano
platform.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
index 3a0c0035de09..e129bb1bd6ec 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
@@ -202,6 +202,10 @@ led@7 {
 	};
 };
 
+&pm8941_vib {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	cx-supply = <&pm8841_s2>;
 	status = "okay";

---
base-commit: 956abeb75f90eac3d5ba1f4cff7c048f7c079502
change-id: 20240406-shinano-vib-80e27e9bab2c

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


