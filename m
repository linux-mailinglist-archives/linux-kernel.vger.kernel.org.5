Return-Path: <linux-kernel+bounces-84755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF1286AB18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA72B23F94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B23307B;
	Wed, 28 Feb 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz8cCpXq"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DC2E84B;
	Wed, 28 Feb 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112047; cv=none; b=Y+42zKeDgURpOj3bJK/R6S3BHzBT7e/F8oIAJgvyvsnFf6WAw8a15ucndv4Q8BeQpcN/spRgikS/cXu5O2gPTCU/FLonXFXbav22MhSFvcA7DjDzp5FXy7RQ4RGUoLjgDMLJAL6mYaKY0bIqsicTCrNYyyeNWnPYTenI8QT4rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112047; c=relaxed/simple;
	bh=V/8zs0tE6GUyqcVezTh3xOtRONJaj657JNEedNDBs6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kw10Q6K5ZSLldSnzkd+Smg7gHBQKYsp5ASpUHLPiAMKpeFwwxI2hBNd++oWsU2NDF86El+WIJF4B6Bx/DkGrIZ6t//Ah3WNcF0cTiXUNCeuSfuMCkWJxeTQPZRpTyg3z0nv/i97pvnjoJKCS9ipdOym/qj64jNao1Bkw11zO2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz8cCpXq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513143d3c40so1546697e87.3;
        Wed, 28 Feb 2024 01:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709112044; x=1709716844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2noyD+gH5EeHWvIbCVfQ5txzmPqGPvNkLe5Kdw3vzI=;
        b=dz8cCpXqBuk3qOdcTOEjLdYXy4jasJu/4+7groKUTVe8z2RW6uzGaPA/diPhOHUksm
         83fh3sOunBIdPIC3Po9dd29UYr7tPGIrwK2DU5RcR/QzvW6fv9gRuF0l/I2XA+1VL5Sw
         zeWQQwwl/gI6jPT+vOkeU9mGpuUoBWYQx3S7P9yyN3givwKLiZtU2CimeorHFTN1Xmsk
         x/wm+oyBZG6+SpZ8Rb/Wrwjwr8CDY6Eme8xR0k3HAESrrLs6YbtP7PrwowZXuQwCpyvm
         BewS7eqiUZUlAwL7MhYH6GPHUxi0YPC/76JWqXgLAroQChZDTIgZF+IULKiZgTBl42AE
         5XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112044; x=1709716844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2noyD+gH5EeHWvIbCVfQ5txzmPqGPvNkLe5Kdw3vzI=;
        b=nh79PPYXJUy9VyisiaE0Nuh0ZniXnGAvpfCUGpC6ubSEtkKRX6BVrLWDcpkUY52Q9I
         fnE7uNsXCPwQUKdu5zL9VHQHsgiFzNUx5s8MarC5MLQ0u0LdUkIte3x39LNscWcvgSdm
         Ljk0Klv9BDi70YH/D/cTI0VAF8dmEitSihVMOp+NUs9dQCwVXNoKm3HxTwgLjt3CTrFW
         cigBpQzfaU9FLysRYExALo/PJtLzyO56mUYoLRrLq7RoRq9+GWMHfI9Clsa7M45Cvv38
         CbXJhepLbnfcrbiqzsxS3NQSC1g2GTJ8fkS8pJvexUuXPlE3GuDGZFrflhhbLip/3ScE
         Xbhg==
X-Forwarded-Encrypted: i=1; AJvYcCVMmkCdrrbeH5PgAkULxETRb8qEdjY04mvUYElJ3Abh7zSd0SdwrnA33rsujxAzO3+/PZolblzQyoO2BAtG8hnie0WcxES8ABxK/+1A
X-Gm-Message-State: AOJu0Yw8Q3IHizo5pKmi77+gIpo2eHGeyjtG3uZ3RnOfGH3qyHn+epmo
	pyOy77xnOO5GFxZ74BO3WFiRtiQ7M4LlRlJYkBVd8iuDZRCwvu7v
X-Google-Smtp-Source: AGHT+IHqmkUwiO2sfj7BD6bTWs5IUeTj5Q2VJyj4bs2CxxwV7i3xk4DbJ+e5SZU7I6iDYoTpbxt8yg==
X-Received: by 2002:a05:6512:991:b0:512:ee1f:b5af with SMTP id w17-20020a056512099100b00512ee1fb5afmr6493372lft.41.1709112043681;
        Wed, 28 Feb 2024 01:20:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b00412b2afb2c8sm1457617wmf.26.2024.02.28.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:20:43 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/dp: Fix spelling mistake "redect" -> "reject"
Date: Wed, 28 Feb 2024 09:20:42 +0000
Message-Id: <20240228092042.4125617-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_dbg_kms message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
index 75d76f91ecbd..6503abdc2b98 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
@@ -348,7 +348,7 @@ void intel_dp_tunnel_resume(struct intel_dp *intel_dp,
 
 out_err:
 	drm_dbg_kms(&i915->drm,
-		    "[DPTUN %s][CONNECTOR:%d:%s][ENCODER:%d:%s] Tunnel can't be resumed, will drop and redect it (err %pe)\n",
+		    "[DPTUN %s][CONNECTOR:%d:%s][ENCODER:%d:%s] Tunnel can't be resumed, will drop and reject it (err %pe)\n",
 		    drm_dp_tunnel_name(intel_dp->tunnel),
 		    connector->base.base.id, connector->base.name,
 		    encoder->base.base.id, encoder->base.name,
-- 
2.39.2


