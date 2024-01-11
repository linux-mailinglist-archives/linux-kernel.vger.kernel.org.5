Return-Path: <linux-kernel+bounces-23498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09482AD96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485C1B211DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF3168BC;
	Thu, 11 Jan 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JPTfchJ5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF563168A4;
	Thu, 11 Jan 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Ulg5o6CoaKeBaKtAlG
	T8y9PQKh25ahXJQd5/WZA3rzA=; b=JPTfchJ5VXgqMWK2ki1mdaYp9JqCh18nEd
	9maxfCsBvt7m5wI3y9VTb29dRC3mSEY+8YDX5R+8XfpZmLGTDbgRU6mmPmEsAVy4
	0J1ZQptl6GNzXsPJvc3xMDrO6FOSLwPMQHh6DGKzQDAHi8HckoIBwf32g1iEd8zt
	a+Ev90Xhg=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3vyva0Z9lmSM5AA--.46639S2;
	Thu, 11 Jan 2024 19:32:42 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	aacraid@microsemi.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: aacraid: Clean up errors in commsup.c
Date: Thu, 11 Jan 2024 11:32:40 +0000
Message-Id: <20240111113240.15985-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3vyva0Z9lmSM5AA--.46639S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUWFy3Kw17JF13Zr4fZrb_yoWDCrXE9r
	4xXFyxuF4UuF13Cr17ur43ZFyavayDur4rurW2qry7XryvvrWUArn8ZrnxZ34Fgw48AF1U
	Kwn7XFn3Arn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiqXd5UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWRxixWVLYUW8GwACsN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '<' (ctx:VxV)
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/aacraid/commsup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 25cee03d7f97..865316ba3c19 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -129,7 +129,7 @@ void aac_fib_vector_assign(struct aac_dev *dev)
  *	fib area, the unmapped fib data and also the free list
  */
 
-int aac_fib_setup(struct aac_dev * dev)
+int aac_fib_setup(struct aac_dev *dev)
 {
 	struct fib *fibptr;
 	struct hw_fib *hw_fib;
@@ -144,7 +144,7 @@ int aac_fib_setup(struct aac_dev * dev)
 		if (dev->comm_interface != AAC_COMM_MESSAGE_TYPE3)
 			dev->init->r7.max_io_commands = cpu_to_le32(max_cmds);
 	}
-	if (i<0)
+	if (i < 0)
 		return -ENOMEM;
 
 	memset(dev->hw_fib_va, 0,
-- 
2.17.1


