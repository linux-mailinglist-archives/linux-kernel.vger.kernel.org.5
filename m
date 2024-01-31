Return-Path: <linux-kernel+bounces-46072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BAD8439F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501C9B2B1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D997AE6E;
	Wed, 31 Jan 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmjYvyLI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NykixTMg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmjYvyLI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NykixTMg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C079DA5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691088; cv=none; b=AYbEV3GPY34+mRdizubmpP9a4UCrZNpNMnr5Z4hMJk9QmGNLk3QKXIIbEepBw0VTWBjz4LIslT/XgeFs3DjThtv32pEhiVCRdFsbTC6FAR9/pGMaFSamp2Vz4VXmRv4DTYleq1OyXd/x4yum7LnP5XZbHmQ6VHiLemG8SuGFQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691088; c=relaxed/simple;
	bh=3+I3RipkXzbDBxUBpa/MYqOq/rreDtPMZkBLvkh5kbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfyN8wdTIQlt+YlrBGM65S7IycuaOP3eLKe6eHgdTMk79JPHtBE9LSUEiSXItHkEwhAXQpbLJCsxOcEqdGRDLqTJicPdUmyEjDYGsgRzIwUc15kFaShs8if5oDNWww+vxL2cIy0cKB0aVgUlZQUBrs5NB0YtFUq1jubfTin8E40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmjYvyLI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NykixTMg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmjYvyLI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NykixTMg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FAD022188;
	Wed, 31 Jan 2024 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJLqryCUSeCjG5siF7t6LmMZVAD9ghgGqIVZxzOzOaU=;
	b=qmjYvyLIQ5DUAL0EHikvBLR0Q2UdDnRGvpVDBeHF8Byg/xilhyqoOL2ydg1Qn+ERpuaxe5
	o1gDuYO01PXCuxjZfT+/k2sE7hYywrkztqOuRtR5d3Pue0wPNYr2TDj437idj6e53xoPsL
	onyTr5OwBNcp302TL3xuZUWybFDLFyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJLqryCUSeCjG5siF7t6LmMZVAD9ghgGqIVZxzOzOaU=;
	b=NykixTMgzNuef0AZj2m80kbijK37V5SnNLJgJfwendNs00hHbb67YbNgh6l7R1Zt1a8Ezq
	/q9LzRBUvPJuarCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJLqryCUSeCjG5siF7t6LmMZVAD9ghgGqIVZxzOzOaU=;
	b=qmjYvyLIQ5DUAL0EHikvBLR0Q2UdDnRGvpVDBeHF8Byg/xilhyqoOL2ydg1Qn+ERpuaxe5
	o1gDuYO01PXCuxjZfT+/k2sE7hYywrkztqOuRtR5d3Pue0wPNYr2TDj437idj6e53xoPsL
	onyTr5OwBNcp302TL3xuZUWybFDLFyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJLqryCUSeCjG5siF7t6LmMZVAD9ghgGqIVZxzOzOaU=;
	b=NykixTMgzNuef0AZj2m80kbijK37V5SnNLJgJfwendNs00hHbb67YbNgh6l7R1Zt1a8Ezq
	/q9LzRBUvPJuarCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3E8132FA;
	Wed, 31 Jan 2024 08:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x5+5GAwKumWKHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 05/12] nvmet-fc: free queue and assoc directly
Date: Wed, 31 Jan 2024 09:51:05 +0100
Message-ID: <20240131085112.21668-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
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
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Neither struct nvmet_fc_tgt_queue nor struct nvmet_fc_tgt_assoc are data
structure which are used in a RCU context. So there is no reason to
delay the free operation.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 11ecfef41bd1..b44b99525c44 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -145,7 +145,6 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
-	struct rcu_head			rcu;
 	/* array of fcp_iods */
 	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
 } __aligned(sizeof(unsigned long long));
@@ -169,7 +168,6 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue 	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
-	struct rcu_head			rcu;
 };
 
 
@@ -852,7 +850,7 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 
 	destroy_workqueue(queue->work_q);
 
-	kfree_rcu(queue, rcu);
+	kfree(queue);
 }
 
 static void
@@ -1185,8 +1183,8 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree_rcu(assoc, rcu);
 	nvmet_fc_tgtport_put(tgtport);
+	kfree(assoc);
 }
 
 static void
-- 
2.43.0


