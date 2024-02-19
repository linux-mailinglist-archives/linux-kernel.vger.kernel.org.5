Return-Path: <linux-kernel+bounces-71389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1785A478
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2A1C21F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5C36AEE;
	Mon, 19 Feb 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X9yxwtAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6WXCnyEd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X9yxwtAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6WXCnyEd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227936122
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348539; cv=none; b=W2cRB0RwQuAw+6i83NvO7ZkBP/zGatJr8vijIu0WbZ0unlHVKQIJcVqwpFhtf0IrDBjDf5ehnZmpfUfOeQIwlFfbOx8SkFU4onwosp58Kk21BlvHocR67zP/JU5d1ANjb1CXG9zMYy6Ln58E40EBbxiKd50IfcVhGKfDH0UOs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348539; c=relaxed/simple;
	bh=Ym7TFu6r6aw+U9CNds3HvZg6pH5a78LLvgHTOEOcQfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc/q2SGo9PEDthNekcGJrBqKKq5lQXok19UwMZH60QgPseXF1e4NdVlknolo+iRt34a1pXymqTMqLQiFnO3+mnR8LH1I5rvasb7p87mYh01EmV+D0QSnYaWYEi8E18JgHJroN7psTggd/lMFtMi3cwnxcFpB30BMbGiGI71hU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X9yxwtAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6WXCnyEd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X9yxwtAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6WXCnyEd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 725131F7FD;
	Mon, 19 Feb 2024 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=X9yxwtAQC6i9Ro99Ynre0N51+HxQGjKigVPCPf4Ogvl5hp/McW0Bc0sSdUK/w5B6pViVL2
	mMHDJwYq7JOg3ScXMrcfKoE1Sj9C6ug47fw7PgJhKbTm+wwk70ghV1FkdcGF4Y8WTrT0sI
	4d1e7utRcP1jfTc9mlHlk+utZJBOVSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=6WXCnyEdGM/8uJdZ4EuVeI+5uz4EI0U3r5RgsmSHBvt8VboD3yBoCfZF+DZ1C1G6LCu7v4
	scvhFXkVm1xKt1Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=X9yxwtAQC6i9Ro99Ynre0N51+HxQGjKigVPCPf4Ogvl5hp/McW0Bc0sSdUK/w5B6pViVL2
	mMHDJwYq7JOg3ScXMrcfKoE1Sj9C6ug47fw7PgJhKbTm+wwk70ghV1FkdcGF4Y8WTrT0sI
	4d1e7utRcP1jfTc9mlHlk+utZJBOVSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=6WXCnyEdGM/8uJdZ4EuVeI+5uz4EI0U3r5RgsmSHBvt8VboD3yBoCfZF+DZ1C1G6LCu7v4
	scvhFXkVm1xKt1Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 612CC139C6;
	Mon, 19 Feb 2024 13:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4VBLFndU02X9AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 3/6] nvme-fc: do not retry when auth fails or connection is refused
Date: Mon, 19 Feb 2024 14:15:28 +0100
Message-ID: <20240219131531.15134-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240219131531.15134-1-dwagner@suse.de>
References: <20240219131531.15134-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.14 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.76)[84.26%]
X-Spam-Level: ****
X-Spam-Score: 4.14
X-Spam-Flag: NO

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


