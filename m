Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CC80E2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbjLLDdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:33:09 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E588F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:33:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b435966249so237792539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702351994; x=1702956794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3W+vl1pPQ5xbJbOBYqTUjLnDDv5t03VNIfECEsk3uHs=;
        b=R8MtVXaiPyZuICvuusMWaZh7QU0U4+OY/QWLeVEjrQXoqbVxQW6cKz07k+IzqTacML
         qtmcpzODwBdoOSwgHpfFzxaNFfQY4+C6m6swJnqTwlgXP1w/3Cl60SONS/Ee/NTvzCoI
         23v9eFNIV4k2tq/jCKkqyErz4hyoIzS/I3PrA3Lv51PD6KKt7MrkGTqvEfKaFx70sCX7
         BdWXp3JGxAuqXKPSfsJ9Ybqg0ELgUSFb73YhVKtuMi6/11lAxhpnLORNqXV22c/maUjx
         iXT9di+sbYw/jaYxy3j0nnze1XFVVnzcaOgtN5H+HWjDagrjFR/2FsSlYiAZY8auidY5
         +H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702351994; x=1702956794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3W+vl1pPQ5xbJbOBYqTUjLnDDv5t03VNIfECEsk3uHs=;
        b=fEK2BwNC7UiZnVem6NbsebY84LYJ5I6V0U2iK1otSVcZQycRYkkROZxlPRCO6c5BRG
         4MyXoosudjXmYdVewffNljPgqHrjSnm9PcPVbiJSBc/9v5rloNxzIkjEEM5DEuasavGb
         vx+GydPygUZwlJ2QbjAA7qs23xHV1KIDfRjP8nzuYyJ/Q4yfQlA7k6DcITRFIj7hNQvQ
         7iM0RWdEx1OG2wpvA8oNLvANTLNBBk4Sszu4Da+YXWigmuK8ufFsJCtP2G72wOgQJZrN
         SCgfAnsXJzxczg1lqNFx8kwJBsOW/ZX2g8oV6bTfM79JPiCgSXUDV5m0wtaHlzBNO7YN
         Vpag==
X-Gm-Message-State: AOJu0YyhCkja83yhqkMxeJ6kovNz/M0Gf4jKllDOk0hVfaS3LCiqs0lb
        WyiCMRdFS0z2SCkTPeBK/jQ=
X-Google-Smtp-Source: AGHT+IEQ2n6XFLN8H7+WSHX07ery6GbeFJs7zpiGoluH51/YRfXyjf+FLjsQ2RJap6WxnQE6JL1qIg==
X-Received: by 2002:a05:6602:274d:b0:7b7:e9f:b93f with SMTP id b13-20020a056602274d00b007b70e9fb93fmr6164628ioe.0.1702351994112;
        Mon, 11 Dec 2023 19:33:14 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:6068:4690:ab38:4373])
        by smtp.gmail.com with ESMTPSA id y23-20020a5e8717000000b007b457153a6bsm2590049ioj.28.2023.12.11.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:33:13 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: samsung-dsim: Set P divider based on min/max of fin pll
Date:   Mon, 11 Dec 2023 21:32:58 -0600
Message-Id: <20231212033259.189718-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The P divider should be set based on the min and max values of
the fin pll which may vary between different platforms.
These ranges are defined per platform, but hard-coded values
were used instead which resulted in a smaller range available
on the i.MX8M[MNP] than what was possible.

Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference clock")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index be5914caa17d..239d253a7d71 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -573,8 +573,8 @@ static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsim *dsi,
 	u16 _m, best_m;
 	u8 _s, best_s;
 
-	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
-	p_max = fin / (6 * MHZ);
+	p_min = DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
+	p_max = fin / (driver_data->pll_fin_min * MHZ);
 
 	for (_p = p_min; _p <= p_max; ++_p) {
 		for (_s = 0; _s <= 5; ++_s) {
-- 
2.40.1

