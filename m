Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421477653C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHIQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:40:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC801FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:40:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d4db57d2982so4998683276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691599233; x=1692204033;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9Uh1xaqmQWPyWIzvmOZ3IRjU5s2QYIsDIKiiZ3xylo=;
        b=dLpsdwSaoNUNlsstJVfWGJbPmhWUg2zQLIOoMOKWCssGTRei5yyqrfxze6pqUw3SnG
         wIwIkpjfgt6aiX+OHz5+GQPvKDIDsuk2PnAoj7kfkBD1Sc4kNjUh7ILdWpWs/CqP22e4
         bCyBHbzcxxoLJ0IWONrYWOD7/xyJYjsfO70tVowF70jro/Lug4hTj6r6CnlylHxr3Tu2
         OYMYV97tL+D90MadyukcuMyJWNMk1Zrdn3Z4ZcbsmdgZsgqy+wFd5GBVM6I12hydxHly
         9mhQ3+sQr4MGEBOpIQa8vTiLVDMNF6/RzO8EimnpvUFxoEVRLblInPE8lsikrkV85USl
         pgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599233; x=1692204033;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9Uh1xaqmQWPyWIzvmOZ3IRjU5s2QYIsDIKiiZ3xylo=;
        b=OvD4kz08MXN3IvAE4c6/zhBl9PFO+QfSxufOVCB/rTb+glWhbxmfa1lxskJOB9xfOo
         1ADFOVwvj8dEErFJif0F9X4izGIkmEupYq1wq/P31iYbsH7g0vWCeDd3TaVH7CIF6yqx
         s/4QYsNaYwFUreJ6QIfOItJnO8mEd/YPDogLPDnK2vAybMqaPtNs/IuCMtBukqhEjUa1
         oEV0rxNg1ON8bpi5I9LQAdNHcMIhJiYPRDDievgozZJn4e5VKwQJLznI89FaYwIjb6I7
         4F/L7LByf/ZnbknYjv+0smBgFc85zKba8oqbf0nYkmBKk1lfz6xhaTRnm9QiNIdh8Hfq
         iB6g==
X-Gm-Message-State: AOJu0Yzp/g1mGej1ZkZp+j+qjpa+juV1CuoLSCVochg10VmDQHOqMkqU
        psnJ9Xw5nfyf79jxragnKA16hfcowO2Xa+YaYpw=
X-Google-Smtp-Source: AGHT+IEdRx2t6Pwl+CGyiFXJ9KHcVF/Bxr8oDSV040ExOfMUeoB8h/USWWd278C5h3rekjP55EdDHww4R9B58GPV1tU=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e732:f13b:6116:f259])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:88:b0:d4b:df05:3500 with
 SMTP id h8-20020a056902008800b00d4bdf053500mr79796ybs.11.1691599232832; Wed,
 09 Aug 2023 09:40:32 -0700 (PDT)
Date:   Wed, 09 Aug 2023 09:40:26 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHnB02QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNL3fSUYl2LJAMTU7NEQwtTEwsloMqCotS0zAqwKdGxtbUATiN1ClU AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691599231; l=2771;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=IYfOsA7GlDBzKwWCtqWtZ36CUvirEIy8v5J2hXJeHZ8=; b=MABlvOg0KLVuP/KojfeTnVa5hBVWMaqbjHFCU8/E6MEiaJkAq2yVa4UwcJe9TbBBt3gTdBxFC
 S3gJe+ye9ZWAqevKCzS48nDzi4co8BQ8c4N4ZgWQjgL/u5SIBv2Ogi8
X-Mailer: b4 0.12.3
Message-ID: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
Subject: [PATCH] x86/srso: fix build breakage for LD=ld.lld
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assertion added to verify the difference in bits set of the
addresses of srso_untrain_ret_alias and srso_safe_ret_alias would fail
to link in LLVM's ld.lld linker with the following error:

  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:210: at least one side of
  the expression must be absolute
  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:211: at least one side of
  the expression must be absolute

Use ABSOLUTE to evaluate the expression referring to at least one of the
symbols so that LLD can evaluate the linker script.

Also, add linker version info to the comment about xor being unsupported
in either ld.bfd or ld.lld until somewhat recently.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Link: https://github.com/ClangBuiltLinux/linux/issues/1907
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Daniel Kolesa <daniel@octaforge.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/llvm/CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com/
Suggested-by: Sven Volkinsfeld <thyrc@gmx.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note that CONFIG_LTO_CLANG is still broken due to GDS mitigations. Will
work on a separate fix for that.  Sending this for now to unmuck the
builds.
---
 arch/x86/kernel/vmlinux.lds.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e76813230192..ef06211bae4c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -529,11 +529,17 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_SRSO
 /*
- * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
+ * GNU ld cannot do XOR until 2.41.
+ * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f6f78318fca803c4907fb8d7f6ded8295f1947b1
+ *
+ * LLVM lld cannot do XOR until lld-17.
+ * https://github.com/llvm/llvm-project/commit/fae96104d4378166cbe5c875ef8ed808a356f3fb
+ *
+ * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
-		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
+		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 

---
base-commit: 13b9372068660fe4f7023f43081067376582ef3c
change-id: 20230809-gds-8b0456a18548

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

