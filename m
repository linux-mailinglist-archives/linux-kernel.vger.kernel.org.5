Return-Path: <linux-kernel+bounces-76684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327CE85FB02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA31C23A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A049146016;
	Thu, 22 Feb 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfGhc2I1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4D14A097
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611596; cv=none; b=nigDOijN/UeW5lIO8gBdzZzxHKty6gnkcBRu8ApPOEIPj+v7XmFq0jhsmFdUatOtL1SUET4iRZs99a+vaBXfvo+WPXEm/Mcb5zrDXjwa7SaOZY8lXSKPjKtM76CH48FZh2PSIzhGDbqIM2wU4+kJQseQBlTG4EaftGEtWVDCMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611596; c=relaxed/simple;
	bh=8svlNz2AM3TX39zt1Mh5SAJo/Xa23Z1D0hrKnS+mZzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orANFbhSJ4myuzQtC/L9zcXMPjSlCo/QSPXMkHCGfBUS4ZupItF88j4tlM/qQwdb8MeLGVY1g/6BE8PB5lFCKELAOc7FPcEVHq25RV8XXKAY1N1S7/t3kFHU8kWpQLcBPWRyp5/1+pombkEBYP+c3Wpzp1G2apSIz8+ZsFNmW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VfGhc2I1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso2153573a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708611583; x=1709216383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNFJtzw1Au24uNAZlkPHp4RYVJ5vQGAsCG8vVXzlObA=;
        b=VfGhc2I1hVTIjT9elOsyD7TI82M848XIuhgwJUdZ3ILk2XJeEpixwVoIC1nhPby226
         nQ+Wv9T0wKxtfy8XhsZa8hfipRKwExCTk3B7poM/80jw34oPYXXHWLAPX9onT3SQVesM
         NTMDUZbD+4zUDKx1zICDx3Z9ClZP1qOUk525TrUOW1y1tK2snMzhg3G/h91nJS0stpS/
         0L+fORGPzDIo6qVGSnfa3YYWm9PfHUufG1Y3TPcbk4cVUJjPK/Yy8KdFj5BtnHClSBz0
         /Rtj1oiTQ7yalyMYkfBdSnf3JLUuaYtaT2MUSst8+S8aXevmGmTki3EzFNPZTl21ACTQ
         TORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611583; x=1709216383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNFJtzw1Au24uNAZlkPHp4RYVJ5vQGAsCG8vVXzlObA=;
        b=AlG6FQ+DCfAwN7LtHIF3IvxQhCVSDbS2BMwzEz9xRnhAVDkxgFO8riPiBs1+u1FJl2
         e13LpAYspgSKfhT4Hd/b7D0mytG9ba+Nd2j+3T9bAbJ4BbvREGGTy+4qQ0CXRRAOj3Mb
         KGwtrceZCNfyBUSbfPMl/naXig8V8TG34ae29wYannMjOfK84akSm3/LbugMOar/HwqG
         Mx8Y6FZhdaEo5Cos3ur+d+uJFHCSImrCdfYP8J4SZUZJequD5ofnur42cxOSe3NHHbL7
         sFjoFY5zxp1TgB+4Sy3SeiR/6h3god26oAlW+tQ8uvQXR/dQj5HpVHByv4brN9hwCew7
         +psw==
X-Forwarded-Encrypted: i=1; AJvYcCWZACx3TIWq/+5KZFcGM+pEvp2p4LfSFg5NrLS12h4jr8RSCf6JgrYMXGGUHB/72XLYlzsuOXOxCC+Pg18gdzp/IwGIuoM2mYGRqRqZ
X-Gm-Message-State: AOJu0YyOVhOmD7DL/qNJBiuVqNtrtkMVRPrVntzBL32od6IJul22evnw
	7BFLUD4jt7yjDAgFa3sjiGFMNdvwm9DkNM+S1XYrX2GZHryTCsJGI2ktgsrkmhI=
