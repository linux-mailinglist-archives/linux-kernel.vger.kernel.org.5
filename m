Return-Path: <linux-kernel+bounces-118935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7088C187
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05B12E0290
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A876FE2F;
	Tue, 26 Mar 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnN7e4K9"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279231848;
	Tue, 26 Mar 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454638; cv=none; b=Axd5SnrMz6AuGHAspI7KNnyRsLlvi4C9eclLnBsSPX40KgqOezVXWnf8vIRSieW3ZefrXhs6xktHW4RuKJ8IP2rplQM6bdc9wmh2VzzrItNfGF70uAwUYS8LuutRTrQGTG1EWxJdenP8EBVQe1qnTKXPH6RovorV/hMjOJVT2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454638; c=relaxed/simple;
	bh=/eolo8YDMliBlPkq5x8R4OwAs+JFGRkmM8SLqYlT6MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYfYzGJ9xIXQX8MJ979sElCLjKY/ep+EWn3kE5nNIGdLYujNL/S7kJjr7yDy6Eho/jeUKfABWnmuqPn7FUUrfhY4ifMECKyhYP/ZgaX3/E3bYvSS5+amRM3Nc0KpXXEDQjUuNgP+jALriw2mHM7F5UCfkBtNrbZdW/3nptwy5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnN7e4K9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so1602274b3a.0;
        Tue, 26 Mar 2024 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711454636; x=1712059436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCxgVhPFTxuH1GA92z1REKomLgR0EURFMfPP7QpUiW4=;
        b=QnN7e4K9aWaypJLnV8uo+Uh7wiFzJQACqIhTixBiUwm8Wa2ZXau5Q7CwPqbWzdjSsX
         qikpBTFrNDhmaKZEqE3/zroSPhYMnESO6XP51zCoF3ByrVqlT2HTmzB8axE/mpaENWa5
         BB53zACpQVOMaKs01+1dVDYnR4egfNPguyY70iCcBu3NpD09z9WX+gw+EVlT5KrJsrj+
         Uo1MuzLqRqQMcYDnBhphm84Q/3I4c+lRtJokNWKXgLZd/X6ZkphEXgwR5fjTOHJN6twI
         TlAP88bZqz5hGXI+tEpvhv7zfraY4ZBVLfZmhq/OOPyGnrU91cAJV3zPw2fdZ80q1NXd
         7h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454636; x=1712059436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCxgVhPFTxuH1GA92z1REKomLgR0EURFMfPP7QpUiW4=;
        b=E1iKpk2kK5o8HGx8YRO9HTxeAFenEr2bJt0sWDPLV9g1d0LaQ7FTJiPJHF6sDQ6Qud
         BCwzRIQzr4+cXIH5Uxq005lTSDAPYjxznME/WgKM2AM+V8SRWCdacQHcI2iuOOU/kpIh
         Z+WgqdEs11ECeVazyN57ZQtXZSa9QZpBb4ZHqa6TUKWSWYvhX0e9chYtCD6+CviOu0xS
         VpSjS0s9FJ+/bcyb6JbpsGlXdNO/WfUCjY9Ub7K8/tAl7ltvxdyuNps4WQponPZwKYjz
         SgFrjh/sXOS1fWQiC/4MqSWRh9cyTFRHDrUW7q9O3qyIp5GTVkRR0pz2NmcIq8jwOgko
         +xtg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4T3b3rDJqesqd0oc5qCcgvNzD28uCMUlj/lu/+r1BmPD7ZE2keQO7dXgjKCxX4/HRAko0n4c40JySFpucGh9oIfkA6BJcvaQyNS6
X-Gm-Message-State: AOJu0Ywtifr2XExFA0xj+wZUYB0955WKv3lZD+VhTB1Xg2QsATwM4p47
	RS+lBbhVOhg4wi4FkLks+4fhKiYHzc561bgrOq/2E23HC5tVBlf1o9avsQ7e
X-Google-Smtp-Source: AGHT+IHmHKO7a+8nHVpE6M2TFcikxT015pV9L/NOHCfZFYh8UAAC2DIJTelSD/iFLV9HxhnsiNljFQ==
X-Received: by 2002:a05:6a20:2588:b0:1a3:5d08:4152 with SMTP id k8-20020a056a20258800b001a35d084152mr1862658pzd.19.1711454636212;
        Tue, 26 Mar 2024 05:03:56 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.152])
        by smtp.gmail.com with ESMTPSA id r6-20020aa78b86000000b006ea92de360esm5991321pfd.93.2024.03.26.05.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:03:53 -0700 (PDT)
From: zhuxiaohui <zhuxiaohui400@gmail.com>
X-Google-Original-From: zhuxiaohui <zhuxiaohui.400@bytedance.com>
To: kent.overstreet@linux.dev,
	bfoster@redhat.com
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhuxiaohui <zhuxiaohui.400@bytedance.com>
Subject: [PATCH] bcachefs: add REQ_SYNC and REQ_IDLE in write dio
Date: Tue, 26 Mar 2024 20:03:45 +0800
Message-ID: <20240326120345.68786-1-zhuxiaohui.400@bytedance.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when writing file with direct_IO on bcachefs, then performance is
much lower than other fs due to write back throttle in block layer:

        wbt_wait+1
        __rq_qos_throttle+32
        blk_mq_submit_bio+394
        submit_bio_noacct_nocheck+649
        bch2_submit_wbio_replicas+538
        __bch2_write+2539
        bch2_direct_write+1663
        bch2_write_iter+318
        aio_write+355
        io_submit_one+1224
        __x64_sys_io_submit+169
        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+110

add set REQ_SYNC and REQ_IDLE in bio->bi_opf as standard dirct-io

Signed-off-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
---
 fs/bcachefs/fs-io-direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-io-direct.c b/fs/bcachefs/fs-io-direct.c
index 33cb6da3a5ad..f49e6c0f0f68 100644
--- a/fs/bcachefs/fs-io-direct.c
+++ b/fs/bcachefs/fs-io-direct.c
@@ -536,7 +536,7 @@ static __always_inline long bch2_dio_write_loop(struct dio_write *dio)
 		if (likely(!dio->iter.count) || dio->op.error)
 			break;
 
-		bio_reset(bio, NULL, REQ_OP_WRITE);
+		bio_reset(bio, NULL, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	}
 out:
 	return bch2_dio_write_done(dio);
@@ -618,7 +618,7 @@ ssize_t bch2_direct_write(struct kiocb *req, struct iov_iter *iter)
 
 	bio = bio_alloc_bioset(NULL,
 			       bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS),
-			       REQ_OP_WRITE,
+			       REQ_OP_WRITE | REQ_SYNC | REQ_IDLE,
 			       GFP_KERNEL,
 			       &c->dio_write_bioset);
 	dio = container_of(bio, struct dio_write, op.wbio.bio);
-- 
2.41.0


