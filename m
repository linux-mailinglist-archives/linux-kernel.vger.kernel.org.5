Return-Path: <linux-kernel+bounces-63023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C1285296D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE362875B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4DF1755B;
	Tue, 13 Feb 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO4qNku4"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA1171A1;
	Tue, 13 Feb 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807259; cv=none; b=uBaDetC/jOOywFJHHioA2gaa0KUqorgaA8KLD4QQ1d452808+awINs8S4k3FVB7xe+5OXnkvdeD3FJGVTEjhdCcbMwD0q4mZ+NzxSsYXVkKl6FZgi6IQXz5Lp4j/wPLapLEvm8xXjdo+5gHe7xC+XjYKMcPgL7bmF0Aknj9NozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807259; c=relaxed/simple;
	bh=yPX55pPyRylfJOPpMRVJ/Y/KCJxWM0ADAW0OZLaUtRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JnJfQ8DYHFOEaFm30oIUsDID0TV5DLuud/0L+2L2RwO/uXeiFvc8E52ZBHDM5Qu6KWio7khmos+s81JYacWhlwYLO51B7N4jDfMLeXD3PpXYS/EdB9ji+rLqRai2QUeMNIDesz8wHu8ZX00R8I8ifRYnCT2h2/16Dqjw/ASYJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO4qNku4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so854247b3a.0;
        Mon, 12 Feb 2024 22:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707807258; x=1708412058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eE4n/xcjwe72umix/tvKZC1RPGH2ElYNbvUqnG6AUB4=;
        b=YO4qNku4JBJ9tB72SklUhgI8ArLAXIYoXb6SYtAag3x294DC4M6+0VkT1asEgQx63p
         Y1sLUlRbOQw/gY3XqKTLXVuyje5nZWdM5Q6WnhF7uIOFLw7PB1Fsg7Z8i2z5eTQ40+PU
         B9UEyyZD3OHwCdw/KPUeCR2fITnUcUgiNjfyxMlAeupf6gfe8/XIJCQy+0rjPOsZE/Vr
         HYjTPLoU7xGkFGnq4CFkLTmrZR1UmKB3fS60j/H9YSjviiAU0SFKcQOsstXbXVgRCzDu
         U/rdbJDrYunuLobDaBwiFnziXI7TJ4kZBY7sd9fvwHqdjr5irRg1iqNNY3qsrC1jz5Ad
         XZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807258; x=1708412058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE4n/xcjwe72umix/tvKZC1RPGH2ElYNbvUqnG6AUB4=;
        b=TvnFpb0ahnXPYiGQFovUKJtC0oXe1hhhaAwmrP/PBmpqhj7t6tHq79aFh2bfFEb7e9
         DnV1/aetgvLFOYbTxH+YtNl/AqpfuvNZl9uLsfLH/xKrY994ENwkeMfAtjX2Sv4WVwK9
         cF7wMKWieiyyMmXN+qSMJjF6/WgfU+6l1EsddDnlECFvCC6q688s8KmbB/4EhTYljT+O
         K8bnzj163ZsejT0bKexUcNYllHyCGluKFUy8qAAojJkTbqYaMXiON+mmObWbbaq7DU2S
         fmZ6OdduFasHy7/GiV7rfUX3LqHKRz1G2Tkt+xe+OgArJp8t8FoLWhaT2psyizsLZlpa
         9WHA==
X-Forwarded-Encrypted: i=1; AJvYcCWCofmXIxRt3mHn4LV3i7rqq/yeX/LwLld/xyV6KvqKuZnI/K0aWM4BXvKTvCUvN+R4cgK+zUoXWw5SoZM+CvTVkF73ux6kTSqcjRQ5I924pIXjpXyNSsqW1jVf5J5ns5O+NKc/gwc3m7g=
X-Gm-Message-State: AOJu0YypOh9yOdb5cXCQvIUfCSKbrJU4NGRgxxssAz2eZSY1GWFhYr4L
	YoJ9xRikCKoeRibm7QN+HfP2KOQkCxCchXgZT2jlNiUURwMVhbrc
X-Google-Smtp-Source: AGHT+IHM4Fk9YQ8Oq7wBOTXN/PqA34hx26fsW6gLj3+enE3vzc5VqmWa07lPaO5kGn9LEiXR+nStYw==
X-Received: by 2002:a17:90b:4f89:b0:298:9688:56 with SMTP id qe9-20020a17090b4f8900b0029896880056mr3491422pjb.9.1707807257712;
        Mon, 12 Feb 2024 22:54:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmG3OCdg3WqHsCukgRY3T/dN57iG8mSJsgjeZ8SS9+yDASLknfjr8rbSxX/3DGFpf+vluGzA5G0p4VjnAQ/5mn8A9w5NNHpIwwirRtj7+xDIJMuS4heROYmjqso4E/1sJiqYR/Ax5eHAyawKkF04L9lFtxMgedKW19uBrpOD0b8af43pU5GhWAEa1rYfLL+ZjczlmqKNLeuAmnk60jubgSh8CExoqFKov5ZVBF3A35EQ/c4o32S4okPryN30akCjy372QO8xKsz60=
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7ed:f419:b281:4119])
        by smtp.gmail.com with ESMTPSA id nh11-20020a17090b364b00b00296a686dd17sm1699933pjb.56.2024.02.12.22.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:54:17 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: axboe@kernel.dk,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	linux-block@vger.kernel.org
Cc: zhengtangquan@oppo.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3] zram: do not allocate physically contiguous strm buffers
Date: Tue, 13 Feb 2024 19:54:00 +1300
Message-Id: <20240213065400.6561-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Currently zram allocates 2 physically contiguous pages per-CPU's
compression stream (we may have up to 4 streams per-CPU). Since
those buffers are per-CPU we allocate them from CPU hotplug path,
which may have higher risks of failed allocations on devices with
fragmented memory.

Switch to virtually contiguous allocations - crypto comp does not
seem impose requirements on compression working buffers to be
physically contiguous.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 -v3:
 Thank Sergey very much for rewriting commit log

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


