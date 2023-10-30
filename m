Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A847DC265
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjJ3WVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJ3WVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D4DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:21:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D963BC433C7;
        Mon, 30 Oct 2023 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698704508;
        bh=BdjBYEo9/tOkaWySc24r8IFPeIekAnU39T5ZuN44j7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=L5sDd993mBBFT6EA10UNbkcFUYg3KDrLM4+rn0TSBufc0+uaxvBkLEhrnfc6dWImR
         Qpj7m9dFwdOd4pQ51YxwtIQsddGreWK9VxKQkWgOrCe/TkHKll9WMH4PNFEEduZTqK
         KS47v/Hsn+7hOoRpQX4VQIskNaCTT1avsDWFJ75ZIeVCMitXNcjIVsGL91m+v6Lxax
         2VonVIeoiCC+1kiD6ggdeQtNa88JMx+Cr9cTyxy1ffxT4tMRHqIx/HfJKnVUL0I13M
         1ROUubP9xJgwM4G9wYHB2PCOTqfrpJp3HH/4rnxRG7rKXpEeKXRZ64x3L5Xnk/VxGN
         69iVhiwiy8/dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 73898CE0BDD; Mon, 30 Oct 2023 15:21:48 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:21:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
        ammarfaizi2@gnuweeb.org, linux@weissschuh.net
Subject: [GIT PULL] nolibc changes for v6.7
Message-ID: <823dcba7-e078-4ad7-b2af-dabce9c4f325@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.10.23a
  # HEAD: b8c60e8fc6f755c2cdf7164931afdbfa670c6646: selftests/nolibc: add tests for multi-object linkage (2023-10-12 21:14:20 +0200)

----------------------------------------------------------------
nolibc updates for v6.7

o	Add stdarg.h header and a few additional system-call upgrades.

o	Add support for constructors and destructors.

o	Add tests to verify the ability to link multiple .o files
	against nolibc.

o	Numerous string-function optimizations and improvements.

o	Prevent redundant kernel relinks by avoiding embedding of
	initramfs into the kernel image.

o	Allow building i386 with multiarch compiler and make ppc64le
	use qemu-system-ppc64.

o	Miscellaneous fixups, including addition of -nostdinc for
	nolibc-test, avoiding -Wstringop-overflow warnings, and avoiding
	unused parameter warnings for ENOSYS fallbacks.

----------------------------------------------------------------
Ammar Faizi (4):
      tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
      tools/nolibc: x86-64: Use `rep stosb` for `memset()`
      tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
      tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

Thomas Weiﬂschuh (12):
      tools/nolibc: add stdarg.h header
      selftests/nolibc: use -nostdinc for nolibc-test
      selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings
      selftests/nolibc: don't embed initramfs into kernel image
      selftests/nolibc: allow building i386 with multiarch compiler
      tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
      tools/nolibc: don't define new syscall number
      tools/nolibc: automatically detect necessity to use pselect6
      tools/nolibc: drop test for getauxval(AT_PAGESZ)
      tools/nolibc: add support for constructors and destructors
      selftests/nolibc: use qemu-system-ppc64 for ppc64le
      selftests/nolibc: add tests for multi-object linkage

 tools/include/nolibc/Makefile                      |  1 +
 tools/include/nolibc/arch-aarch64.h                |  3 --
 tools/include/nolibc/arch-loongarch.h              |  4 +-
 tools/include/nolibc/arch-riscv.h                  |  3 --
 tools/include/nolibc/arch-x86_64.h                 | 42 ++++++++++++++++
 tools/include/nolibc/crt.h                         | 23 ++++++++-
 tools/include/nolibc/nolibc.h                      |  4 +-
 tools/include/nolibc/stdarg.h                      | 16 ++++++
 tools/include/nolibc/stdio.h                       |  3 +-
 tools/include/nolibc/string.h                      | 36 +++++---------
 tools/include/nolibc/sys.h                         | 57 +++++++++++++---------
 tools/testing/selftests/nolibc/.gitignore          |  1 +
 tools/testing/selftests/nolibc/Makefile            | 57 +++++++++++++---------
 .../testing/selftests/nolibc/nolibc-test-linkage.c | 26 ++++++++++
 .../testing/selftests/nolibc/nolibc-test-linkage.h |  9 ++++
 tools/testing/selftests/nolibc/nolibc-test.c       | 28 +++++++++--
 16 files changed, 225 insertions(+), 88 deletions(-)
 create mode 100644 tools/include/nolibc/stdarg.h
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test-linkage.c
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test-linkage.h
