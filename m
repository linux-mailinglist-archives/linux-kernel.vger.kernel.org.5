Return-Path: <linux-kernel+bounces-39976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5C83D7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C085C1F315C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84908604C5;
	Fri, 26 Jan 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilRto/tD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A75C5ED
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263249; cv=none; b=BVNy5aAkn7eW8awJzqJkAtN7XG4An/KFOkR9DD+sL5GHq2dR3ABRaGcB/Mtp/FOn7yZqbyqK0FTrKWT52ZLZaRwLRe0V+yaOUrG4MpbY0oxGx6tfK/V6pCsAIzNEeqvvaf7QvZYtDTyVnY6OIhPv7Z3HZ3WQPSOrfEA/sF34d0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263249; c=relaxed/simple;
	bh=ps2ITLtb+wnuPxzAvuaCM3IjDOmZRmy6w8oxvg6tWw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6KjRh6LH0KMfB/+XzPvRaTKckGBqAf1Djy4DwnfLfsI7hGEXGCuyIXG6Op6mhGmbAg5TXeowweHvCR3vbOz9DEMbYuFKRCtAe5bX2HpPoOqls7nFZ5ZO1/yuWYbj1wKdJ0kN7ZJV4WegwlqRTQN9NhcL51P48sOEFT1Dg7P2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ilRto/tD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ed28f8666so2742775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706263246; x=1706868046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ro+Hb2iobKdmEbVL0if24hsgyW86TfrhpfzGCL1Ai3A=;
        b=ilRto/tDc3IexG4tw2pN6J7+l8izus+SsYYiVdywsUebBEAjrmiy+N3vF7fA9Bh9c3
         EHj0AKvg1XGma8NFIP/nUkBd2S+DNFB62f7BRqZ0K28rHCRgjeinG9lIVpr9999zhUkh
         svItuODzWoiJioGL4qLsZGqi1GsU9COqNdvwHAh6O53XxHFo/X+DfsLFT+dP5UNO1SCe
         4zMzG2ANYTINweTb8PFpDVTo/ZAFrWe03mxi2Ri2cH96d1g+fRdXo1LWmT1Xe3ZC30jZ
         VT9YYtCSc5VdlyDxWwSKhTofNFe6Zo8qCa9jk4/C4FQAF8DGxmnvqBLCs0jbd7K7nf29
         PLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263246; x=1706868046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro+Hb2iobKdmEbVL0if24hsgyW86TfrhpfzGCL1Ai3A=;
        b=RXD7F1FipZbP4poQTa+wjE7LiOxdnLOBfDiUS3USonS5EfjXTdlthLB2WxB2FGR952
         sZeStij/nugukO7oxlBjFhV9yAR1w1O+Vfs/VbooEDcR7282XKU6GMPAySVeWoBcoAMh
         +ftlIju++J6ZKBgLfYXZUQVaUM0ClFm/+d9xETnTymIlqK5wV/pz6dWhZNyvgP7ZJqhh
         I6pq5yckYUG/4eacw5cet85hN6s8OjHLAmqxtYS6fCefMj9YTIoHChpOTIyMpAt0HjX3
         ljX3+Nm6RqIKfGFxkHbxwKahO+L9SbcRvcfGL6BzzIf/KM74T10Ebn+H5TU/2cbeUJod
         0CwA==
X-Gm-Message-State: AOJu0YxpMaKobcXmylKew6GugSsTmVPZNq0sD0oIs+3hh6wh1Af9GIu3
	ktj2jENNK5V/Tk/q/vo9yrqLteqEW5kTGDyTEL5IAp3+Nxr69V+rfuk+yZ0bLYM=
X-Google-Smtp-Source: AGHT+IHVoAb9yzLAsJQZXOv6V6OdxEVIPo1B/6ctTYkTh01MlkLnWCA5cntyxhtdou5bf2h5YXiKdw==
X-Received: by 2002:a05:600c:1d07:b0:40e:51e:7295 with SMTP id l7-20020a05600c1d0700b0040e051e7295mr640360wms.82.1706263245813;
        Fri, 26 Jan 2024 02:00:45 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ox27-20020a170907101b00b00a3221b95ce8sm448494ejb.77.2024.01.26.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:00:45 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 26 Jan 2024 12:00:20 +0200
