Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002D77AA60
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHMR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHMR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CDF10FD;
        Sun, 13 Aug 2023 10:26:36 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uX9N5FO/nLlv56DjWSB7ATh7mek9kQf+hWRoEmlZys=;
        b=mdN6WrQToOW0oEy0XWTnxB3O+Cu8Dr4lgizIuDvq9TL8czMBzegjd5oCu001oKyjJuvOSC
        uxmTMLmPZH6nWBKjVXiS0kG4nCWmLFOqYCrcMv284NK02oHZlio/A8P5hDy/xOlWK3a56O
        ReVOJDaXZdcnr1ZPnqIGA7TFaJ8vnQzlobkRHeKY2eB8fUOGBty+JCwn07b/sBBNAXjk1o
        mA3kt+0kFJfzqIy9Kz7iiNm02kdMSKKpIsBCdfAV1Wy7QGsE3PTDnasAWk9cqFSIMEpjXh
        oM8sqoZkIsst18+zTTMjmq9MrxMWVChWsRIC2jQJQR812vmngiwFSNgSJx8zvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uX9N5FO/nLlv56DjWSB7ATh7mek9kQf+hWRoEmlZys=;
        b=OdOYamFLGsHs00RLYqoEu6MGycaSwdDjbb7keEdgAD75SJhx18X8cgpXADMlCY7NHEbtNr
        7btntrffLq/z7JCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/mm: Remove unused microcode.h include
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.600549655@linutronix.de>
References: <20230812195727.600549655@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759443.27769.6060824581281462047.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     e5a8192942da0026f28a1713684bd46eded04c92
Gitweb:        https://git.kernel.org/tip/e5a8192942da0026f28a1713684bd46eded04c92
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Aug 2023 21:58:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 09:45:35 +02:00

x86/mm: Remove unused microcode.h include

No usage for anything in that header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.600549655@linutronix.de
---
 arch/x86/mm/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8192452..f1697a5 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -20,7 +20,6 @@
 #include <asm/tlb.h>
 #include <asm/proto.h>
 #include <asm/dma.h>		/* for MAX_DMA_PFN */
-#include <asm/microcode.h>
 #include <asm/kaslr.h>
 #include <asm/hypervisor.h>
 #include <asm/cpufeature.h>
