Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70478184F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjHSI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHSI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:27:34 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9D24C36
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:27:29 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F19740E0197;
        Sat, 19 Aug 2023 08:27:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gkGQFD5Y9VgE; Sat, 19 Aug 2023 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692433639; bh=4k/ZNYlzEXdkVQ2opaKpqy+SWyz2cq4kOA1hqN1AJtM=;
        h=Date:From:To:Cc:Subject:From;
        b=hLzfAuux+jRUDnIR7hLJpWic489cfQgytVIXpu/D2QfphyfO4ho7JrYNHzuh8ATVK
         GJIyUfZGT2pyT/8JRZlnsQ0V9UbatN7MpDfID4vZtQsI9BMJfIlv8mgXJx3i+34B0e
         SPLEZkUi4Ax7PZ0lkPfaGcSiX8i/1QAXxfnI8kNmi3KFQgWkwz8sb6wQXiUTMqkzZs
         TjUl32B7aNguQrlM8M3QgKgQTLbRFgLVR+SmaI+Sibx/jOZHUpKR/PlMeK1kWyLLNX
         mSU9xHfP8OwQnL2iCqTKOPH+jB25kskcwgFYHqkYanUqnHe2p5CS6yQLFzYbso+9n3
         5Tm6GkHh3kqorqbEcAz/98GTitMFO19TUfcOma/2WETcB3CHD7Z8Fd02xjfk+vonn1
         f4upH7XP6Y2f8Ljr+YccrIUubUFaqvBq+99h9ZepP6dblZRLtrFlVtSIxq7w9BluUn
         TXOXKG1IndSw8HrPGHENkO0vwqqK0wGPuoCLciKHs71QBMTKgg02+HE8fqBYQ9w/bk
         WTjVI9XDArjeXm4ioEFjcvZsoh/9Wdp1uB2luHIb3uGCBOH6HaB839RgPfz5a71KTs
         cowO5X9QktRbnOaXiPjUNDVHFaXZ7LuNhR9stEL1Eh16g4X5MPqFCKXDLMJmRsPyjm
         ywhIkL1tjijhmu2RzhyjyEG4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0576940E0194;
        Sat, 19 Aug 2023 08:27:15 +0000 (UTC)
Date:   Sat, 19 Aug 2023 10:27:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.5-rc7
Message-ID: <20230819082709.GAZOB83cQ687HkbMgt@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

extraordinary embargoed times call for extraordinary measures. That's
why this week's x86/urgent branch is larger than usual, containing all
the known fallout fixes after the SRSO mitigation got merged.

I know, it is a bit late in the game but everyone who has reported a bug
stemming from the SRSO pile, has tested that branch and has confirmed
that it fixes their bug.

Also, I've run it on every possible hardware I have and it is looking
good. It is running on this very machine while I'm typing, for 2 days
now without an issue. Famous last words...

So please pull,
thx!

---

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc7

for you to fetch changes up to 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66:

  x86/srso: Correct the mitigation status when SMT is disabled (2023-08-18 12:43:10 +0200)

----------------------------------------------------------------
- Use LEA ...%rsp instead of ADD %rsp in the Zen1/2 SRSO return sequence
  as latter clobbers flags which interferes with fastop emulation in
  KVM, leading to guests freezing during boot

- A fix for the DIV(0) quotient data leak on Zen1 to clear the divider
  buffers at the right time

- Disable the SRSO mitigation on unaffected configurations as it got
  enabled there unnecessarily

- Change .text section name to fix CONFIG_LTO_CLANG builds

- Improve the optprobe indirect jmp check so that certain configurations
  can still be able to use optprobes at all

- A serious and good scrubbing of the untraining routines by PeterZ:
 - Add proper speculation stopping traps so that objtool is happy
 - Adjust objtool to handle the new thunks
 - Make the thunk pointer assignable to the different untraining
   sequences at runtime, thus avoiding the alternative at the return
   thunk. It simplifies the code a bit too.
 - Add a entry_untrain_ret() main entry point which selects the
   respective untraining sequence
 - Rename things so that they're more clear
 - Fix stack validation with FRAME_POINTER=y builds

- Fix static call patching to handle when a JMP to the return thunk is
  the last insn on the very last module memory page

- Add more documentation about what each untraining routine does and
  why

----------------------------------------------------------------
Borislav Petkov (AMD) (4):
      x86/CPU/AMD: Fix the DIV(0) initial fix attempt
      x86/srso: Disable the mitigation on unaffected configurations
      x86/srso: Explain the untraining sequences a bit more
      x86/srso: Correct the mitigation status when SMT is disabled

Peter Zijlstra (11):
      x86/cpu: Fix __x86_return_thunk symbol type
      x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
      objtool/x86: Fix SRSO mess
      x86/alternative: Make custom return thunk unconditional
      x86/cpu: Clean up SRSO return thunk mess
      x86/cpu: Rename original retbleed methods
      x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
      x86/cpu: Cleanup the untrain mess
      x86/cpu/kvm: Provide UNTRAIN_RET_VM
      objtool/x86: Fixup frame-pointer vs rethunk
      x86/static_call: Fix __static_call_fixup()

Petr Pavlu (2):
      x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
      x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

 Documentation/admin-guide/hw-vuln/srso.rst |   4 +-
 arch/x86/include/asm/entry-common.h        |   1 +
 arch/x86/include/asm/nospec-branch.h       |  49 ++++++-----
 arch/x86/kernel/alternative.c              |   4 -
 arch/x86/kernel/cpu/amd.c                  |   1 +
 arch/x86/kernel/cpu/bugs.c                 |  27 +++++-
 arch/x86/kernel/kprobes/opt.c              |  40 ++++-----
 arch/x86/kernel/static_call.c              |  13 +++
 arch/x86/kernel/traps.c                    |   2 -
 arch/x86/kernel/vmlinux.lds.S              |  20 ++---
 arch/x86/kvm/svm/svm.c                     |   2 +
 arch/x86/kvm/svm/vmenter.S                 |   7 +-
 arch/x86/lib/retpoline.S                   | 137 ++++++++++++++++++++---------
 tools/objtool/arch/x86/decode.c            |  11 ++-
 tools/objtool/check.c                      |  45 +++++++---
 tools/objtool/include/objtool/arch.h       |   1 +
 tools/objtool/include/objtool/elf.h        |   1 +
 tools/perf/util/thread-stack.c             |   4 +-
 18 files changed, 236 insertions(+), 133 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
