Return-Path: <linux-kernel+bounces-97803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779C876FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F209F281C79
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E71383B5;
	Sat,  9 Mar 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hngeS8t6"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683F38388;
	Sat,  9 Mar 2024 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971884; cv=none; b=cq6qOV6qXOhTOUDeSVrYIiN1kiVIim5/yLUasVDCmHeA8Rlw5hngv/kGy3iBIvv66zoFSs1EHLkTJHsHJYRR/f3Ei0UZVj/eQWGFPTThoSd4r01FD+E3l2UpBQnOOI05am/hadM0XWObitjD8zooQQoCCtk8oKzTNCV7rDvKHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971884; c=relaxed/simple;
	bh=wtfbUwvqoS9/JD8pCIFdNtKbyG58i+fDGo+h8PYm9tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7gONchXFIIyZOQVONfzqidG1pfJ5PQZkxk9NT/D7+noL40qdgSPbz3j5Q+aeyofs2sGMi+hXThkOQXj1LCOHhkSIvpVL2jRrgzSKBap6B+p2w21PLOegmlrfVzNztjzFSRvr2qNF4NrA9INbdU+DYAg9Mvwwli1zYh9vqL+uG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hngeS8t6; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709971882; x=1741507882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wtfbUwvqoS9/JD8pCIFdNtKbyG58i+fDGo+h8PYm9tc=;
  b=hngeS8t6yWKj9sn1pMHMlPszNEoHelOXQvnmLE0y5ldDPsri0/44zcBU
   0y8myE3+fY8pxVI+JVB2pIu2inAWsFbhlcKeM+TqgCHtsyDq38ML8bVKm
   F2PY/bf5cUwbR8QR21dcDruz1XK3ny1crtgdxwS5L6+g96opWMGMlF/ZO
   9kEqfBRfp+haZyBXyXx+t6ClWPvoLHOKLFDpWj8KN4mQK1/whb69o/F/X
   EoyCHF7I4djMWnIXw8dlFVOxHrlWNuDoEIFrNn1m91MZKZUo5xfLJ6N0R
   ZQanmrBQGrHiSIjerklo4IOcQ3BWh9bDBH6jKw/WC59ybFi+zMOv0ToKy
   g==;
X-CSE-ConnectionGUID: yBxqNyO/RimHdLS3l0A6dw==
X-CSE-MsgGUID: F8bKtA7dTNmuI7tYC62Bbw==
X-IronPort-AV: E=Sophos;i="6.07,112,1708358400"; 
   d="scan'208";a="11183742"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 16:11:22 +0800
IronPort-SDR: 1KyJ3Egjx8Nm4ZfGEO1sFODpnsdkhyMiwtC+wOqPK4TEE2+tR767Hh3wlyLn0mcnsQ27h6siwU
 XdFQt70hQgqw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 23:14:48 -0800
IronPort-SDR: MPYQLMJVDGoQ4iRfGIysCZyuMRujhd8YJTLOL5sPV4VxcALy5lpgX5AudHmqMNjLrh3y1joKj7
 PfXR82u/oGRg==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2024 00:11:21 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 3/4] scsi: ufs: Re-use compose_dev_cmd
Date: Sat,  9 Mar 2024 10:11:01 +0200
Message-ID: <20240309081104.5006-4-avri.altman@wdc.com>
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

Move out some of the dev_cmd initializations so it can be used
elsewhere.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3f62ad7b4062..c9c2b7f99758 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3061,15 +3061,21 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	return err;
 }
 
-static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
-		struct ufshcd_lrb *lrbp, enum dev_cmd_type cmd_type, int tag)
+static void ufshcd_setup_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+			     enum dev_cmd_type cmd_type, u8 lun, int tag)
 {
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
-	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
+	lrbp->lun = lun;
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
 	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
 	hba->dev_cmd.type = cmd_type;
+}
+
+static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
+		struct ufshcd_lrb *lrbp, enum dev_cmd_type cmd_type, int tag)
+{
+	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
 	return ufshcd_compose_devman_upiu(hba, lrbp);
 }
@@ -7213,20 +7219,14 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum query_opcode desc_op)
 {
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
 	u8 upiu_flags;
 
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	lrbp = &hba->lrb[tag];
-	lrbp->cmd = NULL;
-	lrbp->task_tag = tag;
-	lrbp->lun = 0;
-	lrbp->intr_cmd = true;
-	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
-	hba->dev_cmd.type = cmd_type;
+	ufshcd_setup_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
 	if (hba->ufs_version <= ufshci_version(1, 1))
 		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
@@ -7372,7 +7372,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 			 enum dma_data_direction dir)
 {
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
 	int result;
 	u8 upiu_flags;
@@ -7382,14 +7382,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	/* Protects use of hba->reserved_slot. */
 	ufshcd_dev_man_lock(hba);
 
-	lrbp = &hba->lrb[tag];
-	lrbp->cmd = NULL;
-	lrbp->task_tag = tag;
-	lrbp->lun = UFS_UPIU_RPMB_WLUN;
-
-	lrbp->intr_cmd = true;
-	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
-	hba->dev_cmd.type = DEV_CMD_TYPE_RPMB;
+	ufshcd_setup_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
 	/* Advanced RPMB starts from UFS 4.0, so its command type is UTP_CMD_TYPE_UFS_STORAGE */
 	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-- 
2.42.0


