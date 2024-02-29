Return-Path: <linux-kernel+bounces-86731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547886C9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D9DB25C94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A61339B5;
	Thu, 29 Feb 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7fTHB/z"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69B86275
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212039; cv=none; b=LYrmU1imdbW2OETRtDsYzLQXI/45mrLDOCpgn2bBYFPdweYp3oQcKZELpwyvXeMjGZ9sh1sNqMn3iwFhaH54LYW3c7mAS8jLsu85lz/omMgspPu09vX0bNCo3RzlEOQpfSGpyevkmCavF3oxJPZMgQPvTqt9X/sADiXexCRwa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212039; c=relaxed/simple;
	bh=AX7XuHTDoRahKMAp+cH7GEaNZR5Qd0pBmGI8tAPbhQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVtyeJtjs/7nXTSda7w3x4vW7WRXHEYbp3q9I26Ehat6mrCbPHY1tzauhjxxV0t//hCpLb7SqMm9JOp9w8V8rpomFVLrLQY1XN89mZuuHfqYkiHM8EiTlk4KfV5V3uc+7ldbX+mvhmri6F7erlbMn5mdZSuN6n64ui4xljPmx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7fTHB/z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27184197cso10019701fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709212036; x=1709816836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt1W5faP85PAWQumOAeVXjmBkQB+qfkabp5eD5nJ+aI=;
        b=Z7fTHB/z/ChMs8hTmzpjzsdlS3cdo0i8VLqp3lpnnU3LITHWdp8whIkCfe1RF2BEVC
         Lq6CWyGOHTnsTe9GZzlYXSAwH6cLVagSXEExyt6xpS+US7kvHcgh6zOKioFA87FY6DeM
         adOKX00i7NtcmgsjKDY3ZdepR1QZPSQQIIsJXujbPsRQ2DH9Gupw/ycxP1JeRatI+Y3u
         F0FLLgbmuy3aZdKtr+GmwALH8ZqOjVgOv6eLhlVLtBJMS75NNJo4s9k8wKE6i0xHXFEa
         hYOS/D1yrbqAFH34bPG6CqAt7SW08FN1ahOSkv9glugdlaLUxwh3ks8141y3LS6gXof/
         GfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212036; x=1709816836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt1W5faP85PAWQumOAeVXjmBkQB+qfkabp5eD5nJ+aI=;
        b=YwJMvWITgM0ZnBYcMnP7DCISbWPle4STFE1ECYpzGqfm4QRfOikfDaLddraDTplYyd
         Bw0bYNxisdyMg7nGxxdT7uDoFFhvRg/rpYy4w6oPSV1jnU3waqfiuDYSvb66PiAXrVTO
         v2sRY9EmwhpRyPeoyOlenMJacfU3ufshYS4iToZrZog6opp1WBPftnVqaLQBHdw7ftOm
         OXGV8u8QMxXE2uRfzJcp0+yQHx3Ltl3d8lOCs2BgQ+iHldZg6TDfwC16WU1+CLAMUfpw
         YxYukvslmcOvOd4qGOhvw/YfuQW9nANDUvRMm1wavRyR8Zo2wL6+kxie5+DD/NzeV/UX
         uVhg==
X-Forwarded-Encrypted: i=1; AJvYcCVGiPZ+W8W+yPClyBbch7aZubn45d+MiQ/9kWcNxfzP4oWQIF7Wls5qud4iZQtLRUwuQZrXYGrnVJmhuScFQYx55SJkGydBURK5vSFG
X-Gm-Message-State: AOJu0YxlhTeOKAZFK/WfTExr3cO4kkLAU2IE3p5nFci1S5isCuOGkU2/
	jsQt/P0yOdjZSEIi0sl1WzYWD+pLP8RZg9f9yX5UcVivX1pfPh2M5G+yOBYBOW0=
X-Google-Smtp-Source: AGHT+IEC7e7Knw0M0ILVJfYrukKdzBj70uBdk2cN9FZc2XJm4ZtvVGGvMvO0ORqpmrytaQdJgTB8Uw==
X-Received: by 2002:a2e:925a:0:b0:2d3:1f1:d408 with SMTP id v26-20020a2e925a000000b002d301f1d408mr1330088ljg.0.1709212036293;
        Thu, 29 Feb 2024 05:07:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b00412a38e732csm2071473wmq.35.2024.02.29.05.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:07:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 29 Feb 2024 14:07:06 +0100
Subject: [PATCH RFT 6/7] arm64: dts: qcom-sm8650: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-6-07e24a231840@linaro.org>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AX7XuHTDoRahKMAp+cH7GEaNZR5Qd0pBmGI8tAPbhQ8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl4IF90QBAS6ajIUqSeE3L+wyYvQnNnniQUAW+vzOK
 eUT0lRyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZeCBfQAKCRB33NvayMhJ0QSKD/
 wLsTQUePv4/u6Ehr2mKU2piyxeS9kM3cXKqGejQlkzPnv3M7ZpQ1aBv7bEybprYefYzmXUYhUsZu3W
 si2yvhUGPAzp3Sp8LlwlewM2vSXzc8/dHPlbsKwv4fBGIu6wkmSmMPh/Hzq6Qegr15ZiRoIwqcYcEF
 dKgPUOOx+LnCqhDJSBBTXRg/O8bSk8BvbKlrHBDZg0p9tnCNCelDCX0LnmGkx63qAShDfeo7p1zaUa
 7BLK0L7awpxrpl3lQS6oFuwASHNvitTmtd7Frdj4/jeLwpFUKtsgshPB9Sq9q4aww1I9bbPV7TuUZb
 IpldH0pK/KF/i26xmmnpEkb6O2xZ9cF9YqnO/NHs50dFxSr4ib8ERzmxoaIADSg7iMDqg7U+zn+t5r
 eAfx5xY93P8F5XhOfNlP2VUy/XEedGbsk1kkKUqk6yTTRhRLb6bygCTJ+gA/JUXfUhJ5VDkNKeQcIa
 DNohs2UT28UVehlsWXNVXi70MhrhPf9dfA8OP5hRoeDyAcaZAb6tnFqFLQm+Fgc8bw1uV7VDjZPGuW
 VF9yUabDeOmONuSFiF4bRDvPHbsPS6Vh8mgp8jnV/mR/BHMQGvDwpKjx3k0rYMAj9Hv1DV5mEViwKh
 P5oazDg0p9ax/nYsywImDJ0ACTkhQEJGsapxg10X3IwPZw4enUXIf2fWTOEw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHY to the Controller
and allow mode-switch events to the QMP Combo PHY.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b07cac2e5bc8..35259ebd07ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -823,7 +823,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 };
 
@@ -1224,6 +1224,7 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3i_1p2>;
 	vdda-pll-supply = <&vreg_l3g_0p91>;
 
+	mode-switch;
 	orientation-switch;
 
 	status = "okay";

-- 
2.34.1


