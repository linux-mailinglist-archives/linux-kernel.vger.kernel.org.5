Return-Path: <linux-kernel+bounces-92989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438CE87290F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDCD289936
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466A12D21D;
	Tue,  5 Mar 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxFeOtPi"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9F12C80B;
	Tue,  5 Mar 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672501; cv=none; b=ZaygO/I2I/iLDJdAk9PeQQgLXRPmmKG6qm4wZYCZd1o6J2FE2PhG87g/BkW+QsRXaTcN63E8uNBeJowty2Ug5ZU1arsFy00c9SAx8hcbq5SzYMHKyIdX+iSNFIV/ISlFSBDZQH+LOoiN6e4x4/fXJO0y7MRKUMUHLdcE6p5BSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672501; c=relaxed/simple;
	bh=29ejzVaI8kO5HhUl/tLZDpgSk6p3AVFcVgn82c34VcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAL/I4PWYCndMmzijGjDgMRCtQDEZDQNDeUijQgeAZvpbAKDc7GeMo1G3g6qA35TpQ7QN0GlHy2iDv22v9c5ckSXz0lgy9w4NnfGETgda50HNqScuPXQEglL6rv40Q58GYoJPSnLrQydSmZZTb6IjnoYL5VT06RounDDcJbY0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dxFeOtPi; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709672500; x=1741208500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29ejzVaI8kO5HhUl/tLZDpgSk6p3AVFcVgn82c34VcY=;
  b=dxFeOtPi7DXKf94ZAnyqO4bM6ccwqB2w4e6iZxMF8HVWwezhb9Oo98EZ
   wC+2nB0k1YO9D+dQRAgZHgewxR4oXOwk0uHWsh4RDoIwtm07b26088N6K
   vIGrzC9VsJhvkZd6Dek9tdIpUTpUSMozfRtL6GYV1Mb5OyJjHOPdrgaWP
   5XTyLL3nriu8GAA39x4y1KuuL4rYLZGbqxVZ9culFvLitJ5xZYy0zMvon
   rZQQUvmSpJmzMFCak/HWBF6dK3crKEtYt3C7sWRIIp1FOcA0HreOd6ppl
   RpVKfJno8NEUMpZXSYeSydybAULVWmAP7UTYjgWrFgQJ38VESW6MGYQT9
   Q==;
X-CSE-ConnectionGUID: eaFc0iNzRRmZW7Lc5gc4Jg==
X-CSE-MsgGUID: 19Uu2znaQsWkG42YPrKImA==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10728671"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 05:01:38 +0800
IronPort-SDR: sHqXVOknCW2wtQy/7Lq6IElgd9J50U1RFsrfxBqO+U+8NJJ/y0WzsE83bWOgAHuz95zTHnfZES
 elSsjh9CVOvw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 12:05:07 -0800
IronPort-SDR: USV0O+qG8QEIyQNqETbVoFM6BwvoRpVli1KcCHpk7tHiRsAtvGtIxrV1WeEzf7VvhyNKxUuSQP
 fs2N8+bSNd3g==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 13:01:35 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 4/4] scsi: ufs: Re-use compose_devman_upiu
Date: Tue,  5 Mar 2024 23:00:49 +0200
Message-ID: <20240305210051.10847-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240305210051.10847-1-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move some code fragments into ufshcd_prepare_req_desc_hdr so it can
be used throughout.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 49 ++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c9c2b7f99758..a39a2b34ee2b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2710,18 +2710,27 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 /**
  * ufshcd_prepare_req_desc_hdr - Fill UTP Transfer request descriptor header according to request
  * descriptor according to request
+ * @hba: per adapter instance
  * @lrbp: pointer to local reference block
  * @upiu_flags: flags required in the header
  * @cmd_dir: requests data direction
  * @ehs_length: Total EHS Length (in 32‐bytes units of all Extra Header Segments)
+ * @scsi: scsi or device management`
  */
-static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp, u8 *upiu_flags,
-					enum dma_data_direction cmd_dir, int ehs_length)
+static void
+ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			    u8 *upiu_flags, enum dma_data_direction cmd_dir,
+			    int ehs_length, bool scsi)
 {
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	struct request_desc_header *h = &req_desc->header;
 	enum utp_data_direction data_direction;
 
+	if (hba->ufs_version <= ufshci_version(1, 1))
+		lrbp->command_type = scsi ? UTP_CMD_TYPE_SCSI : UTP_CMD_TYPE_DEV_MANAGE;
+	else
+		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+
 	*h = (typeof(*h)){ };
 
 	if (cmd_dir == DMA_FROM_DEVICE) {
@@ -2854,12 +2863,8 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	u8 upiu_flags;
 	int ret = 0;
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, false);
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
 	else if (hba->dev_cmd.type == DEV_CMD_TYPE_NOP)
@@ -2882,13 +2887,8 @@ static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	unsigned int ioprio_class = IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 	u8 upiu_flags;
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_SCSI;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags,
-				    lrbp->cmd->sc_data_direction, 0);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags,
+				    lrbp->cmd->sc_data_direction, 0, true);
 	if (ioprio_class == IOPRIO_CLASS_RT)
 		upiu_flags |= UPIU_CMD_FLAGS_CP;
 	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
@@ -7228,16 +7228,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, false);
 
 	/* update the task tag in the request upiu */
 	req_upiu->header.task_tag = tag;
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
-
 	/* just copy the upiu request as it is */
 	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
 	if (desc_buff && desc_op == UPIU_QUERY_OPCODE_WRITE_DESC) {
@@ -7378,24 +7373,14 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u8 upiu_flags;
 	u8 *ehs_data;
 	u16 ehs_len;
+	int ehs = (hba->capabilities & MASK_EHSLUTRD_SUPPORTED) ? 2 : 0;
 
 	/* Protects use of hba->reserved_slot. */
 	ufshcd_dev_man_lock(hba);
 
 	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
-	/* Advanced RPMB starts from UFS 4.0, so its command type is UTP_CMD_TYPE_UFS_STORAGE */
-	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-
-	/*
-	 * According to UFSHCI 4.0 specification page 24, if EHSLUTRDS is 0, host controller takes
-	 * EHS length from CMD UPIU, and SW driver use EHS Length field in CMD UPIU. if it is 1,
-	 * HW controller takes EHS length from UTRD.
-	 */
-	if (hba->capabilities & MASK_EHSLUTRD_SUPPORTED)
-		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 2);
-	else
-		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 0);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs, false);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
-- 
2.42.0


