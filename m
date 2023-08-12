Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0742C779EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHLJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:50:26 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8296AF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:50:29 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA36040E019F;
        Sat, 12 Aug 2023 09:50:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w72jHJuYPd6m; Sat, 12 Aug 2023 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691833825; bh=s1B9ryKiEn3V1nS6SmXzSVK9rb18BhmZdbIb7yBnBzE=;
        h=Date:From:To:Cc:Subject:From;
        b=B4vX886cemcWquuSktfQGJIhccW973fQ5v6dTsTP24xmJvEoNuC4K8ZsMjePKhT4K
         metOQLg4UeiSU2cxFcT83df8AMw2u8Bksf488pEzNrj/gV28v6jByKxUKqd7HEtPxZ
         aUJKKRu/2t7YRWrQZCiqNN76+wWen4Gry9Gaqtt+xpiuR54qmc++UNFKW0wMwakU1N
         s2IzVkvK9oFou3nk2L5iBLen3HgMnvbOGlbnMmdvYkSPc9PDqS3J1J7/U1lGRv/kAr
         SHgMuQg2Xk8FklPvAKmWqX7L8ALTzrqhslSAAT3/XpNZcx477+1I8W5LyJdm9aB8Z9
         lc2DIZONY1fMUkRgTFfCBFWStRq27U/DV/7+GqoAeSMRtMo43GfZszr4lfIIzLj06T
         XgpxcOxETCiZH5f+tWIEgMNNkyCt4KPaPFSYoDhbUcuZsbH8FX+eRQQpZsW37qdUGR
         QXj4QgD9hbpQLMo0HI+Ml5Nv6qnhf/virZdy+2oUaZkc1upsAEpiN/D1ax3+jLfBy/
         8MWdJ1TzR/3yCkr3yMpdSnwusGBJ6hiaO3exL4lcQq6AIITrk1qC43qUCmrCknCBXZ
         0OZbAPUmJkP6J8MhZgPlfWR4o3Bx3mRqqdupWzqUi8FHxubj+l2l8nyMWTcbMVlTY4
         Waz55CnPDifVJznUiiUAh7nA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E19C140E0185;
        Sat, 12 Aug 2023 09:50:21 +0000 (UTC)
Date:   Sat, 12 Aug 2023 11:50:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.5-rc6
Message-ID: <20230812095017.GBZNdV2ZstbkUO+a13@fat_crate.local>
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

please pull a couple x86 urgent fixes for 6.5. There will be more next
week.

Thx.

---

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc6

for you to fetch changes up to 6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271:

  x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405 (2023-08-11 22:52:29 +0200)

----------------------------------------------------------------
- Do not parse the confidential computing blob on non-AMD hardware as it
  leads to an EFI config table ending up unmapped

- Use the correct segment selector in the 32-bit version of getcpu() in
  the vDSO

- Make sure vDSO and VVAR regions are placed in the 47-bit VA range even
  on 5-level paging systems

- Add models 0x90-0x91 to the range of AMD Zenbleed-affected CPUs

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/sev: Do not try to parse for the CC blob on non-AMD hardware

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Jinghao Jia (1):
      x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Xin Li (1):
      x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel

 arch/x86/boot/compressed/idt_64.c |  9 ++++++++-
 arch/x86/boot/compressed/sev.c    | 37 +++++++++++++++++++++++++++++++++++--
 arch/x86/entry/vdso/vma.c         |  4 ++--
 arch/x86/include/asm/linkage.h    |  2 +-
 arch/x86/include/asm/segment.h    |  2 +-
 arch/x86/kernel/cpu/amd.c         |  1 +
 6 files changed, 48 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
