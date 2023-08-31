Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7978F2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbjHaSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHaSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:52:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA67FB;
        Thu, 31 Aug 2023 11:52:51 -0700 (PDT)
Date:   Thu, 31 Aug 2023 18:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693507969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tnclre8+qm6bY1pvrIO0AjJQzVjzGd+iNy32siCDyM=;
        b=wi4JKK4B7lMG8cpqYyjhjdFpGoVDep1LigSJYuhLVEdrn09gtmMRIbCo+a/DJofF3QPjD/
        fBdqtXXvKoI2f8ByGiqnW9w2lgeiB3qGIg/Q06jUE9ORFHdEkRK8V2dipYSCgttMXeOKWh
        QjbOPLA5ZtnRat14OCCbHHuTAb9XT1ZyitJ6kXCVImwXjLyvIaqkdiD624pduuiM7NgOQe
        8vwxqfbg2KEXW3SjpxSs/HmNQzb5G+KByf0nR8isuYwE8e5mnpxZumw9bqN/an+BF7BrbI
        wkrsoBgPNycUndZkE5GqgwM514wPb1J7UPP3PZWs98IV8xnZTJHdtiO/PNeA8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693507969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tnclre8+qm6bY1pvrIO0AjJQzVjzGd+iNy32siCDyM=;
        b=Fpzht2Gl7n/op9zd3o+jK9FrekoPxaISEghQaBRjaBU1ZaIhbqvbzRGrvBnHMBJOZAwSWh
        zUWo5ooJvqv5y0AA==
From:   "tip-bot2 for Vincenzo Palazzo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/irq/i8259: Fix kernel-doc annotation warning
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230830131211.88226-1-vincenzopalazzodev@gmail.com>
References: <20230830131211.88226-1-vincenzopalazzodev@gmail.com>
MIME-Version: 1.0
Message-ID: <169350796885.27769.16966802994476082698.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d87e89c2735772fbed933be0d19e032c1910a51f
Gitweb:        https://git.kernel.org/tip/d87e89c2735772fbed933be0d19e032c1910a51f
Author:        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
AuthorDate:    Wed, 30 Aug 2023 15:12:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Aug 2023 20:43:30 +02:00

x86/irq/i8259: Fix kernel-doc annotation warning

Fix this warning:

  arch/x86/kernel/i8259.c:235: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
    CC      arch/x86/kernel/irqinit.o

Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230830131211.88226-1-vincenzopalazzodev@gmail.com
---
 arch/x86/kernel/i8259.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 4d8aff0..30a5520 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -231,9 +231,7 @@ struct irq_chip i8259A_chip = {
 };
 
 static char irq_trigger[2];
-/**
- * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
- */
+/* ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ */
 static void restore_ELCR(char *trigger)
 {
 	outb(trigger[0], PIC_ELCR1);
