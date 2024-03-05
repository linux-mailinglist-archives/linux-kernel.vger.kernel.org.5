Return-Path: <linux-kernel+bounces-92986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6787290B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0881F27E45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7012BEA3;
	Tue,  5 Mar 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k9M2HSmd"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE8168DD;
	Tue,  5 Mar 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672478; cv=none; b=gBnFvGWFjo3UO497q3sDYQp3axBSEiuA4lZdYre880QW68bPLYbhm/P3pju3ebQ0qbkMg2+mTQgORWwBN37x5WcrSrEHowxSfsZqb0nXpdKPFv0DQfgmIRVgzhFVoUGONPcVYw2EfjyM61UR+aZc9xb44XHUKHr6LBUcDa6pYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672478; c=relaxed/simple;
	bh=IuBwA/fW3rQm/qse2UqUNp2c3FdtJr9WHEPD47rdum8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlRRW485gNw+qu5ffPRhnyV+OdPyjJMlzmPnLsR1Kf4qjOb9tvQq60GoJH7dPvjZvcxhe7KkHU/2dWjEEV3YzZdb8kQkXUJ9I+BB6ru9JHmU5TJwayQEeAyJjqTkvXcC/JvgsrdfRlHx3oQLWnLEWTASMgc+ocx3e9hAMrTB7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k9M2HSmd; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709672476; x=1741208476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuBwA/fW3rQm/qse2UqUNp2c3FdtJr9WHEPD47rdum8=;
  b=k9M2HSmdcg14GnZaZ/hDo144kAxNGWWzbtScR8ENvc6Mr4L0mLBkPB+D
   32lysLxyrEYETasMS3w1H/0BtQj9lVTxX0OAY0X1Uzg52FnQ1sYB3CNZY
   QNRS8krjk9RR7mUt+Ah0B/LNskOYZIQX2Hzh2sgY7X7ei9NvhqFn4A8gP
   P64+6bAIUr+xdZ7fVzTZmHrDVsJGwU5p71NmnxA3bxtZKW8AsRw7Og1Xc
   nraKsYB3kfP54rPbtyzQ7O9wPsIn/vowWpAa3zvGj0JSHmgcz80E/VKCB
   8jI8Srt6FeDidfEAotgf0w/iergMJ6nIO5jYALcn1SqZfQ8JkgiXjo936
   g==;
X-CSE-ConnectionGUID: fU0R9NE2R9ObftjyCOHkUA==
X-CSE-MsgGUID: IY/e7B1NQSu5sCw2joS1Ig==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10855990"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 05:01:14 +0800
IronPort-SDR: NkOvuFfzqDDuB7azPg6xeA+PNk6waA423TXu/bu55I98uRkS1dRell/djWIsOERIlXG3tXKe8I
 jfrBmSMeimyw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 12:10:25 -0800
IronPort-SDR: pxgEwPUjejmb1LiGvKlc/yTd4SVeOsu91Lpid28Gl0GbhOkIL26+TNa3aQDEHeQIPXJyMYFhLy
 dlNexT41TiFg==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 13:01:13 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/4] scsi: ufs: Re-use device management locking code
Date: Tue,  5 Mar 2024 23:00:46 +0200
Message-ID: <20240305210051.10847-2-avri.altman@wdc.com>
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

Group those 3 calls that repeat for every device management command into
a lock and unlock handlers.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 69 ++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 21429eec1b82..983b7b8e3c7c 100644
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
@@ -3294,8 +3308,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
@@ -3312,7 +3324,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 out:
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -3383,8 +3394,8 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 
 	BUG_ON(!hba);
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3426,8 +3437,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 				MASK_QUERY_UPIU_FLAG_LOC) & 0x1;
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3457,9 +3467,8 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 
@@ -3489,8 +3498,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 	*attr_val = be32_to_cpu(response->upiu_res.value);
 
 out_unlock:
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -3553,9 +3561,8 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba);
+	ufshcd_dev_man_lock(hba);
 
-	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 	hba->dev_cmd.query.descriptor = desc_buf;
@@ -3588,8 +3595,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 
 out_unlock:
 	hba->dev_cmd.query.descriptor = NULL;
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 	return err;
 }
 
@@ -5070,8 +5076,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 	int err = 0;
 	int retries;
 
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
+
 	for (retries = NOP_OUT_RETRIES; retries > 0; retries--) {
 		err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_NOP,
 					  hba->nop_out_timeout);
@@ -5081,8 +5087,8 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 
 		dev_dbg(hba->dev, "%s: error %d retrying\n", __func__, err);
 	}
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+
+	ufshcd_dev_man_unlock(hba);
 
 	if (err)
 		dev_err(hba->dev, "%s: NOP OUT failed %d\n", __func__, err);
@@ -7209,8 +7215,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
-
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
@@ -7275,7 +7279,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -7314,13 +7317,11 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
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
@@ -7380,9 +7381,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u16 ehs_len;
 
 	/* Protects use of hba->reserved_slot. */
-	ufshcd_hold(hba);
-	mutex_lock(&hba->dev_cmd.lock);
-	down_read(&hba->clk_scaling_lock);
+	ufshcd_dev_man_lock(hba);
 
 	lrbp = &hba->lrb[tag];
 	lrbp->cmd = NULL;
@@ -7448,9 +7447,8 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 		}
 	}
 
-	up_read(&hba->clk_scaling_lock);
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
+
 	return err ? : result;
 }
 
@@ -8713,9 +8711,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 	if (dev_info->wspecversion < 0x400)
 		return;
 
-	ufshcd_hold(hba);
-
-	mutex_lock(&hba->dev_cmd.lock);
+	ufshcd_dev_man_lock(hba);
 
 	ufshcd_init_query(hba, &request, &response,
 			  UPIU_QUERY_OPCODE_WRITE_ATTR,
@@ -8733,8 +8729,7 @@ static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
 		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
 			__func__, err);
 
-	mutex_unlock(&hba->dev_cmd.lock);
-	ufshcd_release(hba);
+	ufshcd_dev_man_unlock(hba);
 }
 
 /**
-- 
2.42.0


