Return-Path: <linux-kernel+bounces-69387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3F85884F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542361C25497
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA541482F0;
	Fri, 16 Feb 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k9J0Gku/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k9J0Gku/"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E621353E4;
	Fri, 16 Feb 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120926; cv=none; b=EQ/QIBJkqK072q0iZl0BmhV6TsVUNfcXS2C+2/pCAv1pNHpJl8S/wt0bnvo8nkkpTwNsuwVkfNNh5MPZBsYGXJtenZxYUbNioDkZf5yd6AUU3VKdPbr5ywZ5MC7FlHGxq7uAE8R5IBPtrLt400BAsVfRxNRQtSZRDvW6GwepGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120926; c=relaxed/simple;
	bh=qKEMA2lMlq9eajDCPXn4gQO6Gl2TVTqvw6LFlJYFUD0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=RRykGANmai9QiRJqxE3Rh5Es2LET0d+UtFr+lqEfOQcZCs3InClKyJEJYzr3m8pwwOG8AcvquilrEgqgDv0m0wt+akmjhtfayOIcVsiVKIQDmRdM3gveXRFMImebXyrPNO05Z6ithzdbFQAs3yYgCv5TbzQfu3QNO0diUZw5vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k9J0Gku/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k9J0Gku/; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708120923;
	bh=qKEMA2lMlq9eajDCPXn4gQO6Gl2TVTqvw6LFlJYFUD0=;
	h=Message-ID:Subject:From:To:Date:From;
	b=k9J0Gku/Ix3haECfTzzOaGeS3fM3ol3ObEUqg7Aqv274JhAfAZO/s5IBM9b7APSnJ
	 xr8h67wQB6tMTAFtanq2vA3ClKIRuhlHm/Izwcd0mJ8I79/J0L8cO1WgZWM2eukhaP
	 muKXaREiBXPpHi2y4CSqGtvCtihx8h4HkMhxjpuQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 89F891286F61;
	Fri, 16 Feb 2024 17:02:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 95JUY-2E3g31; Fri, 16 Feb 2024 17:02:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708120923;
	bh=qKEMA2lMlq9eajDCPXn4gQO6Gl2TVTqvw6LFlJYFUD0=;
	h=Message-ID:Subject:From:To:Date:From;
	b=k9J0Gku/Ix3haECfTzzOaGeS3fM3ol3ObEUqg7Aqv274JhAfAZO/s5IBM9b7APSnJ
	 xr8h67wQB6tMTAFtanq2vA3ClKIRuhlHm/Izwcd0mJ8I79/J0L8cO1WgZWM2eukhaP
	 muKXaREiBXPpHi2y4CSqGtvCtihx8h4HkMhxjpuQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E4DA21286F5C;
	Fri, 16 Feb 2024 17:02:02 -0500 (EST)
Message-ID: <fd86dd962555df8e53ba997f6b54fff822545667.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.8-rc4
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Fri, 16 Feb 2024 17:02:01 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Three fixes: the two fnic ones are a revert and a refix, which is why
the diffstat is a bit big.  The target one also extracts a function to
add a check for configuration and so looks bigger than it is.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Lee Duncan (2):
      scsi: fnic: Move fnic_fnic_flush_tx() to a work queue
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Mike Christie (1):
      scsi: target: Fix unmap setup during configuration

