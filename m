Return-Path: <linux-kernel+bounces-92988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C3872911
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55519B2BBCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0912D1F7;
	Tue,  5 Mar 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nBRothHD"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13F128817;
	Tue,  5 Mar 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672494; cv=none; b=P/Yp33yl2q4VT4zo7tDSYJeciurrMmkvprtWuzRFM2sg2hd6eqJRiukthL3ad6/cIx+HyIMzaAY1Kdz39K6gVYcyP+WEsoR4Hg6nTXVS+uLA9sLmwBuv48xzoxzM/FQABrytOmLxq+TuS2hJixoTwx82N3XTVS+GjSS99BLVsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672494; c=relaxed/simple;
	bh=/P84ODUHYbGsYYgXUeXdf6QOlpEWyHv+gD90llRzItY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0v1IJ7Plli/3cIXA5U7MjZYKpccIwCwpp5Ha7hiqBLdenhKrL9a8Ylf3erdMuU8uMVYjCw8euTVTJiI5PAthXzhSk9fO+k3Eyvksbd8Z42hEVpNKxclThH4Ljkh24uCWvXbhKbxQVq0yCnqRwC0YzcOSWAN467zqWcp2kDFJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nBRothHD; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709672492; x=1741208492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/P84ODUHYbGsYYgXUeXdf6QOlpEWyHv+gD90llRzItY=;
  b=nBRothHD3ZrnaBDZgSapBdSvlU3N45bpjIlK4nT+CMTGqWO2DDd6Nelh
   gnKmtwzLEwMIoQfEhbghJMhp9xEmXsaITYK+i3Urq1lpAyCiHc2N5wYfw
   82oqEe0lZxN9dab5Vmh1aLcqX/GFSypslOF03KmnIfL4hyRSICj9yiknv
   6CPtF/LKuQnki82+tWgPsY8LSBvOt/KTvxD8hlxkJz0HinT+ubvfrtlti
   pO/nE0GrO92wxwEBFJ+YmrojinXsrN1VjV5HMHkf0f1ZytbMevWT4hLYB
   h20ukYmokqHUKhP4O8VWuRPc6ZsW2tFzlbDD4Hd/jAW6vjd352FnzEJOQ
   A==;
X-CSE-ConnectionGUID: OTGbBJByQX6LfY7+1NEmkQ==
X-CSE-MsgGUID: NdPADZwQQ1SOro07xyav2Q==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10423325"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 05:01:30 +0800
IronPort-SDR: dGlA6gGgWuCI7l69K8d1mtYIufSHy8dIbSPK5DOv8P7RntsEd2vvP4EfjiFX5OZllWlWS/bBFb
 Xiru63z7GcHQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 12:10:40 -0800
IronPort-SDR: gNX+rEGkrn/kOQ89Qga37f+D+SkgseS5wSxKjBs90yqq8MhiyrIhFoEq3OaFOM5h9WwmGiXaDP
 qGjEOVzqaK3Q==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 13:01:28 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 3/4] scsi: ufs: Re-use compose_dev_cmd
Date: Tue,  5 Mar 2024 23:00:48 +0200
Message-ID: <20240305210051.10847-4-avri.altman@wdc.com>
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

Move out some of the dev_cmd initializations so it can be used
elsewhere.

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


