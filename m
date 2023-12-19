Return-Path: <linux-kernel+bounces-4705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC28180D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182422858AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB48480;
	Tue, 19 Dec 2023 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j4ic16nd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A88472
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702962704; bh=5Gpyb7FWFsWFLEJNeHkrED5LPSV+skJktLZ+3cLB6Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4ic16nd6/EkTfinvdyArUH/Vg90ZM+9MegogxgKHO+EwoxEEAU5CeAUUAoKQKa/n
	 Ap7PT5uxSeBuLzqyKHNlZzbpG5jrxvOUKbYGFzvHDYj7EtPMPP8Pa11B79QSEmY1fM
	 A8HWAJH2+qYSUyY4FmilZBRNO3G8PESmwGrD2eeM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id ED53082D; Tue, 19 Dec 2023 12:59:21 +0800
X-QQ-mid: xmsmtpt1702961961tum9663v3
Message-ID: <tencent_B8D761176D66C51367E368496703B5045805@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQe/ZWzugQ8nDB1qPxlZ7xl4VBYyoq81CuQJDLZZUF4+ZZxgqNQ3
	 zQnVQDZrJkgvC9FCf7zUZjTpBCFMNZA00bCy+ZCg9WIffDf2K5FyGnaQrhUXkTv65G0F1HOGUuyd
	 +u9nn7tp4BpnbUB0Jxd7h3BIlMdC0H3AEQZ9SMQeIHzalzliY2icF2/u1P16NQMgc9ccAnQTJO+g
	 BcEAx78UfSmwNZWrudrN+DV70ygNDhxtA4JwZMBoCvX77WjTIZD37FNRZ7nG55ymCz3NV0MZjkxu
	 arFEW2RrEXP8yMCRe7lAxdq7Sdy1KXnG7PJU41ENSvRji8OV6vv4kSn3SSxOb8Z7cUja/PXLSQrK
	 q4v2BCIM+AvxU5YTtlyON/xL33ynzsrtomjYeTvyfpn9pu2blpODnEyAoijlWt56kxPCx9JXh32R
	 h4NnSCper8THjff69KynL9nrdfFq3hv2e7mNtJaso+rlPHs7c3UZOyzPQLUWU7NUyfYgClb6jy7e
	 ICDbAfRiTIjUH1v8wch9ZssIGP6a0WUOs5ZOOAsoA+VdmIYNXrkbp3PlJ2qimAebAIjxK4+92LfC
	 kaqz6sTPZxzKmnjAE3ZGpKUFKcBCL8jj9dVhJF66906GSQY4dtA36OyGuOjNj8QYeWwG8FnAeCb0
	 H5/bsyTIcaDFD+D1OdsVuAA2llfXVNDl9pb1tfUQTIM6G3onYZLded6oB87ZgBD0ASCd1G7OqbAA
	 cp82Mwbfji9ugjGtQHZ+427mGPVsBRsojKoMa0YbaHcJg4TrEDO3ffRJgd5YFY578CmOtgAcc1Il
	 xAiEofujFqursbMtnVKB1s1W6+1XgTbyZSogaxrZ76Ucnmm/0ccg+P8Um82b9YxbXzhcBFcSGWGJ
	 zdgqiec2+Eh1lx+IhPot5pSkQrlMy+K0uKqKMDaKAT9ZP/i2+3tYMonJdC17wki6S0+DE03ZjXbu
	 /LgwdxlJs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 12:59:22 +0800
X-OQ-MSGID: <20231219045921.1746796-2-eadavis@qq.com>
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
index f9544fda38e9..b7e8392d34dc 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,7 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	}
 
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    !args->start.tgtdev_name[0])
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..43a508cea759 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3272,7 +3272,7 @@ static long btrfs_ioctl_get_dev_stats(struct btrfs_fs_info *fs_info,
 static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 				    void __user *arg)
 {
-	struct btrfs_ioctl_dev_replace_args *p;
+	struct btrfs_ioctl_dev_replace_args p = {};
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -3283,11 +3283,10 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	p = memdup_user(arg, sizeof(*p));
-	if (IS_ERR(p))
-		return PTR_ERR(p);
+	if (copy_from_user(&p, arg, sizeof(p)))
+		return -EINVAL;
 
-	switch (p->cmd) {
+	switch (p.cmd) {
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_START:
 		if (sb_rdonly(fs_info->sb)) {
 			ret = -EROFS;
@@ -3296,16 +3295,16 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 		if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REPLACE)) {
 			ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		} else {
-			ret = btrfs_dev_replace_by_ioctl(fs_info, p);
+			ret = btrfs_dev_replace_by_ioctl(fs_info, &p);
 			btrfs_exclop_finish(fs_info);
 		}
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS:
-		btrfs_dev_replace_status(fs_info, p);
+		btrfs_dev_replace_status(fs_info, &p);
 		ret = 0;
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_CANCEL:
-		p->result = btrfs_dev_replace_cancel(fs_info);
+		p.result = btrfs_dev_replace_cancel(fs_info);
 		ret = 0;
 		break;
 	default:
@@ -3313,10 +3312,9 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 		break;
 	}
 
-	if ((ret == 0 || ret == -ECANCELED) && copy_to_user(arg, p, sizeof(*p)))
+	if ((ret == 0 || ret == -ECANCELED) && copy_to_user(arg, &p, sizeof(p)))
 		ret = -EFAULT;
 out:
-	kfree(p);
 	return ret;
 }
 


