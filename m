Return-Path: <linux-kernel+bounces-10501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19481D526
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BE1F220ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021891119C;
	Sat, 23 Dec 2023 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU9iFXsu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFA10961;
	Sat, 23 Dec 2023 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbd00f084eso785611a34.0;
        Sat, 23 Dec 2023 08:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703349860; x=1703954660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8RrFYaQY1C1Ro1apdYiZkYhpyoj4xSq5iwP4LNvPrA=;
        b=VU9iFXsuWB257NQGGVFHgS62WOetbLBXZX3TUgDE3//B9EmVI2h2ZShRHKtUhq6oq9
         +vAOaVHGQKktn3snMPPEIwUNUELONOuP57YrcpQcgI4kMtegMBqz5xSOwZbz2zu5w7/y
         wJZxhlzL31IktnkEi2y0iclZhesuFHRjR3WOO4Gx+NzSxAXyBjdek76NHH4YKnW5/HYa
         2eC6QgZh8KlPOuzvq2q+pOqfoswrywD6NDJrYmbusbEXPbX9tvTQA4FN6Q3SwdhFmQMA
         46CFMvVn7MRvIbE3n/jpxtKIKI5vUZL+Ys13sOLtQ8o5P1+iNy6p5FEZ9Pmv7VM00wIW
         r1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703349860; x=1703954660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8RrFYaQY1C1Ro1apdYiZkYhpyoj4xSq5iwP4LNvPrA=;
        b=oIp/s/Qp7rBbXcgIT0Wpq4rD/PnK0OEkEl2ogL/XIRjXoZ5eQ+blvsIzTIOXzhwkGr
         1UX7umJJjCP3BMgLfaEB0lRtwpx65Onq5H0L/zhiGA/83ydLZmoLmXKGFnzj5sL30S+1
         B3At+UsxSC9v1zQ3L6nBHPbZN/tHkAiSFWDqdHjbakWaG31Qdz6yUcSHTFt6WYjBiMTB
         /2Dz7M3WzVh8478lES5F9erEFiIp9KR47p0zzJue1jqA9GTD6SDJ539/LL90v29yH7Z3
         ixSN90o3NM3yLK7H4zQQO4fxeTGho68SockIaHYLXjtx+M7+R16RDazjF0xKyUuzl5jX
         xUJg==
X-Gm-Message-State: AOJu0YyRKrCol8ztOufIsht28+7oZx/6gw7qvz2imceE19Bt5rUYQ3Q2
	NBNWIBpEaKwDE3WbYzV6Z4w=
X-Google-Smtp-Source: AGHT+IFDvbGyOc3tMXRLa19QJHjPpfxfXv+Ma5HusaiiXVa6Dh1lSTSfLVRGla//+nCd7O5t5dyMhg==
X-Received: by 2002:a05:6358:880b:b0:174:b7f2:51db with SMTP id hv11-20020a056358880b00b00174b7f251dbmr3599193rwb.19.1703349859773;
        Sat, 23 Dec 2023 08:44:19 -0800 (PST)
Received: from oslab-pc.. ([2402:f000:4:1006:809:ffff:ffff:ec29])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a598c00b0028b8499dc80sm5475858pji.39.2023.12.23.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 08:44:19 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: s.nawrocki@samsung.com,
	mchehab@kernel.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com
Cc: linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Tuo Li <islituo@gmail.com>,
	stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] media:fimc-capture: Fix a possible data inconsistency due to a data race in fimc_subdev_set_fmt()
Date: Sun, 24 Dec 2023 00:43:51 +0800
Message-Id: <20231223164351.3521588-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accesses to ctx->s_frame.width and ctx->s_frame.height should be protected
by the lock fimc->lock to guarantee that width and height are consistent.
Here is an example in fimc_subdev_get_fmt():

  struct fimc_frame *ff = &ctx->s_frame; // Alias
  mutex_lock(&fimc->lock);
  mf->width = ff->width;
  mf->height = ff->height;

However, ctx->s_frame.width and ctx->s_frame.height are accessed without 
holding the lock fimc->lock in fimc_subdev_set_fmt():

  mf->width = ctx->s_frame.width;
  mf->height = ctx->s_frame.height;

And thus a harmful data race can occur, which can make ctx->s_frame.width
inconsistent with ctx->s_frame.height, if ctx->s_frame.height is updated 
right after ctx->s_frame.width is accessed by another thread.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 6.2.

To fix this possible data race, the lock operation mutex_lock(&fimc->lock)
is moved to the front of the accesses to these two variables. With this 
patch applied, our tool no longer reports the bug, with the kernel 
configuration allyesconfig for x86_64. Due to the lack of associated 
hardware, we cannot test the patch in runtime testing, and just verify it 
according to the code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 88fa8311ee36 ("[media] s5p-fimc: Add support for ISP Writeback ...")
Signed-off-by: Tuo Li <islituo@gmail.com>
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index a0d43bf892e6..5c8b67f92c65 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -1546,6 +1546,7 @@ static int fimc_subdev_set_fmt(struct v4l2_subdev *sd,
 	fimc_alpha_ctrl_update(ctx);
 
 	fimc_capture_mark_jpeg_xfer(ctx, ffmt->color);
+	mutex_lock(&fimc->lock);
 	if (fmt->pad == FIMC_SD_PAD_SOURCE) {
 		ff = &ctx->d_frame;
 		/* Sink pads crop rectangle size */
@@ -1555,7 +1556,6 @@ static int fimc_subdev_set_fmt(struct v4l2_subdev *sd,
 		ff = &ctx->s_frame;
 	}
 
-	mutex_lock(&fimc->lock);
 	set_frame_bounds(ff, mf->width, mf->height);
 
 	if (fmt->pad == FIMC_SD_PAD_SINK_FIFO)
-- 
2.34.1


