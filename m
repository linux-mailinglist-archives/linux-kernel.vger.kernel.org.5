Return-Path: <linux-kernel+bounces-162266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EB08B58D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBC31C212D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F82954915;
	Mon, 29 Apr 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="creHSdal"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0247175BC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394628; cv=none; b=MkNk3sfgBHjHF4ZDWivVBeOaecNdD615uf8A3ZfvjcDdVBbu6DEjSnCZLaN2WeQcJCol6tTnm9rlN3Ifta1BzjwNZhOTZN6DaS4R6O0Ro3w1SK2ZdNNTXjkbG3ESvOTJ1k2DjKb4Msrs2n8vXWJ+nJgO+1D/hmBITRUMaQY9Wy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394628; c=relaxed/simple;
	bh=NvAJ6b5ki1+dCqAxlvXfYm6SnEViL6U6fNYL2uOeV1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJxcmhVFHbEJAUcqyWC77yMH6c/OgqLr9xCTBxT128NTE3ExCJgC48M0S7MdQBl7kfuHS1sKeLV2vR9TdpfxDkZ3ft8yBjJIBmmAkbx/jqGXGI63ZTnltLMimIzscDONhhUgvxnMevXQD2mIImVVRG7LpmPWL8FIBBmSMojhTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=creHSdal; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d264d0e4so5012926e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394625; x=1714999425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99aJ9PJ8mQRoKAE22+Ctzat8MiNYAHOyEO7AxLly9l8=;
        b=creHSdalZehcvJ6lNUCCLz2AHUfyOvVD+0lyuOzOwhOJkYixlqibw3r2F7R5qdgg8z
         8WbQ9/dTB33iax78SX2iZHqOgek2tkumiu6FoCx9w11g6fxUZaeAjH8GkEmdG+wb1cAY
         hUFfDFk1c5+oUlqsI5uhGT2VCxiIqPSeRGKrFxD7LkAb641aBihVLOZnSfJV8HouOUdv
         0S2mVPVtL7nBz5hjwIxaOdeK8/JBrdf69PUEORdjwVa4HilhCdpEdSGH+NHLVFrfmYHP
         stmq5Z/etCGxLmsRWwU3sAlKvh1//roDt23LzKfCQ+8yAK3inHhWCEf3GrWiWiC4S/4W
         IVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394625; x=1714999425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99aJ9PJ8mQRoKAE22+Ctzat8MiNYAHOyEO7AxLly9l8=;
        b=sN5thjza+gT3OCglhfg8MZZgUaYr8hfyVY+vLVA4JlBz/WxtmxuswD18RsZ8FOwPHZ
         r1A6QNogwFDDNH27TQY6CvoH69F1rQFHOkrs1kVHIUbIBctXmo86wDIXz0KRT8jAW7iG
         NbIF/BN4Xb50ob3Agt4mHjvd356wDJSEXj4AjWooEZYI7G8eK/p6KAm2ICb4kIfPv5iv
         drs1w/uPWokiYTNm7h9semGlYomqdURPKZnYKvGQa79rt9nCTNAEUHZeEKDfrbxxZxqG
         bKj6bLS8Evx78znGWcrsv8QKyixyHaEZwU0FMSK/AtvCfF/exjOviGaXbdsTDAGXWjcg
         nWCg==
X-Forwarded-Encrypted: i=1; AJvYcCXHd5Hlxt+7SjvN/1E69ekNJu1XMbOwaUglsiuFvWGU0M2+zlGIVp8ZnEiwpcmjca+cQSy59ovZMMPuZg3K74aptTiThXTzyhhIfkFD
X-Gm-Message-State: AOJu0YxMWomM+EvtYAB70z7xV3JbCMfHcCTuU81IGzbqfKxqZkxVEsWH
	hpb0iRVPnD5zky136yVyBBWDuBKbYCUUJuVaJ+vDCEpY2MGbYAClB61EJbc1ylxv8iUxSE/fLz/
	9
X-Google-Smtp-Source: AGHT+IGH6nbRRR0+Y9otM6dog5UsjoMI6emEvga4iftex/xtie9D7dOF/teX8edk5NQd5GpMhZPwzA==
X-Received: by 2002:ac2:4e0a:0:b0:51d:a98c:11da with SMTP id e10-20020ac24e0a000000b0051da98c11damr1243107lfr.12.1714394625132;
        Mon, 29 Apr 2024 05:43:45 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0565123c9200b0051d94297380sm467538lfv.241.2024.04.29.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:43:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 15:43:39 +0300
Subject: [PATCH 02/12] arm64: dts: qcom: sm8350: move USB graph to the SoC
 dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-usb-link-dtsi-v1-2-87c341b55cdf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NvAJ6b5ki1+dCqAxlvXfYm6SnEViL6U6fNYL2uOeV1I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmL5X90J5WrU1bAzSOZ2L+UKIVkd53i8fy7x58D
 rZGPJdTJ8OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZi+V/QAKCRCLPIo+Aiko
 1XG1B/9Z5ruZ5MJNx1pbR2KYsy8Ehr5dDZYbuvjo6GCnS6myfxfySRVbNPR25pHM95kHb+9RscA
 2zzdILsAMR+g5vIAU4l2I8gR6Yeifb5CjXB4MkNVHhVc1rkoU206CiQTBaxyeCutMN2qzoGNLhZ
 0++iEWzAb9K65H2HMGpWc+tDDtuJMmD+OZVqgNYgz5tygJnG5lg0KYETmMiIKH3I7+xgiJNytEx
 yyKAUNS0BSrNXoSg3NQZL/U+2b4VknDJrAOJqe+UFYy/Oq3OXcdWI+DzZalkvO7Gg2PLmDIRhRn
 EvWQBx+9AZl8BttNEzHwxcXY4KW2RWGJN6TAM85VvAlZ4z+h
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move the graph connection between USB host, USB SS PHY and DP port to
the SoC dtsi file. They are linked in hardware in this way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 25 +++----------------------
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 11 +++++++++++
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 4c25ab2f5670..81e5577cccb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -486,17 +486,10 @@ &mdss {
 
 &mdss_dp {
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mdss_dp0_out: endpoint {
-				data-lanes = <0 1>;
-				remote-endpoint = <&usb_1_qmpphy_dp_in>;
-			};
-		};
-	};
+&mdss_dp_out {
+	data-lanes = <0 1>;
 };
 
 &mpss {
@@ -864,10 +857,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_1_dwc3_ss {
-	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
-};
-
 &usb_1_hsphy {
 	status = "okay";
 
@@ -885,18 +874,10 @@ &usb_1_qmpphy {
 	orientation-switch;
 };
 
-&usb_1_qmpphy_dp_in {
-	remote-endpoint = <&mdss_dp0_out>;
-};
-
 &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
-&usb_1_qmpphy_usb_ss_in {
-	remote-endpoint = <&usb_1_dwc3_ss>;
-};
-
 &usb_2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index f7c4700f00c3..24c42f285163 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2273,6 +2273,7 @@ port@1 {
 					reg = <1>;
 
 					usb_1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
 					};
 				};
 
@@ -2280,6 +2281,7 @@ port@2 {
 					reg = <2>;
 
 					usb_1_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp_out>;
 					};
 				};
 			};
@@ -2405,6 +2407,7 @@ port@1 {
 						reg = <1>;
 
 						usb_1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 						};
 					};
 				};
@@ -2626,6 +2629,14 @@ mdss_dp_in: endpoint {
 							remote-endpoint = <&dpu_intf0_out>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dp_out: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_dp_in>;
+						};
+					};
 				};
 
 				dp_opp_table: opp-table {

-- 
2.39.2


