Return-Path: <linux-kernel+bounces-74783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBF85D9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402831C232A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C57BAED;
	Wed, 21 Feb 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CBuGanU/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+qnpyIl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CBuGanU/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+qnpyIl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5578B50
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521858; cv=none; b=R9BgPIPOgBsIHSy+YRJ5pFmAYrm4tWQNy/jtH+eJfL/DynH3SAY8/m1WijxoM/k5UBKx4IUi/+zpE5r0DuJC/rFTPavWZFq7LinS138rlMweHDLjrWNJDukZtLvqY+ihL8/p5/gbupe+CFqufm+rLCMo3FIPFAjtL8sNBfrR5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521858; c=relaxed/simple;
	bh=C1c/2CS1WlLvSUIhTYTQ1xb3V1yb//R/rB9FVzU62RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3X1ftC85TDU8DFnAfAGYfAfDaSQoC8XYNd0WL+hmgrbT9p64RHiiRniYcN6uWcKEnYY1YkeERPJ4qMvgQrfXCQlco8SZlZpr0PoxwbbpPkrN0LrmoqI0IGkdydcJtA4LuWtFLkEtgpBTVN/RNcGE+UvW+WHtcXrWZoFxbJck4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CBuGanU/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+qnpyIl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CBuGanU/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+qnpyIl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E3A71FB5F;
	Wed, 21 Feb 2024 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1MQ3FKcHieL4ZS16eDYvXy0N2P3NCVJ7hpHs3kzTpM=;
	b=CBuGanU/7NU7bSqgiou6LMFPQWA1cB3u4UDA0YrkKuTsvpOIpaUqmJAyb4LnqLurNfwXA1
	RgjB8gN+Gsfap0rTPoHvjkqd333HLf1iW87Sy+jdMMhcdQcJJ8Hy5w740uLYwcG09DzdW2
	qw6l0pxJTLLy3dnWza0dJe5x8JVB8w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1MQ3FKcHieL4ZS16eDYvXy0N2P3NCVJ7hpHs3kzTpM=;
	b=j+qnpyIlJw6ht1JH00qKnDBr/fmiTGsgg2LBcPeXrjNy9+sPJhshNmGVhoAUWqX3O/q8JO
	7wwhti4pdU36/cBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1MQ3FKcHieL4ZS16eDYvXy0N2P3NCVJ7hpHs3kzTpM=;
	b=CBuGanU/7NU7bSqgiou6LMFPQWA1cB3u4UDA0YrkKuTsvpOIpaUqmJAyb4LnqLurNfwXA1
	RgjB8gN+Gsfap0rTPoHvjkqd333HLf1iW87Sy+jdMMhcdQcJJ8Hy5w740uLYwcG09DzdW2
	qw6l0pxJTLLy3dnWza0dJe5x8JVB8w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1MQ3FKcHieL4ZS16eDYvXy0N2P3NCVJ7hpHs3kzTpM=;
	b=j+qnpyIlJw6ht1JH00qKnDBr/fmiTGsgg2LBcPeXrjNy9+sPJhshNmGVhoAUWqX3O/q8JO
	7wwhti4pdU36/cBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 479A813A6D;
	Wed, 21 Feb 2024 13:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nbcIEH751WUaPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for nvmf_ctrl_options
Date: Wed, 21 Feb 2024 14:24:02 +0100
Message-ID: <20240221132404.6311-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
References: <20240221132404.6311-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CBuGanU/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j+qnpyIl
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 5E3A71FB5F
X-Spam-Flag: NO

The FC transport is offloading the connect attempt to a workqueue. When
the attempt fails the transport is starting to cleanup resources. It is
possible for user space to trigger a crash because nvmf_ctrl_options are
exposed to sysfs.

This crash wasn't observed with blktests nvme/041 until now because the
retry loop was usually trying for several times (e.g. with defaults
600s) and the test would trigger the cleanup itself. Though we the
recent change not retrying to use invalid credentials the crash can be
easily triggered.

The simplest way to control the life time of nvmf_ctrl_options is by
using ref counting.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++---
 drivers/nvme/host/fabrics.h |  6 +++++-
 drivers/nvme/host/fc.c      | 14 +++++++++-----
 drivers/nvme/host/rdma.c    | 18 +++++++++++++-----
 drivers/nvme/host/tcp.c     | 21 ++++++++++++++-------
 drivers/nvme/target/loop.c  | 19 +++++++++++++------
 6 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..888285fe2289 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1222,8 +1222,11 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 	return 0;
 }
 
