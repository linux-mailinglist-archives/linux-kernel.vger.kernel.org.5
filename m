Return-Path: <linux-kernel+bounces-71391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35185A47B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6291F21CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051FD376F1;
	Mon, 19 Feb 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LlZmxtoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kT63vpob";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LlZmxtoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kT63vpob"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A3364A0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348540; cv=none; b=JwK2Nt+5b4ajvjZBK8Y3QhfSmaloYJ019ssq5NafG1OSWeaHyK7a6upeL+nNcUfrSzyvwLlO+0bNmU2l+hDd9sO8pAt9kEBEgFHiFu3pVZ4tDwc04nKbvpuxQlFurTOOIFQz7tgBAV3rRxdT5JDU1C3mB/RLgKYs+HRWhJDyRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348540; c=relaxed/simple;
	bh=0WQxlo/oz4Feqagd2vcBCjJkzYxrAeuDwhOkd6YNd38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlCZ6/xwkKucCtLA4WVsRIon1t79goqXKSXeP4K0+MXtsZB4Qwv86mX25EiSjiyPnAZgxwFa5g8e+6B2s9zErtLJH7x5ue1MiCb0cfnPU4jbg7zehrygaYJJnEcnu0dPlnOTAVPUMv2jjLJ9en31c39gVUAAes0SzceEWTH2z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LlZmxtoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kT63vpob; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LlZmxtoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kT63vpob; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8FD9220F2;
	Mon, 19 Feb 2024 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyEZOfkKjRD1DB2JnX5AXn1kOpeHmL85HOa4YyZnu48=;
	b=LlZmxtoMzjqL5EHi4fmDnUBVsdWjr3rI+IkF0RO9Uh8ybQBo2go127z3vg5Kqix8nxBtGI
	86C7xAcXJ6vmwGk+uWjISW34K1ZrkdVUkgyLK4Gev0sDXJw3Pv4Dz/VhuQfBS1GThF8AyL
	1E6pn9JPG5utX9/UQ6CgL1A1DMydVgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyEZOfkKjRD1DB2JnX5AXn1kOpeHmL85HOa4YyZnu48=;
	b=kT63vpobCJ5Jz7n5Jlt3gsOtyUleWdNADyqR2QKoEB+Ke229R+tXX4Z+yC4QiEUPmuKH6S
	eKZFP86jWQCbs6AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyEZOfkKjRD1DB2JnX5AXn1kOpeHmL85HOa4YyZnu48=;
	b=LlZmxtoMzjqL5EHi4fmDnUBVsdWjr3rI+IkF0RO9Uh8ybQBo2go127z3vg5Kqix8nxBtGI
	86C7xAcXJ6vmwGk+uWjISW34K1ZrkdVUkgyLK4Gev0sDXJw3Pv4Dz/VhuQfBS1GThF8AyL
	1E6pn9JPG5utX9/UQ6CgL1A1DMydVgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyEZOfkKjRD1DB2JnX5AXn1kOpeHmL85HOa4YyZnu48=;
	b=kT63vpobCJ5Jz7n5Jlt3gsOtyUleWdNADyqR2QKoEB+Ke229R+tXX4Z+yC4QiEUPmuKH6S
	eKZFP86jWQCbs6AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F5F139C6;
	Mon, 19 Feb 2024 13:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OfdmI3hU02UQAwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:36 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 5/6] nvme-fc: reorder ctrl ref counting and cleanup code path
Date: Mon, 19 Feb 2024 14:15:30 +0100
Message-ID: <20240219131531.15134-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240219131531.15134-1-dwagner@suse.de>
References: <20240219131531.15134-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LlZmxtoM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kT63vpob
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: A8FD9220F2
X-Spam-Flag: NO

The life time of the controller is managed by the upper layers.

Thus just ref counting the controller when creating it and giving the
ref back on the cleanup path. This is how the other transport are
managed as well.

In fact we don't really need the ref count for nvme_fc_ctrl at this
point. Though, the FC transport is offloading the connect attempt to a
workqueue and in the next patch we introduce a sync option for which the
ref counter is necessary. So let's keep it around.

We have also to reorder the cleanup code in nvme_fc_delete_ctrl and
nvme_fc_free_ctrl so that we do not expose resources too long and run
into use after free situations which are currently possible.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 101 +++++++++++++----------------------------
 1 file changed, 32 insertions(+), 69 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ddbc5b21af5b..7627d10a5812 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -229,6 +229,9 @@ static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
 
+static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
+static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
+
 /* *********************** FC-NVME Port Management ************************ */
 
 static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
@@ -800,7 +803,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Couldn't schedule reset.\n",
 				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
+			nvme_fc_ctrl_put(ctrl);
 		}
 		break;
 
@@ -868,7 +871,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
+			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
 	}
@@ -1022,9 +1025,6 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 /* *********************** FC-NVME LS Handling **************************** */
 
-static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
-static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
-
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
 static void
@@ -1511,8 +1511,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 	spin_lock_irqsave(&rport->lock, flags);
 
 	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
