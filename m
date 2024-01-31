Return-Path: <linux-kernel+bounces-46069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571168439F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB7E1F2DC08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3872179DD4;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mNq7eH5w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4MgMJ9a8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mNq7eH5w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4MgMJ9a8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A57995F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691087; cv=none; b=EIf7SXgSnjT9wzSKez+5l+zIYUKFXkO9VYZiqW185TwAPlMghZU5INkOntz7nwKehbNx++xfTT2ZxsaHyrlRkkCGhG/LSkI/EPL+pWe7Yt/ZXHc5CTSwF6uqp/VuNDA11Rx2S2PSE1lUN7K24DgoFTc0bKkcniNx35jczxAVIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691087; c=relaxed/simple;
	bh=JaPgBUji+Pi2OZFQgWpVLOvj3fNHAoAyPBb+KBHuwhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fj+iQcCwSoXLGtfsgfaRRkSBHCKnwz5rp71ZB/CUo021TR4kHtfPqrSC4mxwiR9Qf7dmlFLGTVHw3G3oIggqaqK71MYVciQGL7wwCLqBVa3qzNDPGnwssAJHPU6XwxMFMhdAGA9DaAYe1ENtIIdOVyY6HzNdjbfzbLfhzC3z0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mNq7eH5w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4MgMJ9a8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mNq7eH5w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4MgMJ9a8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CB0021FF3;
	Wed, 31 Jan 2024 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQJ9lL2WhEc3RuAdBkdcgFfyzu0YnSsffpECzX01zqk=;
	b=mNq7eH5woEzdrl9tSb5DqovBM2HEebucKDN3oyLHW5Fes6rTWJpY7xMGHPilZ5GK0lN0Vg
	RkjEBue3y4mEhwifJOM1hRXRsl2Thi4Mpk5s4QPJA8f7cb4J+ItQzOoNMI470+4tDiZ/V0
	fdYBWqCIbM0wbCJcK9jk59oQVdwOBRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQJ9lL2WhEc3RuAdBkdcgFfyzu0YnSsffpECzX01zqk=;
	b=4MgMJ9a8QXT6mxPjReLfaEaAk9nc9npJhmwxMvKb3muKcB70PEnJc1oOL2U/kYTRlZ4sq5
	MCPOvO4pfkMPmEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQJ9lL2WhEc3RuAdBkdcgFfyzu0YnSsffpECzX01zqk=;
	b=mNq7eH5woEzdrl9tSb5DqovBM2HEebucKDN3oyLHW5Fes6rTWJpY7xMGHPilZ5GK0lN0Vg
	RkjEBue3y4mEhwifJOM1hRXRsl2Thi4Mpk5s4QPJA8f7cb4J+ItQzOoNMI470+4tDiZ/V0
	fdYBWqCIbM0wbCJcK9jk59oQVdwOBRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQJ9lL2WhEc3RuAdBkdcgFfyzu0YnSsffpECzX01zqk=;
	b=4MgMJ9a8QXT6mxPjReLfaEaAk9nc9npJhmwxMvKb3muKcB70PEnJc1oOL2U/kYTRlZ4sq5
	MCPOvO4pfkMPmEBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 83D04139F5;
	Wed, 31 Jan 2024 08:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5/h7HgoKumV+HAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:22 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 02/12] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed, 31 Jan 2024 09:51:02 +0100
Message-ID: <20240131085112.21668-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mNq7eH5w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4MgMJ9a8
X-Spamd-Result: default: False [-1.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.86%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CB0021FF3
X-Spam-Level: 
X-Spam-Score: -1.78
X-Spam-Flag: NO

The first argument of list_add_tail function is the new element which
should be added to the list which is the second argument. Swap the
arguments to allow processing more than one element at a time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c1faeb1e9e55..1471af250ea6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
-- 
2.43.0


