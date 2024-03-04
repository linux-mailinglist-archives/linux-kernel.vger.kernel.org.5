Return-Path: <linux-kernel+bounces-90312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1686FD69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E48F1F26244
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA49364C5;
	Mon,  4 Mar 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lk8ZZ7vO"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B5224E6;
	Mon,  4 Mar 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544245; cv=none; b=GNsTnnI5OXRHW768EF7rD1aleO3JDRzamEQl51DJBMM9CY5BvIrMJDc1StpprT4M7+CRLM142djkKBZozhVWppIZhOhsj/pkKa4/Zz8wlco2D6ZI03gj0SuqcwrK5QN0dsk16n0Xlo2ptgufjfPSi3XSNhzfxGwroXSAaJbhfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544245; c=relaxed/simple;
	bh=KxSA6CY4fAe1QPEUfy59B02FcUbgtm0MWJDpXFmXmQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHpwO0VZQO2U6BLE1P5B5zPqovyg5EACz8rDcersh9ZHCEMpj7Njav9lG1gb7vTTxaK/Ju0hCgD8oZfWQG7+b0JOgHky/O/B6WScC4M1MKLD1o/z27Nz759kfjcBHZHIFMxdedOTNDnqhNNz+zoWYgE+AI+7+XHv2o6u6MF4VfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lk8ZZ7vO; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709544243; x=1741080243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxSA6CY4fAe1QPEUfy59B02FcUbgtm0MWJDpXFmXmQ4=;
  b=Lk8ZZ7vOeJAKeJjos5D+v2eLas5ZMLFi5gZBulOvxcYdIgjKiLOLs+tt
   GnAyKdCFoNAv2T3eXXoBkS4TfKeMUK/A14G8ZKFNCfFf9TbAw+/veQX0u
   H4QQ+yZUykPFG7Xgx4mvyLt9/ycJ4eWHp8a87eqltFtfNCtf9DadvzfzL
   KdU2Ra41HhoMhR+gscdVXtsSnrTKBWUVPalUaey9yVwh22how8vj+qD2E
   nZRW3i/mBwnwWyziTqzZKSs9joA5iiWq3DWuaIZSc7dpZsDwBC6K/RLwZ
   QnMuEfKJpZyNjohBxdo2a/UqdFkqbGtn2flLuLctM4Zo5omVGJw1j4TB7
   w==;
X-CSE-ConnectionGUID: nf9Aw35fTSy1Ik8jqPmviA==
X-CSE-MsgGUID: miUSt343RA2tuOovQYifCQ==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11326496"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 17:24:02 +0800
IronPort-SDR: fXBrP+xcueaKucUNwlfE86aKYf1g2CiZQh1THpK0YZ8DqFXFXDNP1j8j8m4ewI5eRxjjrdaa8f
 8eLOha0fLhwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 00:33:15 -0800
IronPort-SDR: yYw8TOOEC6u6sDlKfOZjDUPiJuPoFRtXjMdfM2Z5x9+FOxxIfwdfH7gXP4yA7iM2pk1Y5FIzzv
 PWJDdnGVvbzg==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2024 01:24:00 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/4] scsi: ufs: Re-use device management locking code
Date: Mon,  4 Mar 2024 11:23:43 +0200
Message-ID: <20240304092346.654-2-avri.altman@wdc.com>
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

Group those 3 calls that repeat for every device management command into
a lock and unlock handlers.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 75 +++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 21429eec1b82..7456f046e7de 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3272,6 +3272,20 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 	return err;
 }
 
+static void ufshcd_dev_man_lock(struct ufs_hba *hba)
+{
+	ufshcd_hold(hba);
+	mutex_lock(&hba->dev_cmd.lock);
+	down_read(&hba->clk_scaling_lock);
+}
+
+static void ufshcd_dev_man_unlock(struct ufs_hba *hba)
+{
+	up_read(&hba->clk_scaling_lock);
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  * @hba: UFS hba
@@ -3291,11 +3305,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	struct ufshcd_lrb *lrbp;
 	int err;
 
-	/* Protects use of hba->reserved_slot. */
-	lockdep_assert_held(&hba->dev_cmd.lock);
-
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
@@ -3312,7 +3321,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 out:
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -3383,8 +3391,8 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 
 	BUG_ON(!hba);
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3426,8 +3434,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 				MASK_QUERY_UPIU_FLAG_LOC) & 0x1;
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3457,9 +3464,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3489,8 +3495,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 	*attr_val = be32_to_cpu(response->upiu_res.value);
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3553,9 +3558,8 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 	hba->dev_cmd.query.descriptor = desc_buf;
@@ -3588,8 +3592,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 
 out_unlock:
 	hba->dev_cmd.query.descriptor = NULL;
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -5070,8 +5073,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 	int err = 0;
 	int retries;
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	for (retries = NOP_OUT_RETRIES; retries > 0; retries--) {
 		err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_NOP,
 					  hba->nop_out_timeout);
@@ -5081,8 +5084,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 
 		dev_dbg(hba->dev, "%s: error %d retrying\n", __func__, err);
 	}
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+
+	ufshcd_dev_man_unlock(hba);
 
 	if (err)
 		dev_err(hba->dev, "%s: NOP OUT failed %d\n", __func__, err);
@@ -7206,11 +7209,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	int err = 0;
 	u8 upiu_flags;
 
-	/* Protects use of hba->reserved_slot. */
-	lockdep_assert_held(&hba->dev_cmd.lock);
-
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
@@ -7275,7 +7273,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -7314,13 +7311,11 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 		cmd_type = DEV_CMD_TYPE_NOP;
 		fallthrough;
 	case UPIU_TRANSACTION_QUERY_REQ:
-		ufshcd_hold(hba);
-		mutex_lock(&hba->dev_cmd.lock);
+		ufshcd_dev_man_lock(hba);
 		err = ufshcd_issue_devman_upiu_cmd(hba, req_upiu, rsp_upiu,
 						   desc_buff, buff_len,
 						   cmd_type, desc_op);
-		mutex_unlock(&hba->dev_cmd.lock);
-		ufshcd_release(hba);
+		ufshcd_dev_man_unlock(hba);
 
 		break;
 	case UPIU_TRANSACTION_TASK_REQ:
@@ -7380,9 +7375,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u16 ehs_len;
 
 	/* Protects use of hba->reserved_slot. */
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
-	down_read(&hba->clk_scaling_lock);
+	ufshcd_dev_man_lock(hba);
 
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
@@ -7448,9 +7441,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 		}
 	}
 
-	up_read(&hba->clk_scaling_lock);
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
+
 	return err ? : result;
 }
 
@@ -8713,9 +8705,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 	if (dev_info->wspecversion < 0x400)
 		return;
 
-	ufshcd_hold(hba);
-
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
 
 	ufshcd_init_query(hba, &request, &response,
 			  UPIU_QUERY_OPCODE_WRITE_ATTR,
@@ -8733,8 +8723,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
 			__func__, err);
 
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 }
 
 /**
-- 
2.42.0


