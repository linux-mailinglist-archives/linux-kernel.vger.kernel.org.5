Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EF77FD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbjHQSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354222AbjHQSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:12:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4A2D44
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:12:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d672f55d48dso152920276.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692295919; x=1692900719;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDpEeeNNR0Nw6EuE4P52nYwvS2tr5AEnMgO9JS9l+5M=;
        b=TaGbMUFBJl9KSgciaIgpVCisyqbCRpB7YYBG8v79mOmaHpt1tQW4gawLupbCsjGmej
         z0M22Qkxwd6H5Xf9tezwcGzF2BEM0GiWrlMbrqI6y1DxAhLEHpA4LEFNbzzvaS5/USQK
         lnCy83pmJ5KTWktENc5P093oPYM0W7geImacqNCB5v+MvPhMCV3KLqFUNdtuwxAttkjP
         dtl8Pb8QNhuqq+jGhdU0UI1QD77M36OE/e70pTSQuPwf6Xf8AlWO0BYWDs6MfgyskmLc
         s0mENOVB8d4jdzMDABjzbc2Nrq6t54AzWyred9TY2rPT9nehfBlceHHhguFaNgrKcA0v
         avfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295919; x=1692900719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDpEeeNNR0Nw6EuE4P52nYwvS2tr5AEnMgO9JS9l+5M=;
        b=Zspdd0Azkv6i67mDSD9mdcPb6XB+1dFm5INlBduBoIHEQtGo/G/GbpWwsTdlNV8Xgl
         OHdQWLYxYzpIfA6lQkgel8e4OUD3WT20fjpvpQsq1+iclZp7pxSTNACtHDZ6+FHctybz
         38npARWZ6qUSVE43XS4ElGsbE5Sz78GHnSFEP1/9fW7VNdM6xDQZX1rLa7p7qTKn7OWP
         mm/a7VV80v44GQhCTwe2h0qwTCEVfE4Oxi1pXfclN+fBvyMja2yvJwPIRgVZVR70s6s7
         m7eabj4Hnzvq4O+3KuomGFa1cWozTrCU2pCSTTE2YDm7pSxkbUx+UbaPu9EDRoACWyGI
         hY7A==
X-Gm-Message-State: AOJu0YweISPQu3uwVOs8KeuNQm3WJ87iY5sUBlAtBPbJFjikHiRYCXvI
        tzlU7teZ65inrujAxSYhfLL8yLKZz3AE/JoJxRM=
X-Google-Smtp-Source: AGHT+IHGCNqBSivcUqwjOFgkuqC7Ixw26kQNxulLbkpUGpA9QPWtOwJPpJ84qHhcCJciZbWLNwY8Ah3LFW97G3/jWMA=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:ede8:d843:1818:cd60])
 (user=ndesaulniers job=sendgmr) by 2002:a25:e7ca:0:b0:d74:347:1e3 with SMTP
 id e193-20020a25e7ca000000b00d74034701e3mr4153ybh.9.1692295919476; Thu, 17
 Aug 2023 11:11:59 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:11:56 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOti3mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0Nz3YKC5PiK3Pw83RQjC4sUCwNjM0ODVCWg8oKi1LTMCrBR0bG1tQA SG74bWgAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692295917; l=1306;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=KvMdBaUrJ04OP30COeFfEE9LlNaItBIz7QURy18B4Q4=; b=0evZ866zmAcV3WRRll2szvRKmqpke+TXcD3BeqNZENNAC0GzwFFUTYVL/l+EVlX7ETBXDWTYb
 1ikpSuCMENIDTDAuHTqXGGIONyo6p216JYBb88Z9dqYHLzGgZbHiDDV
X-Mailer: b4 0.12.3
Message-ID: <20230817-ppc_xmon-v1-1-8cc2d51b9995@google.com>
Subject: [PATCH] Revert "powerpc/xmon: Relax frame size for clang"
From:   ndesaulniers@google.com
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
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

This reverts commit 9c87156cce5a63735d1218f0096a65c50a7a32aa.

I have not been able to reproduce the reported -Wframe-larger-than=
warning (or disassembly) with clang-11 or clang-18.

I don't know precisely when this was fixed in llvm, but it may be time
to revert this.

Closes: https://github.com/ClangBuiltLinux/linux/issues/252
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/xmon/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index d334de392e6c..7705aa74a24d 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -10,12 +10,6 @@ KCSAN_SANITIZE := n
 # Disable ftrace for the entire directory
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
-ifdef CONFIG_CC_IS_CLANG
-# clang stores addresses on the stack causing the frame size to blow
-# out. See https://github.com/ClangBuiltLinux/linux/issues/252
-KBUILD_CFLAGS += -Wframe-larger-than=4096
-endif
-
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o spr_access.o xmon_bpts.o

---
base-commit: 16931859a6500d360b90aeacab3b505a3560a3ed
change-id: 20230817-ppc_xmon-d288d803610e

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

