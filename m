Return-Path: <linux-kernel+bounces-23484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366182AD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D2D1F23B79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15315492;
	Thu, 11 Jan 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YdV+GSV7"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDF14F95;
	Thu, 11 Jan 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Ldi9YxGzFNhmHsz1pU
	YmMUQer+GNx8j5nJTj27apNl0=; b=YdV+GSV7dcEknYPSR4P47b5rbbDJ1Q4sAT
	fm1K0ObAEgZfJK+AKMSmljzQFIGWmUrGQvlPxOqeRy8XU9HOPKFEhUEfHqn5ZlDF
	AJTg1LQ06jy5hORjIArJ7wUEcqnlRY/GcF+nJf01pJdvqCgQQ3fGXdH80k1/EIXH
	fSj0AD/rg=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3f6a40J9l+N0qAA--.56294S2;
	Thu, 11 Jan 2024 19:27:52 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	aacraid@microsemi.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: aacraid: Clean up errors in commctrl.c
Date: Thu, 11 Jan 2024 11:27:51 +0000
Message-Id: <20240111112751.15810-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f6a40J9l+N0qAA--.56294S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry8Jr4kCw4xCry3Wr1UGFg_yoW5GrWfpa
	yrKFy5AF48ta47Xa18tFWvva4fWa4rta18GFWxA34FvFyUK34fGF40gFyjkry3u3ykGw17
	CF4qvFW7JF1qkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRPfHbUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWRxixWVLYUW8GgAAsO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: "foo * bar" should be "foo *bar"
ERROR: space required before the open parenthesis '('

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/aacraid/commctrl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index e7cc927ed952..049b88030571 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -397,12 +397,12 @@ int aac_close_fib_context(struct aac_dev * dev, struct aac_fib_context * fibctx)
  *	This routine will close down the fibctx passed in from the user.
  */
 
-static int close_getadapter_fib(struct aac_dev * dev, void __user *arg)
+static int close_getadapter_fib(struct aac_dev *dev, void __user *arg)
 {
 	struct aac_fib_context *fibctx;
 	int status;
 	unsigned long flags;
-	struct list_head * entry;
+	struct list_head *entry;
 
 	/*
 	 *	Verify that the HANDLE passed in was a valid AdapterFibContext
@@ -414,7 +414,7 @@ static int close_getadapter_fib(struct aac_dev * dev, void __user *arg)
 	entry = dev->fib_list.next;
 	fibctx = NULL;
 
-	while(entry != &dev->fib_list) {
+	while (entry != &dev->fib_list) {
 		fibctx = list_entry(entry, struct aac_fib_context, next);
 		/*
 		 *	Extract the fibctx from the input parameters
@@ -428,7 +428,7 @@ static int close_getadapter_fib(struct aac_dev * dev, void __user *arg)
 	if (!fibctx)
 		return 0; /* Already gone */
 
-	if((fibctx->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
+	if ((fibctx->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
 		 (fibctx->size != sizeof(struct aac_fib_context)))
 		return -EINVAL;
 	spin_lock_irqsave(&dev->fib_lock, flags);
@@ -476,9 +476,9 @@ static int check_revision(struct aac_dev *dev, void __user *arg)
  *	@dev:	adapter is being processed
  *	@arg:	arguments to the send call
  */
-static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
+static int aac_send_raw_srb(struct aac_dev *dev, void __user *arg)
 {
-	struct fib* srbfib;
+	struct fib *srbfib;
 	int status;
 	struct aac_srb *srbcmd = NULL;
 	struct aac_hba_cmd_req *hbacmd = NULL;
@@ -505,7 +505,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		dprintk((KERN_DEBUG"aacraid: send raw srb -EBUSY\n"));
 		return -EBUSY;
 	}
-	if (!capable(CAP_SYS_ADMIN)){
+	if (!capable(CAP_SYS_ADMIN)) {
 		dprintk((KERN_DEBUG"aacraid: No permission to send raw srb\n"));
 		return -EPERM;
 	}
-- 
2.17.1


