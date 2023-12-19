Return-Path: <linux-kernel+bounces-5158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF962818757
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782271F2460E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908D17999;
	Tue, 19 Dec 2023 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9orCOAS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01961865C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e416f303so1962315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702988548; x=1703593348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SylnFOf7Bavuihep6FrRUZ3K4tT0YwbWb0OaRxJ1UcE=;
        b=s9orCOASLXm93OUJlizPTExVvpj40HrbetKh4MmS6h+bkDTakm0cgf0PiPvM5+NRiC
         yBdKyVtTrMWccu5yKFrmezuqLXS6Lojnya118+lkxLkYLUMpRgi6XP1A3Q3tlkwRuz7c
         DUvRya0AqDPbs2EIB+thQSyGEWKuEEkp/JzSSCnSeX885mkSsfpl0blE0Tth8zfHUlkD
         YuL1Xx1C87+T8+A945lE+illugYKwQ3QIRkdrDHDzVU6JmotBESOVJj8UI7syxh3FiHk
         F6rA9fmIHFIVQE/K1gNqNJC/CnX4iboqFF6U0I8aPdEN2IsoNMP3zGiTeXJT7/TobCSz
         Z6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988548; x=1703593348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SylnFOf7Bavuihep6FrRUZ3K4tT0YwbWb0OaRxJ1UcE=;
        b=M5vQEsXy7KCDMXE84ErDAQ5Hfwn0zKTvDWaquPFy3OldWtsrUBScvo9GgtpTU+nEc1
         8P8NhaiA1AvqVc+lNUyfeW0QCK5U06eAKcqY/1596AEEJKqxLNVAyxyhV3sXgWL7fCPQ
         L6etsT0ebJ9lkw9jgFi6k5e7tnrPEj+cc65oELvU4tL/2mlHNa1Br32bjkY3zAv2py8Z
         FINYsYOxdtsczDuS7yx5OeoAM6UCB/g9RFvI1Hogzruq83gu8B2QzLE7i7TmPKXsClsI
         ZhFyPIcErOkU5ebN0TDw+6he+1Rb6Y9ePGazd7O2aEKfby+IJr9ZPqPXHpgtsckzO0qd
         n5+g==
X-Gm-Message-State: AOJu0Ywh8eCHgeCDKsjb+LIlt0CRbOszVYt6ocwmHGx45pl4UgOnDIpe
	TEoWmaQR3jgxknyAkjZCpphGXA==
X-Google-Smtp-Source: AGHT+IF3YwY+ezYIdFCUb8c2AR6pdEHQ+CZY+DLZB69/phDLq+R0/wdtzbThnFW9MA2NAguY9o48zA==
X-Received: by 2002:a17:902:a9c4:b0:1cf:e19e:2505 with SMTP id b4-20020a170902a9c400b001cfe19e2505mr9205246plr.61.1702988547911;
        Tue, 19 Dec 2023 04:22:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902b19100b001d366f8cfd7sm7719419plr.182.2023.12.19.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:22:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Dec 2023 13:22:12 +0100
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm8650-qrd: add USB-C Altmode
 Support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-sm8650-upstream-altmode-v2-1-a608528864a3@linaro.org>
References: <20231219-topic-sm8650-upstream-altmode-v2-0-a608528864a3@linaro.org>
In-Reply-To: <20231219-topic-sm8650-upstream-altmode-v2-0-a608528864a3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3408;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=x9/qfzNBO7hwOHU0S23SWtGDd1O9B7NOV8hG078Fkrc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgYr3veMctBzDuwIai9WiZBgq+U+B78nC55Gpp4g+
 VYUmCP2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYGK9wAKCRB33NvayMhJ0SKcD/
 40M3AmHf99BCo6DCxYGx4Rixo0deveAa2KnzYFmx3VIbc+tEx3TkZ03TCzqeJEgDFMWMZLny5f0KOF
 ULPaOk1Y0iRmokc4kNvVxkLMG3DUXASvi+nuz/pFRwioZ6R6em51K5XCuIqbOJgB7y6t0m5/jAHAe/
 J45Uhs0G/1yIJTuykBega8JD/WqOKGLkLksS0VHgcWeN7vwm+bKzBbc8dhgzE4QIv3dY8s0y644GIJ
 YiM9yIRD4XnlHNpLY4E6YPqO9fhOjHIHazr9WRu7hHnIUo7LYaT8MMdIn0mDle3jzo9McBDAl4Rwwm
 xd3r5OOsVp1UCZojMqee+9VBNBU82cr4t/gNcnO4ZQ/zfDBDqJGQa55Kh8a20dgmZbgs6sVz5QRKHv
 C3WviYJp0UmRN/CrfADru9TAqcT/6oi+EqNEkcR//p6imu5cmFJ9lfAcVg2cIgg+DvKCMQflZ6Oc9R
 bP0KJiru1RuTM0pwIEiGq8SjB1LE/3A892S++8t65IWp8sl+tD1O8DDo9Szr+8XAtGecBfwkHl0OHq
 N+eWLnSvEioZyV93SB806ZSaGNzf7KbYKMolFcUR4pPcmjnqoQGu/E1jOzpm1XimOHOWc51ClOuywT
 6QBkq3s3cDqsOW04CCDM4n6B1PO/TD3DLCPemyQ2s3cj0Ssz7wlYAfbO493A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the necessary nodes to support the USB-C Altmode path by
adding the following
- WCD939x USBSS Mux I2C device
- nb7vpq904m Redriver I2C device
- Port/Endpoint graph links bettween PMIC-Glink, Mux, Redriver and USB PHY nodes.

WCD939x USBSS port 2 Path to Codec will be added later when Audio support
is added.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 104 +++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 592a67a47c78..a6f55191e107 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -77,9 +77,17 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&redriver_ss_out>;
 					};
 				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&wcd_usbss_sbu_mux>;
+				    };
+				};
 			};
 		};
 	};
@@ -446,6 +454,70 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&i2c3 {
+       status = "okay";
+
+       wcd_usbss: typec-mux@e {
+		compatible = "qcom,wcd9395-usbss", "qcom,wcd9390-usbss";
+		reg = <0xe>;
+
+		vdd-supply = <&vreg_l15b_1p8>;
+		reset-gpios = <&tlmm 152 GPIO_ACTIVE_HIGH>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				wcd_usbss_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+		};
+       };
+};
+
+&i2c6 {
+	status = "okay";
+
+	typec-mux@1c {
+		compatible = "onnn,nb7vpq904m";
+		reg = <0x1c>;
+
+		vcc-supply = <&vreg_l15b_1p8>;
+
+		retimer-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				redriver_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				redriver_ss_in: endpoint {
+					data-lanes = <3 2 1 0>;
+					remote-endpoint = <&usb_dp_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
+
 &ipa {
 	qcom,gsi-loader = "self";
 	memory-region = <&ipa_fw_mem>;
@@ -495,6 +567,15 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
 &mdss_mdp {
 	status = "okay";
 };
@@ -600,6 +681,11 @@ &pmk8550_rtc {
 	status = "okay";
 };
 
+&qup_i2c3_data_clk {
+	/* Use internal I2C pull-up */
+	bias-pull-up = <2200>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -787,7 +873,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -803,9 +889,23 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3i_1p2>;
 	vdda-pll-supply = <&vreg_l3g_0p91>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&redriver_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
 &xo_board {
 	clock-frequency = <76800000>;
 };

-- 
2.34.1


