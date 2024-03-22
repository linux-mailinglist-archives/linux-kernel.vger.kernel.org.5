Return-Path: <linux-kernel+bounces-110988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31BD8866B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D7B1F23F67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B8C8FF;
	Fri, 22 Mar 2024 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OBKzas+f"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9512C2C6;
	Fri, 22 Mar 2024 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088771; cv=none; b=XNZasAUyvlYgpFxf/Oq0gZJpDFVTZTQ+CTpD88+aeUhji+yu9bSMzwlQqLs3SSD4hs5mz9U5jq5SP68xUJi71e0onrYChyFaq4KgmzttaWLhXwPoiIHYO/4gqowOa4y+BEjJU/GuTjmW+Fphie0aiJJU40QCLkOE1Y9aCzST74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088771; c=relaxed/simple;
	bh=dpNeus9MZz3Kq1LqiaXo/h2R9XFASoUytjEW6p+eLTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PHqm1ccKEJY7CJgIQihnvxmAL69KyglFDDMJnnDzjXWj7ZpA2Kz3cxSkhb9JBndaLIrnoBMQx/lVlJrXUi0fnHvYSa+PTyXSkZJ0oLGqWuUDRbq2Ec3Gc7ILDFdM6u7IPWsooho/QMJHLKwFqWo9rQgnkbM/AmBP6286d87Th88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OBKzas+f; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711088766; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FivtUkUPmOXFXKbd7Bw4dBN6HJGl3UTcNMbU+QD0qKw=;
	b=OBKzas+fq/9kIZPltQ6guEc5nAd0VM1Rkc/1jFCtdNlOl5cQTj3EjNABRCfuKJgEMbIoW4d8zcs9c0uQlENSdSTiLCOkKUEfujp4XSSJ/TNYQqivLSJ+DcDoWwduDuamJPJXXWy71nQYMRfaSZf4t1m7EznlpNC9+Nr3qcT5+1c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W31BTa5_1711088765;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W31BTa5_1711088765)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:26:05 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Fix kernel-doc comments to functions
Date: Fri, 22 Mar 2024 14:26:04 +0800
Message-Id: <20240322062604.28862-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fix kernel-doc style comments with complete parameter
descriptions for the lookup_file(),lookup_dir_entry() and
lookup_file_dentry().

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/tracefs/event_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dc067eeb6387..894c6ca1e500 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -336,6 +336,7 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 
 /**
  * lookup_file - look up a file in the tracefs filesystem
+ * @parent_ei: Pointer to the eventfs_inode that represents parent of the file
  * @dentry: the dentry to look up
  * @mode: the permission that the file should have.
  * @attr: saved attributes changed by user
@@ -389,6 +390,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 /**
  * lookup_dir_entry - look up a dir in the tracefs filesystem
  * @dentry: the directory to look up
+ * @pei: Pointer to the parent eventfs_inode if available
  * @ei: the eventfs_inode that represents the directory to create
  *
  * This function will look up a dentry for a directory represented by
@@ -478,16 +480,20 @@ void eventfs_d_release(struct dentry *dentry)
 
 /**
  * lookup_file_dentry - create a dentry for a file of an eventfs_inode
+ * @dentry: The parent dentry under which the new file's dentry will be created
  * @ei: the eventfs_inode that the file will be created under
  * @idx: the index into the entry_attrs[] of the @ei
- * @parent: The parent dentry of the created file.
- * @name: The name of the file to create
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
  *
- * Create a dentry for a file of an eventfs_inode @ei and place it into the
- * address located at @e_dentry.
+ * This function creates a dentry for a file associated with an
+ * eventfs_inode @ei. It uses the entry attributes specified by @idx,
+ * if available. The file will have the specified @mode and its inode will be
+ * set up with @data upon open. The file operations will be set to @fops.
+ *
+ * Return: Returns a pointer to the newly created file's dentry or an error
+ * pointer.
  */
 static struct dentry *
 lookup_file_dentry(struct dentry *dentry,
-- 
2.20.1.7.g153144c