X-Google-Smtp-Source: AGHT+IH6om1CxmwZGcQnWXy6bEIMyBXZcIWXNrdCLTXKQ0SXCd7CCKQlkBnOSpAafphpRQ/CzqYzVw==
X-Received: by 2002:a17:906:aad1:b0:a3e:a3d6:eb6f with SMTP id kt17-20020a170906aad100b00a3ea3d6eb6fmr7506167ejb.48.1708611582822;
        Thu, 22 Feb 2024 06:19:42 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a3daf530fd8sm5992588ejc.210.2024.02.22.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:19:42 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 22 Feb 2024 16:19:21 +0200
Subject: [PATCH v3 3/4] arm64: dts: qcom: x1e80100-crd: Add repeater nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-x1e80100-dts-smb2360-v3-3-85a691d4f68a@linaro.org>
References: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
In-Reply-To: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=8svlNz2AM3TX39zt1Mh5SAJo/Xa23Z1D0hrKnS+mZzw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl11f30GGaRLU6XUNmd7u6Wgq5dYwyzoH/42EN3
 qutQPWK+bGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZddX9wAKCRAbX0TJAJUV
 VpCyD/0fmjcldQqSmANrHDFImBG57tiHs8sO5I+eujxjkmeB6M7qcTc7bI4dl7zD/YKabril3uy
 17uy01kPnB+ogyqEntKqvujGip1OBvcuFz1/I+KypNBKIHL+ZrwFjSAKrmtzQ3wJ8MGe+9KBcLf
 b3K0R9ObWdb4XF/7OHJsc7r0QmAtaxHEI4BtGfxFXDFkfuNYDmy/KndNfSc/mPa6z+U+GeXh05/
 Bp8Ad6Y0//Ourne1/HJmsMLrcbKGQlQloQJ/98irhoMYkKR8qHvc/PX0kN8Oq94pOExsnwqYTJw
 ZKXRjZUNUmDCoJfDyLfd5ao7uxa0GoTK5neo6eG5ehIzhvoYV+jfySyyzLmx3nogmllxNdkwSP/
 lC+oMo7lHgvEryGf3Er0FlJGfbmnDeTeuoBH85G1R3OAJJyO8AQjMOMvq3ktM5jIzvpG8hwXxDo
 PV5YeFSpygLyGvkHplOgo20kMxlWGSjjeELL1JAiLyHq/CRALeqX6rCD35mYgThkPfpcvLl9tCU
 1KexbF/7q88XPLORsWHUungd+/dYwz4eR68lyxVbcy6I8M+OB1sKY/o9bb9ci5yLh9evd+x8JRS
 1DWUpqeTyQEKiVwLM102juo2CzizPwPuzFl9v8s7+YBYHxpecElc66yqaDJxXmEs62c3elbFb+4
 9rAK1ECC2iGjqQw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Include the PMIC dedicated file and add regulators to each one of
those 3 eUSB2 repeaters. Tie up the repeaters to their corresponding
USB HS PHY.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6a0a54532e5f..41078889969d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "x1e80100.dtsi"
+#include "x1e80100-pmics.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. X1E80100 CRD";
@@ -680,6 +681,21 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&smb2360_0_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l2b_3p0>;
+};
+
+&smb2360_1_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l14b_3p0>;
+};
+
+&smb2360_2_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l8b_3p0>;
+};
+
 &swr0 {
 	status = "okay";
 
@@ -817,6 +833,8 @@ &usb_1_ss0_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
+	phys = <&smb2360_0_eusb2_repeater>;
+
 	status = "okay";
 };
 
@@ -837,6 +855,8 @@ &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
+	phys = <&smb2360_1_eusb2_repeater>;
+
 	status = "okay";
 };
 
@@ -857,6 +877,8 @@ &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
+	phys = <&smb2360_2_eusb2_repeater>;
+
 	status = "okay";
 };
 

-- 
2.34.1


