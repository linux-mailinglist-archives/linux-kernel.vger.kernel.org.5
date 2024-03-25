Return-Path: <linux-kernel+bounces-116442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D3889FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C6CB43789
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DB7F486;
	Mon, 25 Mar 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CoxGe+7G"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF61158D93;
	Mon, 25 Mar 2024 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334797; cv=none; b=Gse2TUToqSgCeXJs8cQXnDgoxWqYOx2n+c2SxjtXsebMT5Df0Y3L08SJ18vZEoJNVFMHSh1Tt9RA7BmjgNV1pfMxKfRG7xIXp62wcu/5oGesS9vqiaYIdFuxQqGBsdIhcypVvUw51pbeQwOhfiWLyL4G8kIq466oM6NFaYk5CVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334797; c=relaxed/simple;
	bh=kvnYbAJYV+BV1WgQH3dwyoDwk6yHIMypMOMBm0WlAlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jIAK8x3Dmu05oOs8BRFT7GZgSe+IGhjE0evNyedoQVi6DzUwpupFP7AgIpSt8EHv8b6ZyCdwtlkOxVTKFIexSOCXQwm2D4ohLCynxwvbuPUqXyGHCCtVSt6Y1B342aOZ3NOeeaO6odcrxLko7jp/LCsf98EgKhvdXKVJ5e5CYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CoxGe+7G; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711334790; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hnj6QhXlwaft/coqoLJDZBScFt5gj/F5ruc7EbRseQw=;
	b=CoxGe+7GO/repfGhTS6yPtCJ2TmcFS7a+LkcQoO96rax2jpdrQj1keUnqi7jBFm/i3vqbRhFaccbHaxOTxJzz1R3XSVx7Qd5Cws77xezpCR/TPErhjBulptpxYdQPjREoSc3upy8dwde8/0F5WBEgMcnaDG91vMG3QGzS13EA5k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W38I3D-_1711334789;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W38I3D-_1711334789)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:46:30 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3 v2] fs: Add kernel-doc comments to nilfs_btree_convert_and_insert()
Date: Mon, 25 Mar 2024 10:46:28 +0800
Message-Id: <20240325024628.101296-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_btree_convert_and_insert.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nilfs2/btree.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 65659fa0372e..de38012fd87c 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -1857,13 +1857,21 @@ nilfs_btree_commit_convert_and_insert(struct nilfs_bmap *btree,
 }
 
 /**
- * nilfs_btree_convert_and_insert -
- * @bmap:
- * @key:
- * @ptr:
- * @keys:
- * @ptrs:
- * @n:
+ * nilfs_btree_convert_and_insert - Convert and insert entries into a B-tree
+ * @btree: NILFS B-tree structure
+ * @key: Key of the new entry to be inserted
+ * @ptr: Pointer (block number) associated with the key to be inserted
+ * @keys: Array of keys to be inserted in addition to @key
+ * @ptrs: Array of pointers associated with @keys
+ * @n: Number of keys and pointers in @keys and @ptrs
+ *
+ * This function is used to insert a new entry specified by @key and @ptr, along
+ * with additional entries specified by @keys and @ptrs arrays, into a NILFS B-tree.
+ * It prepares the necessary changes by allocating the required blocks and any
+ * necessary intermediate nodes. It converts configurations from other forms of block
+ * mapping (the one that currently exists is direct mapping) to a B-tree.
+ *
+ * Return: 0 on success or a negative error code on failure.
  */
 int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
 				   __u64 key, __u64 ptr,
-- 
2.20.1.7.g153144c


