Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835497F8A09
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjKYKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKYKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:47:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E737D72
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:47:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D88C433C8;
        Sat, 25 Nov 2023 10:47:16 +0000 (UTC)
Date:   Sat, 25 Nov 2023 10:47:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.7-rc3
Message-ID: <ZWHQscDGVrKPEb6W@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to c0a8574204054effad6ac83cc75c02576e2985fe:

  arm64: add dependency between vmlinuz.efi and Image (2023-11-23 19:10:29 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix "rodata=on" not disabling "rodata=full" on arm64

- Add arm64 make dependency between vmlinuz.efi and Image, leading to
  occasional build failures previously (with parallel building)

- Add newline to the output formatting of the za-fork kselftest

----------------------------------------------------------------
Mark Brown (1):
      kselftest/arm64: Fix output formatting for za-fork

Masahiro Yamada (1):
      arm64: add dependency between vmlinuz.efi and Image

Will Deacon (1):
      arm64: mm: Fix "rodata=on" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=y

 arch/arm64/Makefile                        |  2 +-
 arch/arm64/include/asm/setup.h             | 17 +++++++++++++++--
 arch/arm64/mm/pageattr.c                   |  7 +++----
 tools/testing/selftests/arm64/fp/za-fork.c |  2 +-
 4 files changed, 20 insertions(+), 8 deletions(-)

-- 
Catalin
