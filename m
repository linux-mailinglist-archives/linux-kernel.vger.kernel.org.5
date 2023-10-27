Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3027D95E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJ0LDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0LDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:03:30 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3D9C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:03:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9CC5240E01A3;
        Fri, 27 Oct 2023 11:03:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wuAf5zeu_bWk; Fri, 27 Oct 2023 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698404604; bh=Dy+rKlRhHr7ckNEvaix/+LTTf/XjXCe6Mhb+WYuUrqU=;
        h=Date:From:To:Cc:Subject:From;
        b=aHdg+LUt9RnRDP1RWbnqjammPozdiMnjjxPoe9/DMxhB9qUdY/gBXMC21+x0cBc7r
         o8gGTkqU7ffwGXitidWbgcRBedyAjuG+dj5N4GYKEv3CvV4Cr3V0CWAsszp7m/pWLW
         fs7n61PtQ1JHFf+z7Omy4B00YajMBRWa777tD2bC0Ns1zXXHHK409bfeMQPFLkcDi4
         NvDZf+Cd9XnMIkjE0Q2fQcjLPzAahcTXa6MH6kVPJxXX49qNQ9Db6/JLnzv//zy2Ki
         +pYZbbAoHnwzTu1TfFxsi6ggmX5dPzPhYwDDD4PVwaooYu15DCl+vcsRUeDjcXaG9O
         d0SSI9BLxeG9Dr4L5mT3hfSUGDaE0FE8fHaVAaTHrbkviMk9EtOyoVt+FfgCTYNKfB
         wt1H8jrP7ws71ZgMsUbqNStQFdtz+ATt1Uuj4VlGF63KR9YVR0qA+m81Qc+a9mJX4Q
         wrLz5t3q9HxctYU/TNOgD3nKq63DfU1MvEXnhzIjPQ2xP3v4G2+eoc6OzoD36Kb+qu
         o+22lwMef8bDJrvETPE5bCI/JVHXqHr4fOiKhELsluXAUzQOesu3t3fcNoyCvB1/3J
         vd5BSiBhOSTWp6cu0WTeMB44k/VmRjuCpE1KOHwLlJcTiKkrs+yNNi4KRIMp26ai1m
         DYwTkXmPxB3HATb2NptonVBY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C5CE40E018F;
        Fri, 27 Oct 2023 11:03:21 +0000 (UTC)
Date:   Fri, 27 Oct 2023 13:03:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.7
Message-ID: <20231027110316.GCZTuY9A06lb8w49c9@fat_crate.local>
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

please pull the current pile of hw mitigations improvements and fixes
for 6.7.

Thx.

---

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_6.7_rc1

for you to fetch changes up to 9d9c22cc444af01ce254872b729af26864c43a3a:

  x86/retpoline: Document some thunk handling aspects (2023-10-20 13:17:14 +0200)

----------------------------------------------------------------
- A bunch of improvements, cleanups and fixlets to the SRSO mitigation
  machinery and other, general cleanups to the hw mitigations code,
  by Josh Poimboeuf

- Improve the return thunk detection by objtool as it is absolutely
  important that the default return thunk is not used after returns
  have been patched. Future work to detect and report this better is
  pending

- Other misc cleanups and fixes

----------------------------------------------------------------
Alexey Dobriyan (1):
      x86/callthunks: Delete unused "struct thunk_desc"

Borislav Petkov (AMD) (1):
      x86/retpoline: Document some thunk handling aspects

David Kaplan (1):
      x86/vdso: Run objtool on vdso32-setup.o

Jo Van Bulck (1):
      x86/pti: Fix kernel warnings for pti= and nopti cmdline options

Josh Poimboeuf (16):
      x86/srso: Fix SBPB enablement for (possible) future fixed HW
      x86/srso: Print actual mitigation if requested mitigation isn't possible
      x86/srso: Print mitigation for retbleed IBPB case
      x86/srso: Fix vulnerability reporting for missing microcode
      x86/srso: Fix unret validation dependencies
      x86/srso: Improve i-cache locality for alias mitigation
      x86/srso: Unexport untraining functions
      x86/srso: Remove 'pred_cmd' label
      x86/bugs: Remove default case for fully switched enums
      x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block
      x86/srso: Disentangle rethunk-dependent options
      x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
      x86/nospec: Refactor UNTRAIN_RET[_*]
      x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()
      objtool: Fix return thunk patching in retpolines
      x86/retpoline: Make sure there are no unconverted return thunks due to KCSAN

Yang Li (1):
      x86/srso: Remove unnecessary semicolon

 Documentation/admin-guide/hw-vuln/srso.rst |  24 ++--
 arch/x86/entry/vdso/Makefile               |   3 +-
 arch/x86/include/asm/nospec-branch.h       |  67 +++++------
 arch/x86/kernel/callthunks.c               |   5 -
 arch/x86/kernel/cpu/bugs.c                 |  95 ++++++++-------
 arch/x86/kernel/vmlinux.lds.S              |   7 +-
 arch/x86/lib/retpoline.S                   | 186 +++++++++++++++++------------
 arch/x86/mm/pti.c                          |  58 ++++-----
 include/linux/objtool.h                    |   3 +-
 init/Makefile                              |   1 +
 scripts/Makefile.vmlinux                   |   1 +
 scripts/Makefile.vmlinux_o                 |   3 +-
 tools/objtool/check.c                      |  16 +++
 13 files changed, 258 insertions(+), 211 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
