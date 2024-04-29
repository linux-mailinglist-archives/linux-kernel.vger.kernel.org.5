Return-Path: <linux-kernel+bounces-162267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1988B58D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C27285E05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B36FE14;
	Mon, 29 Apr 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrwCKKB+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44EC15D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394630; cv=none; b=W22UjGpF0f4lNqCageVZSIb4OtaY5Pubf6gBMag/7em2dx0EqzXCiSsJEN099W8wdZNrq5nSwVW7DkqnRiAMD0KHvXyFUjs1KmLS1S0X26W3N5cAMh3B8Dn9RAJGMFRanM0c4ivdMZW3+ErXL+U5MZWkd4LPcGT3rAaC28kYJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394630; c=relaxed/simple;
	bh=RGNZENRA+0alhCGOoQnLbz5uRpvQV6/VtrC4cdvI25M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mws55kT7WDbvAnPyrtLVcZubzo1u36aEC1RI4Vdwa2DU4jB55Qwio3wf2beS+/lBUTBZQcNWpJtvTzXdjeVd/Kk+zC1myUJiZ6AtBF7XhtSUAkwtKFTY128Sp+JYw8I600uLPlz9H6YrauLlUta0l2h3/iOnWDFS4q9LtFJdiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrwCKKB+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51e1b9fba81so158690e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394626; x=1714999426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRvNNTfWi6a7dwHJEWEhcluXY/eX8QPuZTSxnvWt3Os=;
        b=wrwCKKB+ud5q1H+H8/Y0A1AhWE4R65P41Ws/fAq8psctV5TxmWuAU0LPYwNn3/F8SA
         622QyVt279Eg+44TC5HcfwXTGkIiiMXSRsG23j31M6GAsr3Sjv3na8dvYuusPj+q2aRf
         ZoGCHPujqy6OmM3a2Mp7boSszsgMBEKOVMgG84Z5fIljxLZHfmphZ8SjTkIua5f0tStm
         1ZPdtfYLnhkp6hX4f1H5w/Q4h7D92FGhYfzI+s/sFa8YwLS1KAyEWnmOEZPLqOAcxJpG
         EVJRKWCY6XdvMW7PKkkP4qUW6WxyxgVkq+pYLdUX+Slbk4rNBFByEdqwyjpznJPxf+7B
         ywSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394626; x=1714999426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRvNNTfWi6a7dwHJEWEhcluXY/eX8QPuZTSxnvWt3Os=;
        b=RxztZdx4EZmFVNjF5jVUxHQXK5BtpD9PcefvbNZlorBCuZvwQ/gISejgzv0ph4voiO
         iY1BNwA67syC1NmkulPJOO1k6apX7opgl3RqbyBhhHsL7ASnWtOaueyhsCRINFJlOOTk
         LuR0oGELce+7G0zoFRKexnr4tiMkQi6XeliRNqRGSfVR724DQlq/wZT01WDyB3FoAn77
         5BHYW6sbHA3ZDCXi40YkIQ5l8NZcQUhWhOXaEYG+3RrBH3cDBL23Ti/YnAAfUsJoZxuB
         JxnKZOK2oy9YPeNo3zFYlamBNiDjwugFfyJ8+mnVdUxrlWq+7M/0PuiPgzgLoh/ySOe6
         aBvw==
X-Forwarded-Encrypted: i=1; AJvYcCV3HHB4HrtuGnMl3RhOZVfcs1eXlrgS+Gxpkz6DJoszX4DGAQR0DWMuPvgsIlbOSH6fLLcbXhbqucHthrPsZN2AlAM3iWnlqCWdnQfJ
X-Gm-Message-State: AOJu0YzFa9Rbmejn3BXwm8txPMZjB1eJGHngYebVCcYTnvaXl67nm7oN
	I56Ev7g9TMW4kP4MoFPKziG0Hz0zrI69SGDbwMXG/5SXDApf3rKrPsPlIqGodwKBdaJ+LjG+8gf
	A
X-Google-Smtp-Source: AGHT+IFtvqZQxZxOfV0zV8OzIEN0nYUSLW6OP6n7jHcrte32mYuaiiIx7wOX7CCiXfqoFWjR77RRMA==
X-Received: by 2002:a05:6512:1081:b0:518:c69b:3a04 with SMTP id j1-20020a056512108100b00518c69b3a04mr10411503lfg.0.1714394626366;
        Mon, 29 Apr 2024 05:43:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0565123c9200b0051d94297380sm467538lfv.241.2024.04.29.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:43:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 15:43:41 +0300
