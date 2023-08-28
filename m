Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7F78B799
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjH1SyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjH1SyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:54:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9195
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:54:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbc0e0c6dso52805447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693248839; x=1693853639;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sc1uF7gYSefu5BRGSTzQndxC9k/7FyuIdQ087jpekoY=;
        b=VFkAo9hf/RrtBJZzuZAvW4Qx8GDm3uxmV2QYAA2I8g7alFugXamKTScEO35AzaFnad
         ffi7cGrV5TW3+vkFTqTW9oSAu54d1j4LtrxWy3KJTF9zrMxGbVHj7CsMq2cefVk5rFfS
         sxNE2ch3/N/YVclVnzOr482IvlO1P7loQOqGaByhYkIiJmFUYST0ckovmHJl5jz+Iarz
         mWXk8bSWmJd+ZhjytJeBn4PGOZT8Z0OabL73y8+6OSnKyFwOIP/5LFfqSTz+MXRUGNBT
         duGENSiwlo/SrYzEcjZ3Id5dSh1k0umyuGhjSw0zk2tAmKDP5EZSxWo3qyBT5LBvxFXr
         XOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248839; x=1693853639;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sc1uF7gYSefu5BRGSTzQndxC9k/7FyuIdQ087jpekoY=;
        b=Fz5GavrySuWA/aPF3of5QfCbM6/74R5kcgAyrN5GD+i6zTrbs6+ZWQb2I29/LGSiUc
         i5p5NN/Nyv3MwsFd8mUt4LYVQnJJI1ZMibjfxS6Qkww1eYPdNz2FsY42RYcSr1HGScXf
         nCE0KcfsxNiRCXkQZEfVIQN4xqaAbeeXNneT15SmCXySOJzsjoOBg5Z2AVNyiq4l7QdJ
         oUHtfmIJaraYmXtchA7t7vB0hn7q5Cqs77WsEpllG3cFWgfva2bJzCNnwLFKXGktd9sK
         suct32KUjHow//sO3Z6+Cofs8ErSLgPRuxj0MJDkPRNa8z9RALyb2OeD4kX2/u6DgYeb
         +n1g==
X-Gm-Message-State: AOJu0YxjPElFSPaK06E6MAVVimoW1M9XaKHsGI0S6Mhj4U2MqlnxERFJ
        EovGfs2WiKzEbLszr7D3QZxyV96+MYGW9nbSozk=
X-Google-Smtp-Source: AGHT+IHIGJhr7wGTI0i0gH2lGeGCeQNJBVOzftarFxDTgmZ89qvKukPAw9+LhRJNC0a4S9ggs5VITwvLEoUEcw1Hj/0=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a81:af03:0:b0:583:9913:f293 with SMTP
 id n3-20020a81af03000000b005839913f293mr836637ywh.1.1693248839355; Mon, 28
 Aug 2023 11:53:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:53:57 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAETt7GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyML3QoLs/i0nGLd5DSj5GQTyzQTgzRjJaDqgqLUtMwKsEnRsbW1AAP n8AxZAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693248837; l=2210;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=igqcf0msY5QTRQo1MI53i8OCCw46cUhpJvhlSkjr9js=; b=O/AHHJMNw11K4Mjvdph2kcwznwcnbyuKDmEfeEsEdtbLNC7cl0Y4Ds5en/q/zRFEvScTkuUMh
 Q9ZPz2OSsiJBEF1CzZEWB/bx5LNAHREdAkOJJkpShgoLK26lBNDjlqt
X-Mailer: b4 0.12.3
Message-ID: <20230828-x86_fls-v1-1-e6a31b9f79c3@google.com>
Subject: [PATCH] x86/asm/bitops: Use __builtin_clz{l|ll} to evaluate constant expressions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
        Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-parisc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl() to
evaluate constant expressions") and commit 2fcff790dcb4 ("powerpc: Use
builtin functions for fls()/__fls()/fls64()").

From a recent discussion, I noticed that x86 is lacking an optimization
that appears in arch/powerpc/include/asm/bitops.h related to constant
folding.  If you add a BUILD_BUG_ON(__builtin_constant_p(param)) to
these functions, you'll find that there were cases where the use of
inline asm pessimized the compiler's ability to perform constant folding
resulting in runtime calculation of a value that could have been
computed at compile time.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/llvm/CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com/
---
 arch/x86/include/asm/bitops.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 2edf68475fec..50e5ebf9d0a0 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -293,6 +293,9 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
  */
 static __always_inline unsigned long __fls(unsigned long word)
 {
+	if (__builtin_constant_p(word))
+		return BITS_PER_LONG - 1 - __builtin_clzl(word);
+
 	asm("bsr %1,%0"
 	    : "=r" (word)
 	    : "rm" (word));
@@ -360,6 +363,9 @@ static __always_inline int fls(unsigned int x)
 {
 	int r;
 
+	if (__builtin_constant_p(x))
+		return x ? 32 - __builtin_clz(x) : 0;
+
 #ifdef CONFIG_X86_64
 	/*
 	 * AMD64 says BSRL won't clobber the dest reg if x==0; Intel64 says the
@@ -401,6 +407,9 @@ static __always_inline int fls(unsigned int x)
 static __always_inline int fls64(__u64 x)
 {
 	int bitpos = -1;
+
+	if (__builtin_constant_p(x))
+		return x ? 64 - __builtin_clzll(x) : 0;
 	/*
 	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
 	 * dest reg is undefined if x==0, but their CPU architect says its

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-x86_fls-cf2cc49f40f3

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

