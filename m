Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC37C76E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442222AbjJLTc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjJLTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F2B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731BC433C8;
        Thu, 12 Oct 2023 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139145;
        bh=5XvR0nbFOYbsOp6tjXhsyI+hRrcsXxU4UvZwxHkQOTA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Q2cPdtI2bNLimTeaRCR1tgN5h6ZXvNtQqJs7ibarktx9rEhAsF4AfNpv+Gx7HtdoG
         UBrmMR7vXSCCNhvWOP7IwChJXN7dJNm0M5TVfS4hJPrfATmR1WVwXtY2R5N8zr0D7l
         /H0GwaSpZfvIXdl70LM2+jZQybXKvnK9zIa8GqBtXcnD83ypA0HRL0QeJ9cTFuf6g+
         BASO/HH8PBvVVSYCztGrbBD50SD5mIXZiGLQ60as6MRHDirjMThO/5xb/VjnjaR3tS
         +PXsGqpH1QMqy4lw/2HjqAAPL/A++piGNwD2cXIeGMhl/Pq21G3MwhtdNtmpcUWxgl
         VEUC+ztEqieBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3C58CE096F; Thu, 12 Oct 2023 12:32:24 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:32:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        ammarfaizi2@gnuweeb.org
Subject: [PATCH nolibc 0/19] Updates to nolibc for v6.7 (and three for v6.6)
Message-ID: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains nolibc updates, with the first three (1-3) being
urgent for v6.6 and the remainder (4-19) being for the upcoming v6.7
merge window.

1.	tools/nolibc: i386: Fix a stack misalign bug on _start, courtesy
	of Ammar Faizi.

2.	MAINTAINERS: nolibc: update tree location, courtesy of Thomas
	Weiﬂschuh.

3.	tools/nolibc: mark start_c as weak, courtesy of Thomas Weiﬂschuh.

4.	tools/nolibc: add stdarg.h header, courtesy of Thomas Weiﬂschuh.

5.	selftests/nolibc: use -nostdinc for nolibc-test, courtesy of
	Thomas Weiﬂschuh.

6.	tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and
	`memmove()`, courtesy of Ammar Faizi.

7.	tools/nolibc: x86-64: Use `rep stosb` for `memset()`, courtesy
	of Ammar Faizi.

8.	tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function,
	courtesy of Ammar Faizi.

9.	tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function,
	courtesy of Ammar Faizi.

10.	selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings,
	courtesy of Thomas Weiﬂschuh.

11.	selftests/nolibc: don't embed initramfs into kernel image,
	courtesy of Thomas Weiﬂschuh.

12.	selftests/nolibc: allow building i386 with multiarch compiler,
	courtesy of Thomas Weiﬂschuh.

13.	tools/nolibc: avoid unused parameter warnings for ENOSYS
	fallbacks, courtesy of Thomas Weiﬂschuh.

14.	tools/nolibc: don't define new syscall number, courtesy of
	Thomas Weiﬂschuh.

15.	tools/nolibc: automatically detect necessity to use pselect6,
	courtesy of Thomas Weiﬂschuh.

16.	tools/nolibc: drop test for getauxval(AT_PAGESZ), courtesy of
	Thomas Weiﬂschuh.

17.	tools/nolibc: add support for constructors and destructors,
	courtesy of Thomas Weiﬂschuh.

18.	selftests/nolibc: use qemu-system-ppc64 for ppc64le, courtesy
	of Thomas Weiﬂschuh.

19.	selftests/nolibc: add tests for multi-object linkage, courtesy
	of Thomas Weiﬂschuh.

						Thanx, Paul

------------------------------------------------------------------------

 b/MAINTAINERS                                          |    2 
 b/tools/include/nolibc/Makefile                        |    1 
 b/tools/include/nolibc/arch-aarch64.h                  |    3 
 b/tools/include/nolibc/arch-i386.h                     |    4 -
 b/tools/include/nolibc/arch-loongarch.h                |    4 -
 b/tools/include/nolibc/arch-riscv.h                    |    3 
 b/tools/include/nolibc/arch-x86_64.h                   |   29 ++++++++
 b/tools/include/nolibc/crt.h                           |    1 
 b/tools/include/nolibc/nolibc.h                        |    4 -
 b/tools/include/nolibc/stdarg.h                        |   16 ++++
 b/tools/include/nolibc/stdio.h                         |    3 
 b/tools/include/nolibc/string.h                        |    4 +
 b/tools/include/nolibc/sys.h                           |    2 
 b/tools/testing/selftests/nolibc/.gitignore            |    1 
 b/tools/testing/selftests/nolibc/Makefile              |    2 
 b/tools/testing/selftests/nolibc/nolibc-test-linkage.c |   26 +++++++
 b/tools/testing/selftests/nolibc/nolibc-test-linkage.h |    9 ++
 b/tools/testing/selftests/nolibc/nolibc-test.c         |    6 -
 tools/include/nolibc/arch-x86_64.h                     |   13 +++
 tools/include/nolibc/crt.h                             |   23 ++++++
 tools/include/nolibc/string.h                          |   32 ++------
 tools/include/nolibc/sys.h                             |   61 +++++++++--------
 tools/testing/selftests/nolibc/Makefile                |   57 +++++++++------
 tools/testing/selftests/nolibc/nolibc-test.c           |   22 +++++-
 24 files changed, 234 insertions(+), 94 deletions(-)
