Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150937F065A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjKSNQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:15:59 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C1BC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:15:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A16F140E0171;
        Sun, 19 Nov 2023 13:15:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id viAs4TD5Ye4y; Sun, 19 Nov 2023 13:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700399752; bh=g9GdFL9wRuYcI3Ynm4565YA9RBflY8Dk0Lsu+5HCaRY=;
        h=Date:From:To:Cc:Subject:From;
        b=kh2VoIGKYXOegaeDKaqISMCEFVIGSWDXmjQRaCAXp+3jbpCCPItffAFi90URFCgdq
         DGc5tXVVFTiJYJ4f9x8vrS6Jfuz2n+GzckEKJFhaZ3myKP2GGO9mrACuvkjAhNS3HQ
         ab+glqRQ7CdrEDvR7m1yQOqdgcbpNohdSBK16E2C2GbME4k5aKjzqPPqLkmGKIPsCs
         +7HPaehfRbeljry6NjPiHbKw9wfLYJrxCUl8Dp4qF4C6G0qzEXmnm+eCfVIAwsbL3s
         211fp7X0Cez46jUi5r4qTH9f2mgY6dMIUuStSySTowDYjSmWyUXxdDTuZDzCF+t96R
         SWUKlB5hZJYWhwBnYq8TFzC4mNBRr3LBJqTDSK9J9FXck9v8sOL5ZpRq+Vd4nT1yZY
         4bDCONKLZcekkO09/dXNufzUQPv+nSv9I3AK5igkb/OUXmFpPvD2lf1ZwMLlBt6b/v
         YF3GTgwex+l5R4WXguOzIZ5wUHBaX+Ou8zmTynSyN2U5Y36iP1NoZvOz10I+2cCRrS
         QJBTo+kLaKLG63R5RSw1q1HH7sKURGjIkDqpBJUyFR2MN37S6m2f+/GyntchKuzQzV
         wgpImPaqsfYl2Q4PNk7C2FSk3igrgx5YnG5WOEPf5TICZw16b5lPg4u42bKoKGjhBF
         SjzgqXqEefUDSx+O0fq5rA8s=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D86140E0030;
        Sun, 19 Nov 2023 13:15:49 +0000 (UTC)
Date:   Sun, 19 Nov 2023 14:15:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.7-rc2
Message-ID: <20231119131543.GEZVoKf4zenbDfcTG6@fat_crate.local>
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

please pull a couple of urgent x86 fixes for 6.7.

Thx.

---

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc2

for you to fetch changes up to ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167:

  x86/acpi: Ignore invalid x2APIC entries (2023-11-09 14:33:30 +0100)

----------------------------------------------------------------
- Ignore invalid x2APIC entries in order to not waste per-CPU data

- Fix a back-to-back signals handling scenario when shadow stack is in
  use

- A documentation fix

- Add Kirill as TDX maintainer

----------------------------------------------------------------
Bagas Sanjaya (1):
      x86/Documentation: Indent 'note::' directive for protocol version number note

Kirill A. Shutemov (1):
      MAINTAINERS: Add Intel TDX entry

Rick Edgecombe (1):
      x86/shstk: Delay signal entry SSP write until after user accesses

Zhang Rui (1):
      x86/acpi: Ignore invalid x2APIC entries

 Documentation/arch/x86/boot.rst |  2 +-
 MAINTAINERS                     | 14 ++++++++++++++
 arch/x86/kernel/acpi/boot.c     | 34 +++++++++++++++-------------------
 arch/x86/kernel/signal_64.c     |  6 +++---
 4 files changed, 33 insertions(+), 23 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
