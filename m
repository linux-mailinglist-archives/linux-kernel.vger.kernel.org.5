Return-Path: <linux-kernel+bounces-62583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4E852348
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF62282604
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB121100;
	Tue, 13 Feb 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5LeqXO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0D1DFFD;
	Tue, 13 Feb 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783536; cv=none; b=EREc2k5kDqdcj+k1TqZwwR3TT65+aDP/ix7SqpWZKsfGLOxUREIRHL1qKo7Aa0D8ly1l11ldfzj7MgssB27LtI5TCPBxXC0vPPQrQ4EXX1kWnEymcvg4l3SJ1kEmKjW28Qf066CJN0RWp9EQQpeIHgfFAiRMR2tJGFLmjIw5RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783536; c=relaxed/simple;
	bh=REzDn3RSSWeWUryTzUKvYFcyiuK/4SO5GdHw1TcHdog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHCGvpCBTMqUkF8LYFHdx+sBkXtGKo5PH5g+26QiDzf/BiW/qx2vN+X1HeziZw8vQTwPKLibgP9o4OF+02tQH5B0iwOZbGjg9Gjvk70E/ZWRdiU1DnQGMxtn2Fp5wZCOzqDpn596T5sn+AZJ5haCSJnHoJI+3C+gyEd37jwj2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5LeqXO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6889C43390;
	Tue, 13 Feb 2024 00:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783535;
	bh=REzDn3RSSWeWUryTzUKvYFcyiuK/4SO5GdHw1TcHdog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5LeqXO1RiIp6hyTSmEhZBH3EiJfmwQPo0/PMH2meg7Hj7GJ2ejPhobA+jEV0uaeY
	 obYfB4xVA+S1Y3rBWuAOVDnse6A/H1RFG7JOkGC6ZR63qBlddoNv9+vGoEHV6FKGuV
	 JGRJ5axso1L3BW2+8XJHkYPsBrZ5I8Js+rYxzWMkUTShoa9wkwnTmXkWzR4KKeQC0B
	 0GbMAGYdzcWJmKNwymzmxRL+d/QgzOSgMm0/Fk8tjDPl+VyDIPMctFk2P8TJFT+QQi
	 GnRfkwiAsRMG8gPUTIXm7oWnCpI8SBYJt+m8dq0nAyyB5EoDIZ/EFyJCQ+xx01mTnT
	 2ZpSBwPkkCBsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 14/58] fs/ntfs3: Add and fix comments
Date: Mon, 12 Feb 2024 19:17:20 -0500
Message-ID: <20240213001837.668862-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d6ca2d253900b9b0a3a1ad77541d606010f5e5eb ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/dir.c     | 4 +++-
 fs/ntfs3/fsntfs.c  | 2 +-
 fs/ntfs3/ntfs.h    | 2 +-
 fs/ntfs3/ntfs_fs.h | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 726122ecd39b..9f6dd445eb04 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -536,8 +536,10 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 			e = Add2Ptr(hdr, off);
 			e_size = le16_to_cpu(e->size);
 			if (e_size < sizeof(struct NTFS_DE) ||
-			    off + e_size > end)
+			    off + e_size > end) {
+				/* Looks like corruption. */
 				break;
+			}
 
 			if (de_is_last(e))
 				break;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 350461d8cece..321978019407 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2129,8 +2129,8 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 			if (le32_to_cpu(d_security->size) == new_sec_size &&
 			    d_security->key.hash == hash_key.hash &&
 			    !memcmp(d_security + 1, sd, size_sd)) {
-				*security_id = d_security->key.sec_id;
 				/* Such security already exists. */
+				*security_id = d_security->key.sec_id;
 				err = 0;
 				goto out;
 			}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 13e96fc63dae..c8981429c721 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
+	__le16 name[];		// 0x1A: To get real name use name_off.
 
 }; // sizeof(0x20)
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7510875efef6..abbc7182554a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -874,7 +874,7 @@ int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
 
 int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
-extern const struct xattr_handler * const ntfs_xattr_handlers[];
+extern const struct xattr_handler *const ntfs_xattr_handlers[];
 
 int ntfs_save_wsl_perm(struct inode *inode, __le16 *ea_size);
 void ntfs_get_wsl_perm(struct inode *inode);
-- 
2.43.0


