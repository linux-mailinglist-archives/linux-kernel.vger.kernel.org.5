Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592457FE6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjK3Ce4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3Cew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:34:52 -0500
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2BD71;
        Wed, 29 Nov 2023 18:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=12925; q=dns/txt;
  s=iport; t=1701311697; x=1702521297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZooAIqKY+UYI4n4c/2ok+CRSXLnVa8Z+pM6JHwvyCY=;
  b=EhZEN3SaXTwpxQdEioGEsnD+aaM8mu4ko0CihoFQZDHnK8h50OI7BHeh
   YKzjPJPdNBzFpo/zVft1nAPZHiehx6u1kYPTqyXK+11SGdkI1QtqhbVHD
   36FYVSaJ99BtRogvtMBb5J8oHXHoObOuW17aNfG+VgcdxCozG/Y7Z26Nj
   I=;
X-CSE-ConnectionGUID: L6MQ/NM9QqqRSF3Enywufw==
X-CSE-MsgGUID: oViE1w0kS5+d33e+qu1/sQ==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149218848"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:34:56 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA45007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:34:56 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v4 03/13] scsi: fnic: Add and improve log messages
Date:   Wed, 29 Nov 2023 18:33:52 -0800
Message-Id: <20231130023402.802282-4-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add link related log messages in fnic_fcs.c,
Improve log message in fnic_fcs.c,
Add log message in vnic_dev.c.

Changes between v2 and v3:
    Incorporate review comment from Hannes:
        Modify FNIC_MAIN_DBG to prepend fnic number.
    Modify FNIC_MAIN_DBG definition to prepend function name
    and line number.
    Modify FNIC_FCS_DBG definition to prepend function name
    and line number.
    Replace FNIC_MAIN_DBG with FNIC_FCS_DBG in fnic_fcs.c
    Use fnic_num as an argument to FNIC_MAIN_DBG and FNIC_FCS_DBG.
    Host number is still used as an argument to
    FNIC_MAIN_DBG and FNIC_FCS_DBG since it in turn
    uses shost_printk.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      | 12 ++++---
 drivers/scsi/fnic/fnic_fcs.c  | 63 +++++++++++++++++++----------------
 drivers/scsi/fnic/fnic_main.c |  4 +--
 drivers/scsi/fnic/vnic_dev.c  |  4 +++
 4 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index c6c549c633b1..faac0f93b983 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -144,13 +144,17 @@ do {								\
 		} while (0);					\
 } while (0)
 
