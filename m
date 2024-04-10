Return-Path: <linux-kernel+bounces-139213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0989FFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937451F2287C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7E1802A8;
	Wed, 10 Apr 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dliv2Rrp"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9852E405;
	Wed, 10 Apr 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774258; cv=none; b=Z5Jk277PTkuVHdb7FUrytIsdigZn1LgRPTDgEOfCrWK6n+FISaGnqBMZhYbs7Jj6fsFOawnmUxcpByEzhaCsElsoivVw1iBN6fhsuKz34ZtuTpGsPSNmT2O1w44ovFuIUfZ521qmRbGG0BZAOppyObOP/1K2AkuB3nwwvMTw0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774258; c=relaxed/simple;
	bh=TVOV/GWkqbMiiR/JkLVkOlvw44xGfhxzwFvsMYf3GHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBfCTbEm8Wmf+Zo0kuXU4Eh0jfoxFKbFApIzY6fsEgPLdM+hyGPa8Ed3F3sV4R3cw2eXOSrc7rh5Fd2e/UyytGQs9xtM7WxZxYSEsUwT/mC5EDCZSdiZsCgBQIjmOG5XBDYM6arqtUMjA0HG8N6V3bKlfGzpKnbeWPK/GRuRjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Dliv2Rrp; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712774254; x=1744310254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVOV/GWkqbMiiR/JkLVkOlvw44xGfhxzwFvsMYf3GHg=;
  b=Dliv2RrpHP/r83QLQWe4qvKEe/1eTcMHDLbU6NVL4vAU+PEmtvmEBsTT
   7FzuNpqQ13LybZBGnc0a/acXjUOVkb4fAFN7ZSU7XZw+z+vskqHVrDDFW
   JZT/gzokWDVqKtYkK1SsAgQC2hK0Rylu83QCka1dTbOjpPHiaY43cGsBb
   sWVcGZG31C+wASCSFvNCNpbpxN+uPK793fOlz4hqdqovDwgIUR+/Y4cJJ
   yXhLCT6Z/1TvSRJ73/udFLflJRI3jV7Zz/5VZnmzKVa2hRZpN7i+IaunA
   b/c1vDZe8O40CPoVwi/QxrwTdGUhtSHV7G8Aczw0bWt1FbhFJueMLkTeJ
   A==;
X-CSE-ConnectionGUID: FNZgSnVaQgCZybPe9OxCig==
X-CSE-MsgGUID: PatmdwOGRzCNpugwxvtxzg==
X-IronPort-AV: E=Sophos;i="6.07,191,1708358400"; 
   d="scan'208";a="13708157"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 02:37:34 +0800
IronPort-SDR: 39vo/DcldduxGCi4+v1vEJllZn9XX71Dc1t8ySZNt47hYZsfpy7DmGjgO3YNXFcTvmvlbBq/+7
 U6BNVpy+Qvyw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2024 10:46:01 -0700
IronPort-SDR: AyFh0v5bgENVSmPma+dTKh4mwbQGX3LRZgRYPDwiS96JkY2xMij1TFNSDskCynA0DSnwuBUiOD
 5HrPaHWXj0iw==
WDCIronportException: Internal
Received: from 5cd220gd5d.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.26])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2024 11:37:32 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 1/1] scsi: ufs: Remove support for old UFSHCI versions
Date: Wed, 10 Apr 2024 21:37:19 +0300
Message-ID: <20240410183720.908-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240410183720.908-1-avri.altman@wdc.com>
References: <20240410183720.908-1-avri.altman@wdc.com>
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
ever run a V6.10 kernel.  To be extra cautious, leave out removal of
UFSHCI 2.0 support from this patch, and just remove support of host
controllers prior to UFS2.0.

