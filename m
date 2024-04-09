Return-Path: <linux-kernel+bounces-136575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671789D5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABF31F24243
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E1823CB;
	Tue,  9 Apr 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FtW4D0k1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BQqJ1R1D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FtW4D0k1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BQqJ1R1D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043680BE7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655321; cv=none; b=k7dKvG/MPszefZI0fB2a565Dp4ZBQsXdl72rUMcCPz8Q2TmRHh+TkxlDOohUWhw6qoGmPyzzQqnXrYvAVUdDzvbl/gSqdc1SJpUaRWot/RICwxFpume9wFY68ZLkVYouBafvYpZV61HIggszeFiQIhXvuv8nCN3muydVC/eVQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655321; c=relaxed/simple;
	bh=DevpoDEAhnDlAdhXY8izgV01ET9L354/Ax7QTW/6l3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtizMXuXvli6aP7RN8eZJ6iS+7Ly1j8LJYI3TrFXJzpElVa4dOJKY05TNmluB0cDQkYEm+IAw8pLwvtGbNVN3QZ+d743wuOrqwomHCWCv3L9EpXAtOBPHGIenVbSjD3kR0Nfpmot2PPxVWHquru/LimGvEk+/qmDxA+ZnxhRHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FtW4D0k1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BQqJ1R1D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FtW4D0k1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BQqJ1R1D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03AA4338F5;
	Tue,  9 Apr 2024 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ul5kzVEWxUFMosDFpe4FpPaWSDhzeWWrJcGmnq9IKQ=;
	b=FtW4D0k1mWed/pZqgManOyoPMCOoZ5+zc9E03MgFSj2OxIHmTqf5BtUdSb4gCL9w4ponUI
	f7M49izImZMjmbFk/OxGYMP+eafoXEa6oksnZlxNMsc85zcbYuDppN4McTi1yR2Z5a6rGz
	+hIBXlkXRqmOT7XMYVZehM3hrlSdyp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ul5kzVEWxUFMosDFpe4FpPaWSDhzeWWrJcGmnq9IKQ=;
	b=BQqJ1R1DKlKxmpajecMqpB/QeAclJ9//EP7ahTCL0kSEuUz3a8MrPlcHAF9B7R2+6whfi5
	Z+M8aZ9U3c8B2BAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ul5kzVEWxUFMosDFpe4FpPaWSDhzeWWrJcGmnq9IKQ=;
	b=FtW4D0k1mWed/pZqgManOyoPMCOoZ5+zc9E03MgFSj2OxIHmTqf5BtUdSb4gCL9w4ponUI
	f7M49izImZMjmbFk/OxGYMP+eafoXEa6oksnZlxNMsc85zcbYuDppN4McTi1yR2Z5a6rGz
	+hIBXlkXRqmOT7XMYVZehM3hrlSdyp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ul5kzVEWxUFMosDFpe4FpPaWSDhzeWWrJcGmnq9IKQ=;
	b=BQqJ1R1DKlKxmpajecMqpB/QeAclJ9//EP7ahTCL0kSEuUz3a8MrPlcHAF9B7R2+6whfi5
	Z+M8aZ9U3c8B2BAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D7F0E13AA0;
	Tue,  9 Apr 2024 09:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5DARM9ULFWavRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 5/6] nvme-fc: use nvme_ctrl_reconnect to decide reconnect attempts
Date: Tue,  9 Apr 2024 11:35:09 +0200
Message-ID: <20240409093510.12321-6-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
References: <20240409093510.12321-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	RCVD_TLS_ALL(0.00)[]

The fc transport handles the DNR for reconnect correctly, though it
ignores all the negative error code returned by the LLDD. Thus, use the
nvme_ctrl_reconnect helper to ensure to have consistent behavior for all
transports.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a5b29e9ad342..a58f08304459 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3301,7 +3301,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	struct nvme_fc_rport *rport = ctrl->rport;
 	struct nvme_fc_remote_port *portptr = &rport->remoteport;
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
-	bool recon = true;
+	bool recon = nvme_ctrl_reconnect(status);
 
 	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
@@ -3310,8 +3310,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
-		if (status > 0 && (status & NVME_SC_DNR))
-			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
-- 
2.44.0


