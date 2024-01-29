Return-Path: <linux-kernel+bounces-42779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337584069B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F22B1F26C00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991264CED;
	Mon, 29 Jan 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouw+WIwx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7E63502
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534356; cv=none; b=dOnshJ2UWDa053b4c5aPr955Kl2bZuQs7R4tvaG8ykLhUKpqamwWwcmssG1QjS+pjeCUt7SdM9xbsBW3x+am3scUmghrkl/NN56uUhxHSPRJD9HDutMZHZOQ1X2Grk7qBkYFP6dr8ips3lFOhYnjGgah4Xrl+AfENn3jnwTWG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534356; c=relaxed/simple;
	bh=rfGkK17/i+BleU3qzcJWNOMRKGI09BZOvobQeTG7kY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEiarKB41IqckReyCPDw7AgHHM5SBp6ab7C5TzPo/9eCOJazOtGrqs57xe3xKXzT2XJU8gVH9aDzKdrFbuMqYEsjCJj8Ke842As098UYDEvlYnyPkDZ23vNVfNzAiMpw233H17Aehg5+MRxhEZzfXa0qR+9pZ32h2T1kgUopHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouw+WIwx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a35e9161b8cso66211066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706534353; x=1707139153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avsFIxhX/jtxHDt6bjDOfQ40vEVTMaWnxh/VVgqRP8I=;
        b=ouw+WIwxnyJfgu6SCswE/ld+7995sLIxC2wVkXUm1cP9b5AtMRt03KWRCGxD1HwXFU
         Rt1jgv4EGMp2vEjnAE/m+It6xFoNZKmlMOVR/NhO4SK8BQj7SB26AKn64uUt1n0txgzR
         Eo//CMGZ20eP7PDwhsczRFxRzwtpoMdC0KPrexenpXWZWvAQl+jTdQdtEJ3ILlg5cOw3
         K7ZoSDPaLfYWE2v7+S9W9YT8RD2lhKe432Py3j+OIYPhYk9GMQ06s+BNwLMXE7foOC8X
         KxzKOR5Wv+8UP2P5zh76ZV/caBQdOe559ThnOqihFkJMixw0ycR/yUlUatkm0+p5QMri
         Hoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534353; x=1707139153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avsFIxhX/jtxHDt6bjDOfQ40vEVTMaWnxh/VVgqRP8I=;
        b=HW7l1FBi5mCvgjdl/ldLjsTFZ2U2wgYwB53HZL75yoDmODRljGJB7nR/+N2B9coRrq
         74e3d9Z9wg57SYXGNew6z0VZt+zC6bm5Nb5aNPb1VF57Dkp2Pal5N5lecZCovbtJZe16
         jlX9BGx1Ldwt6YKcZhIIY/2QUwJ9CzWSdrwl/JjVHdZ5IugSsTbsZ5tWsfptbruSZaSk
         XbJlZPYacS+lFa2cLOPMjLwYoICYVgZlAb3WoiuRggHX0V4aGdybdATt3WqXqPCn7nCr
         RDlnJEiqu6x7l2Ie4ir8Xq1RJkPXQ7u/EC2mOezk5QFSOyJ2HFqM6sq3vvtCNzpxuq9e
         t36Q==
X-Gm-Message-State: AOJu0Ywaz/v54w1ym6hnk4BbKesFpxX0y76VkpDQM9AqwFA4Ky3uoDtK
	eJv+yeOuuHajhFtRPL6OxidcOHds4YlWU+MsRl+lXKJ+zSeNr2JgdwOkk+q2xuQ=
X-Google-Smtp-Source: AGHT+IHeG6mDUl+ksN0m3/oS9noMoULpS/ssljn6bdDUjLBizSFE1Oo68zXcRckMajlrJwPoI0Hwag==
X-Received: by 2002:a17:906:c343:b0:a30:fba8:8fe1 with SMTP id ci3-20020a170906c34300b00a30fba88fe1mr4296187ejb.21.1706534352761;
        Mon, 29 Jan 2024 05:19:12 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090622cf00b00a359afad88dsm1591658eja.10.2024.01.29.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:19:12 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 15:18:56 +0200
Subject: [PATCH 3/5] drm/msm: mdss: Add X1E80100 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-display-v1-3-0d9eb8254df0@linaro.org>
References: <20240129-x1e80100-display-v1-0-0d9eb8254df0@linaro.org>
In-Reply-To: <20240129-x1e80100-display-v1-0-0d9eb8254df0@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=rfGkK17/i+BleU3qzcJWNOMRKGI09BZOvobQeTG7kY0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt6XH99bhpkCbAVQ3v7T0Zu5dazEjO8JPZDEyT
 B5uByWz/JaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbelxwAKCRAbX0TJAJUV
 Vvy1D/9B9s4n/T4FadLNi76W26+2YKGm3mcG+yf6nOSpCieYzh7MBGwlQQfu6eFB2+RUss76VeV
 Mc5xb1pQZULcW9U1M72fJfZ6kKPsDG4xbKHrtJ3PvR0waNTrRv0jAcGU4MW1/2rdvInN7LDBVS+
 u6BG0JXGh3dZ0wmOnYzke6YIzL16URZv83iNgJTR+QKUObkbW9zNqWNU1WdQrgEJNO9XZFBcH5h
 Ls26Q7amA6HuoaCqGsAwPjtTQwm1DsHzoYoXIXWLxueQ9efGJBlboHsatloAHFEXdonSzZLF0nY
 xjT7x8U6VW9UkI4w1f+1uY5uteZLjJgtT/2ULqRlzkIlJ1WOTVCtXy4CsEGvrC+wSrMGGQdcpJ6
 Hh6L7ZqW6Qwc6xfl6J/LGHgZVQFU6nMOMa3jvGxDTia533+4CSC85WiYHUab0SbtIy0Wwg98IYk
 eeMWF7kcv1qPfsvI+gbLSxzlYB1rmalHi0AKBbk7UYyIndqoyHvn5Z0V1J/ztjB7zMq2kzew8id
 Rtuc3MmHsxerYq3SJNicAypaC4NObHpVqHYRuEVCmgOe8WWSB4QYyj2NiKozrzTx2NgrM90Oi82
 cLQpit73LcVtcimvIiOB33tT1fBlXAMVqgHIFpmFxK6Bnscz7d5pTipYewQURemNMR+oASgC2/C
 x6PXzS1yvt4z8Dw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add support for MDSS on X1E80100.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 455b2e3a0cdd..eddf7fdbb60a 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -564,6 +564,15 @@ static const struct msm_mdss_data sdm670_data = {
 	.highest_bank_bit = 1,
 };
 
+static const struct msm_mdss_data x1e80100_data = {
+	.ubwc_enc_version = UBWC_4_0,
+	.ubwc_dec_version = UBWC_4_3,
+	.ubwc_swizzle = 6,
+	.ubwc_static = 1,
+	.highest_bank_bit = 2,
+	.macrotile_mode = 1,
+};
+
 static const struct msm_mdss_data sdm845_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
@@ -655,6 +664,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8450-mdss", .data = &sm8350_data },
 	{ .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
 	{ .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
+	{ .compatible = "qcom,x1e80100-mdss", .data = &x1e80100_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);

-- 
2.34.1


