Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA04779E90
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjHLJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:31:08 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F7DA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:31:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E13C40E019C;
        Sat, 12 Aug 2023 09:31:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yv-EEqw_wUFX; Sat, 12 Aug 2023 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691832662; bh=hITeAnmBrwdl8aPTxgT9YvMyhOGAanSeik9dOl73LJo=;
        h=Date:From:To:Cc:Subject:From;
        b=TKHJhdlslF863TJS92n+sBaGggOgVngx6FQIYuOTu5ZIjKTIqnf0Md580TM7LImeA
         ymONtEpVv2issTDmdWq1l9sGF15+slwGib7wxUquu3rDGBLggi6ohS09oHB89D1KIY
         IbwfTXzdMkm1MYOa5lCZvknQozuAcvGU+KbQCaKa88OzPIWeyHy9ZoheUaROwugjWV
         bKCJFZ4MCR5OzcZzah5d/IYNbqUrt4goevDk45TWqkzBCvcoIav+fWqPbkdZ33MVsW
         cPX66MElJ+XFew7YKUMM6rUV/s9roUOGXZUIMGaM7bw/GBZXCE63xtQKov6WIrqb/9
         MbNZ1bY67sA7KPHOtIREfswtfxzu3zbRdabbt4q1kYkzZ+jfx9Z2Ei/k5ZRrEHyzAE
         WnjXjPkaoXIQGirvpJXNzPnbRJDljIXA7N927ZrlXN3TrSBf+p5WppKBXadc42lyaY
         l9SESgIorU1Ef4/oJnaKV0TIrJC+E82gm04bri0s8ub1kuyjStUnlRTJPdH3tZkAFW
         qWQzGQ+zqFXFpym05Gq1QUebHLZceeT16AdjqKlElsM/ahmN9FPhXROAFUvsCDgMjv
         Unul5Gy2d/iPGx780JzvErWeqhbsca1a+SANi+fsTyC56RomfcDy6p8lfOWw+GP5hl
         UWyu2GJhRLak+OuiMqP2KHrw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76CC040E018F;
        Sat, 12 Aug 2023 09:30:59 +0000 (UTC)
Date:   Sat, 12 Aug 2023 11:30:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.5-rc6
Message-ID: <20230812093053.GAZNdRTZ8KT1SMIUtQ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the first set of fallout fixes after the embargo madness.
There will be another set next week too.

Thx.

---
The following changes since commit cacc6e22932f373a91d7be55a9b992dc77f4c59b:

  tpm: Add a helper for checking hwrng enabled (2023-08-09 10:05:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_v6.5_rc6

for you to fetch changes up to 3477144c878a52fc3938a529186e81ea030e7779:

  driver core: cpu: Fix the fallback cpu_show_gds() name (2023-08-11 20:36:02 +0200)

----------------------------------------------------------------
- A first series of cleanups/unifications and documentation improvements
  to the SRSO and GDS mitigations code which got postponed to after the
  embargo date

- Fix the SRSO aliasing addresses assertion so that the LLVM linker can
  parse it too

----------------------------------------------------------------
Arnd Bergmann (2):
      x86/speculation: Add cpu_show_gds() prototype
      x86: Move gds_ucode_mitigated() declaration to header

Borislav Petkov (AMD) (5):
      Documentation/hw-vuln: Unify filename specification in index
      driver core: cpu: Unify redundant silly stubs
      Documentation/srso: Document IBPB aspect and fix formatting
      driver core: cpu: Make cpu_show_not_affected() static
      driver core: cpu: Fix the fallback cpu_show_gds() name

Nick Desaulniers (1):
      x86/srso: Fix build breakage with the LLVM linker

 Documentation/admin-guide/hw-vuln/index.rst | 14 ++---
 Documentation/admin-guide/hw-vuln/srso.rst  | 71 +++++++++++++---------
 arch/x86/include/asm/processor.h            |  2 +
 arch/x86/kernel/vmlinux.lds.S               | 12 +++-
 arch/x86/kvm/x86.c                          |  2 -
 drivers/base/cpu.c                          | 93 ++++++-----------------------
 include/linux/cpu.h                         |  2 +
 7 files changed, 83 insertions(+), 113 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
