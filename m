Return-Path: <linux-kernel+bounces-93886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E9873660
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E725B22926
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5E80632;
	Wed,  6 Mar 2024 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s7NL1SeH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E328/abI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="URDeu/hI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VLzGhH1D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308480034;
	Wed,  6 Mar 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728186; cv=none; b=JrH7Ft9uaESKRZUbmImCCZJ5JHGKw6MGOVeFalFoqvEKD8A/+WbJ7Y36EmFnSuq6/1bxUuKyMqb680wFDwyM9bj84bgINl8G4dYmgefNVmP4KCQnl73yIaZXjLycVDdQd8hrdzu7zzU5VfCkqylclGQHC3KGvVOJN28w3pafeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728186; c=relaxed/simple;
	bh=Yt+ho94pR60luKjtRmzjBa884MCPJnkc5KLlQn2SxNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ca44BzeJEzImJ2ndZBg+vflJ9Mq0Xryt1a41IKYc6+/0XIiSosTV8ybJDhgL9rCYSnigf+bu00uq+Xp6waFBH6Uogj4OOqTN6BOSiuM9dVB1H/4RsxviTSsgdhM5jUW3n1TMzkvUMZnV7PdzjpaXFaSyytT2S73YZrSTMojJKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s7NL1SeH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E328/abI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=URDeu/hI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VLzGhH1D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8306F4ED40;
	Wed,  6 Mar 2024 12:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zluc5pdwJo1X5Y/YYPNxWSl6vvjmlAN09PftLZOSlFU=;
	b=s7NL1SeHWkF2MbeTlPKqQvm95tz3aoqI2G9lDHzeXkJsnwrnQI7vwvEbFf4QMWaGRWRODx
	H2FIztmYi2AXTnuSQ9d7Qb3C0A+C/in4mHKsiKKdlnycGTCWnUtg90g/ED7H+j5bml4Cc9
	s/oCqv7Bqiwo5KhRmdWzGJ8lMrV2uqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zluc5pdwJo1X5Y/YYPNxWSl6vvjmlAN09PftLZOSlFU=;
	b=E328/abIB3tFTOP6OXZ6hhUDJebGKd7aPjZMUzqkPeuagY2oqMhzDEs6MwbCv3ZE76f+wD
	J0Idh9PMsta+bgBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zluc5pdwJo1X5Y/YYPNxWSl6vvjmlAN09PftLZOSlFU=;
	b=URDeu/hI/Zn02IV37ksOM9LCOfTbuQG06F0Hfd3pNkwydo2ILv/fHvjsNKw8m0NEXy0mni
	2eHlmrB1XiSSWgDOFIan2geuceVjWRykzdaKFw1W81jxIAzMCnx+lpsFsfoh/1aFOqMo0o
	IiY6p7x18yXLVdEy6xJD3Sm/W/mqti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zluc5pdwJo1X5Y/YYPNxWSl6vvjmlAN09PftLZOSlFU=;
	b=VLzGhH1DuXcZrVbxUMRIZC6ogdcZerr3MLWzPtHJEV32tN+D/nnh/2wJ9RIaeDOiLAdm2/
	HCSyZzUc8zdk/+CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B661377D;
	Wed,  6 Mar 2024 12:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oRTxKrRh6GWdTgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 06 Mar 2024 12:29:40 +0000
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
Subject: [PATCH v3 0/3] arch/powerpc: Resolve backlight include dependencies
Date: Wed,  6 Mar 2024 13:28:17 +0100
Message-ID: <20240306122935.10626-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.71)[83.48%]
X-Spam-Level: ****
X-Spam-Score: 4.19
X-Spam-Flag: NO

After cleaning up <linux/fb.h> in commit 11b4eedfc87d ("fbdev: Do
not include <linux/backlight.h> in header"), building with
CONFIG_PMAC_BACKLIGHT=y returns errors about missing declarations.
Patches 1 and 2 resolve the errors. Patch 1 has been reviewed at [1].
Patch 3 removes another dependency between backlight and fbdev code.

Compile tested with ppc6xx_defconfig.

v3:
	* add Fixes tag and fix typos in patch 3
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


