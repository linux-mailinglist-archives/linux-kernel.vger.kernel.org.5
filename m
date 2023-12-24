Return-Path: <linux-kernel+bounces-10677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078081D894
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487811C21342
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF52108;
	Sun, 24 Dec 2023 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pnTr8Wc6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8220F8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703409611; bh=xSkOJi8ry9ZTYt2xcYSgrVPLNV8aUnqjNEMR3Z4sMIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pnTr8Wc6SgbPLO3GCL6NG4azBRzWyBkr+sdahNYWMeeedPVtxVckRjYyeXVzsdEgK
	 otWlWL0qK3S9FCpmolEPYc5rTETRUoqxUSHBlcsDY378RKbk9n8gcP+MkqHqVzJNmj
	 OKmmJze/sVJvajxOHCZYB0xh0c1vVAqapk3rsPxg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 3882FCB6; Sun, 24 Dec 2023 17:14:08 +0800
X-QQ-mid: xmsmtpt1703409248t3jgeuqf8
Message-ID: <tencent_DECFB60DE7258B8DBB121FDDC75DCF191707@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjgcxFUvHYC3GOEhqvwIp5nhxpRi5XAW2Ws8FM2WrcL4jxjRygBO
	 Msorn+TFPQcQWvDWyF1mllTzri+ryOKFqoATXZwBYMOMS6LGV8dD923pxcdT7+OnuUNyXZkmkWq8
	 np9I5jr4BYaPyqsfYLdA3ha57V27eP5j4B695AR8x6HDi6IHhUK2KfdmDxf0y9Q5UnfWigGCBa17
	 Jg4qENlTZRWH7CqxW29mu00i2s3INxjWdpCjypDCdKHO+x2nVU6a/tntaqQEbgtv6r/pRQo80vLI
	 S01ycE4toIfIJmzNSPW4yI33x/6RKTguYKY5P1i90jJG4OxXHZIoGePA08H7Ko/Suhh/Iwjgfwvw
	 adbPHGZXXcL3kRSGzaHKmt8jPPZZIBQWM/kS+W6BYFKczoU63DAzABfvxTXmjCFWiqIQB86WDXb0
	 qq+MPB134sjIaUk6Npgo4eCrHKT/RUohkNrMQP0ouh10cLg8TDkTMOTz9jiKkD/lYvhO0fF8q2/t
	 LhmbkfqeLcujF+aX1EvzxZzvXSO/wIjXsRumAJsSQQtv8SB7xXCwQFER3YznOt9iqIoxUo7JRvRx
	 dD7WE50r99TFEnplOtBSLlqK9WMLQlO+jBax+xMjTYblGRqoIs7pwjMNhNAEVI5MC+B0/8B8caIv
	 EIXFSJJHzL2/p4GeVyou3RRyIfNZ58cIDA5IUAiP8Gb6nE1u3ar2QmUZIhquwCsHisN4MzPGFhzf
	 utX2f/ZQj+/ygvY8g/B9xzXUbv+8StjlM0nEapINlAiUg0LzMqfj882BNA3/ae/HkhXoA45dBR47
	 9J5lmGPalqLU9AMN3lcVkf72OzO2+NaE1ylU+9iDfKugtLYsOgon6uj/HFuZrFic9FCq4jDnOmAo
	 Xs+AiB+E/u/GhE3yVPQmp14DvaF0vOp7n7bhF8Lc4dOp5wnZuInL40XQzOidbH0l9GyzWtDCiL
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in lock_two_nondirectories
Date: Sun, 24 Dec 2023 17:14:09 +0800
X-OQ-MSGID: <20231224091408.3559876-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000e17185060c8caaad@google.com>
References: <000000000000e17185060c8caaad@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING in lock_two_nondirectories

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a39b6ac3781d

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61277f7f8722..692376f3ce0a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4710,6 +4710,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	inode = iget_locked(sb, ino);
+	printk("ino: %u, in: %p, %s\n", ino, inode, __func__);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
@@ -4944,8 +4945,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
 	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &ext4_dir_inode_operations;
-		inode->i_fop = &ext4_dir_operations;
+		printk("i: %p, %s\n", inode, __func__);
+		if (ino == EXT4_BOOT_LOADER_INO)
+			make_bad_inode(inode);
+		else {
+			inode->i_op = &ext4_dir_inode_operations;
+			inode->i_fop = &ext4_dir_operations;
+		}
 	} else if (S_ISLNK(inode->i_mode)) {
 		/* VFS does not allow setting these so must be corruption */
 		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {


