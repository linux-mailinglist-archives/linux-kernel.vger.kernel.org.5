Return-Path: <linux-kernel+bounces-31999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D783551E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE3A282465
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A7364C7;
	Sun, 21 Jan 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="pEEvcWQ0"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DD364B6;
	Sun, 21 Jan 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832244; cv=none; b=bhLAiVDj06XLqEEesfYZh+nXYwWOE5aCj2gjvdIFuwwr5kymYRiaX48kof8YixcYW9VkeBaLuxuFqQZg7sOf/xNojMKBMXj08DqSsGutiHVXNUTg4qYfLIj0H8yEm6jL0W6dODGNPK4ko6/2Tb0pXviDP276h7dwARkz0l5dAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832244; c=relaxed/simple;
	bh=YHbqyJQreQjpIdCv/xdB+UMZpHf7pPSdmQaD4vNzeBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cWM/2b038OhMdRMnsf67zuIyydcAbllOCbyWUTcD/IkeBuqjhuBgI7Hs35mJOITuF30mM9ciQenALcdacE1vyk5tt6RaPS1YkZUb+iVUn5vd7xPcX5z9fPkeOTB9n9Y9sFckProNofcCqz2wDiFoWy3ZvAo2HFfNMSSpPJoxykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=pEEvcWQ0; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705831806; bh=YHbqyJQreQjpIdCv/xdB+UMZpHf7pPSdmQaD4vNzeBA=;
	h=From:Date:Subject:To:Cc;
	b=pEEvcWQ0E/38SrPQxa2kg/YMC8CPJLNEy8137/gY5/B8ftmvxf+p+30kYj7UMF06z
	 Wnl5tU1NFnj5JYxAV8UQhBrqkwK72TRMExvuEQOlJP4yaMGtSV8KW6iyCQwVxAcXJG
	 Z65Owww+ohDe8AXK8qBL+u62OdQfKmO6qvbSupwA=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 21 Jan 2024 11:09:57 +0100
Subject: [PATCH] ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-lenok-vibrator-v1-1-d4703ff92021@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAHTtrGUC/x3MQQqAIBBA0avIrBPUiqCrRAutqYZCYwwJxLsnL
 d/i/wwRmTDCKDIwJooUfIVuBCyH9TtKWqvBKNMpbbS80IdTJnJsn8Bywd7poe3QOAc1uhk3ev/
 hNJfyAUe/To5gAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=YHbqyJQreQjpIdCv/xdB+UMZpHf7pPSdmQaD4vNzeBA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlrO18EiJJig9UpXbiC3yfijE5aygqcYrIK8vaD
 xMsS4m6bzKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZaztfAAKCRBy2EO4nU3X
 VuHjEADNf2NzYoxBnK25D6x/G2Z7NaVDjP9tGA1LOgRSI5mo1PG9N1DBiQOM6Ik5O8ccRYCTHjd
 B6sTzY3CFQAM62MuA7K5LhiyhKj22o9FiT1Gf0x3onrgkZr8rw1HzQjlh8kdSjUMyCFHwAne4/H
 nh/mO2zyeVhMCp1QcbdEErEWZmYcVNsXuNG2Y2aHlxjxzM7TxYx1K9qk5XxVNxYsHKwufpYcxGe
 HKjuf0QSAd96t6zztZvXKlb+SqRnqDn6eyYIwTsdvCRasD7WBhU9gqUdzRD/VYJFHjJyKANCVaX
 biAYzmUmAdzUAUZxcOvxznN76Oz5xjHbAQncq8UOic2/Z/ctiIVSApu7gcCWJiIFQ7osM50IY65
 V9BvhdfqwwRjigE0B5Xs/lJ17ersRAkL/RhLd73D268buSdflswNu+kInFKy15d580AKDdzOFZo
 FyTSS6Z+rx8x3Ej/q0RU3njP+Lsi2qgQN187My3q47VbMYUtvfhd73FUhjHSagEEUUZl/Ek0E6v
 2wwrOuLlongpMRQ4ZXynvWn15rLlpoXDxbVg2QMsORoc6zHTOpjqu+TFMpkHrysHFOlj4Di1vx0
 OH5KvKzS/ydFhb1VjljYkL7s2mZdlB+6H8ye+fRHTwjtltZavJXAqtq0eoQxgW4izrTBJpUssJE
 FWTnEHeDxjnILqA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

This device has a vibrator attached to the CAMSS_GP0_CLK, use clk-pwm
and pwm-vibrator to make the vibrator work.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
index 0a1fd5eb3c6d..a70de21bf139 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
@@ -7,6 +7,7 @@
 
 #include "qcom-msm8226.dtsi"
 #include "pm8226.dtsi"
+#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
 
 /delete-node/ &adsp_region;
 
@@ -56,6 +57,29 @@ vreg_wlan: wlan-regulator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wlan_regulator_default_state>;
 	};
+
+	pwm_vibrator: pwm {
+		compatible = "clk-pwm";
+		clocks = <&mmcc CAMSS_GP0_CLK>;
+
+		pinctrl-0 = <&vibrator_clk_default_state>;
+		pinctrl-names = "default";
+
+		#pwm-cells = <2>;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+
+		pwms = <&pwm_vibrator 0 10000>;
+		pwm-names = "enable";
+
+		vcc-supply = <&pm8226_l28>;
+		enable-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&vibrator_en_default_state>;
+		pinctrl-names = "default";
+	};
 };
 
 &adsp {
@@ -330,6 +354,20 @@ reset-pins {
 		};
 	};
 
+	vibrator_clk_default_state: vibrator-clk-default-state {
+		pins = "gpio33";
+		function = "gp0_clk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	vibrator_en_default_state: vibrator-en-default-state {
+		pins = "gpio62";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	wlan_hostwake_default_state: wlan-hostwake-default-state {
 		pins = "gpio37";
 		function = "gpio";

---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240121-lenok-vibrator-ce5b1734e2bb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


