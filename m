Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7287F9397
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjKZPrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKZPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:46:34 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212E107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a00cbb83c82so488912666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013599; x=1701618399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beJZbKgVXOvauoKe8Q8WUu/Tdv6GIAu4T+G5aSDiyXw=;
        b=ilvDmsPFXBSj0Us7+oJysEEVrS2Bo6JJQmyeJwrNeMK/GFBpdZ8JYSdbLdJTaz7dkY
         OYLfSGTHeg4IAdM2sY2gTxk2VbFhWtQj6TKmD6wXKNXSrJx7eWvmaGMm10LgoHxHqkcO
         pznZND6wrjvdAAVzHE/30Z3psxkUorB4WWTaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013599; x=1701618399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beJZbKgVXOvauoKe8Q8WUu/Tdv6GIAu4T+G5aSDiyXw=;
        b=Kx75JlNIXTIaVX7Flr4ZOta5SkFsPgREk5viNwZrnNdzaOWo8ou8DAk2I2K5yQpOzP
         UIbBMQYLdjWbAmSSuufBmXTxICzq2IjMAIXWM3r4SiRjVlgCBqgZmz+eI8uX2xX3c3re
         TcMiNfu7+UTTCOyewQIpYNb2GW0+pBfNHdiUpV/wy9bHh9vl0boYDBKKOoH1as2uUwK4
         TKoN7ZUoNnzSDwaoomQz86AkZ1Ovuj8vjUsdSDPtEkBlNSlcMZwZJ8j+m0K3qU6pzMEQ
         v3ItadtWrFm41YlJ36uZd82Kfup/vNP9v8Rj2UEtL9Sq8MOFLBLVxlsz6Az3CFhsoceB
         MrhA==
X-Gm-Message-State: AOJu0YxvG6O09RjCsw7Rg6u+OQVW3wgIWT1T1pBgJJ1JaKXNH+APE81x
        7BBl+NzXfXVlx4fGzW0z8HYJ9euWbEfFe1SEKRwiGw==
X-Google-Smtp-Source: AGHT+IHYhBHEjGL+XT3j6Y6Bjm9VsxzehQvLDMtko3qtuBBCcOV0B5xoVy15karuyYZL/vnEhKjU1g==
X-Received: by 2002:a17:906:1d2:b0:a08:e229:5659 with SMTP id 18-20020a17090601d200b00a08e2295659mr5777948ejj.17.1701013599386;
        Sun, 26 Nov 2023 07:46:39 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:38 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 02/11] drm/bridge: Fix a use case in the bridge disable logic
Date:   Sun, 26 Nov 2023 16:44:54 +0100
Message-ID: <20231126154605.15767-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
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

The patch fixes the code for finding the next bridge with the
"pre_enable_prev_first" flag set to false. In case this condition is
not verified, i. e. there is no subsequent bridge with the flag set to
false, the whole bridge list is traversed, invalidating the "next"
variable.

The use of a new iteration variable (i. e. "iter") ensures that the value
of the "next" variable is not invalidated.

Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/gpu/drm/drm_bridge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index f66bf4925dd8..2e5781bf192e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -662,7 +662,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 					  struct drm_atomic_state *old_state)
 {
 	struct drm_encoder *encoder;
-	struct drm_bridge *next, *limit;
+	struct drm_bridge *iter, *next, *limit;
 
 	if (!bridge)
 		return;
@@ -680,14 +680,15 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 				 * was enabled first, so disabled last
 				 */
 				limit = next;
+				iter = next;
 
 				/* Find the next bridge that has NOT requested
 				 * prev to be enabled first / disabled last
 				 */
-				list_for_each_entry_from(next, &encoder->bridge_chain,
+				list_for_each_entry_from(iter, &encoder->bridge_chain,
 							 chain_node) {
-					if (!next->pre_enable_prev_first) {
-						next = list_prev_entry(next, chain_node);
+					if (!iter->pre_enable_prev_first) {
+						next = list_prev_entry(iter, chain_node);
 						limit = next;
 						break;
 					}
-- 
2.42.0

