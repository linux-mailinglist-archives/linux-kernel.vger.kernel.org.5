Return-Path: <linux-kernel+bounces-126021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CB893107
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287981F21AD0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C00757F2;
	Sun, 31 Mar 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XF0AosOb"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593B2566;
	Sun, 31 Mar 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876421; cv=none; b=jrE0Hh2qoWsWEviZy56wOqJmQe4ffzOYVu6l5Z4QIC0lS+aCdcVjv4zHauYh859uaMBGXpkCi2dEAApkS59Qm1OLn5DqNPigC0DHj7wdZpQpVYdJCYmQRijfNgpLW6/HGFTKBMkw9RzX2EN8+k/2JuwIx1hZp55DZhb53K6PQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876421; c=relaxed/simple;
	bh=URZZQA/UsjF8TDofFtYm9xwej0CTQ94jvZTX+onlnNg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DJFHIr73jzN9rOCuJNg6PTpXoJT4rB6xqgshp1Aya2KOr8lD+TweHonTrcNsxVclupAYwBTqQsfg2SUFy9Gf/rp2A97mGsLfzD7aU/XIpJYpld7YcBqQs56ZminlVyqBlUYlVc82yBc/rr2LZevLMml/TQsHzHL1aYyEJHbHQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XF0AosOb; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711876110; bh=tASjp8lJUpJEZx3sAkmUo22xXVvda6wOyY7V9EO7ejI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XF0AosObMyBAPh2ztKjbpxduCwg7jjxEZLUClt1DlwKADxPkQd5p7YYCm+DGZDx24
	 03pBUR5RkIjTrzZ2+ZzQ+6tmsPeGmHXhD4jOmzN0J4qUmo7u6pZFlNuNvO46vNb4bZ
	 lDgJgUCHQTpDNmsORXHK62fSS//q8FCjMWTjRm3A=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 2199F432; Sun, 31 Mar 2024 17:08:25 +0800
X-QQ-mid: xmsmtpt1711876105tybdq5a2s
Message-ID: <tencent_EF4FAF8DF125F00D8D9237DDCC5DE9990307@qq.com>
X-QQ-XMAILINFO: OW4JjO7DsStBo6TnSWuB8Ghjp46kAIOnnPypeixM/fzzCJAodtnD3zjJ1EsFme
	 gerDP5cOYU04ab7ZEsVoCibndeff1JcDA4ZjCwY05tFC9M+aIMs6b4jrlEa84YGwGUysP0zq0jxU
	 dtGCsCZ98Z0SmZYMvvSxdvhfdMKdPA2WkAkbDTJanotrz8hqW6eeM5MCUvLVL8BHQx+9bTBQ/Sw5
	 +TrrqiPqtcm64DwK4bxanakSMW5fKZfQ4W39dl64wY2mHy705gvT8OZWcqEk2nguNbstlJYCxKdJ
	 ZoGAJbzHyQjbIxxg72YFWdT5BFToHMEenYf6ENFARD64zh130AaSDBlXykaSshNBYkfmWPnPygB3
	 0e3QGrbdiwdQk2mr86ELL2NdjrjiIpvrN5uPEJMFdvuH/tnzkEwQDKC1klG3vkdS/e4RBQIxw71I
	 gRzyt6XQ/USZ9i73TauWcZb6b078FRGO1mQOdbRgV+xaiKDM6iKN/ke4jO9AbNtKO9vTU8dBcRZf
	 2pT37EvI/hiuaYoPD5w2mvgjAOxQbob11F5HVtZ5s4MdDuApeqHyvAKncEVAjEvlyrqW/lOeGlCh
	 BhfjDH1fkTW3qsg+y0QdVLYQelji/xDQO6M4bfqG9vKgFIyF/unsmEg4+z6Q6jGG3ib36ON3jxjU
	 YU8na32tDGF0ylxOVJe1Ldq9e2o9lI1joMq7D6m497W0kTCTNaaKvyquVns4grGpPx5ZQ6M4qqGa
	 da6s5ZG+2+R2n02TRorOnbmVGuCbXxoyN8TaDPI2sdMAXe9SmHQNHIzgunCUCle5C7I6Xq856LY6
	 LcUF6sLjUwnPPifgX5w+lphOoQV4kdqx/QNC4n8UORiarnCuDZbGLPU5flY5zFi242LhYl3FGG87
	 V9Un1gl+/+j5QneVoIn83RA7bqH8O/3sR3JXoSSxt+Gr2XjTjKbVoPgYZ2a9E+yGG5lDDrWZwIeB
	 n7Txtpq/jVuXGLGn0JQuBsXLsGtnXgY64q3p4jXfVPwbd40tOigA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: fix null ptr deref in dev_map_enqueue
Date: Sun, 31 Mar 2024 17:08:26 +0800
X-OQ-MSGID: <20240331090825.1150558-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
References: <00000000000069ee1a06149ff00c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5179 Comm: syz-executor120 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 e6 45 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 d0 8b 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc90003b0f688 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888025258000
RDX: 0000000000000000 RSI: ffff888024035070 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff55e
R10: 0000000000000004 R11: ffff888025258000 R12: ffff8880157d8000
R13: ffff888024035070 R14: dffffc0000000000 R15: ffff8880b943c088
FS:  00007fd0098e46c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200009c0 CR3: 0000000025314000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
 xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
 xdp_test_run_batch net/bpf/test_run.c:336 [inline]
 bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd00992a0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd0098e4238 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fd0099b43e8 RCX: 00007fd00992a0d9
RDX: 0000000000000050 RSI: 0000000020000240 RDI: 000000000000000a
RBP: 00007fd0099b43e0 R08: 00007fd0098e46c0 R09: 00007fd0098e46c0
R10: 00007fd0098e46c0 R11: 0000000000000246 R12: 00007fd009981060
R13: 0000000000000016 R14: 00007fffcb70c160 R15: 00007fffcb70c248
 </TASK>
[Fix]
On the execution path of bpf_prog_test_run(), due to ri->map being NULL, 
ri->tgtvalue was not set correctly.

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/devmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4e2cdbb5629f..ef20de14154a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -86,6 +86,7 @@ struct bpf_dtab {
 static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
+static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf);
 
 static struct hlist_head *dev_map_create_hash(unsigned int entries,
 					      int numa_node)
@@ -536,7 +537,10 @@ int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	struct net_device *dev = dst->dev;
+	struct net_device *dev;
+	if (!is_valid_dst(dst, xdpf))
+		return -EINVAL;
+	dev = dst->dev;
 
 	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
 }
-- 
2.43.0


