Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC1782EED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjHUQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D47FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5Q8KWv9Htyait2nAUglQg3x/dnPYHpHm85MPujE/8o=;
        b=clgIbDMJClAYt3vDAZM6XbIYTVR0vKOLdNlHHEUgU/7Kc5qP7lnf+5XWowcpm1Njf6NoXw
        IAooGpGFwi2mOgUfIok92zWhzEuUprWEztymBYRvg7BRAtMc3eXLEECtTXAEMHoMyUR57K
        z8SVx7eOpRHsYQ3TLQ3rYICdvJnbUiLrE29f4gWmquFUphhwFj5FSDW7R0xSyRcJ0EKXU/
        njaCDSGEo8/5QwCQz+EfZsmWzyUAUjQr1jr4odRQTJiVXlIkAwSQUHAs9UOADwP8m/aQ5Y
        OXZ3+zsLwX9WmcUBdioSfmkBTeIYmuOHPhoksVrPh5bHV6BCYdO/UrVT2GMHRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5Q8KWv9Htyait2nAUglQg3x/dnPYHpHm85MPujE/8o=;
        b=fC5yU2GtLbMSeEzAelPl+PPwnp6yFpqhVrxbO2Q7SAjJhpmG/1DP2OyLDrQVLg+KoWfV0+
        IxQSCYYyQi0vhADw==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/xtensa-pic: Include header for
 xtensa_pic_init_legacy()
Cc:     Arnd Bergmann <arnd@arndb.de>, Max Filippov <jcmvbkbc@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230810123404.1222332-1-arnd@kernel.org>
References: <20230810123404.1222332-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169263708704.27769.15387317980344902628.tip-bot2@tip-bot2>
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

Commit-ID:     9bdd26b6477f798e292d0c196b9a8e5b77ce5e1d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9bdd26b6477f798e292d0c196b9a8e5b77ce5e1d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 10 Aug 2023 14:33:54 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:40:08 +01:00

irqchip/xtensa-pic: Include header for xtensa_pic_init_legacy()

The declaration for this function is not included, which leads to a harmless warning:

drivers/irqchip/irq-xtensa-pic.c:91:12: error: no previous prototype for 'xtensa_pic_init_legacy' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230810123404.1222332-1-arnd@kernel.org
---
 drivers/irqchip/irq-xtensa-pic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index ab12328..0c18d1f 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
 
 unsigned int cached_irq_mask;
