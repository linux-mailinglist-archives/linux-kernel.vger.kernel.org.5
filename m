Return-Path: <linux-kernel+bounces-64050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C3F85396A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995021C26208
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BE605AE;
	Tue, 13 Feb 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VD0rR1f1"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCF604D3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847512; cv=none; b=dEIabevurqHBbcrPSGEj5kCY2+4qYm/AQiQS1TumD2ZbKcB2+/HwumiWC+4lzw+IeG64basNGcOHPDgy7mOrw7O1kDpm1YmUbn0SspjePqrZPL0gxoKAKpuLRjgesqOvG0RFnxUcAZ/EH1XipDNJKPf/nUMK5m7uE85RKuWEoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847512; c=relaxed/simple;
	bh=DRenCHOzrAHmNtT+PvrsMVMW+9QGYX42vbTeK9y9TM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ql2pqj/wzMHtoSaate7jni1ohsbdKOmsrBwuoBC/Dzc6NSqccD+5w882yzAerPyP9iA8OVtrOroS2JKPMO8gSQFz5KaaG6h4uJjpgMcbgGrGuta300PhhZQtQEa7UYkqx4Po1qiaB8d1r4a6plms9h5WMlHuPklqQ4IxD3bfb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VD0rR1f1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0aabed735so60597821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707847507; x=1708452307; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e70wXDD4s58i4pPQoq+fOfAGn7fmyRVc02WAzyBJDv8=;
        b=VD0rR1f1iqPok6dfdNePNbElqeGSyX0nJLGOw94OojWj0yetijyckIMKTL5E4b/Fbp
         4dK9Sj05R5v+Gs+Xm651I6OaPOxaciHo18QofYH13dbeLn7EJaeqyssYmnN6xf6461cX
         hA2aPZMQpMDQCL2lEfHk0c0s3gB5gwY3ArLiXE0hogB65uch7ZpHPwnej/trVnK/iYV8
         aPsdclHkG6LvhPBPTNwjf34VkbwFIXgO2ZXsOKK8QRnFKE7LfC2Qj/K5an5vDm1Yg4dq
         10f61ocuaJLulCsfabESr1SSropLRkpYaLm55j8H6FW2N7txyMj2S4BWYDX2BQGVs4/R
         lA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847507; x=1708452307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e70wXDD4s58i4pPQoq+fOfAGn7fmyRVc02WAzyBJDv8=;
        b=SlFDWLYsGhPzDgyOfI0DLQiBZJOkQG1Y87seq9uw3oHZz9xBsMEAwryMX9PQ85dFDT
         rA2bnw/GF11x01IakNZw7Ta477cXC4CbzACeDVfyUm1o/FKc3wv9Coas8oMZA/oqk+O6
         odsB5ekq+CvGCQuSyQCXSbM+p/w4A0M7ub8Y10yf2RVPsmEHZmuzz1JdZByO8RTtk96p
         SYyuovdSzZG5KePw/j4lXU1QTiuDZgjPlQc8jcIS4CLNC7ueDwZ59PKIARfOTXu+oAjn
         nmpRVLCLWHFLCt5jMYRPyJyGckgiP3wKtBvau6m/572/yZwhCNIqtHyA0JADLQ1sMwo+
         N2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVlVvxbBrWdJVYF/Q4ZW5IBnabHRSVZiabab7golct4PlVdoyigerSRRbzyTDk6qserdtOdJxwB7GWNxIPM3jbGIDteNe9eaXyHjt7D
X-Gm-Message-State: AOJu0YzVdntX3xoe9u7WFQN2ZItCK+7FLMg51Hu9UIX69NE1U1qaK6y8
	XQKZSwlptsF5iB/HmfiDSGzx/qMcSXhcF31QHtWOOHNzFFw9nwh541clM5v6k7I=
X-Google-Smtp-Source: AGHT+IHmkNgIi7TzfvE847XBZ2OZM5yDgs1O1Gu/TDGtB1RJErk5/dezneWdy7eJGVqq6KcPWyHDug==
X-Received: by 2002:a2e:2e09:0:b0:2d1:ca1:760b with SMTP id u9-20020a2e2e09000000b002d10ca1760bmr297273lju.30.1707847507407;
        Tue, 13 Feb 2024 10:05:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ54WrawIOvlpxGz8yZKRDQ4SqXq+ERsBBvUjJjAj9qIo+bWEyrtNeTqIAiLi9LXVheQhFRx9UR6ajW92PZ+CvHLgnewa2EHey+1qbM5k6vFOqj97RVJ+DGojyFT8KwZtvgHrqGU9IPR4yGbV7GBdYJt2IULruG++q1lypc0xAkiG2Oh/ePKKJ6k0cZhn9x5CzoFHWTvZDrU1iQBLyUrF4Eb7KG6vjhkTVbsR4+YZjkeZz2Lk1kUd8QLhJoDAtCk1qKUv+RisDC2l7/yiHlPLnJhOUrqkDMCPA7waGTcg8DdN1tNI0rceLgid50LvlR+6BNKq+VGapvGwAv7CEq41MUsQZ3gqHFeawGmBtfuvghXbxoeYSC1mp06StN5ZL5lVqWurMvYL/OHtrq7O7wOQIedPShPXsBh5kTf/q8wxfD4HTEIlEbjP4G70TvEm8D8Qz+gCu+8umWLo3TMvAem9GcDkf6HfHjRUFvRx7pMOG0uBBd1d6DBNRXpTN9PIikhzbFmHUOIGYLC1v2rqRSMUXHdyKfCfUV9S0qT1C0C6U32aKxY2L4cQLx8CQW7drWAr9rDxmjV8VgdM3fmQhTstf/Q==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j1-20020a50ed01000000b00560ecb22d49sm3827246eds.84.2024.02.13.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:05:06 -0800 (PST)
Date: Tue, 13 Feb 2024 21:05:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/imx/dcss: fix resource size calculation
Message-ID: <4914592b-4256-4c9c-bc1d-6dec1e473831@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The resource is inclusive of the ->start and ->end addresses so this
calculation is not correct.  It should be "res->end - res->start + 1".
Use the resource_size() to do the calculation.

Fixes: 90393c9b5408 ("drm/imx/dcss: request memory region")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/gpu/drm/imx/dcss/dcss-dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 597e9b7bd4bf..7fd0c4c14205 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -167,7 +167,6 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 	struct resource *res;
 	struct dcss_dev *dcss;
 	const struct dcss_type_data *devtype;
-	resource_size_t res_len;
 
 	devtype = of_device_get_match_data(dev);
 	if (!devtype) {
@@ -181,8 +180,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return ERR_PTR(-EINVAL);
 	}
 
-	res_len = res->end - res->start;
-	if (!devm_request_mem_region(dev, res->start, res_len, "dcss")) {
+	if (!devm_request_mem_region(dev, res->start, resource_size(res), "dcss")) {
 		dev_err(dev, "cannot request memory region\n");
 		return ERR_PTR(-EBUSY);
 	}
-- 
2.43.0


