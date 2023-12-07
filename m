Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C382808A45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443390AbjLGOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443293AbjLGOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:18:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3721BFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso1322509a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958649; x=1702563449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=kxLmN75TgX5uFIBJuDTFH1+xNWuzgedppS0kPCGWDoBGRDA7SJpPXO3kMHuPtS+3jS
         8/34YgTmoAYy/FBfScUVsXXnid5r/hCPz0oJeFAETn6vrcCyoAV6FH/vSgLiqkBT9YTz
         +vRjo8hDwR1xJ5c7Oi8himUlFU6vBYp0xsuY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958649; x=1702563449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=ptHO4dq35Q4f1QrpfS8n9u6CHLM7AS5p/H/Dxkf2mbl707k7IE5LYB8LwtJCIyIISA
         VSHUsQYlv103Oue23u1DWjES3q15FmKhUlaGRcv8iAbUx1qS2vFn8KXtpuVnMBkMuDuk
         G1oQ4tjH2xQ2RxDr0Hx/nUkWsS1ePCBWbtm30CLrb0OczdegeWziWZupjf5Gs8qX8vH1
         Lt4oSSqVssuu0L8ss2lHz6yYRoxBSL7tUEoxBvPacwnm8wLFQBlrowPzjnq5CwPfL45n
         M3gWz0hrzuw5cUtFUsIIt5rvH3OeaAM+WPs9pdiMjWV+kPWRB3Lo8rgq/XJEcKFHtQlF
         3pbA==
X-Gm-Message-State: AOJu0Yz3jhx9b84F10N9ehEQ0df6Vmt1TV9l5zAVGc9dgTLxTXnKdgU2
        3oKRXE4pZ++rUZ2xhJ8xsh7f6Mb8ftSFG/lRW0SfKg==
X-Google-Smtp-Source: AGHT+IFX6FD85qiXsRa0p4UVyWkTnzhrOQVGm8xEczpecb8umzKPb/58NcpsvdEbtAuJxOrQVkuD7A==
X-Received: by 2002:a17:907:b88:b0:a1c:eea8:e34b with SMTP id ey8-20020a1709070b8800b00a1ceea8e34bmr1371325ejc.100.1701958649228;
        Thu, 07 Dec 2023 06:17:29 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:28 -0800 (PST)
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
Subject: [PATCH v5 01/10] drm/bridge: Fix bridge disable logic
Date:   Thu,  7 Dec 2023 15:16:30 +0100
Message-ID: <20231207141723.108004-2-dario.binacchi@amarulasolutions.com>
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

