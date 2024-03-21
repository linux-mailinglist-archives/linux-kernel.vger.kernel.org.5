Return-Path: <linux-kernel+bounces-110013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969468858E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333C81F227C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923E76054;
	Thu, 21 Mar 2024 12:15:51 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D458232;
	Thu, 21 Mar 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023350; cv=none; b=pZQ/L9DR1INJHZkHgsG4BPNKDj++iNxs/YY+SZmoQsNZU82B3EEVSA0Z/SQ8Eh62lqZdauyo2VfKZOEJEFlZzuAYiJ0XN84ERFoqyJb580LBMfNDGlx8F7xM95MJS/wjQtToBG6UfvKmImJdnpVUWrRgVRmF768cD3AYXwtN7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023350; c=relaxed/simple;
	bh=BE5d4uIhGmXfTmt51hbSLudYl5pML7tLg/so8U1NfGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvBw5j8P1rTf8nlVDKHI7oj6yH3Gch5M7UbSfO29/IxmqsPAbmvr/t7wSENFervUqqubG78cLY7SjXi5jsqEJGeMuintDWo+KGNJ+fTgeKC1nH5AhU8t9hEKVe9yOuECkrReTipws9yYW3/ePIzLckzdkhZyLG3emE5mnrQC8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id SHL00039;
        Thu, 21 Mar 2024 20:15:39 +0800
Received: from localhost.localdomain (10.94.11.189) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 21 Mar 2024 20:15:40 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<sathya.prakash@broadcom.com>, <sreekanth.reddy@broadcom.com>,
	<suganath-prabu.subramani@broadcom.com>
CC: <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] scsi: mpt3sas: complete function description
Date: Thu, 21 Mar 2024 08:15:33 -0400
Message-ID: <20240321121533.1519-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202432120153994dded071cfb602ad65e351760d0b16e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add unction parameter description.

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


