Return-Path: <linux-kernel+bounces-127041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A069889461C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E63D1F23372
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815465674B;
	Mon,  1 Apr 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDQjpcn4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561156759
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003632; cv=none; b=tc7OsUiWSzABRwDYGpiyZDg1EsAPJnu5B+YjlbREu45bzlRlziYaZyhWiLTFectdiBXJ+fzYDyqNdz5uTDebuo/zJ5s388eq+TOfye4Gvrz9wZkj1tmiYCW3AGrDjtBYmTCzY79RC8cfyuF7fyE9sG4lSTqbesvH9LvPbTBeiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003632; c=relaxed/simple;
	bh=TBIiNNBgZICGeD+NJeW5hxRyvvEMnqmHX98cdDr1ewo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJT/fpYnh5pWvwb7Brcr2wWzBS8D6CD+/b1vqL8E1Knef3H3yz6yXqKkF61GdIxuWAxZLr+s6TRTz+Yqj9IXtGhxw9A1CbpWZWWMyKx5n1uY7PKSMt0YotlNMAA39iyo20t3Dn1yqavJp/vfReeVYZP7E7ELKaNk9NOL/xR0hVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDQjpcn4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e6777af4so7255015e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003628; x=1712608428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=likv4eu7xKsHRY+ZmHx+zM6NgK/jlhd2B+FPr4klQxA=;
        b=WDQjpcn4rOQZgIhRNgyDZY+O7sE6F/gVH0NobGXu9/u+XW92vXSWgZnDQcYbnrrZG4
         hicX5uu9qd6DP+WZL1gW5er75GWH0o5MQ8SPyrx9HLEWAJAwQdR+UPrnoWa3VpXOCghk
         3+3QXU5wTYPSWJ6cwYIgOHp/s7qE4MzrN1MPc01tAUJUx5bwdDojOX/AfMdfYSK+QC3e
         0850eiQs4fTcaJXxX5BElLe5R2Ab+XM/SYj1HanihrW6MBUr9pMLt4Hotl28xRbtQNkE
         qGeJjUEyPE1xeVIYqFW9/T/jq8Wd9EhCbb2OGYZLegvdqCT6xtRZtHD3pttw0Ve1rdpQ
         LsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003628; x=1712608428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=likv4eu7xKsHRY+ZmHx+zM6NgK/jlhd2B+FPr4klQxA=;
        b=DOQHWdEMB4j0Z+9ebO+bfaccg1B615UdR7kQjlSYtM2QhrovFS4W+Ep5/VqfDo9V/l
         EYfq8vusq9sDW3LNnLI+PqxBJ7M4Ho84elrHgC1ZNs3AqZGTlT/riQYUKO2mV+cixpsi
         9XUoatn7UG/CaRYdYSLi+SlkdTx8UxwMBG2c0UINBNFjsO0xTntAWDf2fU+iyt9jkpVt
         lwR/4AXdxcyQTBKG9rmGoLtb1Ni5BeZ4itO6DRzlj6T5v5d36/49xVjzKAYmZlZjOOVt
         DTueKM2EnQr/cvOqTEI8k7m6FcLm9aJKc3AdE1+di2Q+6b9LJ8xOvhcW7Vfbm+J2Jnn5
         z3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdzt0dAOo4SbB78+jJEh5P4mBNHNBRUb1Z62K57Y+BCCZGf9XvP89xs2imue33q5DGHC6rCUD1QiKD7d6En259Pc8ylNnv3XYCzjV7
X-Gm-Message-State: AOJu0YzHhvJYjLre4GdcMOjFVLfM9wH21NjfMwH7a8WaSqhJOrhzWUh+
	t3y1yU9F4flAX4mXvd+ETMjmXGEjNwL7UUPZ7iV59Okr2iB619dPBB/HNyS4pD8=
X-Google-Smtp-Source: AGHT+IE76GUEwz7lu7fLvdaKWch7gbeCYUkgXAouucZP7MI1ejx6ArVewX9ijzvV0zDf0+skLCubaQ==
X-Received: by 2002:ac2:5b1e:0:b0:514:2f24:b0b6 with SMTP id v30-20020ac25b1e000000b005142f24b0b6mr8470181lfn.67.1712003628358;
        Mon, 01 Apr 2024 13:33:48 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:47 +0300
Subject: [PATCH v3 8/9] arm64: dts: qcom: x1e80100: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-8-604dce3ad103@linaro.org>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
In-Reply-To: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TBIiNNBgZICGeD+NJeW5hxRyvvEMnqmHX98cdDr1ewo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxolctFm0CNkwO5e3t2N98mW4RdPVs1cBwY4z
 1yMa9if3LiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJQAKCRCLPIo+Aiko
 1RXwCAClh4NsehEIBHq7283mSUZkJVVAluMWGxSUsRScphIzCBljRO/jxut72DBuLsSvLnyF0tL
 epzRJvOw9jWThWPTilT7vVV7G0fRVD3ZXrDTTDXP/s6K03fR+QKKl7t/dzASP5BIwEX1Ex/MGPB
 bO0PQcEIq5XV/T8JM+ydNP4aC8kC6V/XkT7eiobuwTSB2YOpFc5kqbUfrEPZ+MJjXjakoQIXZxK
 UyB+DjPLIcLnAFUPqbNxJygbN4tOsqKXW3akMRJvwT9nsM+vKCuMb57y8suM4A/m3dsvALxKYve
 ez27JMSuC5QmLkn0hb4GBmswtd99j/C2ZTD82iTr499ty+fG
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow example of other platforms. Rename HS graph nodes to contain
'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 149 +++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f5a3b39ae70e..3213eccc3a3a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2543,6 +2543,33 @@ usb_1_ss0_qmpphy: phy@fd5000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss0_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss0_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss0_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1_ss1_hsphy: phy@fd9000 {
@@ -2583,6 +2610,33 @@ usb_1_ss1_qmpphy: phy@fda000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1_ss2_hsphy: phy@fde000 {
@@ -2623,6 +2677,33 @@ usb_1_ss2_qmpphy: phy@fdf000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss2_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss2_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss2_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		cnoc_main: interconnect@1500000 {
@@ -3445,8 +3526,23 @@ usb_1_ss2_dwc3: usb@a000000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss2_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss2_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss2_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss2_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -3514,8 +3610,15 @@ usb_2_dwc3: usb@a200000 {
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
 
-				port {
-					usb_2_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_2_dwc3_hs: endpoint {
+						};
 					};
 				};
 			};
@@ -3590,8 +3693,23 @@ usb_1_ss0_dwc3: usb@a600000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss0_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss0_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss0_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss0_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -3673,8 +3791,23 @@ usb_1_ss1_dwc3: usb@a800000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss1_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss1_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};

-- 
2.39.2


