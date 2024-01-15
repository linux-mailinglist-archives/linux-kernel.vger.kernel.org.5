Return-Path: <linux-kernel+bounces-25666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C582D457
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E28BB20A89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FAE440D;
	Mon, 15 Jan 2024 06:58:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC43C0B;
	Mon, 15 Jan 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TD2zV1ytXz4f3jM7;
	Mon, 15 Jan 2024 14:58:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 514DC1A016E;
	Mon, 15 Jan 2024 14:58:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAHLA+a16RlEZuWAw--.48011S2;
	Mon, 15 Jan 2024 14:58:36 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: djeffery@redhat.com,
	ming.lei@redhat.com
Subject: [PATCH] sbitmap: remove stale comment in sbq_calc_wake_batch
Date: Mon, 15 Jan 2024 22:56:26 +0800
Message-Id: <20240115145626.665562-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHLA+a16RlEZuWAw--.48011S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18JF4xXF4kCw17JFW8Zwb_yoWDXrcEkF
	WvkF18Wa9xWFn7KF1rAr4avryjk3yUZa48AFWYqFy8JFyjv393JrWkurWYyFWruay2vry7
	CrWxWF4xtr13ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

After commit 106397376c036 ("sbitmap: fix batching wakeup"), we may wake
up more than one queue for each batch. Just remove stale comment that
we wake up only one queue for each batch.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d0a5081dfd12..92c6b1fd8989 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -388,11 +388,6 @@ static unsigned int sbq_calc_wake_batch(struct sbitmap_queue *sbq,
 	unsigned int shallow_depth;
 
 	/*
-	 * For each batch, we wake up one queue. We need to make sure that our
-	 * batch size is small enough that the full depth of the bitmap,
-	 * potentially limited by a shallow depth, is enough to wake up all of
-	 * the queues.
-	 *
 	 * Each full word of the bitmap has bits_per_word bits, and there might
 	 * be a partial word. There are depth / bits_per_word full words and
 	 * depth % bits_per_word bits left over. In bitwise arithmetic:
-- 
2.30.0


