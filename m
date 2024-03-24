Return-Path: <linux-kernel+bounces-112878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A459887F73
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D3E2811B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F03D967;
	Sun, 24 Mar 2024 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QHl15LKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zDkYXSwc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QHl15LKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zDkYXSwc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01E18638;
	Sun, 24 Mar 2024 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318896; cv=none; b=rtLiowpdq/YCOcLOjuVlfetvwjUu33AqnJDKUceX+9+aDI3NlAS4eAodSRPwmXTpucfRO7Ie7zig7o+B9iFRO+bARQ6RgPG7bqNGOa6e1qenRuAAn343Kg2IGQF/2rF21UR/7P/viQwLNrkxgWOi1aryCitBns7MIuCgJcU3SEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318896; c=relaxed/simple;
	bh=+ASgVRvQKrRO6vd7heqIOrfqPHwgmRlRMnaiQ9C9BII=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=GEBDlq+FtKR7wwxddi0awYQycvVGM9tnbbGzLdSK/hPcnNzmpeFTBlTgYy6eGftaCRLbZMHrUuPOt0XNtErfQleHhB8mDDq8FtVHE3GMcHs+B6IFOPQKdddF3Qy1X4ckHUIomtgDOSDC/xbsmaf4yqOznU7ScbfVefLOd5KRMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QHl15LKF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zDkYXSwc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QHl15LKF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zDkYXSwc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8996E3494D;
	Sun, 24 Mar 2024 22:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711318886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q22e8y7gYn1Cil1GqA4W9UMt88586a/ZvqqOpFe5eJU=;
	b=QHl15LKFyv2F1CDKyizBVU1kPj0PEOHci3OiPUxZVjZQCzVfGGMQVFib2uOINDsMwIN7AY
	e2T9lpWdUz4pQ6xbuJfKl5+MPTCAmzcqB6wm4xpLCRbrINUNYGhzT7e07Yk6ZuzNZsk4K1
	iSjnZlpjlwwtChLQx9n3sp1VHb8W504=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711318886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q22e8y7gYn1Cil1GqA4W9UMt88586a/ZvqqOpFe5eJU=;
	b=zDkYXSwcbnYrKLWV/7xCzOph6v2kGdCvyA1l5uBM2ICCgUrrjBeBrpNH9OtQ+poHwOnIqI
	zqaH3i6kwZ8UTECQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711318886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q22e8y7gYn1Cil1GqA4W9UMt88586a/ZvqqOpFe5eJU=;
	b=QHl15LKFyv2F1CDKyizBVU1kPj0PEOHci3OiPUxZVjZQCzVfGGMQVFib2uOINDsMwIN7AY
	e2T9lpWdUz4pQ6xbuJfKl5+MPTCAmzcqB6wm4xpLCRbrINUNYGhzT7e07Yk6ZuzNZsk4K1
	iSjnZlpjlwwtChLQx9n3sp1VHb8W504=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711318886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q22e8y7gYn1Cil1GqA4W9UMt88586a/ZvqqOpFe5eJU=;
	b=zDkYXSwcbnYrKLWV/7xCzOph6v2kGdCvyA1l5uBM2ICCgUrrjBeBrpNH9OtQ+poHwOnIqI
	zqaH3i6kwZ8UTECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A32513695;
	Sun, 24 Mar 2024 22:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JmE+N2OnAGZXMwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Mar 2024 22:21:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org , linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE
Date: Mon, 25 Mar 2024 09:21:20 +1100
Message-id: <171131888022.13576.8585118457506044105@noble.neil.brown.name>
X-Spam-Score: -3.77
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.26)[73.52%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QHl15LKF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zDkYXSwc
X-Rspamd-Queue-Id: 8996E3494D


The page has been marked clean before writepage is called.  If we don't
redirty it before postponing the write, it might never get written.

Fixes: 503d4fa6ee28 ("ceph: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ceph/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1340d77124ae..ee9caf7916fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -795,8 +795,10 @@ static int ceph_writepage(struct page *page, struct writ=
eback_control *wbc)
 	ihold(inode);
=20
 	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested)
+	    ceph_inode_to_fs_client(inode)->write_congested) {
+		redirty_page_for_writepage(wbc, page);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
=20
 	wait_on_page_fscache(page);
=20
--=20
2.44.0


