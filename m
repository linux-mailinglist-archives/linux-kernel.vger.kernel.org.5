Return-Path: <linux-kernel+bounces-131216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AF8984B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D136282A61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229B763F4;
	Thu,  4 Apr 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdP8f0jv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BB757FA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225293; cv=none; b=pARZo/NkAFq7gcv0kcT3Ak8tJmohsV4ui/KdehRqT2BRwBY3f4KMKWZOHNom4a7W71Bmwo50p0btvC9ux1Nc7jcng20Jlany3+nMAHuekdsLz4j2XQFK5JA+t6XEKlnXW8lsZEgiRmKo4hX7jgLbBZkldhSyq4WH1zEGAIQ/ERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225293; c=relaxed/simple;
	bh=xtfhuUTM99xHxoMeoYk5bzlIduxzhp/GTlxP2mkYgaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugcxyvkguKGlwLHbUIac6mdLjg852HEz9Ts3JBZymqfaZuF8kYM7chp0344fWCsTOQCmz2i3z9ZUtaxywzUneNztpxlAjDTPm8n5euj+Mq6cLUYNYJ4TovAeyheyBCQ4KiC1VBc8x7gMGLpOS6drOKlpP76Rt9JLMQXFrgJXwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdP8f0jv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so709297a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225289; x=1712830089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp8USTzsG3ntp/LxWp9gHMeUcZJjL0z8l7/Rhp/dYWg=;
        b=bdP8f0jvBZzFFGLvxufeHDfpNSFBNDnFaZWURYpoV9OcBfvUkIDRiFF0qmCTIlVhbC
         xTkisHlyHE2pYA0J9w1TtP6HaFf6NH3Ih+ITuS+ewGnPFEtX7SELM+rFiXng0GT9MhRV
         5CD/WXtSLDI/kzrP5H6pQd/K8UD9prWxY8qGBvpsQEqfFHO8u6YY93nYyxXPoMiG04gL
         enpR0CobxVw4/Ry5mD/yPqQcvvBmmDcKGiuPi4DVVgf9uP4nc0pSm2tUewVJvKi46qGX
         BPakQIUHDqazePcyZEu2muIjZ7y+m3r6/oBPXrhMOvhnj0KYwEi6Upe7RNnO7cLCHshV
         g3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225289; x=1712830089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp8USTzsG3ntp/LxWp9gHMeUcZJjL0z8l7/Rhp/dYWg=;
        b=vlsMQ+mhkmEZPipiwf0eY7vdjmBQQdprajv1T5O2nXSdksSN7mprASAfcul1OC3PFR
         H3fEp67hPuK+dHvwzVGno69Z3xw+Vf+reY813FDrNIbIkSzL1foGVEdduZd1DeKbxX3E
         SZmzrt1twsYEqzUORnsEe1Pudz/oaDgEh1Wfr6tnaSpsn98va5K4vPDoVAZtFmqMuDr3
         ktZWSSN8Hs0J0corH8/FCcNaLNLv+Qdl8byFh0IAGCVO/Le0/HtwP4OpxAVu77TRoTQv
         YWnewIJ5iwPjrmopmkhRwnwJq9IK3zDQbHtWcKbveASQUo0ke8E86mfwgKAKWPmLbblC
         yW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdrF+OTSu0P8yHU9WAWg200Wg3uQ6FfThqNojWwlzymStaVcdHlHns84+1LNiu4wx4JpQCXC6EtQHiihUW6Nt28G10CrHCW/NVxEz6
X-Gm-Message-State: AOJu0YyE7duseaCYhxwGFrLoBeqtGO2xq2An2viJUfN8Ru4kOrICL5n/
	aBKA9H8rn6U/hCoDoVYcBfDjRdfIVxiJvqofYINSmfQUxc4QsOx0B2ASx7s3ItU=
X-Google-Smtp-Source: AGHT+IHpY7DJnbfRwrN+pggOgCfH6syNZv4JzFQ7NFRdr6EFSZOLNeW3eQkAhrKYCeBUc5BBBg2YBA==
X-Received: by 2002:a50:d4de:0:b0:56e:df1:534a with SMTP id e30-20020a50d4de000000b0056e0df1534amr1014440edj.42.1712225288726;
        Thu, 04 Apr 2024 03:08:08 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 04 Apr 2024 13:07:59 +0300
Subject: [PATCH 1/6] drm/panel: visionox-rm69299: don't unregister DSI
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-drop-panel-unregister-v1-1-9f56953c5fb9@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xtfhuUTM99xHxoMeoYk5bzlIduxzhp/GTlxP2mkYgaY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwFymsormB7E2rQzeFs0/IGcTvRxMiWf2O5A
 yUo7xUWQCKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BQAKCRCLPIo+Aiko
 1TgJB/4z75ZXyRi0GestVgdCyBjlrKyuTdUKv5EevhWnh+aLaSOFY5w85Ts/sc4S/+3rDxvdwU2
 CkN/oVbiKN54mlfRaS7cm0j6/4ZpwgfPkr9H/WmkWaCG5eC8HSr4z3U46sxjNJdaj3FuUW8ouk5
 h04EnLDzSFxa+NJdOnAoFE/qEWblFiPDpVFKpw/ml2sjTU1HUObnzOLZtarfPdKnp10mk7Xmgte
 pwYLYkrAbrUp0xySxMlW7cfEQS6poi0IhoOj0tt7YLGHJq5j5Cp7x/HwHMfaFAyrayEdvlIXJMT
 TQ2msvq1B4rSIXl5Ein9MwCCBaktTd8fYP5gAedMvW3SnueF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The DSI device for the panel was registered by the DSI host, so it is an
error to unregister it from the panel driver. Drop the call to
mipi_dsi_device_unregister().

Fixes: c7f66d32dd43 ("drm/panel: add support for rm69299 visionox panel")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 775144695283..b15ca56a09a7 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -253,8 +253,6 @@ static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
 	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
-
 	drm_panel_remove(&ctx->panel);
 }
 

-- 
2.39.2


