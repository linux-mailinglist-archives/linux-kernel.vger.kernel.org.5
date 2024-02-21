Return-Path: <linux-kernel+bounces-74782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D687C85D9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF783B226DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FD7BB00;
	Wed, 21 Feb 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w5Fx9Fz5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wikyw4A4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oldx6DBU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HNlrwYsn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D247866C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521857; cv=none; b=em9uwlN5j06xR0wBbNjfSje5MrmHL8lPS5ToKZFkckkBkjzQhbbG0h+q8TnibJIvSRO0cVZRYuFcSCQEFGm4VSZXF6GnIA8ohWpN41Naz/mGAJ7+OrACXsG/0xC2iWx4Yi+uluH6uN6W73qldsXCzXEElbUY54Dwaw8G8D+NEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521857; c=relaxed/simple;
	bh=Ym7TFu6r6aw+U9CNds3HvZg6pH5a78LLvgHTOEOcQfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqrAkR09H9gQOBQGS3e+u09FBUBhV1J+aHYRsbpmeVesZkHO0c8aXf/JyaRz7YtKGf9YUcs7kYIR1cxY8IsGGmG8KkDDROq47e2RTRPDMgsrsHwANh10rt5A+pP1noPsmR0dpnC9UdikEzXFDLwQpmVLJ+klYmhjm9e/KRllapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w5Fx9Fz5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wikyw4A4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oldx6DBU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HNlrwYsn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAFE61FB61;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=w5Fx9Fz5qYRbrm7sF5DA/BeiBibRfI4JepUlrYc+xzdPzhB0BHL8mb3VWdQ0Ub/QwXu+IJ
	SPe2/wHblk44TlusZdYDevbcGJy+k4V1/UHQDV/Qn3qmzw/++5QoQNvN6w982l32N8FLaV
	hnhesFx7jmXt8uRXD/gd1v/zNiqzVoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=wikyw4A4sNr+V/eA2NM9fo0ArKcCRREKSH+JmyCDqUacibWJ0xpJ3LARycW60zFzmEGvl5
	Gd59FOqncoKYD8AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=Oldx6DBUt1bx2wzCuiBkGHXJ1WMBORMOA/Vq+yBMwicQthLQmi+ss4iqLb9oTfDqp9x9O6
	lcYjV2nTVeC8jE5OvB62o+8z+y7XVC0Tb45Kg3AicJzLt7eggfsgdxExs/zcWmkuJgpBe3
	Wf2lZHc/VvWr5OpWUF5r1O9UGxuuOcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=HNlrwYsn0sBlrkqQLpdXSPXPq9uk48zyG3xZJyPqMU7It49GBfZpo0TpBdG83X+s+XJddZ
	uYoTzx26bZxm41AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A589113A42;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xjDoJn351WUXPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or connection is refused
Date: Wed, 21 Feb 2024 14:24:01 +0100
Message-ID: <20240221132404.6311-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
References: <20240221132404.6311-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oldx6DBU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HNlrwYsn
X-Spamd-Result: default: False [3.05 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.64)[92.74%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.05
X-Rspamd-Queue-Id: BAFE61FB61
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

There is no point in retrying to connect if the authentication fails.

Connection refused is also issued from the authentication path, thus
also do not retry.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a5b29e9ad342..b81046c9f171 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 			ctrl->cnum, status);
 		if (status > 0 && (status & NVME_SC_DNR))
 			recon = false;
+		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
+			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
-- 
2.43.1


