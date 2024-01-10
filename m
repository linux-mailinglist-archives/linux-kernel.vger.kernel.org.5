Return-Path: <linux-kernel+bounces-22407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30195829D49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5571F2323F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AF4CDE3;
	Wed, 10 Jan 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Ipaq+TrH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014174C626
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2adc52f213so354189766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704899660; x=1705504460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyZi4i2h3MjcAe8ui93Zy0Le6mb9DZJuyAuhhBalDgU=;
        b=Ipaq+TrHlyo8JhRvpslcYdL5sdEK7+gbKk1iUkeja1kJ8mqwNxVwDIuyDzHBbTU4fe
         oHj7YRcvhBpPtUotCNmyNYJ5UpVsWZzBBPoKeBqwksfQF16Yurmj4WgNghTH9lFviisB
         d5/ufz72VDACVYAKhenX5Day7EQ151pr2e74LqfP0zx5weTo5/XUHWmzx8LWbElotkDt
         LHNMkA+oehoOz7gkOpNbFUG3kcTxCUIPCJFuudrRTwus8Y8K9emCYnh+Q47tlcaa5oqF
         RSE6cFeEEWyiO4HbwiTLOTy/QgYSq5pSHok1fL94RoMePr4l6uVqGa/ZXgJdyFTAQJKL
         eYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899660; x=1705504460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyZi4i2h3MjcAe8ui93Zy0Le6mb9DZJuyAuhhBalDgU=;
        b=SxdoDNaMWeCjcUkjme5BUSLXNb7dRngZ3FMqEcaeqzOwSYhcSNoZ75lxlGYAFInvCl
         sqDgHZIOdYv8gF0m5GnFv8mEOU1lA1U/J7oVHwdyXioX3eIFpNRjdKVrZcM4TzsGOZb4
         OjrscgOpt66CuyBqgSI9ET9K4M9/6iLs5+2NeXtyc74bE85KC4i4Gf4doddl8GQPAbso
         wOgBc0L7wWyUcyurqM+xkOMHh7BsDTh5eoSQEEBj0SHlPGF3w5HAtbT3WV6u4C/X15Rq
         OdMvyJyp9ZU5DPxHPwW4IBTw3TtZzLpxDuUYQrlP/FVCWpnTs025wyqeAUKsefWO68cd
         meCQ==
X-Gm-Message-State: AOJu0YyZ7GCsVLEPHXnBWrPElc00I7HSqh4P21PmB9CiPaWykasXjo8a
	RXcXKMNkkZ1Ud0KFWsc59C/m6ciwVIfdRcDPGlYrW+gmTRikjg==
X-Google-Smtp-Source: AGHT+IEYJKfcjt/Uh/leQB0jE1RBU9OXgRCgowWKHDrfkGCNM/8gBFRQG+CXa8s/tv8EwQ60+U7qKg==
X-Received: by 2002:a17:907:b9cc:b0:a28:e870:97b1 with SMTP id xa12-20020a170907b9cc00b00a28e87097b1mr701936ejc.131.1704899660405;
        Wed, 10 Jan 2024 07:14:20 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id jx22-20020a170906ca5600b00a27a25afaf2sm2174517ejb.98.2024.01.10.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:14:20 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Jan 2024 16:14:11 +0100
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 display and GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-fp4-panel-v2-4-8ad11174f65b@fairphone.com>
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
In-Reply-To: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Add the description for the display panel found on this phone.
Unfortunately the LCDB module on PM6150L isn't yet supported upstream so
we need to use a dummy regulator-fixed in the meantime.

And with this done we can also enable the GPU and set the zap shader
firmware path.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 53 +++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 29008e155d62..b9f4b6be7da9 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1338,7 +1338,7 @@ gpu: gpu@3d00000 {
 
 			status = "disabled";
 
-			zap-shader {
+			gpu_zap_shader: zap-shader {
 				memory-region = <&pil_gpu_mem>;
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index ade619805519..9a7d0448fb68 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -68,6 +68,14 @@ key-volume-up {
 		};
 	};
 
+	/* Dummy regulator until PM6150L has LCDB VSP/VSN support */
+	lcdb_dummy: regulator-lcdb-dummy {
+		compatible = "regulator-fixed";
+		regulator-name = "lcdb_dummy";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+	};
+
 	reserved-memory {
 		/*
 		 * The rmtfs memory region in downstream is 'dynamically allocated'
@@ -373,6 +381,14 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sm7225/fairphone4/a615_zap.mbn";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -404,6 +420,43 @@ &ipa {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l22a>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "fairphone,fp4-hx83112a-djn", "himax,hx83112a";
+		reg = <0>;
+
+		backlight = <&pm6150l_wled>;
+		reset-gpios = <&pm6150l_gpios 9 GPIO_ACTIVE_LOW>;
+
+		vdd1-supply = <&vreg_l1e>;
+		vsn-supply = <&lcdb_dummy>;
+		vsp-supply = <&lcdb_dummy>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l18a>;
+	status = "okay";
+};
+
 &mpss {
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
 	status = "okay";

-- 
2.43.0


