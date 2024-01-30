Return-Path: <linux-kernel+bounces-45203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C27842CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0861C25050
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AA78B58;
	Tue, 30 Jan 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTsBM1HJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5C71B55
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643196; cv=none; b=BJcwqPiHFWQoGNLX0wdAAlFp1fjKRuT84BpmUiQA9bvP6w/GjLotCeWxTXlWvWstD/g0l2yFW9SyX+oNcEY7dFIQlPUVKQYZ8zAvxl58zoRrSqNo8jtTA0LeulUmUcYRk+aV1eoRbWW+NlH0CB5S+p3LBEoOcDy6DT70ojW7MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643196; c=relaxed/simple;
	bh=YbJxbniUvZ2znwhQdVnnHP7RPDLL9PQ/9YgOwMvOdms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDytAjDrGG7DBck1LIngo0HlLW/IvcH6NsJYSrG04ET7dsv3qhrH2I6xGDOCimfQ+sLPZL+bJqh8JQMJb0CmUlZI0WV5Wm6BD2gBcsZfpKeDoPuECRIqANCL4NFb80ifDgQYxbqM+tdv/YqJpVsITnDxUCCVTkpiP+EHT7taxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTsBM1HJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso7244130e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706643192; x=1707247992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npFpjUqBQIf0VOW9142O+6ls59GJzjW57cq62091hkw=;
        b=aTsBM1HJ3ybzyso8rlkcyXleQFLxqQcFB8kZ/2U6B5U7b1HcgilWo6HMT/aQK3T3Kw
         HSAjJQ3vEOMeMQhVR7119d0HmGmLFzeFXXcpKcs4SjRZfuEbYOS9dRssVPXBtiq1DJib
         eF194UoAt3IXOO3Byz9mCE/QxGSG63+iViWpcE8wrgtqkoJ2u3HY19NwZKrasTrH/GKQ
         CfMZOPcCxe6CsPiJr/Z6JKngtG+nX4qdHY6jl5nzN03+siq1n68GTm96Y8gMrQ2DcEbu
         3MpS3cYCQ0ovxksJDdou7wG3rBgRbdJCvX7CL6F7FYYDC9i9yFlimE5PJ+6tjh10kwoI
         7qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643192; x=1707247992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npFpjUqBQIf0VOW9142O+6ls59GJzjW57cq62091hkw=;
        b=B2W3IvwA9IdwxG77PsiqoQBxp6CKtxIJazf/Tt1jThT2U+TiUO4B5uoYq+Yrbg8KfE
         DzFnlBj7Ay58u42fyNAYivObqijDRZX/2n4/cYjt6UbP+h8wtK4L2tJWB+zXuArCLNb3
         9kvD59mz7Gg+66MfVW/S6+SDumH7Et3cMLdaLfEds8N+PtyMnBm+k3xKPKeKCqmRPJfJ
         casd2v5dFpeZMOXin45FYjfscqW3f4831mvYPanAuucqY4y1mQL/yQ2193LUX3Wv+b5e
         2hezBbAB+7b5FYa1STxy3PgVKXLkCJ+yzojrueIUjfX0xUCr25l8jWbBaLSLq23p1Qgm
         W12g==
X-Gm-Message-State: AOJu0YxBTVWZ/OlQOzztWJhWMRMfhQp0N+BYxOV3WMSFEQAlxlspV04l
	I7j+I2Ik6U7ch7zKTCmqSssppayYGxEr+B1P2TJNiBN0JEtRy35fWUASoBSsvN4=
