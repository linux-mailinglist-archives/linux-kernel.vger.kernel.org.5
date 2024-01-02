Return-Path: <linux-kernel+bounces-14409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5857821CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69398B20EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5EE1172C;
	Tue,  2 Jan 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsAdDqQ8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311710A0C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-556996d52e5so601950a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704202460; x=1704807260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfdkAWiZB+KWq3VBKxcJ+feZO1q3RlIg9zfnZs0Hypg=;
        b=SsAdDqQ8YtgCTXcMeBVlNZyAbty+6xdKvvH6Y5sGmXL0Ulz1wQUrgpwrYuXsjd/UTK
         HPlDVRbodcycDPIe9asESVXAkR0iUjfD0fG1/3OGMBveLsX6UWH0IfEtAjSwQlPJPkJZ
         lxgll2dVDvK7aV/LyorQiaqXs0IeFI4Gn48M0t/koxZU5my18c/aE5SBiQr7D/YtF08q
         TowVcW8ylol7BpKXo94D9LyvfxLTiC4od3Yc+pKx/QG5lRbeAZ2O5+/HgKgFJefa9iiz
         vYL15nNjswyIfD/G0vX/fIWJ3ZDRywNOO4n68/julAa3la8Zwv0Tj+9vByKsVd2SSV9f
         NJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202460; x=1704807260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfdkAWiZB+KWq3VBKxcJ+feZO1q3RlIg9zfnZs0Hypg=;
        b=tZF6u+2m3Sfhg3BP350PmLwqZoWfhsEIhnFD59yOb2MQ4xWXhctdB9/GapECFXLxdu
         Qa9Km9djSi4z/UpPpQX8bqicNBdvtsgJrJ9d0B2+8mdP76DZfkeUen69fWpy0zRcxkxP
         q9hYWMQVdlwoYFjKlILkf8CYjlbKpDvSoL44ZIHLym37sT830He4vRG1p4JbOUTm6RPK
         SyFuarU3s6/sUEwwLbtlzVy44pKrDbOJ7gVHqotX11TO3Uib2XuQmibiHsUqfuJv7e7j
         xztKC+ZOBke1yb99o0g2AvZhJZyGzQbtWu+INTfzORjQjFSvE1oD0jloqOXpSvxlM7XS
         asyQ==
X-Gm-Message-State: AOJu0YybdrrL9mOyq0ldyuBodcJlU6prX8LF/Zy6qWP1lBuTRrO74Kf7
	ULoLNO0yuvc9E7JrDSMG+1seglyngaJgjg==
X-Google-Smtp-Source: AGHT+IHkSu7cjNhDEED8GIHXMoOgLkRLR89yL2411y9HtPnUetAFvdF96Wm5+LW28YRsNz5h4xBzbg==
X-Received: by 2002:a17:907:7f10:b0:a26:9ec0:e35 with SMTP id qf16-20020a1709077f1000b00a269ec00e35mr11518926ejc.135.1704202460636;
        Tue, 02 Jan 2024 05:34:20 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906109700b00a26af5717e9sm10950923eju.42.2024.01.02.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:34:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 02 Jan 2024 14:34:05 +0100
Subject: [PATCH 01/12] arm64: dts: qcom: msm8916: Hook up GPU cooling
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-topic-gpu_cooling-v1-1-fda30c57e353@linaro.org>
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704202458; l=1062;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xaT5wnjb9DVgYX6CSNQYDxVl8QC8ZRinGFKBd2st2xo=;
 b=TvMGgfL2g/1SpCgfksgIJdWTL4cF9hF0FXnxRdL1kYQi5PhFD3avMhmTH0Q01GQI0ZL5TO2/o
 vBnC8aQbKx6BjWTGwHDZV9+du97Wjm3hhp5MBesqzlRBIEkbRsHL9Fi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In order to allow for throttling the GPU, hook up the cooling device
to the respective thermal zones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7f8327b0dbdb..31ceb1df550a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1794,6 +1794,8 @@ gpu: gpu@1c00000 {
 			power-domains = <&gcc OXILI_GDSC>;
 			operating-points-v2 = <&gpu_opp_table>;
 			iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
+			#cooling-cells = <2>;
+
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
@@ -2697,6 +2699,13 @@ gpu-thermal {
 
 			thermal-sensors = <&tsens 2>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				gpu_alert0: trip-point0 {
 					temperature = <75000>;

-- 
2.43.0


