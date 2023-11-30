Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552A67FF37A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbjK3PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346310AbjK3PVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:21:47 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD91999;
        Thu, 30 Nov 2023 07:21:45 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cfae5ca719so9787265ad.0;
        Thu, 30 Nov 2023 07:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357705; x=1701962505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Ve3g0hg7XJIuYba32dYwns32+lQpud+n24L2XbaBQ=;
        b=LbQ87ofPTwfgWM2C1PcfYMIMIZv5EiL6BzNHZ9qbnBpOIQpEiidGKDhqB67dQKnMnP
         +Aot5d+Z7xwP992oKubb7GT+StWcBYrxIMHCohlMzXqvtlrKzQUPtMHGoOpOHqWd1/Lk
         m3bD8NPk55eUQX2iNBuvEaNbonZpSipVG7+MTq6XtO8Kfstm4RGPHpDuGV6XMwmFbZeS
         x2EKPdHASZMHw0KyXJyx3/QC+wMgzzjAUaNY2JxyIZHfY0c9pqwTWxkHtd7N+wgVgNwB
         sAAjaSp5yuRib0onZt6wIWFAvFGm7lQEB2+pjRGQg5qY6TXP6H1C8z2ky6FhTqETwhAN
         4O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357705; x=1701962505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Ve3g0hg7XJIuYba32dYwns32+lQpud+n24L2XbaBQ=;
        b=LXY38r9vZf8USE2x/M1JECgJWqByDEtOtBdnwsYKu/oW8bOmdZgkVeM2p8U3co+1j0
         h2tXYHiOoBFT7nm2Au3jjOLIm5KaYD24yXlnWVuWYbfpJgyNJsK0fpa4RxFGKZ+SrxMA
         zA5dMxHJU4VpUNw4z6Y5f7ebpi+ubMKIAboB+uJAvGJgduRNYPBPt+1VqrRATBrE1fsk
         ookfBDTuFef+NvJlHw0b1ubGJCiHuLMzfoVuY2Vg0bXpZKQY/Grq8C5DUON2GXYemwjf
         2PR22kYTrMNtMY+7HOTQbUFO7W1h+0CurCU3ta2J5YUY2XVr9+VWgO6cSZQsLvRDGPCL
         tV+w==
X-Gm-Message-State: AOJu0YyOAsnjnXyByg8tA3ZMLrKuuo/8R8Unzu+8Ydq5XfCA2fAlq1aU
        GgNBxSBGfvxoEkVZ5r/vPOw=
X-Google-Smtp-Source: AGHT+IEiOwDWn7FRE8zls2WYmHvdJU86qrptvWpnPBE3aBVrul87+7g44TYNL/hnxJw2y4b6kYpoyw==
X-Received: by 2002:a17:903:2286:b0:1cf:ba46:e402 with SMTP id b6-20020a170903228600b001cfba46e402mr18882771plh.54.1701357704827;
        Thu, 30 Nov 2023 07:21:44 -0800 (PST)
Received: from localhost.localdomain ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709028c8600b001c9c5a1b477sm1514979plo.169.2023.11.30.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:44 -0800 (PST)
From:   Dongyun Liu <dongyun.liu3@gmail.com>
X-Google-Original-From: Dongyun Liu <dongyun.liu@transsion.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        lincheng.yang@transsion.com, jiajun.ling@transsion.com,
        ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate bitmap memory in backing_dev_store
Date:   Thu, 30 Nov 2023 23:20:47 +0800
Message-Id: <20231130152047.200169-1-dongyun.liu@transsion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered a deadlock issue when using zram on kernel version 5.10.
The reason is that the backing_dev_store will first hold the
zram->init_lock, and then it will allocate memory with kvmalloc_node. At
this moment, the system may be in a state of memory shortage, so it will
enter the memory swapping process. In zram_bvec_write, we will trigger
our own thread to move data from zram to the backing device to free up
more available memory, which is the work done in the
try_wakeup_zram_wbd. In this function, zram->init_lock will be acquired
again to read zram->bd_wb_limit, which causes a deadlock as follow call
trace.

The latest version of Linux does not have the bug, but a potential risk
in future.If we try to acquire zram->init_lock again in the zram process
(for example, when we need to read zram->bd_wb_limit), there is a risk
of deadlock. The bug is quite elusive, and it only appears with low
probability after conducting a week-long stress test using 50 devices.
Therefore, I suggest passing the GFP_ATOMIC flag to allocate memory in
the backing_dev_store, to avoid similar issues we encountered. Please
consider it, Thank you.

INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
Call trace:
  __switch_to+0x244/0x4e4
  __schedule+0x5bc/0xc48
  schedule+0x80/0x164
  rwsem_down_read_slowpath+0x4fc/0xf9c
  __down_read+0x140/0x188
  down_read+0x14/0x24
  try_wakeup_wbd_thread+0x78/0x1ec [zram]
  __zram_bvec_write+0x720/0x878 [zram]
  zram_bvec_rw+0xa8/0x234 [zram]
  zram_submit_bio+0x16c/0x268 [zram]
  submit_bio_noacct+0x128/0x3c8
  submit_bio+0x1cc/0x3d0
  __swap_writepage+0x5c4/0xd4c
  swap_writepage+0x130/0x158
  pageout+0x1f4/0x478
  shrink_page_list+0x9b4/0x1eb8
  shrink_inactive_list+0x2f4/0xaa8
  shrink_lruvec+0x184/0x340
  shrink_node_memcgs+0x84/0x3a0
  shrink_node+0x2c4/0x6c4
  shrink_zones+0x16c/0x29c
  do_try_to_free_pages+0xe4/0x2b4
  try_to_free_pages+0x388/0x7b4
  __alloc_pages_direct_reclaim+0x88/0x278
  __alloc_pages_slowpath+0x4ec/0xf6c
  __alloc_pages_nodemask+0x1f4/0x3dc
  kmalloc_order+0x54/0x338
  kmalloc_order_trace+0x34/0x1bc
  __kmalloc+0x5e8/0x9c0
  kvmalloc_node+0xa8/0x264
  backing_dev_store+0x1a4/0x818 [zram]
  dev_attr_store+0x38/0x8c
  sysfs_kf_write+0x64/0xc4
  kernfs_fop_write_iter+0x168/0x2ac
  vfs_write+0x300/0x37c
  ksys_write+0x7c/0xf0
  __arm64_sys_write+0x20/0x30
  el0_svc_common+0xd4/0x270
  el0_svc+0x28/0x98
  el0_sync_handler+0x8c/0xf0
  el0_sync+0x1b4/0x1c0

Signed-off-by: Dongyun Liu <dongyun.liu@transsion.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d77d3664ca08..ee6c22c50e09 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
-	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
+	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
 	if (!bitmap) {
 		err = -ENOMEM;
 		goto out;
-- 
2.25.1