X-Google-Smtp-Source: AGHT+IHUP1ABqsZ6nXpGibVLqqJMZsucIp6CxCj/NrOOIjsjUMw8sINviWHWc7EiFPsQVq1flA5Tiw==
X-Received: by 2002:a05:6512:2247:b0:511:b42:1711 with SMTP id i7-20020a056512224700b005110b421711mr6489732lfu.29.1706643192636;
        Tue, 30 Jan 2024 11:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSqZ4Pp0+rGe3h1XuVfHnXuz9flYBJ2RgG3iZrkS3SGbmR2kP5hwwv5auDro9ELAr58+GqR8q9IvHXUNU8w6FLCAN6IkF4+ynfEGH6yXOqBn42iedWu23M9CXa3KUCOpCMhJCk5mdkSmc7d9EPKkjl56mN3iltZ6MQQ9x1xTZXXVZ4pPfBInOTL7FxVM4rgDuXsJqqDImWxONCLDTk6bUx86tZNIvqtjcQJyU7PtK8zc+yK5EVfvitbMnBSgOPwuekE6yUAf5b/TrKODytSlkhyJjwaL14epagecv5tDe9/VceOR//OZlAVEWOs4sPWJ6rd1bG4uO9hUn02DYsuL2h/NG6dIvZcNv24n9eTYNaDde6P6dfCNha63ISVCuBOu96sYyMk0ZkeCIVk6W/SrottyDH9/clGTRWOUEgeU66aQd7bnclaQXae9hmmzIg4oh4fAdfzcHj55jSycxdIEcyo6UxM9tCPuUg4A3l9YsWfZrEWL+J+ia8Dn+CbqvUMH+hb2VjIGx846iyVgtWwVwpy+gZKsWfes+VHILxzYN4qEMslinLh7VmQQ9Q7EDRUiKUWZkGSAyuZXSlj90BKmpb9dIDDQOZ4+35J3i4qPqt
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u25-20020a05651220d900b0051119371e7csm366525lfr.120.2024.01.30.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:33:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jan 2024 21:32:59 +0200
Subject: [PATCH v3 6/6] arm64: dts: qcom: qrb4210-rb2: enable USB-C port
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pmi632-typec-v3-6-b05fe44f0a51@linaro.org>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
In-Reply-To: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=YbJxbniUvZ2znwhQdVnnHP7RPDLL9PQ/9YgOwMvOdms=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluU7ys02dGfoXOH6zWBHf56+8dD3I7yrm5IOYp
 noffzriEvGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZblO8gAKCRCLPIo+Aiko
 1ZscB/0TM6+7mWmBslzwMev5SmlCLwN6InfSSgJL5GL4i4T/3fc5AP1OYV+bD0lbPQ62rujoGtu
 0Pcerd1WXTQpWLNXf0K090n7jxCUj0Bk7vqOz3tmq6DzJgT7tGXHqH05e6DFWNd3NzKoNhqQCM7
 uPYleNhS83xRJPony2dycfRa6X6ZVp1MZ/QwtyYPqIBq2sU1ddlbswQ2Zgz053TDgtvxtbW0M8Z
 WxvPsTxfGXFdvNBIaTIbt6CzULWhulfu6SD5AKaTpmwrJiMZKUDU4itzmHHx2IMELHPgxSH8QTl
 +rwdyTUfQAi/U1/YLyMM44p6iyuXcrX9RpiOYBt0UoH7+lXu
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Plug in USB-C related bits and pieces to enable USB role switching and
USB-C orientation handling for the Qualcomm RB2 board.

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 50 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 43 +++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 52f31f3166c2..696d6d43c56b 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -6,8 +6,10 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm4250.dtsi"
 #include "pm6125.dtsi"
+#include "pmi632.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
@@ -256,6 +258,46 @@ kypd_vol_up_n: kypd-vol-up-n-state {
 	};
 };
 
+&pmi632_typec {
+	status = "okay";
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "dual";
+		data-role = "dual";
+		self-powered;
+
+		typec-power-opmode = "default";
+		pd-disable;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				pmi632_hs_in: endpoint {
+					remote-endpoint = <&usb_dwc3_hs>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				pmi632_ss_in: endpoint {
+					remote-endpoint = <&usb_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
+
+&pmi632_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <3000000>;
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
@@ -607,6 +649,10 @@ &usb {
 	status = "okay";
 };
 
+&usb_dwc3_hs {
+	remote-endpoint = <&pmi632_hs_in>;
+};
+
 &usb_hsphy {
 	vdd-supply = <&vreg_l4a_0p9>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
@@ -622,6 +668,10 @@ &usb_qmpphy {
 	status = "okay";
 };
 
+&usb_qmpphy_out {
+	remote-endpoint = <&pmi632_ss_in>;
+};
+
 &wifi {
 	vdd-0.8-cx-mx-supply = <&vreg_l8a_0p664>;
 	vdd-1.8-xo-supply = <&vreg_l16a_1p3>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index e151b874eaf3..dd3d97ef5cc7 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -879,8 +879,29 @@ usb_qmpphy: phy@1615000 {
 			clock-output-names = "usb3_phy_pipe_clk_src";
 
 			#phy-cells = <0>;
+			orientation-switch;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_dwc3_ss>;
+					};
+				};
+			};
 		};
 
 		system_noc: interconnect@1880000 {
@@ -1620,6 +1641,28 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+
+				usb-role-switch;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_qmpphy_usb_ss_in>;
+						};
+					};
+				};
 			};
 		};
 

-- 
2.39.2


