Return-Path: <linux-kernel+bounces-157986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD98B19D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33951F21C48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF337153;
	Thu, 25 Apr 2024 04:12:30 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22E2C19B;
	Thu, 25 Apr 2024 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018349; cv=none; b=YQ8YizjU8rHd2xeYkZvxkHuWKyJkQgHKwdG58GTxjjcWt239koYZgbstWVPQfUETTN7r+wDZil7N6ESIWZs2w1rw1LdvMFebevaiqT50nbMPaie+hA+Gni0g6MyHTfedW3iCt6IytgOZ1b41uycd20rX9vup7Ug5AKn7C05b1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018349; c=relaxed/simple;
	bh=1mzDkZX5bXT6Wc5rb9fmiee8ixdgpwFUp2aEI6Dky1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P5pCj9YbvGKWb+vlgzXT8Q0ykkoA3b5RMQ2fzowskgXL9A2AH4U4CI5ZzSvsWeLF3DWfOM45Se2kGaPCyUK7jqrKorJ9MRs/NhEN9no7HOPX57L2puoPa8pWk5VCSzcFOhY0/LSMhgrNG9xfj7HpGr/kjt0/89fLTQPC0th4mow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78ef9ce897bso34671485a.0;
        Wed, 24 Apr 2024 21:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714018347; x=1714623147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nz58B2BArph5KjkUizmtOZEUPa0UxmILdIhhLFp9PbQ=;
        b=Ys0R5D9ml5G8ZH5jfUMaByCfRoC6950XjOEwv1MhIG82u0ZOiZ4GGogwS0OvDvVs8W
         dcV5DpAdZA3h0GXh2BEDVVwHtpZ0A/LnXUoSODqfpQJgTXHWoCxO9okrG0a3wHH4wMv3
         4afWWEa5NrrSR7yJVwJVFLTIAYjcn5R5ThY3zuuU+fLdb3gHRn2MnhRamWvU+uHYcNSY
         mVIMah3K10a+r2MTpKzH2+VPyI+/VCJ6FI2XQQtj4kMSy0Ykcl/vzOdYbSYOCKJG3DA1
         oM0ewZRXbmbfKcZ9hvnp1rOWFmQ+0Ld7URuKWeWPIWsK4LPud44HBqctnwKtf04axRko
         vEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUAv5pWc6pgWhAjV45F+BNkyZw+IbSvOFLo8Pvga5QzLIYYWan1K33HylawoZKvCjWI3rRAex7EAYU0mHvLcyhL2sO3RNT7A4wTVqKGPLTSC5eYbpJnp4r+Kr5K2O3ZyJHOB+keWkPB9bf/SZPj
X-Gm-Message-State: AOJu0YzSrWpnVBcOyvGgjGZDqdyKjTxUmcMPcfp4Nhz6aV0MV+qDjuLy
	Hx0aTDZW20MpvX7RNP2SO6HwEeZKEfxdltXRB9ZieCr55Hl082tD1DqCGAKN
X-Google-Smtp-Source: AGHT+IFkY0pSmtC6kAKrup5kiZOiYxX1ia24r1e6pOTjzh9a4IyIVchb+rYhB0HFsFd8MYnRz/eH2w==
X-Received: by 2002:a05:620a:1356:b0:790:9625:d69b with SMTP id c22-20020a05620a135600b007909625d69bmr2279079qkl.62.1714018346733;
        Wed, 24 Apr 2024 21:12:26 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id q24-20020a05620a0c9800b0078d677e72f3sm6718342qki.118.2024.04.24.21.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 21:12:26 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work
Date: Thu, 25 Apr 2024 00:11:28 -0400
Message-Id: <20240425041128.3093970-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, could you review the UAF bug and its fix?
The stack trace is at the bottom.

mgmt sync cmd could be used after freed in this scenario:

set_local_name()       ... cmd is allocated, set_name_complete() is
                           queued in cmd_sync_work.
hci_error_reset()      ... hci device reset.
  hci_dev_close_sync() ... close hdev, at this point, cmd is freed.
set_name_complete()    ... callback from cmd_sync_work. cmd->param causes UAF.

To fix this, this patch makes hci_dev_close_sync() call hci_cmd_sync_clear() to clear the cmd_sync_work.

Thanks,
Sungwoo Kim.

==================================================================
BUG: KASAN: slab-use-after-free in set_name_complete+0x4a/0x330 net/bluetooth/mgmt.c:3815
Read of size 8 at addr ffff888107259098 by task kworker/u3:0/66

CPU: 0 PID: 66 Comm: kworker/u3:0 Not tainted 6.8.0+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x18f/0x560 mm/kasan/report.c:488
 kasan_report+0xd7/0x110 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
 set_name_complete+0x4a/0x330 net/bluetooth/mgmt.c:3815
 hci_cmd_sync_work+0x269/0x3e0 net/bluetooth/hci_sync.c:308
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 308:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 mgmt_pending_new+0x6f/0x230 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x3f/0x120 net/bluetooth/mgmt_util.c:296
 set_local_name+0x15a/0x4c0 net/bluetooth/mgmt.c:3892
 hci_mgmt_cmd+0xb79/0x1190 net/bluetooth/hci_sock.c:1715
 hci_sock_sendmsg+0x63a/0xf00 net/bluetooth/hci_sock.c:1835
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x227/0x270 net/socket.c:745
 sock_write_iter+0x28d/0x3d0 net/socket.c:1160
 do_iter_readv_writev+0x331/0x4c0
 vfs_writev+0x2e6/0xa40 fs/read_write.c:971
 do_writev+0xfd/0x250 fs/read_write.c:1018
 __do_sys_writev fs/read_write.c:1091 [inline]
 __se_sys_writev fs/read_write.c:1088 [inline]
 __x64_sys_writev+0x86/0xa0 fs/read_write.c:1088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x84/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Freed by task 66:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
 poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x106/0x2e0 mm/slub.c:4409
 mgmt_pending_free net/bluetooth/mgmt_util.c:309 [inline]
 mgmt_pending_remove+0x19e/0x1d0 net/bluetooth/mgmt_util.c:315
 cmd_complete_rsp+0x104/0x1a0
 mgmt_pending_foreach+0xc7/0x120 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x137/0x370 net/bluetooth/mgmt.c:9496
 hci_dev_close_sync+0x4ab/0xe80 net/bluetooth/hci_sync.c:4953
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_error_reset+0x150/0x410 net/bluetooth/hci_core.c:1060
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888107259080
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888107259080, ffff8881072590e0)

The buggy address belongs to the physical page:
page:000000006bdb81a5 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888107259280 pfn:0x107259
flags: 0x17ffffc0000a00(workingset|slab|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000a00 ffff888100041780 ffffea0004145510 ffffea0004240190
raw: ffff888107259280 000000000020000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888107258f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888107259000: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888107259080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888107259100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888107259180: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_core.c | 2 --
 net/bluetooth/hci_sync.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7028d38c..c347efc4f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2764,8 +2764,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
-	hci_cmd_sync_clear(hdev);
-
 	hci_unregister_suspend_notifier(hdev);
 
 	msft_unregister(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c5d879904..aa8e0c33c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5181,9 +5181,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-	/* flush cmd  work */
+	/* flush cmd work */
 	flush_work(&hdev->cmd_work);
 
+	/* flush cmd sync work */
+	hci_cmd_sync_clear(hdev);
+
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
-- 
2.34.1


