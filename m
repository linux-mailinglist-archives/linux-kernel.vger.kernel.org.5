Return-Path: <linux-kernel+bounces-29643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0DB831133
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F01F221F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0337B468B;
	Thu, 18 Jan 2024 02:01:50 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF320F2;
	Thu, 18 Jan 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543309; cv=none; b=FdUfYnHV/YFs48HuAC/noY5uRYsCmNJlZz1TY2xkBtjBBKe8+JnNdWOCeHeXluB/Xo+TuTq7PxmxhOX1q2Cy+OpYvu2jTvSHiCAMMO7Wp37eaim2y3o7s3X928Q0gnyLmBMvJhh3o9PuTDU2DzZcYTsHGx+aHHJFD9klfuH3wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543309; c=relaxed/simple;
	bh=YxiJ6Nud3eO2JnytW2y9JL+FeoU+XsFoYXR+TxAyfCw=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=IdoXBEGY7jRdPhc8rhtZs94Q4DFktE5vR362j3TFo72qvdb2T4qvHscwpZRBK4tdsDalLeZ8I21iBwvmC0/fSgBBuE48Pw1+RCKKzlybljie0U3OFFO/Zpdg6aFg3BoLeJrkLP7hPhqWWrt6CES4BT8sovhCfWLP2rhRVkQjDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-qyKG6_1705543289;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W-qyKG6_1705543289)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 10:01:38 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: satishkh@cisco.com
Cc: sebaddel@cisco.com,
	kartilak@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: fnic: clean up some inconsistent indenting
Date: Thu, 18 Jan 2024 10:01:28 +0800
Message-Id: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/scsi/fnic/fnic_scsi.c:1964 fnic_abort_cmd() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7930
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 8d7fc5284293..5b4768e669f0 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1961,8 +1961,8 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-	    FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
-			"Issuing host reset due to out of order IO\n");
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			      "Issuing host reset due to out of order IO\n");
 
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
-- 
2.20.1.7.g153144c


