Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D01782EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjHUQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A66FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e2XM2wsAXceMOmm9YHK69nGWkZysYH9QMtdHsSPlDo=;
        b=YWKw0hjDFq8zGr8uDjrYjMGKxm7TuoA95flec57Ff4wSjgV3BS5O+7I4ac0j1bDoCl1rf8
        4mLeeaInOnKTekVblARkmNPv0U6bVVIr5nXtYowaCzM1n/uqfORAGxdAca2Bvm6McgjdBo
        vC7rGbhc8drRvqLuh/RWLcN1zXQkLFxu6Xs+tL1qJj0t0l0QAaPxLVaP8DPQ+mRV3Ygpjz
        ZlGS5+eY0unT2uF/CywWVyQVk9feZ9SHiTXooC0YfqaQV64Yr24HPx47PJpN31Y1OaGK+T
        KMrj39UQEBVDyrFRdzPOehCp8mXoAUi/y5he/Z19cbnLFEuGb7satKJTjP52Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e2XM2wsAXceMOmm9YHK69nGWkZysYH9QMtdHsSPlDo=;
        b=JwbNQiFsqUWF6hKUxR2uM5PftMI3HUJfESVcRpLmTr9XJ/FvsdYM/eNhd3ti0PkX6OgoT+
        cEAFPw9B5UAiTsBA==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchipr/i8259: Mark i8259_of_init() static
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230810123404.1222332-3-arnd@kernel.org>
References: <20230810123404.1222332-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169263708616.27769.11978640366702332497.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     424a4aec7a2392d248e2f260ba571a01e24b8ec2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/424a4aec7a2392d248e2f260ba571a01e24b8ec2
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 10 Aug 2023 14:33:56 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:40:30 +01:00

irqchipr/i8259: Mark i8259_of_init() static

i8259_of_init() is only used as an initcall and does not need to be global,
so mark it static to avoid:

drivers/irqchip/irq-i8259.c:343:12: warning: no previous prototype for 'i8259_of_init' [-Wmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230810123404.1222332-3-arnd@kernel.org
---
 drivers/irqchip/irq-i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b70ce0d..115bdcf 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -340,7 +340,7 @@ static void i8259_irq_dispatch(struct irq_desc *desc)
 	generic_handle_domain_irq(domain, hwirq);
 }
 
-int __init i8259_of_init(struct device_node *node, struct device_node *parent)
+static int __init i8259_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *domain;
 	unsigned int parent_irq;
