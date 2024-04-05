Return-Path: <linux-kernel+bounces-132828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8F899ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98091C20ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE216ABC3;
	Fri,  5 Apr 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ilOJSdeQ"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694527447;
	Fri,  5 Apr 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312992; cv=none; b=gsNJTdD/o0s05z4pXM0T4ZE8wTMqRjrJ0noEf7ex0iKdmYxfhPxgSO9q6XuJkbw0kXji+DffliDkP8hIzV1BszLxIOmwVxySicWuFqxizdN8btaqnzbT+Z8xSw5vMzT3Lcu4kUHrbr4Y3e18RGImfaEuGZGS+0D+bn4ZCS1Njcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312992; c=relaxed/simple;
	bh=BroQavTwVXKhYcOxCeyHgRm5Lf2bnHD/v6yEJjqHO7g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=p3QsL2uvMTB5aXQZrG9pHanbEu97JZkZc9oWbF+HyqA+UyzcVWdN8AIMPDoYDkK8Smmj+PZdtPOTtQ/uw4lL3LvUeTTzDCB2xMsOc+fScLwvgkKddjJhFoT+pdI/od8SjmuugMJk3C3ieo9Mk+jyMWZnFho0xgzxEyObhmDRFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ilOJSdeQ; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712312988; bh=WrqgBxPkvI6XXjQlFOMTo2LeveGikRfDs1ScFmq+qNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ilOJSdeQ+emB3vMqr5qPR8E93VPwGQHGOEVANtcmS58R0zAEAOTEXokxCdUyNwn7D
	 DBBVo2HCCVnZ0F9/hxdYxIiBObueUYpJmixxGPJTTzv/i9IuAyr92LnznCJu07J8Yh
	 aFDKS4AFs9GI/XzdoBijkhGzONb7rG1ihwjUOAGo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 41D2E06C; Fri, 05 Apr 2024 18:16:29 +0800
X-QQ-mid: xmsmtpt1712312189tckr4w7xc
Message-ID: <tencent_7A77E9664E3C953694964A37444AF474AF09@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9EWvzZcbDggbR8qCE1SJg8KGpNB0/q6DjF1HISqr2Nc++sPg2za
	 ftiQvoaYMJdbjeHxgnBTEYsQUKxEb6rmRItMqjVVvZ2twzLW0iY8mERov1oNDMESxZf45fuxfdPs
	 pRQjLr+7f53wYeWFK6WNJK2yWDplpMH2hVJomWih0btIp5ISOwHqXIeOMtSTxUR/5/3rlY2qW+t0
	 b3MWhfgLUVZ3C/dKF3LcaJYnnyrh/NT8aNs4c/ub5uI1UCwtPr1cbVaWJWlKAtCURZUd5tohc/8Q
	 bcCq4FbSmZTiAE7xK50fz6DBrVYpdkRuhUSiSWzAr90V0zADNwOxV9/JGnEJ494fx7kDkuPAmSRw
	 QLzCyLxGDr48qSSstY4LLWZ/l2ieZSv6D0TX64C93NTnzu42dzTFocH45vdEH922gSa6Pjh+9OKc
	 3VEk8sQ7wzHICoyLrfEr3+FOfcAQU0P+iXOFyEbRzuf47dhGY/U7L9a9TKJQJSinaKJv+NE8dMLJ
	 j6Urh7KyOc6CeUjcwMMR9+XtO84MVUhw16uAUrWJbK36nhy9aRvNJW8CjIHAG0PO5IStjvXrpL9Y
	 yS7u34rnI6ydcJc0glUJ0fvXGCes867Ij8zcKsGYKGO8xtk3ireWSZekzk/OJs2xCLmywSGzWCYM
	 i9oEL3emc1bZvEk47dn/XwNrzQMI0U75ZB+8OqhsEzKx+KhZJ8Jrtgai7gwITpSRsI0bJK2qQLbq
	 S1zsP2UcjD+4Qys3G7D1oqIacaZaQTZXAcuiPaWnV6INR3LtzUAiUrKr0fXI6sLGFrcuyuiUUNq+
	 J+gl0n/kKB6AGqHA1/5o3/mvrkcqnzTis1v5hAvAc9k4DI+se48FbGBYR6eOgZsjTrjqDbMdIhYj
	 dZA2S49uxz3C2GCxXs+hRuDfM36VCOygh0Q9MLVvJSlkr2aIrTeoy2waaZeQbqAhh0gYJPL3TL2Y
	 sMOr14DwDzKwbOnXLOBoMhbjtHNA01b6nFSDhVfxitfkGV2VIz4Oq238OQsSEY
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/socket: the length value of the input socket option parameter is too small
Date: Fri,  5 Apr 2024 18:16:29 +0800
X-OQ-MSGID: <20240405101629.562985-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b9b20e061553f06e@google.com>
References: <000000000000b9b20e061553f06e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr include/linux/sockptr.h:55 [inline]
 rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
 rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f36ff898dc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe010c2208 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f36ff898dc9
RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000555567399338
R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5064:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x233/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
 do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880209a8bc0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff8880209a8bc0, ffff8880209a8bc2)
[Fix]
The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in
only 2 bytes being allocated when allocating memory to kernel_optval, and the
optval size passed when calling the function copy_from_sockptr() is 4 bytes.
Here, optlen is determined uniformly in the entry function __sys_setsockopt(). 
If its value is less than 4, the parameter is considered invalid.

Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index e5f3af49a8b6..ac8fd4f6ebfe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2327,6 +2327,9 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	int err, fput_needed;
 	struct socket *sock;
 
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		return err;
-- 
2.43.0


