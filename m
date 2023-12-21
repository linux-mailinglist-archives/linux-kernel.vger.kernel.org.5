Return-Path: <linux-kernel+bounces-8207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D881B3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BEE1F25361
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99F6ABA9;
	Thu, 21 Dec 2023 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujt34dgO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D96BB38;
	Thu, 21 Dec 2023 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d2350636d6so587299b3a.2;
        Thu, 21 Dec 2023 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154732; x=1703759532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HEt/Agnjbcv9DZ/M0GOa62SZcHFmpwSvE3fYxb9KVA=;
        b=Ujt34dgOVFXSlXzQf7DIElxF27e/pA6+PQWiMlKTrdHCc5qrrEcvrg+QJBhGvUQ6z0
         UFkrykxc8RCeLeQ8aTw2l+6kfv4ECzt/91s+qxaUxEj9zbZJreo91vHcigbfr6AvgPrH
         WFes/JeLdGuZJ9k2Ia03r0ji8X4t6e8hT/lHKi52ql1BKs9fZtCJrYyDmNdA+xHWRyfD
         CCxPm70FlKca8WcIEZaRMf+hqxVsB48lmqo9vsxew9vYfFpuRd6AxQqeeEbAuZiNkuyi
         /mXC5d2CO1fgj2xIRhg0BSrtsz5gY4fjDdoeQdyzjGc/4wy1uLes3ffZlEWFWpMG/xOH
         /+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154732; x=1703759532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HEt/Agnjbcv9DZ/M0GOa62SZcHFmpwSvE3fYxb9KVA=;
        b=SmwlWCMOCM1KwS4igmIzZPL6LPvr26NFKp0sCYHu7Y+EgRYJTR9hAsOh/iKnAaJq3Z
         u4Ifryanzj70yheNpRu08LZeSelfEkos/RUf/JXWO9oM8nRw9W5zcWE/dHYtS2j+F7wK
         38BAPjwzaQn7AoH5iow/12EXR3QSOktqLf5i2hIV15eNh7C0Jbyp8CL5vNjKG9qE2+so
         OF1rsA8rv+UhWHzDC5eLIERfer+5/dqC6vlYNV/zm0cDv+lOcwtiJF8m7IidMzvAigAV
         jnSmHgiRNjRbpFk/7xWglXsmgAKfrfyeIYC49sDlQAS9gF+BpeZAS1kTy48UJ1DrOT2J
         xN9g==
X-Gm-Message-State: AOJu0YyQg8UYybH2Jjf3AP/tRij5B43w7jmM6KObizr+Q2k9v8TLnSTD
	q2uT63vrZElTA2YNxJ24+C4=
X-Google-Smtp-Source: AGHT+IH5t7uT/SldRyiqK6cSmkG5jDgNvZum1nVCrHGQGX9hUk4auA9koTf/m4gNz1e+uGzeX9pI8A==
X-Received: by 2002:aa7:9d1b:0:b0:6d9:6712:f9ed with SMTP id k27-20020aa79d1b000000b006d96712f9edmr1727220pfp.7.1703154732417;
        Thu, 21 Dec 2023 02:32:12 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a25-20020a634d19000000b005c6617b52e6sm1274539pgb.5.2023.12.21.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:32:12 -0800 (PST)
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
Subject: [PATCH v7 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Thu, 21 Dec 2023 18:31:39 +0800
Message-Id: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
References: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
 <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
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


