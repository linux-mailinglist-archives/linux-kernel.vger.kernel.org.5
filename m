Return-Path: <linux-kernel+bounces-90315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9A86FD75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A22282781
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946C39AE9;
	Mon,  4 Mar 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E4e8vody"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94638FA9;
	Mon,  4 Mar 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544254; cv=none; b=TFAWsd3gB5LAesdcivlBcLoDnJV6MXlIaM6iI05BU4WlDlD1nVKf+/e7BPzqHQ7BYdCWWCLM3SH3fQZkHr021ucLvJmUelxMM050v0Xe7ykWgfEYuFnRxYSVu9utxhZTyZHOAFA/XRWgykwyWiZjbyM2XXwQsf+ChlajASAk7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544254; c=relaxed/simple;
	bh=rvuKoEP4yvi36KEDnO6evJIdtxIuFtM35QGK4LO7PfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm22VX56ieX+bqTAthm8ApWJP1TWFyhzZjOux6FopMQZFormKIfW5X1YB9gHloNz0VdQLRGl9Z++bdphyOWM+6qAXZ9dwCGy7xCQDUrm9RuWKWYAz2SVToNZv2VHZYNGrEFkBe45QGT85hbz2kNp+BAoMJWzR7OXKWlsCtIWVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E4e8vody; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709544252; x=1741080252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvuKoEP4yvi36KEDnO6evJIdtxIuFtM35QGK4LO7PfQ=;
  b=E4e8vodyzi09EM/c/uK46F7oKL2ELUCd4OSHVKmci8zbfR9z4ooEZiv0
   wbS7+FClZOAH8NznT2kamVU1GxO6v8BYmXp/Qe8xLZVoOmpv2NIWbTHl6
   5qGGXdRRiT6WS8Gyel/TDf4oDuzAXKl2M8Q3estDStJWXueaFJ/6W8SzB
   c0Y5ubYYKwoEhblp8UdgyOgYxC0Z18qcDisZ44fNegI2z5goNsQRLmZxJ
   59c8o62rq4uJ3caM+eWTnzQ29RtYKoyq+pxh/sXFTPDJ+1o/bnetux/D6
   lK4Zz1ZIMO57iGPsuMeUknZq19eweBNDuXMoLSBdl8ahryXmA4JpacyiQ
   w==;
X-CSE-ConnectionGUID: 4htDNPlJQZqA+LoBIyF+hw==
X-CSE-MsgGUID: k7H3i8OwTwCGAaLpsW2/QQ==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11326508"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 17:24:12 +0800
IronPort-SDR: 5Xg3a2ij+09TTgaMaa4rnNSMEBTRSZIw6cC0vi6YpBtCuOV913JKIn2fC+JccB0EZh4ZTs75Wd
 W0uqFHQw/rtg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 00:33:24 -0800
IronPort-SDR: XXMV+Nhmr9kQDrdwmCPLrQyLL+6rB3imfJTvJmNkeVVEv3mEoI2CzNGR7w9veBWnnl7T/NXqF9
 2cM/Db45xk6A==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2024 01:24:10 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/4] scsi: ufs: Re-use compose_dev_cmd
Date: Mon,  4 Mar 2024 11:23:45 +0200
Message-ID: <20240304092346.654-4-avri.altman@wdc.com>
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

Move out some of the dev_cmd initializations so it can be used
elsewhere.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6661054e4872..a41cd7ed1e38 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3061,15 +3061,21 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	return err;
 }
 
-static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
-		struct ufshcd_lrb *lrbp, enum dev_cmd_type cmd_type, int tag)
+static void __compose_dev_cmd(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
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
+	__compose_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
 	return ufshcd_compose_devman_upiu(hba, lrbp);
 }
@@ -7209,17 +7215,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum query_opcode desc_op)
 {
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
 	u8 upiu_flags;
 
-	lrbp = &hba->lrb[tag];
-	lrbp->cmd = NULL;
-	lrbp->task_tag = tag;
-	lrbp->lun = 0;
-	lrbp->intr_cmd = true;
-	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
-	hba->dev_cmd.type = cmd_type;
+	__compose_dev_cmd(hba, lrbp, cmd_type, 0, tag);
 
 	if (hba->ufs_version <= ufshci_version(1, 1))
 		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
@@ -7365,7 +7365,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 			 enum dma_data_direction dir)
 {
 	const u32 tag = hba->reserved_slot;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int err = 0;
 	int result;
 	u8 upiu_flags;
@@ -7375,14 +7375,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
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
+	__compose_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
 
 	/* Advanced RPMB starts from UFS 4.0, so its command type is UTP_CMD_TYPE_UFS_STORAGE */
 	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-- 
2.42.0


