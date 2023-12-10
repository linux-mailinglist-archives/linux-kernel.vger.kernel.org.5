Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CE80BA35
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjLJKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:50:25 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF7C8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:50:31 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1D9B340E00C6;
        Sun, 10 Dec 2023 10:50:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 175pUVsJPMCS; Sun, 10 Dec 2023 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702205428; bh=Dq8IvhuNZiMEXXSx0hJc6s8kGAO1BBoQM5Wx/7z/oGk=;
        h=Date:From:To:Cc:Subject:From;
        b=cYDBvA+XSNK/eRO0SGrsW6/Mjlv9CVl1v+ZRY2HfB/rEDdrQK1kuCdDbQFOQpli00
         2u8HAQDgiYlfmFjbUp6WtU7T8EIByeTR5ePzCWMGiFyHqPm49vIV1nZaowrCO28+JC
         I9ipg4OoIfb5uv42u1D2FlJCNuidEY8582gNSPWAIEFxqNw78Q5g/EeTN2vdE7cyeo
         wYhIdiH/92ctEjOtLbQ/WsAH1cXurXn0qwIoD0aBFAc4nnfLZWMWM2x6pwsj2keYOc
         phf/pWchzzt7HPjU6//k0Qm7c+4uCEi1D6AyOMw6FI9tNaW0v7AWypb+f8YvaA5RF8
         CXRFXlche3yJppvm3QYeusjMdagI5oi8Q52tZPeo642UlZiLNlfOgtWtHWTT6jJRnc
         mWQo7+a2QkgD55ZXJkQkaD0/n1vFY2eGWJG7CgpUr7kgkhde+ivT60+8YTwiSVn0UJ
         gavvi2PKLsXNQWFwASjY4NUkqkW46Xl104TDqF9yOSY26vYc/Qdb8dtQ37k0bC3ixB
         i3mAx+T/z1WQleANThet29SY3VOObtEXbBNzMvP8vrQsxDJK5ktmSFPpAjSzFpLyxC
         AKIEBYMtOlS97cq9dq5QhT0iRLF9liu8fjn0KFc38np552VYAYlAIzWfrePlj58qQx
         qUfca9KqqOFR6fR3daWJs2HU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4025340E00A9;
        Sun, 10 Dec 2023 10:50:25 +0000 (UTC)
Date:   Sun, 10 Dec 2023 11:50:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.7-rc5
Message-ID: <20231210105016.GAZXWX6N31tS8bu6k3@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/urgent fixes for v6.7-rc5.

Thx.

---

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc5

for you to fetch changes up to 9b8493dc43044376716d789d07699f17d538a7c4:

  x86/CPU/AMD: Check vendor in the AMD microcode callback (2023-12-02 11:40:24 +0100)

----------------------------------------------------------------
- Add a forgotten CPU vendor check in the AMD microcode post-loading
  callback so that the callback runs only on AMD

- Make sure SEV-ES protocol negotiation happens only once and on the BSP

----------------------------------------------------------------
Ashwin Dayanand Kamat (1):
      x86/sev: Fix kernel crash due to late update to read-only ghcb_version

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Check vendor in the AMD microcode callback

 arch/x86/kernel/cpu/amd.c |  3 +++
 arch/x86/kernel/sev.c     | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
