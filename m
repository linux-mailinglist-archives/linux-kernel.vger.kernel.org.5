Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2607D9F46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbjJ0SDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbjJ0SDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:03:34 -0400
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBCF4;
        Fri, 27 Oct 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6775; q=dns/txt; s=iport;
  t=1698429812; x=1699639412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KALeQZwu/E6nMCSKd3+RrezZye5Cwyf7qnDuQppITX0=;
  b=jcxgPpZQBd28GFJUuoiSmzmJmeQnt0VmRJvCYVfYTZP6COv4KsspCbSb
   hwJrmu4x+bSIn3DX1EVAiCONCasD3ywhoEW/ZkB7pGlqMykGI9Kos7xWT
   +/l/YiI1wjOT40Eyr8nwObvxCfggSaE7Gt/cBshomZA73eNJvxu6MY9Eg
   k=;
X-CSE-ConnectionGUID: SvuIdalcSFa5EHZYrrhwsg==
X-CSE-MsgGUID: W5WYm75fSQSUxpkyHg81Nw==
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="173159920"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:03:32 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39RI39Og029226
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Oct 2023 18:03:31 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v2 04/13] scsi: fnic: Rename wq_copy to hw_copy_wq
Date:   Fri, 27 Oct 2023 11:02:53 -0700
Message-Id: <20231027180302.418676-5-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231027180302.418676-1-kartilak@cisco.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename wq_copy to hw_copy_wq to accurately describe
the copy workqueue. This will also help distinguish
this data structure from software data structures
that can be introduced.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |  2 +-
 drivers/scsi/fnic/fnic_isr.c  |  2 +-
 drivers/scsi/fnic/fnic_main.c |  8 ++++----
 drivers/scsi/fnic/fnic_res.c  |  6 +++---
 drivers/scsi/fnic/fnic_scsi.c | 12 ++++++------
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index c6c549c633b1..9fd01a867788 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -301,7 +301,7 @@ struct fnic {
 	/*** FIP related data members  -- end ***/
 
 	/* copy work queue cache line section */
-	____cacheline_aligned struct vnic_wq_copy wq_copy[FNIC_WQ_COPY_MAX];
+	____cacheline_aligned struct vnic_wq_copy hw_copy_wq[FNIC_WQ_COPY_MAX];
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[FNIC_CQ_MAX];
 
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index 8896758fed8c..dff9689023e4 100644
--- a/drivers/scsi/fnic/fnic_isr.c
+++ b/drivers/scsi/fnic/fnic_isr.c
@@ -224,7 +224,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 {
 	unsigned int n = ARRAY_SIZE(fnic->rq);
 	unsigned int m = ARRAY_SIZE(fnic->wq);
-	unsigned int o = ARRAY_SIZE(fnic->wq_copy);
+	unsigned int o = ARRAY_SIZE(fnic->hw_copy_wq);
 
 	/*
 	 * Set interrupt mode (INTx, MSI, MSI-X) depending
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index ea7b1ba27ac7..887e3e168579 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -357,7 +357,7 @@ void fnic_log_q_error(struct fnic *fnic)
 	}
 
 	for (i = 0; i < fnic->wq_copy_count; i++) {
-		error_status = ioread32(&fnic->wq_copy[i].ctrl->error_status);
+		error_status = ioread32(&fnic->hw_copy_wq[i].ctrl->error_status);
 		if (error_status)
 			shost_printk(KERN_ERR, fnic->lport->host,
 				     "CWQ[%d] error_status"
@@ -494,7 +494,7 @@ static int fnic_cleanup(struct fnic *fnic)
 			return err;
 	}
 	for (i = 0; i < fnic->wq_copy_count; i++) {
-		err = vnic_wq_copy_disable(&fnic->wq_copy[i]);
+		err = vnic_wq_copy_disable(&fnic->hw_copy_wq[i]);
 		if (err)
 			return err;
 	}
@@ -510,7 +510,7 @@ static int fnic_cleanup(struct fnic *fnic)
 	for (i = 0; i < fnic->rq_count; i++)
 		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
 	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_clean(&fnic->wq_copy[i],
+		vnic_wq_copy_clean(&fnic->hw_copy_wq[i],
 				   fnic_wq_copy_cleanup_handler);
 
 	for (i = 0; i < fnic->cq_count; i++)
@@ -901,7 +901,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	for (i = 0; i < fnic->raw_wq_count; i++)
 		vnic_wq_enable(&fnic->wq[i]);
 	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_enable(&fnic->wq_copy[i]);
+		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
 
 	fc_fabric_login(lp);
 
diff --git a/drivers/scsi/fnic/fnic_res.c b/drivers/scsi/fnic/fnic_res.c
index a1c9cfcace7f..109316cc4ad9 100644
--- a/drivers/scsi/fnic/fnic_res.c
+++ b/drivers/scsi/fnic/fnic_res.c
@@ -203,7 +203,7 @@ void fnic_free_vnic_resources(struct fnic *fnic)
 		vnic_wq_free(&fnic->wq[i]);
 
 	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_free(&fnic->wq_copy[i]);
+		vnic_wq_copy_free(&fnic->hw_copy_wq[i]);
 
 	for (i = 0; i < fnic->rq_count; i++)
 		vnic_rq_free(&fnic->rq[i]);
@@ -250,7 +250,7 @@ int fnic_alloc_vnic_resources(struct fnic *fnic)
 
 	/* Allocate Copy WQs used for SCSI IOs */
 	for (i = 0; i < fnic->wq_copy_count; i++) {
-		err = vnic_wq_copy_alloc(fnic->vdev, &fnic->wq_copy[i],
+		err = vnic_wq_copy_alloc(fnic->vdev, &fnic->hw_copy_wq[i],
 			(fnic->raw_wq_count + i),
 			fnic->config.wq_copy_desc_count,
 			sizeof(struct fcpio_host_req));
@@ -357,7 +357,7 @@ int fnic_alloc_vnic_resources(struct fnic *fnic)
 	}
 
 	for (i = 0; i < fnic->wq_copy_count; i++) {
-		vnic_wq_copy_init(&fnic->wq_copy[i],
+		vnic_wq_copy_init(&fnic->hw_copy_wq[i],
 				  0 /* cq_index 0 - always */,
 				  error_interrupt_enable,
 				  error_interrupt_offset);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 9761b2c9db48..3498a8d670b1 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -193,7 +193,7 @@ __fnic_set_state_flags(struct fnic *fnic, unsigned long st_flags,
  */
 int fnic_fw_reset_handler(struct fnic *fnic)
 {
-	struct vnic_wq_copy *wq = &fnic->wq_copy[0];
+	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
 	int ret = 0;
 	unsigned long flags;
 
@@ -246,7 +246,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
  */
 int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
 {
-	struct vnic_wq_copy *wq = &fnic->wq_copy[0];
+	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
 	enum fcpio_flogi_reg_format_type format;
 	struct fc_lport *lp = fnic->lport;
 	u8 gw_mac[ETH_ALEN];
@@ -551,7 +551,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	fnic_priv(sc)->flags |= FNIC_IO_INITIALIZED;
 
 	/* create copy wq desc and enqueue it */
-	wq = &fnic->wq_copy[0];
+	wq = &fnic->hw_copy_wq[0];
 	ret = fnic_queue_wq_copy_desc(fnic, wq, io_req, sc, sg_count);
 	if (ret) {
 		/*
@@ -782,7 +782,7 @@ static inline void fnic_fcpio_ack_handler(struct fnic *fnic,
 	u64 *ox_id_tag = (u64 *)(void *)desc;
 
 	/* mark the ack state */
-	wq = &fnic->wq_copy[cq_index - fnic->raw_wq_count - fnic->rq_count];
+	wq = &fnic->hw_copy_wq[cq_index - fnic->raw_wq_count - fnic->rq_count];
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
 
 	fnic->fnic_stats.misc_stats.last_ack_time = jiffies;
@@ -1486,7 +1486,7 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 					  u32 task_req, u8 *fc_lun,
 					  struct fnic_io_req *io_req)
 {
-	struct vnic_wq_copy *wq = &fnic->wq_copy[0];
+	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
 	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned long flags;
@@ -1932,7 +1932,7 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 				       struct scsi_cmnd *sc,
 				       struct fnic_io_req *io_req)
 {
-	struct vnic_wq_copy *wq = &fnic->wq_copy[0];
+	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
 	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	struct scsi_lun fc_lun;
-- 
2.31.1

