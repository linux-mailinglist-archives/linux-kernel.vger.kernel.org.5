Return-Path: <linux-kernel+bounces-111068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C829886789
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A87B2136C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04AE1642C;
	Fri, 22 Mar 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rfScMAMT"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3E12E59;
	Fri, 22 Mar 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092769; cv=none; b=jcUFNRyf7IzdAdcV3XP7vFofSMBvTd0xTnxmYmFkk0lswXHP4F1/rK+8iNrK2D+wEOG73gOP/pop7SRL85MH/Lc3yW9DE0C8WEX8GJemFXxdIUVoW8w4fRCmBMAoQ/Yk2XQbQaf9HDxI0Lp5g0SoUbeaujINr6CDwx9C3JS9CXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092769; c=relaxed/simple;
	bh=6tRMaL9wuX6/FrMR4wOTO16ErMpGD+oyCQiJ33BW5+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRj8wA6fuqoIVr57w6Lb1UqBKozm/Sug+FRM9FyhdG9aSo/DaqAD5CFRZNmUPQU98WB6OKcIOBi0Y64wMpOFmzFfQTpyWFezKhm+spU+f3Gj/jQONbAolg8ejt4GOcKL3j6eGvXgJAVADnM0QsfXZuboUEVJRSvbCiZ1Ivz/r1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rfScMAMT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711092764; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=thd1B9x4Ir0+XTQFz3zcM+o2NSJw397198Eddv94er4=;
	b=rfScMAMTfK5yCvTa02/YDYDoD3vFy0N+Z3KooyddZJdaWsD7w+MVGOwU3muSvWACEC2FL9jtyh+lfAsxNk5OVMZy1BV5kJnKfoJ4oCyf8JcKBS062MeCUQqY9nMw1eDZsydqIHrubBVucDrp6swWWrIgYn28sGyIBZbrsUPdg8o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W31DHVY_1711092763;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W31DHVY_1711092763)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:32:44 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3] fs: Add kernel-doc comments to nilfs_btree_convert_and_insert()
Date: Fri, 22 Mar 2024 15:32:39 +0800
Message-Id: <20240322073240.91639-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240322073240.91639-1-yang.lee@linux.alibaba.com>
References: <20240322073240.91639-1-yang.lee@linux.alibaba.com>
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
+ * necessary intermediate nodes. This function handles the conversion of a B-tree
+ * node when it is necessary to split it due to the size constraint.
+ *
+ * Return: 0 on success or a negative error code on failure.
  */
 int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
 				   __u64 key, __u64 ptr,
-- 
2.20.1.7.g153144c


