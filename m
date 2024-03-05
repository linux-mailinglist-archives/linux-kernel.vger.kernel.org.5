Return-Path: <linux-kernel+bounces-91965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F16871921
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709CE1F2413E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF953365;
	Tue,  5 Mar 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1e7CU13W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v++BykxR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1e7CU13W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v++BykxR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C252F8E;
	Tue,  5 Mar 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629763; cv=none; b=etOLzS15rXxOQaCm272tzk9zIeu5imiaGYix9eDWRvj8gqYYKQi148dvtiGtwSn1btKWmF2N+UoPm9Z/LwLIMBrKcQYYPKVMQyaAXtuOnPrkHXcUSlWjC/iVXlhH+4mTPxCLPDhbLMlV75L/vOt2LuwnfWG6f1smFdMe2uVjc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629763; c=relaxed/simple;
	bh=Qm+mvyacA6IB95N2ZbCQlA5B0CigtDgyPgYGCOpYecw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJQWf0kUq1XSoj7X/RkRCd8CFjxIeLwHJ0Gzpm5Ctlow82b07DyPumkPeQB0jRRDaI39YPCGj/3xRc+WpSuQQEDJK68voE2Ic8l/uIx+N/tCFmTFGFtiUOpb9ENszFZByny3d1aZo2VPA3a2nSjCAHktqwP4dmmS6sU8pceJdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1e7CU13W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v++BykxR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1e7CU13W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v++BykxR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 472E36AA13;
	Tue,  5 Mar 2024 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5y5vALtoA58bwzW2myIJAAwvG2BEvs2NWDoyJ95gbyc=;
	b=1e7CU13Wen/0WuTbcb8crIxc3m7B7RdIAmVQbh/odyPbheUyNaq8lt9Q2tLJ1lQor7Fwrw
	Sk2lZjkBgH1bxCuftW6ojTYxdYcZwrMB+05KZuhkBeSuXTufNWr29cPJ70uEWY8MnwvpDs
	GacOVjHiFl2EAw4Exj8m32q7XMSwUMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5y5vALtoA58bwzW2myIJAAwvG2BEvs2NWDoyJ95gbyc=;
	b=v++BykxR9KyTTK4FfuWrq6aIV8K9b0KsixB1j7Lz1yLp3Uxm09tALR1+z60Bj5UGOy9wq8
	hIXpGlyV8/cBSICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5y5vALtoA58bwzW2myIJAAwvG2BEvs2NWDoyJ95gbyc=;
	b=1e7CU13Wen/0WuTbcb8crIxc3m7B7RdIAmVQbh/odyPbheUyNaq8lt9Q2tLJ1lQor7Fwrw
	Sk2lZjkBgH1bxCuftW6ojTYxdYcZwrMB+05KZuhkBeSuXTufNWr29cPJ70uEWY8MnwvpDs
	GacOVjHiFl2EAw4Exj8m32q7XMSwUMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5y5vALtoA58bwzW2myIJAAwvG2BEvs2NWDoyJ95gbyc=;
	b=v++BykxR9KyTTK4FfuWrq6aIV8K9b0KsixB1j7Lz1yLp3Uxm09tALR1+z60Bj5UGOy9wq8
	hIXpGlyV8/cBSICQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E175013A8A;
	Tue,  5 Mar 2024 09:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QFrBNTnh5mUSYgAAn2gu4w
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
Subject: [PATCH v2 1/3] fbdev/chipsfb: Include <linux/backlight.h>
Date: Tue,  5 Mar 2024 10:00:58 +0100
Message-ID: <20240305090910.26742-2-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,gmx.de:email,linaro.org:email];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.40)[97.27%]
X-Spam-Flag: NO

Fix builds with CONFIG_PMAC_BACKLIGHT=y. The include statement for
the backlight header has recently been removed from <linux/fb.h>.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/dri-devel/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/chipsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index b80711f13df8a..b16a905588fed 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/backlight.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-- 
2.44.0


