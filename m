Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6A7F9375
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjKZPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKZPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:46:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992010A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00a9c6f283so458823766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013597; x=1701618397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPhojAvgi+YoDilK1ECw25JeY/ntj0LxcVc6MoPKWUg=;
        b=GL9ss8D6v4qFRbk61VECZ4zLfvtoMVEqq2HUxlSxqnAJ5hWByl8N1rc8TmGgFwxXcT
         QoEnURT5m04l+nwl0NFFte5R93oCOYpd3G+nFwHOpsCNPCOHCwdoznRdy3b3xnl2ho9U
         tNX+taJEx6jSn13NSl+LjNTMg5q6XlaB4kzsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013597; x=1701618397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPhojAvgi+YoDilK1ECw25JeY/ntj0LxcVc6MoPKWUg=;
        b=vb73W76jhSZa0m693LwAw/9kwxnIUladz7gvTnHCXO0o+Qkg5VLGTLwACsUzFjaoCh
         vvuV180Fu7fUmLBTp6EPSA1Mbvcv1ToTfHbxPreIjw6srG+WxOWIpUViTsPlBLMaeWyD
         P8Ey+llnyo/n02g+mb9cpdn3Y8tRpWvF39C0aYm1n3odMMQBAjVBtKPsHJWSlI3sk7/K
         d0kiOZ4vgrgtyi9eMde3BBVujh7MeK6JcCXLfvJJ8MFHo/GSDOLW7FPaNIBrPzFEhMcF
         NTHAPtDFRo/qOsHEvYtyPIg97pfLUAxmuIJlML12J6gKj/WBSg0dU2Zh9ZQuWhVyaE+q
         p6HQ==
X-Gm-Message-State: AOJu0Yzs61EcdkChly2ho2jzevIck2ResCCXb0g5Kmo7FwTA8TGUTvzS
        peinM/oGNnzV+YodUdjdjcIVtZV35hfbuswAyExD4g==
X-Google-Smtp-Source: AGHT+IF2c26zfuOWidFTcrN0JuwK29CG/Vrvyi36DqjR5OBr6Zcl5SPM1wOzXPA5XTBjCtCQwzBZiQ==
X-Received: by 2002:a17:906:2f14:b0:9fe:ab09:4d9 with SMTP id v20-20020a1709062f1400b009feab0904d9mr5649578eji.59.1701013596469;
        Sun, 26 Nov 2023 07:46:36 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:34 -0800 (PST)
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
Subject: [PATCH v2 01/11] drm/bridge: Fix bridge disable logic
Date:   Sun, 26 Nov 2023 16:44:53 +0100
Message-ID: <20231126154605.15767-2-dario.binacchi@amarulasolutions.com>
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
2.42.0

