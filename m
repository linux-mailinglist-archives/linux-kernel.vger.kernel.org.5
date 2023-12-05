Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B6805137
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376662AbjLEKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbjLEKx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:53:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D34113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:54:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1975fe7befso593151366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701773643; x=1702378443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=my897ijY0zxb7MaNHGo/3F01VcJ0zZrWMzeFmWcjnoWg3uYz6ibHBPEd1aDLxNtyya
         SaRv0nWftCUb2JDRjr8y0FQlpKQIQd6T+VDDjQfHd5C1zFlOu3LRK8Tik9ZwM3lmfinY
         cDMO+eWQONtsHRonaR0BiZjesTo4HHfqYEK0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773643; x=1702378443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=b8hUWyeMvFW70Z1imyLwa2I/ttr0e7QE6t8NHEbNDGoC/RuG0emSEpTsCrjWJqsv9T
         nSMZYIDO2ob4qSavY7/8cnrJpHvy+bOMVmdRj8k0sVwR6VzNud5dnk2mAkieuwIcUUez
         I1UAEtNVSzKJwZWn8Ndvb91SklewHa6zZHp50Ovdf17/Gd8ZaePOEpdbyAmRHKTVypi2
         YD89/fFr38BlVZJfKKhkzfQW7uh8Bh/LrOLAmksqnPVj+M5XtChyTx6nm6eokx+Yy6pS
         QDnrv9IBGkVVqbtfr85xkr3mGJ2VCfbhaV8jJhuB8fQZVv428nH+pqHOKY680I3n/s7l
         UpZw==
X-Gm-Message-State: AOJu0Yxnipn2bUDVVcCnOn7tgEc0iBSaOuVYFaq9o3bXxgbaLpKefciw
        5K6LHIXochQJu5+GrL1O3zRquCMTZ4FfGABHNVAogA==
X-Google-Smtp-Source: AGHT+IEhCW86sDDqX5HhYwo9leDEXnK3BBE5ui8/2dHRSqsGfYqV4vVQgDEtuqv3sS8ZVoS+1vs00Q==
X-Received: by 2002:a17:906:2814:b0:a19:a19a:eadc with SMTP id r20-20020a170906281400b00a19a19aeadcmr311534ejc.149.1701773643372;
        Tue, 05 Dec 2023 02:54:03 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906089700b0099297782aa9sm6413491eje.49.2023.12.05.02.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:54:03 -0800 (PST)
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
Subject: [PATCH v4 01/10] drm/bridge: Fix bridge disable logic
Date:   Tue,  5 Dec 2023 11:52:48 +0100
Message-ID: <20231205105341.4100896-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
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

As explained by the comment of the fixed code, we need to find the next
bridge that hasn't set the "pre_enable_prev_first" flag to true. The code,
on the contrary, was doing the opposite.
So, the order of disabling the bridges couldn't be altered as required
by setting the "pre_enable_prev_first" flag to true.

Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/gpu/drm/drm_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 30d66bee0ec6..f66bf4925dd8 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -686,7 +686,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 				 */
 				list_for_each_entry_from(next, &encoder->bridge_chain,
 							 chain_node) {
-					if (next->pre_enable_prev_first) {
+					if (!next->pre_enable_prev_first) {
 						next = list_prev_entry(next, chain_node);
 						limit = next;
 						break;
-- 
2.43.0

