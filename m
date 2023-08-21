Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B557E782EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjHUQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjHUQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B57ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vym+lz9cNJAS9ggGgChev+ggKlIKd/nP1pNuX21dw5E=;
        b=GOtJEhBwxYm2ywfzxDIVston9tIvLfYIbRY2EoWKIBc18sA5WuIJC2waXudBRSHH4ZjGav
        KdDTkbNjJtzvpg4bQFycJPmZI/QiiL7XiZxUKJADQEWPMvdvnazobQHcrxFlfbCaWCnl+W
        WUh7sK+WSN4rsNPliC4USjs48A5BCo7tuQh3aCC0N/vV/CTzIbIK5EkdYARPcyK1++2E/z
        W/PO+nPDMeJR17mX2VkfEodMxXE5EYtQpbPNu6AmZH0ixpkqJ2iO0zRL0UooJCzX4CaBwQ
        fRds7/KDWQs/RGaRE5WTcZT+akqY6lFudfFJqqqmdQ3hBtnikUCwZJnV6rmEMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vym+lz9cNJAS9ggGgChev+ggKlIKd/nP1pNuX21dw5E=;
        b=U4PCdNgFyMZRDP+t4bumV1qzZ7U3bH1Tunn5y/mZDc24vba3x6g53TQeDzxzMXTsLW67Nm
        ZkgTXAchC9ifg3DQ==
From:   "irqchip-bot for Yangtao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mvebu-sei: Use
 devm_platform_get_and_ioremap_resource()
Cc:     Yangtao Li <frank.li@vivo.com>, Andrew Lunn <andrew@lunn.ch>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230704100253.36045-2-frank.li@vivo.com>
References: <20230704100253.36045-2-frank.li@vivo.com>
MIME-Version: 1.0
Message-ID: <169263708321.27769.10287078291229984853.tip-bot2@tip-bot2>
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

Commit-ID:     69da32b5438a9f3dc5b26eee0a94372b232a603c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/69da32b5438a9f3dc5b26eee0a94372b232a603c
Author:        Yangtao Li <frank.li@vivo.com>
AuthorDate:    Tue, 04 Jul 2023 18:02:53 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:49:11 +01:00

irqchip/irq-mvebu-sei: Use devm_platform_get_and_ioremap_resource()

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230704100253.36045-2-frank.li@vivo.com
---
 drivers/irqchip/irq-mvebu-sei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 4ecef6d..a48dbe9 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -377,8 +377,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	mutex_init(&sei->cp_msi_lock);
 	raw_spin_lock_init(&sei->mask_lock);
 
-	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sei->base = devm_ioremap_resource(sei->dev, sei->res);
+	sei->base = devm_platform_get_and_ioremap_resource(pdev, 0, &sei->res);
 	if (IS_ERR(sei->base))
 		return PTR_ERR(sei->base);
 
