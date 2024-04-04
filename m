Return-Path: <linux-kernel+bounces-131218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB698984BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0741C221CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F07FBC6;
	Thu,  4 Apr 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWeMi90m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08076028
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225295; cv=none; b=LOYHXrMTMN+24msHNQRXvRasd5xcLSmKpSmuVrgfopxMnfTJSzOC7OUTDksBBxOgLZmGfYANS8kvfOpzShXQI7VuCewiwvGkR3LIMYBMheNikkkiF1Owoye1l8d8j1Di6CqbBqOi7AWMCjwwkbdaIXOnMSAUqZwYiofVpaGlD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225295; c=relaxed/simple;
	bh=rZ4pFCxBcKO4r0UopE2b8togAYR+akgCS3Rw6K0bDz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4zdGrAk8hk5VzgtnaFJa98HjixiGlSsvfPJtFB1jAl5WkAvvfJ6mtVarqaO0djdVDqlCsGBdoekF98esIZP/bBeiHXkr0UM1WkWllkp9olL1yF+d3/iOXTgk7Ix335Xi2r9nbzTpAAa0WfJoUFRInelwX8JLhWkbVr4x8aoSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWeMi90m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516bf5a145aso945833e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225291; x=1712830091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdIQoQEcKOWWU/GbrzKgWkHTMEPIUceBmA7aLedovAc=;
        b=XWeMi90m+ed65nbxWADoaW9lJdCkiajuqNdBBjCVI6pWMnluEkSbegu6qiMFyXxLRf
         O+QdmeK1PvkEbQVitNu3C2YbiA3BnL+NSxfOUAAaqnZH1nm1BbvMlBqMd1gJEwnLBxUO
         quVaYQYd49A4Epn68iqjwgl8WK309siMvqcEkBIZMp8QyOGBla3QOGc1fs0H1FDI6RWl
         0vUpNqr22WKDjStSwjP8jZhnHJgQjCPZ402O8ursQH2g4dr8hVZTbVWM2NyQ6HOviE7i
         JmXMF1ihBBJsZiX6NTFa/tDfPBAwCY8MaMQJqNvp5AhSAC6154afzEHc8aLaRdIq201e
         Zj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225291; x=1712830091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdIQoQEcKOWWU/GbrzKgWkHTMEPIUceBmA7aLedovAc=;
        b=WaxHXpRu1FxB73k1j5+UHyMT+QElQ86PtcJAWMhAoasrHU2wikZTDZP9DGyYgjWaPn
         PS+wsCyucS6jFkjBc60eHFtnWW0R7x+xkKaxeOlDMXU0KOLbP49TKduv9Nwy6297DxNO
         +HIHxRNNFuWCIZPZOtnQVuqSdNwGUeMdZpPuFwfITxsFQ7ZKG5+3pwZfudm/orMd0Wv3
         4TMo1TVDOJlq8usZ4ftPiUsTtsoG6TXuljTGsmz+LCWQnHsBk2P9uXUMRoz9aspOXFE7
         b7RC+pW5DnRV3PTGyVm6xJTbCXyVnSdX3O2EXT1+nsMR7QWHe76EWujfrTi3IOtNxXk3
         4zIg==
X-Forwarded-Encrypted: i=1; AJvYcCWuVQ6suKeDFGQ7UN4fsQGsI4WpgDxSpAqVu07cOj0Mmmp9OPl+OEXxiLJq5Jfu70VvHUIenfFr1ETE77KDuXM8vPT4u8j64dAR1lWW
X-Gm-Message-State: AOJu0YzbNDnDtAv6QwMtLuE8g+/rA2u/ltyaYAi3nfXIcL54CC5M1LDw
	g3FvNHAYWM6kCusI2Y0hiS0rwAa+4aSBKgEd44TPdFWuQSZ4h/Z43ROZGwx7gI0=
X-Google-Smtp-Source: AGHT+IGVlQ33RJEgohTvVD0EMCqh4p4Buhi5vVkciZI4lYNhGCrK13DBduxsmLyc55fg2pHBdTILcg==
X-Received: by 2002:a19:644f:0:b0:516:bfd7:de92 with SMTP id b15-20020a19644f000000b00516bfd7de92mr1308662lfj.43.1712225290902;
        Thu, 04 Apr 2024 03:08:10 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:08:01 +0300
Subject: [PATCH 3/6] drm/panel: novatek-nt36672e: stop setting register
 load before disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-3-9f56953c5fb9@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rZ4pFCxBcKO4r0UopE2b8togAYR+akgCS3Rw6K0bDz4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwFAm7x8NXoFqiIBscoezOHH9QYMPEReQDM6
 baVaKAbFWeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BQAKCRCLPIo+Aiko
 1ZRhB/0Umx3VwSsiurPyTfgDRGxeKFo9jV4d99djRhqqhRRDIYlh8kwO4kA/En/A9IdV0bOtlR9
 /tdlRL1lMwq5S/Z/XcOzVee8BHb9ffUqX1dOuUuTltDlMQWoOaDrLarzWzFAT31SxJPISPS2/Ba
 t7yEsKdIiV9/+9QaSvG35b8LNMeiCtyFsBkaNJrbiKOOTsCDquPJgIy9tVHDlHRtqbJ+8CBaexn
 QgKfxEqZCuj1lh7PHG2SoHaV1GeK0QD7pl6DA6kosRxf9TFkCE/IgmeNJdL3msAFWJcfb2mAwKv
 O7iqZ6oMAWOYwSEiq6XRjNpjv5vzQFFlPs194hg5J4rHFlyG
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

It is pointless to set register load before disabling the register. This
vote is going to be dropped as soon as the register is disabled. Drop
these register_set_load calls.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index c39fe0fc5d69..9a870b9b6765 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -25,12 +25,6 @@ static const unsigned long regulator_enable_loads[] = {
 	100000,
 };
 
-static const unsigned long regulator_disable_loads[] = {
-	80,
-	100,
-	100,
-};
-
 struct panel_desc {
 	const struct drm_display_mode *display_mode;
 	u32 width_mm;
@@ -385,20 +379,9 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	int ret = 0;
-	int i;
 
 	gpiod_set_value(ctx->reset_gpio, 0);
 
-	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
-		ret = regulator_set_load(ctx->supplies[i].consumer,
-				regulator_disable_loads[i]);
-		if (ret) {
-			dev_err(&dsi->dev, "regulator set load failed for supply %s: %d\n",
-				ctx->supplies[i].supply, ret);
-			return ret;
-		}
-	}
-
 	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret)
 		dev_err(&dsi->dev, "regulator bulk disable failed: %d\n", ret);

-- 
2.39.2


