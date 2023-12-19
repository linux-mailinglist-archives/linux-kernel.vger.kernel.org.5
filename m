Return-Path: <linux-kernel+bounces-4881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A1818344
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E100B2312C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2F12B78;
	Tue, 19 Dec 2023 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eDX0wzoM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E512B69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702974216; bh=0nKf0H7sW3huBv7erE6RHP5mPRQfhe5OqEinNTLy83s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDX0wzoMYXcCRG6HZq2wHQx4CNhx/oHJ8q/zldxZG6qFM+QLU+K/ujhdzRwnbK+Up
	 Z+Dbj3NbshQLuJQDLtjANHeE/ENLENenhrvm1sSkNACC1AVtG6+9XDn3z9H8UgPgjs
	 uaBCAaSxyViVPPOpmgQS8OWxHbMAXC+UjHSerIA0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5E21C8A8; Tue, 19 Dec 2023 16:23:34 +0800
X-QQ-mid: xmsmtpt1702974214t9kl9rvz2
Message-ID: <tencent_9AECA6CDE47A4E6E702CA96FEC95B4EA3E0A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtGGpVwAypGJFznCRNod5ZwYNl0gGu1KAsZLI4SJaCFtBaHm5nuL
	 ZW0i5KWw3GlWZ6Uk95GZa/tHABIfDZ3LiQ3YToH03QkPmBPFxwKx+Wc1MqvggLKCMoskPLoEAaAM
	 Eme1kVOeQWoLaZfWySSb2Idw9Mgith6rZsJ1y1HQUNxjTjOILO/a8Lu0KqzLgGYKq4pbKdvlFqod
	 2/EQ1heyBZaPecX9IRwHTBazLJ6FlJbHAp+mY1NCJCjay9LNdKEY9Na9hNLbEy/DkiHeXvBXTXET
	 fxgNEzQ38YdbmnVIZz3adbG8A6JwrHv+jdB/Poz/vv4tyrkjqrKn9CnjA1d/BRqKK0i5yQ15xcTB
	 nIdlOpwNkCk1SF5GoM4rkmA6Fbk4sMTvxK4AaLICaeKcTyXyHAxmCKdTuwYm66f2I4YOQ3QdlqIo
	 V+Nkzr5i7BHyj74SlUc3wnR+y5dZLXw1AYsLPrM3++qjkxZrskVtBa0ijWF/OYjfaO6dOvIwCbO0
	 0vyKOj40eSOmCTZsv59j85X3ABokM7dil98f31ISSa7TlLTs+vaVTX4fMMM+raGaJGIWu/SAnB7y
	 Pw/zsZmBZps3NGJX+Ngz689FK8lwQ1yJKGPZ7ViNZe3rJEE4v3jZfQP0s5rpQIS2Nyx7oFSfhhwx
	 l8p9V0cnWBQET7U41l29m2vvm+j/tyTCmiZXhbdGR0I25010hTfQjesSVI3YMWOYbGzhPd0zCMdj
	 XHLfieLw84qTDZwgHKxLNhKtwsjWYyk5ju2HZ4n7ndsOpc5ke2UQ2VJ4GvJM6oDsGkhglXiWthQn
	 Kwnqn0SZ2M0wWjF0XTlBmce6Ac7vNND4Nsh4Q/mM7zKMmwTvaqUhfMhMoF9UAAgIqwQKBrgl+9Ri
	 vA8KI2JiA5M7mkP+WOtAwzRqJzIGQ/8/jmlo4hPSSEgZ1pTJPQOi2/kQrtBot+iCvio6yW0FJOSG
	 bLK7QZbtoGtwTkMrjE9teniIwC/PqQ77rvkah0MyPTXi0vHN0RCA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 16:23:35 +0800
X-OQ-MSGID: <20231219082334.1962826-2-eadavis@qq.com>
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
+	p = memdup_user(arg, 17);
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
 


