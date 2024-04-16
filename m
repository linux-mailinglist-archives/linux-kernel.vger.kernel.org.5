Return-Path: <linux-kernel+bounces-146618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB148A683F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CED1F21D71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF4128399;
	Tue, 16 Apr 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j8PDHbzp"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EF127E0C;
	Tue, 16 Apr 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263053; cv=none; b=r2ooOicQcGShmzVzDA0xS8iFklnzI/zLeb6Qbnco4IsMzX8sdDD7YLpLnp5QUZtLlCi/WvgfR0Sd/aPqC3bmrdI7mFltFvJTTgOaFT5xiQxRv7zhHSd7UlGwMcQpHgOyLcPkkZSO2IEXbDgQC5AWjG5l/cSUK46rsbnG5nKQMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263053; c=relaxed/simple;
	bh=REfhqUuLCetoty0eudjcd5bnQwPUfofu4YWMWOwN8mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWaVxkxHeUcmpK7E2gooOFMBMjYceNxjsh/SOM+hFXzZf6SAjG4qg4vDLvUWoH0bkQBsUlSb8nUkcVuKgloRkxF5vgfC8JVRlneb8fDIfQMvPvTvmignZcw509gH+OmcrVNEfw+koJXMSBvAvrf28SGOWKRQcO+BV7ZJkMCZ8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j8PDHbzp; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263049; x=1744799049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=REfhqUuLCetoty0eudjcd5bnQwPUfofu4YWMWOwN8mM=;
  b=j8PDHbzpjYKpt8vgSnPe1nlW9ftyjTJ3Lp5Sz4F0zO2mVOsR/z9yNVVA
   Nz3+l3ezWty4V2XNIvzff7IKTVz4961duKPxxjSDViQnd15+mbdvOYwrb
   P7iy2/Ok4g45TkQQSEMU9Tb02/d9XYix9UvLKb7+hhL4s9B+xn6XUxiov
   NyZU9Rm2yVwo4cY18udoNbUx2DV52LHW8Pbr7NxOybuw9OeOPxWHQI6B4
   Hqy9Oyh4bSCqmk8Ae99wh4ppOiC4N5waiqGEPMERvjjjceA6B7RLQi6Y0
   YqlNS7QJ6LfwdgC05Q++F/4VEcz/IR7uOwgCfsDxEeUnyrNSDAyAiM1RU
   w==;
X-CSE-ConnectionGUID: vGVMjB7cS+67m1fKiVjBTg==
X-CSE-MsgGUID: OsCWu4wOQm+MipTyqx+5DA==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14321976"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:24:06 +0800
IronPort-SDR: i0egqbl1ZIlJKsWyebmb19j3nHV7tj1JPbPM0KqIXyY2ea/2DjbfbujNwJsiUR0CWvSJFd6U8O
 78ZjWoXGWvtzeV/8BrCjbn2u0ARW8+ZMlPUZ3vAB0Q09Zp6CH4dlVhAm/z21LK7KsyQm/Q1Q9h
 x4wR2+grhxcG3usHD4eFg6SQ0t5CWwcTxfSj7jWU0s+sbl2xXakf4mf1D5ANozwCL6nPsIXk5F
 bErO+CRsPbQ+o2HFV2kz4bTgDUseXPtJCSTzzVgdTeRZZOcoNxZb1YaTAZoDSU4BEI1KFx2skV
 XMI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:32:26 -0700
IronPort-SDR: 3UH7QfIwD9HpxvAZMOoVZApdRSkGEdQfrGAW11Y+pOEabFUey5u5qMpeFKhzCMe4tkG260szwm
 u7ZQOuTi7cTEcC9TB4YNEwPAS8xXXQmJtg7DlVLgMfkDsXi7CjVqpN462Z6CcbSPmSpKpJBlTb
 C4RTAgNVQcYU+AVSEW1W/RpwxxfQ1HmevmeYC6E0OUxsl4DBcpPs3NSkzlKHxMkrX7dvI0ppDh
 VKFqu8i4KamMuMb63akBO6pcP4YPhehfL0BONwDP1OnbUY+o+mUDGyJo4Lfz0T9qcsdnj3UrjT
 flk=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2024 03:24:04 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/4] scsi: ufs: core: Make use of guard(spinlock)
Date: Tue, 16 Apr 2024 13:23:46 +0300
Message-ID: <20240416102348.614-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416102348.614-1-avri.altman@wdc.com>
References: <20240416102348.614-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded handling with cleanup.h guard(spinlock) and
scoped_guard(spinlock, ...).

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6e35b597dfb5..92ac6a358365 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -132,6 +132,7 @@ MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from U
 } while (0)
 
 #define SERIALIZE_HOST_IRQSAVE(hba) guard(spinlock_irqsave)(hba->host->host_lock)
+#define SERIALIZE_HOST(hba) guard(spinlock)(hba->host->host_lock)
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix)
@@ -2291,11 +2292,11 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
 		struct utp_transfer_req_desc *dest;
 
-		spin_lock(&hwq->sq_lock);
-		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
-		memcpy(dest, src, utrd_size);
-		ufshcd_inc_sq_tail(hwq);
-		spin_unlock(&hwq->sq_lock);
+		scoped_guard(spinlock, &hwq->sq_lock) {
+			dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
+			memcpy(dest, src, utrd_size);
+			ufshcd_inc_sq_tail(hwq);
+		}
 	} else {
 		scoped_guard(spinlock_irqsave, &hba->outstanding_lock) {
 			if (hba->vops && hba->vops->setup_xfer_req)
@@ -5446,7 +5447,8 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 {
 	irqreturn_t retval = IRQ_NONE;
 
-	spin_lock(hba->host->host_lock);
+	SERIALIZE_HOST(hba);
+
 	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
 		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
 
@@ -5470,7 +5472,6 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 	if (retval == IRQ_HANDLED)
 		ufshcd_add_uic_command_trace(hba, hba->active_uic_cmd,
 					     UFS_CMD_COMP);
-	spin_unlock(hba->host->host_lock);
 	return retval;
 }
 
@@ -6786,7 +6787,8 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 	bool queue_eh_work = false;
 	irqreturn_t retval = IRQ_NONE;
 
-	spin_lock(hba->host->host_lock);
+	SERIALIZE_HOST(hba);
+
 	hba->errors |= UFSHCD_ERROR_MASK & intr_status;
 
 	if (hba->errors & INT_FATAL_ERRORS) {
@@ -6845,7 +6847,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 	 */
 	hba->errors = 0;
 	hba->uic_error = 0;
-	spin_unlock(hba->host->host_lock);
+
 	return retval;
 }
 
-- 
2.42.0


