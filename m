Return-Path: <linux-kernel+bounces-118552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846988BC88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD82E29FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125EA43AA4;
	Tue, 26 Mar 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lK4jjU7+"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9BEEA8;
	Tue, 26 Mar 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442001; cv=none; b=umXRf3RXGVxH8SwRh67/Ess5U+hyuy2wdFXyhO5gAJLtWEUnMyGWisTWeE2czsz+zLvav0VhR63aK6PQiPHPwSy+8cuvF/4MsCWprsQO9J7MyUnf15DoTNnKIxLbeasaVnRNobTIQ7RbX0pfx0WWJXmxN/0YUgnp1SdHC374lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442001; c=relaxed/simple;
	bh=Omr0cRds6Atsx+0DtQhcG//wTiSm+bz26TyhMod6BlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3Ms9uxcQhPkWh/ncXP+rAja+xGS2HFOY6aasreg8i06wWN6Fyznz/nfyxIrgbRhLKg8i2KzvfFZl9DIgVKSn+3/ZNnIRTLqosFNBugJ2PeJgW074Yhp1n4EL2AAdLC6rfDylhaMbE0+3fLLhalTepH1knxNFlgqTMYVlmHVRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lK4jjU7+; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711441999; x=1742977999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Omr0cRds6Atsx+0DtQhcG//wTiSm+bz26TyhMod6BlE=;
  b=lK4jjU7+xaYOF4a7/ewE5qMhLTuuqxjL1KPiBsGqU0lOJDdJwvQpFAmq
   RjPs7hNSBj0GIcRvh1AnulZ1JbvXYyjUOEbwwR4tTHCb5B+OJubg64IyS
   MLE8KBuW5BH4Bip0AP+5XS/vKrPOGDq3msNh9cqc73FY/FJqaR8GKDnLv
   KOttjTQe/eizVeKjsI7uQV9KZ5KpThHBoEswK9Eaq083lCk6/o84aRjrv
   9rjQMXtGpucM248aujqU4rwmpSESn03U/UVDhDRHfQ/mggYSv7LzMZMhm
   HPYQ7gt4hJOXWEMl0HrnIJMrtSHuCYlw8z0VXD/NaS5DoOWVigYxkLvo0
   w==;
X-CSE-ConnectionGUID: LCb0ZaI2T/ujP4m+j7wWzQ==
X-CSE-MsgGUID: hLYwWrrIS22lHCRG2B9pWA==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12495278"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 16:33:12 +0800
IronPort-SDR: CFqKlPTslS98Ukp7J/R/Yg6mJGaTUUKjnbSAWYA7b3xMdzNIAHm9jJMo/sQw0rSS9yF1hiVLoz
 jVarziEmGwDg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 00:41:57 -0700
IronPort-SDR: 8AYhFVs0a4Rb0/PjG8h7dfyQJYmRdbAOnsSueF6qM7wQlO3MHKY6tV1qRirk/1Qe0LtEsiAOX6
 m8X7acX+tvHQ==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Mar 2024 01:33:10 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Date: Tue, 26 Mar 2024 10:32:49 +0200
Message-ID: <20240326083253.1303-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240326083253.1303-1-avri.altman@wdc.com>
References: <20240326083253.1303-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

UFS spec version 2.1 was published more than 10 years ago. It is
vanishingly unlikely that even there are out there platforms that uses
earlier host controllers, let alone that those ancient platforms will
ever run a V6.10 kernel.  Thus, remove support of host controllers prior
to UFS2.1.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 73 ++++++++-------------------------------
 include/ufs/ufshci.h      |  7 ----
 2 files changed, 15 insertions(+), 65 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 823bc28c0cb0..cda1939f2d8a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -740,22 +740,6 @@ static int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
 	return err;
 }
 