This patch removes some legacy tuning calls that no longer apply.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c   | 158 +++---------------------------------
 drivers/ufs/host/ufs-qcom.c |   3 +-
 include/ufs/ufshcd.h        |   2 -
 include/ufs/ufshci.h        |  13 +--
 4 files changed, 15 insertions(+), 161 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 62c8575f2c67..c72ef87ea867 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -748,8 +748,6 @@ static int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
  */
 static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
 {
-	if (hba->ufs_version == ufshci_version(1, 0))
-		return INTERRUPT_MASK_ALL_VER_10;
 	if (hba->ufs_version <= ufshci_version(2, 0))
 		return INTERRUPT_MASK_ALL_VER_11;
 
@@ -990,30 +988,6 @@ bool ufshcd_is_hba_active(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
 
-u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
-{
-	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		return UFS_UNIPRO_VER_1_41;
-	else
-		return UFS_UNIPRO_VER_1_6;
-}
-EXPORT_SYMBOL(ufshcd_get_local_unipro_ver);
-
-static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
-{
-	/*
-	 * If both host and device support UniPro ver1.6 or later, PA layer
-	 * parameters tuning happens during link startup itself.
-	 *
-	 * We can manually tune PA layer parameters if either host or device
-	 * doesn't support UniPro ver 1.6 or later. But to keep manual tuning
-	 * logic simple, we will only do manual tuning if local unipro version
-	 * doesn't support ver1.6 or later.
-	 */
-	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
-}
-
 /**
  * ufshcd_pm_qos_init - initialize PM QoS request
  * @hba: per adapter instance
@@ -2674,14 +2648,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2694,16 +2661,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2715,21 +2673,17 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2863,7 +2817,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	u8 upiu_flags;
 	int ret = 0;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
@@ -2887,8 +2841,7 @@ static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	unsigned int ioprio_class = IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 	u8 upiu_flags;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags,
-				    lrbp->cmd->sc_data_direction, 0, UTP_CMD_TYPE_SCSI);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, lrbp->cmd->sc_data_direction, 0);
 	if (ioprio_class == IOPRIO_CLASS_RT)
 		upiu_flags |= UPIU_CMD_FLAGS_CP;
 	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
@@ -5559,15 +5512,12 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
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
+	} else if (hba->dev_cmd.complete) {
+		if (cqe) {
+			ocs = le32_to_cpu(cqe->status) & MASK_OCS;
+			lrbp->utr_descriptor_ptr->header.ocs = ocs;
 		}
+		complete(hba->dev_cmd.complete);
 	}
 }
 
@@ -7220,7 +7170,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	/* update the task tag in the request upiu */
 	req_upiu->header.task_tag = tag;
@@ -7372,7 +7322,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
@@ -8359,83 +8309,6 @@ static void ufs_put_device_desc(struct ufs_hba *hba)
 	dev_info->model = NULL;
 }
 
-/**
- * ufshcd_tune_pa_tactivate - Tunes PA_TActivate of local UniPro
- * @hba: per-adapter instance
- *
- * PA_TActivate parameter can be tuned manually if UniPro version is less than
- * 1.61. PA_TActivate needs to be greater than or equal to peerM-PHY's
- * RX_MIN_ACTIVATETIME_CAPABILITY attribute. This optimal value can help reduce
- * the hibern8 exit latency.
- *
- * Return: zero on success, non-zero error value on failure.
- */
-static int ufshcd_tune_pa_tactivate(struct ufs_hba *hba)
-{
-	int ret = 0;
-	u32 peer_rx_min_activatetime = 0, tuned_pa_tactivate;
-
-	ret = ufshcd_dme_peer_get(hba,
-				  UIC_ARG_MIB_SEL(
-					RX_MIN_ACTIVATETIME_CAPABILITY,
-					UIC_ARG_MPHY_RX_GEN_SEL_INDEX(0)),
-				  &peer_rx_min_activatetime);
-	if (ret)
-		goto out;
-
-	/* make sure proper unit conversion is applied */
-	tuned_pa_tactivate =
-		((peer_rx_min_activatetime * RX_MIN_ACTIVATETIME_UNIT_US)
-		 / PA_TACTIVATE_TIME_UNIT_US);
-	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TACTIVATE),
-			     tuned_pa_tactivate);
-
-out:
-	return ret;
-}
-
-/**
- * ufshcd_tune_pa_hibern8time - Tunes PA_Hibern8Time of local UniPro
- * @hba: per-adapter instance
- *
- * PA_Hibern8Time parameter can be tuned manually if UniPro version is less than
- * 1.61. PA_Hibern8Time needs to be maximum of local M-PHY's
- * TX_HIBERN8TIME_CAPABILITY & peer M-PHY's RX_HIBERN8TIME_CAPABILITY.
- * This optimal value can help reduce the hibern8 exit latency.
- *
- * Return: zero on success, non-zero error value on failure.
- */
-static int ufshcd_tune_pa_hibern8time(struct ufs_hba *hba)
-{
-	int ret = 0;
-	u32 local_tx_hibern8_time_cap = 0, peer_rx_hibern8_time_cap = 0;
-	u32 max_hibern8_time, tuned_pa_hibern8time;
-
-	ret = ufshcd_dme_get(hba,
-			     UIC_ARG_MIB_SEL(TX_HIBERN8TIME_CAPABILITY,
-					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
-				  &local_tx_hibern8_time_cap);
-	if (ret)
-		goto out;
-
-	ret = ufshcd_dme_peer_get(hba,
-				  UIC_ARG_MIB_SEL(RX_HIBERN8TIME_CAPABILITY,
-					UIC_ARG_MPHY_RX_GEN_SEL_INDEX(0)),
-				  &peer_rx_hibern8_time_cap);
-	if (ret)
-		goto out;
-
-	max_hibern8_time = max(local_tx_hibern8_time_cap,
-			       peer_rx_hibern8_time_cap);
-	/* make sure proper unit conversion is applied */
-	tuned_pa_hibern8time = ((max_hibern8_time * HIBERN8TIME_UNIT_US)
-				/ PA_HIBERN8_TIME_UNIT_US);
-	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HIBERN8TIME),
-			     tuned_pa_hibern8time);
-out:
-	return ret;
-}
-
 /**
  * ufshcd_quirk_tune_host_pa_tactivate - Ensures that host PA_TACTIVATE is
  * less than device PA_TACTIVATE time.
@@ -8508,11 +8381,6 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 
 static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 {
-	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
-		ufshcd_tune_pa_tactivate(hba);
-		ufshcd_tune_pa_hibern8time(hba);
-	}
-
 	ufshcd_vops_apply_dev_quirks(hba);
 
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_PA_TACTIVATE)
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 0c067d56305c..cca190d1c577 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -534,8 +534,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 		 * and device TX LCC are disabled once link startup is
 		 * completed.
 		 */
