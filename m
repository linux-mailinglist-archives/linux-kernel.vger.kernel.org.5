Return-Path: <linux-kernel+bounces-44310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE78842042
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92921B2B735
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EA67E8A;
	Tue, 30 Jan 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qSHWMIPB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GcuZW1RN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qSHWMIPB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GcuZW1RN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5676773B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608195; cv=none; b=QtXf6D1xLpe35DXrVrELp1iaDl+dMDOJD9y32Qe9FO13K5iUp/vZAHBpbBAEbPbhvweREWXfxBJ24iQOijN/xyeFsID4M7KXYYYy0b0lrHYMB4DLP0ROOTFXT24D82zEMUxWc2x5k4tdhRFTxrzOkrWZFKw2aP8n4TESwd0zGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608195; c=relaxed/simple;
	bh=6D5qNAHnDte/6Mzqnuo1FyKTHqXNvTLI05sdlQ9npWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDq3j/5gOua+xdKl1VC81nyOv9yy0+wLYdTqhzcnU5FjHrkNy0Kwq3FpSWrQfLUFMaL34CtUZIiEJedIO8DOA5pDrIhk+VadpsFnfjBrWmEQPpLgowvmZ+KTgIiTeqp1odgY8/U5TkeSvcqNgF0RgAnEvI0n72slEjfeC6bIGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qSHWMIPB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GcuZW1RN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qSHWMIPB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GcuZW1RN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE67A21167;
	Tue, 30 Jan 2024 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9lO6rwnkk3zLh5AVHkxXZFZgFDoVGhiyPcyMfjsG9k=;
	b=qSHWMIPBHI+RMsoJH6/eJJ32llGbcF/ajTpNwiwN025SoyvGBQXVyr4KSeOjwEORGzXPAK
	auRp5oZoLp+KJciqhaFYaJmvNosTniiXGX2py/FwM9Jq/5LhwPTvw5spTkut2VPCY/osvD
	r73y7Nsm8vRKa77vHeb+WPnGlJoBhuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9lO6rwnkk3zLh5AVHkxXZFZgFDoVGhiyPcyMfjsG9k=;
	b=GcuZW1RNl75y5KDHXf4WSSoxmmLjhxcr5U51OkLqlErFDfs6qpZf3Rj5DDBsEWrHZYfK4/
	xMesHmtJzNBnmMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9lO6rwnkk3zLh5AVHkxXZFZgFDoVGhiyPcyMfjsG9k=;
	b=qSHWMIPBHI+RMsoJH6/eJJ32llGbcF/ajTpNwiwN025SoyvGBQXVyr4KSeOjwEORGzXPAK
	auRp5oZoLp+KJciqhaFYaJmvNosTniiXGX2py/FwM9Jq/5LhwPTvw5spTkut2VPCY/osvD
	r73y7Nsm8vRKa77vHeb+WPnGlJoBhuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9lO6rwnkk3zLh5AVHkxXZFZgFDoVGhiyPcyMfjsG9k=;
	b=GcuZW1RNl75y5KDHXf4WSSoxmmLjhxcr5U51OkLqlErFDfs6qpZf3Rj5DDBsEWrHZYfK4/
	xMesHmtJzNBnmMDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C0CE13462;
	Tue, 30 Jan 2024 09:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id s+mhJD/GuGWRbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 06/12] nvmet-fc: hold reference on hostport match
Date: Tue, 30 Jan 2024 10:49:32 +0100
Message-ID: <20240130094938.1575-7-dwagner@suse.de>
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
	 BAYES_HAM(-0.00)[39.97%]
X-Spam-Flag: NO

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


