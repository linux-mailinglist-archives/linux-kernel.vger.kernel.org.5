Return-Path: <linux-kernel+bounces-105921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F887E66B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828902817BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD92CCD5;
	Mon, 18 Mar 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEwoP8QH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222F36103
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755523; cv=none; b=ME4VHr+SvG+wd7JdVx3XlkNbPFejW9YNLl+QU6DiXYQdFcEQLXy4dRc0JasNEVOjeBLg38uHmIYxy9pGPjhDYkoAEiHozEgh5voXIrOezOwVjkyS6qmc2g26lvT81tuZfaol5o6kafAfpRwgJ7rPrHqPe0X+CSnhIxJ2Yyx0vwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755523; c=relaxed/simple;
	bh=85uE+8Fjpwsh2LnNpzvvU1BMuhBy7A4cC4byHgOBI8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhCQAGcvYdpgfgmTuRy3PyqYcdYUNwSZOpmHP1Yhgt2WECx1FRfAK7ibITnnQrTTOrtgtQM3lb8eHOL2+q7PIDFyskr4vrdZ3Ad4E1RM3Oje281cxvaOIhiIk7I5gOGbHuLyC/N2W8U3oRM0oXAvH8JQKG9RmZToj2fFSAXRXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEwoP8QH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41413f7b2dfso1995735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710755519; x=1711360319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6M3ghle38laAzVYOE7o4DnWpg3uW1ezRM+qkQnAMfs=;
        b=zEwoP8QHoSFF5ARRHt9ShuOigIKhdKHQNgZ3Pl8KmDUB2CQAbc2y5fM8ogl0egkGro
         RMZa0LeIxFdQdAp1GQNsnLpLNE3tt5UTXQ1p/ojbOY3GsIvnrR5AuJaJul2ig18XRQGT
         qeI2/M6XTNMRictAENaR6XVj1w6XDj9IRKd/h4bQZEs5kq34mWwnF83pNBgKvFTFpinw
         pIx2IgylQfTnUXzLvAWIPQtkrqSGUpHYyXG1IJdM7CwIQGoyKkdQ2r8vDhY2gcAMQikl
         O5Di1N9wfV9sje1bAGT2JK+hJFCpbSWHcJoksYq738quQYiMi1r7lDkW0H2xVZMBQJ+n
         4rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755519; x=1711360319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6M3ghle38laAzVYOE7o4DnWpg3uW1ezRM+qkQnAMfs=;
        b=uCfDtbBu2kH3qH6FV8PGjVjefEmFxNuBzgNIa88elkx3bUuq2ZapOaSzCMnWMq+hUv
         iynbDp80/FyGO61v5sqauHoFysdCvrW2xZD5Y7qytHMtd8pf/JWxKrf9owRaLZFGJkQp
         s7MV7CZmbD4hYuYotG7VyElhNcCGIA53fNEAR3+0GuVbuXrvVhE6jCFYownx+TYCXlT4
         832ji3ZJnb9tOYOvZol1lxN7HvJQCQBZ8P2si/93xaRGsbK3PmSpIx5XBXv4xr2HWMDO
         r1ayb8P+t7LChRoSMXuqPiIEoxSRuB/aOSy1ayBQU8TZRXk/uKUy3tdFP8eSwl1mdxuc
         3K2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmBUBHwYTJ2KqTVCcZt576NbXkeawIJ/xe2z9VNVkJBnCdXTyWLCxzsTkAqivByuFHejkSIUxZeJ70+nrJTqVds0csIH9AnQmSBfHy
X-Gm-Message-State: AOJu0Yxx3CvGoPo9NpYroJATsFbJTJgCREtOMGbW69qFfzvU2yYY30Pq
	bdDXZzhGq53dkNAsiH1nipNIzcnOKnV9/5+oWZeyZQV2Ht9C2+zbKUUQK0+h7NE=
X-Google-Smtp-Source: AGHT+IF2HI/BmNF35Zi08UFOkoo17dDCo4BOu3n3+i5NQ8yjI0vs6MLB+m7l/e0pkXjiCZzUoZo6Gw==
X-Received: by 2002:a05:600c:1c84:b0:413:ff10:cee with SMTP id k4-20020a05600c1c8400b00413ff100ceemr7060485wms.13.1710755519463;
        Mon, 18 Mar 2024 02:51:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bq22-20020a5d5a16000000b0033ebf702e17sm7514974wrb.21.2024.03.18.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:51:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Mar 2024 10:51:55 +0100
Subject: [PATCH v2 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-topic-sm8650-upstream-hdk-v2-3-b63a5d45a784@linaro.org>
References: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
In-Reply-To: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=85uE+8Fjpwsh2LnNpzvvU1BMuhBy7A4cC4byHgOBI8E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+A67Qvv0BipxV7Cdf1iVbpyb2Mx7NR7Mj3zB5Ucw
 wAeqx2iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfgOuwAKCRB33NvayMhJ0fH5EA
 CGi8RYv4ROo3RqL7N5IgqFCgSuVqYHWsRxC6frOyptndxIMwbO9egwHe5T36N9aV5uJPJs6W+ArGKk
 E7X7AA2TDGi7LrjSNa4xkzWYpV+1AR5vS2Xq+rnLyLEcS/RA5rN+tNBI4MhKRCRmRF/aRLCIjNJTHf
 EEaAOqPhUnfYmDMowiJITIby2AJ0sAr6f0pPnAZDQPCq6V/IuJ/G7NFC6lPbL1TkGh7XZFnGIPpLz/
 5LU5Ms/Iixkh0pThxrbTB8d/+QkQRZsDfxNxllxtdIfPWlcdPPezsNR5Otv0q/GtdUM3vAHGLcLpIX
 QoVPBzKwh5R58TLdx0FtRZH9FdOqMxuUySxP7j61gbg5QpU7u1w3yrWFPwpuYKoBRDWMhJOIg0QHqR
 ILDM+t9Zh08/Hd3CQJ83lLxueGQzUWUpAkx9R0pSntSJ4Mamt/bA1Xnjwj4p4aqPiXhdsACfPVKLwp
 uRGlmk2BemadYKzBbIY8/4h8hoRHtG/5rhwekcXEF1g3tJHlyGE6N1Ws/ah66fA2AnGlPJkAFS0M92
 QsTuWZHpe0VmVag5RUH3M7fcsQfHI0Kv5oxvwndlyUGJvcbp+NU9iFExNrw1qZhsqQnXGjLD4BUd20
 A8T4sLCQyJZK3hhqD7ofv+VgenGLLt6oPibumucQ5bKkNrb1iUjAVNunP2BA==
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
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 144 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4f48c98451de..566997db4b37 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -241,6 +241,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
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


