Return-Path: <linux-kernel+bounces-51433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172C848B1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83C52842E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD979DF;
	Sun,  4 Feb 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3TB+J2I"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978979C1
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707022735; cv=none; b=L82mR8oBn1NQgaEPWQ/dkd5LrZRWuXxkarLV8gHJGqliL1JDuqUZHEW2oztgzzunKuBDP3A0GUjyVK6lqsK7ziOBJUt0sKwiDuwfd5wmUqLEijCB3xAwNllfHUrL3SPXfZ79r1kRaxE0/VK+ppBgC6qrj42WCc/4AjMzIWBwqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707022735; c=relaxed/simple;
	bh=6+r6m1SRktt8Wos7P/18OiK0dwK+LAjNE/t7vLBNChw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vls/PXQnjfWi1IyC4oXsvIRVvs0qB6QAbdmxFQvauj6cGnAuq/zGBBSNM53TMyJcSxHvTMdufK1ssBgr1vJ+lvSBBlVFMjqeWOmjm90dDD34QLSJ/NB6g/63c4x6mUFtK42TC8npZY3HbcS2xAxgfPRubrk3gUyX8AoHzupwO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3TB+J2I; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60427d9c5dbso17702227b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 20:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707022733; x=1707627533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mo/Nvkvck63sS/B8DyIx8YcYLkXno8x34rYe0N1lpLU=;
        b=S3TB+J2IoVq0H6wsVQsz4gTVqKGUgWGgYr1BMhPGlHUblaEWavhhUi/zP9PhrOJO+m
         dSwoQHWGVn4xQ/LR12bOTLmv5l55Bm37AbKopDzh/SurmH7BZbhA5UgzsvpVXILDjbhz
         pPhiLRk5z4jUsvk6Zu6ZLRLkAa0HP8rZAa1PGELszXJPghzHDh7E03/BiSYr3mJ8YRri
         c+5nXsC18VWvexR8D5IC6bCw6X+Av2bPWzy5QkYHvNIYdbWn0ZeJ5HWFxuJUHR72K40B
         G+4aK7Rm+uwKbb7VoVEkuhQrcRfQjYyTWOjBtInpziCy5OTLcCTu17Fsmfp3NoRoyt8X
         OaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707022733; x=1707627533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mo/Nvkvck63sS/B8DyIx8YcYLkXno8x34rYe0N1lpLU=;
        b=AVpWzlRugge22iUL4imrLCR3skPH17QwQ2QPY/QOjYHeCXRKDLtFh32o41CTfaB/4q
         k/J4/fnsVuzCl5/s87Z+1vhVsTldunvCgcJJMzO5zJfpeo4N7nba3+ioSrq5se+ZO/x7
         Xb53n+eydyi7EWLhczoGAyDyOb1HS0glp221ttSA2LkZormsdxf3ERidp/Sxv7x2tDhL
         zj92w091/1l9xPfagg9/o1x97rQnu7fBHSM54syU4KWUtHITNaHMTPJ1u7cyL/HMkAR3
         ksbthB+cOrBMhWAmyP+iVTQS+tujthQWU5zBhYnQNy1c0zk7zsYe1NRxeNqHl2sR5Wsb
         o9aw==
X-Gm-Message-State: AOJu0Yxaqn6CmsybDNy0b02al+njqxAPztCjD2sdco9J1fw3+MAPWC9V
	0svfQh8etpLcBgbiZ3Hb+E0POxs8Bxh+Iw/9qP3xTt6x5Zc53Xlx
X-Google-Smtp-Source: AGHT+IFuetYBGJyMd3YNFLcBo+suzwrrIJOPdNk/k9KEhWeAmX0KXY9j7kSgb93k/x7toWrQBQdLuQ==
X-Received: by 2002:a81:91c6:0:b0:604:559:7a12 with SMTP id i189-20020a8191c6000000b0060405597a12mr1746184ywg.26.1707022732701;
        Sat, 03 Feb 2024 20:58:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGgjuZhVgsbToD4KtT9zQh+84oUNmAIpNXk04oHKKPDuMG+uwkyc/GgXKXrLqJ35QbH+Xw1Egj1Fm39v7YjWfBk6E7Sq2yvPq9FuRoiGoay6P8xR6AYDljvdVrnRQ4j8cigA1R3pISB6YRCTI4DMODNrBAQw==
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id d4-20020a0ddb04000000b006041ca620f4sm1296112ywe.81.2024.02.03.20.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:58:52 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.com>
Subject: [PATCH v3] f2fs: sysfs: support gc_io_aware
Date: Sun,  4 Feb 2024 12:58:43 +0800
Message-ID: <3b2852b3d404ecbb53d9affa781d12d0e9ea3951.1707022643.git.liujinbao1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.com>

Currently, IO can only be ignored when GC_URGENT_HIGH is set,
and the default algorithm used for GC_URGENT_HIGH is greedy.
It gives a way to enable/disable IO aware feature for background
gc, so that we can tune background gc more precisely. e.g.
force to disable IO aware and choose more suitable algorithm
if there are large number of dirty segments.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

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
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 309da3d0faff..0b75d37acc63 100644
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
+	gc_th->io_aware = true;
 
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
index 417fae96890f..e8d5667cfddd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_io_aware")) {
+		if (t > 1)
+			return -EINVAL;
+		*ui = t ? true : false;
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
2.43.0


