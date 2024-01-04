Return-Path: <linux-kernel+bounces-16884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C78824560
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F57281E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC94249FC;
	Thu,  4 Jan 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9oeW69w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m3rjxr3A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9oeW69w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m3rjxr3A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAE249EA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 797D721F99;
	Thu,  4 Jan 2024 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmymyCdJqhE7lvGyQ/U+jDRmgdp8zZNu5g0goaB4f9Q=;
	b=s9oeW69waYwtinxTXT9igLKj+PYXScCxrOgUpzWY/OHgPV5HEMeEs8gmyw+PJX+ujhBzrb
	2YsVN+PkHtLJZRt/rcH1EZiritAMjNB74imCnvj2HPlTiGCPTSzOKTQf/blsRXqPjDbu5r
	Zt+9TcTGULrNhe5v1yNKkQXECYAtN1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmymyCdJqhE7lvGyQ/U+jDRmgdp8zZNu5g0goaB4f9Q=;
	b=m3rjxr3ANhsHS0IyarbX4KwihBlUUM/0bytFxdVaOAi3JVZ2h7txU+YUV66FRdPWBvzsWp
	UuEGgEuX3LPJkkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmymyCdJqhE7lvGyQ/U+jDRmgdp8zZNu5g0goaB4f9Q=;
	b=s9oeW69waYwtinxTXT9igLKj+PYXScCxrOgUpzWY/OHgPV5HEMeEs8gmyw+PJX+ujhBzrb
	2YsVN+PkHtLJZRt/rcH1EZiritAMjNB74imCnvj2HPlTiGCPTSzOKTQf/blsRXqPjDbu5r
	Zt+9TcTGULrNhe5v1yNKkQXECYAtN1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AmymyCdJqhE7lvGyQ/U+jDRmgdp8zZNu5g0goaB4f9Q=;
	b=m3rjxr3ANhsHS0IyarbX4KwihBlUUM/0bytFxdVaOAi3JVZ2h7txU+YUV66FRdPWBvzsWp
	UuEGgEuX3LPJkkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 178B313722;
	Thu,  4 Jan 2024 15:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yMvfA6TTlmUaVQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 15:49:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Richard Palethorpe <io@richiejp.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Wanlong Gao <wanlong.gao@easystack.cn>,
	Wanlong Gao <wanlong.gao@gmail.com>,
	Jan Stancek <jstancek@redhat.com>,
	Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
	Li Wang <liwang@redhat.com>,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ltp@lists.linux.it
Subject: [PATCH 1/1] MAINTAINERS: Update LTP maintainers
Date: Thu,  4 Jan 2024 16:49:53 +0100
Message-ID: <20240104154953.1193634-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 6.20
X-Spam-Level: ******
X-Spam-Flag: NO
X-Spamd-Result: default: False [6.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[fujitsu.com:email,linux.it:email,oracle.com:email,linux-test-project.github.io:url,suse.cz:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL6766gqedkkozkf7ued5wo4kc)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[43.19%];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,richiejp.com,bell-sw.com,gentoo.org,easystack.cn,gmail.com,redhat.com,fujitsu.com,linux-foundation.org,lists.linux.it];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

There are more people with git push permissions, but we keep only people
who actually did review and merge patches last year.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

for these interested, active committers found with:
git shortlog 20230127..

Yang Xu is still active as reviewer (last: 28 Nov 2023).

Richie announced us know in private email, that he would not be able to
work on LTP any more due job change, thus I'm not adding him.
Thanks Richie, you did amazing work, your contribution will be missed!

Kind regards,
Petr

 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45b7b2046c10..ef735805917a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12596,12 +12596,11 @@ F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
 LTP (Linux Test Project)
-M:	Mike Frysinger <vapier@gentoo.org>
 M:	Cyril Hrubis <chrubis@suse.cz>
-M:	Wanlong Gao <wanlong.gao@gmail.com>
 M:	Jan Stancek <jstancek@redhat.com>
-M:	Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
-M:	Alexey Kodanev <alexey.kodanev@oracle.com>
+M:	Petr Vorel <pvorel@suse.cz>
+M:	Li Wang <liwang@redhat.com>
+M:	Yang Xu <xuyang2018.jy@fujitsu.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
 W:	http://linux-test-project.github.io/
-- 
2.43.0


