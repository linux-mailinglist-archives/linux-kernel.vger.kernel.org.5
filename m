Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD57D9F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbjJ0SDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbjJ0SDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:03:34 -0400
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079210A;
        Fri, 27 Oct 2023 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4997; q=dns/txt; s=iport;
  t=1698429811; x=1699639411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2D8EExdDVIfSV/dUPsyrfX2rTUTRqFnK6MF55T7m9M0=;
  b=DPCfEcLnNLN7oAm1AiFQ/s8y3yK94K5TPeJCJiIc6nMjiwte2f9jEUfq
   HyR17VkkEqTUHGxKG04RTYy6I47jDuTF2e2NVefsQvvQdWHIUIznCnrzF
   jw417UJPxXHzgP1X54eg4ci9OaoMOg4th5vugQq2gkZmXBu293zpLMNwO
   s=;
X-CSE-ConnectionGUID: WwlYRarCQWavrRowIrT1gQ==
X-CSE-MsgGUID: e+3bR+okT2aRuFURn0necw==
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="180792371"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:03:30 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39RI39Of029226
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Oct 2023 18:03:29 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Date:   Fri, 27 Oct 2023 11:02:52 -0700
Message-Id: <20231027180302.418676-4-kartilak@cisco.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add link related log messages in fnic_fcs.c,
Improve log message in fnic_fcs.c,
Add log message in vnic_dev.c.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_fcs.c | 36 ++++++++++++++++++++++++------------
 drivers/scsi/fnic/vnic_dev.c |  4 ++++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 55632c67a8f2..203ffec625a4 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -64,8 +64,8 @@ void fnic_handle_link(struct work_struct *work)
 			new_port_speed);
 	if (old_port_speed != new_port_speed)
 		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
-				"Current vnic speed set to :  %llu\n",
-				new_port_speed);
+				"fnic<%d>: %s: %d: Current vnic speed set to: %llu\n",
+				fnic->fnic_num, __func__, __LINE__, new_port_speed);
 
 	switch (vnic_dev_port_speed(fnic->vdev)) {
 	case DCEM_PORTSPEED_10G:
@@ -102,6 +102,9 @@ void fnic_handle_link(struct work_struct *work)
 			fnic_fc_trace_set_data(fnic->lport->host->host_no,
 				FNIC_FC_LE, "Link Status: DOWN->DOWN",
 				strlen("Link Status: DOWN->DOWN"));
+			FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
+					"fnic<%d>: %s: %d: down->down\n",
+					fnic->fnic_num, __func__, __LINE__);
 		} else {
 			if (old_link_down_cnt != fnic->link_down_cnt) {
 				/* UP -> DOWN -> UP */
@@ -128,8 +131,9 @@ void fnic_handle_link(struct work_struct *work)
 					fnic_fcoe_send_vlan_req(fnic);
 					return;
 				}
-				FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
-					     "link up\n");
+				FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
+						"fnic<%d>: %s: %d: up->down->up: Link up\n",
+						fnic->fnic_num, __func__, __LINE__);
 				fcoe_ctlr_link_up(&fnic->ctlr);
 			} else {
 				/* UP -> UP */
@@ -138,6 +142,9 @@ void fnic_handle_link(struct work_struct *work)
 					fnic->lport->host->host_no, FNIC_FC_LE,
 					"Link Status: UP_UP",
 					strlen("Link Status: UP_UP"));
+				FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
+						"fnic<%d>: %s: %d: up->up\n",
+						fnic->fnic_num, __func__, __LINE__);
 			}
 		}
 	} else if (fnic->link_status) {
@@ -153,7 +160,9 @@ void fnic_handle_link(struct work_struct *work)
 			return;
 		}
 
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "link up\n");
+		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
+				"fnic<%d>: %s: %d: down->up: Link up\n",
+				fnic->fnic_num, __func__, __LINE__);
 		fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_LE,
 				       "Link Status: DOWN_UP", strlen("Link Status: DOWN_UP"));
 		fcoe_ctlr_link_up(&fnic->ctlr);
@@ -161,7 +170,9 @@ void fnic_handle_link(struct work_struct *work)
 		/* UP -> DOWN */
 		fnic->lport->host_stats.link_failure_count++;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "link down\n");
+		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
+				"fnic<%d>: %s: %d: up->down: Link down\n",
+				fnic->fnic_num, __func__, __LINE__);
 		fnic_fc_trace_set_data(
 			fnic->lport->host->host_no, FNIC_FC_LE,
 			"Link Status: UP_DOWN",
@@ -763,8 +774,9 @@ void fnic_set_port_id(struct fc_lport *lport, u32 port_id, struct fc_frame *fp)
 	u8 *mac;
 	int ret;
 
-	FNIC_FCS_DBG(KERN_DEBUG, lport->host, "set port_id %x fp %p\n",
-		     port_id, fp);
+	FNIC_FCS_DBG(KERN_DEBUG, lport->host,
+			"fnic<%d>: %s: %d: set port_id 0x%x fp 0x%p\n",
+			fnic->fnic_num, __func__, __LINE__, port_id, fp);
 
 	/*
 	 * If we're clearing the FC_ID, change to use the ctl_src_addr.
@@ -790,10 +802,10 @@ void fnic_set_port_id(struct fc_lport *lport, u32 port_id, struct fc_frame *fp)
 	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
 		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
 	else {
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
-			     "Unexpected fnic state %s while"
-			     " processing flogi resp\n",
-			     fnic_state_to_str(fnic->state));
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host,
+			     "fnic<%d>: %s: %d: Unexpected fnic state: %s processing FLOGI response",
+			     fnic->fnic_num, __func__, __LINE__,
+				 fnic_state_to_str(fnic->state));
 		spin_unlock_irq(&fnic->fnic_lock);
 		return;
 	}
diff --git a/drivers/scsi/fnic/vnic_dev.c b/drivers/scsi/fnic/vnic_dev.c
index 3e5b437c0492..e0b173cc9d5f 100644
--- a/drivers/scsi/fnic/vnic_dev.c
+++ b/drivers/scsi/fnic/vnic_dev.c
@@ -143,6 +143,10 @@ static int vnic_dev_discover_res(struct vnic_dev *vdev,
 		vdev->res[type].vaddr = (char __iomem *)bar->vaddr + bar_offset;
 	}
 
+	pr_info("res_type_wq: %d res_type_rq: %d res_type_cq: %d res_type_intr_ctrl: %d\n",
+		vdev->res[RES_TYPE_WQ].count, vdev->res[RES_TYPE_RQ].count,
+		vdev->res[RES_TYPE_CQ].count, vdev->res[RES_TYPE_INTR_CTRL].count);
+
 	return 0;
 }
 
-- 
2.31.1

