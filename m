Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475975701C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGQW7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGQW7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:59:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42081716
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4510612FB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D3C433C7;
        Mon, 17 Jul 2023 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634746;
        bh=OdfI1DsT8msOhtbHO035wIhdW6mDtm8twU0kdrGcESk=;
        h=From:To:Cc:Subject:Date:From;
        b=otKz7JjeuYLIipQRHWMjThEjxKJ8WNODYFYooplOTgboeiGyeR3S30A6wp/3vZt6r
         BuVhg1f6CUWrYahR66aCYjWqRWqNX7yXjimmGVCVJMdtRX5QCmv/kym0vSIW8bHSvs
         I21pscMlxgSIChfASJoJjwLXHyS5UqVLkivgijPtzg3U3jba2zEPcz7U4Okh8AifYl
         lNJKi4ZVQjjEMCh4CbHpJqqTbTdmN7dIUU3Ryz4WuDqV06Y/ViMVO4VDO05be0Spn6
         SDPeDl0o+a2zS9Rpdq3DYW3U7yPoNwHaFx+Ctm7sSo4Gift8iCt14TqCL8P3K1WJ3v
         rVzXLAGGCfCTQ==
Received: (nullmailer pid 3212975 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: rockchip: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:28 -0600
Message-Id: <20230717225528.3212881-1-robh@kernel.org>
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

of_platform.h is not needed, but it implicitly includes of.h which is
needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-rockchip/rockchip.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index beea4564eed4..82102fbabf92 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -9,15 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_clk.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
 #include <linux/clocksource.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 #include "pm.h"
 
-- 
2.40.1

