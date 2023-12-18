Return-Path: <linux-kernel+bounces-3962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B58175C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8286B1C24E35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC975A840;
	Mon, 18 Dec 2023 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BImCcHWe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LozNsC1+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BImCcHWe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LozNsC1+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711395A84A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 167DE1F37E;
	Mon, 18 Dec 2023 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702913884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frwg+Fv/Md0nePEz72ENwBzVnmZF61u9zbsIo6n5Yd0=;
	b=BImCcHWe6ul37PlrDid7FsfnhEKN8g9Zj740OF1fUEcjvGCEynQjHs+5RN/wfG7bINC+qN
	YDl6OBhF5HdgZsriUAYHyDPQOeVBnGDBCg4mgGRgEn5mkda7T1HpD/0KdmztxNHggRTVkA
	KQPecU/lPWGZw3bOu+hQ5uayjx1P2e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702913884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frwg+Fv/Md0nePEz72ENwBzVnmZF61u9zbsIo6n5Yd0=;
	b=LozNsC1+/s2Kyk6sJQCld43PHLM5pzF0qO+YhaIYuLxsyeBg6GUYcfwR9/tT5Puq3ZJnM3
	8LlOPzIknls0o6CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702913884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frwg+Fv/Md0nePEz72ENwBzVnmZF61u9zbsIo6n5Yd0=;
	b=BImCcHWe6ul37PlrDid7FsfnhEKN8g9Zj740OF1fUEcjvGCEynQjHs+5RN/wfG7bINC+qN
	YDl6OBhF5HdgZsriUAYHyDPQOeVBnGDBCg4mgGRgEn5mkda7T1HpD/0KdmztxNHggRTVkA
	KQPecU/lPWGZw3bOu+hQ5uayjx1P2e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702913884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frwg+Fv/Md0nePEz72ENwBzVnmZF61u9zbsIo6n5Yd0=;
	b=LozNsC1+/s2Kyk6sJQCld43PHLM5pzF0qO+YhaIYuLxsyeBg6GUYcfwR9/tT5Puq3ZJnM3
	8LlOPzIknls0o6CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 027E913BC8;
	Mon, 18 Dec 2023 15:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AT5RAFxngGWufQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:38:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 02/16] nvmet-fc: remove unnecessary bracket
Date: Mon, 18 Dec 2023 16:30:50 +0100
Message-ID: <20231218153105.12717-3-dwagner@suse.de>
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
X-Spamd-Result: default: False [0.82 / 50.00];
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
	 BAYES_HAM(-0.08)[63.42%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.82
X-Spam-Flag: NO

There is no need for the bracket around the identifier. Remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bd59990b5250..bda7a3009e85 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1031,7 +1031,7 @@ nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	list_for_each_entry(host, &tgtport->host_list, host_list) {
 		if (host->hosthandle == hosthandle && !host->invalid) {
 			if (nvmet_fc_hostport_get(host))
-				return (host);
+				return host;
 		}
 	}
 
-- 
2.43.0


