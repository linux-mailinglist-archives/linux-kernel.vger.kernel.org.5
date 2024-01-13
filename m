Return-Path: <linux-kernel+bounces-25310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122882CD4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E68B21AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074F18EAE;
	Sat, 13 Jan 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C805GElg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9518E12
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso7686773a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705157477; x=1705762277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=C805GElgMCsq5N3rhzJBZMwTtpcv6KXklRX5HZzb1Gg7jhb9JdQx4DWT+/VsJ3Szmk
         cGCUjQY3fQw71LlrIPFA9vSTKYAYcq8KmWq7Q4xzKZ1MGgqMwHJaGD6jFQpIiajEsViG
         biee6/8uvuKWmnsa9viWzrtoDkRjOa52IR4bWlpC/F7nthFpZQzyx/8pLHdswSTNlObn
         HG4fH0fiiDuo9P/BgX2lWlRK6GHAB8L6W40MTybBTwqj3lqz9QON38Arhpx/3CbmVgE/
         f4+TICpR6LbDenbiuLS/QqlJLC9TB3gi7si4UqoQ3wAClCD6y9Ii7h7nIx4Z8B1U/Wx4
         2ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705157477; x=1705762277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUTCpmfzsSKDHjYlRAYYiQ/aykX/VSlVLVDx9q/aHss=;
        b=w9bbILKotse83HWawoId+UNFJZUnNJphxcOh2+Ea8p17Dc1kMrAlXuvbwC41Gf/ZvF
         ZNDJQcXkpxTWxhYXQILwVKM+t7dQSBZSqtwsbMSotfApna2UceDbkWuHeJEQ4msORt9L
         kLrmTnJv5g0fNE/2z3mAgCsiINBJ9gIao2pQ6zSn2/Ht93XFXMccrtvY66M7EIVAisKI
         d8IN4LFblcHwhcI93Q+LYnGOrhYBO5f4iHmmmLCmlLRKHIQnoto2bSIAvxOwcEKM/Klb
         d6xMMBrF4A1g+tNNNe7kxtSghW2KLF5JXiCK0TnlQgg5xhxHVPKbGZTRlKbH521UUZel
         PTfQ==
X-Gm-Message-State: AOJu0YyDWZMw+PJC+JMdRFIef6nDTdvxUrMyeeLhHl1dUkGaUhDquoUf
	dj86Ucqj9g1kYnlrcfnrZKNgConopOcwyt7kfdF1jYygJ98=
X-Google-Smtp-Source: AGHT+IETAequHzfAwgHF8QsK/gBIn4BSDyAY0yftCXAhJQJM0qG8OILiUEsNbSoyObZt6WLoT++NLA==
X-Received: by 2002:aa7:c602:0:b0:558:2cf:b7f3 with SMTP id h2-20020aa7c602000000b0055802cfb7f3mr1362760edq.70.1705157476826;
        Sat, 13 Jan 2024 06:51:16 -0800 (PST)
Received: from [10.167.154.1] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm3014593edb.27.2024.01.13.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:51:16 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 13 Jan 2024 15:51:01 +0100
Subject: [PATCH v6 12/12] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v6-12-46d136a4e8d0@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705157455; l=911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WDI26IliceRlW0YgN7X8GrPWGyVd7988pOYar0kAAss=;
 b=QkTIudk9bwX/+NypRGqOTPXGV2soTD0F/pgSW+rfGeoOYUJvfu6xMrq9N9B54gSGyfZfAOYfu
 PMG412v8x9ODGvD+GYIFf8ufxxA4ySNYDB/TNcmJ62+5QHMNcTVJIr+
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


