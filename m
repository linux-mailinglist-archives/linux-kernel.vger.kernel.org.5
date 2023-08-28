Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002278B8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjH1T7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjH1T6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8F188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fe210b7edso2222289a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693252729; x=1693857529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqxXsJhK/PDnu5QKzOuhVQVuGBQ7YV59awRNcw8M9KA=;
        b=5vbcngL8ZVHRFE2eljBR/WQoqnwHuLVs7upb4C37eJWQbZVjr56f/ur647yJ4AUyqU
         odlSa8/RjIkDV07G0UBaBb4auy8DU4amPuju8M5IQqLJYH54J4qila2NhRd+E1O4RyAM
         uVYOKvozn6NT8UEW8VWKOZJe/DKWNoXAIn9cnQYVR4AleyEg1/b63QvqUxI0dcSLbnMx
         XLuUylSfyiMonef/eNWAAMq+tnS4EWsKMBu8wIhTW3R0YLJ6tJf56CDFzDgaITSCuq+s
         BLuYHuv7RfEgVzf9k8LBhuxRvd2HXWmtf2Vk/OTijRK93Crc/qqwJGPUvgiTw7PzvnTZ
         ll/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252729; x=1693857529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqxXsJhK/PDnu5QKzOuhVQVuGBQ7YV59awRNcw8M9KA=;
        b=TF4mSj2Y4xjw+L8/RPckBSebxa9rWcYXh7RF+PNvfLCWAdD3ZpQ03CIM2KGPVVEl5v
         xaEjYX31LADPesxNxRSpXF1DnXlYCJaWTlsPfNB3qhzKHBbvYYSif8SxlHCeueliCXQd
         38AvA/zQYH+38xp3GRcSSFa/Ul2KdoFhTQdxvaTWlV/LUeqPcNWWxmBj156MwTaNsBKz
         XFru4oHH7qHzcxNGoXNIWxBrpi2j7OaDZYtboB4dVhJiiaqUMNiKRo2VhAKvNsHHKIxO
         wB2ROiWeIFFVa0wgRT5fHJ28gUU/Ys/Ss4zdnSPkA9ik1ul0DGsMG1QR7SZ0hg8TmVky
         pXnw==
X-Gm-Message-State: AOJu0YwZFW40w7Bd1lh5I6Cq95veQwD4Yvgt4G+gHs0UZXd6qTAoJiqX
        J8NmAUzqBTy2qDNKLJbKGP7Lu6DhegrJVOjrRJ8=
X-Google-Smtp-Source: AGHT+IFGsaaO0XSM/Y67KiglbiGwn9oCum6xrnQEFf9Pggoc6RCuQ0rJ2Xb5U12wKvaEKKMsCRfVVSyEDOKWowHVSW0=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:9351:0:b0:569:52d4:fb68 with SMTP
 id w17-20020a639351000000b0056952d4fb68mr2368998pgm.5.1693252729217; Mon, 28
 Aug 2023 12:58:49 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:58:40 +0000
In-Reply-To: <20230828195833.756747-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230828195833.756747-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=samitolvanen@google.com;
 h=from:subject; bh=P2l56HkzVV4iJDbhsS59ZlfJgm96l/buqsb6+trKTfA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk7PxqKl9k+yTdNALVx1ZMSiIiYkPp3ifD0Ueug
 LDeD+59dp2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZOz8agAKCRBMtfaEi7xW
 7ombC/44I2N+oNE0mhFWTI0lDlgL+4/JMQhfMKSufRM3U1T5OqabvtPwFHQhOXRz1TiwEcDr7i8
 5yQiZuqOXgg3iZ4h+9F4cRzw28ArehJIEGz+O7FO70FgOBNXOSHaWGcyv7VuHdprWhST+C1v9Zk
 ZgslARn9fBw5HJwmwr6bN8M9im4r9jKtVsPr55L3xnUWbk+knu12/aZpE/GGE0bbf3QK+N4vt3A
 0nNh0iiFlV4YayOAPFabrTDShrkvvWlE4rzF+fG11hd/h8APu37zoH57B2AywUWNj14p83mXT6k
 u9y2x57j40yu0iK/b1JflZvDK7CJ0s8ajtQhMOXhjDmApgyeWZVLMLAZTpKv4gs/oO2xodXiw4R
 ksl1GmDHjdIlhyeMTWWtCCcg/DIiAd6f1B740jP4kkXUDiP9Sy3P/G0MHt1K+RGieGHpaB5B13/ UvPppmx2PeR8h40O/fHIATSyyElr9SQ8Dg84t2Fd6nUgiqKsWp+OrKSdL0qF6hmaWxQ0o=
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828195833.756747-14-samitolvanen@google.com>
Subject: [PATCH v3 6/6] lkdtm: Fix CFI_BACKWARD on RISC-V
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
2.42.0.rc2.253.gd59a3bf2b4-goog

