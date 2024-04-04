Return-Path: <linux-kernel+bounces-131221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD28984C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99F21F2550D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26123823AC;
	Thu,  4 Apr 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkGy/fNE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E57EEFE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225298; cv=none; b=KCf+xzMAUiZrZXHS+t3UBEF5Yq1TBXiptUS00IdI+2HbHYC6ZEpNRQpcbdyFFhbpeGwEgfzOWWTzDAbc8Q72wN8MsCKRuHpxPH+b7eyS85EaSMegLIK/GLkKR+bVBmBf0okqVdNX05ILc/oJiSpo6Lw0LhZcwOS0XyGrza57ZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225298; c=relaxed/simple;
	bh=eCcqI9AuK/Z4GvlfkxunJCyaNrb4UqWmCkVQLFSw/nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxXFZlZQid5b8FKs5k8nm9KgJGvfzVBmUAUmpJ3nbC8gmP/6Asp8haS65fUfNdzRrUX4vbglaDOJGk4/eB1vSb+qpVU+Ge35SgiiZZlm8RW20wHPN1tH29s2Gde3w0XnJg+BmXd9N2HsenuJH4TA6BS4estiMMdCbgivUkz7LzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rkGy/fNE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bf63af770so421472a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225294; x=1712830094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPN+AHE8y2MkIJuM9pYz2Ll5VT40Ao0mKYYFM9ZEDlc=;
        b=rkGy/fNEhQnPQWD52y03jTdlR9AyZIu8+ALVFTGJiSImk52o/EeXDiWbtzwFrIW8r9
         Oc1fipeS5A/7IdPuPDBJGjsCf29Ex23BOWbSlwicuC1Udd5Y4fie29TKQr/7L7ojLPsi
         FWttmxZqBSk9pSp+W9AJ9AQr0/u6VGn2lqfvDepwYAGImXb4nyfuu7fUkjx0uSApboku
         C9w/ulXlBMX5IDsqd+1wLpRyuZyLCSjakg9YF+ssnIoEYbU/ZyURrOxTuNpq+ZlAbcbI
         5n35nblyjZ+s685yAkFId1LGu8EQ5evKyUhvXIprNB1SuD1a+PBpy2x2hq5w+V1uj9bO
         G3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225294; x=1712830094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPN+AHE8y2MkIJuM9pYz2Ll5VT40Ao0mKYYFM9ZEDlc=;
        b=mTWnWxuMGrSXedW408QmNI8ffmKWJQpjBE8+CFs/i6u2QtqegJU0o8i/5WslLBjTnU
         IW7KgMOvIPZc5xZ3T+ibmQyVXvbXEXs0N1Bptu4/d/dXb8Qej1zXc7Vktuwhr6AQ+kUl
         HMabVSHevSxIakRU06bziviF5v6UDgbCsraIWHnlUNU59Ho2zp01FotL7cYR66KRaH8R
         wPgq4/dy7P4IzIU/72yoZcDNodMPhiBv0ECZqdWuP6+7ZUrXnu1Ikg3ZdxC5TPgXia+y
         EZjR4VVg33kRRinE/qADSYb6ienAZi+l9tJHBLIZIIiYPVnqJSnz080my0j2IBcUoM/z
         bgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUod42iS8mXxpovvo9gqechGlHX+Z/eKh6v2FnF3UaMVx3RD9sFlS2qpUBJctlqHVODyppPjt2FA+u7unD+nsu92aj5MuibZ8P3X6Xw
X-Gm-Message-State: AOJu0YxwPsuQz3sadxwq6XiRl2VnGSoRwEaFOUS5jkS/kJxHPlpHzVKW
	Csy8PjSQJfJQNRG/RaH4/EZOe7ljG7pt15VWQK+nsHt+9nTh681oxd8Z+I2piF+5b59sitNZJ4T
	f
X-Google-Smtp-Source: AGHT+IG+bzEJEONgFdA3wAMbc5bzkjLYvW9jbIlri8O2GdxrDMhypvw8vGmRretwMNzBqrsEp+LLtw==
X-Received: by 2002:a50:9516:0:b0:56d:eb22:eaf2 with SMTP id u22-20020a509516000000b0056deb22eaf2mr1641222eda.21.1712225293709;
        Thu, 04 Apr 2024 03:08:13 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:08:03 +0300
Subject: [PATCH 5/6] drm/panel: novatek-nt36672a: stop calling
 regulator_set_load manually
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=eCcqI9AuK/Z4GvlfkxunJCyaNrb4UqWmCkVQLFSw/nQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwGnnj+WYVJzPKl/9S+XC8FxF5CW7r/Do0cf
 314BZ0pIASJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BgAKCRCLPIo+Aiko
 1VZVB/4z5IlE0BLotgSxrMP0zTg3pTxhrC760H1bsEoAEATmeiT5vkTHU3LD95tNz3V8GnPGFDF
 YrGEzRLYnT0SOGtCu8HEXePqHwzQJyr1Wo900PMx/JZj56s91T5ya+wqhW4mZwda5H0yQVU2rk8
 l92jyhHDAuFtuL6Ey9S5DIR4w8zhC2C6GM/Pv6YBXS80WgqFUHMgjjzF3NM5FJCpxqgut29qpSs
 svgtDFYO5QNcRXro8ChmX0QRZNzX/tFAzKqf/kZtc5UEimqhbnM2eiQfdB8Os08R1FUioTI20em
 +CHMaTUzjjXXAjk+1ZwVOZizCsXDwF1x6pCj62qPSYbSBfFb
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use .init_load_uA part of the bulk regulator API instead of calling
register_set_load() manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 33fb3d715e54..3886372415c2 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -605,21 +605,16 @@ static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
 	struct device *dev = &pinfo->link->dev;
 	int i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++)
+	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
 		pinfo->supplies[i].supply = nt36672a_regulator_names[i];
+		pinfo->supplies[i].init_load_uA = nt36672a_regulator_enable_loads[i];
+	}
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pinfo->supplies),
 				      pinfo->supplies);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
-		ret = regulator_set_load(pinfo->supplies[i].consumer,
-					 nt36672a_regulator_enable_loads[i]);
-		if (ret)
-			return dev_err_probe(dev, ret, "failed to set regulator enable loads\n");
-	}
-
 	pinfo->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(pinfo->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio),

-- 
2.39.2


