Return-Path: <linux-kernel+bounces-97804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF08876FBA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504FF281E18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860BC39855;
	Sat,  9 Mar 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WqOu0B6a"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B13984D;
	Sat,  9 Mar 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971890; cv=none; b=i/6qz9WPDj9xSF4nebVkKVyVnbrrWRbhIEWephKpwQbH3Xx1UPB7ChmEnXBzJdEPHaF9xHSx3Cpx/uHNlyPqGBrOOr7j2sgSwPKxas3Z+0Z/4/T3BnnrebTUtyJALHOKsjWSoxhpL21Xy/xUGD0T1EFgGNFDt0Y8Kse53qkhn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971890; c=relaxed/simple;
	bh=uadfvdvO0FsBtO9hlkzFwsaQ5dtQnfR/kEXn95ySToQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q087f6PynV9HwYRYlw6oPiDP8eROZdNyE/ihMxngl//FoTktxbxj+jO5nkkmRnXauUoXye5ixJ7O4NtYG8uaGDK0/pXJdhgzc56vppprB6ggHv+EoFtatHdZ0eFLYnd2KjBzLFpgC797fQ/RIG0rOO32bXmq3RVhOqrKsd61x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WqOu0B6a; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709971888; x=1741507888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uadfvdvO0FsBtO9hlkzFwsaQ5dtQnfR/kEXn95ySToQ=;
  b=WqOu0B6as9pl2wNQns9DI+MB39l0YDrcyyDJ9slGKW300qEB9AEaM0wA
   q5oM0+9+QBxec8f3E9UiiMtYxfP6k2Y+Y+q/oR8D3yTYk76/dXVwH4XxX
   8QoZ93kmuq5DCw6xVUNlaNeLM8Tg5Br6FdS3Ilsv0roGQc4rbybRj4tPY
   PVeqNhFGtf43lR6GZvJbrUgJY6pDap6eoWeSst7hFxcXFPJsLwsKmcvjG
   VoKAfqHbKg/gunRDVbmlSvcPa0F2QleNBnk4KN2Ewkm4YINHfxbZQysVK
   JSpnOvgiOiZL9SHJNFij9f2NdWXf1GKIzVqoQg2EdQIfE3jhIlwpcclZm
   w==;
X-CSE-ConnectionGUID: zU+d437dQj6Km4i8WAPvEg==
X-CSE-MsgGUID: XjPh+jYcQya9qy4fCDO61w==
X-IronPort-AV: E=Sophos;i="6.07,112,1708358400"; 
   d="scan'208";a="11183751"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 16:11:28 +0800
IronPort-SDR: fwKyYgGLeYGjL2FVEu/2PFYcLYpZ5tUwkVDdDjhI44lEeCvkW294BW533MRzeSKsmPmlwN/33a
 GgDlik1L4NUQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 23:14:54 -0800
IronPort-SDR: 3S8WZlXJkENcITQYGTvEn/frCW1kzgAWWegGBr/UgL1pd9Vlj+0agPcJUZ1+aLex8bGO0ZTKtI
 q3w3UyUVbYIQ==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2024 00:11:27 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 4/4] scsi: ufs: Re-use compose_devman_upiu
Date: Sat,  9 Mar 2024 10:11:02 +0200
Message-ID: <20240309081104.5006-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309081104.5006-1-avri.altman@wdc.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
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
 include/ufs/ufshci.h      |  2 +-
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c9c2b7f99758..36cbcd30470f 100644
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
+ * @legacy_type: UTP_CMD_TYPE_SCSI or UTP_CMD_TYPE_DEV_MANAGE
  */
-static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp, u8 *upiu_flags,
-					enum dma_data_direction cmd_dir, int ehs_length)
+static void
+ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			    u8 *upiu_flags, enum dma_data_direction cmd_dir,
+			    int ehs_length, enum utp_cmd_type legacy_type)
 {
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	struct request_desc_header *h = &req_desc->header;
 	enum utp_data_direction data_direction;
 
+	if (hba->ufs_version <= ufshci_version(1, 1))
+		lrbp->command_type = legacy_type;
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
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
 
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
+				    lrbp->cmd->sc_data_direction, 0, UTP_CMD_TYPE_SCSI);
 	if (ioprio_class == IOPRIO_CLASS_RT)
 		upiu_flags |= UPIU_CMD_FLAGS_CP;
 	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
@@ -7228,16 +7228,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
 
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
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs, UTP_CMD_TYPE_DEV_MANAGE);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index a196e1c4c3bb..88193f5540e5 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -426,7 +426,7 @@ union ufs_crypto_cfg_entry {
  */
 
 /* Transfer request command type */
-enum {
+enum utp_cmd_type {
 	UTP_CMD_TYPE_SCSI		= 0x0,
 	UTP_CMD_TYPE_UFS		= 0x1,
 	UTP_CMD_TYPE_DEV_MANAGE		= 0x2,
-- 
2.42.0


