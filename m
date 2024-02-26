Return-Path: <linux-kernel+bounces-81348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B95F867490
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5791C24783
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDC604CC;
	Mon, 26 Feb 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjE/PJV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F5604B7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949765; cv=none; b=aPYPtnBlyu2Y85C3KidgjDSBist2Q8cEKSuZo9sKSgQjYQ/OTKwDBhHwIh60G9GyEqkxURZF6DwgQrAmr5UeJCUzUPhY9LndwQr9vekRsOHpvsvmi6bo50EG3qXjEMFwSnlkUQf90SV5BLW+hyZMsGIE37dtJsf9pTN7T6LUJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949765; c=relaxed/simple;
	bh=dIUCjHoNQgOf5LX5CDqGdhGVPI2lsfrC1oPUtvZVZCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=siiSnrw1CXbPBtxatAx6p4pBCl+YdrPgPsqH1KLaQ1MnG6xwVPU2i4YTcJbRS79/F6wYOll9HQB4UQfsbG+Nw41/4cP0GFW02kpc3u2gSrgZNSGhe1YJU6eoDQfWWoQvFQJ9WprPENSy0cqbT5qDZf+Jr9MDqgLFZ5vdgLkGtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjE/PJV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6338C433C7;
	Mon, 26 Feb 2024 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949765;
	bh=dIUCjHoNQgOf5LX5CDqGdhGVPI2lsfrC1oPUtvZVZCo=;
	h=From:To:Cc:Subject:Date:From;
	b=BjE/PJV0v+5zRxcM8rFDX0y0HdQRjazPEjtTatnxIbu0sm1KaPw35w3HvJoJ0Nb4W
	 taKWESXQeBJFOclrjZE9C+Ek2pqnYjj27AdjVVNmxyWmEYZ9++N92Fltmortj0RoqI
	 PGPPJpF8I3P6jCd2wQWPrOSi7NsxUt9cs+SWVXCtEMahNU+mEkO8hKMiejFzbIkaRk
	 BamAkSamVvchgalafebxbjTNkFCl3eDMhcj2F9Qfivm5MMD8kbEe78a74FeSawq/Lg
	 QV3QbkbBR0HryGgeQGJaQYG8oU7XWB9mXGGytrRx1TobkJb0Pz6wKnLMNXiXfaAPKM
	 nMEC7EVaSPxdQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: fix function comment warning
Date: Mon, 26 Feb 2024 13:15:52 +0100
Message-Id: <20240226121600.1267204-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

My previous fix introduced a new W=1 warning for the kerneldoc style
comments:

fs/ubifs/find.c:86: warning: Function parameter or struct member 'arg' not described in 'scan_for_dirty_cb'

Adjust the comments to the argument names.

Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402261559.cYtMOkIn-lkp@intel.com/
Fixes: ec724e534dfd ("ubifs: fix function pointer cast warnings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/find.c   | 8 ++++----
 fs/ubifs/lprops.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 6ebf3c04ac5f..643718906b9f 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -73,7 +73,7 @@ static int valuable(struct ubifs_info *c, const struct ubifs_lprops *lprops)
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -340,7 +340,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -581,7 +581,7 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -773,7 +773,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index a11c3dab7e16..8788740ec57f 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1005,7 +1005,7 @@ void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
  * @c: the UBIFS file-system description object
  * @lp: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @lst: lprops statistics to update
+ * @arg: lprops statistics to update
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
-- 
2.39.2


