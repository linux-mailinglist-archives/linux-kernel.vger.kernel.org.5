Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCED7BCEF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbjJHOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:40:24 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B78A4;
        Sun,  8 Oct 2023 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696776021; bh=eDXsog+J/XXuZesNNvrWlqpieI4EjnnGtBWWP9Ztf7s=;
        h=From:To:Cc:Subject:Date:From;
        b=gohi54XucwRpKeYO/PTNe1LudzL6ZIrrtxuR+cBgMWyegCsfnroYNw2zNXc51k7AA
         bzx5M1FHvN0ZEEgNMhzDWfze2RIvTeIgED6EvgLTj6kYM5LUmDw79MrYpcO9Iv2tZ2
         8VY0w5JIkWG5Y4SisPJSeQXdpbz+WaqMGXS00Pco=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
Subject: [PATCH] leds: core: Add more colors from DT bindings to led_colors
Date:   Sun,  8 Oct 2023 16:40:13 +0200
Message-ID: <20231008144014.1180334-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

The colors are already part of DT bindings. Make sure the kernel is
able to convert them to strings.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/leds/led-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 214ed81eb0e9..2230239283d0 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -36,6 +36,11 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
 	[LED_COLOR_ID_IR] = "ir",
 	[LED_COLOR_ID_MULTI] = "multicolor",
 	[LED_COLOR_ID_RGB] = "rgb",
+	[LED_COLOR_ID_PURPLE] = "purple",
+	[LED_COLOR_ID_ORANGE] = "orange",
+	[LED_COLOR_ID_PINK] = "pink",
+	[LED_COLOR_ID_CYAN] = "cyan",
+	[LED_COLOR_ID_LIME] = "lime",
 };
 EXPORT_SYMBOL_GPL(led_colors);
 
-- 
2.42.0

