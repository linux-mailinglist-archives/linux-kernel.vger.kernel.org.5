Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0F782EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjHUQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF3FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzyQNhgX4GWwAO0kN4/Ngyo6ZQNLpdnG3VkZ/b8jOTY=;
        b=4C7oAiEBDSLQkIn3dOf4qz6oMzooeOhw7EFTM3aimVEGaTa1e+Afb3bOtCyHzAfCfFBScW
        TmKUvmKiGkcfzhaqrCaH4ub7kpg/vgu+YMkZd4g0k5AQsbN2BWTOo7u8AV1ZiakAgaItq4
        /5NOyuG4PFTngt5iZo7U8a5H/0a/tMGtwxEeb6YTdD/rWciWYTLc0dgtQntavRX3iHrhn2
        bc81cu1/hkjR1RhLWsyo5V30pC/Lw85km69yzWXMEIbd5W/m3mEs1RDaP3Rzlf0BnuiSzj
        gT5Xuz5Bs2wEVZ0gHeBRgG+oLtDAfQd7oIAUvD3/fOMvFqbfYUNm2brDFhn/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzyQNhgX4GWwAO0kN4/Ngyo6ZQNLpdnG3VkZ/b8jOTY=;
        b=I0H6UjWOaJ0okx8TVZ9SpojKPlmN9cXlQoIbYt5WYdZ/MUR34keB+T+lIOu5SYHjwZnwTQ
        dIwZkhcJ2L/SCEAg==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Mark
 gic_irq_domain_free() static
Cc:     Arnd Bergmann <arnd@arndb.de>, philmd@linaro.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230810123404.1222332-2-arnd@kernel.org>
References: <20230810123404.1222332-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169263708660.27769.13398521244738343466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     90e921d768677172cbb4be1d7597d556ae018020
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/90e921d768677172cbb4be1d7597d556ae018020
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 10 Aug 2023 14:33:55 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:40:20 +01:00

irqchip/mips-gic: Mark gic_irq_domain_free() static

This function is only used locally and should be static to avoid a warning:

drivers/irqchip/irq-mips-gic.c:560:6: error: no previous prototype for 'gic_i=
rq_domain_free' [-Werror=3Dmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230810123404.1222332-2-arnd@kernel.org
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6d5ecc1..76253e8 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -557,7 +557,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, uns=
igned int virq,
 	return gic_irq_domain_map(d, virq, hwirq);
 }
=20
-void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
+static void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 			 unsigned int nr_irqs)
 {
 }
