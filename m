Return-Path: <linux-kernel+bounces-162269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6968B58E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9721F2219E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717226F53D;
	Mon, 29 Apr 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TndRtTyO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AC6E5EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394632; cv=none; b=ROsPe8Z64Ez/67ibB3nFO1szlZ5sfC8S9BgyNE+11k/14Ot0xj9b436nOVRfLgNkrbX1xexcpb0dhQ/XNKNOQIzb8J9j9jfOa/xLWq0LZhmX0HgRG33fWaiVFwR6eGEH247GLb9JPdspcUSWhePcuy3lROKVb1WeSnCK4s6c9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394632; c=relaxed/simple;
	bh=lfCa8/A3WdTMZE4WDsCfE9ziDKBNSnFF8CBfBae6aH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSgsPxgln5496+OYjX0dRc/HJwyaz5i0f7keJKTtJsTKsjY0rgg4F9/EFX/4sRsh3ItGyi9m9vhA1+5VJSaVNxQG9YbvK7tHDVqzV4NUvkXeatCQp4nm4YfBN9FSIwILd/OfvFaM8l/E+c9J/C8LWL/bhDbCkaWCWL+iB9WoOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TndRtTyO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51acb95b892so5402308e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394629; x=1714999429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1PNklnw7rpcXPRbhJLkI3I7rSwQMAW7Mmxi2Rcau0k=;
        b=TndRtTyOCsQ72k0hq9IKd5V3sKoLk5t1NLiyIiyOWdteqiOZsTMqElXIA3el9oPEVC
         1s/6s3BxGIzebpktGRRFntTeKE1ntj2+Ud/UzP7NoZQ+35ja6cbcyvGMJxo08UMJfU6O
         eMlBz7X+pQW6pzwH1SIrSRduJDVC8+S7yy43ggB45NqtrSGRg8/fU1kftlfG9+mQoz+o
         Ke81aYz3nFNp5sTxe6p+npXZzADIC1yhobM71abPcpxAY2Tsj9CVZwskOejp4rzw6Es2
         4bmaJp2SAVxFbGeU+wVu4wiAX7L3D5gPiMU0UGYlFD6h6WIc5WxqnrA70blHwjMoGGhn
         H1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394629; x=1714999429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1PNklnw7rpcXPRbhJLkI3I7rSwQMAW7Mmxi2Rcau0k=;
        b=ILfHuptBdUmmiSZxxM70Ygb0dpYPQX8H5ZnWgbYgFId9UPgvfpP9EJ1q8GzHuk+qut
         +63vIpSLY6sAPdZLoxPsDgMV2Ofg3tB8bXL5kS62oKlmkC+1Qc6TdUYAht6CpB4nUMjf
         5gKN8zB+stIz/8KsOvqrU3Y2hM2rqQkGCXhsR7/ahLk1MjboYJ2CjttQChNzISqmfiYQ
         uu324XecXr56SDAUoVxhwC//S7OOiKJpDKs1fRr+YKMsn551d450mitKskUIkRTMY07j
         qCAJkwEfypPllNJvMVflFaW7aY99WnmhsNHNEkQvM2+koqRdG3c6jpn9oBRFfIvKiWMg
         sFgw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAHqLX57Dmqv0C/VhUwh+IcirRGmVYedSzjt+7UxwQkElEqJxoctmLVrB1ivDB1Io3flw0A2s28YpR1/ASXVa0pcd2Ak5KOsgGhDN
X-Gm-Message-State: AOJu0YyX5hTf39hsn2XErJSfrote20M37RYgQ+20T+bMfDNglMZXOoC4
	KSOZPRUSqs5DmUwl+cbc3PEq2Tf+XfTM53NLPNwEDg2Kv7K6cfH4ZEla1v/FnMssgmDovP8+0Nq
	8
X-Google-Smtp-Source: AGHT+IHvs8WWEj3p6TBwj4vs3xl32rzPrtcspSVEvP3UNooYhYk0FPySLN71TawbnGaXBKQEracfMw==
X-Received: by 2002:a19:644f:0:b0:51b:223f:ac41 with SMTP id b15-20020a19644f000000b0051b223fac41mr8206330lfj.42.1714394626953;
        Mon, 29 Apr 2024 05:43:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0565123c9200b0051d94297380sm467538lfv.241.2024.04.29.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:43:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 15:43:42 +0300
Subject: [PATCH 05/12] arm64: dts: qcom: sm8650: move USB graph to the SoC
 dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-usb-link-dtsi-v1-5-87c341b55cdf@linaro.org>
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
In-Reply-To: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lfCa8/A3WdTMZE4WDsCfE9ziDKBNSnFF8CBfBae6aH8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmL5X+mEJBHfZwIG87jh7rS6vG7tnHJWSkPk8N+
 FrBErOzJmqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZi+V/gAKCRCLPIo+Aiko
 1ZxPB/0So9yTJ2Y7nrFAv5od+5wTkS1zY1sWmg4VsLRK9Wse2LqAxQlCeo7VI4hlImjmxdPZB+W
 m23GEi1qk2DvsbmfpCd/svK0soVKO9tpMPI6K8asXArZZmVelZsF1N6xkokHv2g+yBXkHNfM5eB
 siv56DbFaOPsSjoSa8qoGlUpZhoAntl6FtL16pOETetDzLMwdzTfHeXdG8E4YYTjXx4P6PFu53u
 QC9SGs6W9G+F3RXwwWiDL0H/w1gCpMEKoa/dQ4M0TXsvCVxLtxGqSsaY2QoYljZGB0lTh0WVApD
 NIpFrjTpUmHE1AXvTc3f2XllEINuEHbyA6aZ0l10PusCCruM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move the graph connection between USB host, USB SS PHY and DP port to
the SoC dtsi file. They are linked in hardware in this way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 13 -------------
 arch/arm64/boot/dts/qcom/sm8650.dtsi    |  4 ++++
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 4e94f7fe4d2d..65ee00db5622 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -832,7 +832,6 @@ &mdss_dp0 {
 
 &mdss_dp0_out {
 	data-lanes = <0 1>;
-	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
 &pcie_1_phy_aux_clk {
@@ -1211,10 +1210,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdd-supply = <&vreg_l1i_0p88>;
 	vdda12-supply = <&vreg_l3i_1p2>;
@@ -1233,18 +1228,10 @@ &usb_dp_qmpphy {
 	status = "okay";
 };
 
-&usb_dp_qmpphy_dp_in {
-	remote-endpoint = <&mdss_dp0_out>;
-};
-
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&redriver_ss_in>;
 };
 
-&usb_dp_qmpphy_usb_ss_in {
-	remote-endpoint = <&usb_1_dwc3_ss>;
-};
-
 &xo_board {
 	clock-frequency = <76800000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 8e0c1841f748..4624ea4906d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3675,6 +3675,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp0_out: endpoint {
+							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};
 				};
@@ -3767,6 +3768,7 @@ port@1 {
 					reg = <1>;
 
 					usb_dp_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
 					};
 				};
 
@@ -3774,6 +3776,7 @@ port@2 {
 					reg = <2>;
 
 					usb_dp_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp0_out>;
 					};
 				};
 			};
@@ -3864,6 +3867,7 @@ port@1 {
 						reg = <1>;
 
 						usb_1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 						};
 					};
 				};

-- 
2.39.2


