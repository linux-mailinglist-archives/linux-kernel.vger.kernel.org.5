Return-Path: <linux-kernel+bounces-164860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3F8B840E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB72D282204
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ACC6AB8;
	Wed,  1 May 2024 01:48:00 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0DC12C;
	Wed,  1 May 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528079; cv=none; b=alqkFDI/II/6wPxCgMGdyQwCRIVL/3ZM1E5aSlcveTkzYZm44pM1OWexzWSOOGSONX7JmbZIAOwJMRDeA9Lg+AGgfwSxMnMIXb960tKfG5yh2dHCjCGv1hoIE58odIoazDIYdV8ZiAd7pDSEOVYv0WnxDibBVbEh/ViKjSVuv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528079; c=relaxed/simple;
	bh=yxIEvEI3gwPOvrMXBlqISmkgnIRzLz+KFfrdMpXGras=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJ2jrKbsJ2a54QvLMLkhlT1h8ba3eMW3tM1s3b7TziFy72yoqdom/7XgmphA7eA3kJK1RQuFRAu3tJHjBx/rg/0lSQvfRt3uM4sYiQKr8L7RhNcQf4YffibKXAgS1klNG2frhVm7Dttg3SshRx6g9DE3X4ZIVp7gv/CzFTPanfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78efd533a00so457088985a.0;
        Tue, 30 Apr 2024 18:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714528076; x=1715132876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDxK3B9fBzENvhZ0WvdESiF+BlvZKna8+uOy9nn3XIk=;
        b=eIkOl9YoTkMRTizNGy8U4geBq7jg0tf7usWZ5AnKDm51EzBzwo8PqmjNXmffc6QBII
         Sq/BkjBZKjiW8eVQSKB6x9XrLzkPdpff+w9VmSC5v7r9VFi2oK4ze9ys5D9ZGSb6vr+D
         cs/FJFxC7fh6DQOcEDfAxuZRpS4CJZWp1sSKfAGslkQzbGNgnMJe3iEkE2GK5952n7QQ
         q1VR5m898mdJv9DCITXkoPk4g3+GUCR27M3detJUfHESlECjGV1Qf4wjcJMl9fJbKVEB
         OGMEF1iD8EiuocwGgZ3Kpohk/9PaVDELGnYyQOCw7cRcMtF5GqrvsLIqWv5BdjfYUrXO
         Mzrw==
X-Forwarded-Encrypted: i=1; AJvYcCUx7MM9+Dr6alQFnrrrfi58BlDJ4HoWxjxyHD8qiY+cMQULxyMVmQtzTPNDwkOJXSt2erU0T2ygZKye7Jw8rfmKD91mtyOjUsMB3Z2kFbMpuaz9DWAhuplAmOUYGZGuPQ8mnExS8M1O2d9zcoom
X-Gm-Message-State: AOJu0YwJUIb+yKfnHh+A021V3u50Wn8PMEUkEXk+A25wRnRzIYRYHJu6
	KYsLxTMKXugw94YRFPCBD+bwQrE+aD11cUw1yH93jg9YhpuZOYnG
X-Google-Smtp-Source: AGHT+IHBjLLTy09E6l2gpCjpOSFC+Uqr4sbwdkPcZrjSPHqQVLrjbdr9kVPmxukXOb6oRnL09jtJHQ==
X-Received: by 2002:a05:6214:5016:b0:6a0:d30c:a658 with SMTP id jo22-20020a056214501600b006a0d30ca658mr1197901qvb.11.1714528076300;
        Tue, 30 Apr 2024 18:47:56 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id o5-20020ad443c5000000b0069b61f8c0a1sm3586243qvs.42.2024.04.30.18.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:47:55 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
Date: Tue, 30 Apr 2024 21:43:36 -0400
Message-Id: <20240501014335.2329860-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Luiz, could you revert the v3 patch and apply this?

Fix the use-after-free bug in msft->data by tying the
msft->data lifectime to hdev.
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

Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2: Move BT_DBG after null checking in msft_data_hold_unless_zero().
v2 -> v3: Make a msft lifetime fit hdev.
v3 -> v4:
- Fix a defconfig build failure, adding a missing declaration for
  msft_release()
- Fix a wrong fixes tag.

 net/bluetooth/hci_core.c | 3 +--
 net/bluetooth/msft.c     | 2 +-
 net/bluetooth/msft.h     | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

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
index 2a63205b3..fe538e9c9 100644
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
@@ -35,7 +35,7 @@ static inline bool msft_monitor_supported(struct hci_dev *hdev)
 }
 
 static inline void msft_register(struct hci_dev *hdev) {}
-static inline void msft_unregister(struct hci_dev *hdev) {}
+static inline void msft_release(struct hci_dev *hdev) {}
 static inline void msft_do_open(struct hci_dev *hdev) {}
 static inline void msft_do_close(struct hci_dev *hdev) {}
 static inline void msft_vendor_evt(struct hci_dev *hdev, void *data,
-- 
2.34.1


