Return-Path: <linux-kernel+bounces-36476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D283A173
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1B528C524
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855117551;
	Wed, 24 Jan 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4hH24+L"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A61754D;
	Wed, 24 Jan 2024 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074586; cv=none; b=Lc+k6EIGIj5imCDwSGh0/zJ64s2nM1AzmVKDbmqSPZkQ3hgapSqknV11Snha52CZvjigIL2R6cqp1CxN7bTgsSCtm6mIu/oXs1Wc3OjSyIRDGaow7YCbnATzTCpzYKYxl9rr/gRcpsGw2UDqXsloSWAT9XMqVBzl+8/m0aifmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074586; c=relaxed/simple;
	bh=FTonyJYMrGMeqQkJelHx/h0+QUGv7Ul6tpIhRdwERfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pW0DRbnX7KJXu1EE9c/s0juMfZB/jVodJ8UzGmT1lM71V8DJcVG1NldPNlq0Bt7gk4zPWixYbbcd5stOdbGp/Kp3RMGyFjz24rjEB13AOygJWJeDj0xOuah17Hy7/z4mjDMdu5127TyVpIxlRPyGeaRp2zHley0MKw7J5IDDBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4hH24+L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so17028505ad.3;
        Tue, 23 Jan 2024 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706074584; x=1706679384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpy9sRZAItz627ZVJHW5k+R1D4QC+yLepEX4TtJReRw=;
        b=Y4hH24+LcCgH8JOzf4dsLKlISbyZHXZBxVQFmlrmC2S3BQL3jNi+ClC5L04uspVwkl
         bqzWfwRrZyATwfxFCdXriK33r/c06Sdqn5nSDL//QEvUFg0rlwgMRBcivnPN3C8o9LNJ
         3pFtlTcWSEzx+1f9kfd6qzxb+mhLDjzPZZXhzP8o6r1p4H7DN2NnnwweIz871CxoJ8I9
         mpSckjtMg0TY9rlZnWoncBxeTJ4p8wUT+GMCMY9vGcsMERBQ1THxeXuivJtjfnrk/del
         93QVqOpFDu3CN9f1pSOqUrXubRgNSFwBphBzihbCbD8vXEz9dSe4xdNP56NhfxbwGc4H
         bj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706074584; x=1706679384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpy9sRZAItz627ZVJHW5k+R1D4QC+yLepEX4TtJReRw=;
        b=tpC6KvMsYUSlA3eGIQAEjqFSn8zqifPVo5AeGqYhuBw5p+KJj4HVfWSQIjMfKzeyew
         eeb+FTt/MmqqmKjke7z5wzpl9DpnbicGyX2s5Z9VwWoL3AeD7jjysK3qI+D++bm5KI+1
         zEksJiQbOGoJWg/L3oB3TxpADhyRLIBraCs/o5rT1Xw1Q9SHGErx7f/l65tlM9z3EabW
         thYM4srePvXoI427Q05XG74fWQ0hfzI4FQzlAirBdK3HldFd33bntFl69sZiZuGozcGL
         Rkd0GS8rnB2tjcFYNFuDFdpSpTFRQDhKFnUq+IIQYoDddj6+B9R561zDqvsoLqLcxXv/
         B7uA==
X-Gm-Message-State: AOJu0YxcQoEqcG9nAek/WSG65EbDoIYabkNNx5xZ0v6wSWWsKT6h0+Pu
	zU3iuHTLlHvjtn6OJyIkpk82xg4YtTa0C6faYGa70qAYOw+2mUmm
X-Google-Smtp-Source: AGHT+IEIOYQLu0dIgIPZVyXxKuK3uq5zhGh24Xtj2CiTZiBfSNhz+tQUUn79+VEaRwxYntSMRlyOXA==
X-Received: by 2002:a17:903:2447:b0:1d4:7687:833a with SMTP id l7-20020a170903244700b001d47687833amr215421pls.17.1706074584135;
        Tue, 23 Jan 2024 21:36:24 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm4015663plb.189.2024.01.23.21.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:36:23 -0800 (PST)
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
Subject: [PATCH v8 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Wed, 24 Jan 2024 13:35:56 +0800
Message-Id: <20240124053556.126468-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
 <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
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
index 855b482cbff1..e0804a86946f 100644
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


