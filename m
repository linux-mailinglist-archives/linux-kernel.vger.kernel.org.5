Return-Path: <linux-kernel+bounces-28490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8B82FF29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A14289CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97336FB9;
	Wed, 17 Jan 2024 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMy9i6tU"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50B4685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461143; cv=none; b=A7N6P99xxbs3o7LyMLL1rF6ExC21mAzn9+6WNcNcUAOkqXdNoBOwDNm0OWp8pt1Jfwa9tFW/8tWC3mbVA0a0IlNWAHTMLg9Gftmw8OXsREXcAoAHlkcgbfIubfR8av7qZJDdiiR6uNHHMuBAUR5Nv54JHGnm62O64KVY07geg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461143; c=relaxed/simple;
	bh=0eihfCcmnCD/Dyd/H3GOL9PYZj+H93161DBErVHEJZs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=XFFlAJVBNoq1KnZ+hlWeU5Bv7w2VQo00BoN3nPyCD4dmiuRH0OGKDQlvpRDctYpfI/laUQLrdOu2rLR5OzJFu6BggSa9SHPc+kGiJnxK0KCXFfjxVzNDgiheGK+xRISwbRAv5forAyC1pmUCoihYq777fzH3K1EfPp1v4RVfxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMy9i6tU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559d0ef3fb5so329486a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461140; x=1706065940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=przBstviTKeMKG8hsGaQhziOmoZ/mS6n5cQDIFTsogA=;
        b=iMy9i6tUoanuFX1Mk4LuPISzJdXg9Kt53cIlc6ACEy+syeMUl6v1Pnt/zqlj0dgaMR
         Liw3AzPn4YjHBSQuePWG4QHNsqF9Vo8dbqBPPQ64q307R2h1iSpKA8qzjE/bZqxh9a4o
         G+1Fmhjuf8sEJeW6GAOI9fpzFd4bop95x8lCyLHKeZBibzgk/qrZ0jwJifxZ68JLdJwa
         v1cUP+LvuB2aABDQzUro4nCVZuIa/yqjjjVx+2rVHpAUKtVsY+iC/qTlYmZlZlEntPr4
         prvdqSUKwSP8qx/WJ01l+/iUGX1vVKrFgeuItq/dQUFQ4ZA3BW9S402IW++tdDb7bBAj
         AjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461140; x=1706065940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=przBstviTKeMKG8hsGaQhziOmoZ/mS6n5cQDIFTsogA=;
        b=bAAtxOVx2eFmLWGlJgtpMAChCITZ4jrcVpVe77WHRSpj3qr+88BspUQUqWuqtd+XYU
         L/jm47Njk01llBgTW1R5ZBfHdPoalzewlkmW6aKTdcjemaKKdViOEfSKAm4X/daI944W
         xNWf90a58kI/uOXcD7iCXX6WsrIshoyb+lVLEF7U24mwsR8mZ8gJwlSKgWcChybbT0NN
         EJklrx+bGNvmcHTaqmNdBaBy1jQopSOLGITv9zkKHCbUSLrhYb2KtE4KYbH+OZMj5wvG
         oN/NOR/3MI3cvSDxv7Pl9mh9utg0Y24fk5Ghfr5do9NmzRvQqynYi9wYxRSMLsfz1Jtf
         lIEw==
X-Gm-Message-State: AOJu0YwbVKqjDbG0/reC+bmFDb8mJFLFfVc9sWtC1fQ9FzjoIddhKAhY
	X9LJWXTm2NDdZZGf06icJiM=
X-Google-Smtp-Source: AGHT+IH4g37ccsIH+5nDtEbHrV7ecTiL8sxw2zhnvaeOkN2UzCLivl5+Qf3In+6yBdstgOn6oOKFFQ==
X-Received: by 2002:a50:9fc8:0:b0:559:ba97:7219 with SMTP id c66-20020a509fc8000000b00559ba977219mr1010135edf.48.1705461139900;
        Tue, 16 Jan 2024 19:12:19 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:19 -0800 (PST)
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
Subject: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
Date: Wed, 17 Jan 2024 04:12:07 +0100
Message-ID: <20240117031212.1104034-2-nunes.erico@gmail.com>
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

In case a task manages to complete but it took just long enough to also
trigger the timeout handler, the current code results in a refcount
imbalance on lima_pm_idle.

While this can be a rare occurrence, when it happens it may fill user
logs with stack traces such as:

[10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfreq.c:205 lima_devfreq_record_idle+0xa0/0xb0
..
[10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
..
[10136.669628] Call trace:
[10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
[10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
[10136.669656]  lima_gp_irq_handler+0xa8/0x120
[10136.669666]  __handle_irq_event_percpu+0x48/0x160
[10136.669679]  handle_irq_event+0x4c/0xc0

The imbalance happens because lima_sched_pipe_task_done() already calls
lima_pm_idle for this case if there was no error.
Check the error flag in the timeout handler to ensure we can never run
into this case.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index c3bf8cda8498..66317296d831 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -427,7 +427,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	pipe->current_vm = NULL;
 	pipe->current_task = NULL;
 
-	lima_pm_idle(ldev);
+	if (pipe->error)
+		lima_pm_idle(ldev);
 
 	drm_sched_resubmit_jobs(&pipe->base);
 	drm_sched_start(&pipe->base, true);
-- 
2.43.0


