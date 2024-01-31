Return-Path: <linux-kernel+bounces-46686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB148442A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B512288B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8384A3B;
	Wed, 31 Jan 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngJv6VVz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2516A32B;
	Wed, 31 Jan 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713741; cv=none; b=Gwh7vfzVadhBUrqKV/1ArGxPlRGAhyfErdH8ijJ5gPFAfy9Wk6LhE/86DsyNYUaLlEVhJb7CpDwRXRZuQzz4DSsTtPmUNFU5SxAqaJ52zXlmuzVcQhAzBAxH5MwU/i3tun5UVXjLFiYGEovy1AUCz36eZfxrEdl3vUa1GC9exmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713741; c=relaxed/simple;
	bh=AOc6YF45IoWVyINXR7aSi6N1btEmXtOchYzJHqnob9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lpw1oT5CusAIntKrwqVc1EESYPUPlXmU+7pRB1k0i85lNIuQMPx5RC2INiArEkNwoZV7V6bRBq0LQ3rzS19h8Nz1mL48ehFpYVNIsRMSxQhdgv1BBuPWyULvIGGUBFf8p9t9ApG4ZCaidujSYDg9AoPwkgvBqSt2fY1hvtBH46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngJv6VVz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94323d547so901285ad.3;
        Wed, 31 Jan 2024 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713739; x=1707318539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjgLEA96psNlw7oy7+wMc8J4ysFO6yGdu22kdKlQ/Bk=;
        b=ngJv6VVzG6nqNcPdLyDLm3rUzo3KV42c8j/Hj/yJ+DpysCQVvzKr/howuhvjxuKfP6
         s/3kYHd5r/Vsd+urFzxp0zLCJ3h2FRHrXnMyCi5FBTqJK4GlGlV9RFiOOh74fLU92S47
         BZ63y0bWD7MQULlQoTs2YJuTy2FbHyQumw3WTfqJzRZqBgqbEeBDHcOw+b3Zpg85A8ZS
         pX3kOrwYpjDZVCexp2Ajb2Y7lld56zc/E8315AMP5ky5bFtwO7WuCqf2Qz6TdlHxHem3
         pBNrRdTP3sNPtHykjWNSJfa4FSzhik9wzvGKW+Ar9JYWlo2EWVvtoDwtX4gC4pG17eUM
         seuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713739; x=1707318539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjgLEA96psNlw7oy7+wMc8J4ysFO6yGdu22kdKlQ/Bk=;
        b=qkEPIG/zlH/S5Vpa4XpBCLGE+UsFRtYlFaclVysbw9s0IBo0QWl7E0JRIA0M8DhNvI
         jrnhOjapLAsgnWhDv3BZ4Suz37m9fsmyLXummRr4QuCJ2FeS9riv59EmSXEU2aU0pbzE
         0F1vf7BM+ivWCi9a+n87DYi/IVdyuJUbq1Udb96RC306zYaJ8vGgjwo1F1GGQGdPNF3M
         wALKZ7yAL3/3EKTJBOYyh3zefm5pwQiCYDTs2NZm2mf4qlnqAfXbkvXG6OkU/XBOIKeC
         SR/Up4S8h6qmCRV3TnsR4nTrJrgMygLsesOpffQhQ38aPlaN539gg11+hxPGuZEswMI0
         dJpA==
X-Gm-Message-State: AOJu0YyZ0eamMLv9N1sxBJ1WVId40aKXXCoANxKA51vdrW1sRQBcDVL+
	CwbPHlAGVbOj+gk+GPCeE4VcIUv10uhN8Mb5oUtMUTi/FVkzsoHP
X-Google-Smtp-Source: AGHT+IELMQ63ocPD4wuPi+ke5HI8IlfGoYnxgj8y/siWaSNWv5CSXMKr5f4mKr26X7FiQk0GEJsZnw==
X-Received: by 2002:a17:902:e5c3:b0:1d5:dac4:5015 with SMTP id u3-20020a170902e5c300b001d5dac45015mr2240225plf.11.1706713739469;
        Wed, 31 Jan 2024 07:08:59 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902d10b00b001d8d1bf5b98sm6385188plw.54.2024.01.31.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:08:58 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/msm/gem: Fix double resv lock aquire
Date: Wed, 31 Jan 2024 07:08:54 -0800
Message-ID: <20240131150854.44089-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Since commit 79e2cf2e7a19 ("drm/gem: Take reservation lock for vmap/vunmap
operations"), the resv lock is already held in the prime vmap path, so
don't try to grab it again.

v2: This applies to vunmap path as well
v3: Fix fixes commit

Fixes: 79e2cf2e7a19 ("drm/gem: Take reservation lock for vmap/vunmap operations")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 5f68e31a3e4e..0915f3b68752 100644
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
@@ -36,7 +36,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 
 void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
-	msm_gem_put_vaddr(obj);
+	msm_gem_put_vaddr_locked(obj);
 }
 
 struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
-- 
2.43.0


