Return-Path: <linux-kernel+bounces-153012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38808AC791
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B111C20326
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549975647F;
	Mon, 22 Apr 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6iXOjok"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506005380F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775702; cv=none; b=tFkzuvUOePhNgxVJrUsb7SRkvP/DxYF44TwZnks8EGE7sNWI3UIQYn5uw5TF4WES4gblCgH6wjxgcIoMF/Zts9/vfk79qxlIEWO5nPk1at6IewZJR68/fz8OTjkVaQj95/+YsGzhXZz8CRfJvFe7AsAgZC/avX5uHCyOzBcwR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775702; c=relaxed/simple;
	bh=gN5G3PL3Hr0bMcAsUHFgDIUicICjazM+18Se751teb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZg0/WdKI3Jqvkrh1nWbQKz1At5kpO9RrShLdHc2poAr7BQEkvL8ahWPrAF2sTOhGLg7p+dJRhFxEb9wmFYCi2JOXcpGMbmQA5I5T4Ay52lM7e7g13a9KKBoS+rBOagSk9nvQ/oFMUYZ6CijWfb9IYfojtvEwC8P3N0Uu6/6R9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w6iXOjok; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso18028095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713775699; x=1714380499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ornUhS0QRSyp62Es3cf++dbIdn5e8lGz3M/ACkqgRqk=;
        b=w6iXOjokRt1Qrt6OcrdjuVnWvTWUHEuO33M/CKlnSSBDskGse5adze7ywqi8buOEAr
         7m8nFDpGWf3b+lgpKVDYlRYwMpbeKWaRX1QrVhewdUY95Im/MSRpGwO8qkXA4Q7KboeM
         mScimQeiwEvpBbB8SYGkytB+cKyTAkpFgLUzwW6jcNazCnjNTiI33GY8kursGPRWqC/M
         vPIY63kteAn2HMJ6pOOykcm5pAC2fQvtq3zi2gpc28kRrWVwhHuyqEeDcjoMoxA0xUZI
         L1VkeyfIFX1DM5PfIMO4rAm8j6xEDX66ovzJjWMpvsJFr3PM1d+w9/jd0AqefdFyuk9y
         tuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775699; x=1714380499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ornUhS0QRSyp62Es3cf++dbIdn5e8lGz3M/ACkqgRqk=;
        b=sdoC/EFSwOMNCVayg47mDwe7lo9Lua1EFquLOa8wX1pwfpEzrg7ZYhDYeUveil2isR
         kj4uqIlycNoR/x1czHzUepfErh5ChjI9ShySD2mTY2di/Z/olvOiRJSXvvKTB4oaC33H
         2izG7XyCItxw9HJvQtTtE1Ddt+8zASof5+tgLo5DpkWRHJ+MbOtwHYa48QyUPytoXHNN
         jEuvGp1Iho0xqsc9t7ABTdLnBn+ne1uwhMcwa1QnxNO42e2aysqjeZ7iR6jXCbUOF4OM
         4IxtEcuC2gFR0fErZfM/mF7u91xRfcyQtzmEKGJa7XYmWy5uGmFJA2bL3rckPB9ZxAe7
         zP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVDukErpRUi6rAx1wCCkZLNq38mIRffAlGEnqqJEn0OGq6kpVKdKXggfjmxeNNx1XtvVfRTkdxlYKgdTownrlWeBUeQ4ns/nCEHAOfh
X-Gm-Message-State: AOJu0YxvkuZNIdxA2rQxtb/oUF6ZAoHSGt6jpBzV13x7mAbOkuFI+lEK
	gNviHw6O9hfntKGaj+XlwVDeWGwiF1J9q5bN/FGaqXe+sBYY9fadYT+p2fk7xhU=
X-Google-Smtp-Source: AGHT+IHamdEnSo8Y02TdGZzI/Myu5/1P6fATwFe0kVH/aC6LMI9HEPlNIia9+Rbz/KJCjhVJtBxQqQ==
X-Received: by 2002:a05:600c:5403:b0:418:be2e:df9e with SMTP id he3-20020a05600c540300b00418be2edf9emr9023423wmb.41.1713775698350;
        Mon, 22 Apr 2024 01:48:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm15962650wmo.4.2024.04.22.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:48:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 10:48:14 +0200