-		if (ufshcd_get_local_unipro_ver(hba) != UFS_UNIPRO_VER_1_41)
-			err = ufshcd_disable_host_tx_lcc(hba);
+		err = ufshcd_disable_host_tx_lcc(hba);
 
 		break;
 	default:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a35e12f8e68b..431af365cf5e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1390,8 +1390,6 @@ void ufshcd_release(struct ufs_hba *hba);
 
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value);
 
-u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
-
 int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg);
 
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd);
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 88193f5540e5..385e1c6b8d60 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -355,12 +355,8 @@ enum {
 
 /* Interrupt disable masks */
 enum {
-	/* Interrupt disable mask for UFSHCI v1.0 */
-	INTERRUPT_MASK_ALL_VER_10	= 0x30FFF,
-	INTERRUPT_MASK_RW_VER_10	= 0x30000,
-
 	/* Interrupt disable mask for UFSHCI v1.1 */
-	INTERRUPT_MASK_ALL_VER_11	= 0x31FFF,
+	INTERRUPT_MASK_ALL_VER_11       = 0x31FFF,
 
 	/* Interrupt disable mask for UFSHCI v2.1 */
 	INTERRUPT_MASK_ALL_VER_21	= 0x71FFF,
@@ -425,13 +421,6 @@ union ufs_crypto_cfg_entry {
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