And the diffstat:

 drivers/scsi/fcoe/fcoe_ctlr.c         | 20 ++++++---------
 drivers/scsi/fnic/fnic.h              |  3 ++-
 drivers/scsi/fnic/fnic_fcs.c          |  5 ++--
 drivers/scsi/fnic/fnic_main.c         |  1 +
 drivers/scsi/fnic/fnic_scsi.c         |  4 +--
 drivers/target/target_core_configfs.c | 48 +++++++++++++++++++++++------------
 6 files changed, 48 insertions(+), 33 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 19eee108db02..5c8d1ba3f8f3 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,17 +319,16 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -700,7 +699,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -734,11 +732,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1707,11 +1705,10 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1722,7 +1719,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1739,9 +1736,8 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1768,7 +1764,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 2074937c05bc..ce73f08ee889 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -305,6 +305,7 @@ struct fnic {
 	unsigned int copy_wq_base;
 	struct work_struct link_work;
 	struct work_struct frame_work;
+	struct work_struct flush_work;
 	struct sk_buff_head frame_queue;
 	struct sk_buff_head tx_queue;
 
@@ -363,7 +364,7 @@ void fnic_handle_event(struct work_struct *work);
 int fnic_rq_cmpl_handler(struct fnic *fnic, int);
 int fnic_alloc_rq_frame(struct vnic_rq *rq);
 void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
-void fnic_flush_tx(struct fnic *);
+void fnic_flush_tx(struct work_struct *work);
 void fnic_eth_send(struct fcoe_ctlr *, struct sk_buff *skb);
 void fnic_set_port_id(struct fc_lport *, u32, struct fc_frame *);
 void fnic_update_mac(struct fc_lport *, u8 *new);
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 5e312a55cc7d..a08293b2ad9f 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -1182,7 +1182,7 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
 
 /**
  * fnic_flush_tx() - send queued frames.
- * @fnic: fnic device
+ * @work: pointer to work element
  *
  * Send frames that were waiting to go out in FC or Ethernet mode.
  * Whenever changing modes we purge queued frames, so these frames should
@@ -1190,8 +1190,9 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
  *
  * Called without fnic_lock held.
  */
-void fnic_flush_tx(struct fnic *fnic)
+void fnic_flush_tx(struct work_struct *work)
 {
+	struct fnic *fnic = container_of(work, struct fnic, flush_work);
 	struct sk_buff *skb;
 	struct fc_frame *fp;
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 5ed1d897311a..29eead383eb9 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -830,6 +830,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		spin_lock_init(&fnic->vlans_lock);
 		INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
 		INIT_WORK(&fnic->event_work, fnic_handle_event);
+		INIT_WORK(&fnic->flush_work, fnic_flush_tx);
 		skb_queue_head_init(&fnic->fip_frame_queue);
 		INIT_LIST_HEAD(&fnic->evlist);
 		INIT_LIST_HEAD(&fnic->vlans);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 8d7fc5284293..fc4cee91b175 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -680,7 +680,7 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	fnic_flush_tx(fnic);
+	queue_work(fnic_event_queue, &fnic->flush_work);
 
  reset_cmpl_handler_end:
 	fnic_clear_state_flags(fnic, FNIC_FLAGS_FWRESET);
@@ -736,7 +736,7 @@ static int fnic_fcpio_flogi_reg_cmpl_handler(struct fnic *fnic,
 		}
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-		fnic_flush_tx(fnic);
+		queue_work(fnic_event_queue, &fnic->flush_work);
 		queue_work(fnic_event_queue, &fnic->frame_work);
 	} else {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index a5f58988130a..c1fbcdd16182 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -759,6 +759,29 @@ static ssize_t emulate_tas_store(struct config_item *item,
 	return count;
 }
 
+static int target_try_configure_unmap(struct se_device *dev,
+				      const char *config_opt)
+{
+	if (!dev->transport->configure_unmap) {
+		pr_err("Generic Block Discard not supported\n");
+		return -ENOSYS;
+	}
+
+	if (!target_dev_configured(dev)) {
+		pr_err("Generic Block Discard setup for %s requires device to be configured\n",
+		       config_opt);
+		return -ENODEV;
+	}
+
+	if (!dev->transport->configure_unmap(dev)) {
+		pr_err("Generic Block Discard setup for %s failed\n",
+		       config_opt);
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
 static ssize_t emulate_tpu_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -776,11 +799,9 @@ static ssize_t emulate_tpu_store(struct config_item *item,
 	 * Discard supported is detected iblock_create_virtdevice().
 	 */
 	if (flag && !da->max_unmap_block_desc_count) {
-		if (!dev->transport->configure_unmap ||
-		    !dev->transport->configure_unmap(dev)) {
-			pr_err("Generic Block Discard not supported\n");
-			return -ENOSYS;
-		}
+		ret = target_try_configure_unmap(dev, "emulate_tpu");
+		if (ret)
+			return ret;
 	}
 
 	da->emulate_tpu = flag;
@@ -806,11 +827,9 @@ static ssize_t emulate_tpws_store(struct config_item *item,
 	 * Discard supported is detected iblock_create_virtdevice().
 	 */
 	if (flag && !da->max_unmap_block_desc_count) {
-		if (!dev->transport->configure_unmap ||
-		    !dev->transport->configure_unmap(dev)) {
-			pr_err("Generic Block Discard not supported\n");
-			return -ENOSYS;
-		}
+		ret = target_try_configure_unmap(dev, "emulate_tpws");
+		if (ret)
+			return ret;
 	}
 
 	da->emulate_tpws = flag;
@@ -1022,12 +1041,9 @@ static ssize_t unmap_zeroes_data_store(struct config_item *item,
 	 * Discard supported is detected iblock_configure_device().
 	 */
 	if (flag && !da->max_unmap_block_desc_count) {
-		if (!dev->transport->configure_unmap ||
-		    !dev->transport->configure_unmap(dev)) {
-			pr_err("dev[%p]: Thin Provisioning LBPRZ will not be set because max_unmap_block_desc_count is zero\n",
-			       da->da_dev);
-			return -ENOSYS;
-		}
+		ret = target_try_configure_unmap(dev, "unmap_zeroes_data");
+		if (ret)
+			return ret;
 	}
 	da->unmap_zeroes_data = flag;
 	pr_debug("dev[%p]: SE Device Thin Provisioning LBPRZ bit: %d\n",


