Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512777787F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjHJMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjHJMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B22268C;
        Thu, 10 Aug 2023 05:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5C965B8B;
        Thu, 10 Aug 2023 12:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB96C433C7;
        Thu, 10 Aug 2023 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670859;
        bh=l3gsIWgCFdtpc7JpDK2jReDOmh4FCchTByIijNMoS1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jF7TZH60dNBSAWHv1xU3CdTi1BP/U1cTWiJX3A/BBVM4iltvB/Bz5x2YrcmCy+GgE
         PCFXbAaZuoH5OCWw6JtdM/BbdLntomS0jNV4hyB4xu62J6qeeFooJSvywjPsypPSwx
         lYuIrIOXGcjbdqNwEQ5iIIfyqmGn/guYFtf1814nQX+JblZ5xNhNrYQ0b8hzqD6vRs
         aFBEi2XOmONn/C77nw8vNYHL1ebsjsbPnmm6TXDeAqSLk5x94S6FBNiOUxzEBJ4Ww3
         U4P59TeGAtbLx6VnYNLR8hUGEsP3AetzpjXMSare1ysX+f6GhmtL2+/w6pDAAOREAq
         ymBYZ44i5iDjA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        wangjianli <wangjianli@cdjrlc.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] irqchip: mips-gic: mark gic_irq_domain_free() static
Date:   Thu, 10 Aug 2023 14:33:55 +0200
Message-Id: <20230810123404.1222332-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810123404.1222332-1-arnd@kernel.org>
References: <20230810123404.1222332-1-arnd@kernel.org>
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

This function is only used locally and should be static to avoid a warning:

drivers/irqchip/irq-mips-gic.c:560:6: error: no previous prototype for 'gic_irq_domain_free' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6d5ecc10a8703..76253e864f230 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -557,7 +557,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 	return gic_irq_domain_map(d, virq, hwirq);
 }
 
-void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
+static void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 			 unsigned int nr_irqs)
 {
 }
-- 
2.39.2

