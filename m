Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B2759393
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGSK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGSK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:59:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1F186
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:59:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 1299D60007;
        Wed, 19 Jul 2023 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689764346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=INBu3P3S1gZdEhtPxSWbNhdhaThn/dov55l5MihIIxc=;
        b=me1+yVQy2h5JS8f9pszwSrbXJrRxg1rUArG7+6vJ5euBuQMTh3l0c1xoPNGtUdqkKIebSN
        SUVo1pA0k1vhhxZa+dqQuTU3DjkgcbaaM/QrWxwJg8Od4ZP7NSP3CJkbnY4x13Pmh+Urcp
        zMfjsdUYEAkbrxk1gxEILiglpcK1cy+K4yrDNvLwU2JNuTDQjTPSmsGzPRpP353aiOJT1t
        73dn1pdVy7NOab2thbwZMed3r1JvHLro3OZx5s52yxdeGdqpAhp6OTv/ehTvXT+5B5FQps
        rOdUKwkx2Fz5Qj6ACS6PCO/MgzjtXY3S9jY/RG5kSeFT8NNz07/srx1sLf+m0Q==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH] drm/panel: db7430: remove unused variables
Date:   Wed, 19 Jul 2023 12:58:29 +0200
Message-Id: <20230719105829.148011-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables are never referenced in the code.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/panel/panel-samsung-db7430.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-db7430.c b/drivers/gpu/drm/panel/panel-samsung-db7430.c
index 117b26845083..14c6700e37b3 100644
--- a/drivers/gpu/drm/panel/panel-samsung-db7430.c
+++ b/drivers/gpu/drm/panel/panel-samsung-db7430.c
@@ -56,10 +56,6 @@ struct db7430 {
 	struct mipi_dbi dbi;
 	/** @panel: the DRM panel instance for this device */
 	struct drm_panel panel;
-	/** @width: the width of this panel in mm */
-	u32 width;
-	/** @height: the height of this panel in mm */
-	u32 height;
 	/** @reset: reset GPIO line */
 	struct gpio_desc *reset;
 	/** @regulators: VCCIO and VIO supply regulators */
-- 
2.34.1

