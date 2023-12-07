Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D81808A56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443256AbjLGOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443188AbjLGOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:21:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41319B9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54cff638658so1326632a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958653; x=1702563453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=eIgxP2Rv9lsBhiVfoHBww21fMl3CDjqTWZk1fUXCQlmBP3xbjqEhlzcjtH7q6lEqfO
         NHOnOEDcUVjSgjTP3wo8Rsitl9Hwlfx8F3ob/SKzS0soZk3ozZfPv7N8aYMYCsn7wit5
         WTnohP1M0buj/ed7tgh0PuAbWwLYA2Uc6yU6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958653; x=1702563453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuU/Yf3+WOs2/s3BqHchrpBnPmBNhkaR5Vfu/UBGmU=;
        b=HsAowq5in1o1i0tT8xdOpU/6nL336jcXlO/Aeuqeho/E8Kc6XxYonYFmtmdmNSiidC
         QTV2PrEbPY0fN/tgsmR9dIV8ck+qswc6WuX2/3KU0IdgTlRFFgIpdAq1NykhLr+INmSC
         oRWYcOhgPcjuYbFXXzLvTh20LqvYf8dQTqHP/2uRmfmuFXkfQzyvdnjqco9iZgCgLWtC
         u1cWv/XAVWVnRzlAcki2Td2/Qy5CBd8ithNA9RM1Bb0I/g21ff8L3iQH8ZUUDj3/kCSB
         5TfaYq8go6GahOFOWBNodCIVmiRDM5Dn9iJW1t14lYNjftHDBHa/lLt3LwQwVu6hENB2
         WGzA==
X-Gm-Message-State: AOJu0YzWsgoVrSVqXTX/dQsZnMMN+4LTfwThy6WJ1dm5nflqXUuumlr/
        xenz31n/SyHu7e9FKm6m7Ldg9x1QgvBi0poiXQg1hg==
X-Google-Smtp-Source: AGHT+IEXkPRNYwtzYN4bJ56aVKbKWo15GXlFCCREur+cBaC6pPT879kzp0Ctb2aW0i+7TuAVzZOEEQ==
X-Received: by 2002:a17:906:b759:b0:a19:a19b:55f4 with SMTP id fx25-20020a170906b75900b00a19a19b55f4mr1531281ejb.132.1701958653107;
        Thu, 07 Dec 2023 06:17:33 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:32 -0800 (PST)
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
Subject: [PATCH v5 04/10] drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
Date:   Thu,  7 Dec 2023 15:16:33 +0100
Message-ID: <20231207141723.108004-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
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

