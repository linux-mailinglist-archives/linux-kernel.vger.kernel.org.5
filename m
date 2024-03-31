Return-Path: <linux-kernel+bounces-125911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E7892E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92AE282748
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72338B;
	Sun, 31 Mar 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1vDLVkx"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC257376
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711843732; cv=none; b=fOnAryDRPPSEbcENGIxJzAZcZIazwem/S4mnuG3PEq49b0AopgSR3g65LaM+I/vd2sDDFRRsPipCz84KqTFGVIBypB0nODGZGcVtLQr1jefbmof3TUKwHP6c6VXqQ0EaKopsmy2jbeUBkorUtx02nx1FG48radsF78tE3nwJ+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711843732; c=relaxed/simple;
	bh=9eBbvZxCuf2y6AL53hiH3nHsymnKizW4Jkjv7RF8q0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dmnMCf6Oes15d0QZK5sXenSja9LCp5siF4rENCcWQgiOaxgf3+A1R1FUJ8T3lkgngbNpv8VhD01o38eSpxh8csq151h8cDxASTwRLrb/Xgj1QmRIx3LeJ9o4vhndioFj8yTJN/Fo5z38xNvztR0sNxXPWjAH10rFfNT1WyoA25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w1vDLVkx; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711843727; bh=XvFjpZ5QUg1ownH8/RT/owX81trRjmiD8nBR8MTc9Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w1vDLVkxoqBmgnvxg77WX9SoqAoBdk27X1mabovdrhnuSjBT3sJaxW2XuK984KSy1
	 /EbrNgFvFYjsNtYjXQqZUOyKcT2YH37JPVK13hGZtBnpK81Ju1QnnoS34mnTF9UBAk
	 /p1aIoZRVwiK6fZj28+WOSDDg8B7TdrJdxkY4VKo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 22D994C1; Sun, 31 Mar 2024 08:08:45 +0800
X-QQ-mid: xmsmtpt1711843725tx0pik7ok
Message-ID: <tencent_CD333C9E9E1B544B651B4D250FBAE5BB1208@qq.com>
X-QQ-XMAILINFO: M7n9VusxZAlPxmkls+7Z+QwpxKdQ6+UsCc7U7260TQiLV+CJLmfSX8u/R8a7Nt
	 GGuOuhNwT2vb6MqWP8rXrzEPUNGvR71ZfkUgn6/qjzHTtLINkfwTCG3bMe9OsXAQ9uP/q7ZiZG3P
	 PqVilKDDqqIiFb+wxNnruW525JKS03Saw5Qwr4QOe0uWDUnlRKXw3q9VbDcUUMxUIv3flYe1dOrr
	 5rtFqjq5ZvAQ948oXE204VpyqNZXewYViN+Z3SYmh4RpRQnlQiU3uLlPjnXtP0vjSJYu4HFBoBQa
	 93RLZuAJrso1cDVNrLLF0rFdwgjFVFxJ0nhK4k+k3cKQ64J0WvMxIVPfOtuSL80eh/2I0TKu5K+j
	 ojdfBiBkbQ11TrSJZHycdv6KONIooIKfHj2N3ePbuFRBSGoSxBoHU/Lc1GG+4SKOzNComzEkSQA+
	 uiYPYUYZLws6CmGuZtTnSmQqLpwqK2QS4QvfJ9w035CA3dNXCdRY5y9p/Gv/RxnzNHAU+HKkWdIr
	 sWEB/DwwRhIm2x1WRcrEcqEkr9BDMqkYR1m07JUL6N3xSbypkPJLNrNHkhqzEXxZIG/6ODeygGah
	 JScTdQaq1mND2xvk1goV4nxkKVaN1Mn/sh4VG22K3LUnEEGjWNHb2PS1fUzlvqoMMtPobkPSht5J
	 TIfjdb/RuqaVKgi4YfTQQR9V23vQeGqV0wWVJ/M05DNclCnFkbmbT9y25TyfUbENf4l8KSBg765n
	 5hD9ehLND5Lhe4tCwunr+1NtChY+aQmYjycF6Buma9HDSuLAkoGGU0oWBr17Gat+s4JAiw+FP+/J
	 KLphmg+aAdEFDq8sMuMTxlPo8s8/l7JnDsbJ3KRok7ahGmPQPxpv5E6WuuUjzUBb6mcP3XbQDWEZ
	 Plxpns4TCgoU4+1b2SMy9g3SYRwX2vu4ddeezkPRFZS1RjJTRoRnaecFIpubFbua5S62FJE7xJRQ
	 mqxuIiE3TkKU1ypya7i5WNGqDZ6yuN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c824290332add8067111@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (3)
