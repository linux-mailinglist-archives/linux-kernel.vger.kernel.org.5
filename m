Return-Path: <linux-kernel+bounces-152097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26798AB8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E911F2158B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5ED529;
	Sat, 20 Apr 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkGECOqH"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21F33F2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580868; cv=none; b=qLGi6Kv3qwsYXssaveEqnqClce4ZfnsebUvjYCYuEA7IU7Zn8k6a5TcGo0hR9DVcdJfHIEUD9gR7Dvn4zqq5tXakzKMZ/qeBmm3hR1DDhHCawtpzhtCFg+CQNPQLlDjUmG0qXp0X+gUswtlhc+qr4tchkyZU6416GylonZkdfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580868; c=relaxed/simple;
	bh=9SBs1y5K2hzjnYPD9Ky3KqU2SZnDlGyGsApyJDQKsvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJikVOMHC34tbmD8JejG3xCF9Td7IWQuskSks4LT4JKNnxCl3nF15crKDFD0QJslVu8mOtArq09I+jsTpXWMeymy1LHhJ5+DE2klLOq5kl7aLKtzqMSqZzGJ8Y/4/eqsGc44BoeGN9sI3F4lEVhC99mYINh23l2T+Ap1aKZLN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkGECOqH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso2498035e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713580865; x=1714185665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSmAuCxNU1y3XahseuBRK4nFztnrZzASjwN1faGf/vg=;
        b=LkGECOqHIMIPnNQ8Pt+Kkb8Se3AjTMs660t63RPvMxLJgsBMeuZiie148P9jnVDV76
         iQa75IXzDY/2+ipvFXKtMqCy39w7xoK3Btwlkfc/sPvMyXLSLetQ6zlKzRniUKHo5zrx
         6NVGhNwj9sn2gHPhvA8+ZsdONFCJfc4W+n1j4j9NIcISTuA6Si+I71w2Szi4cKBA7mTb
         iz7oo21MudP/gNIPL8Bj+BRp/KnLC7Ghe0aZDXS7qVbf2U215q+cnWQdOmGM+u2U4KSB
         ZVOSzobkVAwFz3/+j1T/a2DvkbkJxmJDfGiBzGW1MhjdSF7obtJX6H/QttZ1TdydMymt
         8WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713580865; x=1714185665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSmAuCxNU1y3XahseuBRK4nFztnrZzASjwN1faGf/vg=;
        b=t4yOcVK8Z9h4dS1HtkEXnSQ9uLw27GYSfVbgKakLoUo6zZhwSkRRHizt7DlohQ13bf
         lw0TfKwcGFWMqQDtZjbaDxH/tPlxPJaMd2N2iSnXJzIfgGxNNoJFmDnVfxVAtDRGChh5
         RIMFrtXAqbKzrtAOBQPa7t6RsSMuED9+SCz0mYpmo13qhuLiGaENX2/z3QNX8ijFt2iL
         SOD8B1+JbarCOg/RwSp9nYYsDY3d2v+1tR+wn3lZ8tUGfqyW6GoFdzUQ4HIFaMKG3wQh
         dWUD2bkMgZEp8tMRJgDNih72hccMOoBw30bB2Ldk4WZzLWi/D7qF0ub4vd9ToROVGwny
         wnlw==
X-Forwarded-Encrypted: i=1; AJvYcCXub4yykLwpYjXtmhEvmDWLUmH0jQtGhn//9AyDcJnwZPh1bHPSPqtkJwpUmxJTBejNb5wTlf+dZFaxaLIYd6JBszHSSR+xkyC9CeUN
X-Gm-Message-State: AOJu0YxoBaD6gRWues8EAGuFZLfd3Uxao80BmPEq5mtpL6KIn0KnR0R2
	aIu0NgAYvCvUIzq+3tsQ5fAiyE9TLOzL0UkH38xPKmz45YYHBLwRCQtlTpt9Pxw=
X-Google-Smtp-Source: AGHT+IEgORzz5Sy7uopK88mYrNu4WR6OjysMQQsGBjGgh1ZjqLMNVs4IpmXJ343ikFhE5QjiQcON5Q==
X-Received: by 2002:a05:6512:2353:b0:51a:c548:7257 with SMTP id p19-20020a056512235300b0051ac5487257mr1068099lfu.34.1713580864804;
        Fri, 19 Apr 2024 19:41:04 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b00518c69b3903sm956951lfc.84.2024.04.19.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 19:41:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 05:41:02 +0300
Subject: [PATCH 2/2] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-panel-sw43408-fix-v1-2-b282ff725242@linaro.org>
References: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
In-Reply-To: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9SBs1y5K2hzjnYPD9Ky3KqU2SZnDlGyGsApyJDQKsvY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5qyth1D4+TVMU/O7ssqkMzQcj/nXJK7mukZb+MpR3fuZ
 s4mlR+djMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE9gULk4BmIjCd/Y/XAbVOztcDKU/WKt9
 Y36w3G53REaOgtqqd2tEHE+x1O66sq9ai9u5iPNrK9OzVRWpu/6sWeu5b/qF4pKssxLn1f9bRX5
 d5Sx+7cKSFx951+25U74kbHmHxJEA66SQ2gdytyMVbzY/CNnTa39Q2qLzr1JZoJ105IvT3mmOfp
 umLiy1NVP+yDlx8X6fnGpXRw+9HfuuHd3yaqFClt3/C+8OTmdS2jRbbmpQlPwxjmWvHn9/qPr2t
 JFerh+bdVIjx5dLAYL97L3fLhdaTc7aHzzZ4+zTkF1sFgdi7bMn12wPt97b3K6rwZpp9O6Wj+Ae
 aYvjS1Ki7jHGifGaMLww+3R1b93DN/uL1dJL3u3lNxAEAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
declared.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..2b3a73696dce 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
 	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
-const struct backlight_ops sw43408_backlight_ops = {
+static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 

-- 
2.39.2


