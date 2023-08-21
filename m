Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6931B782EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjHUQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbjHUQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E22FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3H7M0iahbHCn9l4LZxcXETHPJsO9wjPufKyQ1dEYGc=;
        b=LoQ1JsYWaCkOkCKzqKQ5xXsIKGfVyYq8nK8IaORorC6bDyM/J2OQ5sEzLNvqWiIGAmFF50
        n6c9xZrKpZYhVz+ApxdmrnYwABF3uKGU0iDw/tHAKTOdDkmPKnUf2fWIWh0CFjZWCH49Gy
        2+fg54o7Bw62vw2ytEMhEIOUC6hcnOvycASrvLzWxgvKm1HKbZgE7z62p7MrSWvXM+548y
        ongcKpzay+Deohcw2T3/PTMAjhTLS1lN8M7DWne+zzezr5a5iBMYee28Ypa/rcsNJqzGX3
        4ZG2o3I/gc8Ktp8lKEnyLm7GzR87eW4Y1unWJnF4el4NDZSWQRF8byxg4gMLaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3H7M0iahbHCn9l4LZxcXETHPJsO9wjPufKyQ1dEYGc=;
        b=hxskQMKvrJf6qiOmyoW5Is6nDg95gG+LoFfajXApHSyHcDpNn6n8zoWdGxYGLmAhrCEvhf
        ukoZpbV1Jc0i1xCw==
From:   "irqchip-bot for Yangtao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ls-scfg-msi: Use
 devm_platform_get_and_ioremap_resource()
Cc:     Yangtao Li <frank.li@vivo.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230704100253.36045-1-frank.li@vivo.com>
References: <20230704100253.36045-1-frank.li@vivo.com>
MIME-Version: 1.0
Message-ID: <169263708370.27769.167151814933190878.tip-bot2@tip-bot2>
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

Commit-ID:     32b5f8a6f5de384291ea4083541ad10725c7a054
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/32b5f8a6f5de384291ea4083541ad10725c7a054
Author:        Yangtao Li <frank.li@vivo.com>
AuthorDate:    Tue, 04 Jul 2023 18:02:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:49:11 +01:00

irqchip/ls-scfg-msi: Use devm_platform_get_and_ioremap_resource()

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230704100253.36045-1-frank.li@vivo.com
---
 drivers/irqchip/irq-ls-scfg-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index f5ba3f9..f31a262 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -349,8 +349,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
+	msi_data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
 		return PTR_ERR(msi_data->regs);
