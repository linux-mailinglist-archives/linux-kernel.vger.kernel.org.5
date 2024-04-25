Return-Path: <linux-kernel+bounces-158167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1C8B1C75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3AAB23627
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67566EB69;
	Thu, 25 Apr 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdUR7JT7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51256EB4D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032449; cv=none; b=P2sPyS1Q2aHfssWK6OfPN+jFZt5Zgamdzn9eA7ZiDRqMZ+5ak1azkNbyQTRIhwq9aOk0yZ7vS2cG4llTdyQdOY75WWpDo9CAbF077HusmsIQn/719cXgQcNGU+pXg9oT9c9mcdLufPvGggS7c83vHTLTXX+gLny3diwjjFBPhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032449; c=relaxed/simple;
	bh=fc3Tt26AuhRfC8lt6Xad8GbuqDghssQi4g9bwtH5BAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ri7NImS8OvuGChcvV/u4e6Gv+PfrhCsal8VqQ0JWh4n+9p01GJ5jLAsGMJFQyfh9LwpyKwihRkyoLOgQTuMws3MjsIIByOnPFZ6w886kSZes9sl2jZleNOYv8qpvJBH4lOxKHbsd10YDBT+CEmTuJ/iuTfoH0la3y9OgA7MVMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdUR7JT7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b4fd421c8so1701245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714032446; x=1714637246; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyUoEeLBK0Y7y3XYOS3H0VfeNoTOYEFbRWEhtJbr/Mk=;
        b=zdUR7JT75ZfiSt7/6iGY2G28BVa5sQ4pmBvVlAW/B6Px3ffYz9kVb8S399PltYm2nc
         169RBOcSjaKUxj3rNeE14GdFC8jr493Rk1F80rEVmcXEwukyX+LiYaP7bjiukvPLUBDp
         hRCEtvi+dNjiMSqtt0/jdTPvdz9wOep+lUmL+QoJeH+vfjwVL/TqHEelWIGp4JZcZun3
         L0eaV/e6QM3DfXXuYgnR2CbOUKmFN/t7I9OjSGr2hMJgDAcvuCcdYLPTVcO73e57FbSm
         02eFeGKWNsJtiULBzekAVYoxtDJquI4zowhCRVd3a/toZkvTvaBXjJYVFhy3xxTF/ca1
         0/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032446; x=1714637246;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyUoEeLBK0Y7y3XYOS3H0VfeNoTOYEFbRWEhtJbr/Mk=;
        b=UPsiuLM0QmF5egIFfZ5oaD8f1hqVstj/iKgiI1YAxvw9tGb+IqVPxfCHyPMmNnyi2w
         bY4a5bOvlfBQd64BE93AiPfuvP6usd2XZXs9oVal+OISrLkCEi6aLXheLD3sZu5bYSwU
         DXPt/72sTAnAeam6EU/SJXNU7awUiJmxA3hsUvQn/hJ0K1+Vjax0g9A6x1Yorsnozbwg
         aHeKkyA595Y17u1YdyV9BE6L6XDJYbcVZ744/2Jtlxie2o3XD76FtQYk2XfKMXYrTcli
         ROahynp6HOb6najKbU/ChgZQP1+UTCvNM3PDFnpzM3P6JBrLb1rQ3h4kNpYmi6glWt5e
         0Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCVb0sGet1EKKkMkKWJbVxqCh/oZCIO39STWPpZQAndF2Yc+tQ1+tu7Ts2GUikjPkwuAT5kyQcxndMXm71GCqahDAUAKrR8rjT2eIq1c
X-Gm-Message-State: AOJu0YzRun3wfGJX0gGDrpZqOHWZl0m0B1LJyWVJ2wH+/yWR1C1m//tV
	IJef5Bahtk5WxcYGYUM4hxYwabpNL4EjV/y+/YJigkYALl/RYDa8vg1ECpGW9rY=
X-Google-Smtp-Source: AGHT+IFEEiaeJBP5tSVIm+XL5n2eKQ7it2z6ik/js0SokRwDh5hxpeu/0xuqugetal8Z7LDdJEEp+w==
X-Received: by 2002:a05:600c:4e94:b0:41a:f9db:88ac with SMTP id f20-20020a05600c4e9400b0041af9db88acmr3490397wmq.14.1714032445510;
        Thu, 25 Apr 2024 01:07:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0041ac5f19213sm8042321wmb.8.2024.04.25.01.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:07:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Apr 2024 10:07:16 +0200
Subject: [PATCH] arm64: dts: qcom: sm8650-hdk: enable GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-topic-sm8650-upstream-hdk-gpu-v1-1-465a11af7441@linaro.org>
X-B4-Tracking: v=1; b=H4sIADMPKmYC/x3MzQpAQBAA4FfRnE2taf3kVeRgGUzCtoOUvLvN8
 bt8DygHYYU6eSDwJSr7FpGlCfRzt02MMkQDGbLGUo7H7qVHXasiN3h6PQJ3K87DgpM/kayz5Ep
 yGZUQDx94lPv/m/Z9P6yykClvAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fc3Tt26AuhRfC8lt6Xad8GbuqDghssQi4g9bwtH5BAQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmKg81nLaJCVWiTo+CX1gaOg+Bd9umwn4yB+udmxjt
 28lnJjuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZioPNQAKCRB33NvayMhJ0ZHRD/
 4vgLKi25J8V17H0CfCxmJAa0Kyc6XpmPEeRx7qoCScAavG7Jk8NvgcNoVXxaitfTqwQJP2NVCF4c8M
 MIxvsCapRiZCRhDhQc/GQI1iEkLeLUiyax7FXbNsoE2ePeSrnoC9f3zH2d6pl/ndaMTGEi95PoZFK9
 L1SWMiU6zATMoUOmxxULYfvUjjMEHI0cqDrttZYuMTV7DjsTaQHolRApqY+WPs0oEWP/7s25kSV8nv
 xapKMMRTkWhxWnE2fCBoHswe/wrNx5KmbRLpM4ZVmV2yZVEebn6CPo48PoH/0WZVNXwVmd1DxNblKJ
 3eRYn8v/04YLZGevd0G6unwrjxzxbZCQUuIfupzesvxvxrq+6V8XEQJUOc4o1xOhDLBxLp/hkvxdb0
 MIqX/eYmkMK+n/cQw5eBgEDL0YioxJ2AUj8Ft4lfD5OG9Qbuy94SVAoXWJnqkrgWWcIIgkhvmgN5sb
 oUE99TfXfL0Nt3/IR3CzRMhFS0PLVtOZYFiNZvDfG6vIVm5mDY+2GmFxb0kARtqihucbpu2FMoBlCY
 FU5cEXqmZax/vrYo5SrxdU51NkFwUKEp0dkV4Y5o010xU0OxUhSZFEQtOiMtNAkqBgY4wBykEvW8kF
 7U6oVhiery02DePGmLkFe8GYiASfFny+ZTCYhocLFDlFFdc9qYbdAGZUntOw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add path of the GPU firmware for the SM8650-HDK board

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 3791c36579be..7f2dbada63b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -836,6 +836,14 @@ &ipa {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8650/gen70900_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio21";

---
base-commit: 3a01487d6106128530737d62f28c6a7833ff5ccf
change-id: 20240425-topic-sm8650-upstream-hdk-gpu-24b42b72b127

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


