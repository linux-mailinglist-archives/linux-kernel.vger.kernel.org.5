Return-Path: <linux-kernel+bounces-91966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E2871925
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B012E2815D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C7535D1;
	Tue,  5 Mar 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QnBJQA2n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2F+l6XZM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QnBJQA2n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2F+l6XZM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE495535C9;
	Tue,  5 Mar 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629764; cv=none; b=BFzwuJbJE9tofu2+v09kEy+1fE2j148qX0QjtKbzyyGiy/UGrOZCKkbK0zIie8U8Csh/JSOsayaYexNXzxMV0AcsF6goLt3/HzOtHQTv3N3KRkSY/g2aGJ64w8WzmFWtzezilEYg1noRhK4mTWvBygtb1j1+I6ptRt/2ZoOEoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629764; c=relaxed/simple;
	bh=8Lkl4Si1asQHpruqgjj3piZ8d7tWQgURRd+L2SuQxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLHamv2+lyEqf3lTUDdiHxadr4ImFcogqgEpYtUjcp6qeRM1b2n354uBsWum2dcT05PuGAASEugqJiPmBT10glDHeSw12gCvDrAPQKzC/ndqkoHAdKWuTbn/brjPu0GGecXhyF+pdrHbPd9p2DtRgY2TFdAwXhm+AU5r4S4rghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QnBJQA2n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2F+l6XZM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QnBJQA2n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2F+l6XZM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0D436AA10;
	Tue,  5 Mar 2024 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjfceeBfyy7bCVAVt6TqVozzxlZE0IXGwuqMlWRkHUk=;
	b=QnBJQA2nUrp8dzIPoSSVe0IpmtRPFdKGKslIeW74PpT1Jt2jwzN6yeSEBiRxccg/+ZOWIk
	8TkQxD36IDFi2zd0augrYDE0Wi4uFZ3DTXoELLygYxasb5JD9yl3Kc4+sW2vfeM0A54Uho
	YBATQW3EpgEfOJdPxqIxoeMsC5drnzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjfceeBfyy7bCVAVt6TqVozzxlZE0IXGwuqMlWRkHUk=;
	b=2F+l6XZM5TNBe5X47J/G+QZwCLmy+O+RzRxRIm8OA8trntbke7PKjT18DX1cuWFkjjl9Qk
	Xaw2TexyjEc0wcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjfceeBfyy7bCVAVt6TqVozzxlZE0IXGwuqMlWRkHUk=;
	b=QnBJQA2nUrp8dzIPoSSVe0IpmtRPFdKGKslIeW74PpT1Jt2jwzN6yeSEBiRxccg/+ZOWIk
	8TkQxD36IDFi2zd0augrYDE0Wi4uFZ3DTXoELLygYxasb5JD9yl3Kc4+sW2vfeM0A54Uho
	YBATQW3EpgEfOJdPxqIxoeMsC5drnzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjfceeBfyy7bCVAVt6TqVozzxlZE0IXGwuqMlWRkHUk=;
	b=2F+l6XZM5TNBe5X47J/G+QZwCLmy+O+RzRxRIm8OA8trntbke7PKjT18DX1cuWFkjjl9Qk
	Xaw2TexyjEc0wcCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D87A13466;
	Tue,  5 Mar 2024 09:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2ByzETrh5mUSYgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 09:09:14 +0000
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
Subject: [PATCH v2 2/3] macintosh/via-pmu-backlight: Include <linux/backlight.h>
Date: Tue,  5 Mar 2024 10:00:59 +0100
Message-ID: <20240305090910.26742-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305090910.26742-1-tzimmermann@suse.de>
References: <20240305090910.26742-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QnBJQA2n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2F+l6XZM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.57 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLmtuucniqwipafy9wqm5c37x8)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.92)[99.64%];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email,gmx.de:email,linaro.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 0.57
X-Rspamd-Queue-Id: C0D436AA10
X-Spam-Flag: NO

Fix builds with CONFIG_PMAC_BACKLIGHT=y. The include statement for the
backlight header has recently been removed from <linux/fb.h>. Add it to
via-pmu-backlight.c to get the necessary symbols.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/dri-devel/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/macintosh/via-pmu-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index c2d87e7fa85be..89450645c2305 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -10,6 +10,7 @@
 
 #include <asm/ptrace.h>
 #include <linux/adb.h>
+#include <linux/backlight.h>
 #include <linux/pmu.h>
 #include <asm/backlight.h>
 
-- 
2.44.0


