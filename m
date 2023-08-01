Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C376B224
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjHAKqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHAKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:46:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DAF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:44 -0700 (PDT)
Message-ID: <20230801103815.207107339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b1myCBgZLHok+K09N26MfWzhxCP4cilngo+YbfwnshU=;
        b=3EKtAsaVLbSQ76mjgNoPZaN8a0q+gpf2LxDkyy04g4PJ9G4irT3JrD++brfcdfLo0clkCL
        MBF5nBUdLdY9uZLnJgoSVcSQA3AQnYjrXgCkwDYm9AkwfcxgWMMzHExeTXirQ+98RkahWV
        h1vzs/Hon5HOQFr6EJsaibwqg+yXhOrt1u9N6lCXRwDsmecSdxWS2c/6P9QjqC5Fl9pljY
        q9R9nvl+EZtoK9LPizB55znZF6Vat8YSntUeqS+FJrZmFopwBRwGpgFQXB6IF3Oxt+bEyN
        kp0/ITUptkMAWdHwzpvTuDLI4c4hxN2V0mBZ/75SvLVNSB/C2GJfdAss/ynS7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b1myCBgZLHok+K09N26MfWzhxCP4cilngo+YbfwnshU=;
        b=za6iITAafiEVp9sEOLVT4gyhWQGbxcplqujeeSs7jZCSkhpf52074QL+QC1mnYEs4IRo6/
        6yf+VwgXS47zlmCA==
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
Subject: [patch V3 01/60] x86/cpu: Make identify_boot_cpu() static
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

