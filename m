Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009437684A4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjG3JbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG3JbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:31:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6F1BCA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 02:31:01 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CF631EC09A6;
        Sun, 30 Jul 2023 11:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690709460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Eb8HskRwtHAp7tRRAQWBF+pmgcnXcSlZcu7195NUeFc=;
        b=ICjr/kGWETYMMYeYA+lomqSphI3gg1sqgcBHWOaveLiNbMhjGSBh8CkKiPjEikx7oSynPa
        jgSIEPnLmjnQAWccwKa14caDLEhxpbIgMK4K6N6ctEYwMuIzgxbq4SCySJuFBF4PVQK1+m
        iX3WBTxXLaAmo0CUn1ARnDYUTWkXFbQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4ih45vNhAAws; Sun, 30 Jul 2023 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690709457; bh=Eb8HskRwtHAp7tRRAQWBF+pmgcnXcSlZcu7195NUeFc=;
        h=Date:From:To:Cc:Subject:From;
        b=jCyda7kOJoQeDxYi0hABH7I90RZcMnzWrNuAbrkwQf+X8r9obcfmSdAnK6QF7nP/S
         gVCWi81pW+0X40F0FI+Q5vKfafV9BoSNlrxnB3Jpt6iaPt6VqPAbRU/tlfLSK5a7em
         RueIFm7N/iBLODxXBNiTXBiCNEGlXyDgXiq5YxbfGfHKxsW0dZoNiS9f98XLRYTyPf
         RwZWukKhC9sN5kRTDrL44VxTP948kXvuoB2Sk7fkeAoYdY92y63fUF5BZAmPg/4F2E
         dkFznCNBd+IBQquqhrIsEgzTsmfNvKWWR7o8bZS/5vxsTqhwFMqX6I43DFTOctxDMc
         dzZflNn3xaajcwC7ut5tnccQk6AaSEaOiRjUPM7fobKn9d10ty0FzYHOqZuczUPrsW
         OZHLL4POJCW6ct6mcQqjZZ0p1ze9S4vreZbctoyHpmGOkTKRXwa+jm3JUOxUoJ8cVT
         tCylC3nYUQMAa5DmWTQpkkH3Iyq2rJ/rHPZ/YLqL2eR/NgqNNBMCj899HnNdjHHuFw
         C+btiV1NYBSNsayVc2zl+iAGU3PPNGIzaeIC+NiL/FeeypCM7YxkcO42L3IaQfW5M3
         0ClHJAOFwDJNtBEwvBsEmwWoE0LnsxozJy+pyyeECKCnOWBzUbNXnEq7BydqPMRxni
         eipfWRmuAy/u4+Hoy13QbhWY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46CA440E0033;
        Sun, 30 Jul 2023 09:30:54 +0000 (UTC)
Date:   Sun, 30 Jul 2023 11:30:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.5-rc4
Message-ID: <20230730093049.GBZMYtycNKuAuP1+wB@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent x86 fixes for 6.5.

Thx.

---

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc4

for you to fetch changes up to fd470a8beed88440b160d690344fbae05a0b9b1b:

  x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled (2023-07-22 18:04:22 +0200)

----------------------------------------------------------------
- AMD's automatic IBRS doesn't enable cross-thread branch target
  injection protection (STIBP) for user processes. Enable STIBP on such
  systems.

- Do not delete (but put the ref instead) of AMD MCE error thresholding
  sysfs kobjects when destroying them in order not to delete the kernfs
  pointer prematurely

- Restore annotation in ret_from_fork_asm() in order to fix kthread
  stack unwinding from being marked as unreliable and thus breaking
  livepatching

----------------------------------------------------------------
Kim Phillips (1):
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Peter Zijlstra (1):
      x86: Fix kthread unwind

Yazen Ghannam (1):
      x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks

 Documentation/admin-guide/hw-vuln/spectre.rst | 11 +++++++----
 arch/x86/entry/entry_64.S                     | 16 +++++++++++++++-
 arch/x86/kernel/cpu/bugs.c                    | 15 +++++++++------
 arch/x86/kernel/cpu/mce/amd.c                 |  4 ++--
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
