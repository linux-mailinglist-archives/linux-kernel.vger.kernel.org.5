Return-Path: <linux-kernel+bounces-158897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7528B2673
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65A71F240E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42D14D45D;
	Thu, 25 Apr 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GipJC5dF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1bC27S4l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GipJC5dF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1bC27S4l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204D14C5A0;
	Thu, 25 Apr 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062542; cv=none; b=gmlrirzaM+zaADEn9SZc4KmRJthEdTNPfDhgobYCBOVm3AOxu8e/8YVUSGJy8i1wzqqm/XubVQN9vhomqLpMWBQs+FrnIPcxx2KFNd6JgiO0H2H5IfnZzeAQKNphu9b4xWYXTZvZJUF4k/PbuZWZbjzUOFtiyzcZ/e0c0arRXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062542; c=relaxed/simple;
	bh=ECPlObhEBIG/F5eZ/EaI4YFlNQTrHLMup8aVRDilkgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d49e+QhxunVeYDQU7raXlkfRUzyz+smP81F2iSwTTUMWmxj7s8tj44Dvv4sQrvhysLy9D2a+kSWDK69DLkRBgLegyPZFSMQcNZj5rAB20+/8dXwuMpj0uFuab0hiVOJxCyWsEoqBEyNFlPpffxZTuMRh61sLDUZ7nXqYU0LzL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GipJC5dF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1bC27S4l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GipJC5dF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1bC27S4l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0581933F8B;
	Thu, 25 Apr 2024 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714062539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Z5RtrRxhlie0zgpubMe5xW7HzPYgkOoPsvYnVoi4kI=;
	b=GipJC5dF1e73XLJ5Ss3vVhAuShUgDXWB9QAiuOYbFDsUJE770aoT3mKsXpeGMfsZqUz3Zo
	7LK1LxZC23cmrrIhJR9jBVso7BJrX337exTHoACpwZOxgjvwlDGr8u+bJE3jddcLexMObo
	gC6dUXdh5XklleTMnv+ACUusCV78tMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714062539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Z5RtrRxhlie0zgpubMe5xW7HzPYgkOoPsvYnVoi4kI=;
	b=1bC27S4lPEbJn/faNDewmEceDGG8CUT+FGBpMnnVQROR9K0fUvEMz+dHXLNN7CestZo+mb
	6xmL5FSoanoQkWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714062539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Z5RtrRxhlie0zgpubMe5xW7HzPYgkOoPsvYnVoi4kI=;
	b=GipJC5dF1e73XLJ5Ss3vVhAuShUgDXWB9QAiuOYbFDsUJE770aoT3mKsXpeGMfsZqUz3Zo
	7LK1LxZC23cmrrIhJR9jBVso7BJrX337exTHoACpwZOxgjvwlDGr8u+bJE3jddcLexMObo
	gC6dUXdh5XklleTMnv+ACUusCV78tMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714062539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Z5RtrRxhlie0zgpubMe5xW7HzPYgkOoPsvYnVoi4kI=;
	b=1bC27S4lPEbJn/faNDewmEceDGG8CUT+FGBpMnnVQROR9K0fUvEMz+dHXLNN7CestZo+mb
	6xmL5FSoanoQkWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC36D13991;
	Thu, 25 Apr 2024 16:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 78AeOcqEKmawIwAAD6G6ig
	(envelope-from <iluceno@suse.de>); Thu, 25 Apr 2024 16:28:58 +0000
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
Subject: [PATCH v3] ipvs: Fix checksumming on GSO of SCTP packets
Date: Thu, 25 Apr 2024 18:28:40 +0200
Message-ID: <20240425162842.23900-1-iluceno@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[23.28%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

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
    Changes since v2:
    * Use only skb_is_gso, no need to check for GSO type
    
    Changes since v1:
    * Added skb_is_gso before skb_is_gso_sctp.
    * Added "Fixes" tag.

 net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index a0921adc31a9..83e452916403 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
@@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
-- 
2.43.0


