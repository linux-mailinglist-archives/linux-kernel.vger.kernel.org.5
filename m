Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027B75F856
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGXNdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAA1B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:48 -0700 (PDT)
Message-ID: <20230724132044.644384974@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b1myCBgZLHok+K09N26MfWzhxCP4cilngo+YbfwnshU=;
        b=sbgH5INmkXJN1scV1wuwa2IDrW+L3YWqwDablFeq9IOSSAKhoKXvqU6oB/hYlAnfh1cOEn
        yVQBvjadZkgW5Kz1AGfrFCd7+U9gPZ0k25xwOto3q0f5utuAHAOqtah8BMpb/seyCzsrQv
        qTa0n6N/G24aUETPhz+eO5iTUMwpDXLIpqEMZSEdrquupWtRUhdatxEwHoJDndZ2Llbj20
        odNXn+nA41FbhntQI96pN+HjxQavwPQGZy6vG6LwN+LODn++yTa0R69VFeu+8PPfL8tAPN
        bmRlwkVHAwIWlpFUJKIvHwZMdbHYLpbhoVWERETwlMyD4qkXq+imWy4W+1Dvfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b1myCBgZLHok+K09N26MfWzhxCP4cilngo+YbfwnshU=;
        b=UUbRnNLZ28GzPTcU3O4ZzUOV9Xtzul1DA5Q0Kp9VtM+ScXCh4WuH9TPo5TujJSfEwoUNTG
        WPnrSYZaYJDE8xBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 01/58] x86/cpu: Make identify_boot_cpu() static
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:33:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not longer used outside the source file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    1 -
 arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -190,7 +190,6 @@ static inline unsigned long long l1tf_pf
 }
 
 extern void early_cpu_init(void);
-extern void identify_boot_cpu(void);
 extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1937,7 +1937,7 @@ void enable_sep_cpu(void)
 }
 #endif
 
-void __init identify_boot_cpu(void)
+static __init void identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))

