Return-Path: <linux-kernel+bounces-27288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AD82ED59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB4C28562A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D91A59E;
	Tue, 16 Jan 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jh8KHJD2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GA4WR0CZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jh8KHJD2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GA4WR0CZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B851A581;
	Tue, 16 Jan 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98A4D1FB95;
	Tue, 16 Jan 2024 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705403066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TsvTliU/AduXv8+lyjjkHnFNXCRZ5gTEvS/YJHnYT4c=;
	b=jh8KHJD2XI9MNvwOKBGUV3u89KpaECwx+WHsbVQXnR+JIfp+stGXAiY4Ae3T/PehyN4fdt
	if0vMud4Wh4bU/5SDKD+Cb4UfyGDTc5kl4ps3YJEQqzPJSBvMfJsi+xuoPwGlLg8t/L5wK
	t7l1L0Cs2e0JX9sXf6pTOw0ozeSIH+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705403066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TsvTliU/AduXv8+lyjjkHnFNXCRZ5gTEvS/YJHnYT4c=;
	b=GA4WR0CZZi+rJybJiMLoiP8UmdYjQ0ruP6PzcjWiLiql8N4mBmgQnyqll+JWMmeXxuCzoT
	wiqtKQPK62AIiHDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705403066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TsvTliU/AduXv8+lyjjkHnFNXCRZ5gTEvS/YJHnYT4c=;
	b=jh8KHJD2XI9MNvwOKBGUV3u89KpaECwx+WHsbVQXnR+JIfp+stGXAiY4Ae3T/PehyN4fdt
	if0vMud4Wh4bU/5SDKD+Cb4UfyGDTc5kl4ps3YJEQqzPJSBvMfJsi+xuoPwGlLg8t/L5wK
	t7l1L0Cs2e0JX9sXf6pTOw0ozeSIH+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705403066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TsvTliU/AduXv8+lyjjkHnFNXCRZ5gTEvS/YJHnYT4c=;
	b=GA4WR0CZZi+rJybJiMLoiP8UmdYjQ0ruP6PzcjWiLiql8N4mBmgQnyqll+JWMmeXxuCzoT
	wiqtKQPK62AIiHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 274D4132FA;
	Tue, 16 Jan 2024 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYYzCLpipmUwMgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 11:04:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-man@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Alejandro Colomar <alx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK
Date: Tue, 16 Jan 2024 12:04:18 +0100
Message-ID: <20240116110418.2577798-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.54
X-Spamd-Result: default: False [3.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.49%]
X-Spam-Flag: NO

Added in 079925cce1d0 ("net: allow SO_MARK with CAP_NET_RAW") in v5.17.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 man7/socket.7 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man7/socket.7 b/man7/socket.7
index 3ff8fe51b..3ebfc770b 100644
--- a/man7/socket.7
+++ b/man7/socket.7
@@ -614,7 +614,9 @@ Changing the mark can be used for mark-based
 routing without netfilter or for packet filtering.
 Setting this option requires the
 .B CAP_NET_ADMIN
-capability.
+or
+.B CAP_NET_RAW
+(since Linux 5.17) capability.
 .TP
 .B SO_OOBINLINE
 If this option is enabled,
-- 
2.43.0


