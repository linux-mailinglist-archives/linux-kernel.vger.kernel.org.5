Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1067DA03D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjJ0SZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjJ0SX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:23:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A331FD2;
        Fri, 27 Oct 2023 11:23:13 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oD4CgE22kVR7H1tuqLA+CBy4FtkiLGc0YM3cqn0GhZ4=;
        b=Omw9D4NTvqazCIciExgHIlRJC7FgQrn+EifQ4vaPLMQQOyHJni++AHBWqtZU57/OGZMVWr
        Pd/nYuirZwAR9++DlYzfCpkijiuJ7ea+t875rgdJ1RQZN+RKmZLAhy+QiEF0jA6RCqyFvM
        iNXGsB5ok19oWoFv3CWkTCtOVgwKqBLfWfYI19mUzqgAtlCDTI2cQzty3M5pN88ELbpHu3
        PBKke7TRKNegX+hMFujKEUBxLVbHpqLlaS7sSSJJfuT2rB4PPp5p5w5dIBQdztRO28E497
        GiGWsa3DqIimhsekmBb+znWCETI/URxM+sTlwzkNdDNKqrb8EqfQOVviHAKP+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oD4CgE22kVR7H1tuqLA+CBy4FtkiLGc0YM3cqn0GhZ4=;
        b=KEeWAbKHYGBN9TI6gGkAVrenZv/lU3Wp1bRGmbIptHUBWjNZWQxxlLNytJxqzoOZevG7nI
        3ji6dW+YnD23W2CA==
From:   "tip-bot2 for Sunil V L" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
References: <20230927170015.295232-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Message-ID: <169843099133.3135.16121474221122398067.tip-bot2@tip-bot2>
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

Commit-ID:     d7f546c751e8c873302331af6a203ee61f894e9d
Gitweb:        https://git.kernel.org/tip/d7f546c751e8c873302331af6a203ee61f894e9d
Author:        Sunil V L <sunilvl@ventanamicro.com>
AuthorDate:    Wed, 27 Sep 2023 22:30:15 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 12:06:41 +02:00

clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu

The timer capability to wakeup the cpu irrespective of its idle state is
provided by the flag in RHCT. Update the timer code to set this flag.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230927170015.295232-5-sunilvl@ventanamicro.com
---
 drivers/clocksource/timer-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b..5019865 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -212,6 +212,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
 #ifdef CONFIG_ACPI
 static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
 {
+	struct acpi_table_rhct *rhct = (struct acpi_table_rhct *)table;
+
+	riscv_timer_cannot_wake_cpu = rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU;
+
 	return riscv_timer_init_common();
 }
 
