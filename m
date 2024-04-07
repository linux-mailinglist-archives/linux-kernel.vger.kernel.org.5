Return-Path: <linux-kernel+bounces-134676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF389B4C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3553281475
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11747F7D;
	Sun,  7 Apr 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPwi7f1j"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11082446D3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712534036; cv=none; b=nbJdJyiLkPf7i6452S4r6gzWNF4viXSwnjLPy4msItDbui378igdoKheL4c/aW1+Sj2zkheQ/WZxnREH+vyi7Ht+G3XRhY5hbfB/79pJ8LXgrM3nKA0K87X2HS9Y6cZPBUl483EhthBTx2GySc0CbBu4ANfr08Tmop1sdqaB8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712534036; c=relaxed/simple;
	bh=Jn//Iw9esRD8TM8P085ElFyT7MDokBKCt93Vkd/VJlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSRogDEVIfCqp5dKJwyHw1RBsq3e36M9fAlvJf1r0XFqa8kEbWkuYFL9iQaOxxjk+Y80ZHCDwl4/1Ku56Bt3ykqPemt9WoPAy4WbB5U4z06wNZzR4Jt2chKesWfyMb7GIU55Fuz4hqwVrAei1ZYtkO+WTyCLE+YoWb8Awib8po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPwi7f1j; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso49384861fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712534033; x=1713138833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04Dqjw56oztOKjOx6AEdYJc7ELzz7GKlpOl6o5T2ns4=;
        b=TPwi7f1jIKK4p67zPLyyW5TKaq7hRFo0R66PHiguAWeOTz8N4wCrxR1zNnSbwZ7GpN
         cYoYYbdMWnBISBBK05le1w6hXfCtswxkhQxnXXtVoKWxb0Roi9L6aA0fElHoHZcRgzq5
         9n6JiSDsT2+9C96EQqzWc0g6RHifRE6je2XA9DTH0+g167A1lDgLHhBATvK//wpwKGkB
         fC3akr5tg88kl1z42Ic2qW7ZQwElDdsYysiQj1+eZPSXI5vUsrUc7/r9ECqlYloVrs3s
         TRHEbYF8kB7GGmxKU+qH9aSzbDiE5c3sQAT4rtj47wB2gCF5pT+mvs+leVNN0R2bxJuR
         LDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712534033; x=1713138833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04Dqjw56oztOKjOx6AEdYJc7ELzz7GKlpOl6o5T2ns4=;
        b=SCW4Yg09sJbab7avkPX7MCntFsSaVNSfQPbBGajbzYJZDOVcI221AcAitYUzUlSlDE
         oAZkpUwlJh8jJ3idIMYtpjODdhpTuZUB96+o4qH0hgSxQgjjj1a2fRKLiAdR9PluiVIq
         lVdQRuMIecn1kTwi4DcUPCxiafvYEN3udm+WWNbDr4aofHS5Z+1OmE0puccaGYPAKO28
         C3JLP99PG717QEZ3H15q71l+rzJBMGjxVxj2V4N9+X9E9b8mpx8UxicYodc9HotLMhCP
         LnahEL1xy3Ic3tqPiL9nXCGE18I4FuiIJNwgRxrp79xREdzClFtOdEN/h+X6LbVRj+Kv
         2Kag==
X-Forwarded-Encrypted: i=1; AJvYcCWT19eIcnk0rpodtCKLg9w3HP+oggOJSqXx+W115sRY02xqvaEzHrF5oRBrY0qNIBfnS5usrgM8cv9eRym8K5lgn/GaY+WDU23YL2Jr
X-Gm-Message-State: AOJu0YzF9O5I/9OgR/PmUPCJG7r8k62+3iYq1ip0mskzqXINMu1dpPi1
	SMUT1cB9kkEAtPscN3gulhyEhO8PdlgP8iLl6072V5YziBKT1HW7wBVNFnSnGV0=
X-Google-Smtp-Source: AGHT+IGGJI2Ba92TUEzGsRtkoxj8sHZIcavmkHqfKJNlxt+JCsOBzcXsH1wevqOOTob8rUMw+YY75w==
X-Received: by 2002:a05:6512:510:b0:516:9efc:6c38 with SMTP id o16-20020a056512051000b005169efc6c38mr4664785lfb.44.1712534033332;
        Sun, 07 Apr 2024 16:53:53 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b00516b07fdc26sm965696lfk.109.2024.04.07.16.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 16:53:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 02:53:51 +0300
Subject: [PATCH v5 2/4] drm/mipi-dsi: use correct return type for the DSC
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-lg-sw43408-panel-v5-2-4e092da22991@linaro.org>
References: <20240408-lg-sw43408-panel-v5-0-4e092da22991@linaro.org>
In-Reply-To: <20240408-lg-sw43408-panel-v5-0-4e092da22991@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Jn//Iw9esRD8TM8P085ElFyT7MDokBKCt93Vkd/VJlo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5qwER+vpasEz4a1AuuUvyk/ClxTNZ9XrWfPkpYzrNpn7
 ly+eWl/J6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmYmrL/leumqn/090ehhMb
 Vl2yDBa4cWavqbey7s/rqycqn7jPJvcpo+jfw+hXBTstnTzTFp0MYPWKdPZhiV53S0CM3S8ie3G
 ltprHZHkH+YdCTlzHni2xP/hlqn3e9NklJ88EHJy04ZJMdNXzuvr/v1xOhdvvnDgl+HcuW/H04I
 MywfXXrDeum613xVtLRjzV41zvWSNdmxOTFn9i8XrncTeB85+raztbJdOb7W9mB/TOnGZ48MIJj
 kj7iIC4Xdm9U8u1Lni12Mk9TEkILVe5UH71pJjCqlcsZ9N4Z/xZoBbqf1h+Mlf1JsHopFfNdmqW
 DyKM/Sxuugv29XptVHg0ZWdVnWEcx29eN9k1Mw2CObRSAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The functions mipi_dsi_compression_mode() and
mipi_dsi_picture_parameter_set() return 0-or-error rather than a buffer
size. Follow example of other similar MIPI DSI functions and use int
return type instead of size_t.

Fixes: f4dea1aaa9a1 ("drm/dsi: add helpers for DSI compression mode and PPS packets")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 6 +++---
 include/drm/drm_mipi_dsi.h     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index ef6e416522f8..9874ff6d4718 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -654,7 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
 {
 	/* Note: Needs updating for non-default PPS or algorithm */
 	u8 tx[2] = { enable << 0, 0 };
@@ -679,8 +679,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps)
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps)
 {
 	struct mipi_dsi_msg msg = {
 		.channel = dsi->channel,
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index c0aec0d4d664..3011d33eccbd 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -241,9 +241,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 					    u16 value);
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps);
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps);
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);

-- 
2.39.2


