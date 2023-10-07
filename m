Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E837BC751
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjJGMBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjJGMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA4BF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:45 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqJ6iDQXqbjO7aIUOF/hNk0wFZR0pQOymhYZyQ7Ndss=;
        b=277BGSdLaYGAIpGC/2OSZ5Q/2V5RV2bIlj2R9h9J72UH95wpnbscClEaGkFbfQAw02kr0d
        blqDxKSRvbatKIbi+4BlajvBDauvzfZQ4LrAe/lkLkDc/Am5x7LB4oVuxELd0gQxxtjoCW
        +r8hqaLnRY3FYc49Y1495JSfqJHmdPDksvG7BE4M2tbYud6uK4AGi4RG50OQTUl5VFX6fM
        oU3DThLPkNttDqe4IAW21ZHM3Ure/K54kPnaEDls9JONhPhQtlBc+VThm59ilPfWZrfjvH
        edq7XFty44aTk+YY/hnFDK69nyoAKJZF80poIBDY4//eHZotSfjJbS+ADQqIsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqJ6iDQXqbjO7aIUOF/hNk0wFZR0pQOymhYZyQ7Ndss=;
        b=8M/6C+ltXFSYDk6EDF79y9y6/6/Aa/TRBEUo4INBwhcqtj9Q0cL1vpC2D3JzqU7mYq3GoR
        PYGM2ifbgA8B4/BA==
From:   "irqchip-bot for Ben Wolsieffer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/stm32-exti: add missing DT IRQ
 flag translation
Cc:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231003162003.1649967-1-ben.wolsieffer@hefring.com>
References: <20231003162003.1649967-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Message-ID: <169668004329.3135.14975229580572864483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     8554cba1d6dbd3c74e0549e28ddbaccbb1d6b30a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8554cba1d6dbd3c74e0549e28ddbaccbb1d6b30a
Author:        Ben Wolsieffer <ben.wolsieffer@hefring.com>
AuthorDate:    Tue, 03 Oct 2023 12:20:03 -04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:12 +01:00

irqchip/stm32-exti: add missing DT IRQ flag translation

The STM32F4/7 EXTI driver was missing the xlate callback, so IRQ trigger
flags specified in the device tree were being ignored. This was
preventing the RTC alarm interrupt from working, because it must be set
to trigger on the rising edge to function correctly.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231003162003.1649967-1-ben.wolsieffer@hefring.com
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index d8ba5fb..971240e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -460,6 +460,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
