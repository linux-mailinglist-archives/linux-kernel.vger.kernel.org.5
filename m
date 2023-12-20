Return-Path: <linux-kernel+bounces-6692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE518819C26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B7CB248A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A721360;
	Wed, 20 Dec 2023 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtMbx3AE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AE20DCE;
	Wed, 20 Dec 2023 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3cfb1568eso21267125ad.1;
        Wed, 20 Dec 2023 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066658; x=1703671458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HEt/Agnjbcv9DZ/M0GOa62SZcHFmpwSvE3fYxb9KVA=;
        b=QtMbx3AENOISAfOlauZEfEURi2E2Xjxhscrc3OJVwydeJzFTDoyIZVubCwKJJC9mKg
         2Y8t9r1pdMKWHiQfDvRZkoMV3oU7MfFA4gRP/RdnuKIX1HTlS1jjw1qadvzfePkodhBh
         boPmiSeMQib/XOkHKP5iPFJveYrgutnOs5LSu7l/luVEi0l0iRbs4kqAN2e+SS0xF+XS
         hsfMq0nDAZvgH8VKxhEugon+nBbT8j2Fw2RYLhHNNwv1t9daEUYAo4vsWtbV1g+dSdNn
         OX4IP+Iwi/c6zxAqjZ2wysx1QoTg+4k+xHour0pQx0S+vexEJ4l85wQFdRTgpvn8R4NA
         QDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066658; x=1703671458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HEt/Agnjbcv9DZ/M0GOa62SZcHFmpwSvE3fYxb9KVA=;
        b=LNlrExYrh5WgQfHx7G/USbSlz7AM64+FgOJ5WaBNSt42z/jMmPxWRk9O+LU/XpFqNF
         pwuElWg2anqTGFWSNPmLOMdduG8wDYUP952CS6pbyZGa6tzyd5ObM7WgSGzz6+PNpHh4
         gkXr6mps9DKgRcc1/pKJPwvplHxV12M45iwkgcRx7uhlzYmceq6480nXSbH/yi4ule7J
         XehYyIJQKMOghmAJHF4rYxyd3g3F+3QMCrc4PK7UgQsR8PFG+MfO0uqrfXqMKWlgCkHz
         cBD1nxboFNjgNnq+74LsdMn3ZAMzF2H3O8y/RJw3oYPXnrPG2EZMYozn4gEQtUytRlHS
         41kQ==
X-Gm-Message-State: AOJu0Yxre3yRrBkFV9+88i3kWdDfhF19yw+DCAfj4GJQcx4rohrOefIj
	JUSuVhfsSnuB4VjVznZ8aGI=
X-Google-Smtp-Source: AGHT+IEbaFfYHbR6pC1D8QsJ2uRB5r/HvmJFeTQAJTPxOJxDG1Vafjsid5EASELuV3KYMogm+e4Yyw==
X-Received: by 2002:a17:902:d4ca:b0:1d3:45c8:bc12 with SMTP id o10-20020a170902d4ca00b001d345c8bc12mr16994882plg.38.1703066658460;
        Wed, 20 Dec 2023 02:04:18 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001d3b7c5776asm5721619plm.160.2023.12.20.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:04:18 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v6 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Wed, 20 Dec 2023 18:03:33 +0800
Message-Id: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
References: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
 <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

Since dm-crypt queues writes to a different kernel thread (workqueue),
the bios will dispatch from tasks with different io_context->ioprio
settings and blkcg than the submitting task, thus giving incorrect
ioprio to the io scheduler.

Get the original io priority setting via struct dm_crypt_io::base_bio
and set this priority to the bio for write.

Link: https://lore.kernel.org/dm-devel/alpine.LRH.2.11.1612141049250.13402@mail.ewheeler.net

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2ae8560b6a14..ba6e794f7871 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
+	clone->bi_ioprio = io->base_bio->bi_ioprio;
 
 	remaining_size = size;
 
-- 
2.34.1


