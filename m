Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDA7C5E93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKUmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJKUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:42:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050EC91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:42:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so554146a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697056929; x=1697661729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwSU+FrzFRbKZUOpzLtD4x7QEtM9uXRX1yERat/SRH8=;
        b=GWxy9VqnBi3ueftuQSZCtNgMBiOQqB3u89ecqkFYFL6buZnBKgLDsji/UpJXXOWCOK
         q7HqXH1fUa4iROibCjeGfUrUQk85MEzusSlb4yCHttf6hoBiWXEYYWCf06FWe+mZpvxz
         mH5qmkLYWu0dMY2/z2HTkbgMWJQNDUBGgRp3zZ7az4ppQX/lDvUayUu1SUBcA3u2kHy4
         u9aD8lZP/46arfo13cQaIbEI4ICarIukGuRcZSgCwjDwtL3SVtzNsx6VCUINPZ3igTfP
         1CCBr6r/f/AJeqMzCtPNOjJnMlq7ZzNgyNI4cZt603x0l7O06rQzhXvAe8Mn69VRwFQT
         KZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697056929; x=1697661729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwSU+FrzFRbKZUOpzLtD4x7QEtM9uXRX1yERat/SRH8=;
        b=kTgeOUtZQiFtfvbL/a/GR3YqnTn/S58Vmo3dWKH7oV9alBfhokWbPnnRzaStNPgfIz
         7oI9zWfm7c74bVhevir2UmRoTpjs8+xx/XVouGvvBou2MTtKo0X/7XXxWgyLIDpx5JJm
         UDAnvkS/WZmePswwK3snt09ZYsmisCYEiAVUg6lK1JjoErCWbYA3C/doGS3kHO/2TlXE
         ctiIbZ8kne6pfiAMK3rJ8XhSC/KLpPlys6bQiyPvDUkiENUXXVzojpe9gSebtFtY39qN
         tPA/0Fr5ask0JsgeaNtixqqM2RBzU7duCz7oQpSqHC4EMBhVcLPQ903VKcUjsuycAbRa
         yLVw==
X-Gm-Message-State: AOJu0YwQB2HVZatlaDG/NLG2VyZqbTOkPNl7Joy7a7DNdGSnSVKjkSQQ
        FxesHhQ0p4EicGl9AiraGBM=
X-Google-Smtp-Source: AGHT+IFr/El/WgsD3A+b8Y0RU2Ps5H8fcjSs/gMqaggsKiJVQFa1eSAb7tLirygfcCRO2pZAecuVXA==
X-Received: by 2002:a05:6402:1219:b0:531:1455:7528 with SMTP id c25-20020a056402121900b0053114557528mr16824569edw.40.1697056929225;
        Wed, 11 Oct 2023 13:42:09 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id k12-20020a056402048c00b0052ffc2e82f1sm9334504edv.4.2023.10.11.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:42:08 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
Date:   Wed, 11 Oct 2023 22:40:36 +0200
Message-ID: <20231011204150.51166-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement arch_raw_cpu_ptr() as a load from this_cpu_off and then
add the ptr value to the base. This way, the compiler can propagate
addend to the following instruction and simplify address calculation.

E.g.: address calcuation in amd_pmu_enable_virt() improves from:

    48 c7 c0 00 00 00 00 	mov    $0x0,%rax
	87b7: R_X86_64_32S	cpu_hw_events

    65 48 03 05 00 00 00 	add    %gs:0x0(%rip),%rax
    00
	87bf: R_X86_64_PC32	this_cpu_off-0x4

    48 c7 80 28 13 00 00 	movq   $0x0,0x1328(%rax)
    00 00 00 00

to:

    65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
    00
	8798: R_X86_64_PC32	this_cpu_off-0x4
    48 c7 80 00 00 00 00 	movq   $0x0,0x0(%rax)
    00 00 00 00
	87a6: R_X86_64_32S	cpu_hw_events+0x1328

The compiler can also eliminate redundant loads from this_cpu_off,
reducing the number of percpu offset reads (either from this_cpu_off
or with rdgsbase) from 1663 to 1571.

Additionaly, the patch introduces 'rdgsbase' alternative for CPUs with
X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
only decoding in the first decoder etc. But we're talking single-cycle
kind of effects, and the rdgsbase case should be much better from
a cache perspective and might use fewer memory pipeline resources to
offset the fact that it uses an unusual front end decoder resource...

The only drawback of the patch is larger binary size:

  text    data     bss     dec     hex filename
25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o

that increases by 31k (0.123%), due to 1578 rdgsbase altinstructions
that are placed in the text section. The increase in text-size is not
"real" - the 'rdgsbase' instruction should be smaller than a 'mov %gs';
binary size increases because we obviously have two instructions, but
the actual *executable* part likely stays the same, and it's just that
we grow the altinstruction metadata.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/percpu.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60ea7755c0fe..e047a0bc5554 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -49,18 +49,32 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-/*
- * Compared to the generic __my_cpu_offset version, the following
- * saves one instruction and avoids clobbering a temp register.
- */
+#ifdef CONFIG_X86_64
+#define arch_raw_cpu_ptr(ptr)					\
+({								\
+	unsigned long tcp_ptr__;				\
+	asm (ALTERNATIVE("movq " __percpu_arg(1) ", %0",	\
+			 "rdgsbase %0",				\
+			 X86_FEATURE_FSGSBASE)			\
+	     : "=r" (tcp_ptr__)					\
+	     : "m" (__my_cpu_var(this_cpu_off)));		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+})
+#else /* CONFIG_X86_64 */
 #define arch_raw_cpu_ptr(ptr)					\
 ({								\
 	unsigned long tcp_ptr__;				\
-	asm ("add " __percpu_arg(1) ", %0"			\
+	asm ("movl " __percpu_arg(1) ", %0"			\
 	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
+	     : "m" (__my_cpu_var(this_cpu_off)));		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
+#endif /* CONFIG_X86_64 */
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.41.0

