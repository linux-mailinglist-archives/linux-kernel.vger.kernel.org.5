Return-Path: <linux-kernel+bounces-125942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF41892E77
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024E4282494
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8240184E;
	Sun, 31 Mar 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pO3DIasW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060731C33
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856940; cv=none; b=ulYqz4oG+sLwX02EFj6w/arlvMiXxP7/+P/p10VQdEnwfLQzUYmIpEIA2cNbW332yhbEg4uLvK6ONwB26565Z2/AywX8yG58Rj9KGEyKUrDPF7rUxo5P1njjJSz1TCHadM3kz9hBn8m5pd+2aHYFtIUZFaQKNzS2pCrJLUlEev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856940; c=relaxed/simple;
	bh=6si3gBmbo9hW2Dn7hkIjEsjv5s2gkDHJdnkmLUy/Hlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpikSdOXKeuWgx1G0qUK6Wj9wT7yuX/ZaYbsvJjR2iNlMJ/DqNMRZ5p4EWGgSB78/zs3ourJvCkidSiG00EbEqoD3TuzTafZtYPCLKRWeBFsp8lsSB1KTKwzbVc6NH3f19SwtyLOLBStbuqqKLGa83EYJ8ONb2bI5g50QEQ3WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pO3DIasW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e89d0816so3522163e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711856936; x=1712461736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrjDE8MiuiJdDcIyM4PBx9cbplmfRZdA0Hz/5oAovCY=;
        b=pO3DIasWjolX5LR+nb+sauHqmqMVOWK9WHRYZ187ESYNxu2DK2pc0c/rzugJBRDZJT
         9j132+m2/IE1qFil8IwJ53lBkg0ztrTTOt6p/ziuok7uf5MUVH+bGnl/JDEKHNYswYK/
         6YhRKu0jxbSMod7/t0Wl/mNZXUX/O1Nc6l011xQdIAVUjIbFodESrQsI9W+IYER00c4/
         AZLAs8Ez6X1YDzEhHe3Pk6uVrQuUnikTdAeQIfR0mnE4UL3/KOv9yJXCkbLXkoLt4kuu
         HlBEHgN0EdwPCy7A/Tm+X147Nenoqccw0CTZ8RkEdlLed0rJFFiXAhl/KVjQ89dynKoY
         juxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856936; x=1712461736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrjDE8MiuiJdDcIyM4PBx9cbplmfRZdA0Hz/5oAovCY=;
        b=tutwdP9H1uNPCOc743DNc8fsjuMecwUloSE7HyoyrS3OKPkfhKWyUqBm96sIj3Oxft
         bVdXHN0JO6pqE+GxtLn88epAOLvKIUk/BceHo1oOIO0m34K8y4nRYPMXCP+eIsWwXZ8L
         v0dG8MbdGvB1p9e060s+j4Y4y7x3Ul4ZkS1/0641Mk6wtu62NP8vNqxlMEt+y5lszTnT
         rvVmBMjnQBZTTVSVAqZotEEzEOmOl3D8t8jArjAI3dfeRE4wzkkjqLlPRDz7eMTzt5vS
         384ZmD/d+M7tU8oF3V1D1GlxIqQdzeC8FuJgc5YAEZZRZat2gd8WSsaks260Z0ynVxES
         XwZg==
X-Forwarded-Encrypted: i=1; AJvYcCVf832dR07SbEavUBaR472gZoS02U5lTZ9Yh2uD0dPyIDE+Ev5QGHxxQ7X/aUHZMFKFuY4KE3DmTZaPKl60V7CuE55Op7HaBoy7IQTc
X-Gm-Message-State: AOJu0YyW5v9n9xj7dAI5IjMjkQ1lCOL7gqrrCGO/EG7NqTpGnXpU1sBS
	xsASN82wbDVzBROg6IFoUXbMMMrnmSNGpyAkEM1ebckTuPW/QfqIPSQ7aJGx0to=
X-Google-Smtp-Source: AGHT+IFlfukMGy6CQVit3oZ9NHmT0ghaXgkLiCkU/jTIojRHtJdMuSvhy9Y0/ClxDFMjYxT3BXj6eQ==
X-Received: by 2002:a19:770c:0:b0:516:a77a:9a7b with SMTP id s12-20020a19770c000000b00516a77a9a7bmr198687lfc.52.1711856936227;
        Sat, 30 Mar 2024 20:48:56 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b00515ce9f4a2bsm762980lfo.35.2024.03.30.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 20:48:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 06:48:52 +0300
Subject: [PATCH v2 2/7] arm64: dts: qcom: sm8250: add a link between DWC3
 and QMP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-typec-fix-sm8250-v2-2-857acb6bd88e@linaro.org>
References: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
In-Reply-To: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=6si3gBmbo9hW2Dn7hkIjEsjv5s2gkDHJdnkmLUy/Hlo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCN0k1mckRDq9DyYIIFsWsnFESKj0BdPUSLm5V
 yopSvES4LCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgjdJAAKCRCLPIo+Aiko
 1YVDCACPdVhQh0f8lHkDHKGLjQT/Iibqsjz7P0s02+FIY+pCezTZw+0wNYI5T7tqGyGLxxit4pK
 uVgQDCxfm0fx2jG7bcQAG25VqqFiMvLm/VT3Yc5CZoGfk9BpAfn0DiOnwcSdqMAyI4hPdiA1gzd
 fkZE2UrXzCIzyF1VEyCMcksHF8yPeoNJ02DLBUvxgxILVB06e9svPf3bMJjhvTHD3XH/KbqnS2u
 Q8zsuJTXZDiZJr5l1BNUuwHgpXLWTRlAjaivObWc9iwbWhdb6DBAiOQ8stY3OxuJ8O4+ekTdcOy
 0xoVFkvaCRzdOSCqQROFiGbJc4We1/wMmR8dN/TrmQocYNld
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SuperSpeed signals originate from the DWC3 host controller and then
are routed through the Combo QMP PHY, where they are multiplexed with
the DisplayPort signals. Add corresponding OF graph link.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 440bbb89bf8a..cfc07dd9d0ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3917,6 +3917,10 @@ port@0 {
 
 				port@1 {
 					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss_out>;
+					};
 				};
 
 				port@2 {
@@ -4195,8 +4199,24 @@ usb_1_dwc3: usb@a600000 {
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_1_dwc3_hs_out: endpoint {};
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs_out: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss_out: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
+						};
+					};
 				};
 			};
 		};

-- 
2.39.2


