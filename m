Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D881141F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbjLMOFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379443AbjLMOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:04:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4EF11B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1fae88e66eso356234966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702476290; x=1703081090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=FNNo03N4r8yvuc/pCl1KqXjBYa842UOZQe3wgiSxEV8MK8sDeBJgWtNKXxVlV6GsvH
         jKqRsebjME4RYkA75CcvgeFSvD4vLVV+UWG890dGXMhk4hvNdHS4OmcY62RG0lFXxtvc
         R3hb4/oBD9KBLXNssJLVDy065MdntHe7GhFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476290; x=1703081090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=awyiUVSjrtD2r1SVtMBN5F02MSEqNtPSdAWxHV1c+2C8360XopBPhWYsd+2v51TXr/
         AZjF1HF0OgYfwQzrw5NUBukZW6jKrQRpBc1CpKv8tp8C6BHiwgb4fasPYlvLeHzmgPAS
         ysihbY6CI45jnWQs8jcVTTZj8xvDT86DasQZbRzTkgu5JaS+Tz/nZnzShNg5NiAGZMbI
         AAsEVpmiQO+cH0aOfgszKYXdJ8EMMy/7B4nklB6ehxKQF+CMOa6juXGJDVx0hbLemee0
         /RBGAkIJKPC1FVTguF0mwANPmqm/TR9UtnpIQqd+r4mXXnr4COKSi1OhGmhfG2SkgENs
         U0Xw==
X-Gm-Message-State: AOJu0Yw+lARlrNvWDVBwiYdUpCuxuKUnfOsS/Id7C1K9JgFOqiGYZliP
        BgmS2tyFDH7FcHaDiQTA/eC5a8Lt6GQrRqFz9rbfww==
X-Google-Smtp-Source: AGHT+IH/DyKWXFFFShYbC0zIs86T8HHYGnLc0RMfq72z84+U64jUAOx/Wgh/+p7dSDv3JtasURZwyw==
X-Received: by 2002:a17:907:720a:b0:a1d:e889:5276 with SMTP id dr10-20020a170907720a00b00a1de8895276mr5208788ejc.61.1702476290034;
        Wed, 13 Dec 2023 06:04:50 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.pool80182.interbusiness.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm7797635ejc.161.2023.12.13.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:04:49 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 2/4] drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
Date:   Wed, 13 Dec 2023 15:03:43 +0100
Message-ID: <20231213140437.2769508-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
References: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch completes the setting of CLKLANE_STOP for the imx8mn and imx8mp
platforms (i. e. not exynos).

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/samsung-dsim.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 15bf05b2bbe4..13f181c99d7e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -96,6 +96,7 @@
 #define DSIM_MFLUSH_VS			BIT(29)
 /* This flag is valid only for exynos3250/3472/5260/5430 */
 #define DSIM_CLKLANE_STOP		BIT(30)
+#define DSIM_NON_CONTINUOUS_CLKLANE	BIT(31)
 
 /* DSIM_ESCMODE */
 #define DSIM_TX_TRIGGER_RST		BIT(4)
@@ -945,8 +946,12 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
 	 * power consumption.
 	 */
 	if (driver_data->has_clklane_stop &&
-	    dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
+	    dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
+		if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
+			reg |= DSIM_NON_CONTINUOUS_CLKLANE;
+
 		reg |= DSIM_CLKLANE_STOP;
+	}
 	samsung_dsim_write(dsi, DSIM_CONFIG_REG, reg);
 
 	lanes_mask = BIT(dsi->lanes) - 1;
-- 
2.43.0

