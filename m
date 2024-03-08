Return-Path: <linux-kernel+bounces-96639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D0875F48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435ABB2147B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A651C47;
	Fri,  8 Mar 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZuC+AwIv"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40B1CD09;
	Fri,  8 Mar 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885994; cv=none; b=U1EfgOvn2WkFoAgzbn82dwlAP3UVa/Vbc5H+pfYnAxKUTqr5gZzW2UgTnLA2FMqS21rlaLCocphHk+9faMYQ8e3QTlsJz1KiqFsQDWZMrltZUdg464hi5egzrAPopSGjcL6UhDmKQZOnLXmpj17kfGk5VaUeLbnfUwVCOb/RCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885994; c=relaxed/simple;
	bh=21PYJgFrJNf3jVcdXnmILUFji/g2vh50WPLWmjHxe5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jCOC+9fkMw9tLkMeecaK1eeKlroJ2KHAFPqElilltizL6KFrKVSn4zEjbusUjbDq6CqMKcdB6fJgPWL5MwD4RJdH0T6y03CXu8aGndegB1z4/UE6R5Tz+paWX/ircy0R2iqB2OQ2TH9eAAfU84tixR2YYqXc0ZgNSSHv+olVxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZuC+AwIv; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709885988; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0QsC97TrMwcM8l8dIuh71VPq817YWxDlnxeVAHCYWOw=;
	b=ZuC+AwIvZ90qLkQkVZyDhZ7N69NBRQxO8Fu5qXVxve+QtNqb9WE4ZGtsUSle4FWKkB5oGKsfwbyBeQteKu86qLZ1aH2OjbXukeWDeqwjFw9xBWLkaXgJxQrnhTOFV4BdCD1JZg2EDjiLGhFmh8DBElX8gPpeX/XkFok91VQsx24=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2249gy_1709885987;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2249gy_1709885987)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 16:19:47 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] block: Fix some kernel-doc comments
Date: Fri,  8 Mar 2024 16:19:46 +0800
Message-Id: <20240308081946.118718-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the functions read_lba, alloc_pvd, and alloc_lvn.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/partitions/aix.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 85f4b967565e..83e73bcda86c 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -68,10 +68,10 @@ struct pvd {
 
 /**
  * read_lba(): Read bytes from disk, starting at given LBA
- * @state
- * @lba
- * @buffer
- * @count
+ * @state: disk parsed partitions
+ * @lba: the Logical Block Address of the partition table
+ * @buffer: destination buffer
+ * @count: bytes to read
  *
  * Description:  Reads @count bytes from @state->disk into @buffer.
  * Returns number of bytes read on success, 0 on error.
@@ -103,8 +103,8 @@ static size_t read_lba(struct parsed_partitions *state, u64 lba, u8 *buffer,
 
 /**
  * alloc_pvd(): reads physical volume descriptor
- * @state
- * @lba
+ * @state: disk parsed partitions
+ * @lba: the Logical Block Address of the partition table
  *
  * Description: Returns pvd on success,  NULL on error.
  * Allocates space for pvd and fill it with disk blocks at @lba
@@ -128,8 +128,8 @@ static struct pvd *alloc_pvd(struct parsed_partitions *state, u32 lba)
 
 /**
  * alloc_lvn(): reads logical volume names
- * @state
- * @lba
+ * @state: disk parsed partitions
+ * @lba: the Logical Block Address of the partition table
  *
  * Description: Returns lvn on success,  NULL on error.
  * Allocates space for lvn and fill it with disk blocks at @lba
-- 
2.20.1.7.g153144c


