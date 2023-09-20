Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160257A71EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjITFWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjITFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A34F119
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wbH2UWPn7ZVKXlkjQXd3Ii2h2zPMBwxphVeZKwIKuXE=; b=MQjtQyeb+8H6HXu+fLUBoJc4oN
        1d/E+974ScSuSw0nzlMKBYD7a7sKXaU7ftDvvzJ+dV7mgHcA6wNqdUJ2D6oDV1c5dkvtw2eTd0wzK
        ILu/ggQWZTtrm4C2gdOraYwvlXvkM815lxwaDHDaDuFstuAD7Pp7SEZ/vSm6jVAzvKSIS5ZCCbOaw
        TApOPQsYOZuhlyB/Y1itlo1M9Vog5fQxgRuYKTWJYX6ba4DqfKOk+fzC3HF1g58wWXYoRqTzqApW2
        DhI8pv7byvUM4NzqOG7CFHK4ERYYxnDqoFEJc/PFy9UWJiIUa4EZlSpFf/Fm45l4tnXjN2VmQZH1N
        fLeLIvDg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipei-001tym-2N;
        Wed, 20 Sep 2023 05:21:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 09/16] irqchip: irq-xtensa-mx: include header for missing prototype
Date:   Tue, 19 Sep 2023 22:21:32 -0700
Message-ID: <20230920052139.10570-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add <linux/irqchips/xtensa-mx.h> to provide the function prototype to
prevent a build warning:

drivers/irqchip/irq-xtensa-mx.c:166:12: warning: no previous prototype for 'xtensa_mx_init_legacy' [-Wmissing-prototypes]
  166 | int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-xtensa-mx.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -12,6 +12,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-mx.h>
 #include <linux/of.h>
 
 #include <asm/mxregs.h>
