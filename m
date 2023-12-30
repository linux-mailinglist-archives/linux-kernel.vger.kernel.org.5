Return-Path: <linux-kernel+bounces-13289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6682030B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D1D1F2303F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6BBE62;
	Sat, 30 Dec 2023 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDKqGkPq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F468C18
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e80d40a41so4440641e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703894717; x=1704499517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/m9Jpc5xx23q3C8731BxOLK6crl8Nzmn5sx1QieTmkY=;
        b=hDKqGkPqMgoml1iHuEDcJ4ALjd1xBXHfgWaDByK9Sqzb3vJejIMuRxWRjwa47KT8k2
         R4bdT7X5Edi3JpqEOEyorIU49Nsk8w3sBHUeUSgxEyrEOpid7TfnkKQF06t3dy2Tzte3
         Lki0bB0Rx8pOWZXr+iqjUMYTmt9+wt2l36NttiPf85lJG9vb9x12/mVq56wHNVeewpNH
         Hu5IwTRLWo0qplNRGG1z1iq1WJQrHDiTiwliZ1dlJsXAw7uRGWsN0u1hI11qIkLcHRTJ
         sFBJuANyPONhWldMw7Beg1LzuVGOBuj6+wltJrrRwsNHP0bbDwiDObr4WuzxWJlU62Sm
         hBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703894717; x=1704499517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m9Jpc5xx23q3C8731BxOLK6crl8Nzmn5sx1QieTmkY=;
        b=ZKGdlUbE1UAqGA0RFla0PMIyrjxiBQaKJzMkDF2p4cIcMTSEoFVXAfASXYOxSp7TeG
         Xc5DeY08jgvFzcPUG+QH1WSok33iKXE2xUco+Mla8E/Db2RUd9L3uGMZDhUKLtEz9Rxk
         3Rwy0mkIg3PliESzeI9zX+I97wEZQkSNzGIrD5g6kcuD81nPQPVG0PJ6iLNB6zFkgaEk
         9JIzz49uHPB+tW67Y/o4UEJ/m6COz5oDl/ixpIsmtqiO0KA4Y3T5Xs0o0CxOvn1nBby2
         B76OmM24Sxb8F4ir9WYWP3E3yW5qpURk3n8SbBuWM9DxwcHvUvv84eRykixbseWYV3+w
         b4JA==
X-Gm-Message-State: AOJu0YwLnkC3r9f2eLVUZtBLfVCZzUo3M0hr3JR0kRrO5Gum4+TxW/JI
	DXbGxlsUwKf7Mew9M/roZPGf1ikidFrR/3Davbf8LorhMSs=
X-Google-Smtp-Source: AGHT+IHdz1/fvS6Un0vTNbho/hESlCsbygpZbb9y90/mjEXYAAxdOr2wwEREYquLEVeLWliYR5RdAA==
X-Received: by 2002:ac2:5b10:0:b0:50e:61c0:cfdf with SMTP id v16-20020ac25b10000000b0050e61c0cfdfmr4967583lfn.132.1703894717438;
        Fri, 29 Dec 2023 16:05:17 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id wj6-20020a170907050600b00a26a0145c5esm8609623ejb.116.2023.12.29.16.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 16:05:16 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 01:05:08 +0100
Subject: [PATCH 07/10] arm64: dts: qcom: sc8180x: Require LOW_SVS vote for
 MMCX if DISPCC is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-topic-8180_more_fixes-v1-7-93b5c107ed43@linaro.org>
References: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
In-Reply-To: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703894704; l=873;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FkcZAyjsBcuLAWyHWJ3lyBRb34DTbi9Yfrno3FHjRjI=;
 b=Wl/imgB5JjpgHjAWnCZdr78L6R/wet7w0VStVYhfAznYM2nJ8TDhXvPWvY/GzZ02bBjbex7Il
 Re7sbc8s0dVA8NKT5vXIPauXEVfGiS84bRHIZB5KoxyyahmNmi8hbhm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To ensure the PLLs are getting enough power, cast a vote with DISPCC so
that MMCX is at least at LOW_SVS.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 3bb9d25b1dec..97c139d0399d 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3217,6 +3217,7 @@ dispcc: clock-controller@af00000 {
 				      "edp_phy_pll_link_clk",
 				      "edp_phy_pll_vco_div_clk";
 			power-domains = <&rpmhpd SC8180X_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