Subject: [PATCH v5 09/11] arm64: dts: qcom: x1e80100-crd: Enable more
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-x1e80100-dts-missing-nodes-v5-9-3bb716fb2af9@linaro.org>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4648; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ps2ITLtb+wnuPxzAvuaCM3IjDOmZRmy6w8oxvg6tWw0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBls4K+czcZNS3lD4y/7Hy9uMx4Lc3Dk4r/itrsY
 4+TWMvhmkyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbOCvgAKCRAbX0TJAJUV
 VnsbEADEErWAWyuSqwXr/J+oVbDTRi5w2sv2uep1I0fRSEShd+YuM16ZBic6BVUQDIWx7h+jgoL
 yPY+7zSE3YyAJHzewcR6DATSIqr7fKc0dmR5jpvS5impkM6d94tsEkqFA0+xSCKabSyKL+MmwVN
 7XY3B8Kbq984hmo5JIBr9W0CqIY9eOQ34ugW9WD26Y3P6ZxFWpzfzo3c4d6zHgC5i558nVVzo1y
 mqha7N5GEqvqr40BpXfTIt2oOeSOudWj7bPSF8yGjX7UA6NrNHoSzv/rP6iP468FaqsthdsZg72
 AOFwDRhSOfaTCPNaaDwIoyhNGP1dG8bi7/tcxQPW+S3la1mdYNdssGDvub9/9SH8PA4xmFthLjb
 veFGkFefI54DHMj1eCvN1VqlxLgZ1MAzv83JKTnG+ORnhDx+8CL53rVh7v2TtkqrQGdVxyP5nbm
 m/IfRNLmEQwkBdZECTYsmANSwM99/wK/Z8a3nWjVx3uS/W2/wdJxkkKZHGLq49It2ZnQvomi2tq
 avmV3Tqa2qQZV7ZLc2mj2wDy65f5ZqxELaASXeTFHUt9IaiU4nh7KE5Zk8hHSEPLpdX2TcKMMSU
 +Cl5kJjLO0kyf7t6+DnSFkJxNtZf4hYFuKGdqV5RtTQCod9zasxT08yXlAs3Jl8/+09DlWNr9Gj
 gwfBmvhUGL9ZERQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Enable touchscreen, touchpad, keyboard, display, pcie and usb
support.

Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 222 ++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 7532d8eca2de..7e7cc8e43f87 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -401,10 +401,145 @@ vreg_l3j_0p8: ldo3 {
 	};
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+
+	keyboard@3a {
+		compatible = "hid-over-i2c";
+		reg = <0x3a>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&kybd_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ts0_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp3 {
+	compatible = "qcom,x1e80100-dp";
+	/delete-property/ #sound-dai-cells;
+
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&vreg_edp_3p3>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_dp3_out>;
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss_dp3_out: endpoint {
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+};
+
+&mdss_dp3_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&pcie4 {
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie6a {
+	status = "okay";
+};
+
+&pcie6a_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&qupv3_0 {
+	status = "okay";
+};
+
+&qupv3_1 {
+	status = "okay";
+};
+
 &qupv3_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/x1e80100/adsp.mbn",
+			"qcom/x1e80100/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/x1e80100/cdsp.mbn",
+			"qcom/x1e80100/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
@@ -416,9 +551,96 @@ edp_reg_en: edp-reg-en-state {
 		drive-strength = <16>;
 		bias-disable;
 	};
+
+	kybd_default: kybd-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		bias-disable;
+	};
+
+	tpad_default: tpad-default-state {
+		pins = "gpio3";
+		function = "gpio";
+		bias-disable;
+	};
+
+	ts0_default: ts0-default-state {
+		int-n-pins {
+			pins = "gpio51";
+			function = "gpio";
+			bias-disable;
+		};
+
+		reset-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+			output-high;
+			drive-strength = <16>;
+		};
+	};
 };
 
 &uart21 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
+
+&usb_1_ss0_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss0_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss0 {
+	status = "okay";
+};
+
+&usb_1_ss0_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};
+
+&usb_1_ss1_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss1 {
+	status = "okay";
+};
+
+&usb_1_ss1_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};
+
+&usb_1_ss2_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy {
+	status = "okay";
+};
+
+&usb_1_ss2 {
+	status = "okay";
+};
+
+&usb_1_ss2_dwc3 {
+	dr_mode = "host";
+	usb-role-switch;
+};

-- 
2.34.1


