Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA64D7AB5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjIVQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjIVQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:19:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586ED100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09BDC433C7;
        Fri, 22 Sep 2023 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695399552;
        bh=wg0faqqnCPX23fDUvOddN+Ivza/plrs0/jPay77F12g=;
        h=Date:From:To:Cc:Subject:From;
        b=RrK1HcBc+CP0S6pHqYNk1CR9hPCNPPyiucFAl4XwwYSBMgOaZ4L/mnWT9gQsip1x3
         UVefecDBqZwxqzo0xlwlnvC52miioVMvstVcf3spm1ERuUhxGUYs0zcBHUseqjtbmK
         yhw0gDqAFvmDYF6JgEKBjYERxon7WPg3pD631yRFkO+FToghNeP+56nr/Gm0UHk3V5
         InN2BivyNZnrIHJBWDrj2HzW7+uPt78/50DEE4cKxm/yvTrbv8vnHcODw18Rr6n9Mo
         hBgRysp3CIFze9kg5jwNgnLG4LVXCYsvMRYcGUQMm9rG4oDBzoft+U/x6K2G0meO+K
         pIJXqFy78LDqg==
Date:   Fri, 22 Sep 2023 17:19:07 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20230922161907.GB23332@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small crop of relatively boring arm64 fixes for -rc3.

That's not to say we don't have any juicy bugs, however, it's just that
fixes for those are likely to come via -mm and -tip for a hugetlb and an
atomics issue respectively. I get left with the documentation...

Cheers,

Will

--->8

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 44a5b6b5c7fee5146572b4c57f0d9d9c398d1033:

  arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1 (2023-09-18 11:59:02 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix detection of "ClearBHB" and "Hinted Conditional Branch" features

- Fix broken wildcarding for Arm PMU MAINTAINERS entry

- Add missing documentation for userspace-visible ID register fields

----------------------------------------------------------------
Kristina Martsenko (1):
      arm64: cpufeature: Fix CLRBHB and BC detection

Mark Brown (3):
      arm64/sme: Include ID_AA64PFR1_EL1.SME in cpu-feature-registers.rst
      arm64/hbc: Document HWCAP2_HBC
      arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1

Oliver Upton (1):
      MAINTAINERS: Use wildcard pattern for ARM PMU headers

 Documentation/arch/arm64/cpu-feature-registers.rst | 12 ++++++++++++
 Documentation/arch/arm64/elf_hwcaps.rst            |  3 +++
 MAINTAINERS                                        |  2 +-
 arch/arm64/include/asm/cpufeature.h                |  2 +-
 arch/arm64/kernel/cpufeature.c                     |  3 ++-
 arch/arm64/tools/sysreg                            |  6 +++++-
 6 files changed, 24 insertions(+), 4 deletions(-)
