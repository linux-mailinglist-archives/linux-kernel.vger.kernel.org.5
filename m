Return-Path: <linux-kernel+bounces-4031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E48176F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5771C25996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB649F6F;
	Mon, 18 Dec 2023 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1v6op6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cS5EfduT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1v6op6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cS5EfduT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6025A84C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6538121FDD;
	Mon, 18 Dec 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702915640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK/Hr2YVEMCcXE4FG2IGAGx0ZBAT/0fwQl0qaqUb0zc=;
	b=G1v6op6ObibyZR/C0rZ28xAdfORhVbzUByAxvkvgs3dQ/32JZ6nXo6j4WkrGfU+XrOyLO5
	PuifE0PrxHlh5UPnMko3qpBhplWb+6z5wVJ93Wlnem2ttO2LTjX9Sn/URtMoWENQDbAtdC
	ZN5xib6UQxzl4+L/ZMjLGpfU7ovJTu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702915640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK/Hr2YVEMCcXE4FG2IGAGx0ZBAT/0fwQl0qaqUb0zc=;
	b=cS5EfduT2suNMErc3P2c4ho5D3m2AxJAY1ovUmq63jD5Nl/xloZj3qMBT8OJFtwpFPPqb1
	2a8arXTTU0wmlUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702915640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK/Hr2YVEMCcXE4FG2IGAGx0ZBAT/0fwQl0qaqUb0zc=;
	b=G1v6op6ObibyZR/C0rZ28xAdfORhVbzUByAxvkvgs3dQ/32JZ6nXo6j4WkrGfU+XrOyLO5
	PuifE0PrxHlh5UPnMko3qpBhplWb+6z5wVJ93Wlnem2ttO2LTjX9Sn/URtMoWENQDbAtdC
	ZN5xib6UQxzl4+L/ZMjLGpfU7ovJTu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702915640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK/Hr2YVEMCcXE4FG2IGAGx0ZBAT/0fwQl0qaqUb0zc=;
	b=cS5EfduT2suNMErc3P2c4ho5D3m2AxJAY1ovUmq63jD5Nl/xloZj3qMBT8OJFtwpFPPqb1
	2a8arXTTU0wmlUAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EAA713BD5;
	Mon, 18 Dec 2023 16:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vYlJEThugGVcBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 16:07:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
Date: Mon, 18 Dec 2023 16:31:03 +0100
Message-ID: <20231218153105.12717-16-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.21
X-Spamd-Result: default: False [2.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.37)[0.789];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[60.96%]
X-Spam-Flag: NO

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 23d8779dc221..30ba4ede333f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -243,6 +245,13 @@ static LIST_HEAD(nvmet_fc_portentry_list);
 
 static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
 static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
 static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
@@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		nvmet_fc_tgtport_put(tgtport);
+		queue_work(nvmet_wq, &tgtport->put_work);
 		return;
 	}
 
@@ -373,7 +382,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-	nvmet_fc_tgtport_put(tgtport);
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1402,6 +1411,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


