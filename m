Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02607BAB71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjJEU2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJEU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:28:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A8A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696537686;
        bh=GNNPMcp3Lxcx32KOp4OE3EIS4dAH/w8ksGDEtB95dC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdBMa2LdyaODYUTZIdMLAQh8vBZyrlxV7IAfWroRHpi2pAjvoXvqSsIL+JjA2VScR
         lOly9jV9CGnGSbUhYkYS5FSQ7b2C4POzy/d8l4sqe8B9biSPX9wNzxE4UxJBTrvEa7
         Fu/7bBqshi6253ST0TMZspswMUmGUc489NnIV86o=
Date:   Thu, 5 Oct 2023 22:28:05 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
> Hi Thomas,
> 
> On 10/5/23 11:00, Thomas Weißschuh wrote:
> > Hi Shuah,
> > 
> > I'd like to test the current state of nolibc in linux-next.
> > Could pull the request below into your nolibc branch?
> > 
> > I'll do some manual tests this weekend, too.
> > 
> > 
> > Thanks,
> > Thomas
> > 
> > 
> > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > 
> >    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> > 
> > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > 
> >    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> 
> Absolutely. Do you mind tagging and pushing the tag and send
> pull request with the tag?

Sure, here it is:


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a

for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:

  tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)

----------------------------------------------------------------
nolibc updates for linux-next

----------------------------------------------------------------
Ammar Faizi (5):
      tools/nolibc: i386: Fix a stack misalign bug on _start
      tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
      tools/nolibc: x86-64: Use `rep stosb` for `memset()`
      tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
      tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

Thomas Weißschuh (9):
      tools/nolibc: add stdarg.h header
      selftests/nolibc: use -nostdinc for nolibc-test
      selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings
      MAINTAINERS: nolibc: update tree location
      selftests/nolibc: don't embed initramfs into kernel image
      selftests/nolibc: allow building i386 with multiarch compiler
      tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
      tools/nolibc: don't define new syscall number
      tools/nolibc: automatically detect necessity to use pselect6

 MAINTAINERS                                  |  2 +-
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/arch-aarch64.h          |  3 --
 tools/include/nolibc/arch-i386.h             |  4 +-
 tools/include/nolibc/arch-loongarch.h        |  4 +-
 tools/include/nolibc/arch-riscv.h            |  3 --
 tools/include/nolibc/arch-x86_64.h           | 42 ++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  4 +-
 tools/include/nolibc/stdarg.h                | 16 ++++++++
 tools/include/nolibc/stdio.h                 |  3 +-
 tools/include/nolibc/string.h                | 36 +++++++-----------
 tools/include/nolibc/sys.h                   | 57 ++++++++++++++++------------
 tools/testing/selftests/nolibc/Makefile      | 45 +++++++++++++---------
 tools/testing/selftests/nolibc/nolibc-test.c |  6 +--
 14 files changed, 144 insertions(+), 82 deletions(-)
 create mode 100644 tools/include/nolibc/stdarg.h


 Thanks,
 Thomas
