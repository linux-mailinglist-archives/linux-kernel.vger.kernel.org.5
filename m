Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE21782EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjHUQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F05CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxb29NF0KumIhoIrce0BH+Vc5w3HBklR/hhHtC+FhZc=;
        b=z/xb8VE+7TYyrpr5b89YVDgOJUulDRSUOJEY83jmfJVm210O4q3DX6yMlNYk96DUZJy+j1
        01pGC0l/y4tDS+f0rWXgyNPv7O3Hmhhw3phgvpzB1vaW9tJWqSEQHESiCGwFeY6TH4sr+n
        zYk1GeajMWxnBM8Pr1W8jtu8F5oEwtjM26fBfE1s0exDJt4Gs5YlgLctabCARNBeED0nRl
        pz1o25I3QnluLNPWyRcpVWhIS1rJ+zqO1EPFVKSxov6QHRFoTjvumrDIqVBlDZ89DcfiPr
        +DJl8dYbCnSa+4nkJ7m8JYJGYcDtz+WWgYApOElvyD8D60j09IRXtknJ21Kd0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxb29NF0KumIhoIrce0BH+Vc5w3HBklR/hhHtC+FhZc=;
        b=PEWiEldZg972IkcXz2WeDV+hiaGG8HR6hci+qx1MQ1lKa1BHlhv1ZzaT1zPpkdAPUrYpO9
        yOgxRBpdHlp38DBw==
From:   "irqchip-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/orion: Use of_address_count() helper
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230726030741.1136244-1-yangyingliang@huawei.com>
References: <20230726030741.1136244-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <169263708481.27769.7213742246735909985.tip-bot2@tip-bot2>
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

Commit-ID:     70befedaf5b020a08d397e2d6a9c306f0f611cfb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/70befedaf5b020a08d397e2d6a9c306f0f611cfb
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 26 Jul 2023 11:07:41 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:48:59 +01:00

irqchip/orion: Use of_address_count() helper

After commit 16988c742968 ("of/address: introduce of_address_count() helper"),
Use of_address_count() to instead of open-coding it, it's no functional change.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230726030741.1136244-1-yangyingliang@huawei.com
---
 drivers/irqchip/irq-orion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 17c2c7a..4e4e874 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -57,8 +57,7 @@ static int __init orion_irq_init(struct device_node *np,
 	struct resource r;
 
 	/* count number of irq chips by valid reg addresses */
-	while (of_address_to_resource(np, num_chips, &r) == 0)
-		num_chips++;
+	num_chips = of_address_count(np);
 
 	orion_irq_domain = irq_domain_add_linear(np,
 				num_chips * ORION_IRQS_PER_CHIP,
