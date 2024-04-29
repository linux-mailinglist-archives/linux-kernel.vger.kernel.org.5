Return-Path: <linux-kernel+bounces-162272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852F8B58F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1282DB26386
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1B7C098;
	Mon, 29 Apr 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfiSf5T9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E7763FC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394636; cv=none; b=JhHCITjCqqXGkZf4LHkUIX94M67zdcklPnfr9xDEW8UHzMfdOCiIyxt8kbSt4QJeQ1iq4uL2MT7IP4uzPsUbGvW77oIUJvEoyui2p6Zq2I1q32wGLQftBKemO9VapAdZZGoJhmOOcdIUf4jH9+tv89WAqjkqGFFLm14fgSRdupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394636; c=relaxed/simple;
	bh=mB5dNHE33/I4OECIdcy5yU6UtG47DTMDpY7rm0u1Cm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ivybrm2zyUr9Ep4OWT3PyVh1oE6KuhjSZ/xTN0eE1Nw2kH5n7EASmMCnHPEBdWBO6ylPrymkkoqg5z58dg1w2DxnrN1fypOU0QQWGCX8X0gk7Nk9cErTUkY55LdgzCVu83gRxqA48E01ywSD6YD4ZQ/Ft+5vx9dVzN2scxhcgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VfiSf5T9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51d62b0ecb7so2095963e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394632; x=1714999432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUwgFYdQLO2Q3w1p3+vSbtqETEr2mAj9TysZNWquXQI=;
        b=VfiSf5T9rkQLFB8iFgsNSQRd5kJpDUTJWAL9WgeHEdXdt+m0yz6nZgfG1W+rs0hCXK
         Xt/cAawBgRfJbnFvA9VSY0GoUnplpqZAjmUXO2zAElUl8om6bWrNvlQd/IB+u8gprsFc
         r+4j72iWRT6mRwcZSkeHP43NW/IJPrjuidpKMb/Cd5ILKtoymwQec/0+4tz7XVmOydEN
         ScvM/K9N6V+UMhyQ9trD+YSeI+BV5Cl4DNuVdfAV0Q7zMnpNXgqtErjz9pg5vZrBNrL+
         0fphw1BwlBSoHc/YGic0RXzxbuZoAjf/Wql+/Rp9+Xr8k6TvzuO0+6Al8mlfMOMHWDyb
         s2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394632; x=1714999432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUwgFYdQLO2Q3w1p3+vSbtqETEr2mAj9TysZNWquXQI=;
        b=rA2DRGvSl4e4QVvzVoVwqQPzGaMceTuBHo/bPoBD6526UgsjtKQeA0pqcTMDEtyk3p
         u3/y2PhdP5ryJj1sdlL8zrdF8RprSXylpZGu0zz/csT9/Ya770YZEYnuP429dfrTVtQ8
         066yGLHFV1nrV/O3OlDcjFFalPMlhREX99Xd2NmsAF3IQsB4l6yYI1Ggmt6Nzwk1cetV
         rKvopaliMS3DsA8+7KZet7txyk0++W2YEvD6JxVN74V45kuEXCXaXyjvPodd/ygBuF1q
         UqwHcumW5XqtKH3UKtWYdZIUESpM+aBKEI4A5lYxyAPe1e74yX/4e2ixTHCkLB7SXGoI
         iTNA==
X-Forwarded-Encrypted: i=1; AJvYcCVWixttuo245/c+PpnDRO9JiLEXydZRXSKbcbt9sBBLjYDrFQAvif3FD82//qOCcIOiubpaQ4UPx4h9AnN2pI7GeyGq3uh8+QZUZOpv
X-Gm-Message-State: AOJu0YzIt8AWReIv8D0LdQhspW+RxrUlVxzEN+udvTR2FsNJqvLtD7yP
	eeQwWY22IfMcGX7LbSrL3XG7HbFHK1LcJ0FoR82oYIXzeIvHh2H3Qi0qoyPKQ1duiZqk7sP13F5
	L
X-Google-Smtp-Source: AGHT+IFfoZ81l6o5Ix6rjxxP66bHvmS5cReAVsX5CqlAivfxhsmYlrOu/E9gkANeWU4aJMDBfnhTZw==
X-Received: by 2002:a05:6512:329c:b0:51c:778f:b569 with SMTP id p28-20020a056512329c00b0051c778fb569mr8460407lfe.29.1714394632655;
        Mon, 29 Apr 2024 05:43:52 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a0565123c9200b0051d94297380sm467538lfv.241.2024.04.29.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:43:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Apr 2024 15:43:45 +0300
Subject: [PATCH 08/12] arm64: dts: qcom: sm8550: move PHY's
 orientation-switch to SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-usb-link-dtsi-v1-8-87c341b55cdf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mB5dNHE33/I4OECIdcy5yU6UtG47DTMDpY7rm0u1Cm8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmL5X+nPdLahY2uQ5qROmWpmc3j/yqcMyopWIHl
 DGYKKIINOqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZi+V/gAKCRCLPIo+Aiko
 1Zz+B/4tZFDbbOPkCCgOLpuPHfogNtJYpeHcw518Mn+XuWU/wRt6X8o9D31yW7GuGTyeV2t9c6O
 Za3i387gBeGLNPfFV47XYGD8iNW4PJAJ+qw2dw9qYdY716cdLxH2VTbaYeuVcTn3h4+NJWKCgcQ
 VBO3DaaEC7jTPStT63EZcTl66wifl0AuPECa4FyE0vDdkYbed5fj2uFZC2wc7fREy1JucdcP8DS
 1S8mt3IAaULJG+n1FoswX1KH6W+AeNuohje1QPry2+uHxzzLNBgvKZg9LWfvyY5SEWiJnEy1nFa
 DsVf4miJyLkF3SsCXIsV7t9iu1RzvSA7Kz+3r5iVSq1CVw6i
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The orientation-switch of the USB+DP QMP PHY is not a property of the
board, it is a design property of the QMP PHY itself. Move the property
from board DTS to SoC DTSI.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 2 --
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 2 --
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 2 --
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 -
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 2 ++
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index f786d9114936..98934e4a81b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1279,8 +1279,6 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p88>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 56800ab903a1..d3fd00176233 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -972,8 +972,6 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p91>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index d0b373da39d4..1d487c42a39b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -1156,8 +1156,6 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p88>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index 7a8d5c34e9e6..92a88fb05609 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -757,7 +757,6 @@ &usb_1_hsphy {
 &usb_dp_qmpphy {
 	vdda-phy-supply = <&pm8550vs_2_l3>;
 	vdda-pll-supply = <&pm8550ve_l3>;
-	orientation-switch;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 3ada5a30ecb7..9980504f66db 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3170,6 +3170,8 @@ usb_dp_qmpphy: phy@88e8000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			orientation-switch;
+
 			status = "disabled";
 
 			ports {

-- 
2.39.2


