Return-Path: <linux-kernel+bounces-164389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2178B7D15
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2410C2839F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67917B4FF;
	Tue, 30 Apr 2024 16:32:48 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA5FC01;
	Tue, 30 Apr 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494767; cv=none; b=QFlonaDD07GaECz1XNMndL+hVbTo7DWgro+FSd+a4Xj/WQ0xZgeomRfCRMzdi+buneVWTjVWVN7vn3Yypyysra147rO5HPMPfMXxmqb7AQgKhADGazYTDfNrEOGPug3De/eXFhhIcPqKn/OSQmLO2cFmLWBXjYa0A6IdpbBNKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494767; c=relaxed/simple;
	bh=H/gvptIMyXKLzvEYbCGoc5f9/tDyYAwEGTyBOFG3GPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tog/1qhOU7jKrSG7b99upndAvSIsEVkrPH/viWYVSQRTwFtOnCCXzmh+nHmbalmCJKj5U9dlKSJDJas7UX0tPaDN+fO6GJ9Q6/Aa6spfIaR9xfvFYXXp3+EQg8eWGThW8x8AyfnFt9CbIaDQHGt7jT+IhlQt33W29vK9fuUIy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea2375d8d0so4788207a34.0;
        Tue, 30 Apr 2024 09:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494764; x=1715099564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oz6qJQr5VG/TB+Xly+mUB6KvAVjDu9XBnLvrYHSCw20=;
        b=MOkrBFvk/MGkR6S0BKH5CYCGqjrKR78yndbSN39yCbm7MsSPU26kySIbAkrybe5TXw
         wTvfyjROB4z05au9tSlFhCxr2R1PtBu8LZQCQi4E8dKh8ZY16UMvCx0h7KeAn3mj3tZz
         kNijh+WXls4l7/WTN66cTSMTxOG+qjSdM8BfrBiujbOnc5nBo5smgv+kRAJtgNnkepvy
         6svNSL26IMT1hxvl4kuD9HWifey+cvRA8h8IIkxEyk4DbcZz0BPPO8q7X/luMQXgiQBL
         4vSiiz2c+szZNaNyhpNbsGNfYmBfdWxQ/YQd2t41sHVGhH4+PKvm9FM1tyUpkBCa4Ac3
         fqeg==
X-Forwarded-Encrypted: i=1; AJvYcCXKOA0b4Q3+Sxk9+0mCUbnceQdq1DZNbdRi+1DnTVZSd8Q66JpiOVE+2UwkTz0/v4O0i4TH8Q7OT8DCHlG5sZG2EKs1EXb8UJC6chDXT/KKZOlV2JYOe7C+P15yGhBN213UmHMmFKQiLsRxrNUR
X-Gm-Message-State: AOJu0Yz/pJvfKoFUpoKUgRgR1WukitqnxD9lR8KcXt7JGem09J4e6m2y
	bIz75KFFzOmSJY7XDHkqn1E1sd2y4Ie/tkVXaWeN/GKGJT3v6LKV
X-Google-Smtp-Source: AGHT+IFZDNRbBFPAq2mVEzle/wE/Hj2AQDdOfd5ZDLOSkhtm9NXSl2ld7ax1Z/PlN+kdQRGSVnewUQ==
X-Received: by 2002:a05:6830:1010:b0:6ef:8a99:d7a1 with SMTP id a16-20020a056830101000b006ef8a99d7a1mr1408002otp.34.1714494764485;
        Tue, 30 Apr 2024 09:32:44 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id n8-20020a0cfbc8000000b006a0d1b1ecc3sm1800611qvp.59.2024.04.30.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:32:44 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
Date: Tue, 30 Apr 2024 12:20:51 -0400
Message-Id: <20240430162049.1516720-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Luiz,

Tying the msft->data lifectime to hdev by freeing it in
hci_release_dev().
Also, change msft_unregister() name to msft_release().

How msft is used after freed:

[use]
msft_do_close()
  msft = hdev->msft_data;
  if (!msft)                      ...(1) <- passed.
    return;
  mutex_lock(&msft->filter_lock); ...(4) <- used after freed.

[free]
msft_unregister()
  msft = hdev->msft_data;
  hdev->msft_data = NULL;         ...(2)
  kfree(msft);                    ...(3) <- msft is freed.

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x8f/0xc30 kernel/locking/mutex.c:752
Read of size 8 at addr ffff888106cbbca8 by task kworker/u5:2/309

