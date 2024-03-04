Return-Path: <linux-kernel+bounces-90316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40286FD79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF2D1F240F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8AF3A1B5;
	Mon,  4 Mar 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OCuSmq0j"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B453A1B4;
	Mon,  4 Mar 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544259; cv=none; b=D9xP0qZTUpD4OftBEeHAwnQAo9QwXMc2ybPoxVzbJxE28dKc8U1AXv+1PdmCVE2eYMOhzdJ6w/WqD1VU9sKjs2jHIeMZPZUTRDNg+F64fhOUlWgupViadZgiOIhpF5AIawb6o9DGR8fvF1eLo8yrfi67hZ+Q41hOuViHvVyRT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544259; c=relaxed/simple;
	bh=ZNYJmH6JH98eqGuB5N4pR86eqdep53xLc9xBzuVhHUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb98yjOcx+35kE14Ekh/l/DhxayP5WGVruI2tUSm8TrPqJwKimI+tby4LFlAHnClZmN4bSUwZw1n20m+1dJsiXTfjXTPXhPlWqEdvM9PXtTidmCka6uKUUYHGJxebLayzt0t/aYib630CUqhB8+A0IJGfBsdE37mBmzf16We828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OCuSmq0j; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709544257; x=1741080257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNYJmH6JH98eqGuB5N4pR86eqdep53xLc9xBzuVhHUg=;
  b=OCuSmq0jYEkwFTH40z+9o0ATpEa5M2g+M2tF/1AxInTrlnoFzrx50GNA
   CnDMAccG3gIPYAcwK/U723IxaVvdbltJB+FPtdTGxOL7UA47mE0snVgem
   McQoV9gxFEH5EmUdBzCQ50bED91qM1o+++84qWuN8rcLoA6GYEBQaK58q
   eK32t297Sy3I1UVCnjqgS82ZrinmmvudjHWK6BNFghQ8do3Q3lYUlA4Mf
   EyyEv3zlyGQeLnLn+BtmOBGEyvT8oImKUXh12jlP6hViNpyJxYgU1gTh7
   AxKiV9yaxgy7soCSYMrKg00xxiIbVHkIYeLXeNs4OkN3SctSuU1iPqpQy
   g==;
X-CSE-ConnectionGUID: V6yQldMlQCqlwEt5v/y4ZQ==
X-CSE-MsgGUID: QWkrR/5IRbO7WHd5JPRA8w==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11326514"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 17:24:17 +0800
IronPort-SDR: qY8wHVNb1m4xRgMIvaJOmkjcq4K0DnJUeC6hP2yCCnpCTqWiuNtmEYEm9PnpF6elHjWZ/R1iHu
 l0oVa934JMNw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 00:33:30 -0800
IronPort-SDR: ZmtozU8xo0e5aX8zlT7rq3/aIRmOvhI0hLB7OQZ97i52rOky9cZ6JZ00LINFbOSHA491aAcqDi
 TMLjQHDYuQyw==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2024 01:24:15 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 4/4] scsi: ufs: Re-use compose_devman_upiu
Date: Mon,  4 Mar 2024 11:23:46 +0200
Message-ID: <20240304092346.654-5-avri.altman@wdc.com>
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

Move out some code fragments so it can be used elsewhere.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 40 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a41cd7ed1e38..b6e27c6daf54 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2840,6 +2840,17 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufshcd_lrb *lrbp)
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 }
 
+static void __compose_devman_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
+				  u8 *upiu_flags, int ehs_length)
+{
+	if (hba->ufs_version <= ufshci_version(1, 1))
+		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
+	else
+		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+
+	ufshcd_prepare_req_desc_hdr(lrbp, upiu_flags, DMA_NONE, ehs_length);
+}
+
 /**
  * ufshcd_compose_devman_upiu - UFS Protocol Information Unit(UPIU)
  *			     for Device Management Purposes
@@ -2854,12 +2865,8 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 	u8 upiu_flags;
 	int ret = 0;
 
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	__compose_devman_upiu(hba, lrbp, &upiu_flags, 0);
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
 		ufshcd_prepare_utp_query_req_upiu(hba, lrbp, upiu_flags);
 	else if (hba->dev_cmd.type == DEV_CMD_TYPE_NOP)
@@ -7220,17 +7227,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	u8 upiu_flags;
 
 	__compose_dev_cmd(hba, lrbp, cmd_type, 0, tag);
-
-	if (hba->ufs_version <= ufshci_version(1, 1))
-		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
-	else
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
+	__compose_devman_upiu(hba, lrbp, &upiu_flags, 0);
 
 	/* update the task tag in the request upiu */
 	req_upiu->header.task_tag = tag;
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE, 0);
-
 	/* just copy the upiu request as it is */
 	memcpy(lrbp->ucd_req_ptr, req_upiu, sizeof(*lrbp->ucd_req_ptr));
 	if (desc_buff && desc_op == UPIU_QUERY_OPCODE_WRITE_DESC) {
@@ -7371,24 +7372,13 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u8 upiu_flags;
 	u8 *ehs_data;
 	u16 ehs_len;
+	int ehs = (hba->capabilities & MASK_EHSLUTRD_SUPPORTED) ? 2 : 0;
 
 	/* Protects use of hba->reserved_slot. */
 	ufshcd_dev_man_lock(hba);
 
 	__compose_dev_cmd(hba, lrbp, DEV_CMD_TYPE_RPMB, UFS_UPIU_RPMB_WLUN, tag);
-
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
+	__compose_devman_upiu(hba, lrbp, &upiu_flags, ehs);
 
 	/* update the task tag */
 	req_upiu->header.task_tag = tag;
-- 
2.42.0


