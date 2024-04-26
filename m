Return-Path: <linux-kernel+bounces-159625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283738B313D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32BB283085
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214613BC2B;
	Fri, 26 Apr 2024 07:20:29 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86888210FF;
	Fri, 26 Apr 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116028; cv=none; b=SHXRomEqgcc8rzMdngwTqMYQ5Pehfc/uLkDHLhC+lg22c7ijcdKfv85SGLaMx6friQMznFCYihQ+InfiJioKQBvCD+cLdf+DgM9/vu8jW324STJkmgBCrgD6RjaWRzfnTlOXOUU8qK2I8WgnkurN3dG/der2kBe+i9Qqcgm5vCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116028; c=relaxed/simple;
	bh=ZLkgAm7OrwCtlXsltCwfJqKUmyX5N3G73Ksssl3/2mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=md/shAHlqC+76ifLQnneRMV6PfNlfaqQXteh3eIPK/u1mVHoXDIH4PSyXURWbq+fg8Vl3as9bwFhsn/f0Fl/hD6WaQovwRbFche5K3uCLIPCz3jrQCbH13Qd3qqTgH4Tz8K853QKIHD9kfny1+zxzJ7GkwSXC6hHUTe66Agq6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a071595d22so9871096d6.3;
        Fri, 26 Apr 2024 00:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116025; x=1714720825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRvU0xUlHTJYvKA7qTgsZecNFP1QfgtH2vvFVAr0EAk=;
        b=Eh5VPMapYPfQ2mXbVy+lCJxqolzBLFXy6fUSgvJjJCIbMmxf5Znco7Rx2ocmQN+JT6
         5ii3oaC66w7uODUq3hJkI9ZWFz16oLxit2Rx0CGvopDLS4cOvqWn573RcGfg2/ZCyX1J
         HYwOiIQ65v4UWgdt+MiIx26YpoTlRmFLj2jL2QqclWz1kIi/IFI4mwNV4y1yhZPz/Twd
         QbpIfgosZbTRB+8uMhgn1GK8x+iPrc4hGD/2oR5wdmzQjMVTaA3R7hDNq0xiBi+bNwQN
         zUNAycQqrgD6oCyWXu4dPYc2nwBaTy5xrh0dbfjmWju39xqb2T2HQXGsF4WBBa3I+M/p
         /g6g==
X-Forwarded-Encrypted: i=1; AJvYcCXkBpp4s6pzu4ZXhMQdHHOifZGOXPFsb+2qSpS/s94sN+3QvriPUzDMflxx7DaG1PNi70oc6a63mNrcz4UMG3xvkPCAyp4MJ2P1U5VZZf3zjXcOD6oOUwjdgHXEfZpwODBeC+c+4gzoHc5Ehu9P
X-Gm-Message-State: AOJu0YwD730GCudX9Cjzh8u4Zzn0WK4qZGgiUilVRSh1dcTWJntb6E5V
	LZ59Nz5XyNNgFN0bE0or0omQ1SUIJTi0BTMUKh7fNgusAeWOQzAr
X-Google-Smtp-Source: AGHT+IEynjR4BjT04NoxHWMoNQmwIYnX9UW30F3lzWXty1YYzgV3BFuW8OiGdCB85rdrtlc7nBZB4w==
X-Received: by 2002:a05:6214:48b:b0:6a0:57f1:c536 with SMTP id pt11-20020a056214048b00b006a057f1c536mr2404970qvb.10.1714116024935;
        Fri, 26 Apr 2024 00:20:24 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id l2-20020a056214028200b006a0afa5bce3sm222036qvv.55.2024.04.26.00.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:20:24 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
Date: Fri, 26 Apr 2024 03:20:05 -0400
Message-Id: <20240426072006.358802-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, could you review a bug and its fix?

This is a racy bug. Call stack is as below:

[free]
l2cap_conn_del
┌ mutex_lock(&conn->chan_lock);
│ foreach chan in conn->chan_l:            ... (2)
│   l2cap_chan_put(chan);
│     l2cap_chan_destroy
│       kfree(chan)                        ... (3)
└ mutex_unlock(&conn->chan_lock);

[use]
l2cap_bredr_sig_cmd
  l2cap_connect
  ┌ mutex_lock(&conn->chan_lock);
  │ chan = pchan->ops->new_connection(pchan); // alloc chan
  │ __l2cap_chan_add(conn, chan);
  │   l2cap_chan_hold(chan);
  │   list_add(&chan->list, &conn->chan_l);   ... (1)
  └ mutex_unlock(&conn->chan_lock);
    chan->conf_state // uaf at chan           ... (4)

To fix this, this patch holds and locks the l2cap channel.

Thanks,
Sungwoo.

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x5dc/0x830 net/bluetooth/l2cap_core.c:968
Read of size 1 at addr ffff88810b62c274 by task kworker/0:1/10

CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.8.0+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x18f/0x560 mm/kasan/report.c:488
 kasan_report+0xd7/0x110 mm/kasan/report.c:601
 __asan_report_load1_noabort+0x18/0x20 mm/kasan/report_generic.c:378
 l2cap_send_cmd+0x5dc/0x830 net/bluetooth/l2cap_core.c:968
 l2cap_send_conn_req net/bluetooth/l2cap_core.c:1286 [inline]
 l2cap_start_connection+0x25e/0x530 net/bluetooth/l2cap_core.c:1514
 l2cap_conn_start+0x952/0xe60 net/bluetooth/l2cap_core.c:1661
 l2cap_info_timeout+0x5f/0x90 net/bluetooth/l2cap_core.c:1807
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 290:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x228/0x4d0 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 hci_alloc_dev_priv+0x30/0x1ea0 net/bluetooth/hci_core.c:2468
 hci_alloc_dev include/net/bluetooth/hci_core.h:1651 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:406 [inline]
 vhci_create_device+0x10e/0x710 drivers/bluetooth/hci_vhci.c:480
 vhci_get_user drivers/bluetooth/hci_vhci.c:537 [inline]
 vhci_write+0x398/0x460 drivers/bluetooth/hci_vhci.c:617
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x9ee/0xd40 fs/read_write.c:590
 ksys_write+0x103/0x1f0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x84/0xa0 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x84/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Freed by task 1158:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
 poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x106/0x2e0 mm/slub.c:4409
 hci_release_dev+0x1114/0x1250 net/bluetooth/hci_core.c:2799
 bt_host_release+0x77/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0xa4/0x1d0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f1/0x410 lib/kobject.c:737
 put_device+0x28/0x40 drivers/base/core.c:3747
 hci_free_dev+0x25/0x30 net/bluetooth/hci_core.c:2594
 vhci_release+0x91/0xe0 drivers/bluetooth/hci_vhci.c:675
 __fput+0x35b/0x740 fs/file_table.c:376
 ____fput+0x1e/0x30 fs/file_table.c:404
 task_work_run+0x1d9/0x270 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x823/0x23e0 kernel/exit.c:871
 do_group_exit+0x1f1/0x2b0 kernel/exit.c:1020
 get_signal+0x1387/0x14d0 kernel/signal.c:2893
 arch_do_signal_or_restart+0x3b/0x650 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x71/0x180 kernel/entry/common.c:212
 do_syscall_64+0x90/0x120 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Last potentially related work creation:
 kasan_save_stack+0x2f/0x50 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xc6/0xe0 mm/kasan/generic.c:551
 kasan_record_aux_stack_noalloc+0xf/0x20 mm/kasan/generic.c:561
 insert_work+0x3a/0x1d0 kernel/workqueue.c:1653
 __queue_work+0xa5b/0xdc0 kernel/workqueue.c:1806
 queue_work_on+0x74/0xa0 kernel/workqueue.c:1837
 queue_work include/linux/workqueue.h:548 [inline]
 hci_recv_frame+0x375/0x490 net/bluetooth/hci_core.c:2947
 hci_reset_dev+0x126/0x170 net/bluetooth/hci_core.c:2904
 hci_ncmd_timeout+0xb1/0xd0 net/bluetooth/hci_core.c:1525
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Second to last potentially related work creation:
 kasan_save_stack+0x2f/0x50 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xc6/0xe0 mm/kasan/generic.c:551
 kasan_record_aux_stack_noalloc+0xf/0x20 mm/kasan/generic.c:561
 insert_work kernel/workqueue.c:1653 [inline]
 __queue_work+0x8cf/0xdc0 kernel/workqueue.c:1802
 delayed_work_timer_fn+0x6a/0x90 kernel/workqueue.c:1931
 call_timer_fn+0x44/0x240 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1746 [inline]
 __run_timers+0x63a/0x870 kernel/time/timer.c:2038
 run_timer_softirq+0x26/0x40 kernel/time/timer.c:2051
 __do_softirq+0x180/0x523 kernel/softirq.c:553

The buggy address belongs to the object at ffff88810b62c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 628 bytes inside of
 freed 8192-byte region [ffff88810b62c000, ffff88810b62e000)

The buggy address belongs to the physical page:
page:000000007f8eb4fe refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10b628
head:000000007f8eb4fe order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000840 ffff888100042280 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810b62c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810b62c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810b62c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88810b62c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810b62c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862..a8f414ab8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3953,6 +3953,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (!chan)
 		goto response;
 
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+
 	/* For certain devices (ex: HID mouse), support for authentication,
 	 * pairing and bonding is optional. For such devices, inorder to avoid
 	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
@@ -4041,6 +4044,11 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		chan->num_conf_req++;
 	}
 
+	if (chan) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+	}
+
 	return chan;
 }
 
-- 
2.34.1


