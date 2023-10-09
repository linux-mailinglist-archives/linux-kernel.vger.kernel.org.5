Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC067BE9B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378135AbjJIShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378161AbjJIShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2FBA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gALg4BuzDzCCCf3P05cRSMli/frUwAArjCkEkdq6b1A=;
        b=fQwC0Ds4FqNWCrHTCfYdKe2jIEgyxA/wwBviRNELkDTMuKARnb4MD2qMmp0DCeKcT5xM7p
        CbE4vvwymyZk8TfCyWFQqEwi0dUOAEsad8PXWKsK0iiTfGsuyKedsO19/UtRuEILnbiKJQ
        yA8shttz2Krw2d/MKJrU/9Ekv9AsY1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-yCexfcQ5MXKWHHX38_mBcw-1; Mon, 09 Oct 2023 14:36:05 -0400
X-MC-Unique: yCexfcQ5MXKWHHX38_mBcw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3296bd73d91so2050804f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876563; x=1697481363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gALg4BuzDzCCCf3P05cRSMli/frUwAArjCkEkdq6b1A=;
        b=UkdMku92zn4gX1ixqfFC8SAHwDnFu9kNylTeW2om2KowHRSeYFbQ8XYB/iOtCDsqbi
         p83CsGFhMIl7wYzzTenAlyqMomAf/p8I8QhNbMSbXE2yC8pH8cxwFMFdwOAfDMpa9o3o
         teLx5TgfENN7t9Ifx8MFF88wGsqoclr3zFqQfMzo8G/bu71ih4Q47KuYryt+gBwmb8/J
         CLINF9yCSwmVPH7hKsmeOLgPNnj63nsQ8OPRc2xTojPUcfn6UCWKKfRhi8GPcp/DrS8j
         Ppe4lMaL7vK2UIKbHs1t2Cu+on+Kg2TH7SqhI9DaV/ytCvURY3Xj/vA0WkxaFNlm4dv+
         rywA==
X-Gm-Message-State: AOJu0YxKjua68Td99MXM9bnRqASIUZ/lOq48ZQpyRUjbPfI3IKsmGBcy
        W70Z+tJdtadkPVkwPGzDYYZO5MZwDYVFi8HThbKn+LI5kHWT0iEKG2HHTvuYIaiT4VadM9MxuGG
        GBbHIB3WFIfn3/D0LQBUg8C5TqBmZM+JIuz1b2sIGZj+XST0BgO6ePzLJkh7XLz4nIzY45QDb+0
        FlwGzrFd0=
X-Received: by 2002:a05:6000:1e08:b0:329:6662:ac1d with SMTP id bj8-20020a0560001e0800b003296662ac1dmr11185855wrb.24.1696876563002;
        Mon, 09 Oct 2023 11:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJPV6fQzltcRPHfYUiuUATolHxklI0ViN4dcGzNMpNc2h6oW6hYsnrP1UmTcgV1MSDxmuGw==
X-Received: by 2002:a05:6000:1e08:b0:329:6662:ac1d with SMTP id bj8-20020a0560001e0800b003296662ac1dmr11185837wrb.24.1696876562733;
        Mon, 09 Oct 2023 11:36:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b003296b913bbesm9770081wrd.12.2023.10.09.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/8] drm/ssd13xx: Replace .page_height field in device info with a constant
Date:   Mon,  9 Oct 2023 20:34:17 +0200
Message-ID: <20231009183522.543918-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183522.543918-1-javierm@redhat.com>
References: <20231009183522.543918-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This deemed useful to avoid hardcoding a page height and allow to support
other Solomon controller families, but dividing the screen in pages seems
to be something that is specific to the SSD130x chip family.

For example, SSD132x chip family divides the screen in segments (columns)
and common outputs (rows), so the concept of screen pages does not exist
for the SSD132x family.

Let's drop this field from the device info struct and just use a constant
SSD130X_PAGE_HEIGHT macro to define the page height. While being there,
replace hardcoded 8 values in places where it is used as the page height.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd13xx.c | 37 +++++++++++++++----------------
 drivers/gpu/drm/solomon/ssd13xx.h |  1 -
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd13xx.c b/drivers/gpu/drm/solomon/ssd13xx.c
index 10a767fb614c..d29be17665b5 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.c
+++ b/drivers/gpu/drm/solomon/ssd13xx.c
@@ -42,6 +42,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+#define SSD130X_PAGE_HEIGHT 8
+
 #define SSD130X_PAGE_COL_START_LOW		0x00
 #define SSD130X_PAGE_COL_START_HIGH		0x10
 #define SSD130X_SET_ADDRESS_MODE		0x20
@@ -102,7 +104,6 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_width = 132,
 		.default_height = 64,
 		.page_mode_only = 1,
