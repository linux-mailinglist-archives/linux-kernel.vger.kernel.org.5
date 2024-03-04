Return-Path: <linux-kernel+bounces-90313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DED86FD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2301F2624F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD822EF3;
	Mon,  4 Mar 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vea07Fhy"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0792381D5;
	Mon,  4 Mar 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544250; cv=none; b=G+/cVLNg9ZxBGahojiZTnhaJi1q/RCkdi0M/HYJJB0SqVlNDTzIys7+C0AUqifZt8OJvCs5yQG2RYzQ+Kkhfns/J0x/HYlWAhfrrwUQAdGwUkk0zatKbc+FXsvlcYi2nfUB1Nn2h5QMcIavIyQOJZP3a6N8CH8XZdDIqQakoSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544250; c=relaxed/simple;
	bh=0N5g4Lbf2wqsl2XYbQDUUiyLdK42itGhFfSDbgZqjJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyt7lauoIN3sp6JaocQz5AKoFdew5EarSCnD9ZcpjqCaI6xh6+edgOQCTguJmp2lSS2ctgXewbxqhF5v7F0x4vVBBUbuq6WFt1sekm5/e+YxmkTymZLqYQZb7LHebfcpMFIMC45Z8Gcablb/If9Mm4z0wfoN/hxRLVsBbfe5Ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Vea07Fhy; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709544247; x=1741080247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0N5g4Lbf2wqsl2XYbQDUUiyLdK42itGhFfSDbgZqjJE=;
  b=Vea07FhyrSBnjPAcyn/uv/Cgu6UP7KP8OJtd1Hd5Frw3MrImzr3kHKgB
   mz2m4zVXAseBJ6vRloHxqRbU3Z+9XkVtXLZNETv8HBs3XYpP+0VGv4cS+
   5yYYAFmSjO0gha70hHSNa7a2bUmRHHmiKWyJLqQJtl77zfJA80cQFI4pl
   XxlDoqbUfrnUMe1A2C+vlb224kqbWEp5LxDOB1UVkj18Z+6f9dSU2h3z1
   EziSeEU4wEvLn+NwfkHFhbBzNLXUu/Ufj7n8gg9M8kyUiErHInXNP5951
   hoDWHSzJGnxjr07SMswehy3BJA2q4NtddaDV4/mf8lFUjvtDUQsaKWg4u
   g==;
X-CSE-ConnectionGUID: tJ0ts92FRkC03VDP2YxXfw==
X-CSE-MsgGUID: 0OMr42/zQLy9Kul8WL1AjA==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11326500"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 17:24:07 +0800
IronPort-SDR: G2x8Kfh6qlweDaWEbN9TCyCO+LTCFPoRvymDF56Eyx3anWXrlIPF8XwfUcRdxxeTtrG2r8aUfy
 Vy5zHLUIaMxA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 00:33:20 -0800
IronPort-SDR: WyN89J76c/K8poVUTfafW2Lu86JXhLp95dBHl0Dx7KVj2Vp8TAxiIkUGdYoC3UlgiODuyHxEvl
 18Qks+OJM4tA==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2024 01:24:05 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Date: Mon,  4 Mar 2024 11:23:44 +0200
Message-ID: <20240304092346.654-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304092346.654-1-avri.altman@wdc.com>
References: <20240304092346.654-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move out the actual command issue from exec_dev_cmd so it can be used
elsewhere.  While at it, as a free bonus, call the upiu trace if it
doesn't.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 52 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7456f046e7de..6661054e4872 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3286,6 +3286,24 @@ static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
 	ufshcd_release(hba);
 }
 
+static int __exec_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
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
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  * @hba: UFS hba
@@ -3300,28 +3318,15 @@ static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
 static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err;
 
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
+	return __exec_dev_cmd(hba, lrbp, tag, timeout);
 }
 
 /**
@@ -7203,7 +7208,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum dev_cmd_type cmd_type,
 					enum query_opcode desc_op)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
@@ -7240,17 +7244,12 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
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
+	__exec_dev_cmd(hba, lrbp, tag, QUERY_REQ_TIMEOUT);
 
 	/* just copy the upiu response as it is */
 	memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
@@ -7365,7 +7364,6 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 			 struct ufs_ehs *rsp_ehs, int sg_cnt, struct scatterlist *sg_list,
 			 enum dma_data_direction dir)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	const u32 tag = hba->reserved_slot;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
@@ -7412,11 +7410,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
-	hba->dev_cmd.complete = &wait;
-
-	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
-
-	err = ufshcd_wait_for_dev_cmd(hba, lrbp, ADVANCED_RPMB_REQ_TIMEOUT);
+	err = __exec_dev_cmd(hba, lrbp, tag, ADVANCED_RPMB_REQ_TIMEOUT);
 
 	if (!err) {
 		/* Just copy the upiu response as it is */
-- 
2.42.0


