Return-Path: <linux-kernel+bounces-100813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4AC879D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FA7283493
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24D143740;
	Tue, 12 Mar 2024 21:39:14 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D44CDE0;
	Tue, 12 Mar 2024 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279554; cv=none; b=EXwOpLp4knaiArh4dBR7OBXF4to6y403m1kB20skn5o9aVnjuRInqV+BPNvKGEVdcXgXJ/ixRp9FbqC0cpRVOfxXXQIjlHYOvxDvsOro2lf1ciHqN0w/CDdU1l0c0QB7cVCKaozHbHcOPaau3aLShDR9tKMX5Cka9E78x1AVq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279554; c=relaxed/simple;
	bh=jCOUl/hgH4m5xXQ4Gf/fSkRvMuN269rszqvSe0P/8zE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ql2uXgWMDao/ejTiFbI5Zx7CkoeXZvPKgj5C+FohHfxdwEJss6oM4+t1uM73KiB57DIXBsjCjAapLDYR6OILUHMP7GGmIMmsmt8qTe8KQ0jK0XS4xgB1KH6z50Q2LFfD+cfz7dISWO8wDo6rPgWkNAaf5Ygkq8ZeyschnKVfe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 70816A034B;
	Tue, 12 Mar 2024 22:39:03 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lKQgqEeYEGbq; Tue, 12 Mar 2024 22:39:03 +0100 (CET)
Received: from begin.home (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1ECC4A02D1;
	Tue, 12 Mar 2024 22:39:03 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rk9pu-000000076so-2s5z;
	Tue, 12 Mar 2024 22:39:02 +0100
Date: Tue, 12 Mar 2024 22:39:02 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbcon: Increase maximum font width x height to 64 x 64
Message-ID: <20240312213902.3zvqaghlopjusv6m@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)

This remains relatively simple by just enlarging integers.

It wouldn't be that simple to get to the console's 64x128 maximum, as it would
require 128b integers.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-6.4/drivers/video/fbdev/core/fbcon.c
===================================================================
--- linux-6.4.orig/drivers/video/fbdev/core/fbcon.c
+++ linux-6.4/drivers/video/fbdev/core/fbcon.c
@@ -101,6 +101,9 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
+#define FBCON_MAX_FONT_WIDTH	(sizeof(((struct fb_pixmap *) 0)->blit_x) * 8)
+#define FBCON_MAX_FONT_HEIGHT	(sizeof(((struct fb_pixmap *) 0)->blit_y) * 8)
+
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
 struct fb_info *fbcon_registered_fb[FB_MAX];
@@ -2485,12 +2488,12 @@ static int fbcon_set_font(struct vc_data
 	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
 		return -EINVAL;
 
-	if (font->width > 32 || font->height > 32)
+	if (font->width > FBCON_MAX_FONT_WIDTH || font->height > FBCON_MAX_FONT_HEIGHT)
 		return -EINVAL;
 
 	/* Make sure drawing engine can handle the font */
-	if (!(info->pixmap.blit_x & BIT(font->width - 1)) ||
-	    !(info->pixmap.blit_y & BIT(font->height - 1)))
+	if (!(info->pixmap.blit_x & BIT_ULL(font->width - 1)) ||
+	    !(info->pixmap.blit_y & BIT_ULL(font->height - 1)))
 		return -EINVAL;
 
 	/* Make sure driver can handle the font length */
@@ -3084,8 +3087,8 @@ void fbcon_get_requirement(struct fb_inf
 			vc = vc_cons[i].d;
 			if (vc && vc->vc_mode == KD_TEXT &&
 			    info->node == con2fb_map[i]) {
-				caps->x |= 1 << (vc->vc_font.width - 1);
-				caps->y |= 1 << (vc->vc_font.height - 1);
+				caps->x |= 1ULL << (vc->vc_font.width - 1);
+				caps->y |= 1ULL << (vc->vc_font.height - 1);
 				charcnt = vc->vc_font.charcount;
 				if (caps->len < charcnt)
 					caps->len = charcnt;
@@ -3096,8 +3099,8 @@ void fbcon_get_requirement(struct fb_inf
 
 		if (vc && vc->vc_mode == KD_TEXT &&
 		    info->node == con2fb_map[fg_console]) {
-			caps->x = 1 << (vc->vc_font.width - 1);
-			caps->y = 1 << (vc->vc_font.height - 1);
+			caps->x = 1ULL << (vc->vc_font.width - 1);
+			caps->y = 1ULL << (vc->vc_font.height - 1);
 			caps->len = vc->vc_font.charcount;
 		}
 	}
Index: linux-6.4/include/linux/fb.h
===================================================================
--- linux-6.4.orig/include/linux/fb.h
+++ linux-6.4/include/linux/fb.h
@@ -143,8 +143,8 @@ struct fb_event {
 };
 
 struct fb_blit_caps {
-	u32 x;
-	u32 y;
+	u64 x;
+	u64 y;
 	u32 len;
 	u32 flags;
 };
@@ -191,10 +191,10 @@ struct fb_pixmap {
 	u32 scan_align;		/* alignment per scanline		*/
 	u32 access_align;	/* alignment per read/write (bits)	*/
 	u32 flags;		/* see FB_PIXMAP_*			*/
-	u32 blit_x;             /* supported bit block dimensions (1-32)*/
-	u32 blit_y;             /* Format: blit_x = 1 << (width - 1)    */
+	u64 blit_x;             /* supported bit block dimensions (1-64)*/
+	u64 blit_y;             /* Format: blit_x = 1 << (width - 1)    */
 	                        /*         blit_y = 1 << (height - 1)   */
-	                        /* if 0, will be set to 0xffffffff (all)*/
+	                        /* if 0, will be set to ~0ull (all)     */
 	/* access methods */
 	void (*writeio)(struct fb_info *info, void __iomem *dst, void *src, unsigned int size);
 	void (*readio) (struct fb_info *info, void *dst, void __iomem *src, unsigned int size);

