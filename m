Return-Path: <linux-kernel+bounces-76834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308985FD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA3E289FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7F14F9CF;
	Thu, 22 Feb 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qyk76q2l"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29F155A56
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617329; cv=none; b=gnXxzO501SobRAUvqqbISeIcgvc+OcukaWHLTgWLjW+EfzEwJLFlx0x/TxrRFF9zYYNs74hTTqvaLuDfjHGN0pdfucFKMWPLytVRoQRoOMhF6Et3ybSkf7X6NcE9Uf5XJ4pC1FGeF6Wk9IhqdXz9+tByE0YUZCbS24hAyKInUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617329; c=relaxed/simple;
	bh=Igx0dc8kyT7O4TGZsOtKQnB+6acRvpeqzdoVuoVCK4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJuo6Qp+0XB7o16/ya1vb5L64CZRCTP8VkfCVkrINazZB4u9mq0gNGWkKFhylA2WeVQU0zGk5FUoV2Hv7sCl7VA05gmtsD6EewlJOi3UVNlLqwo3/5DHQ3PAOZvf8hubAsbJqpfCFGvXBA4JBnO01fD2U5jrOW2chc2CbgV+S68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qyk76q2l; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so10811171a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708617326; x=1709222126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJjRNIUqnXrTF9bzdEi2VC9ooQUEnRbmpw6uyhCO978=;
        b=Qyk76q2lbn5Wc4XX5HD0pfQSa3JVRjcL3qU24FU2CtceN1syPnriGrlCaxq2AT7s7I
         bhV6PuP5WHBpZFb8G6GwlmjDwgvVa/SjdDDgRa0hEErNnRVwO44LHMAwir6RUMgO7xIU
         FBQM+rRyIPTo7f5y+8VoMkQpuLuuS7PqSSILxlTptFb6Or1kiHo7oBdCkjR5n9fb4sBl
         T97LnHUU3SKjBNEshAL7omOkmSTId41tY5+HA44lMFOnt0yGnZgpZvtgzFmTvrmMYwvz
         cogNutj9/TM3cL9ZIW4RD7znVdKHWWFFmRZ1Bohl8sdz4Sf+XduCMRvgaoqpqMmD6r1t
         L9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617326; x=1709222126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJjRNIUqnXrTF9bzdEi2VC9ooQUEnRbmpw6uyhCO978=;
        b=iag1imulEzqkHRoyNtfxs3R92Ksb7ZLVQdZJ4LmyO1MKQW/sDoz/Q2b9KtWSJl3EaH
         UlnCsPDw7K0Ob19kcA7zfKpN8uAnLCdExlnMXjIllmSSYqVOmy3JP/NruLEfEvCGZCid
         vpOZYSmSalwX5++49SWRKzVfqX9cUKuu8QnN9lkv5v+ARZ+VfQTaDzL2emx9RE2rSFu1
         U+xRgXq0drPnjKyqXyJqWOgv9WS5r4jPJQZXEMBkXBpaDeNYAO0KwG33BqDm6vM1l2vU
         Ue0awrBZDHhM+MvMn7STYd66PmedZs4SPxt9w5tge9s3l7wBEsjFdpMfnu4p6nwvxv/y
         1+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhftU+WjadFpaQjvYoOD2pQm2ncypL1c0eUIGpvzbWqNldDnFEseIoW/NzO6Fo4nPVLUQ4x5FJON4e+O6j9xHz8FKaHGlrRv5i7G6O
X-Gm-Message-State: AOJu0YxCKJty3dFTFWhbiOj+kpf6i92ta0iFuzw4sy3H/yc4HMv+o7T+
	0sPEJycZ0+PhKto6odazGfLugAUs8aooIt9ffVbl5BGCTTzt06ITKn4FIkEUxuQ=
X-Google-Smtp-Source: AGHT+IHx8wUrxZAoY0QTpZfuPEXHwmLiOc0Tnk3az8nxpMMl9wTbjHf3g0uq86KA89J0Eq+x6oS1Kw==
X-Received: by 2002:aa7:c44d:0:b0:564:7bed:b836 with SMTP id n13-20020aa7c44d000000b005647bedb836mr7778452edr.3.1708617325938;
        Thu, 22 Feb 2024 07:55:25 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7dbc7000000b00564e489ce9asm1924247edt.12.2024.02.22.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:55:25 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 22 Feb 2024 17:55:08 +0200
Subject: [PATCH v2 3/3] drm/msm/dp: Add support for the X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-x1e80100-display-refactor-connector-v2-3-bd4197dfceab@linaro.org>
References: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
In-Reply-To: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Igx0dc8kyT7O4TGZsOtKQnB+6acRvpeqzdoVuoVCK4E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl125mmmA1uULH1SHqNXIODPJZhjtL5J4xyD3J0
 gjgi12m37yJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdduZgAKCRAbX0TJAJUV
 VoDVEACr6Dk0tJq9ePeNm+CmSWomyrFLd+GFTUs6dPPc+1N7ayp6jdKgOVxEG1HP2FHS+md0AlP
 XUB5CLUHyU3SvwdcRKz2vvWKreVn6w9dtP4fzvygYfOiRCMuJYT4zdczFwVSPUawfLjgKErA4Hh
 xqtADZ2EKatT8TIDNtt6AEMSWot5NtWCWgN+CWCNbZEIiRcKKva1In+HUjEL7PuSAPzzpxKITJd
 QyxENlkIzdAvT+q9i/XTKnZoeWU+W2YmJRTJUiFk+VeJgiz1DsKfzgfS06PpUTubNY+L4vD5LLZ
 Y9mOusYFlbNI05+o58j8ChNahPZeh6lCvH5K3Hcy5oMlG8leVbOMSFglkuSFDTwRH07UG05CbW3
 ROh8d5D2m4kHzhGtvuQ7GHryrdFmG+8ZplsFZvkaNRk2uEdATvWVTvlM2flsFHDriNF/en9skzE
 488eIKHDYWDsDgdhJyOkpfXlVW6WZY0a7glCER7TlcuDS5j+tVKXgHVMg5b87lKIkqeSzTShwy2
 CASdhiX7aL+6DFbvYvEACkLgQl50sztW7aZlTnnbFf/rQFGP6aaT7v3bdXTIUfw4wV38IqvcWEl
 1qSN37cQVXCM5ViNBwUoqG8XQUnbqnaVFIodFGh5PlEMYryOdB2GbfeHO5Dh129rhkmOM3HpSuA
 knU3z19i1BermYA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the X1E80100 DP descs and compatible. This platform will be using
a single compatible for both eDP and DP mode. The actual mode will
be set in devicetree via is-edp flag.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e01b41ad2e2a..fb1969617617 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -171,6 +171,14 @@ static const struct msm_dp_desc sm8650_dp_descs[] = {
 	{}
 };
 
+static const struct msm_dp_desc x1e80100_dp_descs[] = {
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_en = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_en = true },
+	{}
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
@@ -182,6 +190,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
+	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
 	{}
 };
 

-- 
2.34.1


