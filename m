Return-Path: <linux-kernel+bounces-145089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF5F8A4F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E081C210FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF874262;
	Mon, 15 Apr 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="owR8QOdr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Zv2qhRq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="owR8QOdr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Zv2qhRq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEF73504
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184955; cv=none; b=FOFkbBeqsEXh33L4rqEFiJk2FYh8YCHdGgOQ2fjPY6KVL91LU+rVt7d+U2APHHNmvio9jGwi3nfaskHUz8iLo9UrUYQXnSDmQDTrzQnbnl0Mp3nDHCme/DzYzseCXyEO/3ZBwmgIVOcg/cyatTsMDJcNz9o/TUMY/l7fff2yCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184955; c=relaxed/simple;
	bh=YCu3qszDNcuF08TqVRorHqjC5eRckipuWxl9dt59wdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrkpSl2fZTjofzoT/DmQ+vgVa9+CwsFv9/llpzeiJ+wWPSMO9KsLOI9htQMM0zLGy0XUlLsdtn98OOMxsuXRBdaJRgv1mh7Rb2KnyqwHuixeBM3Y9/vCW6JSgS7HzFPsJLOVj/5kSvk8QZLzO/UnXTfIMLr3do8z9XfgJWEfElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=owR8QOdr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Zv2qhRq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=owR8QOdr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Zv2qhRq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8065CF89;
	Mon, 15 Apr 2024 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdiU/hfpHxZK5zdo9tcxs2NHnlIFlMrR4vJ1/c1O4Xg=;
	b=owR8QOdrUeedrSF+ZViK6TqHtSL80dBKVahI63UxXb00tWxERKgSqCvJYd6YMnwD+gcLA7
	fc5Uipw/AJcpMO13ian/RjGFX8SXAOo6xTsHSQmTXYAgNlcD9iFTJXVGYIRwzGqY4EAptf
	Vjy7JiPFPUcto3OqD9pIIVg2Z2U9M58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdiU/hfpHxZK5zdo9tcxs2NHnlIFlMrR4vJ1/c1O4Xg=;
	b=7Zv2qhRq1MbbbW863GhA58nJhiR79UxRGLf5/SaIvPyXWlUrV2XlSMWfBil0XtMN1+ecEM
	Y9ZcV+raJUtz5oBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdiU/hfpHxZK5zdo9tcxs2NHnlIFlMrR4vJ1/c1O4Xg=;
	b=owR8QOdrUeedrSF+ZViK6TqHtSL80dBKVahI63UxXb00tWxERKgSqCvJYd6YMnwD+gcLA7
	fc5Uipw/AJcpMO13ian/RjGFX8SXAOo6xTsHSQmTXYAgNlcD9iFTJXVGYIRwzGqY4EAptf
	Vjy7JiPFPUcto3OqD9pIIVg2Z2U9M58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdiU/hfpHxZK5zdo9tcxs2NHnlIFlMrR4vJ1/c1O4Xg=;
	b=7Zv2qhRq1MbbbW863GhA58nJhiR79UxRGLf5/SaIvPyXWlUrV2XlSMWfBil0XtMN1+ecEM
	Y9ZcV+raJUtz5oBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8930B1386E;
	Mon, 15 Apr 2024 12:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +RvPH7EgHWY0AwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 4/5] nvme-fabrics: short-circuit reconnect retries
Date: Mon, 15 Apr 2024 14:42:19 +0200
Message-ID: <20240415124220.5433-5-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415124220.5433-1-dwagner@suse.de>
References: <20240415124220.5433-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

From: Hannes Reinecke <hare@suse.de>

Returning a nvme status from nvme_tcp_setup_ctrl() indicates that the
association was established and we have received a status from the
controller; consequently we should honour the DNR bit. If not any future
reconnect attempts will just return the same error, so we can
short-circuit the reconnect attempts and fail the connection directly.

Another reason not to retry reconnects is if the transport returns an
negative error code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: - extended nvme_should_reconnect]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 19 ++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  2 +-
 drivers/nvme/host/fc.c      |  4 +---
 drivers/nvme/host/rdma.c    | 19 ++++++++++++-------
 drivers/nvme/host/tcp.c     | 22 ++++++++++++++--------
 5 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f7eaf9580b4f..d9a73b1b41c4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -559,8 +559,25 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 }
 EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 
-bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
+/*
+ * Evaluate the status information returned by the transport in order to decided
+ * if a reconnect attempt should be scheduled.
+ *
+ * There are two cases where no reconnect attempt should be attempted:
+ *
+ * 1) The transport reports an negative status. There was an error (e.g. no
+ *    memory) on the host side and thus abort the operation.
+ *
+ * 2) The DNR bit is set and the specification states no further connect
+ *    attempts with the same set of paramenters should be attempted.
+ */
+bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
 {
+	if (status < 0)
+		return false;
+	else if (status > 0 && (status & NVME_SC_DNR))
+		return false;
+
 	if (ctrl->opts->max_reconnects == -1 ||
 	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 37c974c38dcb..602135910ae9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -223,7 +223,7 @@ int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
-bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
+bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a5b29e9ad342..f0b081332749 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3310,12 +3310,10 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
-		if (status > 0 && (status & NVME_SC_DNR))
-			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
-	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
+	if (recon && nvmf_should_reconnect(&ctrl->ctrl, status)) {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE)
 			dev_info(ctrl->ctrl.device,
 				"NVME-FC{%d}: Reconnect attempt in %ld "
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 366f0bb4ebfc..821ab3e0fd3b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -982,7 +982,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl,
+					  int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 
@@ -992,7 +993,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+	if (nvmf_should_reconnect(&ctrl->ctrl, status)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
@@ -1104,10 +1105,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_rdma_ctrl, reconnect_work);
+	int ret;
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
@@ -1120,7 +1123,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -1145,7 +1148,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, 0);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2169,6 +2172,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -2179,14 +2183,15 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..3e0c33323320 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2155,7 +2155,8 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
@@ -2165,13 +2166,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(ctrl)) {
+	if (nvmf_should_reconnect(ctrl, status)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
+		dev_info(ctrl->device, "Removing controller (%d)...\n",
+			 status);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2252,10 +2254,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 			struct nvme_tcp_ctrl, connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
 
 	++ctrl->nr_reconnects;
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
@@ -2268,7 +2272,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2295,7 +2299,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, 0);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2315,6 +2319,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2328,14 +2333,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.44.0


