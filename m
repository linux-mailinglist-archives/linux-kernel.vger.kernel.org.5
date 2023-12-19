Return-Path: <linux-kernel+bounces-4981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C738184BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016991C23AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BE114A92;
	Tue, 19 Dec 2023 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RmULgbRO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7614A81
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702979192; bh=EHuTVFe0psa/eENq4ArQJZ9JmWC1Lh/Q3+g2gf0owhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmULgbROqYvyhIjUxvVb9QYlZwmjmZVBbLmeZU/JgobseKN/QAQ0hK1A8T9Y0XzTJ
	 WG8xW1woqxAK/bPlI0IEw2ly2YwMTjqCWxYrw3BEsAmSko2vgBh5YKIu8W7KYhwA8D
	 CUvV1ZvpupJCNj5Ls0WHbvJa2aHqlZilWves9SrQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id B9E8A2EF; Tue, 19 Dec 2023 17:46:30 +0800
X-QQ-mid: xmsmtpt1702979190tf78g1637
Message-ID: <tencent_B6953CE9AEEEFACC2C788A6D302F656DD80A@qq.com>
X-QQ-XMAILINFO: Md1mxnKJDwB6jhS20nPKa3UtPjwCNPut6wHPFkreObgOlAHWolrR0nPP9nNACL
	 0vVXv1FWegnOY4xV34aoUx2YpLdPdyWM5LR7OyF+uLtp0IrK+scv2vxKTD/OkMJDo9dxxXtqy69/
	 ls4tEkK/pwStEaD8awvJlGLAHzNYndgkhERrsT6dmWDVI9RlzisOo3bgkBr98nG5mhDR3rhCRpvD
	 zKCclFCKuPF/1ZgxWpuQR1gOs/QqmR20w4P6jnEttFgfDNeVEXZ+6NYOetDaIJZOg2BwsmkUi4n4
	 Z0X0mCdRVUy51jHfNaWfKe/o3q698HXa49gJ9hUj/XrURtphnpvdG4uFlP6smMpFYeoaPvpFyJ9V
	 Re5AqpWD5YGx25Kqd+yWYzXrOmk2uHXBowuywkXLdO0eCzhpvR8+umrFNNaysjzav7/MwCbkbRjb
	 VMGfk3eivAQx5Oszmd9aK2dF+Ghxpe7RfzuULB+RAORoj6pG1x7p2Dk6rvKe0+vAkAZDv65ZgEDR
	 P5lppGvO/1y6aDAxMbLKtSvm00CN/RNCKkNeRSRJ5RbUTG8ywh5I6ZmZu6UeWtAH8jZJQ7DzVZK8
	 mDEhhtDRlQjkxQExKLHHY6lkn/RVhCXEozLV51Hn5kLiFWs/6oLf2QlJwAyNN5qiiEi2udfd33iC
	 O0l571P8A6DvevNpC2E2mkv+/RiqTug1PGTmVxirsESe1BGKRjGkduFx8uyIl2kFjgz/4JWTOWWB
	 58j9kyGeXR/Qb1M1AAkryZrEavEHBB6X2S3cmmCKh7loJZWrHuxMFNDZjSLMZFl8rNm+wSlQDtF/
	 urjOgqqPGf2BY1tRv7hnLVgHaBx+JZpLrGLX73kWpbOPGHo/OB29jl5+weXn7kSLYngyfo6h70+w
	 AJUSMUUVE4m/lo8b1gVPEahkJVid3N/6G7zh0Q2ASFp8yAGNM8eyKJFtHVyO0RL4GGqNOIBt0QCc
	 ZGIDu56WaAF4mB7/EnxOH65updFhlD2zniTQ4UKvGw6FMI4G2ybA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 17:46:31 +0800
X-OQ-MSGID: <20231219094630.2030656-2-eadavis@qq.com>
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
+	printk("l: %d, %s\n", len, __func__);
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,


