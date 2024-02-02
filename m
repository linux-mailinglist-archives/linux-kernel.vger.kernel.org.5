Return-Path: <linux-kernel+bounces-49385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7F8469D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E951C216FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA317C64;
	Fri,  2 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a1/7C3q3"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA7179AA;
	Fri,  2 Feb 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860336; cv=none; b=kbwFRwL58enMkXhUKl2zOVqbnGOIxQ63Q1xNRIBp+nuwM2UJQrZ9hmdZaRKaJEr9jGI+M0qSu3t1iGwjq92wO06aMp2U6p2Dps6sLtUeE99a7kOltAVHGTVKv0QDs0W1qgLrLU5UVq5tS5WKEG/i/JuoKf+hDBS0seFoRraPeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860336; c=relaxed/simple;
	bh=y2X7R5Qq6Qdi5LJh0o+YL8uCs3iiEztVckSDhp/7Q+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJZKpSfC16utpiTLexM/7A5jyrFx6vUGLA5psiq3JMlosIA5YzWarOA9sHMrq+L6dgE9BPENlzMGGQMA+vIU09l363t2/02jnU6gGPnfipEftQ5+6DnyrtP+qO1xBHSV0I+HDxAkiTRJRWDr8WLuaPPNmsOBNEWcBO0BpW5Z9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a1/7C3q3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706860325; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cOquSrkCgnwTLc8ETZkC+cmIHOXJDfHd2et4ILFlvwM=;
	b=a1/7C3q3V/0AIP2UKUWgJdVwJc41JdLueU0DHGDfXlpHnHptTYWxb9NBKlfO20J2WQOGuj8WDkUC0vUkFLsth5Hcj5KdNh/uRQeL0bFYExIb4sGxsbYpq3/1zT70w8oPa62mZc1lOfl74ZoAOk7xb4VNOhGMyTh15qKwz6nmkZE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.wOAYC_1706860324;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.wOAYC_1706860324)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 15:52:04 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] block: Add parameter descriptions to kernel-doc
Date: Fri,  2 Feb 2024 15:52:03 +0800
Message-Id: <20240202075203.34873-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the kernel documentation for the some
functions by providing detailed descriptions of its parameters.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/partitions/aix.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 85f4b967565e..0169f6d8fe95 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -68,10 +68,11 @@ struct pvd {
 
 /**
  * read_lba(): Read bytes from disk, starting at given LBA
- * @state
- * @lba
- * @buffer
- * @count
+ * @state: pointer to a parsed_partitions structure which holds the state
+ *	    including details about the partitions on the disk.
+ * @lba: logical block address from where the read operation should start on the disk.
+ * @buffer: pointer to a buffer where the data read from the disk will be stored.
+ * @count: number of bytes to be read from the disk.
  *
  * Description:  Reads @count bytes from @state->disk into @buffer.
  * Returns number of bytes read on success, 0 on error.
@@ -103,8 +104,9 @@ static size_t read_lba(struct parsed_partitions *state, u64 lba, u8 *buffer,
 
 /**
  * alloc_pvd(): reads physical volume descriptor
- * @state
- * @lba
+ * @state: pointer to a parsed_partitions structure which holds the state
+ *	    including details about the partitions on the disk.
+ * @lba: logical block address where the physical volume descriptor is located.
  *
  * Description: Returns pvd on success,  NULL on error.
  * Allocates space for pvd and fill it with disk blocks at @lba
@@ -128,8 +130,9 @@ static struct pvd *alloc_pvd(struct parsed_partitions *state, u32 lba)
 
 /**
  * alloc_lvn(): reads logical volume names
- * @state
- * @lba
+ * @state: pointer to a parsed_partitions structure which holds the state
+ *	    including details about the partitions on the disk.
+ * @lba: logical block address where the physical volume descriptor is located.
  *
  * Description: Returns lvn on success,  NULL on error.
  * Allocates space for lvn and fill it with disk blocks at @lba
-- 
2.20.1.7.g153144c


