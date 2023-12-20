Return-Path: <linux-kernel+bounces-7492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228C81A8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA61F23781
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18054A9A3;
	Wed, 20 Dec 2023 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOMevE6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055749885
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d190044c5so1803455e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703110378; x=1703715178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSm7Kkb7iQIhLnJh6bvdjkMX+zpHH9VA+QckFeFJQgc=;
        b=DOMevE6BavQ7i9/NK0hzdEcNPYd6axPghMFLE+9uMppWUWmZWOD8dUMRvzf7o7T+2y
         sJn0Z3DVATf556VAVR7cJPWHJ7umyLeocoZnMXXZlqdBYAJfwQSiUjruT5riPepo50EA
         j9G67cev5/rK3wd2lsRt5cDc+70WVuSBlU06kRkdQjTtcOaPOv6wqwH9IVOvVjeLRvpL
         +2qkN1Cry2zx/2/q8aH4WqFWnex6LHFzmdR9LtRoJgyiE7scmq2Vuu8bJVOVnOtj+LNB
         M1YlGg+Sa8h2YUuFo0oCe7kjRDJDyhvXPTyjfZDrML8thozQ3ZykvbpysFsoEdP5PCQ1
         4bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110378; x=1703715178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSm7Kkb7iQIhLnJh6bvdjkMX+zpHH9VA+QckFeFJQgc=;
        b=mHcxzPvPhHIFgdXd/dho/hGMEhJvHcWmSWQDPy+0AyYNLXvKmOOSNWgDCNI6XXmRHY
         2+lz/NqIonU5ELlf202NaIWkQjkMwweI2Wv50asKD0BSgH3AVVCyFymXux/60FL7sOMY
         QXxli7lvrc8sPPnVEXn/OnBpe4h+lVep9nKX7g5VrpwoRZAScfdb+NHb6F/hzDKxemIX
         y1jdnCORNEhAonHwkpMwAQAprFhvMgyYSvUF8IpKNLsRqdbVYRGAf/SnXToL8pSG0CH4
         3B6KCIsp90Wsb132VS8qukCWRvd0ZmTxUeQpAPCRRS97BCIDuO8HvTlFFrqmNcSAl4sK
         RsfA==
X-Gm-Message-State: AOJu0Yw7bDAesptsezP329fqrB2K9DHtuMKLZ9gAbEU/+/u+Mt9IGR0C
	bFkxrjP3+6hTSpaaefvwPEcHhQ==
X-Google-Smtp-Source: AGHT+IGElmS0ybrvQz17DkHamWxuO4ixffYxAYaOn/nOERKtbCVK0gDHZdtWu4wDeE3f+R0rMCTaVw==
X-Received: by 2002:a05:600c:4fc5:b0:40c:902:dc25 with SMTP id o5-20020a05600c4fc500b0040c0902dc25mr211199wmq.51.1703110378637;
        Wed, 20 Dec 2023 14:12:58 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b00a235f3b8259sm254654ejb.186.2023.12.20.14.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:12:58 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 23:12:54 +0100
Subject: [PATCH RFT v2 1/3] arm64: dts: qcom: sc8280xp: Add lower cluster
 idle states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sc8280xp-idle-v2-1-cde50bf02f3c@linaro.org>
References: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>
In-Reply-To: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703110375; l=1697;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JjG1dfCZcMMBaOd+NpvseWTXSJQeolxAsWRg/zSEauw=;
 b=fNvoy8VUX06ZR/89piYsrqsxZDd9/vblFAD1lS1fiyyeTkkxj2kihoijzFB1il2WOsKSY+dVx
 NOYxHqMdkEKCIntWIvRiDLojaxRGCk6XTS+nb2TjIRxQaeTy6QANkkI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Apart from a total LLCC + APSS power collapse, SC8280XP can also put
either the DSU rail (CPU + L3), or VDD_CX in power collapse.

Add support for these lower idle states to allow more flexibility.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..ca56bbac4353 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -286,7 +286,23 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		};
 
 		domain-idle-states {
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
+			CLUSTER_SLEEP_APSS_OFF: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+			};
+
+			CLUSTER_SLEEP_CX_OFF: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41002344>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <4562>;
+				min-residency-us = <8467>;
+			};
+
+			CLUSTER_SLEEP_AOSS_SLEEP: cluster-sleep-2 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x4100c344>;
 				entry-latency-us = <3263>;
@@ -634,7 +650,7 @@ CPU_PD7: power-domain-cpu7 {
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
+			domain-idle-states = <&CLUSTER_SLEEP_APSS_OFF &CLUSTER_SLEEP_CX_OFF &CLUSTER_SLEEP_AOSS_SLEEP>;
 		};
 	};
 

-- 
2.43.0


