Return-Path: <linux-kernel+bounces-46068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78CA8439F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89317B2AE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872179DB8;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7l6jVU0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sk0oPjVE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7l6jVU0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sk0oPjVE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048127995B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691086; cv=none; b=jq8IN0/D0vu+GSXU9tr7YBhQIIuknN4aQ8Cf3c5+i/MPD1Ylt6aD5+mJs8519GGIURBC4zDFP4F0x8sFqdvPmBB/3IRsh5bZI0JY5nfqxGItLyaCbC9DDJNwrRk31lVUclUpqiqFSJhERGfnHL8w1eG9pIqLf3iqPeGxK/Ax20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691086; c=relaxed/simple;
	bh=V7Jtpd7lYG148xNcB31HoyqrcoOJtIJD5kaifLwWBTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgipGd/X6jYtAehmcWGX96tq9hECGe6gIYz1O+7wFlodnw+BqHq5Z0QwE5xVXZdmHJ0iLrTXQbj+DGkaXfAmlxd6y9xAbFpK7oeNI7ULhMbHZBBnxZoB4F/xISyAxzUCAm0PIfIBxy3GGLUwTgXUinT+8iQ6cc3uNh7DBLJCfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7l6jVU0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sk0oPjVE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7l6jVU0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sk0oPjVE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39A651FD05;
	Wed, 31 Jan 2024 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=Q7l6jVU00tUnnQX0lIWFHaa2sGIkYUhgNYLgdDzeMhw1cFpwQz7x48UbC4mpV/qvyLLJdf
	Y6G+s+Umk6dxW8NSXUZN7Af4QRcSiN+Nnt7XOPtjIc4OXB0DJ+L+mJKz9vjyBacaUcM/ZD
	VN0eiqthmOGV14z9CfN7k6YGwELj9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=sk0oPjVEiZtgmRITqlDTWLlFJi8tw6Bw+QZ/uhlkWg1vZOEFUtTo0aYjOULqj4aeb2DWXO
	MWPv5ex21JoyPJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=Q7l6jVU00tUnnQX0lIWFHaa2sGIkYUhgNYLgdDzeMhw1cFpwQz7x48UbC4mpV/qvyLLJdf
	Y6G+s+Umk6dxW8NSXUZN7Af4QRcSiN+Nnt7XOPtjIc4OXB0DJ+L+mJKz9vjyBacaUcM/ZD
	VN0eiqthmOGV14z9CfN7k6YGwELj9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=sk0oPjVEiZtgmRITqlDTWLlFJi8tw6Bw+QZ/uhlkWg1vZOEFUtTo0aYjOULqj4aeb2DWXO
	MWPv5ex21JoyPJBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FAE139F5;
	Wed, 31 Jan 2024 08:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nwxMCAsKumWDHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 03/12] nvmet-fc: release reference on target port
Date: Wed, 31 Jan 2024 09:51:03 +0100
Message-ID: <20240131085112.21668-4-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.82
X-Spamd-Result: default: False [0.82 / 50.00];
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
	 BAYES_HAM(-2.88)[99.49%]
X-Spam-Flag: NO

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 05e6a755b330..3d53d9dc1099 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -360,7 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -373,6 +373,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


