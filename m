Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA03782EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjHUQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjHUQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CBEC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS2dzeU2aC7oxd0XBgweSocIaBD4c+USkthmq/tTmKU=;
        b=c+wzihCOOCRjr8g45WDX3PHF2/s1fwL4Gl1pTZOMZnr1HrdwTr+IY4wWoaaFQnsPMWmBnQ
        7KCJ+UlR8wUnWtLnX/7Y59ZXuJ+kHmco+/vybpgZ4MDWnyPmF/qLnycTpfBGZPfTRgvj4N
        7mSjkpUFxKUHUMXlpR8IIcJDXR+xJd8v5J8LX4SkC7iohka3hWm+8kULsJLvKPZ+cXd387
        x2qxwBaqM3O/+4O7zaDE92KZCJ3BCg8Cfg+VWh0b5+h/2GCGfVV2UZTGZdqjBXKKlktZht
        qGCEHz+1Y7GbOyZMNeKe2bEaMKkRIyYERQ3E9+u8VIkoxFyVWmy9gP/u7gR8qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS2dzeU2aC7oxd0XBgweSocIaBD4c+USkthmq/tTmKU=;
        b=UhPU7Z5BUfMUoDXWB5XURJ5rtme+bQQ2ZpLM9XzPCEbjWyWLT5Odvu87Q3A9+cQvsP01bD
        /GFZ8YFPqnCt53CQ==
From:   "irqchip-bot for Huqiang Qin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add support for Amlogic-C3 SoCs
Cc:     Huqiang Qin <huqiang.qin@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230628091533.3884385-3-huqiang.qin@amlogic.com>
References: <20230628091533.3884385-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Message-ID: <169263708219.27769.15374105447668886881.tip-bot2@tip-bot2>
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

Commit-ID:     19b5a44bee16518104e8a159ab9a60788292fbd4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/19b5a44bee16518104e8a159ab9a60788292fbd4
Author:        Huqiang Qin <huqiang.qin@amlogic.com>
AuthorDate:    Wed, 28 Jun 2023 17:15:33 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:49:12 +01:00

irqchip: Add support for Amlogic-C3 SoCs

The Amlogic-C3 SoCs support 12 GPIO IRQ lines compared with previous
serial chips and have something different, details are as below.

IRQ Number:
- 54     1 pins on bank TESTN
- 53:40 14 pins on bank X
- 39:33  7 pins on bank D
- 32:27  6 pins on bank A
- 26:22  5 pins on bank E
- 21:15  7 pins on bank C
- 14:0  15 pins on bank B

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230628091533.3884385-3-huqiang.qin@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7da18ef..f88df39 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,6 +150,10 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
+static const struct meson_gpio_irq_params c3_params = {
+	INIT_MESON_S4_COMMON_DATA(55)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -160,6 +164,7 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
 	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
+	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
 	{ }
 };
 
