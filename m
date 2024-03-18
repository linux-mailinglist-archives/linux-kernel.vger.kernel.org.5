Return-Path: <linux-kernel+bounces-106720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612F87F287
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8DB1F2279A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB659B6A;
	Mon, 18 Mar 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="A1QODJ+s"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045F5917B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798557; cv=none; b=dtf0Uy14DqEOLEy7TnPqoJrdLGPc1jvjVR7P9rQFbEmyU7SQlu0sSbk7PGNbUlUdq4hX1ZsR3idqwoFqlrVYH6+zv34tvqH3iTPYzhnOT4S3jJZSvpMmsh0LntiFN3JXrhF976TNuAXFRUoFIHzTs0IpQ/FqmbK24bUGcMpcmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798557; c=relaxed/simple;
	bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=i6VkMXDOsf4rv0phRolOls/SL63zmABCKohZ6omozvhHKLsf7yPn2Su8P3yvH9hAARsixRe0QcRzWE7H/cO8uc2FzH5vXDS9GLKBcxjYm66XZfl0qqTixrjaNNIYtQjGFU8+gf5d8w+9tsfF53HMb4w5jdbi0ZSvbVlLkUmYn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=A1QODJ+s; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C80EE240027
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710798546; bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=A1QODJ+sQD/n147oK1SJ5BVHfmWOXLEoIsQeobr3+VtG3vpib0kanM+ZLG9Pj/Scu
	 wnR6b/GqpSq1sxwCcuK14I0zAPZjHavXz49fwKOYQORkSI5WF39l9QEVed8lp76a5e
	 LudiJhxvs3nW2JjlwUG+DLuCRGBQtislQ5zDL8ydvU5Sr7c31NW/PVVjlkBf37e0Zy
	 H7IxAYCvgs/5zBKik3nCp7rRKqxgcARwgCBCum3iqNMQ6GbncnAHjWcXjM/frTGdAn
	 H5xpIZx49GJ+HcK03PUOo3I2mHkqQhbAUX+kpmrPuaUFzbgmg5BYKS9dgEgWlWC2CY
	 2SFs7jyXbjqIw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tz7ly5gmvz6trs;
	Mon, 18 Mar 2024 22:49:02 +0100 (CET)
Message-ID: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
Date: Mon, 18 Mar 2024 21:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
References: <0000000000002750950613c53e72@google.com>
Content-Language: en-US
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <0000000000002750950613c53e72@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

please test uv in v9fs_evict_inode

#syz test 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
      filemap_fdatawrite(&inode->i_data);

  #ifdef CONFIG_9P_FSCACHE
-    fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+    if (v9fs_inode_cookie(v9inode))
+        fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
  #endif
  }



