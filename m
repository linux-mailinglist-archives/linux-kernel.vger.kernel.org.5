Return-Path: <linux-kernel+bounces-72274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221785B181
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223DAB21564
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5947A4C;
	Tue, 20 Feb 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VUaSri3v"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037D1E48C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400173; cv=none; b=PWQPdCRjtx7GSFM80HFfmrBrKCrnBtl6VmcCoAkKSvG4S93mCnx4vIIglyXj7wECtyArP/p7zRt0vWIIvY4KxBpDemZFTgVxnW9But6XcUIoHEF1aUaQe38JBf3Jb6PYtcJzb8tOSvj6j+9LTSWR5cnQrYlSswlD+PYbpoizV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400173; c=relaxed/simple;
	bh=7dfTuCtjIpywIjCFVNk+ND2mztCjScKwiZKX6KQUwaA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IePsc/+AiSnTahGfSOTB8WBpPSoYDsxG5IAFqNBeTzEBMMHGaNYl1tWA+cM3gmPoAUq3a0yPNuu+M8xxJCDWX0o3INJRQms9vY7gGKWHdoPeRXykXsPn/6w+MoZpfb0yDscE5PoYpfnSzA4KTvjd8DkVenEL1eKN+tCt+Y+8aIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VUaSri3v; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708400160; bh=rByPOF5dYZWIOnrULYHF63QAb6RsV3fcLXdjS8zqzAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUaSri3v1C8jamXwZxW9wIS9SFKQHB1hAWpWZUm+HnxNfVobZt4qBOEKx+5eeAfHB
	 flww1mEzPiG9912s4UnYpBVgQq7oF4xsKdZBjGc/UxQKHodnWo/4aPXwc6snwtDugw
	 QT8Lzd6y7jMNtRzt9hCDqjlvzglNTOBTk4/bDnLs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 5F03184F; Tue, 20 Feb 2024 11:23:48 +0800
X-QQ-mid: xmsmtpt1708399428tnfx932k7
Message-ID: <tencent_6536044A2C75D97697660A3C4B371A963209@qq.com>
X-QQ-XMAILINFO: MRgSEBbyGhwKNRa4nzGXIMM5JQOavNxRmrbjDfGuVvmxszX0I6U9rDuWiV+Bbo
	 PkcrMoZW6UDw5DSlZp5G3eJW3+X0krJHML2Ti8TX6UTgbrl7XrEml+xjA0D24WJvDvdJclXO5TRf
	 tVjhtm2xegMfXcck8ItCrion2n0XQRs5d7MW0cA/EF1h6LUfBrEDo7SYni8fsXyEEOfjHSsNx2GL
	 Nm55cPyznTTQI6hcU/H81Mp1daixwukoUeGwI3wauE/g9/dRlAqsaF9BuG04qyp2gv2EgGA3lVls
	 vrjAV8xbutJA1gCmoeZ3xRBc4BHuWSPy00Ry5TyofhKEN4ClI6cOIDufI/bnVNi3Jjs7MykV+BiM
	 TGplXZTA1QbrXw+7BTdQTFgFEDk33LUPt3309hL2rS734lEfKH3Jx5T+FGFcIuelzWKK+I4kOVDo
	 +uZBqxJ8h7mRGrDuQ0lYcUsd13Oh9OiFAkrVYYkRZ2YtRd9l9iCgfw+rXxMBfOY0D2tR5mlFpYLf
	 40T3RFzpfnvze9ghgFqtHPmxeMMtQoVBGtT8/YOF5xMN/ctU+hAWSzrQ3hy7LgGv5m9CU9nco8Fi
	 Iis5qi02u20puWVp8hZR9vyfHesRuWENRTyKkilEyJwCaJoxTJBxCPNaHJr3U1AYxEjF9ZPinMNu
	 q1td/KyDfyhprZ6pr28OvbIPPCsKc9cMCoFoFqw93yitMiZJ7VrOKJ6oRGGZ0P3EsbyQ4r2A5r5e
	 hRRtAoKW7+uj8ZaYvzReAvRk0Egcx4fRktv4jgZce4GyvOTzOtX76GmpuzhQo/9OPE9gxn10QtCE
	 qfS/2SlrCAj+gdjGNY+UZKDBPBcCmn5tCyXBkegBaGBbHZmviTi64iW7eHItBx5hc/k1N0Bu4mwv
	 kWRYhUabIi+DFhswUhR+P8iyVmih13P1MEM5R3WYpkMsPcn8mSo6oy+qOlAbhYMHK5HVV3l+469i
	 3kHHZp+0zR+L+afwjpGw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_syncpt
Date: Tue, 20 Feb 2024 11:23:48 +0800
X-OQ-MSGID: <20240220032348.2051875-2-eadavis@qq.com>
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
index be17e3c43582..eb60862dc61b 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2665,6 +2665,9 @@ static void txLazyCommit(struct tblock * tblk)
 
 	log = (struct jfs_log *) JFS_SBI(tblk->sb)->log;
 
+	if (!log)
+		return;
+
 	spin_lock_irq(&log->gclock);	// LOGGC_LOCK
 
 	tblk->flag |= tblkGC_COMMITTED;
@@ -2730,10 +2733,12 @@ int jfs_lazycommit(void *arg)
 				list_del(&tblk->cqueue);
 
 				LAZY_UNLOCK(flags);
+				mutex_lock(&sbi->log_mutex);
 				txLazyCommit(tblk);
+				sbi->commit_state &= ~IN_LAZYCOMMIT;
+				mutex_unlock(&sbi->log_mutex);
 				LAZY_LOCK(flags);
 
-				sbi->commit_state &= ~IN_LAZYCOMMIT;
 				/*
 				 * Don't continue in the for loop.  (We can't
 				 * anyway, it's unsafe!)  We want to go back to
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


