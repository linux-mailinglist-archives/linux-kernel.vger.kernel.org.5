Return-Path: <linux-kernel+bounces-46076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734148439FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F528AD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC97F46A;
	Wed, 31 Jan 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qBJYU/tI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uI5ABNFF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qBJYU/tI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uI5ABNFF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D879DA4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691090; cv=none; b=bMxJ23n4IucNm3hVlmzj/t2C6DMXKKaPRxxBK/4kWCSgT4YGCiOe93XXKuzZZADPGaP0U2VYyLw7TO4DwQA2YGReOo7ldsnxRLpofAZOx2Q73HINZutXk6aH7An59T6KqxhQJRkQ2YBj/g9g1Ln23AKNExQXswKlvK8VeSvdqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691090; c=relaxed/simple;
	bh=coe/c0JKdSouUfLh6dzFg4/7jsYn8i3YdtJ4V6+eiMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA5KkJ6sbwuXOp6Oo1qgaaVW/EaRhEFXhSWV+eAicyTjqEymltg3D77YWWCs63zRFPeEOUK1w3TM+YWiWXBL1gp13vHWqMF8PF4XeOW3ANcHEUOTOoSgW/iI3lB3kcO5t5ykCQm5quzK94kHF0IqT6g2/VC9Tv/xUq82Fh0gwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qBJYU/tI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uI5ABNFF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qBJYU/tI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uI5ABNFF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03F221FD0A;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=qBJYU/tI6j44El8T38dpMPmQFBHQ7EV+uE73VMBvrYlvgInoeeMOhk/IPLrLu8AqVA6a4n
	gb1e50BqDnsl5RSbhSOGukyuA4Fl1eW5Rhp4yxiO1DUJLmwKLKvlKzKxU/rEDiAjPq2GsW
	s78FDYPTS8e+pHQuOTiAEfqfJVt6/+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=uI5ABNFFvxjGkzFXZmBy6BLnb78DDdvMbwLRHoomuwcUdrhh++C8RkPRJj7TDKbtbkacjW
	MldXcc7gZBA39IAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=qBJYU/tI6j44El8T38dpMPmQFBHQ7EV+uE73VMBvrYlvgInoeeMOhk/IPLrLu8AqVA6a4n
	gb1e50BqDnsl5RSbhSOGukyuA4Fl1eW5Rhp4yxiO1DUJLmwKLKvlKzKxU/rEDiAjPq2GsW
	s78FDYPTS8e+pHQuOTiAEfqfJVt6/+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=uI5ABNFFvxjGkzFXZmBy6BLnb78DDdvMbwLRHoomuwcUdrhh++C8RkPRJj7TDKbtbkacjW
	MldXcc7gZBA39IAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E54E5132FA;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9PmSNg4KumWYHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 09/12] nvmet-fc: abort command when there is no binding
Date: Wed, 31 Jan 2024 09:51:09 +0100
Message-ID: <20240131085112.21668-10-dwagner@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qBJYU/tI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uI5ABNFF
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.74%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 03F221FD0A
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spam-Flag: NO

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fe3246024836..c80b8a066fd1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1099,6 +1099,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2514,8 +2517,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


