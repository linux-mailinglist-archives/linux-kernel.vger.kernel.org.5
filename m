Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5E756DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGQUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:09:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0195E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:09:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso76120871fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689624570; x=1692216570;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsEmnlMQPV7Fd5Yb95V67Si+MXxbwtnWXXY+l8DoZjo=;
        b=oU8+D8GDnhaYzrA3Gni30BP/qU8SrINxACQ2xyNa2rCPhDarYG6/fs0siRXa7Yt3PV
         iCyVbNVcrozP4u8EFEcAg+09B0olC7CHYG934H1hwyjUeRNrLwkmp8/OuY9FNy9NAbp1
         FMXEZN+i9gLzShxOnTsCe6kVn/umg1f018FckZswUEtS0O4nw4aQPCktqgRHzLAA744W
         LwcfjeglrvrD3vm1OrdNttY3W+mTlyGYYRzBYxG+PQjZKjOUr6Cc3OZT4Vd0Bb3/8dCz
         NGhT0KCo3KGAJWzvKf1CNnZ+EX50bR+FUUrklTjSDd2c1tYa3Dw+CRg1MOM7UtbKaylZ
         rFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624570; x=1692216570;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsEmnlMQPV7Fd5Yb95V67Si+MXxbwtnWXXY+l8DoZjo=;
        b=Pq2DQRPitnW3lpTz0x+KAlYvko2RqkmvthUwqzhHnpsTtG3l0fKCgNZIybelyOW4jz
         /wfRrrRZaJtfM4wA1yrBtBWT1HOUGEkI/mWbeRGbeRqhOMSoK1ZoMPcWRbmctdsgfFzE
         9CF6w/UDf7rV7ABHQskWhlvtAxO8wnui5Og7I1w/I3k7myCnkx4K5zfUbFW12C1TvZTM
         +5SuqTbmJrpAdjY1/8FxqEm8It/Uru8S14vfWh78z/ZnB+5KRp/qj9vLdshF3J5PkBPn
         /Bu/Kv24zXUzrBRWwj4O3h+JDXSIgSq65Kt7MjknV4qhqZNg6tQP9VDw6Nx7kypDT5hq
         0lmw==
X-Gm-Message-State: ABy/qLa4iZc5gKDqp/nYjOJJv0Wi5uotkrBy7sss2jQGug/8Mn+gi1hl
        vdh0Gmr2xYWlw1PNL6MBfG0=
X-Google-Smtp-Source: APBJJlG4Iajle0ADfReJ6a6LzBxYlP+ylGGcYu7WnAvf/t4pEnz9ZPb9/BH2HQh4Y1B+3pu7dT3axw==
X-Received: by 2002:a2e:3815:0:b0:2b5:1b80:264b with SMTP id f21-20020a2e3815000000b002b51b80264bmr9195833lja.12.1689624569720;
        Mon, 17 Jul 2023 13:09:29 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k13-20020a17090627cd00b00997bd42d210sm84505ejc.205.2023.07.17.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:09:29 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Mon, 17 Jul 2023 22:09:27 +0200
Subject: [PATCH] arch: enable HAS_LTO_CLANG with KASAN and KCOV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-enable-kasan-lto1-v1-1-471e706a5c4e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPaftWQC/x2N0QqDMAwAf0XyvIDttIX9ythDWrMZ5upIRAbiv
 1v3eBzHbWCswga3ZgPlVUzmUsFdGsgjlRejDJXBt/7aRheRC6WJ8U1GBadldhj6EPsux+A7B7V
 LZIxJqeTxLD9kC+spvspP+f1n98e+H8rPhil8AAAA
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689624569; l=1432;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=YFPsm2kVtfSehCpbATGIVArV8bDH64E2Vvok0+5hopA=;
 b=f2qpVn5s2uyo2Brz2l2WY4ke7LkrHMJbyfhfiM/vAB+BSOVaVwuPJ0E5UsQdQLmCVh1SYToKlh2c
 KC/RmFLDBl0SrGQFOjU8UpzkDGc9D1JNpy4hRr+hcAPu7GBADIRq
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both KASAN and KCOV had issues with LTO_CLANG if DEBUG_INFO is enabled.
With LTO inlinable function calls are required to have debug info if
they are inlined into a function that has debug info.

Starting with LLVM 17 this will be fixed ([1],[2]) and enabling LTO with
KASAN/KCOV and DEBUG_INFO doesn't cause linker errors anymore.

Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
Link: https://github.com/llvm/llvm-project/commit/913f7e93dac67ecff47bade862ba42f27cb68ca9
Link: https://github.com/llvm/llvm-project/commit/4a8b1249306ff11f229320abdeadf0c215a00400
---
 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af2..61263ff92271 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -745,7 +745,8 @@ config HAS_LTO_CLANG
 	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
 	depends on ARCH_SUPPORTS_LTO_CLANG
 	depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
-	depends on !KASAN || KASAN_HW_TAGS
+	depends on (!KASAN || KASAN_HW_TAGS || CLANG_VERSION >= 170000) || !DEBUG_INFO
+	depends on (!KCOV || CLANG_VERSION >= 170000) || !DEBUG_INFO
 	depends on !GCOV_KERNEL
 	help
 	  The compiler and Kconfig options support building with Clang's

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-enable-kasan-lto1-656754c76241

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

