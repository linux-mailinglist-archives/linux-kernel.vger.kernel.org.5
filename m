Return-Path: <linux-kernel+bounces-159700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D78B327F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9566F1F21609
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339312BEBF;
	Fri, 26 Apr 2024 08:30:09 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0213D500;
	Fri, 26 Apr 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120209; cv=none; b=dGKxzRtE6Kv+DmROn2FFjS5/+HUwStqmLd7OyVqLPDl6L18h3PrAQ9/8PmExSP2Lj7a1vfkTiRZhaQn/8J7rGMxXXj5PMwcQrLoSQxOtwqtg3/PrN2h7kI2r4o4xQVM88AvwmZvmn/9uuDTJeyED6GX5k2zgkP6bsuVmAKVDgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120209; c=relaxed/simple;
	bh=UT2Hldt1LuQTSgRr14exJitTjr6r/cfxQnA6xIPcQS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsT+fcFREzB5m+BNM/auXqD4pBIHWmmw+WEJFOLABMFrO6Sa+RKjOWtl3Rq9P76tTYuvRVNWqvA3pQJftc7OKETd1zHS3WKXS3N9Hg3Y+Q0qOky3wlkOCjh3Kk5FcsxKZ9PmQWVFR9xnu4Fxeec1G9picLGnwFp42aZG5kkivaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f031a4442so125183685a.2;
        Fri, 26 Apr 2024 01:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120206; x=1714725006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlRgvTBOhR4xmp+o/7NX7NdeoYPh3aEgHRcyNE9xJSY=;
        b=Hu759ZcPKVPePDzQehiTdOXjCi/NpY0OsHVRim8GYQiseIJrTKfzf3TCfp4vfmEx53
         8qdpb5wptQunCXiwSo9huF3US9hNt0mIGV9zGpjNl6arsYhOkX/x8km9xib5hduVfjuT
         CgMjX9i/BNf65BdPLgC9xFdPQC8SK19QupCuajFYEHrIE8RHW3UESgZTRBxhBC3r5eVT
         45znkHGeMrtDJ57mn8AEXTxTJr+WfgjrS/PqsbSqhSIioK50JsEoUydJ3jN2fZbMORfv
         0fV5xvYFRIjRdHWCX262iSmONkydAS4ITy9lD1FkukpJUbum8676HN/t5FoSGlp/nvxj
         FpiA==
X-Forwarded-Encrypted: i=1; AJvYcCV0jO0IIf6RpNcDKbV7/WDEwCATJ1lo2R8PeU2qdRsdfHfQzqDyFXUVYJ6eBF1KKUtCqqw/x4/f7b0DToHAmuIJs7ffcTLryZBVbPT779GLtN21pPhxK4fctxhuMWfUm0/ytKH2oDw/ymGagG1h
X-Gm-Message-State: AOJu0YwovRgpXX81jJrvZG+XoY4Oqx2MaY5k5XF5v2mXotTTD5KC+4lO
	14DEIo0HNiZqPpoGtIDelHfVDFVz2MP3eoYBCcAxDeVt6H9q2SDs
X-Google-Smtp-Source: AGHT+IF1jFj9h1E497HKgSVRM6xZSRLf2x+0daqUz2S4ZE8fAKnVWvH5/lf7SWz4Yp1UUgBuzvFt4g==
X-Received: by 2002:a05:620a:1097:b0:790:9484:2dfc with SMTP id g23-20020a05620a109700b0079094842dfcmr2155521qkk.1.1714120206018;
        Fri, 26 Apr 2024 01:30:06 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a111b00b0078ec3c4452dsm7737582qkk.9.2024.04.26.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:30:05 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: A2MP: fix slab-use-after-free in l2cap_chan_del
Date: Fri, 26 Apr 2024 04:28:53 -0400
Message-Id: <20240426082852.555905-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_set_timer() may potentially dereference chan->conn->hcon->amp_mgr.
However, the timer does not hold amp_mgr, allowing uaf as follows:

l2cap_set_timer()
l2cap_chan_timeout()
  l2cap_chan_close()
    l2cap_chan_del()
      if (mgr && mgr->bredr_chan == chan)  // uaf at mgr->bredr_chan

One patch could be calling amp_mgr_get(chan->conn->hcon->amp_mgr) in l2cap_set_timer().
This will increase refcnt and make mgr alive at l2cap_chan_del().

Unfortunately, amp_mgr_get() is in a2mp.h and l2cap_set_timer() is in l2cap.h.
Including a2mp.h in l2cap.h makes circular (and dirty "../../net/bluetooth/a2mp.h")
dependency because a2mp.h already includes l2cap.h.

So.. as a temporary work, this patch assigns NULL to conn->amp_mgr.
While this makes it less likely to trigger the bug, the bug still can
happen because mgr && mgr->bredr is not atomic.
Could we talk about a better idea?

Also, AMP is removed recently.
The kernel with versions <= v6.8 might have this issue.

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_chan_del+0x31d/0x6b0 net/bluetooth/l2cap_core.c:670
Read of size 8 at addr ffff88810dab7220 by task kworker/0:1/10

CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.8.0+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x18f/0x560 mm/kasan/report.c:488
 kasan_report+0xd7/0x110 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
 l2cap_chan_del+0x31d/0x6b0 net/bluetooth/l2cap_core.c:670
 l2cap_chan_close+0x53c/0x930
 l2cap_chan_timeout+0x10b/0x300 net/bluetooth/l2cap_core.c:452
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 296:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 amp_mgr_create+0x5d/0xd30 net/bluetooth/a2mp.c:854
 a2mp_channel_create+0x60/0x110 net/bluetooth/a2mp.c:894
 l2cap_data_channel net/bluetooth/l2cap_core.c:7676 [inline]
 l2cap_recv_frame+0xbd7/0x86a0 net/bluetooth/l2cap_core.c:7832
 l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
 hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
 hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Freed by task 296:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
 poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x106/0x2e0 mm/slub.c:4409
 amp_mgr_destroy net/bluetooth/a2mp.c:839 [inline]
 kref_put include/linux/kref.h:65 [inline]
 amp_mgr_put+0x16b/0x230 net/bluetooth/a2mp.c:846
 hci_conn_del+0x39d/0xc30 net/bluetooth/hci_conn.c:1179
 hci_phy_link_complete_evt+0x135/0x3d0 net/bluetooth/hci_event.c:5713
 hci_event_func net/bluetooth/hci_event.c:7689 [inline]
 hci_event_packet+0x8e9/0x1290 net/bluetooth/hci_event.c:7741
 hci_rx_work+0x387/0xcb0 net/bluetooth/hci_core.c:4106
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88810dab7200
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 32 bytes inside of
 freed 128-byte region [ffff88810dab7200, ffff88810dab7280)

The buggy address belongs to the physical page:
page:00000000a802fdc8 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810dab7200 pfn:0x10dab7
flags: 0x17ffffc0000a00(workingset|slab|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000a00 ffff8881000418c0 ffffea000410d710 ffffea00041c6e90
raw: ffff88810dab7200 000000000010000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810dab7100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810dab7180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88810dab7200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88810dab7280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810dab7300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a41d2693f..f9b41add1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1175,8 +1175,10 @@ void hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-	if (conn->amp_mgr)
+	if (conn->amp_mgr) {
 		amp_mgr_put(conn->amp_mgr);
+		conn->amp_mgr = NULL;
+	}
 
 	skb_queue_purge(&conn->data_q);
 
-- 
2.34.1


