Return-Path: <linux-kernel+bounces-3324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FBA816B06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718D01F2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698515484;
	Mon, 18 Dec 2023 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDdPmvPp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A214AAB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336437ae847so2702224f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895188; x=1703499988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JpYFAZaGSOCR2iZrKzQUAvOF9SV0JKgD6OLjGIZmUg=;
        b=iDdPmvPpSPsbQw04B1k7JZRtKI8HJDKLeK9U89RUwWrK7UhURGqzuXNsUDmc7eLjY/
         qt1XTccprcyw8sve8QDSSdDRO5KnqPHLr/1ZXwzlJzr1s1Vo3g3KsATxSSUdx0er7cqg
         7sKXNs9HZu1t46XEeiEyFzzG+Zy+o4VpIH4h4zx9G5A7h/1H5Ze7561eDUGwTNPadNdu
         z3SwYn/fWS26ybhSy15VFewbZK2yQ2bhBYWD/654efPqmbr2VCOgZ2+egvu6bRlRdE6M
         RZHTfeR/ErqsDPqjs6JaB9s/VOKFgowc7e3+kHtDEiLNZHjmn8weSHgmf3TCOlteZVK7
         +LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895188; x=1703499988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JpYFAZaGSOCR2iZrKzQUAvOF9SV0JKgD6OLjGIZmUg=;
        b=TBAVCYm1BELf1qzrTghIGoh0dgpKPVL+ar5HHNp0C3E2XX9YCUBUH0ZvxRFRyouydB
         4uS3DOnNI0vYG5a5cG4URLxlncZVHmibDaRm6pv5xuSv+XHOnW3e0nSSZl8nl6HLyKvq
         WZoruEbDcv8nAZrCUYh0bTUC7wogipU1zzpW9uIP+CCvrjgjyrQsAkw5Gr32Tk1ArgA0
         2XX5ca9kC7YwyJCaqE/IQ07FJi5vIP5RyMqOf6sdWCxps49EOlgrIJEcrpzlFCZ9UYI8
         Sdjw43b65bqj8uEH52DdrGZEuU+pV+wcAkB7CWRsXJYySSznb0BaOuWm+T7GupZZJD8D
         rL1A==
X-Gm-Message-State: AOJu0YzJwCoa2UoOeYCeFINaveot8hglsA7tuxQkR4NGgZJ/oBntQmvx
	M//jeAwqPK1W3ghC00E+wmCdGKk+FjqtYDT6Nn4qAK0e
X-Google-Smtp-Source: AGHT+IGxxaBKTgAX4il7WwlGMHxTiaoQVgnts1FpPJMa0rCTgjfqkrV/7FuY30AFyCnZqDnMtAoPlA==
X-Received: by 2002:adf:d1ce:0:b0:336:3dcd:186b with SMTP id b14-20020adfd1ce000000b003363dcd186bmr5561702wrd.63.1702895188323;
        Mon, 18 Dec 2023 02:26:28 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b003364aa5cc13sm11365333wrv.1.2023.12.18.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:26:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Dec 2023 11:26:24 +0100
Subject: [PATCH 1/2] arm64: dts: qcom: sm8650-qrd: add USB-C Altmode
 Support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-sm8650-upstream-altmode-v1-1-7900660693cf@linaro.org>
References: <20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org>
In-Reply-To: <20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nDXHDjdOUbZo6NMCY4ZIRIUoi9CPQ+tjxaeoWgPW94E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB5R3BMMALruVDHpz+DlfjI7+aKYNWPrdMVKk0Ov
 K91Jq2eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAeUQAKCRB33NvayMhJ0dAAD/
 44kh86BJr7RRRsbignuODXOZEQc7PaPk9ZW018RoPHz6esmxH+a/dIRq9DPBr9F2xOIjq/NL/DkjRx
 GdDvjUvAa/xmV+90FsUHXO8wLacsT/3EuX7H4bUX7Sgbgj2JwQg/+3xsQWnG8qFKvOhVeMV4JmB/4u
 YJGnSsxeK8c+JL/AASLRKexUtkZKQdwm3v1DumIFnx3nBmndm2Oj36V65CmhPPj+hND/IfXxlZ8zKT
 PAPJfAHBLwJQe+CQ58R4KM1S2Lw4KZhv1abLty+0VbK8nDQv/lTto1SnT7nhEcN4z9omVDaO/wzcH1
 t9JRM9ODUvuCPSkRf0ydwSUAH9/nty7Xqs3EknyyEO2wnMF/ilYxCUNw4dFaEOPq2yTTryTss7zsi5
 d1o/fMHzZDe0+1X0cMUz4zao06Dmma7y7t7ic86K/F5dUrczOyf1O6Cv21Mp4z+zjNLpDIVwxvuo8y
 wtngj23nuheeL2dXd/bDqUqDl8uXXS2QQ7dXkcrF7XAx8Q7HNxDKcKqlw6q5uMEovU3RlnSoezZvrB
 IwUjEwzSOCQjkmLeHdDxvwB8aD7e8o+8o72Arg9TMb+Vht9mse9r2CK2dTLtCivdf24wJC6lTPEoY5
 qr6ud9+N7oUx12EXwUNRMRiXc98Zt0wcYCcDFYuLgxvt1Dq+lZgUUOW1d/PA==
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
index 592a67a47c78..121fbbb5d015 100644
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
+       status = "ok";
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
+	status = "ok";
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


