Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07505757046
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjGQXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGQXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D96171B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF8661168
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9BBC433C8;
        Mon, 17 Jul 2023 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634878;
        bh=MjF9pvhJoJr55QGnjcCWrSX7t2Z3SNWtHtBgNOT/aLw=;
        h=From:To:Cc:Subject:Date:From;
        b=dQ0ps6dZDV+8FJoXESuSK2+xE1zdf5jU8rBKEl5yXwvtesSiYZ9ICOhJL0ItCP8ZT
         5QnzqYA2JSxKRNllPk8pngGk09TNeL+o/SEg36mxfxRpv/wiPDN8jztiHwveTIOAho
         L9nSJTZrNa4KH1ycuXBGI2wJD4JdyzdbRmHAiNaRRCTVO5ItrAebnUg6BcRpnoEYIj
         8hfeKVlu7w/RQseMZlhua6zq160I1CO3vonMn61BBiT1JdPbj6bwa7TDxkAUlfZRtU
         Syx5LimJdeZ1WHE8WxCwqXG1C8D/5XzkjTHXOTOKNQ0nJD9O1nVAsF91gNTMssPFXF
         v+PzRjOzx7tzw==
Received: (nullmailer pid 3215606 invoked by uid 1000);
        Mon, 17 Jul 2023 22:57:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: bcm: Drop unused includes
Date:   Mon, 17 Jul 2023 16:57:03 -0600
Message-Id: <20230717225704.3215469-1-robh@kernel.org>
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
 arch/arm/mach-bcm/bcm_5301x.c       | 2 --
 arch/arm/mach-bcm/board_bcm23550.c  | 2 --
 arch/arm/mach-bcm/brcmstb.c         | 1 -
 arch/arm/mach-bcm/platsmp-brcmstb.c | 2 +-
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index fe067f6cebb6..cd29496da1ea 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -5,8 +5,6 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
-#include <linux/of_platform.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
 #include <asm/siginfo.h>
diff --git a/arch/arm/mach-bcm/board_bcm23550.c b/arch/arm/mach-bcm/board_bcm23550.c
index dd6e9cb785e0..3784b7372ad8 100644
--- a/arch/arm/mach-bcm/board_bcm23550.c
+++ b/arch/arm/mach-bcm/board_bcm23550.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2016 Broadcom
 
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 
 static const char * const bcm23550_dt_compat[] = {
diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 2e3385ced82a..43bc98e388bf 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -3,7 +3,6 @@
 
 #include <linux/init.h>
 #include <linux/irqchip.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 8989299ebdd6..07aeda1d66a8 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -10,8 +10,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/printk.h>
 #include <linux/regmap.h>
 #include <linux/smp.h>
-- 
2.40.1

