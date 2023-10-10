Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074327BFE53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjJJNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjJJNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:47:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4A1BDD;
        Tue, 10 Oct 2023 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1696945614; bh=Ef98GzxcP7McBliEgswm5sU4y6RhvAOoWqlu6C2ixec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E50PC344Puq6dj8DZKaUWUZt/1RK/wiBCSe/3cbmLl2LRvQ+AFZ7lwCCn09RjxEqe
         hfOCOzY9JMMGcjSVfz3ZEVU2M7XCyUtItBgFE89uk6Y29nRwslzpVcs28poqa4nIJY
         e4mPcJPhHWDCCd4FnZc6cEaBFK9YMmJisAoxuDU0=
Date:   Tue, 10 Oct 2023 15:46:54 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the nolibc tree
Message-ID: <92d99a63-876e-4d9c-be59-703b7f298c24@t-8ch.de>
References: <20231010153354.2357ee1c@canb.auug.org.au>
 <0e0f5e19-c962-458a-b52d-0aa540301c34@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0f5e19-c962-458a-b52d-0aa540301c34@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 06:44:00-0700, Paul E. McKenney wrote:
> On Tue, Oct 10, 2023 at 03:33:54PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in the rcu tree as different commits
> > (but the same patches):
> > 
> >   1b831eb43176 ("tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function")
> >   3a7296c94dfa ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
> >   3f79a57865b3 ("selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings")
> >   9e9dcee894f8 ("selftests/nolibc: use -nostdinc for nolibc-test")
> >   a04fd4052251 ("tools/nolibc: add stdarg.h header")
> >   ab663cc32912 ("tools/nolibc: automatically detect necessity to use pselect6")
> >   bd216cb8d814 ("tools/nolibc: don't define new syscall number")
> >   c6a15707d1c3 ("tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function")
> >   d09e2b033a9f ("tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks")
> >   d7f2a69857ce ("MAINTAINERS: nolibc: update tree location")
> >   dbb6448b4263 ("selftests/nolibc: allow building i386 with multiarch compiler")
> >   e6401064e32b ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
> 
> Apologies for the hassle, but which is the non-rcu tree?

Should be this one:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=nolibc

Sorry for the breakage.
