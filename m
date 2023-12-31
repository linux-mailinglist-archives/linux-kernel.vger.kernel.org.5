Return-Path: <linux-kernel+bounces-13625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE36820994
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C40C1C21716
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF57186C;
	Sun, 31 Dec 2023 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VBVd0yzF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDA17C3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703990470; bh=FA4BCuuSTn7+sSTTFVu1YaFnCPWd/2sPRsMVuDWUGJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBVd0yzFbeF/AEbdfleAZO4MTa/knDZmJeceb46WZUY6l08Ii7Pr4x3KsrDU1LS3f
	 1hWBlfTdbGKIBpF0g0PSqFV+Aj5aOlIUzuxwaUZXH9+QfXcF/keJySzebqarD2RCJa
	 WJvXBvwloNWT+L6Ud1iFggXdTb4lVVm/35Ustq/4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id A47B72C8; Sun, 31 Dec 2023 10:41:07 +0800
X-QQ-mid: xmsmtpt1703990467tqzw2zmdk
Message-ID: <tencent_7ECF840DDF25850DD4923CDDD3DDE1197A07@qq.com>
X-QQ-XMAILINFO: M/sBYxuwFsVoo+rQrQA0IQEzEntq4AX7P2R7NY48BNhF9LP2rpapwy1uiTdKZX
	 2pqBkXJeQ2qYHt0RVzFr87h+AvPtvb0y+C+GKYE1S0eD2xquW1XevWAzUt9JOqI4Kjky+Dxs8mXX
	 JBrVgRXfObaH+ha4PG6C4LlcX2qXQvvKbYrqC6sH9mmGhVGAJ7WbE3Rr7nDoNu0UaPe14ObiJbt4
	 ZP2FZEXCUlPgNSteekUSa5OdFqbIiJ2qAH219xgByqu2B1nprHV4ywxAKbO3mfcYK5DzwIbgxpuM
	 jzZPSh/7Jdo2CNP/SdUqp9i6bp+G6r0ac39dEDDCZKsDzfXRuqrEDNfgv3bYGRyB2aNtIwJ+yuLK
	 +L8eglHFR9yX69ICUpuR7N0iIYqdWCL8dRQXI29axxFFfhx/8vTXyuJbIQQIypagcdnb5BOvpxnC
	 SuJJwIuaeL03rBDz6edGh28pjxAELlFsPWSdR1L/PrdBPdjKiZTBCe/JZg4AmWWMinbt3j27tc0P
	 DOeju2oFKpT8CNdIbTUWuGJH/XVVxMRzEgfArSyRh6IEcE4BuowQGj8oU+r3TK1fcvUPI/8OivdW
	 YckWADXh0NSLJezbdQZ6KLSLY2izy2keXVGmWKjVEpMQW77m4H9TEDYkghxOE7QRPJsq8tMPkQsP
	 Es6AtRvvdXeUG5+UwnD7TwzoMoxAMB1OF1ZdNScAU0I2KcYC0ODJi901RsMUPcTqU26WA2psonW6
	 2BE5Puduw9V11g/g9w7CHaYICdOGaHitdxfEHsBJqchr7Ezs1niTqRVAxNwMMD6wAtpskPy27U2t
	 E2yOq0JriOWZEfFA8+Cy2/kTDyUe1+qMlRotqwhoNK1dLfdwv6H4GZQ2tz1ubF1JfVn5BllRTGdo
	 QhBoiqY63qaF80S64dbGe6Ujco42e6ZaZsdcvWKx3qfKbtXNq8PQZC5UUCWBJwPIH6P/or7oLTiJ
	 gc67iAC20=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	luto@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de,
	xrivendell7@gmail.com
Subject: [PATCH] ptrace: fix kernel-infoleak-after-free in  copy_siginfo_to_user
Date: Sun, 31 Dec 2023 10:41:08 +0800
X-OQ-MSGID: <20231231024107.3147583-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9d761060d5ce6cf@google.com>
References: <000000000000a9d761060d5ce6cf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid kernel memory leakage into user space, memory should be manually 
allocated instead of using memory from the kernel stack.

Reported-and-tested-by: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/ptrace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d8b5e13a2229..8bd346b10c6e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1033,7 +1033,7 @@ int ptrace_request(struct task_struct *child, long request,
 {
 	bool seized = child->ptrace & PT_SEIZED;
 	int ret = -EIO;
-	kernel_siginfo_t siginfo, *si;
+	kernel_siginfo_t siginfo, *si, *psiginfo;
 	void __user *datavp = (void __user *) data;
 	unsigned long __user *datalp = datavp;
 	unsigned long flags;
@@ -1061,9 +1061,13 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_GETSIGINFO:
-		ret = ptrace_getsiginfo(child, &siginfo);
+		psiginfo = kvmalloc(sizeof(kernel_siginfo_t), GFP_KERNEL);
+		if (!psiginfo)
+			break;
+		ret = ptrace_getsiginfo(child, psiginfo);
 		if (!ret)
-			ret = copy_siginfo_to_user(datavp, &siginfo);
+			ret = copy_siginfo_to_user(datavp, psiginfo);
+		kvfree(psiginfo);
 		break;
 
 	case PTRACE_SETSIGINFO:
-- 
2.43.0


