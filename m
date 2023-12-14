Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A1812A44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjLNIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjLNIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:25:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E77CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:25:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso940818766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702542314; x=1703147114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=Vxnoh+LR7PQWwgamSvAokbYu3vryfTezhkvquOV6U28OlfG1L6wb/nzKzgvySxmy+m
         GOjg+hctnIzyCBUe0gOgKQHJXxZi46NCehuEeffC4/svjahd9e2fCEjksjC2JzmM++CU
         NJuUBXHKKvJ7HUKK/F9UO97L4MODttUtlIIF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542314; x=1703147114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=LeKDBGpGKtXoTV2/xe9pXVQrxYjAwObsAFh7dYUX8uOA0FEbznLWwDiHiJig09DcM1
         591H6/eDspBxomSOOoE224m6SI18cEIFvTWxg/9yiPlSF8APU2kd3QNtPVsswYj9PvVx
         DQiNy3nK777nN7vRn70n+GTfqtzO1LiBmUcpAY6mAxLs74jE6/slRa86c3QcJ+IPhTNp
         /EG3zK9yxbhwcCfl25DZtOBe9/DbPCyXGqoZ46dASiphrOaJdq2tfrg6cdWGjMmS5dGp
         eOn8zTirZr1EXMEmJ899bKvF9vnTGjLDhe9q+v+8Y5RpzBRa/xAe5gl/dVmSPosFt7PZ
         M7dA==
X-Gm-Message-State: AOJu0YySafNfhHWkBZ+Qy4PvUB4vUrHZVCZ9uYo6Y2vvEsAGwqf8QPVz
        fYdbaQteCCOzvvABN2w1/TY0DoRFAdHK4eg/u7yHAg==
X-Google-Smtp-Source: AGHT+IGZX6MZKKB2rJE3wqGAwfl1WteX/NIbcyKkXwIIBFqD2w9vCPZFUXPnyXVLFk4gqxuEac1EfQ==
X-Received: by 2002:a17:907:86a6:b0:a17:3097:3f6e with SMTP id qa38-20020a17090786a600b00a1730973f6emr6566930ejc.30.1702542314396;
        Thu, 14 Dec 2023 00:25:14 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.retail.telecomitalia.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a1cbe52300csm9026226ejc.56.2023.12.14.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:25:14 -0800 (PST)
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
Subject: [PATCH v8 2/3] drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
Date:   Thu, 14 Dec 2023 09:24:05 +0100
Message-ID: <20231214082457.18737-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214082457.18737-1-dario.binacchi@amarulasolutions.com>
References: <20231214082457.18737-1-dario.binacchi@amarulasolutions.com>
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

