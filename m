Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5746A78B69A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjH1RgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjH1Rfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:35:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD112D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:35:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-591138c0978so52317927b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693244129; x=1693848929;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ijH1Yj+j9athjXIVwqCI/o9Npfye5Ao5bEGt89oFfI=;
        b=LSfDnQfSUKz48f90QQBZmhSyqt5dobsqkR/EKhHwvn7cVZ6RGnJ7BAZYWqrmw9dJtU
         PWc76dswvUTsptSE+vwqgQHg4E432ogmrq+q9jLj70u8U96C6+WjNS3xOeXPzrLsekWc
         h+5Ab1nVa/LBJ09j++3Emcej8g4iyqkNZXbu7/KCLC3xAImMsYMC8+5PszWVpfzA5Cdi
         Waz4PymyiiyC7BitZhDiG1QM1DL879bDTFzSVtlmbdYDTJRBHSS9U1TkhlRi3EIQWl49
         sNObiy/uGZwtxLwJmPMcKYinBlccWoKy7DHNiwrTKjZKuhvVzTwjBzRYCLKs6+X7jGgn
         B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693244129; x=1693848929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ijH1Yj+j9athjXIVwqCI/o9Npfye5Ao5bEGt89oFfI=;
        b=jJrk8fiIjyMqXpwahAijq57Z/0QugsAvyfjixlB5DHbe8WyNbX86Xchpd/FPKLhGoU
         9xeHvq//3bXMoYFU9DM7fAOPsC9bCBP+fcP+JakEgZrKoSYZX/FF+g5XdMGSEuIGvqO9
         xJlDoETjTOmJQVqsLkChb9Y8Wc/9CXP/9dp0arz5HHg01DmamULdJk/Gqg65TffYw1KX
         VpS5pY2oScyABPJ5YvMIRCdB6JhN2UeyqMPAwNxNj75l+PDLO3flHfKHXh00dRKAACQk
         9cFjjvaGDERHRkk0KJne60+0XYCu9BRdhLEk6OzeU6GSjcB/p07PIoaIWXd0Y/TdWZKK
         CzEw==
X-Gm-Message-State: AOJu0YxeYXkOlgpbqF3nzcMPmiXnF2re+ge4ZsC4uxcg3UDmEM9KU3ok
        eRpAgm5Ac1DBOFPf7pVUbqXxW6zrGHYQPSQHcS4=
X-Google-Smtp-Source: AGHT+IG+VaS3u5EP9g8Q/BufJIXYRNueFIz/Y8BPq0nGDiF/i3tXgC74dAg3Miss/xJpw/vbMjq4JXX5rEV9YpzFMGg=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a81:af5a:0:b0:58c:8552:458d with SMTP
 id x26-20020a81af5a000000b0058c8552458dmr796397ywj.3.1693244128809; Mon, 28
 Aug 2023 10:35:28 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:35:26 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN3a7GQC/x2MQQqAIBAAvyJ7TlCTlL4SEWFr7cVkjQikvycdB
 2amQkEmLDCKCow3FTpTA90JCMeadpS0NQajTK+88TLnsDA2FfmSg3XWuKhsQA0tyYyRnn83ze/ 7AU72xYFeAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693244127; l=1550;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=NZWt7Q1QVJ91SA9KKz/j+iZTrbry6bjB26P0pMnU6pg=; b=Lnj6TUFBIu7VQLLeAMH+ogFSMrSNMyHrSXXCmrtgK3wlnBjhUy65e3P0b8ELe49Ot/NrDh+ey
 mMP4H3R/vnDCbYmWUg1PYX7AhCj4SX0KW71DJ4i+pnvdz6PY03w3kZJ
X-Mailer: b4 0.12.3
Message-ID: <20230828-ppc_rerevert-v1-1-74f55b818907@google.com>
Subject: [PATCH] Revert "Revert "powerpc/xmon: Relax frame size for clang""
From:   ndesaulniers@google.com
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
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

This reverts commit 7f3c5d099b6f8452dc4dcfe4179ea48e6a13d0eb.

Turns out that this is reproducible still under specific compiler
versions (mea culpa: I did not test every supported version of clang),
and even a few randconfigs bots found.

We'll have to revisit this again in the future, for now back this out.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/252#issuecomment-1690371256
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308260344.Vc4Giuk7-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/xmon/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 7705aa74a24d..d334de392e6c 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -10,6 +10,12 @@ KCSAN_SANITIZE := n
 # Disable ftrace for the entire directory
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
+ifdef CONFIG_CC_IS_CLANG
+# clang stores addresses on the stack causing the frame size to blow
+# out. See https://github.com/ClangBuiltLinux/linux/issues/252
+KBUILD_CFLAGS += -Wframe-larger-than=4096
+endif
+
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o spr_access.o xmon_bpts.o

---
base-commit: 2ee82481c392eec06a7ef28df61b7f0d8e45be2e
change-id: 20230828-ppc_rerevert-647427f04ce1

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

