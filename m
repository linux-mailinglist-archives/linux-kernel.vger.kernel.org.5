Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C77BC74F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjJGMAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJGMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCBBD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:44 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eQCG1SubaLKcefX9RXX8VJmey2R9K7NERppFez/kQs=;
        b=fLJxRfVkH6YmuFj6bd7wJkrpzI5cWBYcxYwTpxFGvNNhekMMZ/DU8QJzkOw6FxyqM/nYbl
        ktbpU43K44GHpT6oIxGnUOTW9c6n0NJ8WOXZRoX6HEUYGLb83TzAEOOJW+IvTYSm7sbm8M
        30m8m/xiuwYwaJDwTpEhageo6FqmppODlVM2QmAhacI7l3J8Q0flLgPaxKNaEcgc+x/llj
        oIIIfm5ipI8W8+ZPevjVChYH28NvwAF9DRoaCWVEoVtXKAF08CLj96LMtnQraQzYjavx6O
        ikY3lYTpajd3kPeTVVI8E7T7jrA2OKzVTMIr4ZNSd1TBNiJ5HrIY0wS9oDhXdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eQCG1SubaLKcefX9RXX8VJmey2R9K7NERppFez/kQs=;
        b=tHdq5eK1hladga6W4RW9ZrjwiFVrWeb/8UsAFSgy9dfEWUBZ5/EX0t7fn55mBv3fqqgKQG
        fPI2h97WHJmZfYBw==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/renesas-rzg2l: Convert to
 irq_data_get_irq_chip_data()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C8e47cc6400e5a82c854c855948d2665a3a3197e3=2E16958?=
 =?utf-8?q?19391=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C8e47cc6400e5a82c854c855948d2665a3a3197e3=2E169581?=
 =?utf-8?q?9391=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <169668004265.3135.6097288316194548861.tip-bot2@tip-bot2>
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

Commit-ID:     8a4f44f3e9b05c38606b2ae02f933d6b64a340dd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8a4f44f3e9b05c38606b2ae02f933d6b64a340dd
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 27 Sep 2023 14:57:32 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:13 +01:00

irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()

Use the existing irq_data_get_irq_chip_data() helper instead of
open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/8e47cc6400e5a82c854c855948d2665a3a3197e3.1695819391.git.geert+renesas@glider.be
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 2cee547..96f4e32 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -130,8 +130,8 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		unsigned long tint = (uintptr_t)d->chip_data;
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
