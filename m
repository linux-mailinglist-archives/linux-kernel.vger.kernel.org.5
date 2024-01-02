Return-Path: <linux-kernel+bounces-14307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2B821B23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3932815FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C4EAD9;
	Tue,  2 Jan 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fjCgGpy1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896DEAC2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704195452; bh=oEZhMRw9HdJT4A4ewTuyjJB8RjNCZNkSeMoeyQNKRcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjCgGpy12WSCPVg1PksqyZ5SYTPlJa9PkMwRFGUyyzMuLfyWuWq/EsWfufzrsEmuB
	 7wgdtojzOTQHn395XQfy4SkW0rbgm1ghogHZMUF4zZ9tHbwAX04e9Rd1gRNYuS577r
	 afu7QXuGMvdwah/84QzZiHFzHJExjQ5A48B0vAYs=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 95E93A02; Tue, 02 Jan 2024 19:37:30 +0800
X-QQ-mid: xmsmtpt1704195450tyxkjroig
Message-ID: <tencent_17CEBA53BB6733599E5D1B6A4BB11B5A2508@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2L+8tzhP/HGQJrafDNfRCRQjBTdn9tbBQCJJ/6fTS
	 IYQ1ivyaBl7pKVag5tYNGgGPOqIn1HDB896C3BD/CFOUgELsLNoZCQw6yUtxk+VKir+4fAEaI1Ts
	 YVF4C5n6Mf+p6UEJVd7AC3TZ3cqX5mx8K2WzFTDCPJMeuT3Kor+967/zn9XBAQVS5tVGFms0FX8Z
	 CH909PcMf3tMZdrUnZFFg+DlmycOeFiV9iUVD2K6gffwfB6bEbKx1t5z1BKEaa8Tzk9UySIV3De6
	 t2ljZfjHfNB9m85tzzl1JbQP42PcACsE5uvSFfoZQCdsAbCPWC1vMCTeekrd407G+kb6lZa+rEhH
	 H++qhxgK6juYrDvwWGm1x1gr8tLjW67bU9s1+wW838l9fHQUKNTRTbyneGJlmUsparIDqjl5oKHq
	 Ulc0z8pLFpEDBJZAovPUdfqckfBmUfmkZ0UvNNZKwZxnKebba+0fWBhMjhzobKFQrcXDJ6Omh/u2
	 W8MBCNCs4aUUGW88nMr6wAhqo0BNfM2FK0aNYiKJfhwoToo+aVZM1aV29vFmNBTg9Lyn6BSfJ8JK
	 rkg9+LhUlNJ29+ndRIXJ8/vhoyuvrzfPqxo5IkXYObUJVonWW8YOGCNJmzL5fSAx7AbITUzk/iYI
	 dnMDdh1t/kTlZZfHqU66xZqrjv8CbwIjW28cS83vFsIr3RrEXXXgUwXhAGfhH6fg6hJFrce7t+/I
	 AP3tNJEuXv7pxNa+g343MpgVrVSGLYiYIep/tRSNOPlLNf/bmUgq0aYVDza11QDq2I2+cvYdvTU8
	 XXasMsGdL6BrQacjwRznoAovPEOqnKtLFQoH6VTwtGah+vPa9ozoCMLOb6QmdAmR00qymh+EtzDV
	 Sjulkb4bNb4mIiiJCMV8XOiMtidad+DMdHxZsYNSP8JlZWsXawvk4b6tuX7EblhyCJ0+PATieo
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
Date: Tue,  2 Jan 2024 19:37:31 +0800
X-OQ-MSGID: <20240102113730.1515754-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004efa57060def87be@google.com>
References: <0000000000004efa57060def87be@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test possible deadlock in hfs_extend_file

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 610a9b8f49fb

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 6d1878b99b30..1b02c7b6a10c 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -197,6 +197,10 @@ static int hfs_ext_read_extent(struct inode *inode, u16 block)
 	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
 		return 0;
 
+	if (HFS_I(inode)->flags & HFS_FLG_EXT_DIRTY && 
+	    HFS_I(inode)->flags & HFS_FLG_EXT_NEW) 
+		return -ENOENT;
+
 	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
 	if (!res) {
 		res = __hfs_ext_cache_extent(&fd, inode, block);


