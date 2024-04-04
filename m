Return-Path: <linux-kernel+bounces-131219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502218984BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9AA28474F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF280049;
	Thu,  4 Apr 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGvV+553"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378D76408
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225295; cv=none; b=cBVYBhxje51sQpC0vRj769RnN6LEkQHyVHvfC2LKMiCJ5DUhs++bArDsPpsge3pTlYizLxpVB8yK8jtHeu0oTJo9V2/lipqfspdTp1kFd01RRfShycgYQrbqvONXxXRFmMm5oObokkRvCm46VgspwYLAnAYQ9qlpK1qeulfUY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225295; c=relaxed/simple;
	bh=H9DTnvxOhLAsFMR7/zYzkTplDuaaTlPMoOsjC54VSys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9euaUkXDqUnAZReDB1aGB+UAbBYYspto8Q8P4gIqbLNTN6iKx4Pmqtj5WqG+ahTEQ2IRgY3l1AIqtfKbelofl7/ThGVA1927BE2gXsnEr9v47ielGCe2lAr8ziZwIh3LxsLV9E49SZ8Q5uZPwsYgcFRze3YjEKfip/p8nBrbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FGvV+553; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e1e6e1d01so567298a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225292; x=1712830092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iEJ/RqQGEQXC2ep2uq6icF6qECUCl++i3ec6IEoffE=;
        b=FGvV+5536Vr9GcNjfcNwLP7nguEgD9n27jEy4X/Z+IwIjxIqkZf5O7He8p1pLCe0im
         CeTHdVJ1UctmJA6EGpHA6lkSbO1ecPTfXjkm3RZrgfG/emgb2il8poDUjLJoim/EyU2G
         d3K7uezKjrhZJPJrNmAy4EhIlTp3Zi2ItIwS7wsVcQZZNpWXAgeCknoSAyCIMZyzmtS9
         ZQAqQ5C3Nutv5kZ8ksOXcaVyo98Zei+AaKTcLrX1O+ISpA1Q/spdO9O7VSpghKn/kwN2
         kPfEnAjFoWweOVOhIMjGKMCQrQswgiClN45hMs3TPrJeF6kK0mJrB6rcnLF0jts4gpZF
         P84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225292; x=1712830092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iEJ/RqQGEQXC2ep2uq6icF6qECUCl++i3ec6IEoffE=;
        b=WM4rTrh9F925OiGoDawqNeU8E0prcjiXKHdMTGXl21Ol/e3ATQ9MYI9jEiULA5ji/V
         +yrFfg2fGxWPVsXhEvUEadkH/hWxh+wk9itJMZp7oB5vJxydKGu+aBiCTzTH9uNn6q6F
         dOxrx3oBbVxdqHmSw/xdyq9uoYsnlBUDAgWQjaNBFb+aWtz1AmrgJraNCEpXORTHCmqP
         N/kClyzfd+Mj3dqzvSsff5BC1AsrCLOds9ODzW8z/B74JGREP2V9ynWuQF557TB8AirN
         Dv+tByDU7YR8euAiiw/jfjvmpzT6Lv+J/yHQ32pE9lZF0rKW6gKsXeyW8maNrIt9ZXQz
         B+vw==
X-Forwarded-Encrypted: i=1; AJvYcCUVS9DuweZLDe/FboNKmY0dsNGbPPHfvTF9EUAKtqKNdd5R7keYa5ywrAFPOq/C4t1ncZvPt4/UlCpqL1IbeyxpxYWiY2eKA5ote+fj
X-Gm-Message-State: AOJu0YzUTT8LHY2bN6JBgL20wGqIYftdV4/5lonq8JtE7ub5a5rqT3rN
	cFT75Brxd6TLxwYG77EAK5lMvxrIsLlk3Bp7Lu5WCKYREQy8+27K9NP/VXbp6ROp81Pw36eNCE3
	W
X-Google-Smtp-Source: AGHT+IE7uZg+Q8MxKj9wP0qIcOCX5VGa3Rs8Ms9OK8oC2SCWf7JhMx8FjKV08qwBA1+QirOE+lHo/Q==
X-Received: by 2002:a50:9f22:0:b0:56b:a077:2eee with SMTP id b31-20020a509f22000000b0056ba0772eeemr1463352edf.4.1712225292236;
        Thu, 04 Apr 2024 03:08:12 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:08:02 +0300
Subject: [PATCH 4/6] drm/panel: novatek-nt36672e: stop calling
 regulator_set_load manually
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-4-9f56953c5fb9@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=H9DTnvxOhLAsFMR7/zYzkTplDuaaTlPMoOsjC54VSys=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwGOSkOIwSEiA9PVDGHOoidJ+W9OPRJ8acpz
 nzm2l9u+zqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BgAKCRCLPIo+Aiko
 1WMWB/96tYjo2hhtiGxIK0g/c0rr8Y2g8PIUfBaRQ5yKZE6bHjOHd5kpM6RTO95gR5cX2m37Vdz
 UdtHFCsw0p0GHa7VQMeJHwwmYGlyq5kRRXYAJWN/xffSJZXSFHO/7jf3lt6u+zTKuIjEdWP00GK
 65z43VET+dmpitof8CNOty04Q0GD46F76Zivvy9YjMyNO3nH+EThYsPB92alpFXLqdZvkt7G3Ih
 IuydjRCHtNDxoaamGsLDzUPVrBVVmAEWWT2+dntfqtcB17zyb98nVkcdXqTpX6BDWWMuCqgzjbM
 YNdfJaHSbeOUe324ctffoZk9jtJan5O0VkntBwKi++N0l0Tg
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use .init_load_uA part of the bulk regulator API instead of calling
register_set_load() manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 9a870b9b6765..20b7bfe4aa12 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -343,17 +343,7 @@ static int nt36672e_1080x2408_60hz_init(struct mipi_dsi_device *dsi)
 static int nt36672e_power_on(struct nt36672e_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	int ret, i;
-
-	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
-		ret = regulator_set_load(ctx->supplies[i].consumer,
-				regulator_enable_loads[i]);
-		if (ret) {
-			dev_err(&dsi->dev, "regulator set load failed for supply %s: %d\n",
-				ctx->supplies[i].supply, ret);
-			return ret;
-		}
-	}
+	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret < 0) {
@@ -550,8 +540,10 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
+	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
 		ctx->supplies[i].supply = regulator_names[i];
+		ctx->supplies[i].init_load_uA = regulator_enable_loads[i];
+	}
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
 			ctx->supplies);

-- 
2.39.2


