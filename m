Return-Path: <linux-kernel+bounces-68262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD48577F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CF4B2199D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96371CFBD;
	Fri, 16 Feb 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yMtjZeHt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKBy/lAg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yMtjZeHt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKBy/lAg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA91B956
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073146; cv=none; b=ou7bCSvAXh+azvzbYIs3i27vsKA613ESWCqRQtcmuTZlOLX8gBLznIY7Kfzq+V/vyMDwN3oiDEf8iQIFOVBIK90fYwgkIFa+qE9z9QnBM/t3f5r9O/mq6+9EALm7o1OVcSIL4eXxjLrlAkHCxZIizAZ7qkiDsPuuMUl8+PTeE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073146; c=relaxed/simple;
	bh=jy9DRC7+SqxK5oZyWV+pslfAXvoKWnsiJbMrB40vPrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brjdXilkSICtiDdt3VEhkfVOjLGuEsI6KtxJAzjqQfPT95oBBSyV8vFAdawbZ3N14yVRYoWkXKG0qxUoORySq5AUCfYpceLugukeMM5cZ4WLtEwk4uJeY7ftnGbGwV7jn7DeoT3e63eEC5GqwMl18q7PxthbPSBCwyoJ0+vCyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yMtjZeHt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKBy/lAg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yMtjZeHt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKBy/lAg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 144E6220AF;
	Fri, 16 Feb 2024 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NOGbUlrDJJ5ltMa3j0eq+WSmfrFXg34PHU5GrpGC/U=;
	b=yMtjZeHtBdy5mRNq3iVV588twq2GI2NrED5PiZEWo3OrRDGEWRf3mn88ZUnEAqh18wIqMK
	WHmD4XY/tjv6b3VnLQ8OcoFhP3BXCDLw8Ap3XJFo9Cm2wU/BuNnSA0ojlJmTTZmNwbpFRU
	hVKTW3dII0XRcvmFSCgdEkoPv6277P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NOGbUlrDJJ5ltMa3j0eq+WSmfrFXg34PHU5GrpGC/U=;
	b=CKBy/lAg3pqUxByHrHiSxT/XORtei7uCkCnsOCKwlfWy53sCPT5UFvuA5BDpDHQVXRR8Bv
	/dsbtulbTUKrTJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NOGbUlrDJJ5ltMa3j0eq+WSmfrFXg34PHU5GrpGC/U=;
	b=yMtjZeHtBdy5mRNq3iVV588twq2GI2NrED5PiZEWo3OrRDGEWRf3mn88ZUnEAqh18wIqMK
	WHmD4XY/tjv6b3VnLQ8OcoFhP3BXCDLw8Ap3XJFo9Cm2wU/BuNnSA0ojlJmTTZmNwbpFRU
	hVKTW3dII0XRcvmFSCgdEkoPv6277P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NOGbUlrDJJ5ltMa3j0eq+WSmfrFXg34PHU5GrpGC/U=;
	b=CKBy/lAg3pqUxByHrHiSxT/XORtei7uCkCnsOCKwlfWy53sCPT5UFvuA5BDpDHQVXRR8Bv
	/dsbtulbTUKrTJDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 014C113343;
	Fri, 16 Feb 2024 08:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SpN3OrMgz2WacwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:39 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 2/6] nvme-fc: rename free_ctrl callback to match name pattern
Date: Fri, 16 Feb 2024 09:45:22 +0100
Message-ID: <20240216084526.14133-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yMtjZeHt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="CKBy/lAg"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.15 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.34)[76.24%]
X-Spam-Score: 1.15
X-Rspamd-Queue-Id: 144E6220AF
X-Spam-Flag: NO

Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
pattern for the callback.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657b..a5b29e9ad342 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2428,7 +2428,7 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
  * controller. Called after last nvme_put_ctrl() call
  */
 static void
-nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
+nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
@@ -3384,7 +3384,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
+	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
-- 
2.43.0


