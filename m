Return-Path: <linux-kernel+bounces-101165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5787A34E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAD6283057
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8421370;
	Wed, 13 Mar 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rdFQ6nU0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rdFQ6nU0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D820DCF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314062; cv=none; b=D9vSb2PQesXG8F/1/H8JUxacwGeU/p5bzYETHxHN3inLl/OefCWb1FLOu343LB+NkGvu8KWkXRqFjUhXa4zrSeSCfAwUd8baDBNIRD5sCMsCGIKRrVBNR68ExhWn4BZ/vlGBkyjKIu/0OAFu11tTYmiDqB7iQ+tR/i9S4/qghU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314062; c=relaxed/simple;
	bh=hQfkQWSJQKLLPZaMZxXINBFpWyakUN7e9BWkcVz6YIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2wBzO+h0A04JdjmDwMtysv6wcyNWHHppoWUqzjBAtg2Q9iLP3EY2Is/1Dw08guuwceJKklmBZa2AeIiVsz2v1RXpRKs94UXd1PnM8ZxXHw20LePD0gYYG46xSlW0U5KncB4M6mpJKNxln8024P/ifVTuglyMXgfjIjCIXqSzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rdFQ6nU0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rdFQ6nU0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A14D61F7A4;
	Wed, 13 Mar 2024 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOrIQxEHvyyL2+vnTct/YehpC03sIRKTsXlKpP1po1Y=;
	b=rdFQ6nU0hMG5OoHLPrOIQAHfUkxhtZt0ph2a1H8aFLDj9OPEQzCRc3LkMIMw//1AcSV+IP
	iyD+rfzi1cV43KLqpVhnklc7ySFYXh9bH5bKokJR0jo9CoVEuuyFy4iT0PN3I+pJZADBK/
	SkPc6iMRPcobbOQ7U6Ginn1pqF9Es34=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOrIQxEHvyyL2+vnTct/YehpC03sIRKTsXlKpP1po1Y=;
	b=rdFQ6nU0hMG5OoHLPrOIQAHfUkxhtZt0ph2a1H8aFLDj9OPEQzCRc3LkMIMw//1AcSV+IP
	iyD+rfzi1cV43KLqpVhnklc7ySFYXh9bH5bKokJR0jo9CoVEuuyFy4iT0PN3I+pJZADBK/
	SkPc6iMRPcobbOQ7U6Ginn1pqF9Es34=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A3CF13977;
	Wed, 13 Mar 2024 07:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i4BMGEpS8WWtSAAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 13 Mar 2024 07:14:18 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Demi Marie Obenour <demi@invisiblethingslab.com>
Subject: [PATCH 1/2] xen/evtchn: avoid WARN() when unbinding an event channel
Date: Wed, 13 Mar 2024 08:14:08 +0100
Message-Id: <20240313071409.25913-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313071409.25913-1-jgross@suse.com>
References: <20240313071409.25913-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rdFQ6nU0
X-Spamd-Result: default: False [4.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[27.98%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 4.69
X-Spam-Level: ****
X-Rspamd-Queue-Id: A14D61F7A4
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

When unbinding a user event channel, the related handler might be
called a last time in case the kernel was built with
CONFIG_DEBUG_SHIRQ. This might cause a WARN() in the handler.

Avoid that by adding an "unbinding" flag to struct user_event which
will short circuit the handler.

Fixes: 9e90e58c11b7 ("xen: evtchn: Allow shared registration of IRQ handers")
Reported-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Tested-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/evtchn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 59717628ca42..f6a2216c2c87 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -85,6 +85,7 @@ struct user_evtchn {
 	struct per_user_data *user;
 	evtchn_port_t port;
 	bool enabled;
+	bool unbinding;
 };
 
 static void evtchn_free_ring(evtchn_port_t *ring)
@@ -164,6 +165,10 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 	struct per_user_data *u = evtchn->user;
 	unsigned int prod, cons;
 
+	/* Handler might be called when tearing down the IRQ. */
+	if (evtchn->unbinding)
+		return IRQ_HANDLED;
+
 	WARN(!evtchn->enabled,
 	     "Interrupt for port %u, but apparently not enabled; per-user %p\n",
 	     evtchn->port, u);
@@ -421,6 +426,7 @@ static void evtchn_unbind_from_user(struct per_user_data *u,
 
 	BUG_ON(irq < 0);
 
+	evtchn->unbinding = true;
 	unbind_from_irqhandler(irq, evtchn);
 
 	del_evtchn(u, evtchn);
-- 
2.35.3