-		.page_height = 8,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
@@ -110,7 +111,6 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_dclk_frq = 7,
 		.default_width = 132,
 		.default_height = 64,
-		.page_height = 8,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
@@ -119,7 +119,6 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.need_chargepump = 1,
 		.default_width = 128,
 		.default_height = 64,
-		.page_height = 8,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
@@ -128,7 +127,6 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.need_pwm = 1,
 		.default_width = 128,
 		.default_height = 39,
-		.page_height = 8,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
@@ -136,7 +134,6 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] = {
 		.default_dclk_frq = 10,
 		.default_width = 128,
 		.default_height = 64,
-		.page_height = 8,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd13xx_variants, DRM_SSD13XX);
@@ -465,13 +462,13 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
-	unsigned int page_height = ssd13xx->device_info->page_height;
+	unsigned int page_height = SSD130X_PAGE_HEIGHT;
 	unsigned int pages = DIV_ROUND_UP(height, page_height);
 	struct drm_device *drm = &ssd13xx->drm;
 	u32 array_idx = 0;
 	int ret, i, j, k;
 
-	drm_WARN_ONCE(drm, y % 8 != 0, "y must be aligned to screen page\n");
+	drm_WARN_ONCE(drm, y % page_height != 0, "y must be aligned to screen page\n");
 
 	/*
 	 * The screen is divided in pages, each having a height of 8
@@ -503,27 +500,32 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
 	 */
 
 	if (!ssd13xx->page_address_mode) {
+		u8 page_start;
+
 		/* Set address range for horizontal addressing mode */
 		ret = ssd13xx_set_col_range(ssd13xx, ssd13xx->col_offset + x, width);
 		if (ret < 0)
 			return ret;
 
-		ret = ssd13xx_set_page_range(ssd13xx, ssd13xx->page_offset + y / 8, pages);
+		page_start = ssd13xx->page_offset + y / page_height;
+		ret = ssd13xx_set_page_range(ssd13xx, page_start, pages);
 		if (ret < 0)
 			return ret;
 	}
 
 	for (i = 0; i < pages; i++) {
-		int m = 8;
+		int m = page_height;
 
 		/* Last page may be partial */
-		if (8 * (y / 8 + i + 1) > ssd13xx->height)
-			m = ssd13xx->height % 8;
+		if (page_height * (y / page_height + i + 1) > ssd13xx->height)
+			m = ssd13xx->height % page_height;
+
 		for (j = 0; j < width; j++) {
 			u8 data = 0;
 
 			for (k = 0; k < m; k++) {
-				u8 byte = buf[(8 * i + k) * line_length + j / 8];
+				u32 idx = (page_height * i + k) * line_length + j / 8;
+				u8 byte = buf[idx];
 				u8 bit = (byte >> (j % 8)) & 1;
 
 				data |= bit << k;
@@ -559,8 +561,7 @@ static int ssd13xx_update_rect(struct ssd13xx_device *ssd13xx,
 
 static void ssd13xx_clear_screen(struct ssd13xx_device *ssd13xx, u8 *data_array)
 {
-	unsigned int page_height = ssd13xx->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, page_height);
+	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
 	unsigned int width = ssd13xx->width;
 	int ret, i;
 
@@ -605,14 +606,13 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuffer *fb,
 				u8 *buf, u8 *data_array)
 {
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(fb->dev);
-	unsigned int page_height = ssd13xx->device_info->page_height;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
 
 	/* Align y to display page boundaries */
-	rect->y1 = round_down(rect->y1, page_height);
-	rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd13xx->height);
+	rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
+	rect->y2 = min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE_HEIGHT), ssd13xx->height);
 
 	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
 
@@ -814,8 +814,7 @@ static int ssd13xx_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd13xx_device *ssd13xx = drm_to_ssd13xx(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd13xx_crtc_state *ssd13xx_state = to_ssd13xx_crtc_state(crtc_state);
-	unsigned int page_height = ssd13xx->device_info->page_height;
-	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, page_height);
+	unsigned int pages = DIV_ROUND_UP(ssd13xx->height, SSD130X_PAGE_HEIGHT);
 	int ret;
 
 	ret = drm_crtc_helper_atomic_check(crtc, state);
diff --git a/drivers/gpu/drm/solomon/ssd13xx.h b/drivers/gpu/drm/solomon/ssd13xx.h
index e5abf23196b0..64283935fbc1 100644
--- a/drivers/gpu/drm/solomon/ssd13xx.h
+++ b/drivers/gpu/drm/solomon/ssd13xx.h
@@ -39,7 +39,6 @@ struct ssd13xx_deviceinfo {
 	u32 default_dclk_frq;
 	u32 default_width;
 	u32 default_height;
-	u32 page_height;
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
-- 
2.41.0

