Return-Path: <linux-kernel+bounces-93889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1300873664
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6671F24CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425680C08;
	Wed,  6 Mar 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ncXMa+EF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jq8LPHqS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ncXMa+EF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jq8LPHqS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BB80607;
	Wed,  6 Mar 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728186; cv=none; b=JlfZVn9BM/IN1FhZM1unihbJCOn54S1lO4+r/ju0YOIIphK3hms8bJFAsoq2ClxIRMkc9bHtMlS/hRlTLN/48CxI9s4n+zY8nBsu4e1i4uW80aPjhNNC2ygIHlOwXBLElarc4COOg1O4QYxPEBPwyJQu6cF7RlWpKlyAmGzPm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728186; c=relaxed/simple;
	bh=F0Tw4x4wxA83WbI8UtDAHqU2XXTBPLlZw3tIVOH5GOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbAKA0JMnNHqQ6aDHwUvABMjPPM3+ZvRbbOoV7mY7+FaTxZhRyQoBsn9k8AhKJi32W8mpqMvtVkmFad83RS1m6d4AA/9CSQt2vMFs3NqzEQk2pFAHpny72IbJV1fuXVfyggDcfMuzXxZY2lZ8ToCj7e6+g8LKqhShN1eehvlZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ncXMa+EF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jq8LPHqS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ncXMa+EF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jq8LPHqS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C5754ED4B;
	Wed,  6 Mar 2024 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=299andLo8CD0Xa8La9on+/jSs0H+mryiPZNMgllG54Y=;
	b=ncXMa+EFJ3AZfkV5rm6p7jlw5ccVC5/iTPzRn5ZKlaR19gDmgaKmoSjuM3mrdTzneHWPC9
	d8ViQlAJ2M2VZ0hlsAD+dc5nz9ghW+feYmDV9GYWxPCBMpAjDxDUk6+HojBk3/S6tZ8lRZ
	2ei7vEo+kK3366uHRh3QUtIP3qGyGWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=299andLo8CD0Xa8La9on+/jSs0H+mryiPZNMgllG54Y=;
	b=Jq8LPHqSatrU8uU98u9cNckJrMxKHfSp+CTvTAa4kS1axoUAYJNcT29or2pa85+pvstrw1
	jCwEuaHNDQ9+WSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=299andLo8CD0Xa8La9on+/jSs0H+mryiPZNMgllG54Y=;
	b=ncXMa+EFJ3AZfkV5rm6p7jlw5ccVC5/iTPzRn5ZKlaR19gDmgaKmoSjuM3mrdTzneHWPC9
	d8ViQlAJ2M2VZ0hlsAD+dc5nz9ghW+feYmDV9GYWxPCBMpAjDxDUk6+HojBk3/S6tZ8lRZ
	2ei7vEo+kK3366uHRh3QUtIP3qGyGWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=299andLo8CD0Xa8La9on+/jSs0H+mryiPZNMgllG54Y=;
	b=Jq8LPHqSatrU8uU98u9cNckJrMxKHfSp+CTvTAa4kS1axoUAYJNcT29or2pa85+pvstrw1
	jCwEuaHNDQ9+WSAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC781377D;
	Wed,  6 Mar 2024 12:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KIkWOLZh6GWdTgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 06 Mar 2024 12:29:42 +0000
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
Subject: [PATCH v3 3/3] arch/powerpc: Remove <linux/fb.h> from backlight code
Date: Wed,  6 Mar 2024 13:28:20 +0100
Message-ID: <20240306122935.10626-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306122935.10626-1-tzimmermann@suse.de>
References: <20240306122935.10626-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL9wq65f3r6cge75md5ma8xy98)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Replace <linux/fb.h> with a forward declaration in <asm/backlight.h> to
resolve an unnecessary dependency. Remove pmac_backlight_curve_lookup()
and struct fb_info from source and header files. The function and the
framebuffer struct are unused. No functional changes.

v3:
	* Add Fixes tag (Christophe)
	* fix typos in commit message (Jani)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d565dd3b0824 ("[PATCH] powerpc: More via-pmu backlight fixes")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 arch/powerpc/include/asm/backlight.h        |  5 ++--
 arch/powerpc/platforms/powermac/backlight.c | 26 ---------------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
index 1b5eab62ed047..061a910d74929 100644
--- a/arch/powerpc/include/asm/backlight.h
+++ b/arch/powerpc/include/asm/backlight.h
@@ -10,15 +10,14 @@
 #define __ASM_POWERPC_BACKLIGHT_H
 #ifdef __KERNEL__
 
-#include <linux/fb.h>
 #include <linux/mutex.h>
 
+struct backlight_device;
+
 /* For locking instructions, see the implementation file */
 extern struct backlight_device *pmac_backlight;
 extern struct mutex pmac_backlight_mutex;
 
-extern int pmac_backlight_curve_lookup(struct fb_info *info, int value);
-
 extern int pmac_has_backlight_type(const char *type);
 
 extern void pmac_backlight_key(int direction);
diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index aeb79a8b3e109..12bc01353bd3c 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
@@ -72,31 +71,6 @@ int pmac_has_backlight_type(const char *type)
 	return 0;
 }
 
-int pmac_backlight_curve_lookup(struct fb_info *info, int value)
-{
-	int level = (FB_BACKLIGHT_LEVELS - 1);
-
-	if (info && info->bl_dev) {
-		int i, max = 0;
-
-		/* Look for biggest value */
-		for (i = 0; i < FB_BACKLIGHT_LEVELS; i++)
-			max = max((int)info->bl_curve[i], max);
-
-		/* Look for nearest value */
-		for (i = 0; i < FB_BACKLIGHT_LEVELS; i++) {
-			int diff = abs(info->bl_curve[i] - value);
-			if (diff < max) {
-				max = diff;
-				level = i;
-			}
-		}
-
-	}
-
-	return level;
-}
-
 static void pmac_backlight_key_worker(struct work_struct *work)
 {
 	if (atomic_read(&kernel_backlight_disabled))
-- 
2.44.0


