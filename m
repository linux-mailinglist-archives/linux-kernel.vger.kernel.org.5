Return-Path: <linux-kernel+bounces-131220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084518984BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713961F2538B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400D74C09;
	Thu,  4 Apr 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLIyDXgC"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529647FBB6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225298; cv=none; b=JZ9KNt6DHUagT14+wJpAGsEuMqmVkhFknPp9KHruDXhOQUqYGvVLkJ0Ko1S806tjRMCdQzJI05LG65HNa5sNZiq3f0NYyWt9yAoWMOHYNo5moM7++LJOngqcggssWOp1ltHoAd2Q8hjGbZ6ea8qzflWaPoNLNbzfHguO+T8Q1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225298; c=relaxed/simple;
	bh=irilOr1F66J72zSf/iZ/FxY1c7hsuCBIEPtG00CVG8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUej4wf3cTx6D7SKWOjpLAgEYi/BP7xTHyV8TaRLNy4m6CJUjFkU846QAOahNacmLT25jnN0ujreOCv2R5eKpBv39KiB8LBBjFeN4W2ZcEONMI6SaMwqrKGUeGFbTvSqOex+p2H7qgZHQ7/tAxFbWg6H4qg5eSwUG/tLHdES3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLIyDXgC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso900951a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225295; x=1712830095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gdreFmOsn9hnQ9/3et99EfVumTY2yhwD/QDrRRb3VQ=;
        b=CLIyDXgC85XIjzyJ6IHHDeQ6722QQjxl6N44zrZt5w1FUsLOYZG0V5jkMiaF0XPPBc
         7UJJzxYiMv+iUaBP0iyIvbx1SFxwN77UhhCL4/81N/tpCjy6fuGdhUBUXoTA7lEjBPK+
         JTzpp5RICvPgz31iy/2dHRcL3r73nfMe2xUBPwMEkqMJLzXUbQZQ0Ry7m9TtNpHmq2q5
         3gCXXr82Zi5nb0ggYydVMS4rOKI5CjAZ0WLBr22vkIGeGUiVl6p0z7nKziQovLaaWEzO
         x8PKKOlo7GBmO29eINqK/1vLAL1VMNC10DDRnoVtkAd5e4nXLF/vfQ6fhxtLkj5dyjtx
         sX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225295; x=1712830095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gdreFmOsn9hnQ9/3et99EfVumTY2yhwD/QDrRRb3VQ=;
        b=VuQx5ApeRKzkBUV3/h6yg/v56hgd2IMqijy1VwXAeHefjiMsLzXhOEjMKdQR1JJFJs
         UL3/BcHZCN1xhPy64AfYKFP+2BfX8RovnGNQPQoEIoYwx48NDPDTHSkvev0fYl5lFUXX
         giukVeFFViBga+8gf/kAEzmX3HCGYenpI6wRGG7E+W1yqRqDofZud3vUaiU9MIA6lLvb
         gx6AKmb7wx15Rx5apwXJTIc5lIMHUHsT/GR08ZK+UaInF9ObuE1UMPREciYF20XuGQiM
         QIpCLe3h0wnVTh+Raas4tLAu9HgBEGn9YPifNW7wG5KxjXes1rAyNbEpq+w0th1zK3g+
         WOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7kheZH2xFx8Irs05EuZSdMgFhMjN33XK4HqdMUflmPq7PG0LTe+krK08nGlY+wMFnlTxeVVqFrkm2Tz3Sxw9f/AZyDVXdv0SDLPPS
X-Gm-Message-State: AOJu0YyEZZPPp3vScEpJ/L7qjOPDNZ8FRD49O+Xb3/0Cma1Z2ib2ZVf7
	F+ahnR6dPDfXCiEC8UU/FWeU2Xv0APjI71D+VvdfkQjUPrRvR774UgNxAhH5FBU=
X-Google-Smtp-Source: AGHT+IG6MIBoUnhn5kD8YkyWDaqubmu5zZw/UDEyEutc/LQNpwjh73npo2Rh0hXKgklGbZY1tDHrxg==
X-Received: by 2002:a50:999a:0:b0:568:b622:f225 with SMTP id m26-20020a50999a000000b00568b622f225mr1367415edb.30.1712225294754;
        Thu, 04 Apr 2024 03:08:14 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:08:04 +0300
Subject: [PATCH 6/6] drm/panel: visionox-rm69299: stop calling
 regulator_set_load manually
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-6-9f56953c5fb9@linaro.org>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
In-Reply-To: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Harigovindan P <harigovi@codeaurora.org>, 
 Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=irilOr1F66J72zSf/iZ/FxY1c7hsuCBIEPtG00CVG8k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwGO0eQ0yN5Gyv9QpomFj0R6gyXZ+5rtNEtm
 IGQoU0uAEaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BgAKCRCLPIo+Aiko
 1WYFCACn5db1y7XDZnwi8s8NKNDV0h88BTcuOpypH5tfLwAH0CVs/5d5b23X+DvXMpORhQEi1jY
 Dlh/F0h8AceX/ZhR04srs58R1l1cV18WdVKPKoWheb7OstyQjJweYXovPKwMHJ9oAgyIVfGWA2b
 ZkPVfk1YaWtNi7jLO44GU7J7TOMbi9Y6tHvkxgEb7LpRXi6KzxA5Vxn/hlitMipltv3Th8rHBbU
 k6h0ttkCAmQbWlJKlqYqcNOE615htx4ndaJ81GMF6rJ4I8/2/oiVwmjy5y3aLOLWsJ0Iurs02L+
 MwsKQn0YXCDkU5gtyKKVeeXSmjgnvndGlJJ+gU7szKQ6+s6Q
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use .init_load_uA part of the bulk regulator API instead of calling
register_set_load() manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index b15ca56a09a7..272490b9565b 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -197,7 +197,9 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 	ctx->dsi = dsi;
 
 	ctx->supplies[0].supply = "vdda";
+	ctx->supplies[0].init_load_uA = 32000;
 	ctx->supplies[1].supply = "vdd3p3";
+	ctx->supplies[1].init_load_uA = 13200;
 
 	ret = devm_regulator_bulk_get(ctx->panel.dev, ARRAY_SIZE(ctx->supplies),
 				      ctx->supplies);
@@ -227,22 +229,8 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 		goto err_dsi_attach;
 	}
 
-	ret = regulator_set_load(ctx->supplies[0].consumer, 32000);
-	if (ret) {
-		dev_err(dev, "regulator set load failed for vdda supply ret = %d\n", ret);
-		goto err_set_load;
-	}
-
-	ret = regulator_set_load(ctx->supplies[1].consumer, 13200);
-	if (ret) {
-		dev_err(dev, "regulator set load failed for vdd3p3 supply ret = %d\n", ret);
-		goto err_set_load;
-	}
-
 	return 0;
 
-err_set_load:
-	mipi_dsi_detach(dsi);
 err_dsi_attach:
 	drm_panel_remove(&ctx->panel);
 	return ret;

-- 
2.39.2


