Return-Path: <linux-kernel+bounces-163414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3818B6A87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F1282A33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD3318E1C;
	Tue, 30 Apr 2024 06:35:58 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF81FB4;
	Tue, 30 Apr 2024 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458958; cv=none; b=OAPhikTN9MJfeTWgoPvhzCsDvBrjwiLoFWwrqUCVA1ATVIYCI0a0Icc9wnjbSv6SnzhveAwMyJy960NRPViuTQNnWedjxtBgaiuODYW9+1tcBI4aKUNbYpPJPSo8m73gny3MvbL30zVoePL8QI8GCYjFG+ocoklWS+k66ZNh3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458958; c=relaxed/simple;
	bh=GSCsAwQWzg24QibiFvvxjkxi1CHyl26VooRorm2KiA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XAWgTOm5GXyPQ1d0eO3w4X2L7dMi1zRcmuzjUX0YmVfNL1fLQH9nFfZAx5hwgAeyocbI9x3WfrkGEuVRAf6BVjWEJ3qbnC+EGCGEG+xX8H5v6Zs+0LcHlSpifuFjJftxH7Pgm7owLYk1GUYw5i6FfspsFsclTFQY5CBDOhC+BlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-617f8a59a24so47788477b3.1;
        Mon, 29 Apr 2024 23:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714458955; x=1715063755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUfOdWiuxq2xU9KRdAfdK1cxDmTrZ5hz+dVQewL3/OM=;
        b=ODyVKBGw+bGORB5ne7XKKPevDcHXJzwU3oKEo8hIoc9PhlaS9TulusmIP1eAW/43/S
         M1Cr261MHkyTOSv8f6iLR/loVxHF2hXNYJbHf7beaalLkMNIbt05OweR+6lnkZER0+Lk
         /T3qigo/RWMCTuDyLu5ouk8WmeI8MAYeYGRES0Nmbtak8Nh5X3Hf23Wsj/g0wmmU+3iI
         5reiskx7SOCHCiVq+48GNNMrqwGl07rzLwJ4109fOKviFHeobXrP3HD20fcAaW7Kp7y3
         BvTJ1fxd0bvPJDJCDTBgNm9VdQDI1N/kX3vI2ttO7+jvFYzYJcKnToMtLn4sIFaqGx29
         VMuw==
X-Forwarded-Encrypted: i=1; AJvYcCV9K4mBwfF4jA39dUVPZKf3L0eBgMAh45fACqzcj0kP5DQlvHecX2RNtJ4B3O+k5D0UeRAyqZIPfJdOZQIGOuNC8qA1b2fPHD40Ij+VVHID2Rna7Tn0KzIxbJreh77GbdjvAe8zi+s+qk0sO/C/
X-Gm-Message-State: AOJu0YxhmvrhD3JjO9m13UP5IAOQC8HeyZIkTaqiaYPSVe83c1L1YuFp
	vwI2FTVhXC/C5ZQGSSumbtHLPhtau7aYwOGQmCxGPOmBDKEvLzxWifGLQZP76ec=
X-Google-Smtp-Source: AGHT+IGMnsVzdq3tLKR/4rH6Vf/QXtpWsnvHCDgmSRLxu2qhWPxoHiGibtszq7hNdhIDKdlWiJ9pmg==
X-Received: by 2002:a05:690c:6407:b0:618:8e3e:8675 with SMTP id hr7-20020a05690c640700b006188e3e8675mr12632821ywb.22.1714458955021;
        Mon, 29 Apr 2024 23:35:55 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id hd21-20020a05622a299500b0043c58b6d941sm245816qtb.42.2024.04.29.23.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:35:54 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	dan.carpenter@linaro.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
Date: Tue, 30 Apr 2024 02:32:10 -0400
Message-Id: <20240430063209.584244-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend a critical section to prevent chan from early freeing.
Also make the l2cap_connect() return type void. Nothing is using the
returned value but it is ugly to return a potentially freed pointer.
Making it void will help with backports because earlier kernels did use
the return value. Now the compile will break for kernels where this
patch is not a complete fix.

The patch is copied from
https://gist.github.com/Vudentz/c0c09ca0eff64a32ca50b1a6eb41295d

