Return-Path: <linux-kernel+bounces-91964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6687191F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F164B2363C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433350272;
	Tue,  5 Mar 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lBeeAbK8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u1MMH9wn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LNEt80FI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFTIxbPd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468350248;
	Tue,  5 Mar 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629757; cv=none; b=C++JmpSidj4xOO+91Ce73PlwG3QEg1fj4b0ZTgzkXSkfZuibFUZTpn2d4H8qFISyJtUdMrhwW6CqXMhJgdWii4cZQ9xtb/RDxYy4Cth2DOxk7pZe4MSNZ5mh7WNEp68oUB5RGU2znZcnSWlAETEtPobWrJ7AbTJjFp7B5YJFY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629757; c=relaxed/simple;
	bh=6FtfTRMJ9KQpAFhbcdfJc+vgW9lBO5Msu+U0sj92YVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ud1vCBd6PU58WzKwQ4ZcfgZHuoc88xlPPhsZFWvWaAAD3rUh/6cAPORPhnGHZxIFl7QyxORbmynm3pBK7/SMAV2Hl3KLmoL61qlFK4C3Ob2CISNxiVOvB9i//bC07nIAeysFrqlB8EmM8J52p/lUiBgaZ0q0A9WR1cKpcUg7LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lBeeAbK8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u1MMH9wn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LNEt80FI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFTIxbPd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E10217666C;
	Tue,  5 Mar 2024 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Th/it1BW0cxTcajCDSkw5GZxs8x0WcNljdwQ9vEs7lk=;
	b=lBeeAbK8WH21FUjXt4+xWPPdaBMyQlk+8geYFgAgr6wlDdfbz2N/b8xKK6bRTfKBPj+izb
	oLpOpJUyWMPMX7+H1VeRvRYXeeCIPmFTGoCHJuE3F1rLPBX5rD3kqGnbehcUjaiHBXvz/C
	SHa5HKCsn6MDst7qeR1ABMIj3g6vMpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Th/it1BW0cxTcajCDSkw5GZxs8x0WcNljdwQ9vEs7lk=;
	b=u1MMH9wnxcZ0wFK6jJM6z+AuBVAgahh7+0oNB/fiVE6PKpaPHXMzQ9Q9lXwJO2dEbu5X3v
	40srVuxgoTli57Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Th/it1BW0cxTcajCDSkw5GZxs8x0WcNljdwQ9vEs7lk=;
	b=LNEt80FIoHdRKHjQtXk/OyAmCQLcdDvuGPhIzjDGGQldx7c/kgi0jEErD7GL7jLJpP6mMM
	spVPIrUMCwgWFKbX8XWUoU8w+eN19VyLjANQyAotYPricrf6rCDALyHHc8d/LcsfIFTRDp
	HzLq1L8/FaL54YRxqG0KxmiwaoSfTwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Th/it1BW0cxTcajCDSkw5GZxs8x0WcNljdwQ9vEs7lk=;
	b=wFTIxbPdteiwtr27ZfesXFwkCPaVGNcE62mfNw5etXaZeIk2VGTbJGE5phMf6vUdon7l2S
	JfPvw7ZH0x6E8nDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8034913466;
	Tue,  5 Mar 2024 09:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /8a2HTnh5mUSYgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 09:09:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mpe@ellerman.id.au,
	jani.nikula@intel.com,
	naresh.kamboju@linaro.org,
	deller@gmx.de,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/3] arch/powerpc: Resolve backlight include dependencies
Date: Tue,  5 Mar 2024 10:00:57 +0100
Message-ID: <20240305090910.26742-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LNEt80FI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wFTIxbPd
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.09 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.40)[90.88%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 2.09
X-Rspamd-Queue-Id: E10217666C
X-Spam-Flag: NO

After cleaning up <linux/fb.h> in commit 11b4eedfc87d ("fbdev: Do
not include <linux/backlight.h> in header"), building with
CONFIG_PMAC_BACKLIGHT=y returns errors about missing declarations.
Patches 1 and 2 resolve the errors. Patch 1 has been reviewed at [1].
Patch 3 removes another dependency between backlight and fbdev code.

Compile tested with ppc6xx_defconfig.

v2:
	* via-pmu-backlight: fix build errors
	* powerpc: resolve dependency between fbdev and backlight

[1] https://patchwork.freedesktop.org/series/130661/

Thomas Zimmermann (3):
  fbdev/chipsfb: Include <linux/backlight.h>
  macintosh/via-pmu-backlight: Include <linux/backlight.h>
  arch/powerpc: Remove <linux/fb.h> from backlight code

 arch/powerpc/include/asm/backlight.h        |  5 ++--
 arch/powerpc/platforms/powermac/backlight.c | 26 ---------------------
 drivers/macintosh/via-pmu-backlight.c       |  1 +
 drivers/video/fbdev/chipsfb.c               |  1 +
 4 files changed, 4 insertions(+), 29 deletions(-)

-- 
2.44.0


