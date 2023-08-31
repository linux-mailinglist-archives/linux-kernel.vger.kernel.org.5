Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A778F15B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbjHaQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjHaQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:33:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A612D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:33:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc4291239so13485767b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693499627; x=1694104427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLVkJMtFMtxqN/FlfG44AV8zInEiORUqCTslGqZ0Zos=;
        b=FEYbr5NOY/yssInoCh+qYqWCs8xJ6Zw8lt7EEsdNRJfgm5tHejPeICkoNzRXnhimlw
         OSKgb4BOlbWfp736fkGdp7k2/oTLuKvg+s1GrgAeW5EcW7QpVrnGrRiuKvJD5KnZiBPP
         ElQrl3ZI/As4Py9P2Xp+DG9wv01cNdfFpyS31Izn4+b6Uvyg7hvcjHAZBR6M+x/VZQiN
         slCRLnFGOPefHeKZN/FSDPcfuZIZQrv7ifMToTWvfcgkn5UwqQjVPIGCDPOIETGVVFmj
         tLP3/7BuF+tEJ7dyhXXn9ADDdTH0ggiUiq/Mjr/ENZAO/JZ8lr/yeuckxbveLPT3WLuc
         FuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693499627; x=1694104427;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLVkJMtFMtxqN/FlfG44AV8zInEiORUqCTslGqZ0Zos=;
        b=e6oUs/BfMcMAYRNvUFjO5CQUKH+bd6j+GgVk+QkE4wCkC5Uh5uhTDN3wuae8RqYM0x
         6c6zEdY6RfcKoXCw8689Jut+OE2XvjqrV67/SXtNKRX4FFXztEz8EZojn6pTJXMvlj+Q
         lqGCQkMBgJarnuzeGUuw8q3qd7GXCKMcgC9SlEBsRDSJb/VtOpZ/ZztK/FPcY59Y9NIj
         bdc6XZhumSJFeTSd7TobVqTNSlJGwwCGm5nbqmIgzB7OrdRN0n7GMev9aOqqE8BhajaL
         w57/tHxA7k3Gunt7Fto0gIEjlVXgi/cQ4TjJNhapzIvkZD6cmAvL91Aj6qh31/JqtTjC
         ev/A==
X-Gm-Message-State: AOJu0YxZgG71NN2OcM8bxPBzh8g6Bvf5+MDuLTIeP/oFUzWa7YgEG9wf
        TZnp+voR4nwslh7PEusf5mKNGndRCP6roghcJ2c=
X-Google-Smtp-Source: AGHT+IHBf6DssYHHHGzDp+ZZCZOF66xUxU07MR9mUuVHImcb4Q/TurPeCLfHb/qMIv/nPlAZpPXEVTmDap9poDfZ0rQ=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:892a:3b04:5286:6211])
 (user=ndesaulniers job=sendgmr) by 2002:a81:b105:0:b0:583:4f82:b9d9 with SMTP
 id p5-20020a81b105000000b005834f82b9d9mr206632ywh.5.1693499626839; Thu, 31
 Aug 2023 09:33:46 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:33:40 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOPA8GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC2ND3dK8zMLS1PjMFF0TC2NLY4vkZCODxEQloPqCotS0zAqwWdGxtbU AkP5UnlsAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693499624; l=2689;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=5wJlHBCko6R4VUFetDJgQLAa+BBT8kcL3VLV3bHqTXY=; b=LyNW0ykOyhWizRHCLzYXMxm0Nq0Nar2lwxOuLhJQr3jkgWqXkdznUFQ0Vr5FqxY1CHeFwukok
 Xz0DnJ2LnRRCylfMQ3UT1JHRd46qHV9S1JN0HGfdbXA/7DCAAZZdFDl
X-Mailer: b4 0.12.3
Message-ID: <20230831-unique_id-v1-1-28bacd18eb1d@google.com>
Subject: [PATCH] compiler.h: unify __UNIQUE_ID
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jan Beulich <jbeulich@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6f33d58794ef ("__UNIQUE_ID()")
added a fallback definition of __UNIQUE_ID because gcc 4.2 and older did
not support __COUNTER__.

Also, this commit is effectively a revert of
commit b41c29b0527c ("Kbuild: provide a __UNIQUE_ID for clang")
which mentions clang 2.6+ supporting __COUNTER__.

Documentation/process/changes.rst currently lists the minimum supported
version of these compilers as:
- gcc: 5.1
- clang: 11.0.0
It should be safe to say that __COUNTER__ is well supported by this
point.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-clang.h | 5 -----
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler.h       | 5 +----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 9b673fefcef8..ddab1ef22bee 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -14,11 +14,6 @@
 #undef __cleanup
 #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
 
-/* same as gcc, this was present in clang-2.6 so we can assume it works
- * with any version that can compile the kernel
- */
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7af9e34ec261..2ceba3fe4ec1 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -39,8 +39,6 @@
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..174099fdc485 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,10 +177,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
-/* Not-quite-unique ID. */
-#ifndef __UNIQUE_ID
-# define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
-#endif
+#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 /**
  * data_race - mark an expression as containing intentional data races

---
base-commit: b97d64c722598ffed42ece814a2cb791336c6679
change-id: 20230831-unique_id-483938cc20aa

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

