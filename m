Return-Path: <linux-kernel+bounces-38260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37783BD47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8A728B955
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34101CD01;
	Thu, 25 Jan 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ankrfSQA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262F1C6BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174889; cv=none; b=W4UBPRgAL8h5Gk/5cTmAja1MPSn4vgAmJnUI1PuGTXvq//3tVai/7vcFwBe+5o8KqPeYRn0iNnfrqxaQnxlULhFokDbXOa9pHmoTO74PcDORqB+O/p1pkhUQ5gDX7rrfWxCvqRT6y45LB9lK/xl7/TW+1UAaZnkVqUi9P5Sqhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174889; c=relaxed/simple;
	bh=e0q3tzU9PtPJ6aOC4Z8oUIUxg1kRUqCx5AWvdwwuobA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSxt7INRo2GcrWhlFsgAAYEW5DIzmiU7JZapv6g5Bf5dgPMGwV78E6Yx92i2eYmHKxz/+NLgJatVW7dj6aSVOILiqD2Ngc6GNMMW84OKwOwrZ9SeEOfdqoLJ7au3PBOCBD/NXskR5MMYlGKGgu2h4mIX4MvO4eWy2LnkEKoQTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ankrfSQA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so8097721e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706174886; x=1706779686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kuW7rAIXRWMF2+WZC8ydmjzSUCYzONZg7QrI9SwDtw=;
        b=ankrfSQAPtAu2lAjSVync+sWNWEoEsTJ21RTJB3Pb8m/lTBZjqTA7PSI/ChM5SXBT2
         IL2rBPNDWh7rghExUDcfYJ9x7QW99DKYWm1X/x+mLPKHyIO4WYCow6VFJ0dihdRZSbRT
         SXBnCsr0m8b7mif2UVaTx06FVxbLpUUbDrOv29gk3SFepYcll2tBSqsPgw8SMk8VxFAb
         B9p8mN3+2Z8+jT6saHvBVQGlRlx2u/BxN3yZXK+8KQnU3kYlBslRzNNpF1/EJeZPmcMo
         xswgsoxp3X5vh8E/H2Z/AyIAdiJzfNqikYQOh+TzWzYutQJXQ39QExGf49lkhGcBpMbY
         oPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174886; x=1706779686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kuW7rAIXRWMF2+WZC8ydmjzSUCYzONZg7QrI9SwDtw=;
        b=jDPoCLKTWsLYFQgMrZed18sfRJO4WDKnWWsji7/Gdz+aIj1J7ioEP1Ez99b2SPqfU7
         jecYBO9nAtPleCzYy+vqrAkl86XqU+jIYDAuD36BWdXs2Ei8/a4PeOcbEt++QxjHuNOZ
         FgECdBXOBwK57GNZib1vQO+iHAhhLUDJwZzgRxjb/kdWsauzeDM/eXGdTctk5O0UkbjL
         FqfVgJ66yQKdqoOk3H5eycBY2Bb3rlkomBiGBxN9DkL1r+oiK+L7A0dEfLcvTSZeA59l
         1yfreDpez/4VY9074dWdhW0b7xIUGyBEBxu3J5PsbKhgpXk7vw7WGVSwRCrzag5M0+iO
         0YBA==
X-Gm-Message-State: AOJu0Yz08vnJea2OyIcLMTYhIjXbHcnqi8MKL7H21WwtbRBTDiNJI9JI
	bN6Gxq7NSyzY09QhEQE/Oda4vGBDGkNYkGYIGxg5OZDPNQ/jtMVRR/T7GORJV5Q=
X-Google-Smtp-Source: AGHT+IFABPbW/Y7yZw9n+Cwz02EsVAtUFoi7oZiqm9dyRhBsZW+GfLLA59GIxerQtnCBkvAzPh5Z8w==
X-Received: by 2002:a05:6512:1104:b0:510:f2:e675 with SMTP id l4-20020a056512110400b0051000f2e675mr468078lfg.125.1706174886146;
        Thu, 25 Jan 2024 01:28:06 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402005300b00554af5ec62asm17356391edu.8.2024.01.25.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:28:05 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 25 Jan 2024 11:27:47 +0200
Subject: [PATCH 3/5] arm64: dts: qcom: sm8650: Drop the Disp AHB clock from
 dispcc node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-3-0f8d96156156@linaro.org>
References: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
In-Reply-To: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=e0q3tzU9PtPJ6aOC4Z8oUIUxg1kRUqCx5AWvdwwuobA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlsimcYX9NefSa6EsFSQ72uwsURpwK8h5MAL+tc
 QWd8gkY7ZWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbIpnAAKCRAbX0TJAJUV
 Vql2D/4gjxfUr0/RGGs2uhqr1hHCPQWZoF3K5MOQIWyv5qAq6pdCSmwve8tDseJE+XdP+pModtS
 C9ZZ8hFOmn+9OYeeyONffa+7o/LnwdsdhkqH20LHH5IRFkZExQYkBxjNTVeEH3rJ89H/oPzjDhn
 beYkGkvwzARkKqSNfBdbu9NhxQMYiFgCaWEH3gTQSISLu7kw+tbs2sDkkp6qmfbYkLA3dTPCVV3
 VnWMiA8K4q/IDeaYze3mwzN+sf5TKv52QvyMwoEzUth0oesvK+70NVEoK30LtjZu704YPjjGLud
 q2wCkOFGYVwSpSDodrgbJKdH6x6YWFf3KhsuoFItU154aJHUcbLUoH6u+D8hjQ0416mAmjSdtCQ
 aaXdV2bDJkgTsEC6oZLWjtiLxqn0sjdpVZsKHlprD7hGolRyI46BGtmjMaRAYb2SxUAcbeRL0l5
 Thz23FRvtYfaXQOU9W7RjMUBgnOG4o6PKEKNdEk7B5+aQDd3N5yDD0Q8rlU01ltcEpIboJ5fVfL
 wuzBHQ2TtEHpQ7IWcJffboySkMdWE3xlNqQ//wFl+PqzK4v9rTsiYDc8xrBkxulaxJcMAUEn3IV
 0pbskWNgZfvKfOUHNUY1I/Hj4NgIBPDnc3ssXC+Gx2gltDjm0N3LZK3ZCrPZhDfAsExR7ctQV0V
 cQVdxCT+wuQTdSg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Disp AHB clock is not registered, but is enabled on probe, by the
GCC driver. So drop it from the dispcc node.

Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..1bf16636371c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3442,7 +3442,6 @@ dispcc: clock-controller@af00000 {
 
 			clocks = <&bi_tcxo_div2>,
 				 <&bi_tcxo_ao_div2>,
-				 <&gcc GCC_DISP_AHB_CLK>,
 				 <&sleep_clk>,
 				 <&mdss_dsi0_phy 0>,
 				 <&mdss_dsi0_phy 1>,

-- 
2.34.1


