Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78EC78C762
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjH2OVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjH2OVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D4198;
        Tue, 29 Aug 2023 07:21:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F12D1F38C;
        Tue, 29 Aug 2023 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693318889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdv0cLQ6j1TsZQmdczOCC46tJyhpJPozzqmzgQ+pW6I=;
        b=ahtn3VTrCuEHEHObH9V07adWKUxOD5bT2xSCSmrvZh0U+l9975MToLLrl/EoeWxNEz1HIL
        YTmm3zzX1tSIIN6lRaKVHE/83wX2OarloMohDtUZkoymUm+hEtayyCVuSJHkmZdDu40PdZ
        hzgFEtzx1jC2LAcCIa7yxU+bTVd6HlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693318889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdv0cLQ6j1TsZQmdczOCC46tJyhpJPozzqmzgQ+pW6I=;
        b=lEMwenznQ1/v0CjQSH863yJS+JL0tQVj7OoxDI7yAydKvURMQWCC8TIZgEQVv9VEUpU+3U
        OMF/wDwxrA03yzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3868B13909;
        Tue, 29 Aug 2023 14:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHLiDOn+7WREewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 29 Aug 2023 14:21:29 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/7] fbdev/core: Fix style of code for boot-up logo
Date:   Tue, 29 Aug 2023 16:15:42 +0200
Message-ID: <20230829142109.4521-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829142109.4521-1-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a number of warnings from checkpatch.pl in this code before
moving it into a separate file. This includes

 * Prefer 'unsigned int' to bare use of 'unsigned'
 * space required after that ',' (ctx:VxV)
 * space prohibited after that open parenthesis '('
 * suspect code indent for conditional statements (16, 32)
 * braces {} are not necessary for single statement blocks

No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ee44a46a66be..98e1847e4287 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -186,7 +186,7 @@ EXPORT_SYMBOL(fb_get_buffer_offset);
 
 #ifdef CONFIG_LOGO
 
-static inline unsigned safe_shift(unsigned d, int n)
+static inline unsigned int safe_shift(unsigned int d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
 }
@@ -229,7 +229,9 @@ static void  fb_set_logo_truepalette(struct fb_info *info,
 					    const struct linux_logo *logo,
 					    u32 *palette)
 {
-	static const unsigned char mask[] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
+	static const unsigned char mask[] = {
+		0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff
+	};
 	unsigned char redmask, greenmask, bluemask;
 	int redshift, greenshift, blueshift;
 	int i;
@@ -247,7 +249,7 @@ static void  fb_set_logo_truepalette(struct fb_info *info,
 	greenshift = info->var.green.offset - (8 - info->var.green.length);
 	blueshift  = info->var.blue.offset  - (8 - info->var.blue.length);
 
-	for ( i = 0; i < logo->clutsize; i++) {
+	for (i = 0; i < logo->clutsize; i++) {
 		palette[i+32] = (safe_shift((clut[0] & redmask), redshift) |
 				 safe_shift((clut[1] & greenmask), greenshift) |
 				 safe_shift((clut[2] & bluemask), blueshift));
@@ -371,7 +373,7 @@ static void fb_rotate_logo_cw(const u8 *in, u8 *out, u32 width, u32 height)
 
 	for (i = 0; i < height; i++)
 		for (j = 0; j < width; j++)
-				out[height * j + h - i] = *in++;
+			out[height * j + h - i] = *in++;
 }
 
 static void fb_rotate_logo_ccw(const u8 *in, u8 *out, u32 width, u32 height)
@@ -636,9 +638,8 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
 
-	if (!fb_logo.logo) {
+	if (!fb_logo.logo)
 		return 0;
-	}
 
 	if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD)
 		yres = info->var.yres;
-- 
2.41.0

