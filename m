Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84C7989FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbjIHPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjIHPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670CB1FC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:30:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A424C433C8;
        Fri,  8 Sep 2023 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187012;
        bh=gp/Qd4M7tMQouaQ0tvh7NKp7hlaTwc/Xd1brfUHlaAE=;
        h=Date:From:To:Cc:Subject:From;
        b=tCZAPlWyttOhYM7uJVc1jDWcijQfGhGcqaZJ+7/+qe3b+ak0op4MRHUipB0If6J7k
         xNzzcbum9vGNExXLk7xXnVhQLFGN+xbevulVbgSqeqImlccspjDfoI71dT3kTRTJBa
         GhS9TURar48JUc/3R2inQw9OjyGqyi3QJEC9nY3/RxP6GOO03DByYxRzi3VK+6pN3y
         wFIUWQrEsr8Uamzqd+QI5GKZHYjcezwHSF1yYlmbf1TZOavlxPXs2L6oq6BBJJJIzY
         0RfkhzNx1r473iJmadEkNk/hZXB1ZJLRX1a2J7uceIPWCMNdiXFHIosEORu9yeeFX6
         OdioJFW/1WY7Q==
Date:   Fri, 8 Sep 2023 16:30:07 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20230908153007.GA7281@willie-the-truck>
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

Please pull these three arm64 fixes for -rc1. The main one is a fix for
a broken strscpy() conversion that landed in the merge window and broke
early parsing of the kernel command line.

Cheers,

Will

--->8

The following changes since commit e1df27213941725962f68c64349bbcc60ece0314:

  Merge branch 'for-next/selftests' into for-next/core (2023-08-25 12:36:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 8bd795fedb8450ecbef18eeadbd23ed8fc7630f5:

  arm64: csum: Fix OoB access in IP checksum code for negative lengths (2023-09-07 10:15:20 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix an incorrect mask in the CXL PMU driver

- Fix a regression in early parsing of the kernel command line

- Fix an IP checksum OoB access reported by syzbot

----------------------------------------------------------------
Jeongtae Park (1):
      perf: CXL: fix mismatched number of counters mask

Will Deacon (2):
      arm64/sysreg: Fix broken strncpy() -> strscpy() conversion
      arm64: csum: Fix OoB access in IP checksum code for negative lengths

 arch/arm64/kernel/idreg-override.c | 6 +++---
 arch/arm64/lib/csum.c              | 2 +-
 drivers/perf/cxl_pmu.c             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
