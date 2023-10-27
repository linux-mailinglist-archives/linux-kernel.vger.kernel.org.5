Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0227D9B48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbjJ0OY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbjJ0OYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:24:24 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C441EDE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:24:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DF11F40E01A3;
        Fri, 27 Oct 2023 14:24:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7riU_N71bCKI; Fri, 27 Oct 2023 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698416656; bh=j3KZifBK0GH+/NJdGK03xi4/fjMS4VXdVAmqjTt1pyw=;
        h=Date:From:To:Cc:Subject:From;
        b=cVvAM821I+9gh5dNaFA5c7rtYj1Nx65jm4IvL+tKy0/yJAhP3AA2rHZ0DG/4rRzUQ
         HThJSDPim0Io9x/TqFCQ4DuLNH27onrfb5x232ZBn2onveEX8CUZzj0ugpXRHK4+hT
         upGMC/wUOHor/MNomAwzUOkeHPZRI5+YN5GNki9EoRDL8zf/WUq6LcVL3CJAz3dy79
         4lbp7/CtSzYUYIe5pcjWhFceciyw1BIPqQJsJq8BTuwX2194DPIVAEd1AxB5UJu9aB
         oqJQQ4+zWZMFRhX3MUVsILsZ2Zvcq4Ch20Rlz3cFufX9GQh8wCDNLGsNts6tWxw6sh
         IMdBhxy1FM/4CYqPVV1nCbv6vep16s3jwxfejojy9Cwh/SFL1liGbUx505LLfStsEq
         iq/L2xhlxJaVi6bA+oUtaC8Nh9Cv/EM5ghYwzHddb0Qud1GNMDpN72PUKP9Ol93bom
         43MDRq3Qgm/QJmvCP6qTwaWEM08HKpUXSuPaitJTV3zheIqzXyG6c7sH0vpT9AbRRN
         3Ot3c5eTOoP9bM8stdgv3cNGyGyPBuD8Ol8e0/fTvIMi+MaUb6jJ3k5xiz5PthD9ya
         uigVnxpSQ7KEPVPtefjTEeWfPHb6ist76KUXgInlid79EcqS3HtyIJwS6G6F3IMIAN
         g8pzHhw9pyogKlQz61Lqev0M=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AB1940E018F;
        Fri, 27 Oct 2023 14:24:13 +0000 (UTC)
Date:   Fri, 27 Oct 2023 16:24:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.7
Message-ID: <20231027142406.GEZTvIBnp/BWmpxQX9@fat_crate.local>
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

please pull the accumulated resource control pile of changes for 6.7.

Thx.

---

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.7_rc1

for you to fetch changes up to 4cee14bcb14881aae81d60f106a335c68553ac1f:

  x86/resctrl: Display RMID of resource group (2023-10-17 14:05:40 +0200)

----------------------------------------------------------------
- Add support for non-contiguous capacity bitmasks being added to
  Intel's CAT implementation

- Other improvements to resctrl code: better configuration,
  simplifications, debugging support, fixes

----------------------------------------------------------------
Babu Moger (9):
      x86/resctrl: Add multiple tasks to the resctrl group at once
      x86/resctrl: Simplify rftype flag definitions
      x86/resctrl: Rename rftype flags for consistency
      x86/resctrl: Unwind properly from rdt_enable_ctx()
      x86/resctrl: Move default group file creation to mount
      x86/resctrl: Introduce "-o debug" mount option
      x86/resctrl: Display CLOSID for resource group
      x86/resctrl: Add support for the files of MON groups only
      x86/resctrl: Display RMID of resource group

Fenghua Yu (2):
      x86/resctrl: Add sparse_masks file in info
      Documentation/x86: Document resctrl's new sparse_masks

Maciej Wieczor-Retman (3):
      x86/resctrl: Fix remaining kernel-doc warnings
      x86/resctrl: Rename arch_has_sparse_bitmaps
      x86/resctrl: Enable non-contiguous CBMs in Intel CAT

 Documentation/arch/x86/resctrl.rst        |  38 +++-
 arch/x86/kernel/cpu/resctrl/core.c        |  11 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  14 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  31 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 281 ++++++++++++++++++++++--------
 include/linux/resctrl.h                   |   4 +-
 6 files changed, 276 insertions(+), 103 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
