Return-Path: <linux-kernel+bounces-46073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D18439F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771BF1F2E089
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991607B3E2;
	Wed, 31 Jan 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R3sJXBOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V+pZwvh3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R3sJXBOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V+pZwvh3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBA79DA6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691088; cv=none; b=Xq2ZupDnmp9jSoK2YEUM4vm3CMGyway6oLN8TzAXtO6xeJYkiU6gOgcwUZLe/yn3qUspUJkloAXrc/AoWO5ybrl5tb5PpiGWIv8Hlf2p4PObbGfIn6lo8ntq5gGrz2sjKlnN8ucDbb8aZxJ19lq6jWLCUvxpLXhm+GC7JTyNIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691088; c=relaxed/simple;
	bh=k9VnTC2E0scTt27fHWfaedyxUc7y3ETys0MXODD+4u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGhUB4j1l1ix3/sTjvO2ECvbVsVs1aS6Eldm3zjSQPc5J8Ngp4aqsZQgxKX/ygF/f5Lffl603/dCyxSEs6irfaPykK60cfTioFbaX/ewF02bPS6vX9v9BSjZK1XqFWG+6n4s7392JIpysbomrlo5UrnsYxW6qXwJCl1fpESVEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R3sJXBOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V+pZwvh3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R3sJXBOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V+pZwvh3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2034C1FD0E;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=R3sJXBOiHBdZXbXSqNVxZB+e5d2RasvE5TymeW1cne1QpwY8ZtD+8DtnBciUjjlYWairjf
	ionBbRwwlyemK8Ge/yjYgUz+JHFIHT3qWscgsk2rna5LEwf6g85qQi9zHwvwez6w3OJshc
	Aj9TgWsm1qxbVxf7pHcROpX3WJb7hx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=V+pZwvh39BnHJhGktSGfTLqpXdVzh3EJ73gPPUiHQqz8Wvzyki4iKdBNlPr3ma9xAVEKmU
	WUREzTA7HCp826Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=R3sJXBOiHBdZXbXSqNVxZB+e5d2RasvE5TymeW1cne1QpwY8ZtD+8DtnBciUjjlYWairjf
	ionBbRwwlyemK8Ge/yjYgUz+JHFIHT3qWscgsk2rna5LEwf6g85qQi9zHwvwez6w3OJshc
	Aj9TgWsm1qxbVxf7pHcROpX3WJb7hx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=V+pZwvh39BnHJhGktSGfTLqpXdVzh3EJ73gPPUiHQqz8Wvzyki4iKdBNlPr3ma9xAVEKmU
	WUREzTA7HCp826Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E7EC132FA;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KFIYAg0KumWOHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 06/12] nvmet-fc: hold reference on hostport match
Date: Wed, 31 Jan 2024 09:51:06 +0100
Message-ID: <20240131085112.21668-7-dwagner@suse.de>
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
X-Spamd-Result: default: False [2.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.63)[98.35%]
X-Spam-Level: **
X-Spam-Score: 2.27
X-Spam-Flag: NO

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b44b99525c44..205a12b1e841 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1068,8 +1068,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


