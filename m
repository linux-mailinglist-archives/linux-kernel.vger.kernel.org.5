Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F9757021
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGQXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGQXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986C1712
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0243761168
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E3C433C8;
        Mon, 17 Jul 2023 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634789;
        bh=w16O/p1JmAQil+GKF+Te1GDFLCerOtCeggV7C++Q+oM=;
        h=From:To:Cc:Subject:Date:From;
        b=e9DltCNVrYMkE3KNchvO4i/D/fExd0Pd6WQdPFyt3s2hDKoPHpDKzUr+Xwzu3KN8w
         BzWz0GPZnr8+j7bzrLnioCYW1DH6P8UgZnVCvAgQU534J0u9fYpHmWPAXplrr2esxh
         A+XyigJg2epZLWC4PoHZQWKvhMxKcRVySwY+O8cB36PmcR3+btCLzAgva2YcATTGNM
         FpYUBX+dnEVkbjs4P59TlLy3AGW2hIfreWn/WiMvyu5+DkaLenJ84dSCNDnRc1EXvR
         Ckio+YKWsRTyxumfpb2pMPZlm9Zc33KUKHXxpzBY6xsi+zR4jQADlweEUOcC+Mm5ym
         NJZlrkLpvwfjA==
Received: (nullmailer pid 3214909 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: hisi: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:38 -0600
Message-Id: <20230717225639.3214794-1-robh@kernel.org>
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

of_platform.h is not needed, so drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-hisi/hotplug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index c517941416f1..f5655ad1c351 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include "core.h"
-- 
2.40.1

