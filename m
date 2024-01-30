Return-Path: <linux-kernel+bounces-44650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D784257D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6DE1C23A57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630106A350;
	Tue, 30 Jan 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLfW5RQM"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C16A03D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619086; cv=none; b=OsKHPkb6qc8jKcUUXV8nCK/+mQ3OQ73ix+wRs5hFn+r7/J9aEYl2UxleScRnH6x6A5x9T6tZaJ9o8H/FDLSW0h/5R4I5bxHrVwtDruBYguR+UEPMYXY6vyXBz/3M3n/22rPga3gPMAgFiWz0g0hw1CTDTpYrU6e66Rt/iUxoMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619086; c=relaxed/simple;
	bh=rTnKuH15SuMnXR29rgvNOa2casFDsER5RRZy8dJX2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUOHvf9NEerAdQtk6medC/V1SDHMhNzA/8Zq4uSE4WDd+CdFkI7d+6Z3onuRxvNM6cBq7u0Ir8ZJclvH4VKa/WATYbEBPZ/V02FCSrwLOOOb/1LM/D8l7CvmdumbsAMj9jQrvwPFLpFFhPpsUAeNo2hyfUenuQbnzJYDqelCCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLfW5RQM; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3be6df6bc9bso961449b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706619084; x=1707223884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgKJFJ/3GGLxSM/jtfTq8LlETbTPciEFuAYV4rAipow=;
        b=RLfW5RQMbbdYyFDPpX3+odJWf2WjZnsb9KkyskT0YxoTYLOJDTVa3kliA4913mZ9ZE
         Rc86TRtumJ8WTWKciWFlL3bFTy15RLFXS9BbSZKQbt0FgwQWEzAheczrSBQgTEmFKg3/
         kmGrWt4M00mx9CDtQP24Ke5pWMr2T/7VRBMW3K2G6gLEV22MqbPeqvbsdctDoUv+K1Ch
         7udGOccEM5bZRNVjjnYRhtko0/WqvoU76i0ZsJYFUcfP/yI9v1GWD3FjNlRGeDOSKq0W
         6R/JiwYphYhdeeo51c9WZMHi9H3FrKd4Svr2qB5kCY0ddZRuKAQC98X+ZtRBSvi7Db0D
         fUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619084; x=1707223884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgKJFJ/3GGLxSM/jtfTq8LlETbTPciEFuAYV4rAipow=;
        b=jX+/jcoSTTHBmr8fV+GgHuhua4oJwl1hpl93Qub6YQUSzG31FSDj+wlxIrVMSVXXtR
         b9LFr/D+qv5HUsn/ab5RBglywX2eHCVjhqzjn2sftDz3E8JBO3i9yLC6D3qfkuDAnkCC
         BXLSLG0nv0vMULqVmmRMqqzaV4tle+Ilw48iyOgg0HNw7S9Ere1q1b7RdSGSORrvJmia
         nwAUCw6T08ABhRITZLoqAute4et08lRHf2Wjq7QdMhNYdkjakFP/6KiShi6J5KZsBjZO
         G1Ufy9/alr8rH+vo9tcDx5Tc2oKJVMHXx8Au17e6nvLmpJ/q/5Zces8BIwOy2NYbajWC
         Dv1A==
X-Gm-Message-State: AOJu0Yxo/tuHCukQZ3Pdtj4FmSLmT3Df2NFNeU2j0FQxxz9cvtECcBqZ
	erWqjsA29SsQTw+qhUWHE5Ycap20/L+dtAPTqF1A6tqqxxhZqD46
X-Google-Smtp-Source: AGHT+IGNfdUcohP4BKiAK7V+W7bLsZz3PVad76EolQPKCaFm9MaSgHAVqJlH0BBBDLiis3lSHk1ieA==
X-Received: by 2002:a05:6808:128e:b0:3bd:c1b2:b1d5 with SMTP id a14-20020a056808128e00b003bdc1b2b1d5mr7640905oiw.46.1706619083954;
        Tue, 30 Jan 2024 04:51:23 -0800 (PST)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b006d9b35b2602sm7606311pfj.3.2024.01.30.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:51:23 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
Subject: [PATCH] UPSTREAM: f2fs: sysfs: support gc_io_aware
Date: Tue, 30 Jan 2024 20:51:13 +0800
Message-ID: <20240130125113.14081-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>

Currently, IO can only be ignored when GC_URGENT_HIGH is set,
 and the default algorithm used for GC_URGENT_HIGH is greedy.
It gives a way to enable/disable IO aware feature for background
gc, so that we can tune background gc more precisely. e.g.
force to disable IO aware and choose more suitable algorithm
if there are large number of dirty segments.

Change-Id: Ic0ea1bf8fb6602f0dd88b924088f1c1b33fcd809
Signed-off-by: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/f2fs.h                          | 6 ++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb547901..47f02fa471fe 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -16,6 +16,12 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
 Description:	Controls the default sleep time for gc_thread. Time
 		is in milliseconds.
 
+What:		/sys/fs/f2fs/<disk>/gc_io_aware
+Date:		January 2024
+Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
+Description:	It controls to enable/disable IO aware feature for background gc.
++		By default, the value is 1 which indicates IO aware is on.
+
 What:		/sys/fs/f2fs/<disk>/gc_idle
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 214fdd590fdf..ebe953e7459e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -374,6 +374,12 @@ enum {
 	MAX_DPOLICY,
 };
 
+enum {
+	GC_IO_AWARE_DISABLE,	/* force to not be aware of IO */
+	GC_IO_AWARE_ENABLE,	/* force to be aware of IO */
+	GC_IO_AWARE_MAX,
+};
+
 struct discard_policy {
 	int type;			/* type of discard */
 	unsigned int min_interval;	/* used for candidates exist */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 309da3d0faff..34a1e6b35af6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -109,7 +109,7 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (!is_idle(sbi, GC_TIME)) {
+		if (gc_th->io_aware && !is_idle(sbi, GC_TIME)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			f2fs_up_write(&sbi->gc_lock);
 			stat_io_skip_bggc_count(sbi);
@@ -182,6 +182,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
 	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+	gc_th->io_aware = GC_IO_AWARE_ENABLE;
 
 	gc_th->gc_wake = false;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 28a00942802c..51d6ad26b76a 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -41,6 +41,7 @@ struct f2fs_gc_kthread {
 	unsigned int min_sleep_time;
 	unsigned int max_sleep_time;
 	unsigned int no_gc_sleep_time;
+	bool io_aware;
 
 	/* for changing gc mode */
 	bool gc_wake;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96890f..95409cfc48f4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_io_aware")) {
+		if (t >= GC_IO_AWARE_MAX)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "migration_granularity")) {
 		if (t == 0 || t > sbi->segs_per_sec)
 			return -EINVAL;
@@ -906,6 +913,7 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
 GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
 GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
+GC_THREAD_RW_ATTR(gc_io_aware, io_aware);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1061,6 +1069,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_min_sleep_time),
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_io_aware),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.39.0


