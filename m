Return-Path: <linux-kernel+bounces-72224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B385B0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD07F284AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F65C2E631;
	Tue, 20 Feb 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="W6wxobJN"
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5932E400
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397262; cv=none; b=EJvWNNeYidpudiOP6G/7ltzWWs/1bUMz0eoM13vhkSJ8zQzsHrRQSN4oxOB2Y4CZGYLhlZ6K0cIsPXt18PQPnolQ8xwvoF/GjmqwWr3f1TVNzowSeXZ2RJQBS0pxCBHB0I5KgjZr5SqSmErMHglQJsgSXcD6YamK5Q9sR5HuKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397262; c=relaxed/simple;
	bh=WZhDQHVt/eFOTGy+6AFVtF1k0oHT7nXaK5YloFAu6TA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uVhjdjsNs15u9LjpJoHQgznDzbjaKqYM28lxwLwFksfeNJa7Rpd+DZywUp3VITLPDGGhLoSroKARAwwyhVoExxiGnFX6LKlJLUtshu7wsduTWGL/Gwvqae/tkiiEVOBTzDPBFAKctwavwb/JS2jGpc8sLxew15x84MPEgoF7UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=W6wxobJN; arc=none smtp.client-ip=203.205.251.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708397251; bh=5e0DqTGLAWCNHVUq2rJGy4hwpnKW2PqcQIQ2kpU6bKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W6wxobJNh7Y3I8JgyZDo/jXXYEVutz/JKvNINxHGph2i92W8IokfIORTdA6YRJGC3
	 ywHIdbDb1QBeI5NUMKXGe4dJzj8Qm+0SA6t4H6MxbOKiw7BZYGVlsy8PO3Exn9AXJs
	 9YUVoskkrG+F6hNH8DTVolOPKaEaq8g5PeR3UYeI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 9CAA2661; Tue, 20 Feb 2024 10:39:10 +0800
X-QQ-mid: xmsmtpt1708396750tbameql70
Message-ID: <tencent_8712375DDCDDA9995CCFA38DF325920DFF07@qq.com>
X-QQ-XMAILINFO: NioaTWkRhWwaqtUXUk0vapS/NBHwpJaO0zjwvvdYm8Qqnj0E8hSsN+36AKrv9s
	 b8RqgpzXVzIH0Qwd4Lt6C1v04eqefETnFz4MXsxUmEUqKFUnmKssnVkKEXilD0s9b/oW3qDq+5+g
	 KVeGYXRNiTHOWO9wW5U5W6sPmI18Ir26YDN1QM7GWTZJQspVTzfvmK/gsOPw7KSz967TS/OKQZzV
	 hfh7I2rq4rx9HG6iR1o/AdNSBc/marc8aA4uSKNygvCXbpldZg2CW0ZLZBrKXBe9yCf7fj1NVKH1
	 3DrMOoVm5vx5MDRs3avVbV4krMY3cL6+RThOECrWcSjb9Kr6jdpQpBJFrUXbzU+Y20SRxgxtio5W
	 KGx/vUZc6/qUzL/wa3LyijMpeS8BhIeM0nuhCJdC+1i5XVosKF70l2EVmVPw9unoATzBKgz67UlR
	 ffK0Jgdv+/alj39u/NcUIlN30LZUj5rchmwaRPJ9pWtSCnEUi/P4hGon/e/2iS1Rq8zYG1lUSC1T
	 bLLH0Z8V7fyzb9Q2yDscQ6LPP094R9SNexySfCrgrvmIESmb2bsuTHP9CSmxdP6i0QE4P7OduloR
	 /7C6aNhTlsH8kj4cuN4e6qddTl1GYbMKp0bdFlHGtQXa8uzW+oNaxe4t42hEN1jGMK4Fa0OkE2g6
	 a1/aQbZi2wnQsTm3Hc6BnFbGMu6xj6wARDB5VblbRaEIxmZnJw86Z+UwjNOpTqhVLY78poYGBkUV
	 VZE5yt9hAypGYN6M8a5yTn8MWenOCQkKKcAZ25eKKW+/C1hkMx5OzG65St5iM/mRrlSYhIT2ethF
	 JE16f/0p+srnlHSelDa/N/SJWfWHji+niEhqlU9QtSaECdrFSaXQLAktYt3loUeSRompB3+4LgiQ
	 71xIqG8t9mHJCLPudIQ86NgZUoI2jvLjHNY3QAmltuNDSUTj1j7TY=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_syncpt
Date: Tue, 20 Feb 2024 10:39:11 +0800
X-OQ-MSGID: <20240220023910.2011462-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003d021006119cbf46@google.com>
References: <0000000000003d021006119cbf46@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in jfs_syncpt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index dd4264aa9bed..15955dd86bfd 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -197,6 +197,7 @@ struct jfs_sb_info {
 	kgid_t		gid;		/* gid to override on-disk gid */
 	uint		umask;		/* umask to override on-disk umask */
 	uint		minblks_trim;	/* minimum blocks, for online trim */
+	struct mutex log_mutex;
 };
 
 /* jfs_sb_info commit_state */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..bd30b93e435c 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2665,6 +2665,9 @@ static void txLazyCommit(struct tblock * tblk)
 
 	log = (struct jfs_log *) JFS_SBI(tblk->sb)->log;
 
+	if (!log)
+		return;
+
 	spin_lock_irq(&log->gclock);	// LOGGC_LOCK
 
 	tblk->flag |= tblkGC_COMMITTED;
@@ -2730,7 +2733,9 @@ int jfs_lazycommit(void *arg)
 				list_del(&tblk->cqueue);
 
 				LAZY_UNLOCK(flags);
+				mutex_lock(&sbi->log_mutex);
 				txLazyCommit(tblk);
+				mutex_unlock(&sbi->log_mutex);
 				LAZY_LOCK(flags);
 
 				sbi->commit_state &= ~IN_LAZYCOMMIT;
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..04788cf3a471 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -51,6 +51,7 @@ int jfs_umount(struct super_block *sb)
 	 *
 	 * if mounted read-write and log based recovery was enabled
 	 */
+	mutex_lock(&sbi->log_mutex);
 	if ((log = sbi->log))
 		/*
 		 * Wait for outstanding transactions to be written to log:
@@ -113,6 +114,7 @@ int jfs_umount(struct super_block *sb)
 		 */
 		rc = lmLogClose(sb);
 	}
+	mutex_unlock(&sbi->log_mutex);
 	jfs_info("UnMount JFS Complete: rc = %d", rc);
 	return rc;
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8d8e556bd610..cf291bdd094f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -504,6 +504,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
 	sbi->umask = -1;
+	mutex_init(&sbi->log_mutex);
 
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;


