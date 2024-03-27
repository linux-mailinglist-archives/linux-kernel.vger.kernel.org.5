Return-Path: <linux-kernel+bounces-120417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8688D715
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE27529C292
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B525779;
	Wed, 27 Mar 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NOOh64o5"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939C28DD7;
	Wed, 27 Mar 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523857; cv=none; b=AqYeXZ2hhKtSqDMr3Z+zLigsa6qVvxB7qrijmlrO3VZZCTGwd1KCH4YaJqv4dnQ7WJLlCl/CCOBeit9SLEkM9zE8PV1qIoBQgD7OxUyGrZyai2/PEOLAFK0MzYdR9p9jPs9c3kL/ILTQ1llMmsfA9E3acX/gHiI418tai24paFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523857; c=relaxed/simple;
	bh=CsIKPXnLCXhmQwuVYaC6EmvEpXzQLzOLvOM5hQqs1GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Axiajy/D2jc55wlFi3P+6SsWJcRDqh0jITZXWGmpFK7W5VtXtryhRKU86DIpqUMKt/e1FuyfGWS1DihHJsotlAbvqM4Lh0AC39rB1e9TK4tZiAxteyb3cX9L/4SPa9DlCHbCt3lfzeHW0w3y89Xwj72X8R8CA6hclI6Qppb/94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NOOh64o5; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711523855; x=1743059855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsIKPXnLCXhmQwuVYaC6EmvEpXzQLzOLvOM5hQqs1GQ=;
  b=NOOh64o57ZUpTHe3Rnr2Lqd6slHkmxXglUH3+C4Cdt8A7WoidVRG8C0a
   Jj7nSQSApKQ8/P4FWZ55VAaZ18yOgtTEC7ZhYk4+9Z0L5DgGzXA9kT4Gi
   Gj++6uJwnjcSiw4UPkINsgy+CY3qcXH4H7UpzHGK4Rn8H2d8aWabH+MDX
   5pN/aC3tupZOWuoBanJMHTbS4reoYLAkeBchmDzK8j5P/4+2Aaflg+Nch
   jNcx0hJcVq7+oosMboDL4ZdConXUcHvr2zqKBqvaGczIwYERw+ZegR8/a
   km9kQ9xTgtP7GF2HfSU/WXgQqRIH4eXSs7D0En22fHTNi2aGVPFtLNKLG
   g==;
X-CSE-ConnectionGUID: tha2nNgLRriig5Ez65UZNw==
X-CSE-MsgGUID: Bb/GHJbrQRmgulCrlzqePw==
X-IronPort-AV: E=Sophos;i="6.07,158,1708358400"; 
   d="scan'208";a="13230195"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 15:17:33 +0800
IronPort-SDR: Kt2iwieoNpCJIRRzVlDbzf5UrDKlAGi8l8ns8uxuI/iB3YM7fMhaPctuzH6q6sKTp3ihxMHsKd
 1QjNT0FTkSBA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 23:20:37 -0700
IronPort-SDR: 2Iwx4my24L0X7NKHy6eaVEZxxm12tqM5QUThqQ9IiMXE89MMH/0XULYRqiLLtyxS/usZh000j8
 sPwaIP5tWpIQ==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2024 00:17:31 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Date: Wed, 27 Mar 2024 09:17:13 +0200
Message-ID: <20240327071714.757-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240327071714.757-1-avri.altman@wdc.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
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

This patch removes some legacy tuning calls that no longer apply.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c   | 174 +++---------------------------------
 drivers/ufs/host/ufs-qcom.c |   3 +-
 include/ufs/ufshcd.h        |   2 -
 include/ufs/ufshci.h        |   7 --
 4 files changed, 15 insertions(+), 171 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 823bc28c0cb0..7791ee780eb1 100644
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
@@ -990,30 +974,6 @@ bool ufshcd_is_hba_active(struct ufs_hba *hba)
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
@@ -2674,14 +2634,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2694,16 +2647,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2715,21 +2659,17 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
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
 
@@ -2863,7 +2803,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	u8 upiu_flags;
 	int ret = 0;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
@@ -2887,8 +2827,7 @@ static void ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	unsigned int ioprio_class = IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 	u8 upiu_flags;
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags,
-				    lrbp->cmd->sc_data_direction, 0, UTP_CMD_TYPE_SCSI);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, lrbp->cmd->sc_data_direction, 0);
 	if (ioprio_class == IOPRIO_CLASS_RT)
 		upiu_flags |= UPIU_CMD_FLAGS_CP;
 	ufshcd_prepare_utp_scsi_cmd_upiu(lrbp, upiu_flags);
@@ -5565,15 +5504,12 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
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
 
@@ -7229,7 +7165,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, 0);
 
 	/* update the task tag in the request upiu */
 	req_upiu->header.task_tag = tag;
@@ -7381,7 +7317,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 
 	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
-	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs, UTP_CMD_TYPE_DEV_MANAGE);
+	ufshcd_prepare_req_desc_hdr(hba, lrbp, &upiu_flags, DMA_NONE, ehs);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
@@ -8368,83 +8304,6 @@ static void ufs_put_device_desc(struct ufs_hba *hba)
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
@@ -8517,11 +8376,6 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 
 static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 {
-	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
-		ufshcd_tune_pa_tactivate(hba);
-		ufshcd_tune_pa_hibern8time(hba);
-	}
-
 	ufshcd_vops_apply_dev_quirks(hba);
 
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_PA_TACTIVATE)
@@ -10508,7 +10362,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	hba->ufs_version = ufshcd_get_ufs_version(hba);
 
 	/* Get Interrupt bit mask per version */
-	hba->intr_mask = ufshcd_get_intr_mask(hba);
+	hba->intr_mask = INTERRUPT_MASK_ALL_VER_21;
 
 	err = ufshcd_set_dma_mask(hba);
 	if (err) {
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 06859e17b67b..06391f923dba 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -531,8 +531,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
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


