Return-Path: <linux-kernel+bounces-32394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F4835B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1407B27282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790B6ADB;
	Mon, 22 Jan 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="il/ZpNhk"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251792913
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905807; cv=none; b=vAu6aQiYDuAj/ViGVDRpIfoseSGhzlEX8nUKPbWz3tfrHFysg8DjNUMeJqspdDPM32QiGDfR3yKGcGez415SWvwJMKkdN7IeHlXQXielFBdDaMq0Mimg0m2cIt0BYxgBNpvri3iCpb7JjI6fqZ7ymd2txKPC7/7ZfNI32xnvcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905807; c=relaxed/simple;
	bh=zpaIjkgHkPGHrgfWtgVl4af0/imPULca0EYx7pJSUd8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cIcEuRp3jO7ssN7ik0Iw9F91urC84WIxRY3D8krdka7JuzhVzdg5QxDFPwFg7a3B31Ff0jKQN9HKOZ0fKtghPhC75vP8a64qd8z3RyC78mYnYfD5Hdknwztyesg/hZK3bGEN1LuZwlmunxmKM2/QLaWc7W6gq+qLn+Ifjezq1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=il/ZpNhk; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705905802; bh=oEZhMRw9HdJT4A4ewTuyjJB8RjNCZNkSeMoeyQNKRcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=il/ZpNhkQJDQbPwgjW2rRDME5f8H2EebHE9h7YxThTyaopD3IHN55AkCJVp4WL/9C
	 RehCEaX9uF5Z1vuGoGXKR1qOrROmZX39rakre3TurM6aPMmvIBot7C+uV45pFVAqBE
	 mILTncvIKhq98+TuBvSIz1xXT8l03phNmBwMXKrQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id AD50D6AE; Mon, 22 Jan 2024 14:43:21 +0800
X-QQ-mid: xmsmtpt1705905801td6ol7g4w
Message-ID: <tencent_5A768367E63CF5373E97AC37C24A2A748509@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/OQ2aS0u1J2TYmhyDt90b2ECS0ICzA+EBKZsgnFPJhh/wThubjr
	 /HSb9oqHPNdTB1p+qoPcfv8Pqphezn+yPGZdX+l6Ur6M+dGo1HHuPpMxGCliFDAw4kI5Pu0RJLcd
	 zoBFqWG+cjTHj/aWM6/mJmVZEafQwor8wM8zDVHvMuh7r6czayrjDmBHCn6i1YN50i4Js0D9v6EL
	 d2Kkdv04mJTvDrHNkBE5D6t/wLHRx1VUumBYm2hH1hc6CkykFyZHfaqJopnItWXHCSI0/AOmCkFO
	 zwQ+6BaVoXk2QduyUo1Z60D53QjNA+sTmQxxNyKs3/ZjrcMpz7aYUw+ugYddiGL3YFGALdQtOIdY
	 qLSQSr2Aa/u3xEThF4FdTDPHgnAhH9LeR1mr0viB0Qgo/ANFe6kYhdxhnl0+ObnkavfBxu8FY/Ws
	 IJEbtkgfYTqu6IXkfLWHUZvQ/+qd3gg9TejUe9Md2TPtpvCmgeadgO2S8uZk2fQ7X34cMrYtsJiO
	 MdkUPF6+VGOKLrlPKD7AmTi8EMmv4O2/VcyW/Ecn6yX/5z73lJNHwe+gyWrqZrMkunatQACaxtFo
	 HQNc5km75m7C+Rc8QjWUh7maqyuC+7jt6fvWdBxkt9QxZseUdxD1JzeJEnzLm8orBkly7Qv60BE2
	 Ww8s2LbKo6pXa8pg6aEYJqEhIAlEnhsRP7CzLVoMvuaypyEIR06ws/kRmWkCLS7d+Gdgx93VTxaQ
	 sNYtk1OotR6XYET1Hymfs6JV9vACaptuYMo8Ofe+lzfwybA+h+OmqeVlPgTo6QphmRCXQZjBjhFk
	 USVxtyNvRoVZtW6QKT/8wE7BPOzEQADdJREFvbTq8G+8GKib7LToZ2nrBSNsPqveYvecgYvoPUQD
	 QbHLQhkZL9YXG81pewQ6b7wMxqLn/3+SY2SD7Ap60b/XYqWgcsp1tCj24oT7eFXQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+37463f2a5b94a8fdabec@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
Date: Mon, 22 Jan 2024 14:43:21 +0800
X-OQ-MSGID: <20240122064320.2058062-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006347db060f619341@google.com>
References: <0000000000006347db060f619341@google.com>
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


