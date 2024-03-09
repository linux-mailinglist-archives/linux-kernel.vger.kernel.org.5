Return-Path: <linux-kernel+bounces-97802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F758876FB6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CC51F21857
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AC1381C4;
	Sat,  9 Mar 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FifV0NRB"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9D374F1;
	Sat,  9 Mar 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971881; cv=none; b=kAm4uju4Zwad+oaToZNZXINTDprNNMPGj5+SpU+XtdDDCOOcdQTwyQdUaWMoaQeYz+8VIfgWy4sSEMks3gQjeT9FSXKnlJVZCWjy7vBapqOT3h+SSe5gWg8cyIR1kdwtzvMLrkmqeza/He6a/umPTWuOQscTemzcURtkRXBQ8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971881; c=relaxed/simple;
	bh=6JXRE9xbaYXSjjEh7IsdvBn1gHR+jrWYYNpXb7YHIck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsX0KKSRMecdIJMnNpEZ7kPJA77iZg7ylNMPIROPuAhfreu+8l41CizviY0icBhyEzrUYE+Ihc494rSFz/6cdy+Fv6vxm4hC+I9e+EyOASz2kOEJTPLh/tuaL11SBC/ukxAvU8gHpb2u22N6vttX5UyKua42s+uYdzEKv5aDxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FifV0NRB; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709971878; x=1741507878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JXRE9xbaYXSjjEh7IsdvBn1gHR+jrWYYNpXb7YHIck=;
  b=FifV0NRB8rzjVisE/KjDM0afLHpOQelhcoyqh5X5OOxxeB4HHwVSeggB
   Ex7cjQlFrFftaImUztNMurbSk6GCTjzU+8Cjuj/dgmHdkJPey2rHNEz3T
   CZyIgsf4sbzczTcMzSeVm6bxOxgfsIQiS72OWpJqJ4JMvHyEyi+qqTayh
   5wwhKKN1gkWSIp5qhgNopseew34/cGuzdG+LOROndwVCCPsO2dbDoIlQh
   zIvTGGJZFOjwoGds4LoTlH1K7eaf0mTnPEXIoy5puybUuMNZp52UrgXiR
   tvsPB+cy+oVNurCBw4Cu9/bLDQ9aVdsWHQ8n35dC4eNT/jtch43LNv6XZ
   Q==;
X-CSE-ConnectionGUID: I35hU2XKT8S/38c6/6JT5g==
X-CSE-MsgGUID: EGagtkWMQ82YHnaASo2wUA==
X-IronPort-AV: E=Sophos;i="6.07,112,1708358400"; 
   d="scan'208";a="11183736"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 16:11:18 +0800
IronPort-SDR: RyDHBkH088TWClGZpulTfTM208VBnFBtIB92fDWfHwlH/RZZNMd8zndXmD95N+3LIsbmHC6ds7
 lfSSlFim1GIA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 23:14:44 -0800
IronPort-SDR: s5T08JdhM9MormO4Sj/Sfs1ijBeJa+KLDOaw2WzQUou5ELBWClVkVKrpkHOqdgsxS531iettHi
 NBnmFuSFkUWg==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2024 00:11:17 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/4] scsi: ufs: Re-use exec_dev_cmd
Date: Sat,  9 Mar 2024 10:11:00 +0200
Message-ID: <20240309081104.5006-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309081104.5006-1-avri.altman@wdc.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move out the actual command issue from exec_dev_cmd so it can be used
elsewhere.  While at it, remove a redundant "lrbp->cmd = NULL"
assignment.

Also, the device management commands that are originated from the
ufs-bsg code path, are being traced now, which wasn't the case before.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 53 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 983b7b8e3c7c..3f62ad7b4062 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3286,6 +3286,25 @@ static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
 	ufshcd_release(hba);
 }
 
+static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			  const u32 tag, int timeout)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+	int err;
+
+	hba->dev_cmd.complete = &wait;
+
+	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
+
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
+	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
+
+	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
+				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
+
+	return err;
+}
+
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  * @hba: UFS hba
@@ -3300,31 +3319,18 @@ static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
 static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err;
 
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	lrbp = &hba->lrb[tag];
-	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
 	if (unlikely(err))
-		goto out;
-
-	hba->dev_cmd.complete = &wait;
-
-	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
-
-	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
-	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
-	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
-				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
+		return err;
 
-out:
-	return err;
+	return ufshcd_issue_dev_cmd(hba, lrbp, tag, timeout);
 }
 
 /**
@@ -7206,7 +7212,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum dev_cmd_type cmd_type,
 					enum query_opcode desc_op)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
@@ -7246,17 +7251,12 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
-	hba->dev_cmd.complete = &wait;
-
-	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
-
-	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
 	 * read the response directly ignoring all errors.
 	 */
-	ufshcd_wait_for_dev_cmd(hba, lrbp, QUERY_REQ_TIMEOUT);
+	ufshcd_issue_dev_cmd(hba, lrbp, tag, QUERY_REQ_TIMEOUT);
 
 	/* just copy the upiu response as it is */
 	memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
@@ -7371,7 +7371,6 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 			 struct ufs_ehs *rsp_ehs, int sg_cnt, struct scatterlist *sg_list,
 			 enum dma_data_direction dir)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
@@ -7418,11 +7417,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
-	hba->dev_cmd.complete = &wait;
-
-	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
-
-	err = ufshcd_wait_for_dev_cmd(hba, lrbp, ADVANCED_RPMB_REQ_TIMEOUT);
+	err = ufshcd_issue_dev_cmd(hba, lrbp, tag, ADVANCED_RPMB_REQ_TIMEOUT);
 
 	if (!err) {
 		/* Just copy the upiu response as it is */
-- 
2.42.0


