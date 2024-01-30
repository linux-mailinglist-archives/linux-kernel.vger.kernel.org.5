Return-Path: <linux-kernel+bounces-45404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529C842FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E1B1F21D76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2F78697;
	Tue, 30 Jan 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfXOa8eN"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9514F61;
	Tue, 30 Jan 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654140; cv=none; b=GJDzsd5F9Qu8ue20PMPVeFBY8mgCMpO1XUI7X+8HTKhQY4i6PtaHZ5tzp9o8MGK4DfcrINxk/GZIPqD/y4rlwWQ8FCKaRVs0Vm+Bs1Y7LE556vKDejy51B4gtmZrm3FXA8yibCmJDmcpqHnm2WwagmdP2faBOpgu8YoQ6rfOrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654140; c=relaxed/simple;
	bh=qd+uYXWXLg/AiJYexFHfgFf/wOf03uG1TaUcBZV0vsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An3XIBttL76l1m4T6cZP1aY6uXfZgVSSdwHw+t4mE6h2+/2A8DGxu4RHwejoun8Kb82AEZwdz558hCpCgSoP4Zwu8O3WOHpPTjVbAMvMTw6Dn4edbApcWeFCgzYQ5HBMdgdTt78yWk9HAn1RYXWQJoiG3sYvl3GO6au9AiFZdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfXOa8eN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d51ba18e1bso40518565ad.0;
        Tue, 30 Jan 2024 14:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706654138; x=1707258938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQdNB3amLD3wgWN5nJoJwd+J8vfuxzeUi86+HaqASZA=;
        b=TfXOa8eNb/fh3zJy4xFyARglaiYB9u2sdjtl+Js67Fm2Pt5x1z6zBNrq5JRfgTRrap
         LGkbk19d/cqJF3HjqdF0X1p45vwrRE+uyAQD/bPkFvFMo4aFEkoejZGsHaEnOW4bdV7N
         GqMH3YdNGWMN/ZxhW8pJaa3/DTDVzE6i5owTKRuaMjIweytW+3TjFDsMI0FI8q3inhk1
         dKccFMuuqvjxTNP1f51LdiC8SdW2yiegVRZTh0YWaCNwzvj5OFvaojwljhygcX4O90xR
         iLgOThl9qzSYi8qLlLCvoDWIIEeDqYEpAJFQevi3LDJREH8wxBg5AF4zFtrxC05QqJoT
         Gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706654138; x=1707258938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQdNB3amLD3wgWN5nJoJwd+J8vfuxzeUi86+HaqASZA=;
        b=LmdfQlFP965+8/Zb+4qzH1yFgYlnumbrIaymXvuoimI+yN4ftGv7kg3tdFHNT+jiR5
         O5NbILE65U6f85iRJwSn9NUUszniDdoltFpzituhmu5oah1oBMrETjlH1S2UVxTcSP8v
         pqi5+UNJ/8SElpQZfZTmMmwGll0BvvkuxJzp+tc/gKgmScjAZ+oa2EssWx0FWp4iqgPb
         T8g4ZktMbMwLeDPTXQpBCeyxh6ybKpfAM9B/sGCz0GePT94DdHKL7XJAbF9yY9Lvb2fL
         ph+NoUrEaduGu5dJ2+1Hu38NyTKgVZ5uTFQ/tqCiaSb4l+Pqahw2oDMUgGbipOSVD+pM
         FHPw==
X-Gm-Message-State: AOJu0YzAgGoRhfsTdCbExLQbWUMpcIuPU4sITpAOgsHlj0CO5mb0KQgQ
	rhpwplF11BpfCi2eBqXk0y49UiD3STWuR86CwueGdRL/demwgQKR
X-Google-Smtp-Source: AGHT+IFkj+E3wXJek3COMk2XISaWLhZObNoUmBCYA2ECXaBh+4x1L68p53d2Yn6DikZr614ZjhXc1w==
X-Received: by 2002:a17:902:780f:b0:1d8:d6b9:c0c0 with SMTP id p15-20020a170902780f00b001d8d6b9c0c0mr5944770pll.46.1706654137509;
        Tue, 30 Jan 2024 14:35:37 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902f28b00b001d8e4b85636sm4115407plc.138.2024.01.30.14.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:35:36 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Fix double resv lock aquire
Date: Tue, 30 Jan 2024 14:35:33 -0800
Message-ID: <20240130223533.25713-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Since commit 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping
functions"), the resv lock is already held in the prime vmap path, so
don't try to grab it again.

Fixes: 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping functions")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 5f68e31a3e4e..8a27b57a5bea 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -26,7 +26,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	void *vaddr;
 
-	vaddr = msm_gem_get_vaddr(obj);
+	vaddr = msm_gem_get_vaddr_locked(obj);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 	iosys_map_set_vaddr(map, vaddr);
-- 
2.43.0