Subject: [PATCH 04/12] arm64: dts: qcom: sm8550: move USB graph to the SoC
 dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-usb-link-dtsi-v1-4-87c341b55cdf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5277;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RGNZENRA+0alhCGOoQnLbz5uRpvQV6/VtrC4cdvI25M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmL5X9Ypp3cFmtJ7OmMsknUpsvfAkgnL6CLfDHy
 81iHH9dKK6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZi+V/QAKCRCLPIo+Aiko
 1S5VB/9rO3CMRyN4wYvwNooFwP7MPs9MvDZdm+rczJkNhLBVMdiWe2jJTLHVV4QUs2l8Bx3Xg6I
 Tvc60MUxwseH2QBHv6DkkbWGvC+HXh6eg4ZcLpxZOScgV2YekCNWmalWzGVYHorJLuT4W1iNNU3
 uNIujtLXp7NID1I27OtJjTwAhITKB/9OF1f9/mWm3QGGY2IMBsrEwuWQXkQFSGi6Fk6/tvEdN4a
 azxx+MA+5Hz913JkAVAcbufxpaMN1dzw4ATM3YDsKWMBghWczJRK4BQb1mr6rioNwfkOKxxnyvA
 /smC+bzgP2TlGQr7l6lBQzY8C2gYtEQU6QBs8Kt2ClIPas8O
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move the graph connection between USB host, USB SS PHY and DP port to
the SoC dtsi file. They are linked in hardware in this way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 13 -------------
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 13 -------------
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 13 -------------
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts |  8 --------
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        |  4 ++++
 5 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 12d60a0ee095..f786d9114936 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -940,7 +940,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 	data-lanes = <0 1>;
 };
 
@@ -1267,10 +1266,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdd-supply = <&vreg_l1e_0p88>;
 	vdda12-supply = <&vreg_l3e_1p2>;
@@ -1289,18 +1284,10 @@ &usb_dp_qmpphy {
 	status = "okay";
 };
 
-&usb_dp_qmpphy_dp_in {
-	remote-endpoint = <&mdss_dp0_out>;
-};
-
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
-&usb_dp_qmpphy_usb_ss_in {
-	remote-endpoint = <&usb_1_dwc3_ss>;
-};
-
 &xo_board {
 	clock-frequency = <76800000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 3d4ad5aac70f..56800ab903a1 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -736,7 +736,6 @@ &mdss_dp0 {
 
 &mdss_dp0_out {
 	data-lanes = <0 1>;
-	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
 &pcie_1_phy_aux_clk {
@@ -960,10 +959,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdd-supply = <&vreg_l1e_0p88>;
 	vdda12-supply = <&vreg_l3e_1p2>;
@@ -982,18 +977,10 @@ &usb_dp_qmpphy {
 	status = "okay";
 };
 
-&usb_dp_qmpphy_dp_in {
-	remote-endpoint = <&mdss_dp0_out>;
-};
-
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
-&usb_dp_qmpphy_usb_ss_in {
-	remote-endpoint = <&usb_1_dwc3_ss>;
-};
-
 &xo_board {
 	clock-frequency = <76800000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 92f015017418..d0b373da39d4 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -807,7 +807,6 @@ &mdss_dp0 {
 
 &mdss_dp0_out {
 	data-lanes = <0 1>;
-	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
 &pcie_1_phy_aux_clk {
@@ -1144,10 +1143,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdd-supply = <&vreg_l1e_0p88>;
 	vdda12-supply = <&vreg_l3e_1p2>;
@@ -1166,18 +1161,10 @@ &usb_dp_qmpphy {
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
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index 85e0d3d66e16..7a8d5c34e9e6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -746,10 +746,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdd-supply = <&pm8550vs_2_l1>;
 	vdda12-supply = <&pm8550vs_2_l3>;
@@ -770,10 +766,6 @@ &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
-&usb_dp_qmpphy_usb_ss_in {
-	remote-endpoint = <&usb_1_dwc3_ss>;
-};
-
 &xo_board {
 	clock-frequency = <76800000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index bc5aeb05ffc3..3ada5a30ecb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2910,6 +2910,7 @@ mdss_dp0_in: endpoint {
 					port@1 {
 						reg = <1>;
 						mdss_dp0_out: endpoint {
+							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};
 				};
@@ -3186,6 +3187,7 @@ port@1 {
 					reg = <1>;
 
 					usb_dp_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
 					};
 				};
 
@@ -3193,6 +3195,7 @@ port@2 {
 					reg = <2>;
 
 					usb_dp_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp0_out>;
 					};
 				};
 			};
@@ -3280,6 +3283,7 @@ port@1 {
 						reg = <1>;
 
 						usb_1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 						};
 					};
 				};

-- 
2.39.2


