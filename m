Return-Path: <linux-kernel+bounces-12869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB081FB73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BC81F24507
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B610A0A;
	Thu, 28 Dec 2023 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tJEcP401"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A710A00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703800865; bh=FbL3XUQGG36I/6CQH5chH65yLqnCzzZleBtliZ9ep7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tJEcP401mJjpcbXt420oAZpUf1FU2VZx8zswdQH0x4WEFsc97949GCf6Dg+9O48WG
	 tF+rX5VJjyLXIT47jlEin2LE7ZJbxStcAhqWo9jVIrzkMoyToZE2j6oF6bRsoZCP0B
	 7qGwSxpj1rTdx8+yQMAbVg3kRfkVCUcvejOsgiTs=
Received: from pek-lxu-l1.wrs.com ([2408:8409:7810:45b:788d:ee9e:1fba:da17])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 431E6FF; Fri, 29 Dec 2023 06:01:03 +0800
X-QQ-mid: xmsmtpt1703800863tzhjl841d
Message-ID: <tencent_A16363296CC3BF645C7762576306DA737405@qq.com>
X-QQ-XMAILINFO: MeB5Wo+JmnrbHp8YhYt8pWysVqY3GasZv29YWYaWew/nKzDLAGXgaDJ5CvCkaR
	 3mYZFkcuVzwPo2b4UME4SEAQTfA57bazxtsI6vwJpC2SjLbMiKjrzrpuyjTPL/8UBgjUmX5g4P+B
	 NUJKwXAxa+n+tbPJanGMJAKE1dB6VTEQD9DEYxz/1eBtfL4aI+xJOX0J3eO6zQbL9Vc/ovNez5ka
	 1c7YpQBwsTLtbNzay3GvE2O+izAGLkfOoPZ4IasOv95vAtbAyEktobET/V298kYsB6y4Hokx4guO
	 2sxO4toPPYvlsfoe9rxoT3XrxBg3hbxToPyD6xjR9xoU7f0mydiDNdxB4GtjfzlNui92jbfU027P
	 VbMFoA5yKrRpgiGLhaE9ABmeLaWVR12u4+oAQi5bfxGchYeTDhceox3Zh+qTASOXlDhqlnzahR3X
	 xcnuaw8pWireTRwcxTYHDn1Yky2fxBZ0xXYaRif5k9zkix5TbgPHiS8z7M03tLUR4OFeY5eFdk3A
	 8+DRg5tDYUV6fxZ1xpX1ue4uHHT9z3dJdoqYOgs4hE/tdfLTh2Gs8HAeUv3Bp66tpFrPbqIHhdOu
	 4Jgj5e4getyNtXhbvrBG96Cd7nJ4MP2k92RvmZh15IvNMZB9RKm+eWlp75jrR1OzZFFTCM5xitg9
	 onMog4s3OduCBDdoBXWNlPM23k/FIhG2bNN/7U4RWU4pQ2CTO7TLKp65elHYHK9C8NeFKndW1XWP
	 FV39W1Rf9HCWVctxNfsCiLLi3ELdsvSqYAL1fQ8JoWP9T2WNQkXeZ5D02CVMdYNgrElWrXjvi4VG
	 swBNHZD1QPlkvYUWkuwS7e/oHCxideSvtCB+Cp97vxTmHeQcRALKtOwwO5F/8Fe7FrwO97/MQz2h
	 9e41k4M2JqrJMFX5FzlSrt/OsqeFJEDxHKwNFgzKHNmZNHS796BDeD5bT41xWklWJlDS3AzKwR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
Date: Fri, 29 Dec 2023 06:01:03 +0800
X-OQ-MSGID: <20231228220102.215226-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002cf943060d8f4e3c@google.com>
References: <0000000000002cf943060d8f4e3c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in __hfsplus_ext_cache_extent

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..9d4ffff6d42e 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,6 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
+	fd->key->ext.fork_type = 0;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 3c572e44f2ad..6681e3a24f29 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -206,7 +206,7 @@ static inline int __hfsplus_ext_cache_extent(struct hfs_find_data *fd,
 static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 {
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	struct hfs_find_data fd;
+	struct hfs_find_data fd = { 0 };
 	int res;
 
 	if (block >= hip->cached_start &&


