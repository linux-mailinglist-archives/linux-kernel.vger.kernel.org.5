Return-Path: <linux-kernel+bounces-144876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67F8A4C11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6CF1C20A67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B144DA0B;
	Mon, 15 Apr 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/3bwBgM"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DB47F4B;
	Mon, 15 Apr 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175024; cv=none; b=bXA3jAwnhpshvj8Xrz0EomBCr1J1lseyI2GZbPJsP4hUO30h5NCgeBHu2h2dCsz2K/ENIqO0n6W8VsIMpT7IuYIY7JWAZYjqMkgNCVh/fAVZnXLA3pe8Qggb1JQTigghTa91lVTzD6A5W4l0GR7ZUJw9cG6ii/wMI3tbGT3YPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175024; c=relaxed/simple;
	bh=D0/46h4JT2NcCeh2yJo41/KSOz5i68/5Tg5zz5p0fiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ifADzpzNlOnc0EGKE1N6tlGxWoVTX1kpZ2OpE5fN6MoUT1zGKyU/qhMmMQ5gsS5OSOFi1y2FutZ6BA+0pBM8h/WgHqN4Imo+iIR9pipLjUggfX0z1SuqFAL3uI9xjS6C3iQyIXzeYPoR+4kPHJvKmpOoqSOG1As+No2w+UGjjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/3bwBgM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346c5b83c6eso2494653f8f.3;
        Mon, 15 Apr 2024 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175021; x=1713779821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/rKQn2i9AJe69a9IKOYTlsaBB0pLUNTFKMRgaL9iMo=;
        b=K/3bwBgMw0KtpuFz2G64yZKmTMsSQCpPSIWj4iMjBWfazdXe3Q77YyrTwP4LvC+Mvm
         O9YiX00MT7gdh4OeUszm3u1i/X2VsushNIqMqMOtIr9wvJehgvO+2iaM1+1LeExV7Dox
         mMNMy+LgQtA1g4YUzfONVgOVltEA6SkvtF6jeqms++FMyM4sz3szEDxdGjcrttR5wxWQ
         2wmT+pRmao0VShC5XQww4yD5jPVxVbInMCeZXEzkd707F/8QT15Q4yAo8mTBODGPYBDm
         yw1jHn9P1djTg69h53jZ0X7Qm2fKkklLMh8hgTuvaikppuDFBYjGm+/2g5wZUbE9NnjI
         enfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175021; x=1713779821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/rKQn2i9AJe69a9IKOYTlsaBB0pLUNTFKMRgaL9iMo=;
        b=nt42zTu772G2d0f6lqW4NNf0JcrrPC0x9CWY/CFIQpIAV1LwxG1x4N42KrfzIirkBw
         xHgfRIpETOqOqNljNiZ/KvKvIIlhy56bx+08YBdAUsbXDDgw2D9jg4//eJDpDiiPkiTs
         lCSpsx9NPBGm0cqeyDYQHVkvjv5nAhJEBYFDEKAcyx9mLz4WYKFVwrTUX76QzwONEWUx
         f5Cpoz0YKjB1AomqYfH+zb8DhR5E2vPPRcut8SRBJgfzBzo3Xan7L3X1XM4FOXX/FWbg
         CUys+ssOOD6eKwl6CH9k4c7CFPi8JlyeBjB6IMa6ywQoT0TFKGYQQQ0H40RraakwL3V9
         Qexg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q7K2t+O82lsuH85zHyRGT/z/N65kfEYdE5pPL01kQJzgj5NqM06+SDZwtem2yw0aw7wZqG4pgz66AA1gMtGOMc68gjLjCntmmK9k
X-Gm-Message-State: AOJu0Yx1XTDebuc/qG8uFMNSuOt3nXjlP1Cv0e07Nos2Us0U5kwML6+q
	R51f0lsAVGcSqgtMhieBrReU+cA9UG68RlT7LzFkHCQqgA8EIuR9
X-Google-Smtp-Source: AGHT+IHGhS/R4L+sxaYFupE82/pGE1N4pIuX9FJHqwGuvGP7rG+SdGbXleJEfkjqdXjuMaDnzPQgCw==
X-Received: by 2002:a05:6000:1743:b0:343:8994:313c with SMTP id m3-20020a056000174300b003438994313cmr5217871wrf.5.1713175021220;
        Mon, 15 Apr 2024 02:57:01 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b00341b451a31asm11537447wrv.36.2024.04.15.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 02:57:00 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915: remove redundant assignement to variable err
Date: Mon, 15 Apr 2024 10:56:59 +0100
Message-Id: <20240415095659.482989-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable err is being assigned a value 0 that is never read, the
break statement escapes a do-while loop and then the code returns
without referencing err. The assignment is redundant and can be
removed.

Cleans up clang scan build warning:
drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c:1075:5: warning: Value
stored to 'err' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 99a9ade73956..9ca9e9505244 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1071,10 +1071,8 @@ static int igt_fill_mappable(struct intel_memory_region *mr,
 			if (err != -ENXIO && err != -ENOMEM)
 				goto err_close;
 
-			if (size == mr->min_page_size) {
-				err = 0;
+			if (size == mr->min_page_size)
 				break;
-			}
 
 			size >>= 1;
 			continue;
-- 
2.39.2


