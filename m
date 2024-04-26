Return-Path: <linux-kernel+bounces-159961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21E8B36D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701361F22D43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC7145B04;
	Fri, 26 Apr 2024 12:03:50 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E85145358
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133030; cv=none; b=SWcJcdwnRPs324os6wSQDaLHgN1wOHhVRZL39aM1QsPY4G7NOSyFdg7uopA6PstDExXLldpiG/w6T9IiWNVrA+szQMytawmGVevulPwVXRTDBPdmNFaGzs/JPPMnV+Ya+vhzj9Kjx4lNrowgvKGDSuGHFFKVaj2BcJ1/h9nW5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133030; c=relaxed/simple;
	bh=1YNJVTz06BWFqJ7FQvwgAsfJPj+hF8YmXKjq0iE0r9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=io1PjlwjOHzvejs4d8PpVdOdQSMBaozRtfKMoO0go3JI3I+PEjIV0zU1jRw1Vipbl9s7ppoqv2MOlGmTi7seQvu86l4C4MD2MFThhCOvOZ8DiPlgJAP/yiyzdf9DTjitU/YyuLquQaRUUqJlp12W5dSEOUsEPzbaD4eM0YEbtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43QC1c1w090269;
	Fri, 26 Apr 2024 20:01:38 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VQrq51X47z2Nr60C;
	Fri, 26 Apr 2024 19:58:57 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 26 Apr 2024 20:01:37 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH V2] f2fs: fix some ambiguous comments
Date: Fri, 26 Apr 2024 20:01:29 +0800
Message-ID: <1714132889-9423-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 43QC1c1w090269

After commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size"),
Some comments are confused and just correct with block size is 4KB.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: add comments "support 64 TB disk size for 16K page size"
---
---
 include/linux/f2fs_fs.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a357287..41d1d71 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -394,7 +394,8 @@ struct f2fs_nat_block {
 
 /*
  * F2FS uses 4 bytes to represent block address. As a result, supported size of
- * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
+ * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and it equals
+ * to 16 * 1024 * 1024 / 2 segments.
  */
 #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
 
@@ -424,8 +425,10 @@ struct f2fs_sit_block {
 /*
  * For segment summary
  *
- * One summary block contains exactly 512 summary entries, which represents
- * exactly one segment by default. Not allow to change the basic units.
+ * One summary block with 4KB size contains exactly 512 summary entries, which
+ * represents exactly one segment with 2MB size.
+ * Similarly, in the case of block with 16KB size, it represents one segment with 8MB size.
+ * Not allow to change the basic units.
  *
  * NOTE: For initializing fields, you must use set_summary
  *
@@ -556,6 +559,7 @@ struct f2fs_summary_block {
 
 /*
  * space utilization of regular dentry and inline dentry (w/o extra reservation)
+ * when block size is 4KB.
  *		regular dentry		inline dentry (def)	inline dentry (min)
  * bitmap	1 * 27 = 27		1 * 23 = 23		1 * 1 = 1
  * reserved	1 * 3 = 3		1 * 7 = 7		1 * 1 = 1
-- 
1.9.1


