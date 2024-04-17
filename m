Return-Path: <linux-kernel+bounces-149159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170F8A8CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ED328695A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D61176FD3;
	Wed, 17 Apr 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="se6gY84D"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84517557E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384201; cv=none; b=kaXm8wjHYE8GRWfdumDo6Ga+mnuMrtZjhaEwONZgrE+FfZL7iAR40uVZEs+zh4QnuXgvNFzfRfkxZLFJj3YGYd0jRpx4plCAq/eHxjxv5Qu9T2cwGshMcU9Bo0DuCGV5Im/jJjRxb1isq9gWaj1ku5LJWHJeiGFH/4eJDgIQVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384201; c=relaxed/simple;
	bh=N9C7J/UXFBbxcLZJ0Wle4it14ExoZJn/aRTDf20iB8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sz8Ieub3WVbnM0z7fjXqxKRjAd/k4VZkTe+um+DpooV6R1lLbEEvFQ+XIeZR4enkVgb/7n8tboBQhuNa1UR16OSju9+PghdM4XGU8JDB4q/F/pcYO7YGmhXUI8h3DuIWj9RSA/x/tIGm5/+WlLmkQ/5jCGg5LZmGyC0DtU1r15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=se6gY84D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso72457e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384197; x=1713988997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYI4k5JR+67InOGrmasq4k+IdEUXSCsAg3S/O+/c6wo=;
        b=se6gY84DzsqhxWokngzsn+5aByus98CTgUqJWAYkNYBeVtD0pUmD1ZZ5N7/x2m7lW5
         L19uaKAS7RaCOhx70wdQrWrwWjNhModtzr2bNkpWUKk5eojrNA6QzOpXPs7heuSKe6Es
         hNe+mN9eJfjYpdXDIO1iiu46sKi5pIXlRg4d54kX4OF8u4YpeQXodatokztwzP1sWoew
         UOWnPUmUYSkPUbEhsvOhrDf+it4lpH59Fbt3RXJ63dZwwROsn9HUlgUmxJxMXci5jGGQ
         DiSD2gXHtPhcp8N26lVFBDPhMSmzJKAK0GrLwdrGqd7POaEYZev6GA7/pKU4oXR5PsH6
         v/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384197; x=1713988997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYI4k5JR+67InOGrmasq4k+IdEUXSCsAg3S/O+/c6wo=;
        b=FQLdB3vLMq6zqcg6XHW4vmrTBA28u5AwxIl7X821ZMGGNpPj9M4yY6k7CH023vaoPM
         j/5AjEXwnWITASn5vaTzjN6ENJBuSBwvrnFIXLiKDQXEuDXadwpQ+V5IDrYQ5c9lkwYv
         51KWFSqEsTbtQrragp28yn1ql7bHl9rfGGmdtHkERIYb8z09mqZYK/pUquufnAuBSer7
         /jTltIxdTjxRDaspdM57tD/ZGUl8146M3zrLA/ycRWhGOAdGGTOmuGR2Kv80U3PJTTpC
         2hMGGFReYXCPe5XaqkDlpazmNG6cyzEV++OecUy6/oZIU9s/DEOw96wND3bLavPl+nQX
         Uy1A==
X-Forwarded-Encrypted: i=1; AJvYcCVdeA+uLI+p8qhsHA7HPHz04R+QVlCsY0Syl0w9qQQgBw95AClKWh7edWDXfNRAkniMk51WPlqnDN1NKFivdIG0vFbFd+RT8+8PtMk1
X-Gm-Message-State: AOJu0Yy4owmoOQ5+htQtU7INZlYN4EAbxHOxizMyHBT3UOIts2BVot1N
	wTc9+UIKK/UG8CEOCWdZOmRY/QXJyMmq5qiZp2DhcHxeR8P21hA7F3Y4pkM44LlJPQgDp0ypKS1
	1
X-Google-Smtp-Source: AGHT+IEveCP0Ef7EGrGrqGh7PzeSM8OltYJtYtq+rF4s+Usgg81dUYwCdW8Fjgw8tn+MFYo18gTAKg==
X-Received: by 2002:ac2:4852:0:b0:518:bd37:606e with SMTP id 18-20020ac24852000000b00518bd37606emr206953lfy.13.1713384197719;
        Wed, 17 Apr 2024 13:03:17 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170906fd8400b00a5252e69c7dsm5905590ejb.160.2024.04.17.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:03:17 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:02:59 +0200
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8550: Wire up GPU speed bin &
 more OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-smem_speedbin-v2-7-c84f820b7e5b@linaro.org>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
In-Reply-To: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384181; l=2413;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N9C7J/UXFBbxcLZJ0Wle4it14ExoZJn/aRTDf20iB8I=;
 b=MHA+uQvVZajZO7HB9yQ9w98lwwxIsrifK11MFrFba+JTdm7p6ywc7iaAOHKu6/NKHBghvMv0k
 DShJ2TmzIFCDxFEiwF2L/6pAbYWdc5a/F5PivT/SpWn3M5H58jc7ga8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the speedbin masks to ensure only the desired OPPs are available on
chips of a given bin.

Using this, add the binned 719 MHz OPP and the non-binned 124.8 MHz.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 5cae8d773cec..2f6842f6a5b7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2087,48 +2087,67 @@ zap-shader {
 				memory-region = <&gpu_micro_code_mem>;
 			};
 
-			/* Speedbin needs more work on A740+, keep only lower freqs */
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
+				opp-719000000 {
+					opp-hz = /bits/ 64 <719000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-supported-hw = <0x1>;
+				};
+
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-615000000 {
 					opp-hz = /bits/ 64 <615000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-550000000 {
 					opp-hz = /bits/ 64 <550000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-475000000 {
 					opp-hz = /bits/ 64 <475000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-401000000 {
 					opp-hz = /bits/ 64 <401000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-348000000 {
 					opp-hz = /bits/ 64 <348000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-295000000 {
 					opp-hz = /bits/ 64 <295000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-220000000 {
 					opp-hz = /bits/ 64 <220000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-124800000 {
+					opp-hz = /bits/ 64 <124800000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-supported-hw = <0x3>;
 				};
 			};
 		};

-- 
2.44.0


