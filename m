Return-Path: <linux-kernel+bounces-111037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E0886731
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8917E1F23C36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5810A1A;
	Fri, 22 Mar 2024 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YQKZCPPI"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922738C11
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090549; cv=none; b=rWjF6FnQG18Jjxoe5i6vsYLj97dXfFF1UNSxcTpJGR8Nw3CmZuCj+8MnLW7R9LMYA6snB3BhKWn1niU+cYYPCLhpQltwYrRb4VVCoh3CGPO5czPHfASDECtSOftNl1Q1oZlQfu99T+YZEPl18VHSn8l0koE34hWqjfzWr/cq+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090549; c=relaxed/simple;
	bh=JRIxEKRHhp7NCyWHS1coKlGd5hjec0w//YZZ+2jMasM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqRYlZIZF0O/9heR3NeJ+xAUcfQoPsLSDt6nGnf6DhTZou8mz0DUqbRS8804Mr+kyOD+2geykJAJQaQscdflPg8FMxCCukiFOk4SMjfF/Lz0aXlFNUswG9WWKkRop6sn6EOj+XMGItB/uFoYGULQpBlQIr7nhaYaVK998gtPJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YQKZCPPI; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711090544; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LVabKYwSmk14tjRnmAAv7y5xHKFF5PGMC+FrZ1XHhPY=;
	b=YQKZCPPIOW+R6zwOQgIMJYwLoNFUDYDL7gcWsc4xBPv/lO09JvfkfZU9hn8lt0J1qG7hBIi800R//0KasYbdop772Q3LCtVuDHrE7JuMGYbuvNBOCQmYSLcD56vlB8j1XTKPF3Z6hQZQ2fAmydeuJ6lyFG6BktaxxP5Bz3UjFEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W319pCd_1711090543;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W319pCd_1711090543)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:55:44 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dushistov@mail.ru
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to ufs_getfrag_block()
Date: Fri, 22 Mar 2024 14:55:42 +0800
Message-Id: <20240322065542.5588-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function ufs_getfrag_block.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ufs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a7bb2e63cdde..4a36feff043f 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -392,6 +392,20 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 /**
  * ufs_getfrag_block() - `get_block_t' function, interface between UFS and
  * read_folio, writepages and so on
+ * @inode: Inode of the file for which the block is being fetched.
+ * @fragment: Logical block number within the file.
+ * @bh_result: The buffer_head to fill in with the block's information.
+ * @create: Flag indicating if the block should be allocated if it doesn't exist.
+ *
+ * This function is responsible for translating a file's logical block number
+ * into its physical block number on disk. If necessary, it can also allocate
+ * blocks to the file, when the 'create' argument is non-zero. It fills the
+ * buffer_head @bh_result with the mapping information.
+ *
+ * Return: 0 on success or if the block is already allocated and @create is zero.
+ * In case of an error, a negative error code is returned. If a new block is
+ * allocated and @create is non-zero, the function also sets the buffer_new
+ * flag on @bh_result.
  */
 
 static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
-- 
2.20.1.7.g153144c


