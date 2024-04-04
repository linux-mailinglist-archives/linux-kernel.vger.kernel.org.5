Return-Path: <linux-kernel+bounces-131637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E2898A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9351C25D54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874561D555;
	Thu,  4 Apr 2024 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w67yvzg/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RNMzBZ72";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vEOy8XuQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vSijkvP5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2211B964
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241702; cv=none; b=s6DPB7wR78Ft3IrSuFZBTYfGnXDkkZmGYvNpEAO5/oXiCGdD9/gYV8+bG2vQfr2rcwD7yKTObydSF0tL8wNFmPAPLn8AExP7KStdrrtpEOcJbjIXaTGc67MLawprn4/7BLQeTzCvd5WG9ksi+u/ovETTEVdeyoFTZHBS+qPXCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241702; c=relaxed/simple;
	bh=k4DttWMe2otYlFQVxmSUOWiHoIRlHS0CVBiGjbaWU78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mtcz+AIKoueDt0lvkEFCNPoZX/IkneK4RGorOBarDVogrFJN3z7NU6s8Ps8d1zffUCYkfpTCKaM8QKJSpCD3v4ve0+HN6r6byjJ3iguTU10aX/Q1p3q2Ri+hoQhEA4WRetYktiuoJChOy7+ISpDJ17AxdRapGdoei5ubHzYbKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w67yvzg/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RNMzBZ72; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vEOy8XuQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vSijkvP5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 784B15F806;
	Thu,  4 Apr 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=w67yvzg/Al/UeZ+5cLx0lHEij9NqcqbAZJVJpk9FEyNJX2o5wvQXjGzyZ2iiB3M3ZmvMfB
	YhG8ZdPSvqovq7nnnMfr9R4CfXvv1q5sEfj1Qj6LZ90ZY1WPh3SqyOwA3yO35hUiiM5BMR
	LXDcmShOB7qJ8FWdC/paGFdhTA1M0qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=RNMzBZ72F6SkqmP7dEjSNzL0W2/G1/LvzkJ2VXFoo+qXepA6J/8jRKrZC1o8VKE4oiQHf7
	/jBL8CRg+r3FIPBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=vEOy8XuQKn4mMQ6MLsiOyElEX9NBfJz5PsQohHNLHgIEdCZuCzz55LcFzGMteP1Wq7pBG7
	TsQTOTNdaSXvprbcDsHErG8Rb5K2HGHCGe4PwNKsiCHPeJFhqzuPVQ/LtpWyHDeAR4j+sP
	y0GO/n0KFid9jy2xIMjKCu49655QIc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=vSijkvP5ap3vymxsQg0aH+sT+fj/RexiPB4AjIrXN2c4adR2kyPq3Vn2ENkuCClOz/dDhu
	GfHhdNJ/vjVRDdAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 66CFE13298;
	Thu,  4 Apr 2024 14:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XIamFyK8DmZxDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 14:41:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/2] nvme-fc: rename free_ctrl callback to match name pattern
Date: Thu,  4 Apr 2024 16:41:31 +0200
Message-ID: <20240404144131.17988-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404144131.17988-1-dwagner@suse.de>
References: <20240404144131.17988-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.17
X-Spam-Level: 
X-Spamd-Result: default: False [-0.17 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.37)[76.88%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]

Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
pattern for the callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
2.44.0