CPU: 0 PID: 309 Comm: kworker/u5:2 Not tainted 6.9.0-rc5+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci4 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x140 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x191/0x560 mm/kasan/report.c:488
 kasan_report+0xe2/0x120 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0x8f/0xc30 kernel/locking/mutex.c:752
 mutex_lock_nested+0x1f/0x30 kernel/locking/mutex.c:804
 msft_do_close+0x292/0x700 net/bluetooth/msft.c:694
 hci_dev_close_sync+0x906/0xf10 net/bluetooth/hci_sync.c:5168
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_error_reset+0x152/0x410 net/bluetooth/hci_core.c:1091
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
 worker_thread+0x926/0xe70 kernel/workqueue.c:3416
 kthread+0x2e3/0x380 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 7328:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x20c/0x3e0 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 msft_register+0x66/0x1d0 net/bluetooth/msft.c:760
 hci_register_dev+0x85e/0x9a0 net/bluetooth/hci_core.c:2737
 __vhci_create_device drivers/bluetooth/hci_vhci.c:438 [inline]
 vhci_create_device+0x390/0x720 drivers/bluetooth/hci_vhci.c:480
 vhci_get_user drivers/bluetooth/hci_vhci.c:537 [inline]
 vhci_write+0x39b/0x460 drivers/bluetooth/hci_vhci.c:617
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x8eb/0xb50 fs/read_write.c:590
 ksys_write+0x106/0x1f0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x84/0xa0 fs/read_write.c:652
 x64_sys_call+0x271a/0x2ce0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x9c/0x130 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 7332:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:579
 poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x13c/0x330 mm/slub.c:4390
 msft_unregister+0x9d/0x120 net/bluetooth/msft.c:785
 hci_unregister_dev+0x1d9/0x520 net/bluetooth/hci_core.c:2771
 vhci_release+0x8c/0xe0 drivers/bluetooth/hci_vhci.c:674
 __fput+0x36f/0x750 fs/file_table.c:422
 ____fput+0x1e/0x30 fs/file_table.c:450
 task_work_run+0x1da/0x280 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x856/0x2210 kernel/exit.c:878
 do_group_exit+0x201/0x2c0 kernel/exit.c:1027
 get_signal+0x12ff/0x1380 kernel/signal.c:2911
 arch_do_signal_or_restart+0x3b/0x650 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xcc/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xa8/0x130 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888106cbbc00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 168 bytes inside of
 freed 256-byte region [ffff888106cbbc00, ffff888106cbbd00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106cba
head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ffffe0000840(slab|head|node=0|zone=2|lastcpupid=0x3fffff)
page_type: 0xffffffff()
raw: 0017ffffe0000840 ffff888100042040 ffffea00042de590 ffffea00041b3e10
raw: 0000000000000000 00000000000a000a 00000001ffffffff 0000000000000000
head: 0017ffffe0000840 ffff888100042040 ffffea00042de590 ffffea00041b3e10
head: 0000000000000000 00000000000a000a 00000001ffffffff 0000000000000000
head: 0017ffffe0000001 ffffea00041b2e81 dead000000000122 00000000ffffffff
head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888106cbbb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888106cbbc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888106cbbc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888106cbbd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888106cbbd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Thanks,
Sungwoo.

Fixes: 9e14606d8f38 ("Bluetooth: disable advertisement filters during suspend")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2: Move BT_DBG after null checking in msft_data_hold_unless_zero().
v2 -> v3: Make a msft lifetime fit hdev.

 net/bluetooth/hci_core.c | 3 +--
 net/bluetooth/msft.c     | 2 +-
 net/bluetooth/msft.h     | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7028d38c..bc5086423 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2768,8 +2768,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_unregister_suspend_notifier(hdev);
 
-	msft_unregister(hdev);
-
 	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
@@ -2823,6 +2821,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
 	hci_codec_list_clear(&hdev->local_codecs);
+	msft_release(hdev);
 	hci_dev_unlock(hdev);
 
 	ida_destroy(&hdev->unset_handle_ida);
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 9612c5d1b..d039683d3 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -769,7 +769,7 @@ void msft_register(struct hci_dev *hdev)
 	mutex_init(&msft->filter_lock);
 }
 
-void msft_unregister(struct hci_dev *hdev)
+void msft_release(struct hci_dev *hdev)
 {
 	struct msft_data *msft = hdev->msft_data;
 
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 2a63205b3..cc438db09 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -14,7 +14,7 @@
 
 bool msft_monitor_supported(struct hci_dev *hdev);
 void msft_register(struct hci_dev *hdev);
-void msft_unregister(struct hci_dev *hdev);
+void msft_release(struct hci_dev *hdev);
 void msft_do_open(struct hci_dev *hdev);
 void msft_do_close(struct hci_dev *hdev);
 void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb);
-- 
2.34.1


