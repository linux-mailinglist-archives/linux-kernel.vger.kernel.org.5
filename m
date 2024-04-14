Return-Path: <linux-kernel+bounces-144418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF9F8A462E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B0B20E62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE3137747;
	Sun, 14 Apr 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="g16LOD72"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03B2110E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713137980; cv=none; b=SMT8LIsyBcVSmRS77IVhMD+sp09woDl06cmhuTl2DdzT/HKtVAyj2c/LAP1c/OMiDzBj3epgmYhOO7ZYQGchpgFIiAuBqgvETo69x20Ys8IvQ+mEIyxoZVH4qXkPM7AWdAJrQJ/A32pa7/0IyryBfAA0pbHCunv7CmRsxeBGpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713137980; c=relaxed/simple;
	bh=d7387m7Fe6KCeNNP+mZc6Jx4w5n/uhmA6p42y8z8dx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5Z1vwMaXbwQV/kIl66CCTKa5+uHyRkoW9etVIq3fofqPHiKZBMJTuqq1k619AbfExgjXiYNy2C2784wkkABiVFqKoS14XTjM6iWfdxrm4DpwOQFQexzBmMpFQG+wGyT0SjOV5N0YDDH+AvgpdVv5Zs/cnJFRU3Rlo6q473etmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=g16LOD72; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso3947377a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713137977; x=1713742777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QT+4H6LMJlz+8DH7pQ8tCzWtRow/zNF+rdLqCVP9iDo=;
        b=g16LOD72+fEeYu42z4lbPchAVxbPtJjVCVOyhxuxIkMZp96F7ffthtgdOORurqyjbc
         dkqqTGrb5JXOhavS4WKgHlhG8F+99+shgBTGizENSxRZn/Wwe2kikqOLci7ksN5kILds
         jeDg58tDYkrX/Ad6Y/fvWFoSCvk1LNEQQxoTAqjfR7N13U/ReSFCVmVSC+VhWdN7Bq1d
         uexI5dDfxp0RS8xGYlIms1ErDQiTY1kBz1wJknOZRSEKcSJFh9DpHPdQAcHsFOWB5aqT
         kUH49WPAXJYfxtqeNthrMaM13jZm5Fx6ueYbIMBusyJVy5eY/f1pYvgkvI5nAcCJ3NZy
         Tb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713137977; x=1713742777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT+4H6LMJlz+8DH7pQ8tCzWtRow/zNF+rdLqCVP9iDo=;
        b=oAacKh3fjqkvbJWUzF3DUAWOoa4dP40w+mnZKALXZZi2VSWNLENXSeaXZOm8vu3IKw
         SItVb/qgBTloiqUq3dnPoRVXIB5a3xdBClO1ua3eZeabXCm9Tg4n07rmn/ivbtQzNxUT
         o4zogzbERjV5bFZjwgL9hYbwuXivRyyV4y9i7aTnKMqQa3VctjeM+JtpYpNXyFmfIRjx
         5/6l/5LDBxbu2wpZpWavVNwLxLlzy6ZJiyqbLl0Xg88WE614ekhMG0BmFiYsZZmjvWZr
         bdU3H1iRjb4MgPy1AGHSMVKXbwCGXsl2a4/cMwXoEWkZhlAa/xQFaCpQ8N6k2dkTXz5I
         ZvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7D2giDUqD7oggwsGO4HyJ2iczPC8+PWpQX/A4g4dRTaZTMjmnzkudnHxey+pi5VigtQhXQ1cF04r3YAbWYQ0T+5uKJG/C21TT0CyV
X-Gm-Message-State: AOJu0YxA7x0aLeaFCFPLNq43fHPcaLznpN6DO+XcfOwHTIRmsj+NzVq9
	FPqWnj1XQ9PDCTuXQKNHg5ewe/Y/q/xaVDTZPiKif6MuM/NGBkY0QlGs2NDu1W0=
X-Google-Smtp-Source: AGHT+IFb2HPMbxbzo+Z0wMa+oIFoQ5KEgnlxWzihlJ20RFpTeq9w5TDvQeaOwMubtpEelzwV72ysew==
X-Received: by 2002:a50:d7d6:0:b0:56e:e76:6478 with SMTP id m22-20020a50d7d6000000b0056e0e766478mr5380764edj.31.1713137976751;
        Sun, 14 Apr 2024 16:39:36 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402401800b0057009a23d4dsm2495701eda.95.2024.04.14.16.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 16:39:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/amdgpu: Add missing space to DRM_WARN() message
Date: Mon, 15 Apr 2024 01:38:39 +0200
Message-Id: <20240414233838.359190-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/,please/, please/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7753a2e64d41..3cba0e196ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1455,7 +1455,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
-		DRM_WARN("System can't access extended configuration space,please check!!\n");
+		DRM_WARN("System can't access extended configuration space, please check!!\n");
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-- 
2.39.2


