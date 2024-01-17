Return-Path: <linux-kernel+bounces-28491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134482FF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F7B1C23E73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467F8BE7;
	Wed, 17 Jan 2024 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm+kDHnl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B85247
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461144; cv=none; b=oU6pV7vNQHvYoZDJkk7SCY5WBIxEiQmWkIU+rNhENoLyeUw9i/oYG6OUjQAH2t7vAPLtDzmM5hFsGvXoIY1PVtwlz8RV8q2cjPJyLEeaMTBV7N8GWqM5A/VuOyh2OqGQ/x0ssqmlgxS8caeU/9Qbt6xJ6wqHxdXF5sIj3y95qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461144; c=relaxed/simple;
	bh=jQeqyLpTjYK+a2u6oMjAU4jsTR7Olg9YLIxfKKrTlwE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=ITdldcOD9+hIx1qNZ07PeEOrKrtRp98LNJZ6wSuopxEMp2mXPqTR9HHhMiMQZGY54RAhTgvIySRnLWDmGI50LrcPXSa0lp8lIptSsBudWWMDrb7qvin+gY6AUJdzrU1XBVfWhsAjFtgZy8mjx/G8T4wkIwkb0UFE3kMx1S3BjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm+kDHnl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso9863531a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461141; x=1706065941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgEOXnBwtjV0DRgAs0TONH+yAncBHjvW7O8dDZAmbmY=;
        b=Cm+kDHnlIxH4HbJ90FeB3C4x/FLi8cGabgUSBzFeUCGasqqRHsUoRUoyWFJEohk4Vx
         JdUm/mbvWWHR6LaatFzt4aYlmKD3hfLRbnmYMdQF2xPsQmCSZeyEClPVUqXtNAz4RqXe
         fIkAixOFhhzEXHgqCk1hUvIKenqMobrI3FGPPFwVe4e+mqp6B0UoI5tlmrn/jv9NjVuQ
         9cL9sJE4vkkMGdvj/uG2wMC6FvJvu7jpHi2yMuQgQMZOUcaRRyUzJlysJY2eJYC+vDtn
         ukYdckUcQzjrO6c7y56JgNgEGSJdjZYZ4lNTWudtn9NmZie+Kur+WeCTEha4N/WW+okG
         rIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461141; x=1706065941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgEOXnBwtjV0DRgAs0TONH+yAncBHjvW7O8dDZAmbmY=;
        b=KkGiefHdFswbfxgytART4NOdDPcFQSHIg03nhygD5xxj1qsHvXn6Y5ioIOiAYSpz9k
         KNzZm4nWHkHVKPZJqWPu5goVRcCIE8mDyRyrMUzLeq2tW72GBXLcg+pJ9U+QyQEi092p
         sy0/0Dwz+Kg1pN4ovsqytTOV6xh+3rY+aB15YI3wCRoFb/gaYpDdbYj8o1Bn3Bf3oLJ/
         LiTDteiiv/6cSwWTc/GxzwmdcF8A0WFCFnmrYtJ0mlM3UJsg1bCGmO8sdEsH3Lo++CWp
         Pa6+D6JBdahw6tO/d8xDx1E0ZDDb8kzWvTnjOcF0O+7pfLc0cCzTflORwZmJbQzXA14H
         +fuA==
X-Gm-Message-State: AOJu0YwK9JBXd2pkXwFKW0Z/Pq37QaG98KKi7iso32qz1vN2udc2+bnG
	LAd/k2yC1qC9Pgup9Xar+YA=
X-Google-Smtp-Source: AGHT+IFbr8FIXBAVFLQAm0BnJme9prl4lYGU0GNZbLVZDPfrnNKHuH2dSlYobzkRpW1IT5DgI99FTA==
X-Received: by 2002:aa7:d389:0:b0:558:9126:5673 with SMTP id x9-20020aa7d389000000b0055891265673mr4261820edq.39.1705461140983;
        Tue, 16 Jan 2024 19:12:20 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:20 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 2/6] drm/lima: reset async_reset on pp hard reset
Date: Wed, 17 Jan 2024 04:12:08 +0100
Message-ID: <20240117031212.1104034-3-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117031212.1104034-1-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lima pp jobs use an async reset to avoid having to wait for the soft
reset right after a job. The soft reset is done at the end of a job and
a reset_complete flag is expected to be set at the next job.
However, in case the user runs into a job timeout from any application,
a hard reset is issued to the hardware. This hard reset clears the
reset_complete flag, which causes an error message to show up before the
next job.
This is probably harmless for the execution but can be very confusing to
debug, as it blames a reset timeout on the next application to submit a
job.
Reset the async_reset flag when doing the hard reset so that we don't
get that message.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_pp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index a5c95bed08c0..a8f8f63b8295 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -191,6 +191,13 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
 	pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0);
 	pp_write(LIMA_PP_INT_CLEAR, LIMA_PP_IRQ_MASK_ALL);
 	pp_write(LIMA_PP_INT_MASK, LIMA_PP_IRQ_MASK_USED);
+
+	/*
+	 * if there was an async soft reset queued,
+	 * don't wait for it in the next job
+	 */
+	ip->data.async_reset = false;
+
 	return 0;
 }
 
-- 
2.43.0


