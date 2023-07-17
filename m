Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF948757023
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGQXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjGQXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900C1733
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8379661306
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FFDC433C7;
        Mon, 17 Jul 2023 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634804;
        bh=2nzkfnkwx2NP72BTWfe15D1y0jmgK6SX4uhWkSkYJGI=;
        h=From:To:Cc:Subject:Date:From;
        b=G6stOvb2JNMTKa9lqen1tFTGMnpaPdW8QQQoY0qCjkK0MKtvTs9CLusAI6X4/FgiT
         VczSKV4+Ycyn0qH4tFofUAxq5K4i602gyixd8PDYEIESrqFgL0JiH5gG5t0N8Jijnu
         acCn7/+14+P25dpBi6pMO/Et8WNUfDeJgV+ssQPFN2QnZgpF5If3uQJAq5MJb3Yxro
         dELR+iMqQLMXebemY1btvzx+XRhe77TbUIZKIw8WZA38W5pQLDzQ5valYVusIa87s/
         xX9IRzFFdO7IYkaDHAKLh0HDheM44PxGCsppS1bKJdzuXXPEHtFRC9lJxe55LURn+k
         jej5niFeA9kqA==
Received: (nullmailer pid 3212608 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: versatile: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:13 -0600
Message-Id: <20230717225513.3212477-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-versatile/realview.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-versatile/realview.c b/arch/arm/mach-versatile/realview.c
index feab66080ba2..a3933e2373d5 100644
--- a/arch/arm/mach-versatile/realview.c
+++ b/arch/arm/mach-versatile/realview.c
@@ -4,9 +4,7 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/cache-l2x0.h>
 
 static const char *const realview_dt_platform_compat[] __initconst = {
 	"arm,realview-eb",
-- 
2.40.1

