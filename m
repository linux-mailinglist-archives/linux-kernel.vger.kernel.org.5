Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3609677787C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjHJMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjHJMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93B2127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB8A65B8B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F9CC433C8;
        Thu, 10 Aug 2023 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670849;
        bh=it2lGyiKvKK8rJkGhAhtlW9olnQHGDG2I/ZknHi9ze4=;
        h=From:To:Cc:Subject:Date:From;
        b=iRTSP33m8xkuwTZYDD28i9Fy3VOuAoJnoJCusKb9ccUyKihVj2FNqf7q9jvDwZEve
         9W0jnz0zs0jhlm9qfP3PMr5QhkKGt9Qi2DwtgpPd/JWQlbLLTiZZm8E3d64tPdIYx3
         5gdB94yeOw+VAFmzA3g9u7ltEkoxbhF/nZosPcn9zi3mIzXiskTCgTdkq5RahpOz19
         SQGkcq9DyopFoPrJ6DhJJTs+xFiDGA+dW63LyzNSvPBLDEpQKCDsJvC1xP8KbjyDPE
         jOGB5Lot4RmsRhpvwFg/OztH/ilxIclADz1itvGzb9cAQagYca9MUiaREVwphGEayn
         9dmR49wchRh9g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] irqchip: xtensa-pic: include header for xtensa_pic_init_legacy()
Date:   Thu, 10 Aug 2023 14:33:54 +0200
Message-Id: <20230810123404.1222332-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The declaration for this function is not included, which leads to a harmless warning:

drivers/irqchip/irq-xtensa-pic.c:91:12: error: no previous prototype for 'xtensa_pic_init_legacy' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-xtensa-pic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index ab12328be5eed..0c18d1f1e264f 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
 
 unsigned int cached_irq_mask;
-- 
2.39.2