-#define FNIC_MAIN_DBG(kern_level, host, fmt, args...)		\
+#define FNIC_MAIN_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_MAIN_LOGGING,			\
-			 shost_printk(kern_level, host, fmt, ##args);)
+			 shost_printk(kern_level, host,			\
+				"fnic<%d>: %s: %d: " fmt, fnic_num,\
+				__func__, __LINE__, ##args);)
 
-#define FNIC_FCS_DBG(kern_level, host, fmt, args...)		\
+#define FNIC_FCS_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_FCS_LOGGING,			\
-			 shost_printk(kern_level, host, fmt, ##args);)
+			 shost_printk(kern_level, host,			\
+				"fnic<%d>: %s: %d: " fmt, fnic_num,\
+				__func__, __LINE__, ##args);)
 
 #define FNIC_SCSI_DBG(kern_level, host, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_SCSI_LOGGING,			\
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 55632c67a8f2..5e312a55cc7d 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -63,8 +63,8 @@ void fnic_handle_link(struct work_struct *work)
 	atomic64_set(&fnic->fnic_stats.misc_stats.current_port_speed,
 			new_port_speed);
 	if (old_port_speed != new_port_speed)
-		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
-				"Current vnic speed set to :  %llu\n",
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"Current vnic speed set to: %llu\n",
 				new_port_speed);
 
 	switch (vnic_dev_port_speed(fnic->vdev)) {
@@ -102,6 +102,8 @@ void fnic_handle_link(struct work_struct *work)
 			fnic_fc_trace_set_data(fnic->lport->host->host_no,
 				FNIC_FC_LE, "Link Status: DOWN->DOWN",
 				strlen("Link Status: DOWN->DOWN"));
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					"down->down\n");
 		} else {
 			if (old_link_down_cnt != fnic->link_down_cnt) {
 				/* UP -> DOWN -> UP */
@@ -113,7 +115,7 @@ void fnic_handle_link(struct work_struct *work)
 					"Link Status:UP_DOWN_UP",
 					strlen("Link_Status:UP_DOWN_UP")
 					);
-				FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+				FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 					     "link down\n");
 				fcoe_ctlr_link_down(&fnic->ctlr);
 				if (fnic->config.flags & VFCF_FIP_CAPABLE) {
@@ -128,8 +130,8 @@ void fnic_handle_link(struct work_struct *work)
 					fnic_fcoe_send_vlan_req(fnic);
 					return;
 				}
-				FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
-					     "link up\n");
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						"up->down->up: Link up\n");
 				fcoe_ctlr_link_up(&fnic->ctlr);
 			} else {
 				/* UP -> UP */
@@ -138,6 +140,8 @@ void fnic_handle_link(struct work_struct *work)
 					fnic->lport->host->host_no, FNIC_FC_LE,
 					"Link Status: UP_UP",
 					strlen("Link Status: UP_UP"));
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						"up->up\n");
 			}
 		}
 	} else if (fnic->link_status) {
@@ -153,7 +157,8 @@ void fnic_handle_link(struct work_struct *work)
 			return;
 		}
 
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "link up\n");
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"down->up: Link up\n");
 		fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_LE,
 				       "Link Status: DOWN_UP", strlen("Link Status: DOWN_UP"));
 		fcoe_ctlr_link_up(&fnic->ctlr);
@@ -161,13 +166,14 @@ void fnic_handle_link(struct work_struct *work)
 		/* UP -> DOWN */
 		fnic->lport->host_stats.link_failure_count++;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "link down\n");
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"up->down: Link down\n");
 		fnic_fc_trace_set_data(
 			fnic->lport->host->host_no, FNIC_FC_LE,
 			"Link Status: UP_DOWN",
 			strlen("Link Status: UP_DOWN"));
 		if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"deleting fip-timer during link-down\n");
 			del_timer_sync(&fnic->fip_timer);
 		}
@@ -270,12 +276,12 @@ void fnic_handle_event(struct work_struct *work)
 			spin_lock_irqsave(&fnic->fnic_lock, flags);
 			break;
 		case FNIC_EVT_START_FCF_DISC:
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				  "Start FCF Discovery\n");
 			fnic_fcoe_start_fcf_disc(fnic);
 			break;
 		default:
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				  "Unknown event 0x%x\n", fevt->event);
 			break;
 		}
@@ -370,7 +376,7 @@ static void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 	fnic->set_vlan(fnic, 0);
 
 	if (printk_ratelimit())
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			  "Sending VLAN request...\n");
 
 	skb = dev_alloc_skb(sizeof(struct fip_vlan));
@@ -423,12 +429,12 @@ static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *skb)
 	u64 sol_time;
 	unsigned long flags;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 		  "Received VLAN response...\n");
 
 	fiph = (struct fip_header *) skb->data;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 		  "Received VLAN response... OP 0x%x SUB_OP 0x%x\n",
 		  ntohs(fiph->fip_op), fiph->fip_subcode);
 
@@ -463,7 +469,7 @@ static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *skb)
 	if (list_empty(&fnic->vlans)) {
 		/* retry from timer */
 		atomic64_inc(&fnic_stats->vlan_stats.resp_withno_vlanID);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			  "No VLAN descriptors in FIP VLAN response\n");
 		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
 		goto out;
