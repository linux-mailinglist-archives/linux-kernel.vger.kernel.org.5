Return-Path: <linux-kernel+bounces-132671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E989984F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CD3283992
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB415F31D;
	Fri,  5 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tAqVdcaj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+xLWMXQk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tAqVdcaj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+xLWMXQk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C363DB97;
	Fri,  5 Apr 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306691; cv=none; b=KoPccRA6hdEKhfOlgOhGvGTzPalmpSrY4zSqAN51SUBEriRmJHbJAbkvVh9tHQoWwVdzd0/BXkz26NIo5MvAU7+rD1bMqK6J0O0h3RCgpQaH8Uhg8wavTIb42b5DHGSNFutAQuAECaVi9mzMp9jE0ZQL+1UaRIZSK/0Pleae0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306691; c=relaxed/simple;
	bh=7YNRlrAcoyG/GgPjRSHx/EbzxzA7DFDQ3rI4N0VGfB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aib+mBonqRDU/3ziGsQJ7tF1dUaENh0FTXxnmMYVICTTp+ViKLjMG5DXNPhk9uFt8oWYkrCgHrvnIBGPvEeHAUD1yhLjw+Vd8IQt9cnZHtcxwGWw/Z6qeFrkwN8V8OBgt50l3iU2o4y+5glHBFLbe/UVQLiBxaF2lI1dQNiq0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tAqVdcaj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+xLWMXQk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tAqVdcaj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+xLWMXQk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EF1421A24;
	Fri,  5 Apr 2024 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712306687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i+O4AE3NAynzP6j5bH6pNrCGJTgFQPmATJfGRfm6Bqo=;
	b=tAqVdcaj9srGaLf7j546xzWofOcBtByL1TDwjTFjZSiH+HIHb966txNiudG3KCli+1VLl9
	7knPGWUAqdZiGuDSvApjZDgYlnvvhfUq1rHSOd4pgthAbNnkdC35ijOna9JtZrTBsfAqja
	cFSnukJhCtqT6nCJJtpoEVYM69T7qOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712306687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i+O4AE3NAynzP6j5bH6pNrCGJTgFQPmATJfGRfm6Bqo=;
	b=+xLWMXQkKK8lVqtXG/C/NFrIWF2/HEzzVVwyzEgTs9N8/ZyebS6jw8umcAeutyDlC8CKLT
	pIMJH6jcnJY4bPAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712306687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i+O4AE3NAynzP6j5bH6pNrCGJTgFQPmATJfGRfm6Bqo=;
	b=tAqVdcaj9srGaLf7j546xzWofOcBtByL1TDwjTFjZSiH+HIHb966txNiudG3KCli+1VLl9
	7knPGWUAqdZiGuDSvApjZDgYlnvvhfUq1rHSOd4pgthAbNnkdC35ijOna9JtZrTBsfAqja
	cFSnukJhCtqT6nCJJtpoEVYM69T7qOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712306687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i+O4AE3NAynzP6j5bH6pNrCGJTgFQPmATJfGRfm6Bqo=;
	b=+xLWMXQkKK8lVqtXG/C/NFrIWF2/HEzzVVwyzEgTs9N8/ZyebS6jw8umcAeutyDlC8CKLT
	pIMJH6jcnJY4bPAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 59763139E8;
	Fri,  5 Apr 2024 08:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id b2QrFP+5D2bjSAAAn2gu4w
	(envelope-from <tiwai@suse.de>); Fri, 05 Apr 2024 08:44:47 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: psmouse: add NULL check to psmouse_from_serio()
Date: Fri,  5 Apr 2024 10:44:46 +0200
Message-ID: <20240405084448.15754-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[21.76%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

The serio drvdata can be still NULL while the PS/2 interrupt is
processed.  This leaded to crash with a NULL dereference Oops, as
psmouse_from_serio() blindly assumes the non-NULL ps2dev object.

Add a NULL check and return NULL from psmouse_from_serio().  The
returned NULL is handled properly in the caller side, skipping the
rest gracefully.

The log in the bugzilla entry showed that the probe of synaptics
driver succeeded after that point.  So this is a stop-gap solution.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1219522
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

 drivers/input/mouse/psmouse-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a0aac76b1e41..fdeee7578d18 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -120,6 +120,8 @@ struct psmouse *psmouse_from_serio(struct serio *serio)
 {
 	struct ps2dev *ps2dev = serio_get_drvdata(serio);
 
+	if (!ps2dev)
+		return NULL;
 	return container_of(ps2dev, struct psmouse, ps2dev);
 }
 
-- 
2.43.0


