Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B875701E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGQW75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGQW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CC172C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BFD612FF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD7C433C8;
        Mon, 17 Jul 2023 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634753;
        bh=jTqlg+dasXYab0RstTETE4dV28+b6/mzxs6/MFJCZ/8=;
        h=From:To:Cc:Subject:Date:From;
        b=mHv+qYTFug/XWQ7lR8wQs3aTKIXK6uoKWNhFluoVFGesoYfsGSFXXyzSAJBLTc5T+
         O2ihraCWH40CAzXcQXpkkShe0/OabWsA9LJZjN6jJoCwwax5Y93XC9oOII1ejVjE8H
         JG+IW8VAVDN1U96RqnvLP8NbHo0xcvPvTQMqEmrwqjB6OrDg8Q8GJkkAsQpDCe8D1Z
         uRvXWU0OwnimQH8jFAnd4sPn311rLW7WQ/cam/QEjcixlhAYb5tb9wfRUgOj0bsleM
         eUNmBdlG8Lg+FtKDUX+oyl3G9ZVmyldbTYmTrRA/JasEnBNh7m2m4UHqFvbNYlVOQX
         tCBw+RBezQqHQ==
Received: (nullmailer pid 3213275 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: nspire: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:39 -0600
Message-Id: <20230717225539.3213182-1-robh@kernel.org>
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

Several includes are not needed, so drop them. io.h was implicitly included
and is needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-nspire/nspire.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 2d4abb0288b9..d20974a9fbc1 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -5,17 +5,10 @@
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 #include <linux/init.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-vic.h>
-#include <linux/clkdev.h>
-#include <linux/amba/bus.h>
+#include <linux/io.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-#include <asm/mach/map.h>
 
 #include "mmio.h"
 
-- 
2.40.1

