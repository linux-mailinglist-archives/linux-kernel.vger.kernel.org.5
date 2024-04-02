Return-Path: <linux-kernel+bounces-127678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80406894F59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20399B2466E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884625916B;
	Tue,  2 Apr 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lW/riFUL"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E61E4A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051896; cv=none; b=FtDQUYqDaOOCNeMV4JGBzRPG1dBEpVNmTKfjonk80MJv9vE7QO2vs0ApwgYnq8kjiD+QMbpRdrhlG4P1ciM60xzmoZ4bPubrjM59VoX2JCyyuCsJM5fqfS2xDNXFGLlLyGUOJ6fxwS88/7N2vNI+pcOOosvcv0EWTDNVg6bBNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051896; c=relaxed/simple;
	bh=i3dAA3EBuiwwRsOxrV8BH5VJ943ZUlY2pGSFcOqvWsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dmVzBtLVsWy9K1x8Pl3wedcZ48x+qgKU7Eg3xHMf6JMoR4YTOGZiK53uecvbD0B4w8aixi7r6UFUF01c67oszhbzcd6LIzkfojvTZi7ZR5HDoLQ9Fj1I3qLoULJg5IBRzDbfQItTwHpPs3JD20dzRdb5NntFKfijHw5cDPcTNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lW/riFUL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso5523580a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712051893; x=1712656693; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld5/UZMRVCPDO/dKTQcgFxFhH+C0bdjqoU583UYXs7Q=;
        b=lW/riFULRJeVOWDl3FOtQ1mA7mgZZs3VeDZJhMPuHixSaBW/YqAfASuUZr+yY3T477
         HuMkEpCUiKm1ONF2P4qWldjcuXHa+9et8ktaAQo6kfLRZ30L5cYzt7+ePek6EwbX18xR
         bwqJIQmOq26Hs5M/b/jDwdfxnNaoeEcoZdcx0S8zc7dnyPiSNoFDfUvCCDq4vpGQk6bG
         uL9xxE3ya/aTKjo/Ub49RpxPQhTPU+Sg/Eci1RI6vPihBC5hYGL5E9ZcEqwb4E30Sgv5
         bIV2UMScktdCSkLT44zMkIdn6pvi7XfwbfV7wPEV+fyYnRIKqWHri+FZwI39HXu1RAOj
         clLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051893; x=1712656693;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld5/UZMRVCPDO/dKTQcgFxFhH+C0bdjqoU583UYXs7Q=;
        b=PL7Q+7QRzffBkNqvpUFMOz3+zZVV9ZyhSc3Tv1APi7F8XxJNxUtlfxXD3jMLxGgUir
         OjWwaovDZw9IJe2r3tHzPjFx0VrqjTEFT06ffq5abp6h8pD7R9HLFQs8Xt9kW7/OgAct
         pe+dX78EY4U62THb1AvhYXWrBUNaMbL10l1PW+aw/4Ml8sFf4wy+gP/V9BPHB7JixAzB
         lwlNPWO04Oqvl75UXsV/xDcKEWvMqd+k9O7xX9TuPH5qTqvtKInOzT4chFYpCwXTpUNX
         69rCYpkx8gwif79Y/qVXIYA5DmGbxO+4DY8WmqFYTmXzkjmTExhOSKWELIrcmi1gUjfD
         FXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3x+saW/UHLvWWP5EbQQeH6ak0JUxOVkc5ylAgq7yLn1cc3Ark52nxXAtSxR0J/CH0Vv704Nkr9mg/YPRNr+E986WlerwD6HiLitiB
X-Gm-Message-State: AOJu0YzbhHavtSESAvorDgXIJ5b8uc7eAdbcqF+qy+Fmo5pbyH6h/XUx
	gd1xvDyLQ5254KOy1nXmhLiSOFOVmBbp+2377ES8ZYs3rnR+Kd+h0iOuQGZ4XDE=
X-Google-Smtp-Source: AGHT+IFgDns4XbXtOdDo3mYfgf9w3lFqwUVjIK8JRoHpGzz1mCaGhgoZUM8ANRaz4ThKySFmuVQUqQ==
X-Received: by 2002:a50:d4cc:0:b0:56b:9925:38a with SMTP id e12-20020a50d4cc000000b0056b9925038amr7967208edj.38.1712051893318;
        Tue, 02 Apr 2024 02:58:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d556000000b0056c63ba1387sm5295464edr.86.2024.04.02.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:58:13 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:58:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix a couple -ENOMEM error codes
Message-ID: <cf5bbba5-427e-4940-b91e-925f9fa71f8d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These error paths forgot to set the error code to -ENOMEM.

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fdd35249169f..a26b40aab261 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1264,8 +1264,10 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->rsvd_page_tables.pages = kcalloc(pt_count,
 						 sizeof(*op_ctx->rsvd_page_tables.pages),
 						 GFP_KERNEL);
-	if (!op_ctx->rsvd_page_tables.pages)
+	if (!op_ctx->rsvd_page_tables.pages) {
+		ret = -ENOMEM;
 		goto err_cleanup;
+	}
 
 	ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
 				    op_ctx->rsvd_page_tables.pages);
@@ -1318,8 +1320,10 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		op_ctx->rsvd_page_tables.pages = kcalloc(pt_count,
 							 sizeof(*op_ctx->rsvd_page_tables.pages),
 							 GFP_KERNEL);
-		if (!op_ctx->rsvd_page_tables.pages)
+		if (!op_ctx->rsvd_page_tables.pages) {
+			ret = -ENOMEM;
 			goto err_cleanup;
+		}
 
 		ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
 					    op_ctx->rsvd_page_tables.pages);
-- 
2.43.0


