Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD580E2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjLLDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:33:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD811B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:33:16 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b70de199f6so141209639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702351996; x=1702956796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYInYE6vgyZ8xggSLq7h777qBlps2bVu+HQMH76x0n0=;
        b=PlZ5rd0IhGJ/2tsh47RU7PeKgHw9f8gjT9AWvlikDH8j7OlOMGe6BWu0KrZ76o37WP
         SOBnhNFQ2tCHZ2i8F2skYXEqjLtVowWaX/QkAhSZZ8XlyChOZk48OXN/bSkeQz9v8mdU
         hTui88FsIyRZmBjqIa13xdPLBhvkqyJeiwxA7XPC29unGCAhY8lGeYx3Yngcq1NoQ/ha
         CCEnW1090eR2h2c5NHoVWAwSMAqREnvu9OvrvklCnHVX6Th/dbeM3FKXSpDNrzu41xaB
         LZYNaM+TQsYWywfZgUOY1tpoCD9P4iCQXnYOy1I651vebebb1mtND8tma0eH6DNcjPGX
         7tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702351996; x=1702956796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYInYE6vgyZ8xggSLq7h777qBlps2bVu+HQMH76x0n0=;
        b=V6gelAQZ0JlJzNg3fHAQ3S4f17R/AgnX/KkAPDUrke3i0hG++AlaE4r2UtkN9gkWZA
         eDRmfAaibrRuzq1/R2KxNCbF+e+BMFyYqQMZxL32PVC8N8vqRH7g3WVl2n2x9d4FCyNj
         mrDxHAhVvFpiilPLj6jezY8h2RhOpmYxWdpHnHeq4r46yr8e3+yoZ+dj7lPI/DGqrHHZ
         cjqOgv/mWH6KX8eWKl1a4nqm7UMy0YCtOA3Hh3MvP8amEzGYfkHNVhokrL4MXbAukH+a
         Lu5IIcdi+MFLyRbE6xHsLQu04dgJgAdOklbfuSvMInAmWBhAqjkrIAkGPE4432m2Mf1p
         191g==
X-Gm-Message-State: AOJu0YwaJQgNuJEjs+5Geu0AmNunKYLx4ixC+/53/CybD1NJ0bOV1qX/
        j02QaT34vNXGp8AE+deQ40I=
X-Google-Smtp-Source: AGHT+IG08MJ0IJU3QFb5acFcJOPuXxUtZCYC4nz6t5BQKhDRpUHFrucdvKe0afj1ildqn1g7OvRgBA==
X-Received: by 2002:a5e:a916:0:b0:7b7:19e3:a645 with SMTP id c22-20020a5ea916000000b007b719e3a645mr5176094iod.20.1702351995800;
        Mon, 11 Dec 2023 19:33:15 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:6068:4690:ab38:4373])
        by smtp.gmail.com with ESMTPSA id y23-20020a5e8717000000b007b457153a6bsm2590049ioj.28.2023.12.11.19.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:33:15 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
Date:   Mon, 11 Dec 2023 21:32:59 -0600
Message-Id: <20231212033259.189718-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212033259.189718-1-aford173@gmail.com>
References: <20231212033259.189718-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using video sync pulses, the HFP, HBP, and HSA are divided between
the available lanes if there is more than one lane.  For certain
timings and lane configurations, the HFP may not be evenly divisible.
If the HFP is rounded down, it ends up being too small which can cause
some monitors to not sync properly. In these instances, adjust htotal
and hsync to round the HFP up, and recalculate the htotal.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 239d253a7d71..f5795da1d8bb 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1628,6 +1628,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
 		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	}
 
+	/*
+	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
+	 * the available lanes if there is more than one lane.  For certain
+	 * timings and lane configurations, the HFP may not be evenly divisible.
+	 * If the HFP is rounded down, it ends up being too small which can cause
+	 * some monitors to not sync properly. In these instances, adjust htotal
+	 * and hsync to round the HFP up, and recalculate the htotal. Through trial
+	 * and error, it appears that the HBP and HSA do not appearto need the same
+	 * correction that HFP does.
+	 */
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {
+		int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
+		int remainder = hfp % dsi->lanes;
+
+		if (remainder) {
+			adjusted_mode->hsync_start += remainder;
+			adjusted_mode->hsync_end   += remainder;
+			adjusted_mode->htotal      += remainder;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.40.1

