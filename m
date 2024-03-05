Return-Path: <linux-kernel+bounces-92987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC587290C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D7C1F294B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F412D1F2;
	Tue,  5 Mar 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oGJoRhCe"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC8168DD;
	Tue,  5 Mar 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672484; cv=none; b=TaJ85egLW7hF+ivO7Y7J9nBxi8WyviEFROA5ygpcyCsv8Zksz2CrnmeFILqcX9ykepK0fs3fV9+xVxm9+8Sy6tcsfiIFTJKls3GmInEDAbWxLMebGlg/LA9F6FwKZGUzupaAk66PlaNIVdb7LwCYz9P0iiOPo9dlPQ8c5BtN6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672484; c=relaxed/simple;
	bh=ZnfZ7ET4S4wv/2O0OfB43T3O8cyA0isR3aRfNcoDRmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW7+kMvKDXMOOT4gmYyYIbZDLyb7tNPmFPIv5evefpKP034PBugIER/dM1QmphAUj8vBL0BBAnc7xbpa7V99tWa88LP97A9bZnq3ToAnhO4qkQs25jAwIzBXgOjrG/X0Cvx/SIMzKFI7uMezy/EvFAGJ7xN1prJ57InffSOHNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oGJoRhCe; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709672481; x=1741208481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnfZ7ET4S4wv/2O0OfB43T3O8cyA0isR3aRfNcoDRmE=;
  b=oGJoRhCeD7m/EtFe1upJOQC+uAsEx7qFV7AYPA6P+lu7mkiWdXY6IcRU
   /+QdmnBfQpWkX/Tg0mcvbYm1XuW0tCo8tp4DEj+FnMYWo/jbE2xoLmqGO
   A42e9lc3b0zzCyFF0+BicTy4zAOcOwjaKYGW7TKBRYOc2dW8f4ENtdc4M
   nueJ3PWy5XmOrPWqJpFX1iMOm/uvPA3VAgne6E9GbIAk3kTEZLRiAxcWu
   GDE5dqcX54cWwMGMhgHagdrzqhkfE5zh8mDdiZPLVW8oeo1ymvbTdRINq
   BRae4gPGsdGq0DA1uqdUAuB8b9jtjH1z23hY7TxPUfs50D6n4I99ZAmfc
   Q==;
X-CSE-ConnectionGUID: 6Zi/sagxS3iEqeokvHFWYg==
X-CSE-MsgGUID: ESprFExJQI6/QYU1pJVnjw==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="11475152"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 05:01:20 +0800
IronPort-SDR: YmXt7AuP4dn8bMSM65zDKgDFdz0g/KBjwRDsk5sC/1UAmICCm6LLbYHZ0yFNNsPJZkQQCjkhWS
 lh7BLkyQEsRg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 12:10:31 -0800
IronPort-SDR: EqkbNSMQh2+6eQtB1ZejmsXhgDYwgoSuizsi4k/Qx2r5PVKHkaPduGQm6vQWwsiVA7OvhqR2ji
 6Oi9KMDfp/Yg==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 13:01:18 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
Date: Tue,  5 Mar 2024 23:00:47 +0200
Message-ID: <20240305210051.10847-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240305210051.10847-1-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move out the actual command issue from exec_dev_cmd so it can be used
elsewhere.  While at it, remove a redundant "lrbp->cmd = NULL"
assignment.  Also, as a free bonus, call the upiu trace if it doesn't.

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


