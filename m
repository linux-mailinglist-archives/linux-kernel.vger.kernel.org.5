Return-Path: <linux-kernel+bounces-13433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AA82068C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FF21C21008
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813015AFB;
	Sat, 30 Dec 2023 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5E7LdNt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6F156FB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccbbb5eb77so52696041fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941485; x=1704546285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=r5E7LdNt4+H7YHlK867Sxo1w8ir7gZs+DiEJwR9jcDqnFmUhB6z2YPZr0jj6HTEtIe
         L3DQKW0vcBmuvHtb99x4EaBqxlCQ1RjqFUNGzmtqCOyQ5frJJ+dIvnxksdzboKyPgH7r
         9G6kWOG5TlXQ7U8v7uTtFNRC67EA37inJMiCRJHXZFwJ9kNoyo2jOxkO2Ey/1pBtIwZT
         cC/NQGG7/96jU+arhumndGBcijxVXZH+AkbmHuOGxlXH9ttWvyP2vmtlbH2WVI0zKGip
         7i6m11GOqS6vJf4YgDR4fsID7yyAm83ZBjCkakT7X2HRBg+hBeHIzedlT8zv/n7fS9Mj
         CjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941485; x=1704546285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=qvSsYm1GH32Ot/ZIoWEObxQHsqjcSoBDVjKHLmeJEkVlJhbDcCO4/h+8jxJJ+BE826
         44kUhTKP5NXIzUV6wPNc1GIkcqtxDKIBy8+uKetr64uPGidDQJBBglJXPkiXXRlc5vfw
         PlcFqqimg2OKWlVRIYdBN7yE/HdagtD4NOiX7yrraoo2ZLon25+wjnjZN0WHPwGa6xNP
         WJ4i+VNSrjizSVx6JUV1hqHA/PGR5HPRiJbU23qUf74yuVyjaxut+qivXCXbbSzEukq0
         gC/TDwFoRo+uGQ6Cdaeb/VmpKc0jlOWnq1JiPJGg2F/XBW2cbyx9YzZJKcz+bWpGXWVA
         2Oaw==
X-Gm-Message-State: AOJu0YwmARbYOTNKwyYJAlaAPlpfZCbV4/SS/+VXHf87aECtuxi2sB5U
	+3bEnr7ILuP+ECc7Q3c5n4Op15X9zHbGohV2H+hbJyElqWs=
X-Google-Smtp-Source: AGHT+IHU+x3djEpIT6wEg1juKyJq9AUeXR5FMYN7QxnnNiFJHJ45mcitVUhqemdbQz0AhCxu6WNxUw==
X-Received: by 2002:a05:651c:124a:b0:2cc:eb47:225b with SMTP id h10-20020a05651c124a00b002cceb47225bmr1539686ljh.100.1703941485677;
        Sat, 30 Dec 2023 05:04:45 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:45 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 14:04:14 +0100
Subject: [PATCH v4 12/12] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v4-12-32c293ded915@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WDI26IliceRlW0YgN7X8GrPWGyVd7988pOYar0kAAss=;
 b=tJe4w2odgxduiwNhQKpH46QG19PrXsyZwDwXtdiYCPIKhlwTuKNdbLk+C897zMdU2NNBJn+4H
 xur4Bw/li2rA+bk/fiiYRQpqhf06ASknrm080sAFAT5eDcoG0ZpU9Nm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GPU_CC block is powered by VDD_CX. Link the power domain and
provide a reasonable minimum vote (lowest available on the platform)
to ensure the registers within are accessible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 30b140e1cec0..ec9a74acc69c 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1723,6 +1723,8 @@ gpucc: clock-controller@5990000 {
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			required-opps = <&rpmpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.43.0


