Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA680EF26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjLLOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376915AbjLLOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16141100;
        Tue, 12 Dec 2023 06:44:27 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l06ZNNQIPzSZ7bNNiV8PB/YtNLzbYT34VxKldfXFS1A=;
        b=ee0Kdj6xilNBrNQD7uFdS+aTRkivoBdX9r2yQf387rkw2ia4BpCI0ZW7j4zkujcc57u18m
        C3TTz4hNVVA8Svj6ikiyS1BXiVHHZP2VtTiHM1eSwzgllJt6XWz20aiH/zMj2i8n45vWQB
        MqA55Wp8Z+xY3dqMOcLFrb9OwQhjROVxztXbql9zkUk1NYUxTF9cu0kSUW7MYkXA8oKehn
        u91s2QgSCbPsLn1YN1BKX792Ivh3lQhwO4JhYECH28YaWhTiwWhai8p6wykcP6Cv1orlLX
        LskgnhRYBoZ5OlBMZA9tHmWnODCjlEQTkj8vqO5Wy1UDzINGuwZwCLZuanWmdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l06ZNNQIPzSZ7bNNiV8PB/YtNLzbYT34VxKldfXFS1A=;
        b=p3yuVvqR2dDxG/8wTp0kVdaZkKhS1mOvsmXjYBiZfn4N/9g8EVA4mMR8axcIBN1eBi5xrl
        QTjoGoOIwy+K/5Cg==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Align struct member names to tabs
Cc:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <170239226508.398.9799498682458756779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     02f6507640173addeeb3af035d2c6f0b3cff1567
Gitweb:        https://git.kernel.org/tip/02f6507640173addeeb3af035d2c6f0b3cff1567
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

irqchip/renesas-rzg2l: Align struct member names to tabs

Align struct member names to tabs to follow the requirements from
maintainer-tip file. 3 tabs were used at the moment as the next commits
will add a new member which requires 3 tabs for a better view.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index cc42cbd..90971ab 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -57,9 +57,9 @@
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
-	void __iomem *base;
-	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
-	raw_spinlock_t lock;
+	void __iomem			*base;
+	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t			lock;
 };
 
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