@@ -721,7 +727,8 @@ void fnic_update_mac_locked(struct fnic *fnic, u8 *new)
 		new = ctl;
 	if (ether_addr_equal(data, new))
 		return;
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, "update_mac %pM\n", new);
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			"update_mac %pM\n", new);
 	if (!is_zero_ether_addr(data) && !ether_addr_equal(data, ctl))
 		vnic_dev_del_addr(fnic->vdev, data);
 	memcpy(data, new, ETH_ALEN);
@@ -763,8 +770,9 @@ void fnic_set_port_id(struct fc_lport *lport, u32 port_id, struct fc_frame *fp)
 	u8 *mac;
 	int ret;
 
-	FNIC_FCS_DBG(KERN_DEBUG, lport->host, "set port_id %x fp %p\n",
-		     port_id, fp);
+	FNIC_FCS_DBG(KERN_DEBUG, lport->host, fnic->fnic_num,
+			"set port_id 0x%x fp 0x%p\n",
+			port_id, fp);
 
 	/*
 	 * If we're clearing the FC_ID, change to use the ctl_src_addr.
@@ -790,10 +798,9 @@ void fnic_set_port_id(struct fc_lport *lport, u32 port_id, struct fc_frame *fp)
 	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
 		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
 	else {
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
-			     "Unexpected fnic state %s while"
-			     " processing flogi resp\n",
-			     fnic_state_to_str(fnic->state));
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			     "Unexpected fnic state: %s processing FLOGI response",
+				 fnic_state_to_str(fnic->state));
 		spin_unlock_irq(&fnic->fnic_lock);
 		return;
 	}
@@ -870,7 +877,7 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 		skb_trim(skb, bytes_written);
 		if (!fcs_ok) {
 			atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				     "fcs error.  dropping packet.\n");
 			goto drop;
 		}
@@ -886,7 +893,7 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 
 	if (!fcs_ok || packet_error || !fcoe_fc_crc_ok || fcoe_enc_error) {
 		atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			     "fnic rq_cmpl fcoe x%x fcsok x%x"
 			     " pkterr x%x fcoe_fc_crc_ok x%x, fcoe_enc_err"
 			     " x%x\n",
@@ -967,7 +974,7 @@ int fnic_alloc_rq_frame(struct vnic_rq *rq)
 	len = FC_FRAME_HEADROOM + FC_MAX_FRAME + FC_FRAME_TAILROOM;
 	skb = dev_alloc_skb(len);
 	if (!skb) {
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			     "Unable to allocate RQ sk_buff\n");
 		return -ENOMEM;
 	}
@@ -1341,12 +1348,12 @@ void fnic_handle_fip_timer(struct fnic *fnic)
 	}
 
 	vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 		  "fip_timer: vlan %d state %d sol_count %d\n",
 		  vlan->vid, vlan->state, vlan->sol_count);
 	switch (vlan->state) {
 	case FIP_VLAN_USED:
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			  "FIP VLAN is selected for FC transaction\n");
 		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
 		break;
@@ -1365,7 +1372,7 @@ void fnic_handle_fip_timer(struct fnic *fnic)
 			 * no response on this vlan, remove  from the list.
 			 * Try the next vlan
 			 */
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				  "Dequeue this VLAN ID %d from list\n",
 				  vlan->vid);
 			list_del(&vlan->list);
@@ -1375,7 +1382,7 @@ void fnic_handle_fip_timer(struct fnic *fnic)
 				/* we exhausted all vlans, restart vlan disc */
 				spin_unlock_irqrestore(&fnic->vlans_lock,
 							flags);
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					  "fip_timer: vlan list empty, "
 					  "trigger vlan disc\n");
 				fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index f989a5d7a229..e8c567a46994 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -210,7 +210,7 @@ static struct fc_host_statistics *fnic_get_stats(struct Scsi_Host *host)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	if (ret) {
-		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			      "fnic: Get vnic stats failed"
 			      " 0x%x", ret);
 		return stats;
@@ -322,7 +322,7 @@ static void fnic_reset_host_stats(struct Scsi_Host *host)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	if (ret) {
-		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 				"fnic: Reset vnic stats failed"
 				" 0x%x", ret);
 		return;
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

