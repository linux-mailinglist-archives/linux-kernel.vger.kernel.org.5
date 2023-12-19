Return-Path: <linux-kernel+bounces-4697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781F8180B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F3B20D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA4611F;
	Tue, 19 Dec 2023 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E9SpQ03x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB335393
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YEGuvprQ3dTZw1JyhXzIpAPhUvuaG4lj/1PCwJqLmsU=; b=E9SpQ03xB6fI5bC3pH27Slea9p
	X6RbEVvKPJKL0aO9jpblnfckeZQU75LiYMUWUxROTZ0zyZWSOc7Yjc7QAzzFf/VUzMcqpFuCjpbrM
	LysbfQvcP2Ig8PFMcGSUI5loo+zSszL3FcP+QvwonBF8Y+WUamOel8leVVo6A+q2a/e46KlukfuEo
	0jlbNR478vdlxsq9PIDM7WRQv6mwN6pH7xc2Fwa1ApW+aY7GKed9QcxMAK6Q01tpJ2uS0GjfYw67Q
	aMNMVKidLv/r3nC1iMLF8eg1PtmwXd9luExg058pO8vgrx4eMmXPqGd07f8PUytnyOtLAMiPR498O
	8sHo4XWA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFS7T-00CqDi-0v;
	Tue, 19 Dec 2023 04:54:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ntfs: dir.c: fix kernel-doc function parameter warnings
Date: Mon, 18 Dec 2023 20:54:14 -0800
Message-ID: <20231219045414.24670-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the kernel-doc function parameter warnings for function
ntfs_dir_fsync() to prevent the following kernel-doc warnings:

dir.c:1489: warning: Function parameter or member 'start' not described in 'ntfs_dir_fsync'
dir.c:1489: warning: Function parameter or member 'end' not described in 'ntfs_dir_fsync'
dir.c:1489: warning: Excess function parameter 'dentry' description in 'ntfs_dir_fsync'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/ntfs/dir.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1462,7 +1462,8 @@ static int ntfs_dir_open(struct inode *v
 /**
  * ntfs_dir_fsync - sync a directory to disk
  * @filp:	directory to be synced
- * @dentry:	dentry describing the directory to sync
+ * @start:	offset in bytes of the beginning of data range to sync
+ * @end:	offset in bytes of the end of data range (inclusive)
  * @datasync:	if non-zero only flush user data and not metadata
  *
  * Data integrity sync of a directory to disk.  Used for fsync, fdatasync, and

