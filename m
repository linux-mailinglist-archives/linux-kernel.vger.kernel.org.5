Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0307FF17E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbjK3ORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbjK3ORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:17:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054BBD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a08e4352992so141214666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701353834; x=1701958634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=XvsyvLyMPtI3GoxpMgck/+6f8D16FWCeyBAj4ANEBmPkBmx+q+vTAUOUb8BejlHyjk
         EQZvhWM/8WGmMdji1wmdWlmommNl3gPz8Nz31x6I9zNOoU8PfDbE9d4aOeGGl+4H7Ol1
         7Yy3LDZW81uuMf/z8awAtYPRUqtsEkxXVBkbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353834; x=1701958634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yGi3UQjgH7vKIKdKQCwE11iHS9JPf1l9kS7cSUyqbg=;
        b=hBFxxQpJSSgylxzxXYrpU9DiAc+gP3rrA1Wvx1J/zYti+DuPEqjL9CysMVmgFYR/+U
         mRuRMs8CQVSOYFpcCsb8tlvLwAEYA9vhn9+DU2N8l/wKCpSgi7PS15DYI1mkiECorU9q
         gZxZywz34DLDlgaP60rmHtBwcasfs5Zdk+enbRL+wZuudZdKiYaeQvry2BNyOfCG26pF
         n0VdnzKREroukOuKfhtQOsQTAslD9W4OS6PRtRG0dbXhqSPIS/hI1YrRvt0avhIns/Ny
         ssQMgbiHXFLha+nblQhGRz+RL736YXUWq3g/pPfmBW052kcpR76dAUBbOIz+lDGzEkBS
         IliQ==
X-Gm-Message-State: AOJu0YxmWvLSCs2hngBjs81vBvM5JnnSEoAHnOtd+neG0jikm4hHvViz
        8YfbjMHd5KbZRarfRZycz6Sshj87dSH/zx5ydhhBmA==
X-Google-Smtp-Source: AGHT+IGbutfd86LPxsw38uj7AedD+n1qyjNw1JAgPkJqTtrXi7II4U7qU6uGC2mVffiXY0vpT4uqkg==
X-Received: by 2002:a17:906:15a:b0:9e4:651f:60cf with SMTP id 26-20020a170906015a00b009e4651f60cfmr14558074ejh.1.1701353834502;
        Thu, 30 Nov 2023 06:17:14 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
        by smtp.gmail.com with ESMTPSA id my18-20020a1709065a5200b009f28db2b702sm716064ejc.209.2023.11.30.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:17:14 -0800 (PST)
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
Subject: [PATCH v3 01/10] drm/bridge: Fix bridge disable logic
Date:   Thu, 30 Nov 2023 15:16:18 +0100
Message-ID: <20231130141705.1796672-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
References: <20231130141705.1796672-1-dario.binacchi@amarulasolutions.com>
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

