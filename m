Return-Path: <linux-kernel+bounces-62445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BFB8520CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC81128633E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DD4CE18;
	Mon, 12 Feb 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcMYFtOP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D047A53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774947; cv=none; b=KsRYRnVH5DDoGZGjJRb0xe2QqvCZ7L5OGEyEnUY1W9yZVdH6wToqwX7PvGH4/gB78EO/11nCPQF9bTt4gWcmAfNdxqJBVaC28ruQQPRw4a/Y5S7c3TipVgcW9Ip7OX8eU2lBWMhaAH3I0budjBaoYEgxDcOrml7G8I7drhZk0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774947; c=relaxed/simple;
	bh=fy3oFa1Du9WZTcVDD2rPZ9UaztTMprEbVYIX644zR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXYOFgPVdM3jfPvSUmDuP47BM9fHkNx0ZlGlzGCpwcqZAdR5PanbFJWygLBuk9WDfpqmHhlBP9NIPZwtWegQsGr9wu+40r7jvQP+GZ+c7ldjLA8otcurAVyQ9Dka+AHf8wKh/jpCDpHTkl3gA5saRf1da8fDzxnaFAP8goVV8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcMYFtOP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso1543972b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707774945; x=1708379745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsqc1DvmmxB3axNP5BMsYZJAEgwUf5CF4YmTNlqSGbA=;
        b=RcMYFtOPygWnoLcjFk1LEXzwHYYtCgX/Dkzd3FS4zgLHB9LK7pl/MC8pJ75eqzWVZF
         R8PS5eLqbDEC1MKY0PmnY8AtxopQHwDUVQ4m9VLPHkqEAZEsuqz0B+0ixg8lU3ImRP0F
         dcKMgeKAtvAHV707kOeEwezAXJr2k3M9bAI4EVyJca3KhXnSjTlpO5Kf0GXE6u/JnV9x
         2EHugnwMSAGuQXi6eTBqZCZW/toqYrlllosFb8HreBbFMfGYemqdcNWa3wpa2Ha/d/am
         Ge8fuu+8KXun0lsUIIZkcqGju6PXY8D2Im6pcGXhHY/Zodw5mS6jz8GAIXA800p24HKR
         lLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774945; x=1708379745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsqc1DvmmxB3axNP5BMsYZJAEgwUf5CF4YmTNlqSGbA=;
        b=mc/rJmQDSQNAHR0BSOB6Xh6akMRpBthCc7RlPp8bqds3YXa/iMvQqATEjtsa3AssJc
         Rzy87d8mGiQ4u2K0JIzKykXqiBvYOEL13ge9FUeIq4Zbw5g4xZGF7uhvK6nrv1G29BP2
         QeG+WVTfJafX8qz/ksLGdwvcRmGoQ8AQxXDrA05bOI6YvlpyNecQ+bW07stBMXfx+Pyk
         flmsOVDslUliEqvBOSyjnrYR6w5JsdEcPEzskiQM7QD1ox8aJ1ee17KnglXkJOAOgDvW
         5zXqzDgdzhKEdacwIPv0Oj1CMF1SOcAVC6w+75xoVi1i1CBO4aWC2TxYKF78hoGHdUWN
         L3uw==
X-Forwarded-Encrypted: i=1; AJvYcCWNuvnBRQp8cytwsftRtK4EhBrao5mmAOj8g0A8QZuMVy+CSyICGKktJSJJKmgw/70WgqDmxwEMuFxvLF6o0v1LS8czM3HVIKfJNxdE
X-Gm-Message-State: AOJu0Yw8BK1kfJccjPuM1Le5Kwtcw0d6K+v4HaWz34T2kpDpjHG0vPAd
	7R4c28CWTF683Myy+1V2HNcBG6hCrKg/dE0u7BEfeLqponp5p6aw
X-Google-Smtp-Source: AGHT+IHj0WR5Hcj8YnPlvwL3CWPRbYDSlTvLoG6xlnQ2L0rpNKUIXQY5hf+J5qTYTqzkRqu0OnLLOw==
X-Received: by 2002:a62:8104:0:b0:6e0:ce45:d781 with SMTP id t4-20020a628104000000b006e0ce45d781mr4163831pfd.16.1707774945160;
        Mon, 12 Feb 2024 13:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViaMU7RDTULr51gacAoII6GxPSl9070X2jrfpZ4ePcCBd1Goqto+8N6lV2b4AqT324A0uKvwTqU1GRhYPx9NcDC3TlDc/qbwLTe/47kMpxnnyIxnzJnsrkBi4MjXuiKBbTGgfRn6AbD0xett601m4qicEJgBFx4TCt+u8nTWsP2SCKorkkIsu/EqMwJT0CdYQ5innk83OfUJgBcTbRYEZv1JopsOkqCp7y2nmJwNbeloE8TSOF8hSYNKjkyihP7BWjpKnIpkoFUeBhzwhD8bCCUGBN
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b006e03ab56acbsm5977451pfh.217.2024.02.12.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:55:43 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/crtc: fix uninitialized variable use even harder
Date: Mon, 12 Feb 2024 13:55:34 -0800
Message-ID: <20240212215534.190682-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
which means we can't rely too much on variable initializers.

Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
conceals a nasty sharp edge.  Maybe it is better to have the complicated
restart path a bit more explicit, like it was originally.

 drivers/gpu/drm/drm_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index cb90e70d85e8..65f9f66933bb 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -904,6 +904,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	connector_set = NULL;
 	fb = NULL;
 	mode = NULL;
+	num_connectors = 0;
 
 	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
 
-- 
2.43.0


