Return-Path: <linux-kernel+bounces-61310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265438510D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C21C20F69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751919478;
	Mon, 12 Feb 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0fQtlRgd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+/y2VEXJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0fQtlRgd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+/y2VEXJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB518AE4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733790; cv=none; b=qeeFNaR0XbkLMseIy3Jgwea2Q3Ed8SgfoS5uCRU18JkDYAl7LGBlZAo35iNRJD+HnpmPGg3D/dCEiwUGV8wEgSUFa31AcCeXud41JP+WpwnVxGcnNxAfKJq6sI2ecMpc3cVzZk2S+OYwtKkvFWlISnjY0MDpmh+Svv8gt86E7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733790; c=relaxed/simple;
	bh=24KMFTDtM8zDrK2zoHWmRLkUEB0HDxDBEyiRrun12dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4U+150KeLCuGU2Gm71oRpblr+FVMeAqD0f5ZJTEUQ8X2OqBoKgV5ibEHOGf90qXyQ5vO4Bfka63dYpgQWg10IbVS8Qp2CAPwqKJkOErjE8llWnKkV4PN89knijjvQM1RQSi1MYB26wyJY/IYyGAd1+b8ecE0hPqqGAqg0Tee9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0fQtlRgd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+/y2VEXJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0fQtlRgd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+/y2VEXJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 592AA21FAA;
	Mon, 12 Feb 2024 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHSEkwkOSqT6ah+GaDRFScqUEIBxmXVYMhJHdx6LhuE=;
	b=0fQtlRgdCdmPDINWNLZBDyijqCHhRZheRxW/VfYdPOG+dSjcsQUyFdlXEq+2/p51MPIFfW
	sbC7Vw9+7+A6vMAO92YUx/dtYZ6kjlIEvwj1SOyGGVLOguaQkDQUfzIfTtEdsBWmOXl6xw
	9NGQ7kkLD0/Wm/fyGL5jkS0ffho/jXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHSEkwkOSqT6ah+GaDRFScqUEIBxmXVYMhJHdx6LhuE=;
	b=+/y2VEXJMhaa2DDJvrdcrKdTwCkfRl0UBgBGQdZTo79EE8CULguyJGtCzmjucbGtpdpktU
	uCuh5lvhnDGoZLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHSEkwkOSqT6ah+GaDRFScqUEIBxmXVYMhJHdx6LhuE=;
	b=0fQtlRgdCdmPDINWNLZBDyijqCHhRZheRxW/VfYdPOG+dSjcsQUyFdlXEq+2/p51MPIFfW
	sbC7Vw9+7+A6vMAO92YUx/dtYZ6kjlIEvwj1SOyGGVLOguaQkDQUfzIfTtEdsBWmOXl6xw
	9NGQ7kkLD0/Wm/fyGL5jkS0ffho/jXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHSEkwkOSqT6ah+GaDRFScqUEIBxmXVYMhJHdx6LhuE=;
	b=+/y2VEXJMhaa2DDJvrdcrKdTwCkfRl0UBgBGQdZTo79EE8CULguyJGtCzmjucbGtpdpktU
	uCuh5lvhnDGoZLAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B01813A0E;
	Mon, 12 Feb 2024 10:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4lPzDBvzyWU9CQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:29:47 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
Date: Mon, 12 Feb 2024 11:29:40 +0100
Message-ID: <20240212102940.11137-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0fQtlRgd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+/y2VEXJ"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.16)[88.76%]
X-Spam-Score: 0.33
X-Rspamd-Queue-Id: 592AA21FAA
X-Spam-Flag: NO

The RCU lock is only needed for the lookup loop and not for
list_ad_tail_rcu call. Thus move it down the call chain into
nvmet_fc_assoc_exists.

While at it also fix the name typo of the function.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..337ee1cb09ae 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1115,16 +1115,21 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 }
 
 static bool
-nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
+nvmet_fc_assoc_exists(struct nvmet_fc_tgtport *tgtport, u64 association_id)
 {
 	struct nvmet_fc_tgt_assoc *a;
+	bool found = false;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
-		if (association_id == a->association_id)
-			return true;
+		if (association_id == a->association_id) {
+			found = true;
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	return false;
+	return found;
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1164,13 +1169,11 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		ran = ran << BYTES_FOR_QID_SHIFT;
 
 		spin_lock_irqsave(&tgtport->lock, flags);
-		rcu_read_lock();
-		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
+		if (!nvmet_fc_assoc_exists(tgtport, ran)) {
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 			done = true;
 		}
-		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	} while (!done);
 
-- 
2.43.0


