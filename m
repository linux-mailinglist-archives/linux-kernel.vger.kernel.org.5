Return-Path: <linux-kernel+bounces-4886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2281834F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0748B1F24505
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3977125DD;
	Tue, 19 Dec 2023 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P6pLnD72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58511728
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702974460; bh=4wX4sHJfzJszxr4jnIz5T4FHA/zCdlXbTuI+duBBW24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6pLnD72A0UovRKjlWuAnxIAC48wO3ng0kz+pWEewrR3ExCPA0jX9cmwSfmn5tGZc
	 l4Dk8aQ/PjJhNkzkBhS9lSXDclssNcHW1HKHEDbOVEOQh3+8/a1b+XuOq/x7myVrRB
	 ij0blviLfnroO8jcY6H5NScrzp5YzGAezMtkY28k=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 6E718EFA; Tue, 19 Dec 2023 16:27:39 +0800
X-QQ-mid: xmsmtpt1702974459t0g0vxihm
Message-ID: <tencent_23960436F84A82754D76C767CE3C75373809@qq.com>
X-QQ-XMAILINFO: NSmesZGuqQTYWxS4J0JQ/kbswCSFaDFMGC0XdUTPzSWO//zHRHXXWN90BGuY4/
	 LoA79OICkB0cEpw0+6RQI4+AEBV3PpWtq3hCGYTh5jRBLB19jwcpOcHi+SmH7rV+2+OdJRXN5c9L
	 agIjC+D8nUeSxBPv8LVGOli2bzvhkcXxfvDgp9Fq1YYSQ7S88kEq3P9pLfFWUgnvgoMpBqVO8aPw
	 otw3hSzCxTECG8Y9Rk0/ThG0/QdY9dGy7qvKDz5IEs27HtVgYNWVHe+Xl3Fn7DufA940mPE/L4sX
	 miM41wZCu22ExL5p+qpzOfxV3S/WP5/U6otiKjse/3RXbjtPnj04/aiOfi6hOMWkqKML5TNrrDHS
	 TtGTI+sbIWz3ULEGDMqB58kij9bSo6BOBNQyfK08APH3TKen1w2eABA6rc4m6tJOjGyqU7zIcjze
	 MO21QL3WaF+WqI7hAq2DPJH3IilxY65gLzHZZ52jCbd8zaxMacN5yjhhBdHTyNoNdlW89vphbNf0
	 PAasragfXiurrcsdmMl345U2HUP3d1Ofwhcz0zIFX0PM/lLF7BzpgGq9u17afryEmmYsU84XIwfJ
	 LbEYknaL/XHlQ/VwdCHKESAdQY5F+Kbjj1xpec+YA2gJmDdfbLv8hrDBN6Vuw7fac76wvOCbSI9X
	 qzTSUTmSesGd57Cf7raBEufqNlVueIvsKqkScRaFQNutVKS87kO8ev/LgOsCckuV5v1yiAHWdIRu
	 n+T9hOsBSLJJWnmHl9RltcC2awGEAiz+DupVQ+wNC7Q9Vttqu8mpF9A2sgYDQJhjV7QbWwtg4cUC
	 gLEZbWCIpy8rTBVuRUR/o8Ur5BWLgpZjKNHhSlrYmuu0QvY9KGldDC9BA1ux3inA+CTyAxIFuDxI
	 +5d8UlV94MZNboJzp7Tcm3wI8OInEzD7akCwbMMgNZ86SmkejjAtdiiZCY5XRyvtwtTGqy38IdQ+
	 +GnUmwEfhVmMYtKfOqy6y/tpjn+MapnzQYFGd+vcAPehyXaYcCefYQqiuLzzUD
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 16:27:40 +0800
X-OQ-MSGID: <20231219082739.1965565-2-eadavis@qq.com>
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

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..31218d3aebe8 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,7 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	}
 
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    args->start.tgtdev_name[0] == 0)
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..20822e62f8b5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3283,7 +3283,7 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	p = memdup_user(arg, sizeof(*p));
+	p = memdup_user(arg, 1042);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
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
 