-		if (!nvme_fc_ctrl_get(ctrl))
-			continue;
 		spin_lock(&ctrl->lock);
 		if (association_id == ctrl->association_id) {
 			oldls = ctrl->rcv_disconn;
@@ -1520,10 +1518,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 			ret = ctrl;
 		}
 		spin_unlock(&ctrl->lock);
-		if (ret)
-			/* leave the ctrl get reference */
-			break;
-		nvme_fc_ctrl_put(ctrl);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
@@ -1602,9 +1596,6 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	/* fail the association */
 	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
 
-	/* release the reference taken by nvme_fc_match_disconn_ls() */
-	nvme_fc_ctrl_put(ctrl);
-
 	return false;
 }
 
@@ -2071,7 +2062,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
-		nvme_fc_ctrl_put(ctrl);
 		goto check_error;
 	}
 
@@ -2383,37 +2373,18 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_ctrl_free(struct kref *ref)
+nvme_fc_ctrl_delete(struct kref *ref)
 {
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
-	unsigned long flags;
-
-	if (ctrl->ctrl.tagset)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-
-	/* remove from rport list */
-	spin_lock_irqsave(&ctrl->rport->lock, flags);
-	list_del(&ctrl->ctrl_list);
-	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
-
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 
-	kfree(ctrl->queues);
-
-	put_device(ctrl->dev);
-	nvme_fc_rport_put(ctrl->rport);
-
-	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	nvmf_ctrl_options_put(ctrl->ctrl.opts);
-	kfree(ctrl);
+	nvme_delete_ctrl(&ctrl->ctrl);
 }
 
 static void
 nvme_fc_ctrl_put(struct nvme_fc_ctrl *ctrl)
 {
-	kref_put(&ctrl->ref, nvme_fc_ctrl_free);
+	kref_put(&ctrl->ref, nvme_fc_ctrl_delete);
 }
 
 static int
@@ -2431,9 +2402,20 @@ nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	WARN_ON(nctrl != &ctrl->ctrl);
 
-	nvme_fc_ctrl_put(ctrl);
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
+
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
+
+	kfree(ctrl->queues);
+	put_device(ctrl->dev);
+	nvme_fc_rport_put(ctrl->rport);
+
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	nvmf_ctrl_options_put(ctrl->ctrl.opts);
+	kfree(ctrl);
 }
 
 /*
@@ -2682,9 +2664,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 		return BLK_STS_RESOURCE;
 
-	if (!nvme_fc_ctrl_get(ctrl))
-		return BLK_STS_IOERR;
-
 	/* format the FC-NVME CMD IU and fcp_req */
 	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
 	cmdiu->data_len = cpu_to_be32(data_len);
@@ -2729,7 +2708,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		ret = nvme_fc_map_data(ctrl, op->rq, op);
 		if (ret < 0) {
 			nvme_cleanup_cmd(op->rq);
-			nvme_fc_ctrl_put(ctrl);
 			if (ret == -ENOMEM || ret == -EAGAIN)
 				return BLK_STS_RESOURCE;
 			return BLK_STS_IOERR;
@@ -2770,8 +2748,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 			nvme_cleanup_cmd(op->rq);
 		}
 
-		nvme_fc_ctrl_put(ctrl);
-
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
 				ret != -EBUSY)
 			return BLK_STS_IOERR;
@@ -2855,7 +2831,6 @@ nvme_fc_complete_rq(struct request *rq)
 
 	nvme_fc_unmap_data(ctrl, rq, op);
 	nvme_complete_rq(rq);
-	nvme_fc_ctrl_put(ctrl);
 }
 
 static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
@@ -3284,9 +3259,16 @@ static void
 nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
+	unsigned long flags;
 
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+
+	/* remove from rport list */
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	list_del(&ctrl->ctrl_list);
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -3344,7 +3326,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
-		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
+		nvme_fc_ctrl_put(ctrl);
 	}
 }
 
@@ -3582,25 +3564,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return &ctrl->ctrl;
 
 fail_ctrl:
-	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-	cancel_work_sync(&ctrl->ioerr_work);
-	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
-
-	/* initiate nvme ctrl ref counting teardown */
-	nvme_uninit_ctrl(&ctrl->ctrl);
-
-	/* Remove core ctrl ref. */
-	nvme_put_ctrl(&ctrl->ctrl);
-
-	/* as we're past the point where we transition to the ref
-	 * counting teardown path, if we return a bad pointer here,
-	 * the calling routine, thinking it's prior to the
-	 * transition, will do an rport put. Since the teardown
-	 * path also does a rport put, we do an extra get here to
-	 * so proper order/teardown happens.
-	 */
-	nvme_fc_rport_get(rport);
+	nvme_fc_ctrl_put(ctrl);
 
 	return ERR_PTR(-EIO);
 
@@ -3614,6 +3578,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
+	nvme_fc_rport_put(rport);
 	/* exit via here doesn't follow ctlr ref points */
 	return ERR_PTR(ret);
 }
@@ -3724,8 +3689,6 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 			spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 			ctrl = nvme_fc_init_ctrl(dev, opts, lport, rport);
-			if (IS_ERR(ctrl))
-				nvme_fc_rport_put(rport);
 			return ctrl;
 		}
 	}
@@ -3950,7 +3913,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
 }
-- 
2.43.1


