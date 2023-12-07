Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B082808A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443414AbjLGOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443325AbjLGOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:18:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572561FC0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:34 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1e2f34467aso91279866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958650; x=1702563450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu0Px4Tbxip0tKoFWKIyTvbcuMI1IJ2fyAiFtPcJOWc=;
        b=P/zjBzBWuo7MgP5j2NOsH5kzeNz9Is90YoKPKeZgsIF8KC9nt0v7TOEpU1ZXI12IRQ
         a4uHbSAh47vyEOX55uG1zsLH3XzSNMnmMCQTXywnmpPZtF02LYW6QbWkg1mVmtVwUdLy
         QVP+5KoPOMDURuj6UB2HD1VTqi+xJ2usuC1gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958650; x=1702563450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu0Px4Tbxip0tKoFWKIyTvbcuMI1IJ2fyAiFtPcJOWc=;
        b=vzjGWJD36OAHP86KZCD/IPOdPWhh4s3RMkgOuzHwvxVR86cIGaHYoxBr4PQGm+0Ddm
         cMi2OrV+45A4hj8xoQV9nHrM38ZjuCIpkk8KXVGVP5nbUJnwVgrc+ouXgBAGHKBYzvvq
         f2a2cIRq5HkAzIpx7taxgnjWm8L4eQCwJ3VX+wEfq1iu3lzX5DobK+lMb+vKBHFgq9Pa
         ROirWSJsCOB4iIdZusKRxIOkRXSVAbEW7ajydEknOYnmvfSOQQhmplXn2yS4jcDp0bXD
         SH8hT5gJ21mDE61NPJBuA6RMHNkkLuuD0Vu3JSYOXl8jTLrYw1zUKnuYB9RT9azJ7n6Z
         SwJg==
X-Gm-Message-State: AOJu0YxzzJ9fg53DKo9YfJUxIJqbSBxhVfTNk6ZxxgU6vin1+XzC93S0
        XWhg6I/YMm+szijoHc/vAKn75e8NJLuHuvEKslvY7Q==
X-Google-Smtp-Source: AGHT+IEKt+m4WcAwGyRNiq3p7RkcN2HRJDZ2ARN/vQ7Yh6kI3tPnmINApVHMQ1D31CBUjdDTe5zvAQ==
X-Received: by 2002:a17:906:ce32:b0:a1c:8b15:fc01 with SMTP id sd18-20020a170906ce3200b00a1c8b15fc01mr1663788ejb.33.1701958650470;
        Thu, 07 Dec 2023 06:17:30 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:30 -0800 (PST)
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
Subject: [PATCH v5 02/10] drm/bridge: Fix a use case in the bridge disable logic
Date:   Thu,  7 Dec 2023 15:16:31 +0100
Message-ID: <20231207141723.108004-3-dario.binacchi@amarulasolutions.com>
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
2.43.0

