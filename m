Return-Path: <linux-kernel+bounces-131333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8054898667
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4235FB2738E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238284D2A;
	Thu,  4 Apr 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gfTwZcZ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GmZuFjP+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E07745C3;
	Thu,  4 Apr 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231363; cv=none; b=kUOYTvzjSBftaQ6JAOlVfj7eW8B3strXSQwHf7rOCCBnLW6diSqi11YE82/1GuiwLKZRxJXE/gxiTZGIuJlic8xSNNB/PfMY6xnQK9b7qiPabrVXSGqxiJVgyaS6D4HO0ed382JRTs9fT99Jfx6PDmVv0t9taNl4BNFMBiY1tdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231363; c=relaxed/simple;
	bh=nsDNhESopgrlyLMUX6pXqRsQjNY64bQQgEYbtEgxgBE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=geJC3byXHD/vXgJfbraktL1wpaa/e4dG4nMo7pwov0IyVssaLfJJemGMdQypoR4I4OUkSZxLRqoj6btegXHdbB0uxxQuXHxSavuvxqRGz+Yx0oGyr0PXxDUTNQN0DYFMdCKBn853hZ2kEClfRsYVU4T/oZJW/pu8G3G0Gle2Y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gfTwZcZ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GmZuFjP+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A32E65D8F8;
	Thu,  4 Apr 2024 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712231353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/x9kZleEmr9UJKwNDU1GNGFTF512qoraQs7ixZ7EWwk=;
	b=gfTwZcZ0rHANC8/CboSHxZMhI7ZD42XjKhsHofmdSqY7PGURAD3NHOD4+gH01veMPoEqcL
	gzX50WWvtMrq2wy7sOv4kbgsywX0tmCpkYHM154Hlfj3l/ewsiDIP7T8QpTwYZS6bYbLsI
	qdMr11itivVub0nyd/qC+Km1o1p1roA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712231353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/x9kZleEmr9UJKwNDU1GNGFTF512qoraQs7ixZ7EWwk=;
	b=GmZuFjP+6lm4IdGjqZGmtdEMX68Unvt5IgpnK4khuPUC9hHIfuM8gVH4L9Vm8wIkeHLEYK
	v1wxGKIRB+XDueDw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E2DD13298;
	Thu,  4 Apr 2024 11:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Y5qKIrmTDmYZUwAAn2gu4w
	(envelope-from <tbogendoerfer@suse.de>); Thu, 04 Apr 2024 11:49:13 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching aggregator
Date: Thu,  4 Apr 2024 13:49:08 +0200
Message-Id: <20240404114908.134034-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 5.21
X-Spamd-Result: default: False [5.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.99)[-0.989];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com,greyhouse.net,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *****
X-Spam-Flag: NO

If selection logic decides to switch to a new aggregator it disables
all ports of the old aggregator, but doesn't enable ports on
the new aggregator. These ports will eventually be enabled when
the next LACPDU is received, which might take some time and without an
active port transmitted frames are dropped. Avoid this by enabling
already collected ports of the new aggregator immediately.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/bonding/bond_3ad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..529e2a7c51e2 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggregator *agg,
 				__disable_port(port);
 			}
 		}
+
+		/* enable ports on new active aggregator */
+		for (port = best->lag_ports; port;
+			port = port->next_port_in_aggregator) {
+			__enable_port(port);
+		}
+
 		/* Slave array needs update. */
 		*update_slave_arr = true;
 	}
-- 
2.35.3


