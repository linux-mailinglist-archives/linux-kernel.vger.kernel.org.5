Return-Path: <linux-kernel+bounces-157199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3588B0E61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D3C1F22135
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8916D4EE;
	Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoVYSUR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A371607A2;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972571; cv=none; b=LG6uAx9NOgdolO09XDEVrE3SRDtyA64eJUw0wclu3zyeLPtoczy3tTIgkqRiyk4PiicoPwkHMOeBG+deIgS7jrTkoqV4SDxEHH2uY7jB2p3lW4ygQx3vWs62jRWPUP/AoAIIV4FO8TgmoRjbAWgPxCaL/Vq4w5rFVY7xuvtqF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972571; c=relaxed/simple;
	bh=XXEfSL+a21s070Hd5m+I1ksA0AW6VTvOpydm+lrklMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1mat6B6h3h8vCY7TxNNUBVzCCqQjx416wFkkmkaNyshuZq/juV1/UYzXv9pXR9W2FTM3ZFieB+tfW3MAB9SPxF0SCMXeVcXJiBO3TTim86eMbqu0DuuOtntK0i1Ib1LNtwviMzh2yHiy89OT13Rt95oBYs9uJy+NckLEH645zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoVYSUR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DA47C4AF55;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972570;
	bh=XXEfSL+a21s070Hd5m+I1ksA0AW6VTvOpydm+lrklMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hoVYSUR9x00FV3kz7ePqckZGysuGEpKR7OaekEBgmRKlYOVMOpFu5ZaSWoUqdohb1
	 TcHl6g+QVeOHlN1SLbg+i+ifaNjtUcK9vkmthZCuu7YXlL4hX7BfTNOttBaWaF0czF
	 a5cvE9JtWdDr78C8I74RWTDKxyVWEngTqxX0O3Kz2c+CDcnaLuhfk6VBeArSmhUbYi
	 9yVrrsMgmo++EAHRrKNe8JFMn2FzC8IcEkYaIkZlYRIwM8z263jG/eIaWIwbPpSv+3
	 bNdwX/QeqciLpYh7a1i8/yImwpqV+Xm+UlKFjf/GFcOKAUSTMkWa6dJkQdcW1r05S5
	 iaMs6kFQwXGag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83630C07E8E;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Wed, 24 Apr 2024 23:29:12 +0800
Subject: [PATCH 07/10] arm64: dts: qcom: sm8550: Update EAS properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ayn-odin2-initial-v1-7-e0aa05c991fd@gmail.com>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Molly Sophia <mollysophia379@gmail.com>, Junhao Xie <bigfoot@classfun.cn>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713972563; l=6912;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=eJdsjG3Ujl+JaIzyIaW0tLBoLUPuJTGlhV/s1VJPzzY=;
 b=fxx1evrD1+3dEvUHC+b13Y34IhR9IOYveFQsTNidPvGjFTP/Fj5LEY/SVF6xGs8oj4PFvfm4v
 6jDAU9Scfb1BNIvSc81K9KQbtGlJxRF1cAWELGmF4/SEyvjh8P/cE/s
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

The original values provided by Qualcomm appear to be quite
inaccurate. Specifically, some heavy gaming tasks could be
improperly assigned to the A510 cores by the scheduler, resulting
in a CPU bottleneck. This update to the EAS properties aims to
enhance the user experience across various scenarios.

The power numbers were obtained using a Type-C power meter, which
was directly connected to the battery connector on the AYN Odin 2
motherboard, acting as a fake battery.

It should be noted that the A715 cores seem less efficient than the
A710 cores. Therefore, an average value has been assigned to them,
considering that the A715 and A710 cores share a single cpufreq
domain.

Cortex-A510 cores:
441 kHz, 564 mV, 43 mW, 350 Cx
556 kHz, 580 mV, 59 mW, 346 Cx
672 kHz, 592 mV, 71 mW, 312 Cx
787 kHz, 604 mV, 83 mW, 290 Cx
902 kHz, 608 mV, 96 mW, 288 Cx
1017 kHz, 624 mV, 107 mW, 264 Cx
1113 kHz, 636 mV, 117 mW, 252 Cx
1228 kHz, 652 mV, 130 mW, 240 Cx
1344 kHz, 668 mV, 146 mW, 235 Cx
1459 kHz, 688 mV, 155 mW, 214 Cx
1555 kHz, 704 mV, 166 mW, 205 Cx
1670 kHz, 724 mV, 178 mW, 192 Cx
1785 kHz, 744 mV, 197 mW, 189 Cx
1900 kHz, 764 mV, 221 mW, 190 Cx
2016 kHz, 784 mV, 243 mW, 188 Cx
Your dynamic-power-coefficient for cpu 1: 251

