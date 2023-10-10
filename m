Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46827BFE44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjJJNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjJJNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:44:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721A1984;
        Tue, 10 Oct 2023 06:44:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD560C433CA;
        Tue, 10 Oct 2023 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696945440;
        bh=QirSDA3Xw1E4yQgF16Tv+Df2f8Iy1FzhX4S2yppUiws=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jR4V5wZpBOiNsVTcWAdD+mrVqQM99AwYEBAnH5qfpLcMelxVjKmXDghSaAxmz6htX
         b5MJ4485PZW9xq4uBzXA4S+u+CB1N6fL1SDAlIl3oXDTDKR0RQxjG+ej/CmQg5twEt
         RHNZc6BdGbMLdktUOJSEjb4yRFJJmYWBr4xZjyIHA1vzQ1tj5+bmCjps8CjELz7KRt
         1RSKf8Qp7BBC5qqsSDmb/eKSJTVm20OowkCN8rn0QAEBazlN9Tp3BBQFBWEhSCKi36
         VSEdZCXd3BTik8xmkHLt6qesyhYRe09096s+4DdzJDd55hGW8g4lOZ5Xjhd5iEFXiZ
         KtZooMJIeSNGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46D89CE0C54; Tue, 10 Oct 2023 06:44:00 -0700 (PDT)
Date:   Tue, 10 Oct 2023 06:44:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the nolibc tree
Message-ID: <0e0f5e19-c962-458a-b52d-0aa540301c34@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231010153354.2357ee1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010153354.2357ee1c@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:33:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the rcu tree as different commits
> (but the same patches):
> 
>   1b831eb43176 ("tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function")
>   3a7296c94dfa ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
>   3f79a57865b3 ("selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings")
>   9e9dcee894f8 ("selftests/nolibc: use -nostdinc for nolibc-test")
>   a04fd4052251 ("tools/nolibc: add stdarg.h header")
>   ab663cc32912 ("tools/nolibc: automatically detect necessity to use pselect6")
>   bd216cb8d814 ("tools/nolibc: don't define new syscall number")
>   c6a15707d1c3 ("tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function")
>   d09e2b033a9f ("tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks")
>   d7f2a69857ce ("MAINTAINERS: nolibc: update tree location")
>   dbb6448b4263 ("selftests/nolibc: allow building i386 with multiarch compiler")
>   e6401064e32b ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")

Apologies for the hassle, but which is the non-rcu tree?

							Thanx, Paul
