Return-Path: <linux-kernel+bounces-4966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8BE818477
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6151C1F26585
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159813FFC;
	Tue, 19 Dec 2023 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wbbvqYUa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AE14A92
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702978008; bh=elkpKXS1pqxcZhfNDJmp+MGflnUCTd0/G4iZBGkHaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wbbvqYUazWaZ9CmCGP9dlPlO8O26fHMO53sgcFy2kAlsAAN3d2Cg7+q4/f4H+9sGA
	 5yQ6YlzC9m+P5YdfUL02NSykgecOPDifJHNBzUQ32nTP603Ar76Ez3U8n1tMdDggHN
	 LPc0JNpqw4Jzd9LC08ShihsHKvirROInSBPvlPuU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 6AE86075; Tue, 19 Dec 2023 17:26:46 +0800
X-QQ-mid: xmsmtpt1702978006toi2n32kk
Message-ID: <tencent_6C9D33059E4C1B544BDB1B472576BAD9BB08@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIer+hWI+RaEvjHLg66dkCGkHYkIx4HgcYr6AhsvKTCuQFy6jjg5N
	 kw3pPgQCZ+hIj6RO0+QG694ghKABHyGjmlTWD42/esNbCjNYG0EuzHq7yLAaFE7gD4ZzD77tmk6b
	 Jeo5Su/UCSSSyJmPx2tXxEHQIo1yLJRLJtA3v0l21FawBt63v+jwQnfv5aJWK++iHA0R4Aia8rCq
	 aNV2m/nVC+Dffb1whJJR7iJBwGDHt8zj3gFEFoNyyhFlujg/JTtThNWTIYKR/WELKckQg3E5p69r
	 mMx03bHTrprWAH4nQ6jSoeMA0eI0RiXj48TSn5ZuCZqCRU+1q9UfHg6K+bioi9eml5botDxN/hYl
	 AJwJoNdqrO8blKXHCbY2SM6zAoz5nA28KcFQu//YOfA2kJMQGMNsU82/Un/IjtWXNy85nwlUnCv5
	 e7LJfmrwdbH4ylIRkwbXjL+I+3sKRZ+4y8L6gwO6qyPcKWEnP6jjSqsXfoR5g7faM8BUWAFytz6r
	 Prgy2S4inzYq/gaNawz7SAf7yYVERQaNS331ngVM5v9/u4RHSForHAviV17f7eO98OTFmds8BfrQ
	 AapabImiQhG9uS36cEsh/m9rkon5Zn49OqpN2vO3y8AgfiAMRXNzhPQm52tEAyiTIU6+rTZAojVf
	 s7mwcjv1c4kCLhNOhtE6OvvXU/gLqdKK1cOvHBTz+mwDT4ED9/hRPvUX40hlbqxG3LicCaEyPjHO
	 KMDN5azqNbO5IivzbQdKSOQYfJR4tfOPiUCc4JyqcjsFB7tatccg882Pr0FJViOPMGr4pMCVyJg/
	 zBxNOKvyw8G+YKDD/poDFLwJn5UK6RMxzi4FXDcJ7iGa/b1U0cR7YgMsJODzx2IOezdPIywJ69AW
	 Pf9tncsSiXfPrAPoCbCqO+mEj/BI4g8sKmhEgVXOPXCCR8UUF5XU7VbROwYdQp/KsvbEIHYT5PVV
	 vHmSBMEGG6nH2Ds1a16kV8cGFZ1QkSCZREww/HcnVpOGxwe3tARMtwjNJMrUMP
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 17:26:47 +0800
X-OQ-MSGID: <20231219092646.2015274-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d1a1d1060cc9c5e7@google.com>
References: <000000000000d1a1d1060cc9c5e7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in getname_kernel

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3bd7d7488169

diff --git a/mm/util.c b/mm/util.c
index 744b4d7e3fae..2581d687df87 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -194,7 +194,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN | __GFP_ZERO);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..8318f6a21b3d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
-	int ret;
+	int ret, len;
 
 	switch (args->start.cont_reading_from_srcdev_mode) {
 	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
@@ -740,8 +740,11 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
+	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
+	printk("l: %d, >%s<, %s\n", len, args->start.tgtdev_name, __func__);
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,


