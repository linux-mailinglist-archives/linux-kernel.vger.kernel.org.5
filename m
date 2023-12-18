Return-Path: <linux-kernel+bounces-3986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F50817656
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B961F2726B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E435A841;
	Mon, 18 Dec 2023 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I1WW/2Yi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVXkYC6f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I1WW/2Yi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVXkYC6f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685B5A84D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88D411FD48;
	Mon, 18 Dec 2023 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEDhLc4jQdXXTJgtSxhlyCdpiTkBcsIA12np3rAsa8Y=;
	b=I1WW/2YiqJ8hfTQulgEFb5CoSJKSeekBRCgLecy5L/P68I/YNUgiUCTAv24YVZ6BWy15Dw
	xPd2asIL8jWv6E1fs/PxgtInhi9WqYDkk+zZf6ogvsH7f1nJYxe2Lx9zL2hqxGF3EZ/Ceh
	AMz4upviPFh8SDeAWjGTvU5mIQEj7kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEDhLc4jQdXXTJgtSxhlyCdpiTkBcsIA12np3rAsa8Y=;
	b=WVXkYC6fLXCf+XlHomWRGhXfGDDfHIc0zid4fUcE4NM/ePwwQgFtjou79jbj1eB+Hpe9uQ
	OfST+GZYumbPFlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEDhLc4jQdXXTJgtSxhlyCdpiTkBcsIA12np3rAsa8Y=;
	b=I1WW/2YiqJ8hfTQulgEFb5CoSJKSeekBRCgLecy5L/P68I/YNUgiUCTAv24YVZ6BWy15Dw
	xPd2asIL8jWv6E1fs/PxgtInhi9WqYDkk+zZf6ogvsH7f1nJYxe2Lx9zL2hqxGF3EZ/Ceh
	AMz4upviPFh8SDeAWjGTvU5mIQEj7kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEDhLc4jQdXXTJgtSxhlyCdpiTkBcsIA12np3rAsa8Y=;
	b=WVXkYC6fLXCf+XlHomWRGhXfGDDfHIc0zid4fUcE4NM/ePwwQgFtjou79jbj1eB+Hpe9uQ
	OfST+GZYumbPFlCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B06C13BC8;
	Mon, 18 Dec 2023 15:49:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Xw4QHQFqgGWSfwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:49:21 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 07/16] nvmet-fc: Release reference on target port
Date: Mon, 18 Dec 2023 16:30:55 +0100
Message-ID: <20231218153105.12717-8-dwagner@suse.de>
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
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.19%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.79
X-Spam-Flag: NO

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bda7a3009e85..28e432e62361 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -360,6 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
+		nvmet_fc_tgtport_put(tgtport);
 		return;
 	}
 
-- 
2.43.0


