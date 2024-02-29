Return-Path: <linux-kernel+bounces-87635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF68386D6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E062835D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7974C02;
	Thu, 29 Feb 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c400Wvdj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A074BED;
	Thu, 29 Feb 2024 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245374; cv=none; b=fZcx6a8npe+BEizWFFGoOPohLBUWDnm9iJtWK/PTS2cP/K5Q0R+PHZ8EJ5rR04ZdaqoMbzoK6WkZsvN/vDkNVrKtr6b5sYbpyYM0xQ7c67cC5A8wpj4uqAt/kGsY1Kjbe7b65hl3uhpoKham3N29zP/mEAIldctO55L87tdvl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245374; c=relaxed/simple;
	bh=fDlp2DkTK60nwwej8ZSAlANPrk7Fhs+s/d381rtEG2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mycX8DKqbJZ/oauZIEJjN01iLEksEe2/GHJR5GWdjjAqF3gvx9mbP9FoQ2XmRg7jDEBX717D6c0lYQqdbWbMF0qj+odIizSF0CQ4+uhD+ROdyustw6f6paXI6XH0vlhIVhHMO4jY2nfEh+xkvZ4m+LnloQBXeZ0+EV/P44M7uNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c400Wvdj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412c3f4c6b9so2483805e9.0;
        Thu, 29 Feb 2024 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245371; x=1709850171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FbmS0/vnMiN5O2ElDtKte3cIBv6R/kEmABEvMifW8o=;
        b=c400WvdjhOx5IsWtPYPzYoe3/rQ0CL034Y1hzqvyl8HCyQwLHd3Lv9M1behCWjSPtM
         geLj7XKjFm22CWd7SUiYB6Ye25LNIv6384W90x2OquXNrBnHklhhdd7KnlM0kbSOtboJ
         ZYkT1O6pKcNofaNTwP9tHK0lkv1CCWI5gd9TauTbhMl/sP8Gn2yG800LYBdJ9kMXeVj3
         snP1WRqqZMI/Lq41G0J1Fan2RFa+DHE5UwHJNZaSqVzR7ygLb9Wu5Bz+8XOb/UAo3VDD
         zO+28KnUBU/hBTuhm9nta2VVeLoeJYP4QtRLGnpC6VskCu4VacL88zwBat0uZoVT+iCB
         68dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245371; x=1709850171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FbmS0/vnMiN5O2ElDtKte3cIBv6R/kEmABEvMifW8o=;
        b=o47LZDzytbPZxXZZQWut8hxMbXDTuaLbOJkO8LmtvTdWgIStnGOBNdxtk7XQPcd0uR
         z68HJefMpEvCM40zurghANwM1xfNOKWt0SNOX5U1Xp2PI23ll31ArLJekfksFPmvX8cw
         yPWdvtYENBbwoIByzO2myNA4BKgwhQmiCB6yqTAh7yVoWz2PJg8eYypeUsU/ZnhxFC7X
         ctTI8nBm+CCFvEDfDyQ0OG05Y+lu/i93v5BoOHcNSOoiBDF3Qelbe7uvkCmma1NFRCAo
         ikQjFZ0CijeTAcBV7KojlMbc/GGiJCCuXap2rXWHO4NxCu6ZG5E4Hpr9EF6dA3EngZxw
         JjHw==
X-Forwarded-Encrypted: i=1; AJvYcCX58gGNF9I/+xkJbJjM9i8HS/L3cNS33lvskydXa8Z/cwZYncB6yomQl8UJqelBKgK/PrZnvy3sp+V6n5TdunQEbm4472X/LUgoV89U
X-Gm-Message-State: AOJu0Yxrgk9pcgBpcCXuuRUxCFMxV6Qt0kaEJJV9IKSn2Eba6X2Lohkm
	Ke5K2K+ted1p7W5k4RBdZPaA+CvztZU4geb9Z0QrLNkFHbDZm33u
X-Google-Smtp-Source: AGHT+IHASHiTZs+NNiCu2DblsLo6+JIqLJKP5xMXLvjCOoQZJQJhsdB9l6fQCvYM3CjKlcJdLnyaHg==
X-Received: by 2002:a05:600c:538a:b0:412:b767:7d5c with SMTP id hg10-20020a05600c538a00b00412b7677d5cmr7798wmb.14.1709245371252;
        Thu, 29 Feb 2024 14:22:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcb8d000000b0033ce06c303csm2815325wrh.40.2024.02.29.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:22:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/9p: remove redundant pointer v9ses
Date: Thu, 29 Feb 2024 22:22:50 +0000
Message-Id: <20240229222250.351322-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pointer v9ses is being assigned the value from the return of inlined
function v9fs_inode2v9ses (which just returns inode->i_sb->s_fs_info).
The pointer is not used after the assignment, so the variable is
redundant and can be removed.

Cleans up clang scan warnings such as:
fs/9p/vfs_inode_dotl.c:300:28: warning: variable 'v9ses' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/9p/vfs_inode_dotl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..7af27ba1c25d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,7 +297,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       umode_t omode)
 {
 	int err;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -307,7 +306,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	v9ses = v9fs_inode2v9ses(dir);
 
 	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -739,7 +737,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -749,7 +746,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 
-	v9ses = v9fs_inode2v9ses(dir);
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err = PTR_ERR(dfid);
-- 
2.39.2