Subject: [PATCH v4 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8650-upstream-hdk-v4-3-b33993eaa2e8@linaro.org>
References: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
In-Reply-To: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4581;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gN5G3PL3Hr0bMcAsUHFgDIUicICjazM+18Se751teb8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJiROw/anLeQsTKrfcSV5y8hZk82j+BHYlnqs6bst
 ZRoR7aqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYkTgAKCRB33NvayMhJ0RjND/
 43U9dK7zxbQmw39Zk5LIvBdXfeRgIVG60v+5nJiDY3EuoCKynKWYB13HR63RjQVt58/81MYo8K0NZL
 zye11cjvSzc5Xv5T9bYLNGGYNBW8E/Z8wUer1YV6KHP/iFfI1csIhlUA2XxT3hL1RtEQA4rAlnP/j9
 xGIaruuZvlAPmPkUbYsiVnfSNB9QrXNqynGxbJJg7HrvTlbqn8G+ylSjd9RZkdnLJat+TmcovL1xI0
 XJ0v+8XuYCdkoR0EUsNuRFE5ZqpKHwEvwm/MYlzxPQO2Nj+tJLAogLmplpjl72YzgldB024ozTUd0m
 /uYjSCkvEUWfOCwjl5RCbGHe/8WENDJzdHzqKN9c8rw3HHnzdlhrDOjxXjkwE6c1xcsfcE3UXvDvWe
 TCPrGXZT4meoDx5KcYFehSmZ2Itizqs+cO5mmGYRX1uOUPGVRJL5yiFUjVvB0fJpOOe89pyGdf89Kx
 CuUQ4axWH51qzSoCNdH8OulDNVxrnvFKGZ12Wj9wrXQ0d9r+I7PvXwCwhpHGqd7hS5Y+SVxm8gn4eT
 JGwmHg7vG+1CfgR9AVQN9O2MahLwhKD9HmDOUfEvY4+59MTVfs+1Jbmi+DZEKRmT+gsYf6u/GaqJ+e
 s25GY/xFTDpEk/eDBiSmf5cThxgONvhRAkxvxbSrGeGbLh03milMgP5bZ0Uw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

With the SM8650-HDK, a Display Card kit can be connected to provide
a VTDR6130 display with Goodix Berlin Touch controller.

In order to route the DSI lanes to the connector for the Display
Card kit, a switch must be changed on the board.

The HDMI nodes are disabled since the DSI lanes are shared with
the DSI to HDMI transceiver.

Add support for this card as an overlay and apply it it at
build-time to the sm8650-hdk dtb.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 144 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 74e6796eb5eb..640c8fb499fe 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -242,6 +242,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-sony-xperia-yodo-pdx234.dtb
+
+sm8650-hdk-display-card-dtbs	:= sm8650-hdk.dtb sm8650-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
new file mode 100644
index 000000000000..83f2338e5bf4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+/*
+ * Display Card kit overlay
+ * This requires S5702 Switch 7 to be turned to OFF to route DSI0 to the display panel
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+/plugin/;
+
+&i2c6 {
+	status = "disabled";
+};
+
+&lt9611_1v2 {
+	status = "disabled";
+};
+
+&lt9611_3v3 {
+	status = "disabled";
+};
+
+&vreg_bob_3v3 {
+	status = "disabled";
+};
+
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "visionox,vtdr6130";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
+		pinctrl-names = "default", "sleep";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+
+	/*
+	 * DTC requires to have both endpoints when compiling the overlay
+	 * and also requires the #address/size-cells + reg properties
+	 */
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			mdss_dsi0_out: endpoint {
+				remote-endpoint = <&panel0_in>;
+			};
+		};
+	};
+};
+
+&spi4 {
+	/* DTC requires the #address/size-cells to compile DTBO */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "goodix,gt9916";
+		reg = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <162 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 161 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l14b_3p2>;
+
+		spi-max-frequency = <1000000>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2400>;
+
+		pinctrl-0 = <&ts_irq>, <&ts_reset>;
+		pinctrl-names = "default";
+	};
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_irq: ts-irq-state {
+		pins = "gpio161";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-disable;
+	};
+
+	ts_reset: ts-reset-state {
+		pins = "gpio162";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};

-- 
2.34.1


