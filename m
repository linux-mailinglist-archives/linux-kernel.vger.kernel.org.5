Return-Path: <linux-kernel+bounces-3971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D881762B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B69AB216CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A54989D;
	Mon, 18 Dec 2023 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L19Sc9vV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqqX81U+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L19Sc9vV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqqX81U+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9E74E04
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 154B71F37E;
	Mon, 18 Dec 2023 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=L19Sc9vVeoGzkuaT2qhVSvnG1e+bsLsIbDUptKVOlITXwsbz8oar6ZZiFL7/YNxqipOTqr
	/Nz3myfKu/2YrcLBQ5sEOOAO39HhKdsxqEgACVxrUl5wyRvzZGvuJf7GJvH8s4g5HN28pg
	SV4xV6TSZxp67M6sRZDmFOe0T4RRR+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=DqqX81U+go088EIo54twaH9n2d7KVeW8hu+UFLich8bj+0EIpHlQFpXv3AFSLrcDJipvhD
	E21TFtbKbh+D93AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=L19Sc9vVeoGzkuaT2qhVSvnG1e+bsLsIbDUptKVOlITXwsbz8oar6ZZiFL7/YNxqipOTqr
	/Nz3myfKu/2YrcLBQ5sEOOAO39HhKdsxqEgACVxrUl5wyRvzZGvuJf7GJvH8s4g5HN28pg
	SV4xV6TSZxp67M6sRZDmFOe0T4RRR+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=DqqX81U+go088EIo54twaH9n2d7KVeW8hu+UFLich8bj+0EIpHlQFpXv3AFSLrcDJipvhD
	E21TFtbKbh+D93AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A4213BC8;
	Mon, 18 Dec 2023 15:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ea/SAG1ogGXOfgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:42:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 04/16] nvmet-trace: null terminate device name string correctly
Date: Mon, 18 Dec 2023 16:30:52 +0100
Message-ID: <20231218153105.12717-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.81%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spam-Flag: NO

strlen returns the string length excluding the null byte ('\0'), thus we
cut the last chars from the device name. While at it, switch snprintf to
ensure we always have properly terminated string.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/trace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 68f5317b1251..952e69f9737f 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -59,8 +59,9 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
-		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
+	snprintf(name,
+		 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
+		 "%s", req->ns->device_path);
 }
 #endif
 
-- 
2.43.0