Date: Sun, 31 Mar 2024 08:08:46 +0800
X-OQ-MSGID: <20240331000845.633596-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000041ac86061400b95d@google.com>
References: <00000000000041ac86061400b95d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test hung in lmLogClose

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..56d336a49985 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -197,6 +197,7 @@ struct jfs_sb_info {
 	kgid_t		gid;		/* gid to override on-disk gid */
 	uint		umask;		/* umask to override on-disk umask */
 	uint		minblks_trim;	/* minimum blocks, for online trim */
+	struct mutex    simutex;
 };
 
 /* jfs_sb_info commit_state */
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..b5609a7618e5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -155,7 +155,6 @@ do {						\
  */
 static LIST_HEAD(jfs_external_logs);
 static struct jfs_log *dummy_log;
-static DEFINE_MUTEX(jfs_log_mutex);
 
 /*
  * forward references
@@ -1068,19 +1067,19 @@ int lmLogOpen(struct super_block *sb)
 	if (sbi->mntflag & JFS_INLINELOG)
 		return open_inline_log(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
 		if (file_bdev(log->bdev_file)->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return -EINVAL;
 			}
 			/*
 			 * add file system to log active file system list
 			 */
 			if ((rc = lmLogFileSystem(log, sbi, 1))) {
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return rc;
 			}
 			goto journal_found;
@@ -1088,7 +1087,7 @@ int lmLogOpen(struct super_block *sb)
 	}
 
 	if (!(log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL))) {
-		mutex_unlock(&jfs_log_mutex);
+		mutex_unlock(&sbi->simutex);
 		return -ENOMEM;
 	}
 	INIT_LIST_HEAD(&log->sb_list);
@@ -1130,7 +1129,7 @@ int lmLogOpen(struct super_block *sb)
 	sbi->log = log;
 	LOG_UNLOCK(log);
 
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	return 0;
 
 	/*
@@ -1144,7 +1143,7 @@ int lmLogOpen(struct super_block *sb)
 	fput(bdev_file);
 
       free:		/* free log descriptor */
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	kfree(log);
 
 	jfs_warn("lmLogOpen: exit(%d)", rc);
@@ -1187,12 +1186,13 @@ static int open_inline_log(struct super_block *sb)
 static int open_dummy_log(struct super_block *sb)
 {
 	int rc;
+	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	if (!dummy_log) {
 		dummy_log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL);
 		if (!dummy_log) {
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return -ENOMEM;
 		}
 		INIT_LIST_HEAD(&dummy_log->sb_list);
@@ -1205,7 +1205,7 @@ static int open_dummy_log(struct super_block *sb)
 		if (rc) {
 			kfree(dummy_log);
 			dummy_log = NULL;
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return rc;
 		}
 	}
@@ -1214,7 +1214,7 @@ static int open_dummy_log(struct super_block *sb)
 	list_add(&JFS_SBI(sb)->log_list, &dummy_log->sb_list);
 	JFS_SBI(sb)->log = dummy_log;
 	LOG_UNLOCK(dummy_log);
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 
 	return 0;
 }
@@ -1441,7 +1441,7 @@ int lmLogClose(struct super_block *sb)
 
 	jfs_info("lmLogClose: log:0x%p", log);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	LOG_LOCK(log);
 	list_del(&sbi->log_list);
 	LOG_UNLOCK(log);
@@ -1490,7 +1490,7 @@ int lmLogClose(struct super_block *sb)
 	kfree(log);
 
       out:
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	jfs_info("lmLogClose: exit(%d)", rc);
 	return rc;
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index e1be21ca5d6e..23628ca3990c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -504,6 +504,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
 	sbi->umask = -1;
+	mutex_init(&sbi->simutex);
 
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;


