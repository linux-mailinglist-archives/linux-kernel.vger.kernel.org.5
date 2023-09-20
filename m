Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE097A71DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjITFWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjITFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BCF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=k1o2Ekmeu8BpquniHUsCXqdavZ5ZtIt3qUMpaG8idGY=; b=NLnTXwImvvhPaUU6GRVAi8580t
        OA5ZG+ZnbgUgFYPptAGJcweZcPwvfMSwh5faftayoVwj75hR/AwZ8B87EyR2JcVFBdW7P7XeobuRz
        hVzi7u0yFhYqOjBe8X0swguFJXh/SE6jndckWKlWxZIKNMwQTHVzSQrkOy9oofxvRHMo7g9o5oF/X
        O7BwRIkG6yoeKQWfsHTf2A6Vgen/Ij2U7GGhqMVRMzdig4nszt8DNteuwKdiI6RDxEpNjcqB9zkhL
        /NTaxEMAhPZsSK881YYDEXSk6W9fEmX9PRnr8TU18q0AkNjHFPebVHg/d2jN+44W07tkEW7DK7/It
        FaoYDFDg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeg-001tym-31;
        Wed, 20 Sep 2023 05:21:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/16] xtensa: irq: include <asm/traps.h>
Date:   Tue, 19 Sep 2023 22:21:26 -0700
Message-ID: <20230920052139.10570-4-rdunlap@infradead.org>
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

Use <asm/traps.h> to provide the function prototype for do_IRQ()
to prevent a build warning:

arch/xtensa/kernel/irq.c:34:17: warning: no previous prototype for 'do_IRQ' [-Wmissing-prototypes]
   34 | asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/irq.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -28,6 +28,7 @@
 #include <asm/mxregs.h>
 #include <linux/uaccess.h>
 #include <asm/platform.h>
+#include <asm/traps.h>
 
 DECLARE_PER_CPU(unsigned long, nmi_count);
 
