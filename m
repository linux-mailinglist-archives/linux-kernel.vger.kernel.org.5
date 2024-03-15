Return-Path: <linux-kernel+bounces-104149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A496387C9C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60A81C221F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE917592;
	Fri, 15 Mar 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQnJKYQj"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AA17581
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490424; cv=none; b=SCB+pz1bzx56mrCY/oj/+j0qhvWlc2AmVZmhrOVgO/TDx99FST1IT9W0abQWIx/CDv/JzSj/0B9anN5z1DZQq4svGCIQBoaDshHbidvul7In2csOcYKfwpBq5MGjCcRH3ugfmR9X1MqlV/cMtw3yQirc3QvZUBw4/SrQ6+anklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490424; c=relaxed/simple;
	bh=bC7My8oeg0T3EHs8tbxbV7WmTFSCamPB62t8Ch/QUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Peds8+a6M6/qT9LtRQOzcA4F+TD/RJR64TfyFcqA8XLPG8BKB0sq49iplw+cVZmkzeELJOodcIIOcE14mnQ3E4UMt3SjW8hgqucFqs6WWEAzgTkLu/LGbiH1EZc7F8K9oJJKoos8sOzl2yXvNGuL433+cZ+xVIY+jL4NdLJBS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQnJKYQj; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490414; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SQuXMqSOanP/j7MWbwE28K2yMx+KaDM6sNBTCkxedCA=;
	b=uQnJKYQjhPgSfGzA/z/5fb2LycflFbfcZP2FJ5kXKzYW8IRS3ZL1wtej5B81bICmEvvi1XJ7gNi1yEWcuqfK7z2NsROmFEMO/6MOu3Fi1R7SDo3RzH5Kdp0stRki8I3UqU6v4P74P4GIiFqR0P4MTlLceCAJhyrp+C4qafY7jE4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2Vb1QP_1710490413;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2Vb1QP_1710490413)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:13:34 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to functions gfs2_freeze_super and gfs2_thaw_super
Date: Fri, 15 Mar 2024 16:13:32 +0800
Message-Id: <20240315081332.27389-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the functions gfs2_freeze_super and gfs2_thaw_super.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9de789b78bc5..240822fee6fb 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -731,6 +731,7 @@ void gfs2_freeze_func(struct work_struct *work)
 /**
  * gfs2_freeze_super - prevent further writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: indicates the entity that holds the freeze
  *
  */
 
@@ -799,6 +800,7 @@ static int gfs2_freeze_fs(struct super_block *sb)
 /**
  * gfs2_thaw_super - reallow writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: indicates the entity that holds the freeze
  *
  */
 
-- 
2.20.1.7.g153144c


