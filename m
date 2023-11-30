Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C37FF18B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbjK3ORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbjK3ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:17:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD385
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a18b0f69b33so111519566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701353838; x=1701958638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=ajTJeqhwBV4+OZhstNIbMDi7arqPtoNOm1xx9NQjMJRhhWsucF8UiZ+5bEG31aEPHW
         uJVtsL3MQZyKn3JUVPrekmEALUfcV66F4iTPnyY0Nx5Y2OzBnIEr/j6xLe/vl00/KlJR
         LQuXadqo+stOuAfN/p0JVA0gKQ+kZh6O+xQC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353838; x=1701958638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=N0W+KJSr6ol8XFyAWZRdmf3eJu62Sgsipf4/gAIzA5zwhY/PM1al0zrYtoyksxb/wR
         8sYNnuFob0aCFrPXRO0lMwvU901eEeS2/VUYm7lHY9g0nYrLHpHWK4oMs7j1xxeqqi2b
         g/TKibGFkUdsDyTMVx8nA7IXJaE1DYqCzzQw8YgSjVFutYdH0vK9KTcYJ2rdRY3W0Iaz
         PKT9O9x81Io/R3/0HOXjRdLEFcdoEKUVtO5sEj2uFzBgOYYlHOIf1POaBJXr2/R7y46H
         PYslnacqk4XuKVEOt7Khwlh1kaOxEaVkQ6MSAvrOY+oFQ2cKnkf9LpA4879oMiZfPKeO
         CFDw==
X-Gm-Message-State: AOJu0Yy49s+KkB5Kj4wUIzxsOK8jR7V2aoj6yqFuQTn9sW+Q4gTv5Qgb
        MDJOLhO3PZb5gdId7bP8ip8tQN4M3Vke3AI4VL9QGw==
X-Google-Smtp-Source: AGHT+IHdMxmxgR2HxolYhbHNxz+aCeCS19l5l5Eqtur1aa8feojY3KHYn45CFJYV+wVmeAhvP5BhUQ==
X-Received: by 2002:a17:906:20dd:b0:a18:a1e7:5682 with SMTP id c29-20020a17090620dd00b00a18a1e75682mr1828465ejc.14.1701353838727;
        Thu, 30 Nov 2023 06:17:18 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
        by smtp.gmail.com with ESMTPSA id my18-20020a1709065a5200b009f28db2b702sm716064ejc.209.2023.11.30.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:17:18 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
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
Subject: [PATCH v3 04/10] drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
Date:   Thu, 30 Nov 2023 15:16:21 +0100
Message-ID: <20231130141705.1796672-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
References: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

