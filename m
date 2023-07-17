Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C40875702F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGQXDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGQXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAF1B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70E861315
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CD5C433C8;
        Mon, 17 Jul 2023 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634870;
        bh=vkrckR+PUbIXtjryoHNayOpTopy4ZbuOkhMATAKs7+c=;
        h=From:To:Cc:Subject:Date:From;
        b=EjN/fy6BLDh4DuMXHyCMVopxMo45DOT7p3O/KwiJiVBOudfMQVZ0hQFXw7cQHOT55
         xH8wZ8nhwrRpdH4QaG3tWw1u8vjFU4sSwY9JAq2GVItX1yoBfqDmOZYyNbwsZvWZJD
         dSJFmaTkx0PevxQ9EHCX1+hTa8hRKXmrI3kRdFq1ytEOgC3RYlbEUp8JKdq4phnbl1
         0u65DK/uVL9ClahVQjWp8YCBk7di3k09wWf4UOM/CTOjYeoPrp7o+RLblvbfomI2yu
         Iq1M8YKBG22FLSoqiovP3RaRL1qBTsL3MP9PhMtyrjfh4rTocSWV+KPA0WRayJwy45
         1a7W1fkcqwL9w==
Received: (nullmailer pid 3213606 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: nomadik: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:51 -0600
Message-Id: <20230717225551.3213486-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-nomadik/cpu-8815.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 51f88a297c4e..0eed60917dcf 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -5,25 +5,12 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 #include <asm/mach-types.h>
 
-#include <asm/cacheflush.h>
-#include <asm/hardware/cache-l2x0.h>
-
 /*
  * These are the only hard-coded address offsets we still have to use.
  */
-- 
2.40.1

