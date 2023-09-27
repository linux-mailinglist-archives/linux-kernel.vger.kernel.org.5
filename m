Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA97B0F15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjI0Wsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjI0WsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:48:14 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9342102
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c5fddcf2f1so135790325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854892; x=1696459692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h9NlhRD8hF3JGpC0yj7VRjIJqQSgsUALXY/NiPb6h0=;
        b=W9P9xxx/gnYx5osYpeI76vzlOzUEZfBvOLYTAO10FfRylT1mRq2bCMYcS1+hZft3AY
         eGZxePpApMxNN6c3WlWJBYdNELeMLib6wf1nyJ5oA4p5JDg7FCt1iW+URV2HCAkBPm2b
         eqQeNetpEjf0hkEkQ0YyuyF1TCs6Vs9UTvLLXUReoJtc6/JIdz05h1AAlp1beXi2B0lQ
         isFXBAT7jFPTgJQ8P+kuxLj6ro5eRYIb2ZFthvt5nDPRxsDGJoktPaerzsb8uVoQZzDu
         n62biOqvhU0Oo26flZg4+asLR8fOy1TKIRJYK5XRG5g8V4oNQYf9ODdXlY15hK8yzQ+i
         2DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854892; x=1696459692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h9NlhRD8hF3JGpC0yj7VRjIJqQSgsUALXY/NiPb6h0=;
        b=oWKkRB7qu8zr+7JcouQvxbeuXqo44qFvVnYE5l3LGh3qHItGKZQPzuHtLfPKib4Z7r
         i+kAY4TGNeQMY+tgrEDYR9HZNP9mdfVKgLbFueL4HQbHEv/fHwsJFcFYtQbtckJOBNfd
         t5f2OWadFWaqvUy5qPluC6F9CjAg0/vAZKnpihor4NgXSTkldVJpqwlTJzcNnU1JWKFL
         mW3wrkTwHCR8SN8e6bz+aENjPI70aWUTEA4Sk78LXMrQ1tBUUyU3PfF2VCRLA44rSq6x
         N2emBL1gUzbYKm5yiPMIvr+cwFRTveCG2n7HNEpwIpjE3v1C526rh7wFAecR0X9aSY65
         fFmw==
X-Gm-Message-State: AOJu0Yz71/nrM7dM5v3awK3SlMAcAJPP+laIxxttpcyL8rpIQfq6OPIJ
        zQPVVIQ1P2mW0+EDwZ96/DBtniKs+XD9RA3ZdHE=
X-Google-Smtp-Source: AGHT+IHK+0biBPVWxcHovzaXWOtINj3uMRtfg9f7R8EmqXuweOi238eHtIUJiD/eg0+vD4plv8qwETomHuFNs3pZDjQ=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:903:2350:b0:1c6:d25:8750 with
 SMTP id c16-20020a170903235000b001c60d258750mr47383plh.10.1695854892186; Wed,
 27 Sep 2023 15:48:12 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:48:04 +0000
In-Reply-To: <20230927224757.1154247-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230927224757.1154247-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=samitolvanen@google.com;
 h=from:subject; bh=4N5TA1RYsqEG6l9M0xplln+cBa1Qt0iz0MCbO5csiTU=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFLEdbuqhUGRkvHlpnRFoLVngxWUbGDzCKHZjB
 gXmrezGpZuJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRSxHQAKCRBMtfaEi7xW
 7uL3C/9V/COsf71wMsf8LAD8PbXFSUssu/Ulme80Bc+IvZbku+VH0yCAi+0as+ACJEpRsTnNbIQ
 pScn4vacTqNH+5w4IriZtrxed/+JlJlJ3oFsv2kgI5IxJP44McljBfgT1GRyGCHurDabqPsJYX5
 TaGUz9a7+gFF6iVgMLHb9uNWunfwjDU0mlECp6rp+occD5rm4k0XsmhUdYYDNB2N7vwL4ar7t7Y
 bRUrWcDXIDTzByGd1qZFeUPJ4XRuZmExIhm3XrLYrmbZvkYIH6oKzVv5knn9MHzzjsjfdiVDoME
 e2Bibk2Mj6F9ABYdpfXOcVNTMcGMZtsjvwmAv9Qx3j7PwTa5naJ0np9PriPDIM2jsshK4hOOa65
 Z+fMEcQII52/5PTX5HX9sXBqn/ly0o9tU3LTzbR4GGVs6W1Rzk4Yoden9lVz+2Ti9QdMMMmqjSM hvdcZcYO8OTXRXZtW4dNPx1A4wMY6pfJadi3BaYatIPrJyHzova74Yk95MQNhaBqyh0DU=
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927224757.1154247-14-samitolvanen@google.com>
Subject: [PATCH v4 6/6] lkdtm: Fix CFI_BACKWARD on RISC-V
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Clement Leger <cleger@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RISC-V, the return address is before the current frame pointer,
unlike on most other architectures. Use the correct offset on RISC-V
to fix the CFI_BACKWARD test.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/misc/lkdtm/cfi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index fc28714ae3a6..6a33889d0902 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -68,12 +68,20 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 #define no_pac_addr(addr)      \
 	((__force __typeof__(addr))((uintptr_t)(addr) | PAGE_OFFSET))
 
+#ifdef CONFIG_RISCV
+/* https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#frame-pointer-convention */
+#define FRAME_RA_OFFSET		(-1)
+#else
+#define FRAME_RA_OFFSET		1
+#endif
+
 /* The ultimate ROP gadget. */
 static noinline __no_ret_protection
 void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
 {
 	/* Use of volatile is to make sure final write isn't seen as a dead store. */
-	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+	unsigned long * volatile *ret_addr =
+		(unsigned long **)__builtin_frame_address(0) + FRAME_RA_OFFSET;
 
 	/* Make sure we've found the right place on the stack before writing it. */
 	if (no_pac_addr(*ret_addr) == expected)
@@ -88,7 +96,8 @@ static noinline
 void set_return_addr(unsigned long *expected, unsigned long *addr)
 {
 	/* Use of volatile is to make sure final write isn't seen as a dead store. */
-	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+	unsigned long * volatile *ret_addr =
+		(unsigned long **)__builtin_frame_address(0) + FRAME_RA_OFFSET;
 
 	/* Make sure we've found the right place on the stack before writing it. */
 	if (no_pac_addr(*ret_addr) == expected)
-- 
2.42.0.515.g380fc7ccd1-goog

