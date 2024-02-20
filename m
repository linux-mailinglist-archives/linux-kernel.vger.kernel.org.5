Return-Path: <linux-kernel+bounces-73781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75085CB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B41F219D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4799115442A;
	Tue, 20 Feb 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFNdD+1m"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913F154458
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469450; cv=none; b=E+PMMasljJ82vT52goSIBMpdcTmkYiQ04MRsY3w3FOduvwe+5Ez6zbMQh7wz8RN58DjOifNLSCxx0cksWYgri5dLl9xDur50p5/zmesEaLIieHgt1TLnha59zrYaeSNs0cJpGYP5y7xI5jNXWsy8amULudxET3Sw+/O2Vdua+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469450; c=relaxed/simple;
	bh=Bg+64ybndxfDs6b6x4LD2hmPzSVNqo/QK+11IhNoFjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5LAhNm6Kjk3+4QzxOMkzVlT+L1DSSPunT4ge2gR5V0nUg96rNCTZeTaJ5hFehCPcKPurjy8YtB+pBm3ffmEamJpgaXfDAXG2WT9jv7/Bp6P1oT5LPdqsfsPdRkL3nIV8jBc7yjCzCv+W6nCWWHo/dNhSc+H9UlO2ve+7QhTb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HFNdD+1m; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3f1bf03722so91224866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469447; x=1709074247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaiHKOatnN3Icf8gwgiK0T0n2HRv8NzGbPdfVNxfS4k=;
        b=HFNdD+1m6rErkIqiYIsNftkVY9r2zhWkLSMQqb2USR8r0IBLllRj3LHk3tiNtHswTF
         2Sq6JQmOJXHbBf80ksGZFh2IGpxwukA+Y13MFjLRkX5wwIigZE7G2LaSRK4LAumX6Jia
         rZmg3m8wZRGFuLPzo8q/f3g00xl6Tt61QJBj8KExAj/tcTeZOoUu+/wHc+1Xwb9NEq9c
         VeUMB6O1RqWmLJ4ZNIf5t3o4kxbfPbuLM02PRD7LoDJ5vjq6fRXZIKmI6UOKVG+zyFGy
         hzeyIDARpFw51DZoiHT8u8k/Z7iTD/OS48FdE1DSy3epGMjer3BbAyMO3KhM1Ug45zFK
         kV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469447; x=1709074247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaiHKOatnN3Icf8gwgiK0T0n2HRv8NzGbPdfVNxfS4k=;
        b=SNjWqH8hHylHzFSjE32rqILmJCjothiYVKIH8ikrt0Nh55RjIFJbmJ5fm9xX6jviB7
         QigtbF2bIlarBt1UAjf6eJq0JIr6MQBoGHvch3xOZ0lgF2xJIaVRng4soJz6opDG6BQT
         usmKurJQYu39otIrcnMTExA2QL6prRBAJWrx2eWaD7DNEvcJJeJwLg5+KuvWAkEQyIv0
         OO4GXnNuOXAlxxp3YCHYq0ldSHSQ45V3Osq1SEjtG2U70klyTJAbtt/vTH95zyTGF32A
         PlaFTiOZhnjLzrKZpojnlkoBqMinCo8M4+b8X/ZeZwKKJFbVolVqUT0NDmkanZx4PytP
         pKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdOi63aJ6BO0ML4W//2NJ4TBW0vR4vEfZTjjErmnJMC+yqsJW3n/Lmtr1lkfZA1XVcD3awN7wzSmdaOCKi97s2riKVcyPaj6Mj9t80
X-Gm-Message-State: AOJu0YydY9v9Z0cdtYSg5ibPyWZPJLr5LK4TLUogjJsyi0ka9naD9sBZ
	3nZKQKvChlyj6dT2uwlm5z5x/WcWhhIjoPyU9OMC5KURZG/CaTOeYLYZvB1Kyb8=
X-Google-Smtp-Source: AGHT+IGKYFLq9n74LH641A+5aXYbvLwZ/7XrnLC2ffc52710JhYABnciYA9kLk++qgZ1K9d8iIvTtQ==
X-Received: by 2002:a17:906:504d:b0:a3e:1225:2d7d with SMTP id e13-20020a170906504d00b00a3e12252d7dmr6954762ejk.38.1708469447175;
        Tue, 20 Feb 2024 14:50:47 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906c18300b00a3ed811cff9sm1601977ejz.154.2024.02.20.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:50:46 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 00:50:33 +0200
Subject: [PATCH RFC 3/3] drm/msm/dp: Add support for the X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-x1e80100-display-refactor-connector-v1-3-86c0e1ebd5ec@linaro.org>
References: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
In-Reply-To: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Bg+64ybndxfDs6b6x4LD2hmPzSVNqo/QK+11IhNoFjQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1Sy/SY/Li7l08xMJ7M+mWv/uESkmaPF0NsvaC
 dpCRX6qGoOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUsvwAKCRAbX0TJAJUV
 Vgn6EACmcH3wtom1eKfkJzuGchzrI103o2ht9z1QwN/8SbMuJseRPCeWyeeikKSw+Po4gGZ/G3D
 0yoTOTAK9JW4c703Yi9C25hqmPQWsoBGvsbRjFVs/twSZQ1NEbVxhUL6f6BFuutOZVfw08UYU89
 tBa3qjivZque5i9drKIn4aC7FifFsZBOQQI/bhqR+ZMOL4Y3vLdlK6i2QHKp+WtAqGRRFXbMgpy
 wAVuWMEvlikjtpGTKq1OiplVqZQJoRhnT06zeeapu7UOSPLYIvar+xRpMSgNZ3uiWypOv95QkEF
 km0lOHe1Z2pdrQIc3LP+ic3fJSYZrUFT4tcuOTagiTFqVNlstMXfoXQ80xe5vf23nQt1tSW17fU
 jbh4JQRTjVGXfeX92p0NkZL/Q24BOYlvADOwNY2dB3FYPyPrLIT14vSbQRG91RPPfTWgWGjuu9M
 qTyQi5g9EINuFMtx8944XfOAMQozkqQbqGl61lxVBRD4egoukK57vxtTVTGKTGFJ90S25n5EfRZ
 HJesuuXKHlyqu6btq67skJmmUpaOjO5ngZBSns/QX3u9/bcJnKF9CQCarp/5ROFEfsFr/B4R7e5
 hS2V+HVKFaG7bWp3lOk8NH6NETTt4/y0HjvnQqGJrzvSmFCZLK8egouw1MQ2b7ulVDeA4sTJeFg
 OpYr4j0j2VYNZXw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the X1E80100 DP descs and compatible. This platform will be using
a single compatible for both eDP and DP mode. The actual mode will
be set in devicetree via is-edp flag.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9e58285d4ec6..7b8c695d521a 100644
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
@@ -179,6 +187,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
 	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
 	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
+	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
 	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },

-- 
2.34.1


