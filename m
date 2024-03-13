Return-Path: <linux-kernel+bounces-101166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DA87A351
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474B81F21CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B222630;
	Wed, 13 Mar 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UoywMclp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UoywMclp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DE225DE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314067; cv=none; b=rSKEsTxZUqh944KG/Jhl5NTO0kxo7q/uVR9XMgYYoV64fQEpVsPPrZkXa0kYtQUn2PnKvGJeywWKSbuJ1UXQzhrLuI/zxZZhbDYon6kKWMFYWfmwUHQQwF03z8sln6MwUepa2T5qg17iQBEUA8RfiAQsuW/0pBxy5EVA9ZKsuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314067; c=relaxed/simple;
	bh=U0jSC2h7kQCcpgHrk1T0gyWetAKWJfKBKkwLYdLb4x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoOlQlxMsNUiVg4PoDq9zOseN8AJN728exr68oFrQnj9S10Ptk01Sy7BUQQtyQ7PzYJ8cIkgB7jZ+yqbqNYM1cQZe5G+Fvz9JpjVIcd7TWwFgZ9Zst1+ONtylrqHxCK7ejdAhoMmk/gXTZwkZ/RMsQimddTKdyrstKVXO9bw+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UoywMclp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UoywMclp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C52E1F7A4;
	Wed, 13 Mar 2024 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaNFizuX+HpD4/5IgMI1rgARw+12/nL76PmtgllkKJ0=;
	b=UoywMclp7TJYR91IhMV5U07zPMiTVrKqIXuCdOeYZZI4+snSxSOAmhNgkwR1+9eNhqvEHJ
	oJkI5PAD0SyxktGTNUtz1B+bwPyMQ89NaDpemlhVcEzwvYw8POk8o8qaa3cDOEYxo1LT1f
	Pr/hjgxHYfcfMh7WaiitQ3QSY3awRy0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaNFizuX+HpD4/5IgMI1rgARw+12/nL76PmtgllkKJ0=;
	b=UoywMclp7TJYR91IhMV5U07zPMiTVrKqIXuCdOeYZZI4+snSxSOAmhNgkwR1+9eNhqvEHJ
	oJkI5PAD0SyxktGTNUtz1B+bwPyMQ89NaDpemlhVcEzwvYw8POk8o8qaa3cDOEYxo1LT1f
	Pr/hjgxHYfcfMh7WaiitQ3QSY3awRy0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D2313977;
	Wed, 13 Mar 2024 07:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dM3kAlBS8WWySAAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 13 Mar 2024 07:14:24 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] xen/events: increment refcnt only if event channel is refcounted
Date: Wed, 13 Mar 2024 08:14:09 +0100
Message-Id: <20240313071409.25913-3-jgross@suse.com>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UoywMclp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 4C52E1F7A4
X-Spam-Flag: NO

In bind_evtchn_to_irq_chip() don't increment the refcnt of the event
channel blindly. In case the event channel is NOT refcounted, issue a
warning instead.

Add an additional safety net by doing the refcnt increment only if the
caller has specified IRQF_SHARED in the irqflags parameter.

Fixes: 9e90e58c11b7 ("xen: evtchn: Allow shared registration of IRQ handers")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 2faa4bf78c7a..81effbd53dc5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1190,7 +1190,7 @@ int xen_pirq_from_irq(unsigned irq)
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
 static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
-				   struct xenbus_device *dev)
+				   struct xenbus_device *dev, bool shared)
 {
 	int ret = -ENOMEM;
 	struct irq_info *info;
@@ -1224,7 +1224,8 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 		 */
 		bind_evtchn_to_cpu(info, 0, false);
 	} else if (!WARN_ON(info->type != IRQT_EVTCHN)) {
-		info->refcnt++;
+		if (shared && !WARN_ON(info->refcnt < 0))
+			info->refcnt++;
 	}
 
 	ret = info->irq;
@@ -1237,13 +1238,13 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 
 int bind_evtchn_to_irq(evtchn_port_t evtchn)
 {
-	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip, NULL);
+	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip, NULL, false);
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
 int bind_evtchn_to_irq_lateeoi(evtchn_port_t evtchn)
 {
-	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip, NULL);
+	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip, NULL, false);
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq_lateeoi);
 
@@ -1295,7 +1296,8 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 
 static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					       evtchn_port_t remote_port,
-					       struct irq_chip *chip)
+					       struct irq_chip *chip,
+					       bool shared)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
 	int err;
@@ -1307,14 +1309,14 @@ static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					  &bind_interdomain);
 
 	return err ? : bind_evtchn_to_irq_chip(bind_interdomain.local_port,
-					       chip, dev);
+					       chip, dev, shared);
 }
 
 int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 					   evtchn_port_t remote_port)
 {
 	return bind_interdomain_evtchn_to_irq_chip(dev, remote_port,
-						   &xen_lateeoi_chip);
+						   &xen_lateeoi_chip, false);
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
 
@@ -1430,7 +1432,8 @@ static int bind_evtchn_to_irqhandler_chip(evtchn_port_t evtchn,
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL);
+	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL,
+				      irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1471,7 +1474,8 @@ static int bind_interdomain_evtchn_to_irqhandler_chip(
 {
 	int irq, retval;
 
-	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip);
+	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip,
+						  irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 
-- 
2.35.3


