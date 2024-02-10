Return-Path: <linux-kernel+bounces-60456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5BB850530
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59831F22302
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91785C8FF;
	Sat, 10 Feb 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="gKs3L7Qm"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5CC5C5E8;
	Sat, 10 Feb 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582598; cv=none; b=QydCBbw6OY9l1DgCrrjMFUtbozQ+47zCdxQ2hIn7+QpEDIEiu/D9NFtkJQbckC5ikI5EHqs0/M+JUNFLjmJgge45dDaITnN+wKpiAhKojOyQFNNimdwD7V/4n5d6hyThF8/vmM26BrAmH16ewgL28CgLWcI27waqb+ADOK8c+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582598; c=relaxed/simple;
	bh=5m1gQLd7uABOATw03ZDp49YqHmKbWEYL7MaNLQOW2LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlVgu6frVXankVLO2nRsxbpLJMHF+p8WiWVnaTBPn17EVS9L0kCHSDpzcs9S1MUzo9G9ekNEiRvUA03IQxbYjhsXr9Ge6zIExiNymbYRNH+paPRpLvTQmBh6g0pHQoTLmnmFdKYLk21Wzv2uLSam6r+3PRYZj6UA86+FWBoNcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=gKs3L7Qm; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707582594; bh=5m1gQLd7uABOATw03ZDp49YqHmKbWEYL7MaNLQOW2LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gKs3L7Qmb+7nfC+0juPS3NxX8OPbkMP1D5WUHg/M1hikKvFv99yUDMZAvCSQNiKXU
	 IEjTE9gqrNN1XI8ghGS7QsxyP2qdx9WeLhtgpm7Z+p2+ZAO2ChrheTRwl9MbDkbfWj
	 dDqvSNXus4a6a8y824gyFdSq5qEb/MQxTwR3iUNY=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:28:54 +0100
Subject: [PATCH v2 3/3] ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8226-cpu-v2-3-5d9cb4c35204@z3ntu.xyz>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
In-Reply-To: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=x8JuvX/IKrTAF+OKwnd8Abogn/7OVQEBDL8aa2HYyRY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6R/fpwkBk7PqSEx/egA+dhAVruxFjMAYds4P
 f0Ct/QoFoGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcekfwAKCRBy2EO4nU3X
 ViIFD/46Yc5EU1w9TpnVZPClDY4W2UGU7l69ASa7I5rIJu+/5OwLnqhlcQ5eQtoyxgcC8eycFqg
 jmXHq8BvcG8QaTjeGO5UH9+2k6yfUN8uIXUmNjQpL7twM1AKgLc968hJx/2IRzTyftiVpUyC2H6
 wVmDeSDCbgfRU7Pk7i9bVeNW8swPpqOdzURQ5vxzFrDQosWxleaJ3d1c47b+oImIggEeyDot9+e
 39yVheq9YRPQ9C05WCaJch+U/A12GN4LqkIf6gA/ktY5o7o3sJaL/fY1Ez4SPWVSugzdZ0B3pam
 Vt7dzS+RML/XJ9Sq16dqt2m4Q7T1tJXs3a/C/NPkbr+vlyIcNV1mDEkksmQrs+0u5KuFQVd7QWS
 5r6Xb9OinywMwyKVIL64R5puUZfCmjrL4cvSE6Z/E0orIPBHFq9mHi/eEqXYApu+idwSOzUlX43
 buAh3db6rJzXC8FvU3kK6QxIAsIpdJ8pW8aetCdBLombDLIO7WKRHmWTzsHtpTbb+6i6GDMpNmw
 oMJ1G+Z/DopJlMWHphKxRJgopeI9ydJPo7JcUttJfT7j7gAmFAX9/yTn56NR0M2SATRV5iG0/LH
 S6C+mFAv6TIevm3xvIg5XvA3l8qQ1ET9J9oH7J39eKwEnHsNhdp5eLqaW796X+hKIBZe+DZGsL0
 qFQxYitjx1yoyJQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

Add CPU and SAW/ACC nodes to enable SMP on MSM8226.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
[luca: update some nodes to fix dtbs_check errors, reorder, cleanup]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 96 ++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 6896318e6612..8fae6058bf58 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -34,6 +34,57 @@ sleep_clk: sleep_clk {
 		};
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			compatible = "arm,cortex-a7";
+			enable-method = "qcom,msm8226-smp";
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc0>;
+			qcom,saw = <&saw0>;
+		};
+
+		CPU1: cpu@1 {
+			compatible = "arm,cortex-a7";
+			enable-method = "qcom,msm8226-smp";
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc1>;
+			qcom,saw = <&saw1>;
+		};
+
+		CPU2: cpu@2 {
+			compatible = "arm,cortex-a7";
+			enable-method = "qcom,msm8226-smp";
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc2>;
+			qcom,saw = <&saw2>;
+		};
+
+		CPU3: cpu@3 {
+			compatible = "arm,cortex-a7";
+			enable-method = "qcom,msm8226-smp";
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc3>;
+			qcom,saw = <&saw3>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-msm8226", "qcom,scm";
@@ -185,6 +236,11 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
+		saw_l2: power-manager@f9012000 {
+			compatible = "qcom,msm8226-saw2-v2.1-l2", "qcom,saw2";
+			reg = <0xf9012000 0x1000>;
+		};
+
 		timer@f9020000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0xf9020000 0x1000>;
@@ -243,6 +299,46 @@ frame@f9028000 {
 			};
 		};
 
+		acc0: power-manager@f9088000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
+		};
+
+		saw0: power-manager@f9089000 {
+			compatible = "qcom,msm8226-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf9089000 0x1000>;
+		};
+
+		acc1: power-manager@f9098000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf9098000 0x1000>, <0xf9008000 0x1000>;
+		};
+
+		saw1: power-manager@f9099000 {
+			compatible = "qcom,msm8226-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf9099000 0x1000>;
+		};
+
+		acc2: power-manager@f90a8000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf90a8000 0x1000>, <0xf9008000 0x1000>;
+		};
+
+		saw2: power-manager@f90a9000 {
+			compatible = "qcom,msm8226-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf90a9000 0x1000>;
+		};
+
+		acc3: power-manager@f90b8000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
+		};
+
+		saw3: power-manager@f90b9000 {
+			compatible = "qcom,msm8226-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf90b9000 0x1000>;
+		};
+
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;

-- 
2.43.0