-void nvmf_free_options(struct nvmf_ctrl_options *opts)
+static void nvmf_free_options(struct kref *ref)
 {
+	struct nvmf_ctrl_options *opts =
+		container_of(ref, struct nvmf_ctrl_options, ref);
+
 	nvmf_host_put(opts->host);
 	key_put(opts->keyring);
 	key_put(opts->tls_key);
@@ -1237,7 +1240,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->dhchap_ctrl_secret);
 	kfree(opts);
 }
-EXPORT_SYMBOL_GPL(nvmf_free_options);
+
+int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts)
+{
+	return kref_get_unless_zero(&opts->ref);
+}
+EXPORT_SYMBOL_GPL(nvmf_ctrl_options_get);
+
+void nvmf_ctrl_options_put(struct nvmf_ctrl_options *opts)
+{
+	kref_put(&opts->ref, nvmf_free_options);
+}
+EXPORT_SYMBOL_GPL(nvmf_ctrl_options_put);
 
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
@@ -1259,6 +1273,8 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&opts->ref);
+
 	ret = nvmf_parse_options(opts, buf);
 	if (ret)
 		goto out_free_opts;
@@ -1314,7 +1330,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
-	nvmf_free_options(opts);
+	nvmf_ctrl_options_put(opts);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..8436533aed16 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -78,6 +78,7 @@ enum {
 /**
  * struct nvmf_ctrl_options - Used to hold the options specified
  *			      with the parsing opts enum.
+ * @ref:	for reference count of the data structure
  * @mask:	Used by the fabrics library to parse through sysfs options
  *		on adding a NVMe controller.
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
@@ -117,6 +118,7 @@ enum {
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
+	struct kref		ref;
 	unsigned		mask;
 	int			max_reconnects;
 	char			*transport;
@@ -146,6 +148,9 @@ struct nvmf_ctrl_options {
 	int			fast_io_fail_tmo;
 };
 
+int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts);
+void nvmf_ctrl_options_put(struct nvmf_ctrl_options *opts);
+
 /*
  * struct nvmf_transport_ops - used to register a specific
  *			       fabric implementation of NVMe fabrics.
@@ -228,7 +233,6 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
-void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81046c9f171..ddbc5b21af5b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2406,8 +2406,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	if (ctrl->ctrl.opts)
-		nvmf_free_options(ctrl->ctrl.opts);
+	nvmf_ctrl_options_put(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
 
@@ -3474,10 +3473,15 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	idx = ida_alloc(&nvme_fc_ctrl_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	/*
@@ -3583,8 +3587,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
@@ -3607,6 +3609,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ida:
 	put_device(ctrl->dev);
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 20fdd40b1879..d3747795ad80 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -976,8 +976,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2236,6 +2236,12 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
+
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
@@ -2244,7 +2250,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);
 		if (!opts->trsvcid) {
 			ret = -ENOMEM;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
@@ -2263,13 +2269,13 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
 			       opts->host_traddr);
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
 	if (!opts->duplicate_connect && nvme_rdma_existing_controller(opts)) {
 		ret = -EALREADY;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
@@ -2286,7 +2292,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_free_ctrl;
+		goto out_free_opts;
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
@@ -2317,6 +2323,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 out_kfree_queues:
 	kfree(ctrl->queues);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..3b20c5ed033f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2349,8 +2349,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2678,6 +2678,11 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
@@ -2695,7 +2700,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 			kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
 		if (!opts->trsvcid) {
 			ret = -ENOMEM;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
@@ -2705,7 +2710,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
 			opts->traddr, opts->trsvcid);
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
@@ -2714,7 +2719,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
 			       opts->host_traddr);
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
@@ -2723,20 +2728,20 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
 		ret = -EALREADY;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
@@ -2770,6 +2775,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 out_kfree_queues:
 	kfree(ctrl->queues);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e589915ddef8..de2ff7ed0657 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -283,8 +283,8 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 	if (nctrl->tagset)
 		nvme_remove_io_tag_set(nctrl);
 	kfree(ctrl->queues);
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl);
 }
 
@@ -543,6 +543,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
+
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
@@ -550,10 +556,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-	if (ret) {
-		kfree(ctrl);
-		goto out;
-	}
+	if (ret)
+		goto out_free_opts;
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
@@ -612,7 +616,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
-out:
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
+out_free_ctrl:
+	kfree(ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-- 
2.43.1


