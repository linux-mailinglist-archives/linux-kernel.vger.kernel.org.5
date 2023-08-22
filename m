Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850FF784866
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjHVR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHVR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B15CF90;
        Tue, 22 Aug 2023 10:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804E46573E;
        Tue, 22 Aug 2023 17:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62979C433C7;
        Tue, 22 Aug 2023 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692725273;
        bh=IJT1zIifrckYwbgRixaFTijgqcJoxHtvhdNrCRkTsB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvrJoyPZ0Viq76vNJjsLiICj6oJjxCqTfy1rzCVww9XJTNEoVibiXhg5U+eXOmaQS
         LabZ1W6tnLC8UOIqk9N3Zrkw1Z98yA7tGnXSV6hnNx8yb0W7mvfOJA4UzC9hiKisaW
         bAAH+OzRilfvc2hYJp+RUDHAJv+RgNjOHdJP1Iuw=
Date:   Tue, 22 Aug 2023 19:27:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082212-pregnant-lizard-80e0@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <CA+G9fYvkBSb-i_6unB3bRLwRibVtZ3snYDe_gG+bsZehu3Hv3w@mail.gmail.com>
 <ZOTTxsW5IGhOO8IW@eldamar.lan>
 <2023082241-extradite-overpay-1754@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDmVdOkUVxWYHBPk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023082241-extradite-overpay-1754@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDmVdOkUVxWYHBPk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 22, 2023 at 05:51:27PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 22, 2023 at 05:27:02PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > [Adding Peter Zijlstra to CC]
> > 
> > On Tue, Aug 22, 2023 at 04:25:22PM +0530, Naresh Kamboju wrote:
> > > On Tue, 22 Aug 2023 at 01:21, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > There are 194 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Results from Linaro’s test farm.
> > > No regressions on arm64, arm, x86_64, and i386.
> > > 
> > > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > 
> > > NOTE:
> > > Kernel warnings noticed on x86_64 while booting the kernel.
> > > Paul E. McKenney reported this last week [1] and discussions email
> > > thread provided here.
> > > 
> > >  [1] https://lore.kernel.org/lkml/4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop/T/
> > 
> > Seeing the same warning for the 6.1.47-rc1, which is missing
> > 4ae68b26c3ab ("objtool/x86: Fix SRSO mess"). Unfortunately the commit
> > will not apply cleanly to 6.1.y. 
> 
> I tried, and failed, let me try again...
> 
> > I guess we need at least as well dbcdbdfdf137 ("objtool: Rework
> > instruction -> symbol mapping"), but not sure this is enough.
> 
> That gets messy fast, I tried to backport all of the 6.4 objtool changes
> to 6.1, but ugh, the changes were highly intertwined with many other
> things.

Hm, I applied that, but now I get build errors:

vmlinux.o: warning: objtool: retbleed_return_thunk(): can't find starting instruction

and

incomplete ORC unwind tables in file: vmlinux
Failed to sort kernel tables

Attached below is my backport, what did I get wrong?

thanks,

greg k-h

--dDmVdOkUVxWYHBPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="objtool-x86-fix-srso-mess.patch"

From 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Aug 2023 13:44:29 +0200
Subject: objtool/x86: Fix SRSO mess

From: Peter Zijlstra <peterz@infradead.org>

commit 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 upstream.

Objtool --rethunk does two things:

 - it collects all (tail) call's of __x86_return_thunk and places them
   into .return_sites. These are typically compiler generated, but
   RET also emits this same.

 - it fudges the validation of the __x86_return_thunk symbol; because
   this symbol is inside another instruction, it can't actually find
   the instruction pointed to by the symbol offset and gets upset.

Because these two things pertained to the same symbol, there was no
pressing need to separate these two separate things.

However, alas, along comes SRSO and more crazy things to deal with
appeared.

The SRSO patch itself added the following symbol names to identify as
rethunk:

  'srso_untrain_ret', 'srso_safe_ret' and '__ret'

Where '__ret' is the old retbleed return thunk, 'srso_safe_ret' is a
new similarly embedded return thunk, and 'srso_untrain_ret' is
completely unrelated to anything the above does (and was only included
because of that INT3 vs UD2 issue fixed previous).

Clear things up by adding a second category for the embedded instruction
thing.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.704502245@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/arch/x86/decode.c      |   11 +++++++----
 tools/objtool/check.c                |   24 ++++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h |    1 +
 tools/objtool/include/objtool/elf.h  |    1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -796,8 +796,11 @@ bool arch_is_retpoline(struct symbol *sy
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "retbleed_return_thunk");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -418,7 +418,7 @@ static int decode_instructions(struct ob
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->alias != func)
+			if (func->embedded_insn || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -1164,16 +1164,33 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 #define NEGATIVE_RELOC	((void *)-1L)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
@@ -1437,7 +1454,7 @@ static int add_jump_destinations(struct
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2327,6 +2344,9 @@ static int classify_symbols(struct objto
 			if (arch_is_rethunk(func))
 				func->return_thunk = true;
 
+			if (arch_is_embedded_insn(func))
+				func->embedded_insn = true;
+
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -60,6 +60,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 };
 

--dDmVdOkUVxWYHBPk--
