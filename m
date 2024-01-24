Return-Path: <linux-kernel+bounces-36543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C883A2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D5F1C22D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12020168D0;
	Wed, 24 Jan 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blqix7i8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBD16428;
	Wed, 24 Jan 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081093; cv=none; b=d/hTdGQ86YtLx/tYzNUCWFN44bKCkY+DDdQ1OQ2/ZtkCh//TNXyZ7c8QvO4IlCYhC51zQH0jV1PR7FSg/1w3fReujipp0vMqiGcngOMRBc9q31/ZT2RC91Ie2RDlN6z4mN1VQqy98Se9vUmRcP7HLUdof314ffrq0RcWRdX0dRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081093; c=relaxed/simple;
	bh=gGTI6E/3Uq1rswyx/VCnY4ITQEVHmH86csU6Jxmh17k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKKbAkYOwZdsNxVbuVsHKJhX87BWMkZ5hT/PmDhTv2Vm0GtdCpJRBpx7X4Ep1jJadZYZdOg8UX+torpXxGsqX5Kb9SXbvj7Aqq/KguV03ICcIGOOCecLv8XIUWMCQl9fW9ph2COa4tYYdKTgSsGu/mRgHTz2grlxrWsfqiR3XhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blqix7i8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100c4aa08cso1318958e87.2;
        Tue, 23 Jan 2024 23:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706081090; x=1706685890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9uZC1dIj5M+eMoRLHxiej0eM3JdeDGVY5f4KmbEUp0=;
        b=Blqix7i8Lw+KJ9kXUYIWuNbdrDLcWrmRHgiaGKUPPbTL78i4Tiz7AGoQlVANPHvqgP
         oiyWF4W4hhgYZVqz5Af660d4qyMZW59sbZBn6//OIKwnv2tYvgS2Ag6Bnh++KK07hxVe
         lcljN+R2ncTuZdHBQRMhhZBZmgxvqgF+opKH2+suRquYojUsI+IlyYVB2t8Pb3OwsKcr
         h3ClAsGMlHtUCAa+iQnFDB/69nc0XBaF8422WoM+Pt6hHNExFsUrDOqfC6Z7q5NvvaZS
         em5xy/CP07RH0IH45us0VKRSqSS7lVU5hz4gEcyevEo9bSLxI/MyHoBE7LLVMVNE1vvh
         gTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081090; x=1706685890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9uZC1dIj5M+eMoRLHxiej0eM3JdeDGVY5f4KmbEUp0=;
        b=aWi8Zzn/Dvvby2+qV4glb6e9POLsNpPSFb7EQtbd7efOvcv+ejZ5Ohl/flAcRaiTCX
         j4/nyBzF7sf6byCwFdIpJ3DZGCAZKshHu4N3yJwHD0DU+CLYk2wAE2dOBv6Gq7VJLGhC
         B6qZXM2+zvWvRvV8e+nNWwCID4PUj2x3BcH+hXOzV+s1sA9O9yg/4k8zWRe6OALebxU/
         XK4mw//iKNFdNrKfPHJ+G8SyZ3gPgO9+qQcdO+lxnl5O6HdEmvwBLr770eZG7utDZJNa
         DvCAhf3bvM/mjHuk3jgmnvolcmUEM8NNvVXi6Imu7lssDecMzsQ6BosOd6jPI3LiUI68
         vzxQ==
X-Gm-Message-State: AOJu0YxJfjuRGmvU8RqvHjjfUYrXkdk0xbiC0L9va76DbL6Ha/7vbDta
	aNQ5o/CnmgOhiqNB1aBJmVUKn7oMqWddX/jvx4DS8bOgsk5VfA8X
X-Google-Smtp-Source: AGHT+IGx+rZ1X/HhmTr23mLmA/XF03fr1OOXTm66vuGecPuhfinlKC7ireQ5C9o9eihHds0NqOoIrQ==
X-Received: by 2002:a05:6512:3f13:b0:50e:7be3:d326 with SMTP id y19-20020a0565123f1300b0050e7be3d326mr3702820lfa.85.1706081089673;
        Tue, 23 Jan 2024 23:24:49 -0800 (PST)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id c18-20020a056512105200b0050e64a0c62dsm2481708lfb.240.2024.01.23.23.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:24:49 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maksim Kiselev <bigunclemax@gmail.com>
Subject: [PATCH v1 1/1] aoe: avoid potential deadlock at set_capacity
Date: Wed, 24 Jan 2024 10:24:36 +0300
Message-Id: <20240124072436.3745720-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124072436.3745720-1-bigunclemax@gmail.com>
References: <20240124072436.3745720-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move set_capacity() outside of the section procected by (&d->lock).
To avoid possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
[1] lock(&bdev->bd_size_lock);
                                local_irq_disable();
                            [2] lock(&d->lock);
                            [3] lock(&bdev->bd_size_lock);
   <Interrupt>
[4]  lock(&d->lock);

  *** DEADLOCK ***

Where [1](&bdev->bd_size_lock) hold by zram_add()->set_capacity().
[2]lock(&d->lock) hold by aoeblk_gdalloc(). And aoeblk_gdalloc()
is trying to acquire [3](&bdev->bd_size_lock) at set_capacity() call.
In this situation an attempt to acquire [4]lock(&d->lock) from
aoecmd_cfg_rsp() will lead to deadlock.

So the simplest solution is breaking lock dependency
[2](&d->lock) -> [3](&bdev->bd_size_lock) by moving set_capacity()
outside.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/block/aoe/aoeblk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index d2dbf8aaccb5..b1b47d88f5db 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -333,6 +333,7 @@ aoeblk_gdalloc(void *vp)
 	struct gendisk *gd;
 	mempool_t *mp;
 	struct blk_mq_tag_set *set;
+	sector_t ssize;
 	ulong flags;
 	int late = 0;
 	int err;
@@ -396,7 +397,7 @@ aoeblk_gdalloc(void *vp)
 	gd->minors = AOE_PARTITIONS;
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
-	set_capacity(gd, d->ssize);
+	ssize = d->ssize;
 	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%d",
 		d->aoemajor, d->aoeminor);
 
@@ -405,6 +406,8 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
+	set_capacity(gd, ssize);
+
 	err = device_add_disk(NULL, gd, aoe_attr_groups);
 	if (err)
 		goto out_disk_cleanup;
-- 
2.40.1


