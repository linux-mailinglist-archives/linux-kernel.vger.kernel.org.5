Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4C752E96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjGNBiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGNBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5542D50;
        Thu, 13 Jul 2023 18:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D29061B9C;
        Fri, 14 Jul 2023 01:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ACCC433C8;
        Fri, 14 Jul 2023 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298681;
        bh=VliKl8yRFl/vxHPSCbMcCRDElBFtRJGleu5OKQBvOiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgVwOrcINvGcwjIf2mECWMFJg6P/gWNuuZRLGQxB/xJYE76Sqo8bdcPi9FxasDtSh
         JjtiuQeRFj951kk7RXJfFBcPKkEKut5rRwP0qprsGB82sjPrWivTTdy6XUdGzcx0se
         GCsqPjF/OzktqndI4WUbBmqTpstc8Ur4vDQfL31B8XQlziOtyrXGBTbxuK/WomV/WO
         +LLzzwVLsNYiRnnZ8OvtRdQu8+4wN6ZC7sk7ZQ6Y+GdXXLu3dB+Esj9cyFu2b2ZmpR
         aStiUMWSfnw2/qXH8s72QaDxqw+ctMTHnZ5H5ksCxAH2P2DnR+8y9N953HgRcYg17h
         fQsAo0sTi2HTA==
Received: by mercury (Postfix, from userid 1000)
        id D2BB01067694; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/19] drm/panel: sitronix-st7789v: remove unused constants
Date:   Fri, 14 Jul 2023 03:37:41 +0200
Message-Id: <20230714013756.1546769-5-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST7789V_COLMOD_RGB_FMT_18BITS and ST7789V_COLMOD_CTRL_FMT_18BITS
are unused in favour of MIPI_DCS_PIXEL_FMT_18BIT, remove them.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index e4d8dea1db36..f7566551b5e2 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -15,9 +15,6 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
-#define ST7789V_COLMOD_RGB_FMT_18BITS		(6 << 4)
-#define ST7789V_COLMOD_CTRL_FMT_18BITS		(6 << 0)
-
 #define ST7789V_RAMCTRL_CMD		0xb0
 #define ST7789V_RAMCTRL_RM_RGB			BIT(4)
 #define ST7789V_RAMCTRL_DM_RGB			BIT(0)
-- 
2.40.1