-/**
- * ufshcd_get_intr_mask - Get the interrupt bit mask
- * @hba: Pointer to adapter instance
- *
- * Return: interrupt bit mask per version
- */
-static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
-{
-	if (hba->ufs_version == ufshci_version(1, 0))
-		return INTERRUPT_MASK_ALL_VER_10;
-	if (hba->ufs_version <= ufshci_version(2, 0))
-		return INTERRUPT_MASK_ALL_VER_11;
-
-	return INTERRUPT_MASK_ALL_VER_21;
-}
-
 /**
  * ufshcd_get_ufs_version - Get the UFS version supported by the HBA
  * @hba: Pointer to adapter instance
@@ -992,10 +976,6 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
 
 u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
 {
-	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		return UFS_UNIPRO_VER_1_41;
-	else
 		return UFS_UNIPRO_VER_1_6;
 }
 EXPORT_SYMBOL(ufshcd_get_local_unipro_ver);
@@ -2674,14 +2654,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs)
 {
 	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
-	if (hba->ufs_version == ufshci_version(1, 0)) {
-		u32 rw;
-		rw = set & INTERRUPT_MASK_RW_VER_10;
-		set = rw | ((set ^ intrs) & intrs);
-	} else {
-		set |= intrs;
-	}
-
+	set |= intrs;
 	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
 }
 
@@ -2694,16 +2667,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
 {
 	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
-	if (hba->ufs_version == ufshci_version(1, 0)) {
-		u32 rw;
-		rw = (set & INTERRUPT_MASK_RW_VER_10) &
-			~(intrs & INTERRUPT_MASK_RW_VER_10);
-		set = rw | ((set & intrs) & ~INTERRUPT_MASK_RW_VER_10);
-
-	} else {
-		set &= ~intrs;
-	}
-
+	set &= ~intrs;
 	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
 }
 
@@ -2715,21 +2679,17 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
  * @upiu_flags: flags required in the header
  * @cmd_dir: requests data direction
  * @ehs_length: Total EHS Length (in 32‐bytes units of all Extra Header Segments)
- * @legacy_type: UTP_CMD_TYPE_SCSI or UTP_CMD_TYPE_DEV_MANAGE
  */
 static void
 ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 			    u8 *upiu_flags, enum dma_data_direction cmd_dir,
-			    int ehs_length, enum utp_cmd_type legacy_type)
+			    int ehs_length)
 {
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	struct request_desc_header *h = &req_desc->header;
 	enum utp_data_direction data_direction;
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = legacy_type;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
 	*h = (typeof(*h)){ };
 
@@ -2863,7 +2823,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	u8 upiu_flags;
 	int ret = 0;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
@@ -2887,8 +2847,7 @@ static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	unsigned int ioprio_class = IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 	u8 upiu_flags;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags,
-				    lrbp->cmd->sc_data_direction, 0, UTP_CMD_TYPE_SCSI);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, lrbp->cmd->sc_data_direction, 0);
 	if (ioprio_class == IOPRIO_CLASS_RT)
 		upiu_flags |= UPIU_CMD_FLAGS_CP;
 	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
@@ -5565,15 +5524,13 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 		ufshcd_release_scsi_cmd(hba, lrbp);
 		/* Do not touch lrbp after scsi done */
 		scsi_done(cmd);
-	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
-		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
-		if (hba->dev_cmd.complete) {
-			if (cqe) {
-				ocs = le32_to_cpu(cqe->status) & MASK_OCS;
-				lrbp->utr_descriptor_ptr->header.ocs = ocs;
-			}
-			complete(hba->dev_cmd.complete);
+	} else {
+		WARN_ON(!hba->dev_cmd.complete);
+		if (cqe) {
+			ocs = le32_to_cpu(cqe->status) & MASK_OCS;
+			lrbp->utr_descriptor_ptr->header.ocs = ocs;
 		}
+		complete(hba->dev_cmd.complete);
 	}
 }
 
@@ -7229,7 +7186,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	/* update the task tag in the request upiu */
 	req_upiu->header.task_tag = tag;
@@ -7381,7 +7338,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
@@ -10508,7 +10465,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	hba->ufs_version = ufshcd_get_ufs_version(hba);
 
 	/* Get Interrupt bit mask per version */
-	hba->intr_mask = ufshcd_get_intr_mask(hba);
+	hba->intr_mask = INTERRUPT_MASK_ALL_VER_21;
 
 	err = ufshcd_set_dma_mask(hba);
 	if (err) {
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 88193f5540e5..aecdc209ab75 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -425,13 +425,6 @@ union ufs_crypto_cfg_entry {
  * Request Descriptor Definitions
  */
 
-/* Transfer request command type */
-enum utp_cmd_type {
-	UTP_CMD_TYPE_SCSI		= 0x0,
-	UTP_CMD_TYPE_UFS		= 0x1,
-	UTP_CMD_TYPE_DEV_MANAGE		= 0x2,
-};
-
 /* To accommodate UFS2.0 required Command type */
 enum {
 	UTP_CMD_TYPE_UFS_STORAGE	= 0x1,
-- 
2.42.0