Thank you for your help, Dan and Luiz.

Call stack summary:

[use]
l2cap_bredr_sig_cmd
  l2cap_connect
  ┌ mutex_lock(&conn->chan_lock);
  │ chan = pchan->ops->new_connection(pchan); <- alloc chan
  │ __l2cap_chan_add(conn, chan);
  │   l2cap_chan_hold(chan);
  │   list_add(&chan->list, &conn->chan_l);   ... (1)
  └ mutex_unlock(&conn->chan_lock);
    chan->conf_state              ... (4) <- use after free

[free]
l2cap_conn_del
┌ mutex_lock(&conn->chan_lock);
│ foreach chan in conn->chan_l:            ... (2)
│   l2cap_chan_put(chan);
│     l2cap_chan_destroy
│       kfree(chan)               ... (3) <- chan freed
└ mutex_unlock(&conn->chan_lock);

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect+0xa67/0x11a0 net/bluetooth/l2cap_core.c:4260
Read of size 8 at addr ffff88810bf040a0 by task kworker/u3:1/311

CPU: 0 PID: 311 Comm: kworker/u3:1 Not tainted 6.8.0+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x18f/0x560 mm/kasan/report.c:488
 kasan_report+0xd7/0x110 mm/kasan/report.c:601
 kasan_check_range+0x262/0x2f0 mm/kasan/generic.c:189
 __kasan_check_read+0x15/0x20 mm/kasan/shadow.c:31
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 l2cap_connect+0xa67/0x11a0 net/bluetooth/l2cap_core.c:4260
 l2cap_bredr_sig_cmd+0x17fe/0x9a70
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
 l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
 l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
 hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
 hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 311:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 l2cap_chan_create+0x59/0xc80 net/bluetooth/l2cap_core.c:466
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1849 [inline]
 l2cap_sock_new_connection_cb+0x14d/0x2a0 net/bluetooth/l2cap_sock.c:1457
 l2cap_connect+0x329/0x11a0 net/bluetooth/l2cap_core.c:4176
 l2cap_bredr_sig_cmd+0x17fe/0x9a70
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
 l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
 l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
 hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
 hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

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
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:509 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x1e7/0x2b0 net/bluetooth/l2cap_core.c:533
 l2cap_conn_del+0x38e/0x5f0 net/bluetooth/l2cap_core.c:1929
 l2cap_connect_cfm+0xc2/0x11e0 net/bluetooth/l2cap_core.c:8254
 hci_connect_cfm include/net/bluetooth/hci_core.h:1986 [inline]
 hci_conn_failed+0x202/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x913/0xae0 net/bluetooth/hci_sync.c:5359
 abort_conn_sync+0xda/0x110 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x20d/0x3e0 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88810bf04000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 160 bytes inside of
 freed 1024-byte region [ffff88810bf04000, ffff88810bf04400)

The buggy address belongs to the physical page:
page:00000000567b7faa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10bf04
head:00000000567b7faa order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000840 ffff888100041dc0 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810bf03f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810bf04000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810bf04080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88810bf04100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810bf04180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 73ffa904b782 ("Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V1 -> V2:
Make l2cap_connect() return void.
Fix a wrong stack trace attached.

V2 -> V3:
Extend a lock instead of additional hold and lock

 net/bluetooth/l2cap_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862..eeba16f69 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3902,13 +3902,13 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
-static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
+static void l2cap_connect(struct l2cap_conn *conn,
 					struct l2cap_cmd_hdr *cmd,
 					u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan = NULL, *pchan;
+	struct l2cap_chan *chan = NULL, *pchan = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3921,7 +3921,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
-		goto sendresp;
+		goto response;
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -4008,17 +4008,15 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
-	l2cap_chan_put(pchan);
-
-sendresp:
 	rsp.scid   = cpu_to_le16(scid);
 	rsp.dcid   = cpu_to_le16(dcid);
 	rsp.result = cpu_to_le16(result);
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
+	if (!pchan)
+		return;
+
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
 		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -4041,7 +4039,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		chan->num_conf_req++;
 	}
 
-	return chan;
+	l2cap_chan_unlock(pchan);
+	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 }
 
 static int l2cap_connect_req(struct l2cap_conn *conn,
-- 
2.34.1


