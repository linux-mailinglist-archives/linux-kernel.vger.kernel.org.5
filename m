Return-Path: <linux-kernel+bounces-71387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086485A477
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B43B21537
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF235364A9;
	Mon, 19 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eE23rC/C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WuXpm3P8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eE23rC/C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WuXpm3P8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228B2E85A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348537; cv=none; b=Z6DEC/rpOC5U6lpauUh+oIYpOQYdQ7pVuK/ZxDgsmUNrPkMgo9yU2q7tKLBQ2ESMyYDjf8u/h1cvropm5E3IMNcfywQ15G0tjyTqNroZhH1y4LIvHZqfkJM7nx7YJro1NfrNOgxF+jd+jOUfpi7rIhvh8odtBhzqz2mzSDdkv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348537; c=relaxed/simple;
	bh=3fTX27T2FxmGNJuKSvmm6ZGpVatKqKA53mQIRUJhzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmWrS+XO6Ytcc4NRCpGpRjDtOPgqBwwR5ywyCMT1oi9F0zrpFMNpFTF/BUTD3fX5cBK+8Cxl3ovIAOZ/V2D432BdSuxzeQ62xpbwv3zkbNyj0O2UDrSXwlCIQhx8P9apJz+tAx9e0Sgc3xRB/lPvDnJqNCJf29PFNDVUz2tZ2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eE23rC/C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WuXpm3P8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eE23rC/C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WuXpm3P8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 358991F7FB;
	Mon, 19 Feb 2024 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yftycFZCcqjHt7SJY5v4vF4oSS3TaYlqwDQ6B9sB/dk=;
	b=eE23rC/C6SAlsnMV6UKLjfDfdDPWKYjGlBTwOXswZIccfv3DukVlLOzrbMuUm5ncN7etAI
	G47nqWtyNtv3C+7ptZFviQd7exTAdbtxAdci2CdegAX6dKDzRVNM/7wFE9EsuD1QVbRD0N
	MpQNB+7AWYRXJiY9HHzL+COP6Cb7W6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yftycFZCcqjHt7SJY5v4vF4oSS3TaYlqwDQ6B9sB/dk=;
	b=WuXpm3P8ZXvpENL1XqvSGVrOPnBZYaHsJsD1tjHgYWZvNRKJYsC+CpAnRCvh6HgdSSED4m
	LdXEl7wna62wIlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yftycFZCcqjHt7SJY5v4vF4oSS3TaYlqwDQ6B9sB/dk=;
	b=eE23rC/C6SAlsnMV6UKLjfDfdDPWKYjGlBTwOXswZIccfv3DukVlLOzrbMuUm5ncN7etAI
	G47nqWtyNtv3C+7ptZFviQd7exTAdbtxAdci2CdegAX6dKDzRVNM/7wFE9EsuD1QVbRD0N
	MpQNB+7AWYRXJiY9HHzL+COP6Cb7W6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yftycFZCcqjHt7SJY5v4vF4oSS3TaYlqwDQ6B9sB/dk=;
	b=WuXpm3P8ZXvpENL1XqvSGVrOPnBZYaHsJsD1tjHgYWZvNRKJYsC+CpAnRCvh6HgdSSED4m
	LdXEl7wna62wIlCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D16139C6;
	Mon, 19 Feb 2024 13:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /sVPB3ZU02X5AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 1/6] nvme-fabrics: introduce connect_sync option
Date: Mon, 19 Feb 2024 14:15:26 +0100
Message-ID: <20240219131531.15134-2-dwagner@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eE23rC/C";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WuXpm3P8
X-Spamd-Result: default: False [1.69 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 358991F7FB
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

The TCP and RDMA transport are doing a synchronous connect, meaning the
syscal returns with the final result, that is. it either failed or
succeeded.

This isn't the case for FC. This transport just setups and triggers
the connect and returns without waiting on the result. Introduce a flag
to allow user space to control the behavior, wait or don't wait.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..7d33f0f5824f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -678,6 +678,7 @@ static const match_table_t opt_tokens = {
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
+	{ NVMF_OPT_CONNECT_SYNC,	"connect_sync"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -1024,6 +1025,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_CONNECT_SYNC:
+			opts->connect_sync = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1245,7 +1249,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_SYNC)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..01d3ef545f14 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONNECT_SYNC	= 1 << 28,
 };
 
 /**
@@ -115,6 +116,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @connect_sync: wait for connect attempt(s) to succeed or fail
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -144,6 +146,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			connect_sync;
 };
 
 /*
-- 
2.43.1


