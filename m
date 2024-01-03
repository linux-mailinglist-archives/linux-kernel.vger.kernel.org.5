Return-Path: <linux-kernel+bounces-14999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7438225F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF6284736
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DA17DB;
	Wed,  3 Jan 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYeeYVHi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22611390;
	Wed,  3 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28ceae32e9fso6375a91.1;
        Tue, 02 Jan 2024 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704241827; x=1704846627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFvILJ+t1ObHf5nxnhyRtHafjkPPFwRKVWgBM4XnJkU=;
        b=SYeeYVHiQiLhjej0E7YLm8V15FV35BzKFb0fFEeWjyDIApB8NvSNAXziWXvBmjweXo
         ULz7j1aTqNfzzDx43uvQt2I2pUDPkFS2WwPL7VlzsHHhlcXLeE99DAqlHkqR77/3LbB0
         3f+nTN7cEFyC2ynPglqfdf5NcUjemz+muMxNUdl7x6f6QgL0FKFHTiwxcajtNR2gjtIO
         xv4IFrTI0np2ph9COiJOJRXt+HdYfOMzpt31f/0aMWKT4BoZRkVFiN6LQfb6+QNiU8Qg
         VTbiGoTc4toaya0fXC1kuUUNp0BlGrtkLxHiWssJ4Hc/M4q/9J2PPPQlHQPQRidqnu0N
         X8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704241827; x=1704846627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFvILJ+t1ObHf5nxnhyRtHafjkPPFwRKVWgBM4XnJkU=;
        b=psrVJrjtNTBQcmoHFnof7peOdreD9Wnit0qxCOvZcLONsN0AzSg5OILCC1Db3kkEwF
         DS+7kmFn6KONMWdlyBvXx9RkUgshWf8rCAPwOvQM7JcpB1Si2onXaPM8dc/Lg/xnNZlq
         uvCqBO0FERZuzR25CoBTZBni5qxXdn6dbuuxVRADGnG5pSYPrFCXS95CT7qB7Pv7U2UJ
         Iggxlh2EL5GFA6Wy7ZFXYAZDKMiwQOK09Bba7t1E22e4V1oqOwYLTqT+VHsY/8LG15CH
         yVjvhhIYHSGNzFWJJ3lEsMZ9ecTv1O+wCaoB+PPRGSl4ggWyirEU8B3W/VhHODqxoItS
         weIA==
X-Gm-Message-State: AOJu0YybUXjs12E1YGKYtgpLX9iN9cE3UCQfI1uYB1wX7r3xq5uhny1z
	JCpUHZuV4yXU+NWsgpMcXJ0=
X-Google-Smtp-Source: AGHT+IF70NRYMTEHC8E1Dw0SmGhZazrVvpo+xsB9XKrGYIsDqyN7u8pkdUibyBCdEl2AM8bk2uaC1A==
X-Received: by 2002:a17:90b:b15:b0:28c:bbc7:7576 with SMTP id bf21-20020a17090b0b1500b0028cbbc77576mr1859418pjb.77.1704241826950;
        Tue, 02 Jan 2024 16:30:26 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a3e8500b0028ce81d9f32sm254134pjc.16.2024.01.02.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:30:26 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2 pages
Date: Wed,  3 Jan 2024 13:30:11 +1300
Message-Id: <20240103003011.211382-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to keep zcomp_strm's buffers contiguous physically.
And rarely, 1-order allocation can fail while buddy is seriously
fragmented.

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


