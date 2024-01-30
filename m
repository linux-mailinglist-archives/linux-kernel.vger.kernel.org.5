Return-Path: <linux-kernel+bounces-44313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B08842025
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F041F241CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5BE6A336;
	Tue, 30 Jan 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sR/0aYaW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ToSVIbgY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sR/0aYaW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ToSVIbgY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B867E66
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608197; cv=none; b=HEYmmZd3mCYKoBf+EkVzcIhUzPbGaN3u/a0vSfefQ9iXW6pyGayRM6GnOprPIm3M81+QWB9jPfKPFiD72Ylu9AUDIwYx7UZDyhRYydcDaGgERa/V+BVJItsNCxBKboujLsZtCQtQO8N4WRrJGmyrUmCBaicg3X3aVGkyIw7iOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608197; c=relaxed/simple;
	bh=Y0Ry2iadhqi8emlPeOA/J1XwHUaczAWTKR+gQbwQZk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8GOIJ2atsq3wI4BStC6ew5B3u4+XORwi5U7mEzp/8JxoruJQTi1kD3M32Pdi0hc5ViWXmdYSpu/m80ZHCbfI3wF+5zlpDETm7Udwb6F40H3NgXE1D0r37RlO/NSyMFpFDwO7PYOLEO4P4aNz02rr9tYx38mPC9+rWkQ6hKM7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sR/0aYaW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ToSVIbgY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sR/0aYaW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ToSVIbgY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F7C621F90;
	Tue, 30 Jan 2024 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KU2KRImXH4Dq2cSK8HSdS8+CzpufHu7ZOAfEo9r7l0=;
	b=sR/0aYaWqHDeyrrM6Z6ozItQlsOURALsqY0+cPfekBTZUsQJgPt696D7N0hI5mqcaBzuz+
	2sTEvbLyhVV9gktLIHwHpddd5GLFIKtRjfTt4j6UXIJ/w7m5CWVBjT7h2EvN/TL9bp8Ajg
	KQKy8BkmZ+hMv2sObyjnA9uBVt9/Pfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KU2KRImXH4Dq2cSK8HSdS8+CzpufHu7ZOAfEo9r7l0=;
	b=ToSVIbgYTW3hHgdon4XsZzXZw68BgxaK/X1ewn5cgfqpiwoJnXgt+IWxzaOnIJBman0BsE
	lz9LrDgO0PyL7vDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KU2KRImXH4Dq2cSK8HSdS8+CzpufHu7ZOAfEo9r7l0=;
	b=sR/0aYaWqHDeyrrM6Z6ozItQlsOURALsqY0+cPfekBTZUsQJgPt696D7N0hI5mqcaBzuz+
	2sTEvbLyhVV9gktLIHwHpddd5GLFIKtRjfTt4j6UXIJ/w7m5CWVBjT7h2EvN/TL9bp8Ajg
	KQKy8BkmZ+hMv2sObyjnA9uBVt9/Pfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KU2KRImXH4Dq2cSK8HSdS8+CzpufHu7ZOAfEo9r7l0=;
	b=ToSVIbgYTW3hHgdon4XsZzXZw68BgxaK/X1ewn5cgfqpiwoJnXgt+IWxzaOnIJBman0BsE
	lz9LrDgO0PyL7vDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C58713462;
	Tue, 30 Jan 2024 09:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eVpJDULGuGWdbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:54 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 10/12] nvmet-fc: avoid deadlock on delete association path
Date: Tue, 30 Jan 2024 10:49:36 +0100
Message-ID: <20240130094938.1575-11-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130094938.1575-1-dwagner@suse.de>
References: <20240130094938.1575-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.02%]
X-Spam-Flag: NO

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c80b8a066fd1..3e0d391e631b 100644
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
@@ -247,6 +249,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -358,7 +367,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		goto out_puttgtport;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -371,8 +380,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1396,6 +1405,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


