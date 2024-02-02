Return-Path: <linux-kernel+bounces-49847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB6847067
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DBCB29963
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4480185A;
	Fri,  2 Feb 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SKPUt0wn"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE72812
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877216; cv=none; b=Dr32XIXNEK+bqW7nFrn37omsBl75doK8DE8u3xY35q3PKnhnNnUr5sqSJBMD/5kD9vTfAjHyCWStAUkiNgb50b1yqSJAej1xqh9GhEmk+CsxpG47cMlI1SDMWoLqSM6IMMtg2mZ6zaS3vdyeLNi8X5r8aw7Dg2uDCXuC8Ry4GF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877216; c=relaxed/simple;
	bh=17ZmaFXcLxg2KMbiZIcv3+8qkiAx6XN1CMzo1A5epLg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Hudzv0J59WMyXtNjzuBPx1kQ/CrcNBLbj7qBexosRMxEAPiRntyeoWSQWGfZXd2sFmuvAquDfQG+DOl7E6AmMwtx4yNPHURVpoE2VQtCrYz0w4TJoa5++FgHtOxjtXJB7LIz5DU/IN4KemMpoUr7DByCqElC/tP+V6OLuM/3krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SKPUt0wn; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706876911; bh=dzCH+OjkxcpMqkNQvlYI0iK3X0Jm3Cc5qzb5TSQ7P2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKPUt0wny3wwJvfCrH9tGbCBkIML8pnOZywsNvUzdyGsuATG+vAnnhAw1Z6SoKjkz
	 986U+YyLh4x3+xhZ2qlZpvPsprX8y6vnjfyo72K/wteAPJS84F/gg5aSXMz+miIpTg
	 SUjVKMPZGXMQZ7mnjK3WDzY/uOzXjtWbORrRAsqU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 6CB91000; Fri, 02 Feb 2024 20:27:11 +0800
X-QQ-mid: xmsmtpt1706876831ta40w31ob
Message-ID: <tencent_620E966237DC4A4C740B777367123CC53609@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DMSB/dNY69ZZh5B6aeUsPRIkF6+38qDqLZK+CGxkXkf2TAz2J1/G
	 7naGyC2rao4fmwUXK9AFehZiRyXFw00yq2CoIgJWipOEYVwk2Nf/1sdAW4M/QCqXZOVKbCogHUf5
	 7dZv1JyN7cguHgZWwQizFQ4jxe4o69k8FKJjNffJySz94C1vPhA686QBtaw0PXgcLrp+bJDq4XdA
	 BLyeUAqDOshJBl600tEvAMOYzwMQlDlWl8phHVQDhDWx0q4QLQ1QEZcgfNi9pKAhYszNM8hGD+c+
	 ILpF1qLuMKrnO8CrQNcCZUWshgLihtI02i8q6NNI8nz3K2Hff6LLKzd7gvqgpbXJfo9hhy8wRFCY
	 buCueFvnQh9kRN0n576b+YnsK5dICv+hznEFJM+32ZMYTdA1QE8FRgcXo6XvIGaf+2gfpBH8wKvm
	 Zx6zgFoX+gjvxh4YzgWXT3ZbO5llemmN8xrEy1AvtR/62BCe5xnr+agankYOhbDZIOowKZIxe8dF
	 PQAImyPcigM+D+1ueQHlRVpc26eClE9GJEcjvPF/eLwPbOzu8O9UaOO4K9TQFJCu5PiXw0S4wBdz
	 aChy6ZJR2M01G/mhbfQXqkkeG+Q91YuFtgBUxPF12SkaukPU7W+64nOsITRAePD/lA3J9SDL3Wv8
	 tB6n/jnnWs/1rRdS0564pw4cBiCsOYIIzBGlGke/uDqmeG3VDOKsIjW/XPfZnprPSn0lLueCCfDQ
	 tzuW9nv3HrjzivGaJ9zl7WfzzDX1G7/jijFvJeZHxEOk7RXv9XigaHa3baOpWlc6pUXO1Zp90b8D
	 POE5R6mzgCr2rJsqotImYt88VEjhg/fD9nq7nd2Kc+zXYmFHK5i0DDYVIJ9A+bPaG4YRuuX5i46Y
	 Z06V/e+mLJdL4DHq+ncI83oXZBNHUVm0BSduFQlCq8xPtZA0jRVd/JYrh9cRPggHUZOPCNv9bB
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in __fscache_relinquish_cookie
Date: Fri,  2 Feb 2024 20:27:12 +0800
X-OQ-MSGID: <20240202122711.4045209-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007e7a63061062fcd9@google.com>
References: <0000000000007e7a63061062fcd9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in __fscache_relinquish_cookie

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..e36467ed618f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,9 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	printk("mra: %d, %s\n", mapping_release_always(inode->i_mapping), __func__);
+	if (mapping_release_always(inode->i_mapping))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
 }
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..fd26bafe4279 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -78,6 +78,7 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 
 	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
+	printk("mra: %d, %s\n", mapping_release_always(inode->i_mapping), __func__);
 	kfree(st);
 	if (retval)
 		goto error;
@@ -86,6 +87,7 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);
+	printk("2mra: %d, %s\n", mapping_release_always(inode->i_mapping), __func__);
 	if (retval)
 		goto error;
 


