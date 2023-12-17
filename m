Return-Path: <linux-kernel+bounces-2486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C3815DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76EC1C219BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A4185B;
	Sun, 17 Dec 2023 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aRhxOXEE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460071845
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702795944; bh=w2iNoDx0ol/reh7PH4+1e72SR7ZZmu1KnDFAPGv04fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRhxOXEEE29L55fMkh3Fc3hbCHuPWya74o2tAJPfZ/y5ZXaq6Y6iX/YHnoUD3vgZx
	 Utl/7gSOSB3IAtCGPNE1eYp5+/E4/U2CdkQkkcIX2mWSzx4ZLzGuGDJJnw2plOhcNm
	 /lR+ZqFEg5rwBb/jvD03hsYnntnMa8C6gUYegEIY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id AE539AE1; Sun, 17 Dec 2023 13:43:37 +0800
X-QQ-mid: xmsmtpt1702791817t1gmkxnu0
Message-ID: <tencent_5BC6CF6C79EE6E5C2E016F209494EBF2EF0A@qq.com>
X-QQ-XMAILINFO: N4ZILu3POr3O743QA05SwSLZRuryDcO7m5wjU8mrs1y+/mxWeK/bYSckruN209
	 Y2696Lv9aYod9c7kFjK3gzoThyQVbIwFQ2fW08dQ6r28WybKJ7Pvgiq4qiike0y3SJ0eW6pBVMnR
	 sVSWqvBqptqiP2BGf73JvH/vYtFnAgU1j4QEUJyWZuzWmOZ9Ita3H1YhER7lgEOmrfvFwp05Qd57
	 RvLdgYOfjkCqyCwLtvI/cYU8bGMABYgXI5Ne24j7VhEN3PjfSdwvxziU69I9WqPY/OrNdtX4O9gj
	 qGH45iYjsblTZXLQ2VUjXipc8YGH5qcon/Gk3F6dSIx5OGDpjTZqrLMAaLL0Qe85ozIkjITc9jjF
	 8bTFDP0UqyQVTf61rtCwmL4IaxXoKsGVi/AgxX4wL+6Z5ZgfqIiz8U2a7mcTobSVAABQwVk9qd+N
	 qKgn4XRC7CDnnG1XPVaLEf5hNC9pnOpFAjwR1Ez8YE7zmvyk7v7bfUhQGkuMbLyXNOo3evrO95by
	 8rdlcyGSpmlgZlIpcEYHOcauRyTgOZ1VBk8LtDsydMzXomQtoX+9B/0ceFMI7UtZhukIaQh1f5/N
	 qPZpzPJ3znZjOQuT+ItgZ+1bU+yDct5BLJxTKci7D3/FzU4xD4+MW/xLfh1nyz1/fLZRXNRCKGrh
	 Vkjt8qPY2PK5uujfn3HHp1oOQesx6vbpERt1ZJ+5sIqmrT/sfkYlbihI8KJPOrOkSCNat4hcvFCA
	 M2/yn9ISThcFn+ViwUjPSJNeNmmwsM3GOWnWKAnx6D0gS7rtOM8LLxNUJtOEGXveqpMhBo8z6QTp
	 mTmGxnKzBQ6NiYRgi3YDNHNY4iDkU+YLdD1sT5MBxcr8CPIcbCd+HkPDVflkd2GUZSS8RKcyyXCM
	 aG3/3jQ/ed2/bSBF5ugX963d7SiU3Wiu/w8VsZ2nUUXrtR12QdJp+byp4EAiX8ob6ByGVcxuJ6OA
	 Y35O2L7PSt7pn0p8VolQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
Date: Sun, 17 Dec 2023 13:43:37 +0800
X-OQ-MSGID: <20231217054337.4008486-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003362ba060ca8beac@google.com>
References: <0000000000003362ba060ca8beac@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test BUG: Dentry still in use in unmount

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3bd7d7488169

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..0348ff4374fa 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -731,10 +731,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.rdev = c->stat.rdev,
 		.link = c->link
 	};
+	err = -EIO;
+	if (lock_rename(c->workdir, c->destdir) != NULL)
+		goto unlock;
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
 	if (err)
-		return err;
+		goto unlock;
 
 	ovl_start_write(c->dentry);
 	inode_lock(wdir);
@@ -743,8 +746,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
+	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		return PTR_ERR(temp);
+		goto unlock;
 
 	/*
 	 * Copy up data first and then xattrs. Writing data after
@@ -760,10 +764,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * If temp was moved, abort without the cleanup.
 	 */
 	ovl_start_write(c->dentry);
-	if (lock_rename(c->workdir, c->destdir) != NULL ||
-	    temp->d_parent != c->workdir) {
+	if (temp->d_parent != c->workdir) {
 		err = -EIO;
-		goto unlock;
+		goto unlockcd;
 	} else if (err) {
 		goto cleanup;
 	}
@@ -801,16 +804,18 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+
+unlockcd:
+	ovl_end_write(c->dentry);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
-	ovl_end_write(c->dentry);
 
 	return err;
 
 cleanup:
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
-	goto unlock;
+	goto unlockcd;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */


