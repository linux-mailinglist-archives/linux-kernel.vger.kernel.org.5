Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0C77D430
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbjHOUfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbjHOUe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:34:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5410F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-686b879f630so6261875b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131697; x=1692736497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ykk2Dcm0sp1r3wFF3O+L+QDwz/a2RXVAzUE310xTCE=;
        b=c51n2/tJShODyeeUWChM6SNmOtBH4TwAB27gHlz0U2MW1KhJAFsJAI7HodLDVzEs2L
         h5EacJeK3yQ7xI1bDM7pS/8+NTTnu/pBkkf0mHnOLxusk130BgOMc3UgF/ILE4pTCv3b
         FoK/mdVbDTdzIm+PesccCvkjIraV3wLcVysrd2PMSHMHQsQbcViexWNnSAbHE6yrDtgT
         Mp+VyMCTaEctp9R1ryTin05vgD7DzxczuWzmHabxbBnipkxhOH1Z8NXKF+B+bk3ZWN2C
         pzEoTOjVu6w2TWjI1tCV+5ZHtdXlLljOrV5rvKK0dr/ZGKr7YBnabTma9ayXOLsdZ9cs
         ecvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131697; x=1692736497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ykk2Dcm0sp1r3wFF3O+L+QDwz/a2RXVAzUE310xTCE=;
        b=BlmY6QCqYTOVoTzRIUih1vAU+GtmuIDD3WRbT9Xf/TE5VZF5RyI5KKlQiJzRa4fQVJ
         sds44cSIxSWyL7mIuD9bGrmqCC/b+MuM4Bo3+jQjKl+dhD1XGrK+48C3t3Xo5ATfEOvW
         NuBSgeC0Ny5AWK0StTMUSKYpw8GhRltx/yXNW5X8QmC2i3c6isCHS2sCaPSmmaKV1jUJ
         7IGbaGvtrLxAlNaiKhWXVVSiVGJQ4ybL6l9rSQyCv/laD0k3MY6NRP6Q2naCFVTGCb9y
         H5oSeLEk5TCjv8TitlPikfOy2lqxTvtNWlZHCrJMeHwLhD4d9qyMNJP+BO8kK3srmE40
         auWw==
X-Gm-Message-State: AOJu0YxblDjB3CEYKl11Pdo/7tSC7u9/qcOfocaLWlHYX6FTjDQMco41
        7zWK+dfFHSf3Iub+Ui6lVoyuCps4JbYLrlh3BbE=
X-Google-Smtp-Source: AGHT+IFSPEKlQSmP4El45E8vBc0Epq9faMbNSeZpAP4jMdZu51DXHIvs320ofYVLaVzWyPCFTx03x5OLJ9JW1V1TgBQ=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1a87:b0:674:1663:1270 with
 SMTP id e7-20020a056a001a8700b0067416631270mr6012423pfv.4.1692131697326; Tue,
 15 Aug 2023 13:34:57 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:34:49 +0000
In-Reply-To: <20230815203442.1608773-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230815203442.1608773-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=samitolvanen@google.com;
 h=from:subject; bh=ki2ulz3S+Qkr8AIV7YWzX5sRx6qIOMgf7DcUTP9c/kA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk2+Fi+17Bq1AKxHm6SJ6quZHGmn+eubZLGDQWv
 bi76aScYZaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNvhYgAKCRBMtfaEi7xW
 7uDxC/4yeVJIZQGthB7VhCrB1mQ9aPlWa4zl/qPRC5GlncPWQV/MwLuo1ExhOVxQY1M+pu82F+m
 8PqQG33dyzALoBf1c1t0RJgk8hXrSg+on+5gsx856SahKsjV3+GpMyptJgjPEwnNHk+6wKMMK8A
 N/pPZs3mhzf+AhJROOGKLcZi1Ux1G5qizF4mL1TsJXLT2ky85P+u9iE+XnlUUOVj0o6+zdRc6E4
 T3hgbyVAvct21OxraGNq6gZ4hFfI1gD0Vzy9TsNhYvkKUv6h9A3mjyabLDgnWYIneyLL5Aw8hLM
 778p+uRcOJ4tKxAH+wveS7E7YVuTsPIR0MtZTeW4TlXWx284O7O/LdzF0u0artPihMYgdyyeXkT
 fbWExG0nGe0BC399mEX2b1gOK/3yeNpSy5DzlUGN+aTa7vNStcHxmPR4yr6Qlfw7uDrg4g305Ra AkJHJ/qsdN+6PCM8BiYrPK7icqJ3WmLfwFC54pjnKI93e+BJiBx3TlG5aczelxjKucC60=
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203442.1608773-14-samitolvanen@google.com>
Subject: [PATCH v2 6/6] lkdtm: Fix CFI_BACKWARD on RISC-V
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
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
2.41.0.694.ge786442a9b-goog

