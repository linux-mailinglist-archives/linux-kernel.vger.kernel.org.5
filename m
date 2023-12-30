Return-Path: <linux-kernel+bounces-13362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA1820401
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8011C20BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D11FAF;
	Sat, 30 Dec 2023 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wDwkEXg5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E063A1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703924078; bh=2YLUQ5JD8cIPsfY4zmD1aNRnT9NT5rVQVNTPSdRnL/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wDwkEXg52W/BCFqRTlMSaRE+vR7Eh0F3bXppQR07d4TWqsQevqUYpuq6SVJ1kdOPH
	 Ww+mzEmgojOCO4BjySLm5cCXL4vXWH9eu3Dhr8V4m5xu858RtpPFaI3+AUwup2eLUx
	 vheR3vhQb3akoSKVX6aAiO912Bo9ky605r8SOtl0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 22299EF1; Sat, 30 Dec 2023 16:08:34 +0800
X-QQ-mid: xmsmtpt1703923714tpr0fri95
Message-ID: <tencent_50A825E08D9F92025DEF5DE4992C4FB00D07@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoZ241g0V/0SAmWgmDYbVEvp6npzLS7qLl2SaWOzHEOaewm0L1Zp
	 rRk0vTz4yxKzJGYEW8NJBNyyEZ0WQjR9kJE33eVRdvSX3NpCujZ6VXgQXpgLT+JmHq1I7tqPaWaG
	 c96H+4RXJ6gd5ePix0jxziAihGqyTkI40ce5PfPZXw9b+xk2fUjTF1z5rS/9uB8L8wXMSvqpMdRa
	 szN5gYAwxNZuW7ZHfEvU5kCtvtcT8l/d36JqHPbBT6cMnov2LAHYMf66oRFQB/auKQdXOzxS9mfa
	 iwrWmsO2d5lP4XPlmjXU87G8FeTsZtzmKjC3Q6CAV/NPvudRjbdtbBOvLigfIAaxJ5MI1hCWZxjn
	 ZL+4F1vSdopGGOqKZUUMV65bFElxz97kNG7Vh71UPCp2jbKr4/z2s0mRWHJagtMYNskoWuKJ6nsf
	 XtAAoYAf4QvOHhpt9BIVBnceDJAEDORC+RpKWMFkuTDYZI0XNH3cdt6h+tSui/kzUTUHQXc68HVn
	 jdUgfwkUmouI2zkSzzDYse4zMbUtlvXob+bPevhzEu7/ujnXxOFI5m+trttx2oUsp0fYSHp7bZcE
	 jkh8TSshASks8ECCvRkYZT4M9y5TM7uC+Xfx41K1ukganlwfgZcEyJkuTgeLUDlySbbVbJVEUvYi
	 MPKydQ3yNcC0kB4ZuN3ZoonD6hqtHPy6j3R/FZwGBdi39OgM8D4EbpIw+45z86u1yEznk/9OnqxS
	 Y/LNIKz/aJWXf+Q4rT1XKDfm0FhIfgmrEpCbofdpUGzUuUW88WT9GErRuNxVi0Z8WBtbTNRjSeOU
	 bWaAOO3/CyGIGbafgERVEPG9qaRO4vN3e5P08vEbC2E/LmkkWtHy92q2yMx4T2c9P/gJhaorHQc8
	 UELWhw3kPhE4Nlvi7ibQIjJ4BrA9jUGBp4r85yUvnXUEs829FdDaEwyOR7fRxKLTyDveeNeiUt+X
	 J51o5scD8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_listxattr (2)
Date: Sat, 30 Dec 2023 16:08:35 +0800
X-OQ-MSGID: <20231230080834.2216261-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000038cf2f060d7170a9@google.com>
References: <00000000000038cf2f060d7170a9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in ntfs_listxattr

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git aafe7ad77b91

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4274b6f31cfa..3b97508a7bf2 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,6 +219,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
+		if (ea->name_len > ea_size)
+			break;
+
 		if (buffer) {
 			/* Check if we can use field ea->name */
 			if (off + ea_size > size)


