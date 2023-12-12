Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84480EF24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376955AbjLLOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376910AbjLLOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1AFE;
        Tue, 12 Dec 2023 06:44:26 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frVw2tKUZHRXjfmTO2gk1NZi4AkpXSfA/Me7+sGTxJw=;
        b=v/Y1VfD83aBoVi54QqrG22PGb9inhxJPt4gLkQlZU9IuGQ1DMd7Cx+leUgQvT/1VP/VDpZ
        OoEkn7koM0TIYnWgSAr0sy0Ngk0+naO0W6gAmHyi6SxqNIqXVPrtvU/9babqcuaEdh9CSp
        zX8JXCXUlu6NC8w/iLb7hqX1dMXc8anHOQifKH4AjS5soxvFOeYS1GjzYGvY/09A1M8tlp
        qyFdRhO/GniSqkXznMaNjAu3xFrkzXTaQ/m25p1IpL21CRsDkpRZYkb2EktMD+6MATzTsJ
        ZV+LV4kZo0KX/PILLAxvZiBf8CYuXpw9k5XB5XxhYpsn2jpK4jbJkAQM72KHkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frVw2tKUZHRXjfmTO2gk1NZi4AkpXSfA/Me7+sGTxJw=;
        b=CAfWqqVertrlY1wHIS8U01edoMm0NyppxOPnpU7EbQVqdqp80uNAKHkqBFf2EYJ/FOO+2o
        tKmE5zBw9gsUC4CA==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Document structure members
Cc:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <170239226436.398.15622434442121538440.tip-bot2@tip-bot2>
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

Commit-ID:     b94f455372ad6e6b4da8e8ed9864d9c7daaf54b8
Gitweb:        https://git.kernel.org/tip/b94f455372ad6e6b4da8e8ed9864d9c7daaf54b8
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

irqchip/renesas-rzg2l: Document structure members

Document structure members to follow the requirements specified in
maintainer-tip, section 4.3.7. Struct declarations and initializers.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 90971ab..0a77927 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -56,6 +56,12 @@
 #define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
+/**
+ * struct rzg2l_irqc_priv - IRQ controller private data structure
+ * @base:	Controller's base address
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ */
 struct rzg2l_irqc_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
