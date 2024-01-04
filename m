Return-Path: <linux-kernel+bounces-16716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3218242D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F040B248A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FE224C0;
	Thu,  4 Jan 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qHxvj7z5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2721A1C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704375883; bh=crHrwCcZJEq7rN8cHb2Mnaapl2QQjpmkPYf6p2tNyCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qHxvj7z5bdpF1QXKvBwEYAezD9Zj5+dkZknL6A+hTk0nqOzDFj+BBJpoDJbfCG1aJ
	 sH2q4OdJVAiUcy00P1jdOFBOqGGJYvgK4keHRoxTnuFdcsC7Lub62xlsQl95VbCi5W
	 wdGQVBhTTT76VZdWZgk5SRN+1SrdDafGHCLY3sP4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id B2983CB5; Thu, 04 Jan 2024 21:44:41 +0800
X-QQ-mid: xmsmtpt1704375881ts7xrep0l
Message-ID: <tencent_E286962837EA4A84759D77A766423C3D3609@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zF/zgUJiJLT0IYsLH7IfVv6MvHiQLR6PbpKb5L8gy1sl9pTrZoS
	 9ig+DRTAkNh9+Te4cWivA65m3JSYsTJusuC8XTdGHZ/S6sx7Bqgpx3UFdYq66f6VJ4xx4LnrgOOr
	 N3SRPLa9Q7gk6P0EFXvLwYNn9OLo9X1VKs8lipg5/GEH09h/gsY8mq+1I1RPpkCx4SuEASN/R+o5
	 E3YUGd+a+lYQfOR6ENjAxcDtOQeeYp8tXsoxo4lum9Cxs6MTvZ7ecGTDm9yXUOsDq7vpz8NCXXXf
	 qMEFzybCnKvFly37KCD5e63SwzX6XIhGKy5Mppd4bER/SXsvdhE24uz7WEhBcIhhO8ZvAy8vQW3n
	 I4o3Kp2HLx2Pj83KeGkZykffT4xLZh0l8UHn/XQG5YoWUgi6vpqUsGpeULfUhUv/LimRFhU1NYlR
	 wwCe4U8k7o3ase2WGOqEZbkGkIBv+MZJjF/KfZm1b+1Z2RUxCSeGLefdWtleYxBFe+Ye8MhkAdh3
	 5oIP1VyCS0Vn4RdZsGf0XvblX8368LowCQ0umCrJzWnH1dt0bMMum72JnG/OrsW7u6bV/C+Pug0l
	 CYCd+QxKiOP67se4t8x8h8Ifb63VBeBDNmNIAhSbPkfF2hY09r/y5MslhtxTwSBoXmIzFGnEXrDv
	 IZ+ZFBGG4Snow/IrYGufn5P+LKFwApmgoaI0O7xBmXpuL06Wk8KtwmjfEw6YG9iFLJW37Ou5nyLX
	 twEcepTMNJqYjeacJ15tOfpjQSKhY6qrqraXXJEuDSPv6geKL3c0Zo2RcfwoHkQQKPU4xiJHLbgz
	 N+WZt377fmkZ6yEzg56PZrvbrXuOSEuFkA9a3BXhNjyQoHdwxYCmH7WAP4HGICdBm/eQKC4Lzs+S
	 bLwH+0agLr3kPF1GXXBMQRsWQgEVEnxOWfv9gMfUtuT5VMvt4UvKoX3x7oK9FHxTwvS/maB1Ap
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [trace?] BUG: unable to handle kernel paging request in tracefs_apply_options
Date: Thu,  4 Jan 2024 21:44:42 +0800
X-OQ-MSGID: <20240104134441.3715919-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006bf22a060e117a8d@google.com>
References: <0000000000006bf22a060e117a8d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test unable to handle kernel paging request in tracefs_apply_options

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 453f5db0619e

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 62524b20964e..51eacb5f4e08 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -220,9 +220,11 @@ static void set_gid(struct dentry *parent, kgid_t gid)
 		change_gid(dentry, gid);
 
 		/* If this is the events directory, update that too */
-		ti = get_tracefs(dentry->d_inode);
-		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
-			eventfs_update_gid(dentry, gid);
+		if (!IS_ERR_OR_NULL(dentry->d_inode)) {
+			ti = get_tracefs(dentry->d_inode);
+			if (ti && (ti->flags & TRACEFS_EVENT_INODE))
+				eventfs_update_gid(dentry, gid);
+		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			spin_unlock(&this_parent->d_lock);


