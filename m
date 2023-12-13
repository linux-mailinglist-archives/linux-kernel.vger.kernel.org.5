Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34EF80B0BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjLIACX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:02:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD21724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:02:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD81C433C8;
        Sat,  9 Dec 2023 00:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702080148;
        bh=JnQEXduTa09K+vbZ15f7xxfTVDDKD0OLE61EVkHk9t0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gQpEZ1A7pJy9zeEl3pT4YoIR+vCBPsHlA6GmPiQHRDjuK4dMKMt4Dx9F+NOpRpf00
         ZeaLz8oWNxlEqee1QEAKZnOHMlMMub95AXE5QxjkxpQATg+TVVTIuNbpwWBkcfVOlV
         7P6TM4LcP3lJAcbHqys0AwO3T8ZkWz3EHfsTfwwn6/A8/7fG31nopq5pjjmgnPIFLu
         yPnyeyBoMvSQOWMXe/9QJj5Db1c4TrB85wgElJtIRioiTCLl3iR6nVneihFyLC2qMV
         xwxIW6Tb4JiRk3aUSnog/wmDJB1CUMGxn6cIMk+uIJEjQOzlHC+LoPbM1K7fv5VCmt
         azVDOiM+1XFdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82BF0CE04E4; Fri,  8 Dec 2023 16:02:27 -0800 (PST)
Date:   Fri, 8 Dec 2023 16:02:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: nolibc changes for 6.8
Message-ID: <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 06:09:59PM +0100, Thomas Wei�schuh wrote:
> Hi Paul,
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
> 
> for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
> 
>   selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)

Thank you!

I pulled this in and got the following:

make run:
162 test(s): 162 passed,   0 skipped,   0 failed => status: success

make run-user:
162 test(s): 160 passed,   2 skipped,   0 failed => status: warning

This looks like complete success to me, but please let me know if this
is not expected behavior on an x86-64 laptop.

							Thanx, Paul

> ----------------------------------------------------------------
> Summary:
> 
> * Support for PIC mode on MIPS.
> * Support for getrlimit()/setrlimit().
> * Replace some custom declarations with UAPI includes.
> * A new script "run-tests.sh" to run the testsuite over different architectures
>   and configurations.
> * A few non-functional code cleanups.
> * Minor improvements to nolibc-test, primarily to support the test script.
> 
> There are no urgent fixes available at this time.
> 
> ----------------------------------------------------------------
> Mark Brown (1):
>       tools/nolibc: Use linux/wait.h rather than duplicating it
> 
> Thomas Wei�schuh (21):
>       selftests/nolibc: don't hang on config input
>       selftests/nolibc: use EFI -bios for LoongArch qemu
>       selftests/nolibc: anchor paths in $(srcdir) if possible
>       selftests/nolibc: support out-of-tree builds
>       selftests/nolibc: add script to run testsuite
>       tools/nolibc: error out on unsupported architecture
>       tools/nolibc: move MIPS ABI validation into arch-mips.h
>       selftests/nolibc: use XARCH for MIPS
>       selftests/nolibc: explicitly specify ABI for MIPS
>       selftests/nolibc: extraconfig support
>       selftests/nolibc: add configuration for mipso32be
>       selftests/nolibc: fix testcase status alignment
>       selftests/nolibc: introduce QEMU_ARCH_USER
>       selftests/nolibc: run-tests.sh: enable testing via qemu-user
>       tools/nolibc: mips: add support for PIC
>       selftests/nolibc: make result alignment more robust
>       tools/nolibc: annotate va_list printf formats
>       tools/nolibc: drop duplicated testcase ioctl_tiocinq
>       tools/nolibc: drop custom definition of struct rusage
>       tools/nolibc: add support for getrlimit/setrlimit
>       selftests/nolibc: disable coredump via setrlimit
> 
>  tools/include/nolibc/arch-mips.h             |  11 +-
>  tools/include/nolibc/arch.h                  |   4 +-
>  tools/include/nolibc/stdio.h                 |   4 +-
>  tools/include/nolibc/sys.h                   |  38 ++++++
>  tools/include/nolibc/types.h                 |  25 +---
>  tools/testing/selftests/nolibc/.gitignore    |   1 +
>  tools/testing/selftests/nolibc/Makefile      |  65 ++++++++---
>  tools/testing/selftests/nolibc/nolibc-test.c |  51 ++++++--
>  tools/testing/selftests/nolibc/run-tests.sh  | 169 +++++++++++++++++++++++++++
>  9 files changed, 318 insertions(+), 50 deletions(-)
>  create mode 100755 tools/testing/selftests/nolibc/run-tests.sh
> 
> 
> Thanks,
> Thomas
