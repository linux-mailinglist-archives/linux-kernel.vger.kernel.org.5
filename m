Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6E772AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHGQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHGQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:32:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771B1990;
        Mon,  7 Aug 2023 09:32:18 -0700 (PDT)
Date:   Mon, 07 Aug 2023 16:32:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691425936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JbN7AUthEz7Vb7oogc8x3K5whakgGYbtVj1/LIYwlc=;
        b=cwgTTGMz+jF3/LFgoiJwfRit/zX7oXyODUv6t2oiEZsgWuRDZgALeRHZwAu8Mel303eD39
        lGrrilrxMCWwvGqps7K8YlaRC5n7qpICmvg/qcolwzC/WqA9H5CouXUVWFaipqtyDEjIh1
        KAaarvAxpbTOLinHtqPwyjQUrWcZ9zScvHBiRvAj/Z0emqqqqSIfZ1YhLvs7BoPHL1U8Lo
        6RuUqvQghBHCeo5WDnaRF47T6bffMUOPlNq9LKQ7OD8oqOup9YI7Hy4niODVkF/54eqHVX
        T1EbqpLcFnf4yRs7knWvudmwLE4flQQdA7k0LuZitvrWiIgTWSqFNyz5iT0WnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691425936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JbN7AUthEz7Vb7oogc8x3K5whakgGYbtVj1/LIYwlc=;
        b=LarKtNU1T8yPtvk167NtRLqNf0saNVuRybu8mHeaO4wDKdv2D9qwODUCUqfzX/R4C5iosk
        gFJQ2QWdBdm27RAA==
From:   "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove unused function declaration
 cpu_set_state_online()
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230805110406.45900-1-yuehaibing@huawei.com>
References: <20230805110406.45900-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <169142593560.28540.9353044579569007442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     33af38d85b5c9e8ffe26f9712319ed28c5ded64f
Gitweb:        https://git.kernel.org/tip/33af38d85b5c9e8ffe26f9712319ed28c5ded64f
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Sat, 05 Aug 2023 19:04:06 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Aug 2023 18:22:42 +02:00

cpu/hotplug: Remove unused function declaration cpu_set_state_online()

Commit 5356297d12d9 ("cpu/hotplug: Remove cpu_report_state() and related unused cruft")
removed function but leave the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230805110406.45900-1-yuehaibing@huawei.com

---
 include/linux/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6b326a9..ed56b25 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -191,7 +191,6 @@ void arch_cpu_finalize_init(void);
 static inline void arch_cpu_finalize_init(void) { }
 #endif
 
-void cpu_set_state_online(int cpu);
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
 
 static inline void play_idle(unsigned long duration_us)
