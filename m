Return-Path: <linux-kernel+bounces-110018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B548858F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3394C281B24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A876055;
	Thu, 21 Mar 2024 12:20:39 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C899224F2;
	Thu, 21 Mar 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023638; cv=none; b=Re2FYEYseGfDgrcgfPZRm9pKybeih8rP60wxB0NXyQQiWFhj4XOAJRcvFj/cZXiXKl+QcZL47rPhXhBUICQQHwfdAQjnnTrt3n+WnDR8VtaxBZBd1IXcfXLIm1IHUcOcP35DCXYjjDdf6dz1qXysLnax/hsGm4+fi1+z/RyuC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023638; c=relaxed/simple;
	bh=7T3ZMGkzzpCMvYPDnfhlD6ZOzgqvjIvDKifoS2Jbd1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j2M6dUGK+k6+9/aB87H+4+TTjnvs65YJLhT/PtKWenxoyyg1I1pZ0Tz1ab+kjKqIz/GoRDhdNaDgE3xuqJlFwtnFiHes7q4cT9jeGqq2DDizHJ+tofpeY9RXck3BzOiOxCfh+keWlbibSo0YEMWdYU/vFY67ZU+EDv5a0yiPlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id SHQ00026;
        Thu, 21 Mar 2024 20:20:26 +0800
Received: from localhost.localdomain (10.94.11.189) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 21 Mar 2024 20:20:27 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<sathya.prakash@broadcom.com>, <sreekanth.reddy@broadcom.com>,
	<suganath-prabu.subramani@broadcom.com>
CC: <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] scsi: mpt3sas: complete function description
Date: Thu, 21 Mar 2024 08:20:16 -0400
Message-ID: <20240321122016.1587-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024321202026d57b9675eb60499e78977c056994ce70
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add function parameter description.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1b492e9a3e55..4a159ca26df7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -171,10 +171,10 @@ mpt3sas_base_check_cmd_timeout(struct MPT3SAS_ADAPTER *ioc,
 
 /**
  * _scsih_set_fwfault_debug - global setting of ioc->fwfault_debug.
- * @val: ?
- * @kp: ?
+ * @val: string representation of a value
+ * @kp: object that will be set
  *
- * Return: ?
+ * Return: 0 success
  */
 static int
 _scsih_set_fwfault_debug(const char *val, const struct kernel_param *kp)
-- 
2.31.1


