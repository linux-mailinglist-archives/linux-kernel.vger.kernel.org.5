Return-Path: <linux-kernel+bounces-14420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2026821CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FF2844CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114B16418;
	Tue,  2 Jan 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vf8rxYT/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2715AFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so100183721fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704202475; x=1704807275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeKwT1A3XsXuuDojkgywa+/EpDJdsCptqUtmXkx5794=;
        b=Vf8rxYT/cUQV/82ACMVl+SFhMehHNmfIxv73Y7aY6oLTtJYb2EpRa6+nhHIyHc0KKW
         wdo5cxr8OSZBwKbVmpr5qw1mGI/gSYwtCl/V+hB2+js3SAPsMO/mAYKCMTNcAWUhAdwB
         kZdRlNT6bEKV64ujRkGojPDtihlugobIhXJfl4TvC379zuOOT4CNZmSjTj0yoMBQU09K
         ciqNJ4XqC1IFxK3yqlPoKZB192IIG9wR+wHfmfW6RsEnbFO47EzPqs8em8cj+Fd/ewHJ
         90JCAg0PsZszz3eJPz+g9AQaxjw5WQ94KscvY4ip4sTrlgoguSXGbwmWPQdF8mli/yyQ
         aD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202475; x=1704807275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeKwT1A3XsXuuDojkgywa+/EpDJdsCptqUtmXkx5794=;
        b=auX7O2TLPJZOFlpq6KswaxwYDbxVPosU2roNXqRjJAJeFsFDPiN/TKpsfn5sx9NCcm
         Ro8/QVfo8jziPUbFmjyQyj0G2n4E1/ujLuyTbReKg8zvqIgt1q9ehFutetFwK6FDGejP
         oZGB7N9HK0bGc6a7p9djybNLZ1pHS6EyMAMP1Y/p+rFM/NCDBMGTngl5o0ZNlspCl1iQ
         aX/cgrVMSnWcLA3nVfsM8TMiWKu/7XPy/K5Dd9JPXSyfc8M5J3vKeHobXAsluEQzFkFH
         O0oauQAbWvDbxIsMTceWFhi+VfXN2iOT30fJ22O71ISM3VRUY7VNP1u2jmQZ+TArHbhA
         CBZw==
X-Gm-Message-State: AOJu0YwttsnStriEeJ6YzUYTP2pAQc9TDQte+bNd/LnPEj01wursMHhL
	oYJykW8f6SnkIb/N1N1tN4M8Ww408XkDzQ==
X-Google-Smtp-Source: AGHT+IGiqR0JDwID0n3wdeBwAvdvieXgN6ZSyb5hHkLZQG2NRFovAJb7WIX9mIkPnIsl2BZkIL28Ow==
X-Received: by 2002:ac2:4836:0:b0:50e:7dfe:fe82 with SMTP id 22-20020ac24836000000b0050e7dfefe82mr4306564lft.82.1704202474834;
        Tue, 02 Jan 2024 05:34:34 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906109700b00a26af5717e9sm10950923eju.42.2024.01.02.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:34:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 02 Jan 2024 14:34:16 +0100
Subject: [PATCH 12/12] arm64: dts: qcom: sdm630: Hook up GPU cooling device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-topic-gpu_cooling-v1-12-fda30c57e353@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704202458; l=1248;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dkeGc5o0HQxWFtiMDhc/Q4H/20eU/xyAL75klKJTI2M=;
 b=E2ErxoQ3kpFQPbKINlrBy6Bu2+Ni5vxkudf5gW7KmKfY/ZCu82WDVuQ7h6Fbth7tWCFbKEVxo
 KjJLpsPDLoPDWIqV1jSwBCBpmFQLG0voDpYCBVsHcrLBIs0duhS7zn0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In order to allow for throttling the GPU, hook up the cooling device
to the respective thermal zones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 775700f78e0f..fc06665861e2 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/soc/qcom,apr.h>
 
 / {
@@ -1120,6 +1121,7 @@ adreno_gpu: gpu@5000000 {
 			interconnect-names = "gfx-mem";
 
 			operating-points-v2 = <&gpu_sdm630_opp_table>;
+			#cooling-cells = <2>;
 
 			status = "disabled";
 
@@ -2580,6 +2582,13 @@ gpu-thermal {
 
 			thermal-sensors = <&tsens 8>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&adreno_gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				gpu_alert0: trip-point0 {
 					temperature = <90000>;

-- 
2.43.0