Cortex-A715 cores:
614 kHz, 572 mV, 97 mW, 470 Cx
729 kHz, 592 mV, 123 mW, 473 Cx
844 kHz, 608 mV, 152 mW, 486 Cx
940 kHz, 624 mV, 178 mW, 485 Cx
1056 kHz, 644 mV, 207 mW, 465 Cx
1171 kHz, 656 mV, 243 mW, 480 Cx
1286 kHz, 672 mV, 271 mW, 459 Cx
1401 kHz, 692 mV, 310 mW, 454 Cx
1536 kHz, 716 mV, 368 mW, 462 Cx
1651 kHz, 740 mV, 416 mW, 454 Cx
1785 kHz, 760 mV, 492 mW, 475 Cx
1920 kHz, 784 mV, 544 mW, 457 Cx
2054 kHz, 804 mV, 613 mW, 458 Cx
2188 kHz, 828 mV, 702 mW, 465 Cx
2323 kHz, 852 mV, 782 mW, 461 Cx
2457 kHz, 876 mV, 895 mW, 473 Cx
2592 kHz, 896 mV, 1020 mW, 490 Cx
2707 kHz, 920 mV, 1140 mW, 498 Cx
2803 kHz, 940 mV, 1215 mW, 490 Cx
Your dynamic-power-coefficient for cpu 3: 472

Cortex-A710 cores:
614 kHz, 572 mV, 91 mW, 388 Cx
729 kHz, 592 mV, 116 mW, 424 Cx
844 kHz, 608 mV, 143 mW, 443 Cx
940 kHz, 624 mV, 165 mW, 434 Cx
1056 kHz, 644 mV, 195 mW, 430 Cx
1171 kHz, 656 mV, 218 mW, 414 Cx
1286 kHz, 672 mV, 250 mW, 415 Cx
1401 kHz, 692 mV, 286 mW, 412 Cx
1536 kHz, 716 mV, 331 mW, 407 Cx
1651 kHz, 740 mV, 374 mW, 401 Cx
1785 kHz, 760 mV, 439 mW, 417 Cx
1920 kHz, 784 mV, 495 mW, 411 Cx
2054 kHz, 804 mV, 557 mW, 412 Cx
2188 kHz, 828 mV, 632 mW, 415 Cx
2323 kHz, 852 mV, 721 mW, 422 Cx
2457 kHz, 876 mV, 813 mW, 427 Cx
2592 kHz, 896 mV, 912 mW, 435 Cx
2707 kHz, 920 mV, 1019 mW, 442 Cx
2803 kHz, 940 mV, 1087 mW, 436 Cx
Your dynamic-power-coefficient for cpu 5: 421

Cortex-X3 core:
729 kHz, 568 mV, 252 mW, 1110 Cx
864 kHz, 580 mV, 312 mW, 1097 Cx
998 kHz, 592 mV, 379 mW, 1109 Cx
1132 kHz, 608 mV, 453 mW, 1099 Cx
1248 kHz, 624 mV, 517 mW, 1067 Cx
1363 kHz, 636 mV, 587 mW, 1067 Cx
1478 kHz, 648 mV, 657 mW, 1058 Cx
1593 kHz, 664 mV, 739 mW, 1049 Cx
1708 kHz, 680 mV, 813 mW, 1020 Cx
1843 kHz, 704 mV, 940 mW, 1021 Cx
1977 kHz, 724 mV, 1054 mW, 1007 Cx
2092 kHz, 740 mV, 1201 mW, 1045 Cx
2227 kHz, 768 mV, 1358 mW, 1029 Cx
2342 kHz, 788 mV, 1486 mW, 1016 Cx
2476 kHz, 812 mV, 1711 mW, 1046 Cx
2592 kHz, 836 mV, 1846 mW, 1014 Cx
2726 kHz, 856 mV, 2046 mW, 1020 Cx
2841 kHz, 880 mV, 2266 mW, 1027 Cx
2956 kHz, 908 mV, 2616 mW, 1074 Cx
3187 kHz, 956 mV, 3326 mW, 1147 Cx
Your dynamic-power-coefficient for cpu 7: 1057

7-zip benchmark single-core MIPS:
2128   4416   4632   6686

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index b8bbe88e770f..a84dd7f6ebc1 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -79,8 +79,8 @@ CPU0: cpu@0 {
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			capacity-dmips-mhz = <1024>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <326>;
+			dynamic-power-coefficient = <251>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -105,8 +105,8 @@ CPU1: cpu@100 {
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			capacity-dmips-mhz = <1024>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <326>;
+			dynamic-power-coefficient = <251>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -126,8 +126,8 @@ CPU2: cpu@200 {
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			capacity-dmips-mhz = <1024>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <326>;
+			dynamic-power-coefficient = <251>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -147,8 +147,8 @@ CPU3: cpu@300 {
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			capacity-dmips-mhz = <1792>;
-			dynamic-power-coefficient = <270>;
+			capacity-dmips-mhz = <693>;
+			dynamic-power-coefficient = <447>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -168,8 +168,8 @@ CPU4: cpu@400 {
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			capacity-dmips-mhz = <1792>;
-			dynamic-power-coefficient = <270>;
+			capacity-dmips-mhz = <693>;
+			dynamic-power-coefficient = <447>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -189,8 +189,8 @@ CPU5: cpu@500 {
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			capacity-dmips-mhz = <1792>;
-			dynamic-power-coefficient = <270>;
+			capacity-dmips-mhz = <693>;
+			dynamic-power-coefficient = <447>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -210,8 +210,8 @@ CPU6: cpu@600 {
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			capacity-dmips-mhz = <1792>;
-			dynamic-power-coefficient = <270>;
+			capacity-dmips-mhz = <693>;
+			dynamic-power-coefficient = <447>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -231,8 +231,8 @@ CPU7: cpu@700 {
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 2>;
-			capacity-dmips-mhz = <1894>;
-			dynamic-power-coefficient = <588>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <1057>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";

-- 
2.44.0



