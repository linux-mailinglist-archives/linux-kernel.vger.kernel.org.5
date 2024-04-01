Return-Path: <linux-kernel+bounces-127034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA9C894608
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170BAB2214B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3054FBD;
	Mon,  1 Apr 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti2dzJWB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F3446AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003627; cv=none; b=a3E0owV8x2UY3PzPlCtfu+vLc9Gb7UoysWx0CVIQpCSUMM84R3+3H8EMkhRI4xxoIRmVzwnyWkHxxMYPCr4FX1z6/TzR1Otp8ic5yGK5NilWCqnS2rIE73ZPR1IHjZI6Zy/cgl39SXhr0NWLU6FXM2su3ti3JaGImohBbtXM44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003627; c=relaxed/simple;
	bh=IMnWMrJva5plwLKTtuiDtd3gpNM3ZSgoTVFSaJx002Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jzwrev04vhDcq6GFcQuV+V0NKGOG0E7bv3XoSrMwI31Fp8Muv26u842sJ/B9QsLdJykfB+wfT/S/FhtUMekjDjG46LHQwwBfGE5q9LHbxWbXQuaEAvUFX4yw5EWaGdtb6/XHEkAiMiNEbwakoczq8cdP9NsPg1LsDuB4iSzUswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ti2dzJWB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ab4b3251so995016e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003624; x=1712608424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvlF6PIZ+/DGiphlCgc+bCJlzZJLRqvHDNB4freCtEs=;
        b=ti2dzJWBi2Aapn7wB7TDK5a+RIclAwePiGA40RgoQhBMyLJTY5og2VSen/dQcY6285
         xKqDVdW6YtXgNxWNGjDrz9bpqIqrIk95DERCbF2fhQLmiKHQBYez3xFIn10viH9q7onN
         megJm0zk3MiGeGLLdphEf/GB47n+xPcPamA07L/ghFnpOoKfT+ox02cTONVKfWfQKQKB
         UbL8Kwx/scMtH2Tl1Fd2C5MdpXdZQ9H4RRmfFp96u2ou9QS2Bct1ESzF5B606BolO+VN
         S1QVMwrg2pY8zC7/El7oVWISZ/+T0ah7eLMB5Vz0f/v0Z2m29+dk4OtGzR9qR5LrZoSC
         JcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003624; x=1712608424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvlF6PIZ+/DGiphlCgc+bCJlzZJLRqvHDNB4freCtEs=;
        b=MUtDw80hnw32w8ysMOFnwhC9BPs6CeL1k1FY1joENfsn7YCeWdD1e17Qc6jBuQui6I
         cUFRWHvwn/N3/IE9DxGCgqWg+FWcHwOrFY0LXrhtx/AlgjgW/uOMHxg3FoUEVafUA5AB
         tXqj9zX4+u30c/YQnOIUE6zJRqYKtbp4OVGWaqSl5d0MwfkoUHI/MGmkTMrvQjW/HDLy
         J53+8i88GL0JKT2sW7L68+gQIngNvPq78l0gX2gACucjqg3Ij+niSzSNG+eW44Mp1MCo
         sdKNzmP9Hp5X25rXC5kaJ+fCrKT3elp0pi2y9cGH1iOVUpK6ZCCYjTO5moexj052pAD7
         r6nA==
X-Forwarded-Encrypted: i=1; AJvYcCV4VGtK3GzoamejkTkr1XfV/DdIT0oG9Wlsn+u5s31S5khdDWgrJEWal+WVJkypVGv3UCsmXHUFoCUVnIeG3/7Fv50RR2PBitQqtx4s
X-Gm-Message-State: AOJu0YyQfa8VpYHpRRHb9MHRGpCDp6//92/gULSJO1l89SUZ/khXCQlD
	eHQ2EpcwUdcF+sywvCKJwanOELSxvVUoqo44ubUy0MEiEuDVIP/xb7CxGZT2tr4=
X-Google-Smtp-Source: AGHT+IFm2+9s/EaAP5U1sU3VvxclPHHFfkJFBG7g8imvZOAWKUebJWW8ITjZVXvEZX/XCr1upRC/gA==
X-Received: by 2002:ac2:424b:0:b0:515:9ee7:ce45 with SMTP id m11-20020ac2424b000000b005159ee7ce45mr7606962lfl.49.1712003624165;
        Mon, 01 Apr 2024 13:33:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:41 +0300
Subject: [PATCH v3 2/9] arm64: dts: qcom: sc8180x: correct dispcc clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-2-604dce3ad103@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IMnWMrJva5plwLKTtuiDtd3gpNM3ZSgoTVFSaJx002Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxokl48aMrRfcnGP2EioDchgzKMMzRkz1bCnC
 Qq6Lw/2wA2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJAAKCRCLPIo+Aiko
 1TFvB/9DaGH7PaDMd7tL6ZfnEx2zIwbNyJGTtoRLHBcECwwFXGUe8lty1f0SffKkWCiXJRZL0X3
 jYmEPPcMWuPLyW/tbY3Mc5xPcKDG+7LsQSHwqbEg+sHwZ+W1khjkzEWKNaxw7uXb+Itrc0kzinm
 0kDG+srL8Ijgm7AhwbetFyveTrCnAFHysyQV6ivhmrwOiaVDBO0xmKkBd4Egp1+5LHQDkVqSpJH
 gxt2RcMyb46pCLPFQSalMyfvSrvK3nT8H+kXO12tA/9s5lSqS+nfQ9GRMJ/bhyXuLj7wloH9NRz
 IP2oy4fQaBzFswwgMJYG2cZdEVtKg0LQ6RGADjcqwiCtYNLe
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Correct the clocks being used by the display clock controller on the
SC8180X platform (to match the schema):
- Drop the sleep clock
- Add DSI clocks
- Reorder eDP / DP clocks

This changes the order of clocks, however it should be noted that the
clock list was neither correct nor followed the schema beforehand.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 32afc78d5b76..a086dbe0d910 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3267,21 +3267,27 @@ dispcc: clock-controller@af00000 {
 			compatible = "qcom,sc8180x-dispcc";
 			reg = <0 0x0af00000 0 0x20000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&sleep_clk>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi1_phy 0>,
+				 <&mdss_dsi1_phy 1>,
 				 <&usb_prim_dpphy 0>,
 				 <&usb_prim_dpphy 1>,
-				 <&usb_sec_dpphy 0>,
-				 <&usb_sec_dpphy 1>,
 				 <&edp_phy 0>,
-				 <&edp_phy 1>;
+				 <&edp_phy 1>,
+				 <&usb_sec_dpphy 0>,
+				 <&usb_sec_dpphy 1>;
 			clock-names = "bi_tcxo",
-				      "sleep_clk",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dsi1_phy_pll_out_byteclk",
+				      "dsi1_phy_pll_out_dsiclk",
 				      "dp_phy_pll_link_clk",
 				      "dp_phy_pll_vco_div_clk",
-				      "dptx1_phy_pll_link_clk",
-				      "dptx1_phy_pll_vco_div_clk",
 				      "edp_phy_pll_link_clk",
-				      "edp_phy_pll_vco_div_clk";
+				      "edp_phy_pll_vco_div_clk",
+				      "dptx1_phy_pll_link_clk",
+				      "dptx1_phy_pll_vco_div_clk";
 			power-domains = <&rpmhpd SC8180X_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;

-- 
2.39.2


