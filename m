Return-Path: <linux-kernel+bounces-10276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA181D201
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF4A1F22457
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D59F1376;
	Sat, 23 Dec 2023 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RuV66sS/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CB10F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703303622; bh=1nrVHvyS/LVOmQXDvQQQM8sNwOU6LkRwG8hehapmtTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RuV66sS/Sx8tG0VFIfVHgZZR/vqE7C0oqH+nE2uD95gpVzMF0fzACGJP22UPkSgQk
	 v13G+/OM2PUBw5MgUYWmhfOUtXUCgSL8yhCIAG16C7nWak1C84YVKec2S2K40s1rKG
	 fPKu/9nYXkbrel16+ib7B4jlqFVH01md3k9QKFyo=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id BE715EE5; Sat, 23 Dec 2023 11:47:39 +0800
X-QQ-mid: xmsmtpt1703303259t3nx5u840
Message-ID: <tencent_8FCF968DD725F80DE712085DC4DDAD993B07@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNojI959x8ksgH8DxWDjxWvYK+m+b3veqYfN+j+y/OdYfQfX9gTyV
	 O0tJZ8OF//FEseldDip17Ur20S3jjaO8O9Z84+XzQtVtPX7aJnnB9PqiGpJfv5OmEWgy88nDDZC8
	 22rpNQLqE2ZufRx24IiFQzp4xjLrSCgUZaTeN1VNbuHkCGCaSWXmhx40NJ2BDdm+mUk6w12vf0QL
	 hT7NYkVdAB6t6Sw66IbuTtuXQm6t43w7V+ZkAYUvhU9PQH1GqDPliPl9DO0ukepJvg+Opv9N1H7w
	 1uYZNrv1P5oLyCOFFBBqUmWQn8T5NUKboE2p9y5hhHvqQisIQBdGLfoTIyP3r8RX2bfrlw+Xk2+p
	 UUcT+thi9kSo0/mx6z6THdOOriMIi77hibGpB9tl1QaYdJ+XRi/XSLrcgnQFNZxxRVb+28qbi1Q1
	 Ge3f8JrrvOH1DcXEsetiqefzJw3pOuAOBNUXgYPGN3KQI5I/ha4Gj9Xy5C7L2UdC9TYekHm0THFn
	 kwIJv6hz4qKmcLlpJRZ3YvZLMTiTv+hQw+7qgsVXJHyd9XS/W/265SYmwf2g6s8F9eG2T2g6Mbt2
	 nrpFpABenvzAVbvSjONQD8Qrb6737ubyN2W9k5v8UZSCNja7vdDiCezwWByG7AlIP9UynZl3jXY9
	 8biJdlY9xSJFwnbBv8Rza1ZOgRIiy2Mg+TVn/IfSsQdi42hOwRkZJmLgBOYUaImt4pbn6gzAorkx
	 BCH3z1geolvmuoj8tjYPpJojFt66qiOAGovyGZ0K2Roboul5Xd+9Sitm0LFEjOmHtdUEtkmXC/Yv
	 7TsBk4P0A1zd4UQ3rUVZ9h6n616YQ536vdCV4uoR4okfiaiLSHl7jVW0h6CdQzGN1OXC5pUuhETO
	 LQwwDzTTIuhFaF0z5rc7KaIye5S0+QtwNmLtGF4RoFhzwdDsHmlAc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] WARNING: kmalloc bug in ntfs_load_attr_list
Date: Sat, 23 Dec 2023 11:47:39 +0800
X-OQ-MSGID: <20231223034738.1912969-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000006ee8fe060d16e2a5@google.com>
References: <0000000000006ee8fe060d16e2a5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING: kmalloc bug in ntfs_load_attr_list

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9a6b294ab496

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 7c01735d1219..e631ecc1b9df 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -53,7 +53,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
 		/* attr is resident: lsize < record_size (1K or 4K) */
-		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -91,7 +91,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		 * the result is 16M bytes per attribute list.
 		 * Use kvmalloc to allocate in range [several Kbytes - dozen Mbytes]
 		 */
-		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 63f14a0232f6..49e660be9a0f 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -660,7 +660,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 		wnd->bits_last = wbits;
 
 	wnd->free_bits =
-		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 
 	if (!wnd->free_bits)
 		return -ENOMEM;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..87778834aa9c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1413,7 +1413,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	bytes = inode->i_size;
-	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
+	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL | __GFP_NOWARN);
 	if (!t) {
 		err = -ENOMEM;
 		goto put_inode_out;


