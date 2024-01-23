Return-Path: <linux-kernel+bounces-35381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB739838FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6441C20E46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22387604B3;
	Tue, 23 Jan 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DC+b6Z1B"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128A60253
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016084; cv=none; b=re0aB4BwRvbmEfJAll5I/jY5uoMfI0oRJRgJifdZ7KNFygzOIAXWz8WL5acR3V9KgDOjpfaP8dc7vbVT8pZnX6uQprla0NW06IT2mSc3R4Qdu0Lek/KsDOCv5r6UH9XSfrK09p6kFCvwYxigtXdlqZrvjEaGATzIVcLHylk+yEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016084; c=relaxed/simple;
	bh=x9/qfzNBO7hwOHU0S23SWtGDd1O9B7NOV8hG078Fkrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtJ+KnR8wqIgNPZd+5sP91fIm18PxQiWrcjdRSF2AxWTpv+lyROU+5u0TZJCf0RwyZhOaccrNLBzz+ZcHNaKRFTmJYgZd1HtIyN6O+XCGFkvs7ljKKbZnBDxZq8azij2GaF+NCOlFi9WhofuBGKwXm5nmil53/29oRcej93zsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DC+b6Z1B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so47605965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706016080; x=1706620880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SylnFOf7Bavuihep6FrRUZ3K4tT0YwbWb0OaRxJ1UcE=;
        b=DC+b6Z1Bc8N4i4rsW9DRT9CpdbeZKAsOJyo7lqMDH6utBUy1rWZ9brXJTRPA5i4zDa
         x8rI09e+TlajVr1EtHNnHsozZO6xw/hiEmIw9HvrzLUDqdmjrHePirWQL1AuJ3hu1szJ
         9r/Fh+r0AC/FP5ArqElzbdmaZ19wrP/C6HWLJtbTlZzPNLCn5Gnebadk3gb1nDNA4sLX
         DJ8W6NUXLfRQbZq2lTPTf36doPk5NjMB3/alNlRfjb1SU49WJi0TwtOUElehpJZLDvpc
         6hvKpv9MMlyQa+0+XTx/rQA72trPNEzgI7QAor9g7MybvgDzFo/HvYK67XGDJ1lyUSvu
         nbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016080; x=1706620880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SylnFOf7Bavuihep6FrRUZ3K4tT0YwbWb0OaRxJ1UcE=;
        b=sygM/ohoERzOAWW0PIOVlbhkswe12xYiqB3lr1C0RbC2PUYMq2r7FN45S3dgh/hU5I
         iDtu2FIRxXD5aRF3Er85+BvUDoajW/31Kb5lQyMH2vV8pw0aYIwTRcIbN/x1JtZu5DHT
         /Gm3RrkH/JM+Gxel5iwkNnrAiTvg6NxiQU+IwRiUPzWTRJvTYRIRoWMQLkB53lLaVU94
         zkkEi4GNAGFRZCqiW/XcA9BE4gBCQFPR2WeB3bxbSMzSeZes1UUkV9FWFb9tsvcxIlTg
         cK9eZHTq3ZTBS0HNT4gyXgbmdjOAy53T7OiF9UtijFTxdQRe3ZwwnpRjfsLqsYaX10n4
         q0tQ==
X-Gm-Message-State: AOJu0Yzwc9xE7n5z/UnGUHryBLlGd0JLyCSf2LpbZtVnbYFH937/mqvS
	ktIuzLc0FkD86hb0DLAeAPXPmpLgyN6afIZvTnEzerVpN1u8iBURQ4gHJgj7Hzk=
X-Google-Smtp-Source: AGHT+IFo+FHbZA94pFbra0P66oNc9pTeAk0/7cduszutwH9FEdIN2hfu3d3866ZGDxSWf2NRxvOBtw==
X-Received: by 2002:a1c:790d:0:b0:40e:6639:6708 with SMTP id l13-20020a1c790d000000b0040e66396708mr515536wme.49.1706016080068;
        Tue, 23 Jan 2024 05:21:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id hn33-20020a05600ca3a100b0040e621feca9sm39982445wmb.17.2024.01.23.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:21:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jan 2024 14:21:15 +0100
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8650-qrd: add USB-C Altmode
 Support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-topic-sm8650-upstream-altmode-v3-1-300a5ac80e1e@linaro.org>
References: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
In-Reply-To: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr71NiXn1d6ebmM3WrdSpaXkY08hClcgwBI0hJeau
 9TbVf5qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa+9TQAKCRB33NvayMhJ0YMKEA
 DJtL30dRcAMqf30uxcmYeq/14W48RdF3/vJtIol053B/HovDHoxHVzKu/w1Mucp2PGM+0o36ceheU8
 dkpl2+cYdvSwwPKT6O2cupUUa3+trurBjJHsMYdkrer9ndE+ynrxQsXyFARZ6yaWSXVTX7FaZ5FH7y
 UeJavnP+mj+B0KDRdjvVbyCQXnEfzAU4LAsZj5Zr5HZfSnClKgLqQMTOkFTw6FKvafZt4YRWzIocTd
 qekYqWLNtK/D1fMEMvZ4KzJRiNIEHuHBs8Am5y2UrgQKcrw+LznsTRC+KEv41todxlqudu60XTgxU5
 WKm2bQqaUfxX6ECKrFknffSW2ZIHj7l3qVya/q+SsopxJ0/yFxwE8mxsdPn7Nh2YEo0uY6xCLJyAgT
 1gytEU+a0QfueUisUSZCTqZwdmfc6G8tkJEXtRhp2qf/2TOQKM3wSrjS3t1difKWduesZmd2mBxLto
 jUtfsCgR8bZY/YIm5uLJjvra0TIIfVEKzcrxUHivgnDtq8wO53dA+P3eD4UhOMwHGcbqO3bRGIkIMZ
 dmcI/b3gEdCQTb3AzoEO3ib1gSPRdISBpxlS4Jj6PBwh1mKxrS9Bam+st+c+awgkrSau9qnOTgTJC7
 jCQtiv1gZqSaf0VkByQRT9AsuVZXhM0y+/mejATWvED+B4QPOdaa+apdHFHg==
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


