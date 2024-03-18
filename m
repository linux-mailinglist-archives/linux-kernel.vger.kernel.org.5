Return-Path: <linux-kernel+bounces-106331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BD87EC90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8641F210DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DC52F83;
	Mon, 18 Mar 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cnmFKxKn"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95280524D1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776939; cv=none; b=GePUGfcBxXZlZ4oxMwgbjiX7bh62GQQCFb7SNnr2kAuj5nt5WR0I71zfRCU3+zKf1rIz1FGN8+PWQ/Q/iFZ1re/LC7E05IzHIk2jZtVHApIY7gXu8gKXX7glwhDl5ms3dzKKRL2XOzhLYuqcTbSubsoU7DLo1kdm/fFqm0hoqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776939; c=relaxed/simple;
	bh=P2mrvSmlzie7vQSmXFC32spGcjtp7fqRoyCIPryRSRs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ORHXxqsDnDk1W43TtaAdno8JOky3//hCa515ZtYOETjL2/froY1sY9cX71gdXBd5qbXEb6qoc2c7cp+Ym5kkF/M/EYS3MxwX/wcdPvLQnXrcrcpiaZHWDEHNfTSA9wkQHeQjcVsmaHS4xvUowxqOW6J8CugFEIoMzeDBSU1RZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cnmFKxKn; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5A32324002B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710776928; bh=P2mrvSmlzie7vQSmXFC32spGcjtp7fqRoyCIPryRSRs=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:To:From;
	b=cnmFKxKn0+APiCmv+eTDjs1YIjZIlKWbTZGXwgTagExa64Mhli4fMPXr0gnetBNEE
	 1PmCuYANO3Z2waQvNfuC4vSRhFJRkIj7lxsW7UCxKzjLrWMfTArP0GiMZ5T7LPnc0G
	 tab6HG4Hdu8DvlWZpw4fXzT5Mev3PjDpz9XhE4vLn9FN8mS9JVyvh8MJ0Hx590SBJy
	 gCa5yIJSVml3mRFzchAbFO32u7R1sTN+vfX3b+Ey2oS7jbgzAKvR5ZOMQNXgMvo0uh
	 r374aMUqrPHsBQJbBjpPlR9sRAbgpyjkoK1ZLJsSlXkFK0Dce9YsrRR7SYRVtKKQjN
	 /9KS3YrhMM5eQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TyzmD52ZWz9rxN;
	Mon, 18 Mar 2024 16:48:44 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <0000000000002750950613c53e72@google.com>
Date: Mon, 18 Mar 2024 15:48:11 +0000
Cc: asmadeus@codewreck.org,
 ericvh@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com,
 lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com,
 v9fs@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6E22992-FF45-44E3-8FBE-D157BED7B922@posteo.net>
References: <0000000000002750950613c53e72@google.com>
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>

please test uv in v9fs_evict_inode

#syz test =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);

 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (v9fs_inode_cookie(v9inode))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), =
false);
 #endif
 }=

