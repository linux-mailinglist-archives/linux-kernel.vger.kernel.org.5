Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCC7DA042
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjJ0SZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbjJ0SYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:24:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D947C1FD7;
        Fri, 27 Oct 2023 11:23:14 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aR6R40gU+CjZs2UnXD/34D0hQZVTWiqk4inrpHJFb4g=;
        b=f0PYOyItFD7V+KIlKOMrlmi9LDhbvm5TAkY3LG2OY5kqzd0rtkNrvWIiCrxcVBN0OtGN49
        ICV+T6JBo54gm1NxP2hfyiO2O8W2ZWgNOS2yvw3pEKuMFgnYdP+aMaXl7eGXh3qDk0Opxo
        0V+vezN6hbu64tgeG/I5xeEAqCL5UQ9PguBMjkcuk3EulNEK2VRoJCdrQxAGvIxBXk1JQc
        VPf+WT652EuNPfbSUihyeG6ljxQzbxwfpCSkw/1oks4ASLf7XOH1X72EeC7j0xrXx7opcv
        4UEGbczfLpro/vNO3d9lVvy98sW0q3KZBLxoRCsk3GQumdzZ16VN7MUohBTKrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aR6R40gU+CjZs2UnXD/34D0hQZVTWiqk4inrpHJFb4g=;
        b=/T9BohRJJq+imsNg4tvWs9H2Mp4X5xPoODX8OudO9AEtylppI8XQI3dCHRvAxypu4wtxS6
        F5f6BJ+FFIo64zBQ==
From:   "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun5i: Remove surplus
 dev_err() when using platform_get_irq()
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
References: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <169843099187.3135.3931806046322225231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fd73c011a123a66d88998f356c920d33d87524cf
Gitweb:        https://git.kernel.org/tip/fd73c011a123a66d88998f356c920d33d87524cf
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Thu, 31 Aug 2023 12:14:14 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 12:06:41 +02:00

clocksource/drivers/sun5i: Remove surplus dev_err() when using platform_get_irq()

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

./drivers/clocksource/timer-sun5i.c:260:2-9: line 260 is redundant because platform_get_irq() already prints an error

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230831041414.66434-1-yang.lee@linux.alibaba.com
---
 drivers/clocksource/timer-sun5i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 69fee35..0d229a9 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -256,10 +256,8 @@ static int sun5i_timer_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Can't get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
