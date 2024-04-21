Return-Path: <linux-kernel+bounces-152511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3C78ABF91
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3228161E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395717C6A;
	Sun, 21 Apr 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pk8nNq/u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Okn0s4jM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pk8nNq/u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Okn0s4jM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597B1429B;
	Sun, 21 Apr 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713709367; cv=none; b=YZF1cWrA2R9YBPcM6vsWE19c5Ez3XuSRx/XNTrQZynoEI7ygt0VQq/KExeNAY/yzWGVkMrrv5Qd+UGHiDI6ugDBT6y9/D//y3w1v35baDe0oFvsrU/YzOBeRfajPRNNikbnJnlOo+oSbSIg/1ZMbhvAiNRiGdBgfdi2rwgBMPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713709367; c=relaxed/simple;
	bh=2FtL9q5lxhcTRJOh4mdw6XudRZaWyQsJmyja/hMn7jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyybJQYCbtYhp9ZwnNxm8pL/74LNSeWfRdx5RX1Z0ZH/yosf24RMEk8H+sd87ZmqqkT+kUaCvH8Wcg9RKiXGbIvFMPfrmFalUBXjp4wQmmS+zTKJAUnNyUxDdGrRpASsyqB9bccaHjR6u7aC/8qXLCfPP4lw2St5IxvG3kHJidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pk8nNq/u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Okn0s4jM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pk8nNq/u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Okn0s4jM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6AFF20F10;
	Sun, 21 Apr 2024 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713709357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0KmDhdcvtj9G8gCkXxDmU3FPVVKYh9jcF0fj66UTaHo=;
	b=pk8nNq/uNsIMRYuD0NWcz7x4n0kNs6EHnm+YEvVKiGcN0YIST7MP7KCpm4Eqz7v46giAbL
	a1UHzLexhHy9Qqz0Vl6LxD9AMOWXSGS62l6hC5tCP7iYbi+//vxh1OFR4FqKRzekXur3F/
	IuDBOhhYdqTgtfWT7zTDJumpdbjp6U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713709357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0KmDhdcvtj9G8gCkXxDmU3FPVVKYh9jcF0fj66UTaHo=;
	b=Okn0s4jMQSfXtGQO5qA3yAlH9/dueBA7VD+nIUezvvsi27lcjW3Cekzb1ubDb9yjerVRXq
	dqhvJP4HkgUpxABg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pk8nNq/u";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Okn0s4jM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713709357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0KmDhdcvtj9G8gCkXxDmU3FPVVKYh9jcF0fj66UTaHo=;
	b=pk8nNq/uNsIMRYuD0NWcz7x4n0kNs6EHnm+YEvVKiGcN0YIST7MP7KCpm4Eqz7v46giAbL
	a1UHzLexhHy9Qqz0Vl6LxD9AMOWXSGS62l6hC5tCP7iYbi+//vxh1OFR4FqKRzekXur3F/
	IuDBOhhYdqTgtfWT7zTDJumpdbjp6U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713709357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0KmDhdcvtj9G8gCkXxDmU3FPVVKYh9jcF0fj66UTaHo=;
	b=Okn0s4jMQSfXtGQO5qA3yAlH9/dueBA7VD+nIUezvvsi27lcjW3Cekzb1ubDb9yjerVRXq
	dqhvJP4HkgUpxABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD8913981;
	Sun, 21 Apr 2024 14:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WVR6Gy0hJWZZYQAAD6G6ig
	(envelope-from <iluceno@suse.de>); Sun, 21 Apr 2024 14:22:37 +0000
From: Ismael Luceno <iluceno@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Ismael Luceno <iluceno@suse.de>,
	Firo Yang <firo.yang@suse.com>,
	Andreas Taschner <andreas.taschner@suse.com>,
	=?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.com>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH v2] ipvs: Fix checksumming on GSO of SCTP packets
Date: Sun, 21 Apr 2024 16:22:32 +0200
Message-ID: <20240421142234.15764-1-iluceno@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[14.50%];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A6AFF20F10
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

It was observed in the wild that pairs of consecutive packets would leave
the IPVS with the same wrong checksum, and the issue only went away when
disabling GSO.

IPVS needs to avoid computing the SCTP checksum when using GSO.

Fixes: 90017accff61 ("sctp: Add GSO support", 2016-06-02)
Co-developed-by: Firo Yang <firo.yang@suse.com>
Signed-off-by: Ismael Luceno <iluceno@suse.de>
Tested-by: Andreas Taschner <andreas.taschner@suse.com>
CC: Michal Kubeček <mkubecek@suse.com>
CC: Simon Horman <horms@verge.net.au>
CC: Julian Anastasov <ja@ssi.bg>
CC: lvs-devel@vger.kernel.org
CC: netfilter-devel@vger.kernel.org
CC: netdev@vger.kernel.org
CC: coreteam@netfilter.org
---

Notes:
    Changes since v1:
    * Added skb_is_gso before skb_is_gso_sctp.
    * Added "Fixes" tag.

 net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index a0921adc31a9..1e689c714127 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
@@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
-- 
2.43.0


