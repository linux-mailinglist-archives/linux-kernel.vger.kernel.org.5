Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D17FDA32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjK2OpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjK2Oov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:44:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A21BD4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00c200782dso980986866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269081; x=1701873881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uv9zfaf6z99knWy+mQD+FqbIWFj2XAGtTYBT+VcDlo=;
        b=y5VK98Z0MVFrt2Cmlg6H99Oi+r4ETFSCQsSdm64kkCrfOx2gRIwzDB4Tvwh6gWTSbS
         1fxS1+CDg36xfDj5xXa2HLs6+7dYDhYVLttV9pq2oT2EG1v85GtRkc+GLxerP1GadLZ3
         pDSV/LJtu+s85EmCGFR5gdHPTzSnRK1JzL+ARzhXhxALsBfRlGf7fXuOBS4i7J6MtFPz
         EDT7lwd/RgyTHW3G4xWxcnclJ0cynvp1CMelN1c8ty27DcLyA5QxvcAA5B/9m8WXkBCs
         zc7k35oOu+Lhn3iZfK0pGBV7b35+JfWXyliQKUr+RQju+VANeDAMm9UIjRbANkb03Ft6
         jPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269081; x=1701873881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uv9zfaf6z99knWy+mQD+FqbIWFj2XAGtTYBT+VcDlo=;
        b=q+WNZftUJZrH7CTkZ5K9XC1ydJGNJ1PoWid6p0kmACfDK6TieULeDXi40jwqx+2mWY
         bvpAaBsIQNXc8HLZa0/kdZciuANhvj4iVZBnE5Zf6WdhhKFS4R/GlwlvUmOkM1O8xzsD
         3RdSMqozYQ5PexlpnhyDlgo7PeceJhtNMxAg1Wn23QhD8bofgZpyGds7ryVK5HkGIO7C
         AFBlNyoCB9XITEWNPXcjnkz14sTZn2iYkY/kOr8JOwXqdVHAsCclF4jBnZd5Wr5My3jM
         uoRAvkLJE17mQw5uVzXmSHzf3bcpKvJDZlfmErnCEoIa8ASRuUmlX1OtbGhMJjQT+Grj
         3MnA==
X-Gm-Message-State: AOJu0Yy1HV9G26rZHgXadU4b8pV9f2cJEJ1JUXD7cIev/0kVKGdM9BKy
        wvz7xnGz4VzieP1r28pvfNMvsg==
X-Google-Smtp-Source: AGHT+IH/vXkw0enMe7jjwoBb+lnZfRyS5aO1O8s2vfXdceOl8FZPhdJNVVAhGjenI+fDmgsaO/vHsQ==
X-Received: by 2002:a17:907:6b88:b0:a11:adc9:d14e with SMTP id rg8-20020a1709076b8800b00a11adc9d14emr6306159ejc.71.1701269081664;
        Wed, 29 Nov 2023 06:44:41 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 15:44:07 +0100
Subject: [PATCH v3 10/12] arm64: dts: qcom: qrb2210-rb1: Set up HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-10-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=2405;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7zIWcZYNiLUFpSiqbz9ETzUeMoZvPDpFqV4bp5urq7I=;
 b=sB+64YQKn6yoWshqZCZ+xVNWQ5kgrtmy29piu0Wsi8nXSWUNAn07BSj+gyt4rmqgsQtWaApR8
 nJYCsn5ZpY+DuB9A7y6p+2C11Z7QRG94ErbCwzs8mK+tTXJMUpbWuVV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes to support display output via the HDMI port.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 94885b9c21c8..ac6584164058 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -40,6 +40,17 @@ key-volume-up {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -158,6 +169,68 @@ vph_pwr: regulator-vph-pwr {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+		interrupts-extended = <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_hdmi_out_1p2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm2250_l5>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm2250_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -377,6 +450,19 @@ &sdhc_2 {
 };
 
 &tlmm {
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio41";
+		function = "gpio";
+		input-disable;
+		output-high;
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio46";
+		function = "gpio";
+		bias-disable;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";

-- 
2.43.0

