Return-Path: <linux-kernel+bounces-4024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549AC8176E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8566F283AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529E74E03;
	Mon, 18 Dec 2023 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wt/CvXe2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89C74094
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so39049181fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915361; x=1703520161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0legLdqA3HMiABFAk1IEGD+aB3bRG1lPUakJuX6NHbk=;
        b=Wt/CvXe2YjAuwwoZhsuSGlIXKA2Pfm/6sP5w+EkzUGqIfjz/80Wi1zzlcgh/knNUbH
         bT9u+0hIa3Ko4+AFQZkQ69Qi9H+vHBkpxfucQt//KRruG+Vu5qjuauLFEi5wlRZF7vDW
         wJAd27F8u01K3LJmQBzSIhuS69MIH8r8WSPXmVmHTESOuy0Hvuj2V7/FIC4yxTTORA5W
         95/VLjoyld4SmuyC2vLtxBH9RqyhBcrQOJ3IIHYbjDpOfEj56X7BY58IGhi8a5XxS7Ko
         Vql3H4KA0KJOjBS0cKErGsRgOpNqdv8FyafohOFoOe1fk5NfXF9XLsXCn3XzjLmrnXuy
         pNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915361; x=1703520161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0legLdqA3HMiABFAk1IEGD+aB3bRG1lPUakJuX6NHbk=;
        b=c0a6vv/VuUKgC1fdzWU1NN8JW8cM7S5szgyoserPH0T7qz7eUYfR9xESxQ1JlYfvVT
         YEBlETyBY/59MWnU7KNIU2hOVfeOQGT4W7x2+z7n1QGx/5Hqa8hms/4Dbl4tdOZZdb3b
         jkS6kSZDWbGbHLrJXibEHFzt/85olLfMFcKeuWrqUw2fBfCNLZrpjkSWMEQnWLRetcDz
         S65KPc+dF0f6FXsoGySCKGL9okxnR2a0tI+hbHunWZhBFu1JjC2aOaFQPPgsnPQ8CiSj
         5rQ0YZv7d7Kv0nTR1NFtHXYgweVWT40vfbfb9Kq9VU6dsP4DPSUC2ah4rHsdC5DAbVb9
         8KOw==
X-Gm-Message-State: AOJu0YwVFfdxbx7ar8i0eGxBWDc29DTQgaiaJ5qOrKDCK4koF3vx+HKE
	TAnhYigP0m0hVBM9oYQmSWnkjA==
X-Google-Smtp-Source: AGHT+IFFsASXToWE6su/3JQTF9uVLLNzIiYmXLfRUuiPzzehkLvaC5Xk5Px32C4F5KPXt8oF5wRXDg==
X-Received: by 2002:a2e:b8c9:0:b0:2cb:2bd7:38fc with SMTP id s9-20020a2eb8c9000000b002cb2bd738fcmr8080147ljp.15.1702915361417;
        Mon, 18 Dec 2023 08:02:41 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:12 +0100
Subject: [PATCH 11/12] arm64: dts: qcom: sm8550: Separate out X3 idle state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-11-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=1364;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PL04FEARqu9VLzK2p2tNsar8c78v1Xz6Zm6Z8pmFlvw=;
 b=cOfL7ZgcpBQGzjkcau2Mz4guvK26PJFAx43Nzowi7aW94eAPfCu383h/id6jzhAQmgNKwGNws
 Ob1bijCWbBlAINYEcbhIzOK4F6UG2ZTv6+OCGx/DK6zbrNfd5GPwige
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The X3 core has different entry/exit/residency time requirements than
the big cluster. Denote them to stop confusing the scheduler.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d6edd54f3ad3..5143a08c4867 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -300,6 +300,16 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				min-residency-us = <4791>;
 				local-timer-stop;
 			};
+
+			PRIME_CPU_SLEEP_0: cpu-sleep-2-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "goldplus-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <500>;
+				exit-latency-us = <1350>;
+				min-residency-us = <7480>;
+				local-timer-stop;
+			};
 		};
 
 		domain-idle-states {
@@ -401,7 +411,7 @@ CPU_PD6: power-domain-cpu6 {
 		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&PRIME_CPU_SLEEP_0>;
 		};
 
 		CLUSTER_PD: power-domain-cluster {

-- 
2.43.0


