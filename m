Return-Path: <linux-kernel+bounces-10532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3081D5BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02D01F21F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B112E62;
	Sat, 23 Dec 2023 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WXXRUbIZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WXXRUbIZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759812E47;
	Sat, 23 Dec 2023 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1703355412;
	bh=/rADMDxldZcxvEJb9SiQ4SNFYDlRD3i/SqPgSM0FTas=;
	h=Message-ID:Subject:From:To:Date:From;
	b=WXXRUbIZLT1ZV31OWX6yHHg3SvDPlCug2WQvNojgK7B6DRnTUGHnRe/c7tmHtJzxB
	 ShrK2uCiyXcZL5FGcoPpdukweHBJFLblJ6BnI5usTlBOyMhMDZ7rA9OospWCo5HMQy
	 e3Jr+XFcryMmVbGpYmG4H36iqgb7OmRO5wDxQVLU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2AE3A1286197;
	Sat, 23 Dec 2023 13:16:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id k9YNN6b6E4tx; Sat, 23 Dec 2023 13:16:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1703355412;
	bh=/rADMDxldZcxvEJb9SiQ4SNFYDlRD3i/SqPgSM0FTas=;
	h=Message-ID:Subject:From:To:Date:From;
	b=WXXRUbIZLT1ZV31OWX6yHHg3SvDPlCug2WQvNojgK7B6DRnTUGHnRe/c7tmHtJzxB
	 ShrK2uCiyXcZL5FGcoPpdukweHBJFLblJ6BnI5usTlBOyMhMDZ7rA9OospWCo5HMQy
	 e3Jr+XFcryMmVbGpYmG4H36iqgb7OmRO5wDxQVLU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 776A112860E8;
	Sat, 23 Dec 2023 13:16:51 -0500 (EST)
Message-ID: <03b579bec43c7bcdeb4eed7ded859c92f4035461.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.7-rc6
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 23 Dec 2023 13:16:49 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Four small fixes, three in drivers with the core one adding a batch
indicator (for drivers which use it) to the error handler.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Can Guo (1):
      scsi: ufs: core: Let the sq_lock protect sq_tail_slot access

ChanWoo Lee (1):
      scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

And the diffstat:

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 9 +++------
 drivers/scsi/scsi_error.c         | 2 ++
 drivers/ufs/core/ufshcd.c         | 3 ++-
 drivers/ufs/host/ufs-qcom.c       | 6 ++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 05ddbb9bb7d8..451a58e0fd96 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -429,7 +429,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -441,11 +440,9 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto err;
 	}
 
-	tmp_skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!tmp_skb)
-		goto err;
-
-	skb = tmp_skb;
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return -1;
 
 	if (unlikely(eth_hdr(skb)->h_proto != htons(ETH_P_FCOE))) {
 		printk(KERN_ERR PFX "bnx2fc_rcv: Wrong FC type frame\n");
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..1223d34c04da 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1152,6 +1152,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 
 	scsi_log_send(scmd);
 	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -2459,6 +2460,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 
 	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
+	scmd->flags |= SCMD_LAST;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bce0d2a9a7f3..16d76325039a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2274,9 +2274,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 	if (is_mcq_enabled(hba)) {
 		int utrd_size = sizeof(struct utp_transfer_req_desc);
 		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
-		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
+		struct utp_transfer_req_desc *dest;
 
 		spin_lock(&hwq->sq_lock);
+		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
 		memcpy(dest, src, utrd_size);
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96cb8b5b4e66..17e24270477d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 			err = ufs_qcom_clk_scale_up_pre_change(hba);
 		else
 			err = ufs_qcom_clk_scale_down_pre_change(hba);
-		if (err)
-			ufshcd_uic_hibern8_exit(hba);
 
+		if (err) {
+			ufshcd_uic_hibern8_exit(hba);
+			return err;
+		}
 	} else {
 		if (scale_up)
 			err = ufs_qcom_clk_scale_up_post_change(hba);


