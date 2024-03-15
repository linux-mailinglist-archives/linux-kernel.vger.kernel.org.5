Return-Path: <linux-kernel+bounces-104470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16EA87CE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A77281F84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC63BB26;
	Fri, 15 Mar 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="ELqiRKgo"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C82C840;
	Fri, 15 Mar 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510719; cv=none; b=jC//6g0a25PK8ZDW9J2lnDQVe7yPAxNri4ajykWWHVG3jfnmx/GVBqLKs7qsxAog1Ufn2HFWsi27js44sxKK3Vp1GLKcS1B+AAAn8lOf6bwkhDSqwj4CaIWTVw+AGfs0h58skbQNwdtzNisJtnUTRk3bw4PhWKg5cd23YPv8El8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510719; c=relaxed/simple;
	bh=jsye4iMlzYgMShc+YE+ty/P6/vvS30GKFX45O2KwmP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhZF20TqTQDPvwJrSoea37HdocVPTkXPyctMMdpT8WCvU5bHVhVDP90FNCmJWLbG7XSV48Hahi7D4kFsYlKQPmseshRrnlaiKt45Ign+krEo4dst4d2Te7TGZ9S88UJsYTgtLIwgTotbiORHjuQkJbQS2UpJUjIuWynfuYLyRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=ELqiRKgo; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 99E7A41EF5;
	Fri, 15 Mar 2024 18:51:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710510699; bh=jsye4iMlzYgMShc+YE+ty/P6/vvS30GKFX45O2KwmP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ELqiRKgoMh/paed6/QeN0DzWJIDDh+sKv7npRojZQQgtjVE0BhAN9mLHyFm1fWOwR
	 hAgBtEEYZwmt878Zv72lE+kEgZxouA5b3vx9kiRP1IYldRorXSqSlUoXgH6eb+CLZZ
	 q/fZNKxASk1bgxksQJ5q+sdvMdh3x39X29WNjuK+6POViHoqprBVZKHS5FUh2ZYB56
	 PoRN2f9dUJ9ErF+8SdUlpHhmlKlu+zeIaY+sl6pn08/BmKapoD2LKqNmT7ky0bH1vy
	 MnPHUuqGwMBamWvhKm7+Yk2gYSVjTcwraDiFnb4QazheBOemld9tv5TlrXJihxF2q1
	 n9I9e2rMZM4uA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 15 Mar 2024 18:51:18 +0500
Subject: [PATCH v5 4/4] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-aspire1-ec-v5-4-f93381deff39@trvn.ru>
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
In-Reply-To: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=jsye4iMlzYgMShc+YE+ty/P6/vvS30GKFX45O2KwmP0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl9FJmccm+Xc7hgj8Q6v+gBqQukTnL3STU+cuEM
 TmuIGHG2jKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfRSZgAKCRBDHOzuKBm/
 dQUAEACD/drXOfIJgA0gly7ofi/bbFZl5eYLRSRa6n5nS4fpElxHHThb/7q51vzHzt14N4SaPYv
 J0PHGX5ekFi7DAuuwoYo0b0ggS5i2BEdwRoHCOBRA0k8bng1gD5wU6z2QopoHd3nTzdZoVn4gxj
 wd0GtFsGcuM7OkstTVKBp3IIdpdsoYpWzrx3YduLDuER9WcftEnIKPV50hFI6LSR1Obv//learC
 ZT4zzaz69ZNuEEOKsM/yBN8ij5KoFDVcr5P4QZoiptRpUlAFKv5GiFf3sXMX42ar4KrP7+8C7VR
 MF8h3RL5kAOIwGXvtdS7gp9G8y2fv3RrtcaVippNj1sMab37kfJYq8A6q4oJTC9fWcwdDYMu7TH
 jwyNboh+2vfW31vShdg9eXnVCDFBPyC1+js3BVi1cvoFBAbLmmUzXTfJQXgB09el7CS9QNaJHdJ
 FgGZycezb38SnqEI6xgc5c9+gleeIRymuY4sNW1c30Ro5hVjYzEbvvUHh8kBypACqPHZ6jeDb5k
 g+6yxF58ridqGqfjUX5w5H0sdMrYmqnEuH3ZE6S+B1fj/n2zner8kHhyFlfhT9bho9BjfnGyZNe
 QZcGDC/ZUwJm/J79TDl007EpgmXcu2NUTvldW0C3InOwqL7IwAnK1rmjfsCB1hbOfek/DjQewVO
 Ox0VsgCJ+GPd6Vw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 5afcb8212f49..3f0d3e33894a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -255,7 +255,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -419,6 +437,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -857,6 +888,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.44.0


