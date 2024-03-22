Return-Path: <linux-kernel+bounces-112049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2104887496
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6811EB225A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16581AD6;
	Fri, 22 Mar 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z96sVxPo"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF881753;
	Fri, 22 Mar 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144104; cv=none; b=V5VKGJ5PPYrgOIdOFNnB6XwIN7nrKla/M94mlfBZEilwTAevjvy1qo0hv01FcYOK9OjApXcFxkEdrVA9Akn1U+IzRHrp9aErhLDvTpclDcLWviuONcpdhIpvNwDZwJFrdk7FsR5Zy0kZqGLR4LN5frgutLvqnWQUdRVTXcx82ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144104; c=relaxed/simple;
	bh=AjTmeRsXLG1tSJTuVMmO6vOG8c0fhKFKbcOIXvGXNe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COGUU05oqGaxPtkK5Nf+Mdu1Hi/zTUrk/ZLT6DxfupKSL9ftboJhXHztXgUpvRnArWpjnS6jU0SRvbZTJulEhuaPkHE1kjrpNDjvJfpH6r7haXu1Ks0Me7eGBY6qFoBZmFE8/8FPI/iQNjQ3U8fyRZ2bTP29W37Ta77+FGWn3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z96sVxPo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so2031136b3a.0;
        Fri, 22 Mar 2024 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144102; x=1711748902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQK5tb3Nw1ZoxZ8aMrSXrErJ9rtnHZb1a9z7kXmUAAI=;
        b=Z96sVxPoDSLyVYOIYNlqWbjuOPepG4X2PzaPyLP3XdmkVvDzDAilLvPPdfbEfBqnee
         hmIce/oEOI6xsDz8bylLLrZEHZFssKYO0sx4kKrBZ5nbmKvagqjmoBjcxfbx9j+Oalc2
         DdLcVwl+6hr39GFSoyWHzMEjN6+0pHQpNXvK/2YK4PWK7Dxin/+ycugz+lR7/Ap0MKoy
         SZKS4s4UkAsTo5TfQHfvkbXojCSiqaf8Nzw0CxBj6qYuPl9OMrsuxWuQHf7lMwMiSLVI
         pgQjzLby6dW6eLCQWu6FHkccFKCKwwmmyiIKjNrUF1JhC1GcQ6fVPNpwX9wBsmFd1vEY
         Hj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144102; x=1711748902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQK5tb3Nw1ZoxZ8aMrSXrErJ9rtnHZb1a9z7kXmUAAI=;
        b=V4xVEstZJLNzJ6k1AB34Q99v8jzDpIojQAb7qjtshv4YLF2rUim6iekjv7Ar+DhXKZ
         kejv2XTni1hOY6DJZ1hvtW+ZIr56g7i969qQ7JFAtE5QmD7efgxc1ejlA0kj66nc0moQ
         6UvAAHB8YSPAdGahBFmAdd5yMILv6xe/5ys/zKfboeilD/DoR7kB45JOVv9ff20P+RhE
         oDJP4Hy7s4Blm5GGQ+UHOjNvSTJrSNg0t8N3lXlz8r1Ogf/c4p11dzSS3FIgMq0ETrPo
         mFtlFy5btbY1ClN9t98NSUQ53kRAlCDTJXmJYtWBpZhtOakMJ603SBvZWd2Qn2YBQmso
         hkQw==
X-Forwarded-Encrypted: i=1; AJvYcCUv5kuTXWs8muYg/NfhNxAQngD/Go140rdT+LwbjdRwSicBZKSupdbrWEfyrkBysN+dAEeK/a17cmRXGv+HEQ78tjbybH089a5Q1iUsm2S2AmmoJDlt502Uy6HTD84jcxgUoXPoA5ENPuo=
X-Gm-Message-State: AOJu0YxvV2FgQNoNxotGhVz+rLUwQbJdOU6ieFAIOrDabDKNG7zaX7Fi
	j9f9ESSufUQf+2Yf7xy3x3BExDxuQspVAxrEUPnY2RMd9M2H74780X24rzO/
X-Google-Smtp-Source: AGHT+IFu6vLzMaYsKuds4uUemNeUEL9Iv5gz6ZsPkXFYKeQTEq4g7nV6vk/JeeIFbxe7CJ53DpsPaA==
X-Received: by 2002:a17:903:944:b0:1e0:84b5:d76 with SMTP id ma4-20020a170903094400b001e084b50d76mr1175359plb.52.1711144101986;
        Fri, 22 Mar 2024 14:48:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b001dee4bd73e0sm226385plg.59.2024.03.22.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:48:21 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Dominik Behr <dbehr@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Simon Ser <contact@emersion.fr>,
	linux-kernel@vger.kernel.org (open list),
	linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
Date: Fri, 22 Mar 2024 14:48:01 -0700
Message-ID: <20240322214801.319975-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

virtgpu "vram" GEM objects do not implement obj->get_sg_table().  But
they also don't use drm_gem_map_dma_buf().  In fact they may not even
have guest visible pages.  But it is perfectly fine to export and share
with other virtual devices.

Reported-by: Dominik Behr <dbehr@chromium.org>
Fixes: 207395da5a97 ("drm/prime: reject DMA-BUF attach when get_sg_table is missing")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 7352bde299d5..64dd6276e828 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -582,7 +582,12 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
 {
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	if (!obj->funcs->get_sg_table)
+	/*
+	 * drm_gem_map_dma_buf() requires obj->get_sg_table(), but drivers
+	 * that implement their own ->map_dma_buf() do not.
+	 */
+	if ((dma_buf->ops->map_dma_buf == drm_gem_map_dma_buf) &&
+	    !obj->funcs->get_sg_table)
 		return -ENOSYS;
 
 	return drm_gem_pin(obj);
-- 
2.44.0


