Return-Path: <linux-kernel+bounces-110998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B51D8866D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDA5B238B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAADBE4C;
	Fri, 22 Mar 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nVshVq7C"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229022900
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089446; cv=none; b=tIxlpHRQVfA3lbuoelJC7R2nfVTj4XiEfdYryGy2D0DZ9+xcy2Jf8xixKjRE2Lp3yIFItn5FgoDHz3AKUxDZSCMpF61rTKvrGWynfV8BffXWbVtC/MSWpiWzg5fjTKWwRB9PUYclePAM5k5KPZhWyECKZ5Oy/77kaa/td9gg6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089446; c=relaxed/simple;
	bh=zO//7ikIiE59nF3XzyBW1JfQyYBLpBR0aKDdIkebZxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euxEA0REr3xXnoE1flK1047b7D4DwV0JflybmPVRLLHogUSJLMDU3ENfDh4cX3P6+iQtFiKCOU8aRs7bgX6l+nCly2KKkRHkya/zGNEPhCUxKV+I3jH/POWvb2uvcng4w+ApSH7imP9czWXKuj60tsszUtuucFx2eCEPxdvSDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nVshVq7C; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711089440; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9/++gwBFcArjU1qdYetE8T/+iDphIeVPOOipqZwUwrU=;
	b=nVshVq7CsR6uxV6HmQtRpjjKlRdHgYeNicwsT+OYv7CCPcET8+I6hMxFr8lhbwVJeU+OcRnHfkJwmasdHjynak001N3vei2t17+eHXAgF8uG4t0asyc5W0cMvUrfylW9TBQ+PCzh54wkDEiQDwP0lN37nOwpEci3w1tMcGq/w7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W315FUe_1711089439;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W315FUe_1711089439)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:37:20 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to ocfs2_prepare_orphan_dir()
Date: Fri, 22 Mar 2024 14:37:18 +0800
Message-Id: <20240322063718.88183-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function ocfs2_prepare_orphan_dir.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ocfs2/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 9221a33f917b..8a61c5f94533 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2187,8 +2187,10 @@ static int __ocfs2_prepare_orphan_dir(struct inode *orphan_dir_inode,
  * @osb: ocfs2 file system
  * @ret_orphan_dir: Orphan dir inode - returned locked!
  * @blkno: Actual block number of the inode to be inserted into orphan dir.
+ * @name: Buffer to store the name of the orphan.
  * @lookup: dir lookup result, to be passed back into functions like
  *          ocfs2_orphan_add
+ * @dio: Flag indicating if direct IO is being used or not.
  *
  * Returns zero on success and the ret_orphan_dir, name and lookup
  * fields will be populated.
-- 
2.20.1.7.g153144c


