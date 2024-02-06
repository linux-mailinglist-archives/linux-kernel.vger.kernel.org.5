Return-Path: <linux-kernel+bounces-55594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D766384BEA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9471A281C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEEC17BCD;
	Tue,  6 Feb 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPrhRIjn"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5D17BAE;
	Tue,  6 Feb 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251134; cv=none; b=s/W26JN1QSHAa58ZahqL+mctTEZ2y60/lZwq5vXRCaHqmnIC3G/K/ebFP9g8DSYoIaVYZFxhgpH051Lk1tkPfxfSL7ado0Nz4E8yVI7YO4q5EnRTJ5MNKTtS3+AK8+j1I5eS9FUqBL0idnJHlMBnNjkjGOYol7whIIA1cqD3IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251134; c=relaxed/simple;
	bh=myAxlBcAAYqHNe+fmEvkZ0s4GJom+6nvVRiWnx0/Raw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RX2hHaVpt5uhvwzYXsL75C7BjV9/NyN556xT6oWORz3YDgCusmsnuHH/6e8YA4vPTM7iWdj9FXsHTR0oKw8n4YetNoWUxI/HlgAvOdbt5CKTJ4rzQDagiTZCh/G+cjja6/ZmQRNYqkszATgXPurBmlp5Jpbk2WQs1QUlcrQsvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPrhRIjn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dc13cbce45so2545267a12.2;
        Tue, 06 Feb 2024 12:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707251131; x=1707855931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErQyw3q1yXVP0Ncex+AHp1fqkTGZvWT7VIYuvafQego=;
        b=hPrhRIjnGOS7QRlpaI0cXK5U8ereEz7TKqfh7o3iWnycP6GhMwDkjEhmkCEX5lQR+x
         0lhAh2GjEYoYGdo33xcrHZUfJxpUdBFZibMpQLAifWjupOcLLQe5iW/YtmfanK3EI0UO
         v+IgfvuokSNx1XI0hG2pEpBUxiSS4SD3BBlPAAojmcSU3dIBbiLZRwm2C+hZSk+pLg5K
         qdDYBmzhPRQCq/DPuvggN1ULmLCdPLAQgIU1AMH883OufUZPdGM1k32XRTQ71SpAAhMO
         Djcc2Nn6moehlUq/PMJ73I/R5zxQeyuJr2RKaIyuL6veItn+YM4qiss25w95IRg6gclE
         KEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251131; x=1707855931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErQyw3q1yXVP0Ncex+AHp1fqkTGZvWT7VIYuvafQego=;
        b=wyvu1SmouEKWN/wRBZnqxtlE0vSJRjaKuWhxhI69HTnyHoiCDDKD9zoYo6Ats0lxUi
         7xCONDt6uyygEdHI3Lp97671EoWRenpks+Z5RJDOtkWpK7t/0yHZWnY3V4zxEsjfojk5
         /vKyBJpS/5gzb6DFneYofjx/TZp22sjItdkCAvEb0uQTIO0ZDiU2He5N+Mwy2UUn4oGK
         2IWbkH86+ytz5SyWOPfxh1+NZjPDf0v3dt8JQFSzQFfwD/H8YSSS7BQ2ulv4F8kKCC0C
         ahxBaBXqo7D8+Y7cmSO4BSf2bISlefWLGrx/Mzak9/b3CSnytG0RVEpiOLol1fgB00YX
         o2fw==
X-Gm-Message-State: AOJu0Yx1xq4GqYaHpk/OVxjnuTqoeX6JlLznbqS9QDBo202iwALwCR+r
	yxLIYN/se8jWmzcnW5RI5JRtpnVKgg+l9cV+870BWCTP50BAO+SQ
X-Google-Smtp-Source: AGHT+IHrxeWL4PNn0erWEy/zfrew41Tx9xSAIXGmq0aCza1yK8mlFfdYt9ZXHSq5ZGdZkPnma1GdLw==
X-Received: by 2002:a17:90a:d443:b0:296:a13c:8f84 with SMTP id cz3-20020a17090ad44300b00296a13c8f84mr642729pjb.33.1707251131107;
        Tue, 06 Feb 2024 12:25:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXX1KERzDsG+KIcsVpucZrWB1OSpeeuWlvHE1rORsA5tI2oTekpquyBIOFuscF4sj/ywA3BOQnUsGdW7nipH3rZk6Nw4ATflP8nzfL+UT+kDD3F55uOEsVtArCX3uhQHQSxpqZ4A/AmoArcOOL11YQAZ5MYT8unpyV5fSgPW4IuMYp/kY0c6NJ8oV/mdhtMujm/KeaMQgFUJl45l5/qnW/+Eonxx4Yfi/Ailof2i0Ii+nxvMqRDdeL/hAuIBlSq+6XnOsH6wuI=
Received: from barry-desktop.hub ([2407:7000:8942:5500:f8bb:67cf:8c3f:c7bd])
        by smtp.gmail.com with ESMTPSA id sn15-20020a17090b2e8f00b00296b57ac914sm2165557pjb.38.2024.02.06.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:25:30 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers through vmalloc
Date: Wed,  7 Feb 2024 09:25:11 +1300
Message-Id: <20240206202511.4799-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Firstly, there is no need to keep zcomp_strm's buffers contiguous
physically.

Secondly, The recent mTHP project has provided the possibility to
swapout and swapin large folios. Compressing/decompressing large
blocks can hugely decrease CPU consumption and improve compression
ratio. This requires us to make zRAM support the compression and
decompression for large objects.
With the support of large objects in zRAM of our out-of-tree code,
we have observed many allocation failures during CPU hotplug as
large objects need larger buffers. So this change is also more
future-proof once we begin to bring up multiple sizes in zRAM.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/block/zram/zcomp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 55af4efd7983..8237b08c49d8 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/crypto.h>
+#include <linux/vmalloc.h>
 
 #include "zcomp.h"
 
@@ -37,7 +38,7 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 {
 	if (!IS_ERR_OR_NULL(zstrm->tfm))
 		crypto_free_comp(zstrm->tfm);
-	free_pages((unsigned long)zstrm->buffer, 1);
+	vfree(zstrm->buffer);
 	zstrm->tfm = NULL;
 	zstrm->buffer = NULL;
 }
@@ -53,7 +54,7 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
-	zstrm->buffer = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
 	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
 		zcomp_strm_free(zstrm);
 		return -ENOMEM;
-- 
2.34.1


