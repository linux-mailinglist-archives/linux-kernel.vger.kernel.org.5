Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C27BD59A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjJIIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjJIIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:48:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0762A3;
        Mon,  9 Oct 2023 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vsEYVvFd0zJLjsdD17x+dxYbHK8LYUuMJRmfVCrYGtw=; b=B2txYrQOk6U8asYJhO+g+1IPzN
        8SSELzSqQOMyNwfIJdlnHnQMcDlRRrdfw2kZatVBOvRfbY/d/LMSRbu9wgMgq7eRIaH3Z13CT2CzA
        Z2/c3mGlHjnujHrYfP45/88GvhlpFpD1ZS0lFv8ZwtR1q+UDRZPUxR3XoCk7ZwmB6vQr0p3XKC7fH
        4I1kRx2bz+xplVnj2DcKATmaINoUgfg+HZTvWds9BrRLEU74q05vIEwSYrH+/DZajm97/smj+R48N
        4ImKw2qs2ixiqFwG/jiqC8n/eS3x5WL2ZgDDVIhMR4u4G+Gn/TGd7rh/f+zcGtWqcYLUw6m0WC3wr
        Md6BcMmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qplvv-00Fjac-15;
        Mon, 09 Oct 2023 08:48:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F8EE300454; Mon,  9 Oct 2023 10:48:12 +0200 (CEST)
Date:   Mon, 9 Oct 2023 10:48:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231009084812.GB14330@noisy.programming.kicks-ass.net>
References: <20231009123118.4487a0e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231009123118.4487a0e1@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the block tree got conflicts in:
>=20
>   arch/alpha/kernel/syscalls/syscall.tbl
>   arch/arm/tools/syscall.tbl
>   arch/arm64/include/asm/unistd.h
>   arch/arm64/include/asm/unistd32.h
>   arch/m68k/kernel/syscalls/syscall.tbl
>   arch/microblaze/kernel/syscalls/syscall.tbl
>   arch/mips/kernel/syscalls/syscall_n32.tbl
>   arch/mips/kernel/syscalls/syscall_n64.tbl
>   arch/mips/kernel/syscalls/syscall_o32.tbl
>   arch/parisc/kernel/syscalls/syscall.tbl
>   arch/powerpc/kernel/syscalls/syscall.tbl
>   arch/s390/kernel/syscalls/syscall.tbl
>   arch/sh/kernel/syscalls/syscall.tbl
>   arch/sparc/kernel/syscalls/syscall.tbl
>   arch/x86/entry/syscalls/syscall_32.tbl
>   arch/xtensa/kernel/syscalls/syscall.tbl
>   include/uapi/asm-generic/unistd.h
>=20
> between commits:
>=20
>   2fd0ebad27bc ("arch: Reserve map_shadow_stack() syscall number for all =
architectures")
>=20
> from the asm-generic tree and commits:
>=20
>   9f6c532f59b2 ("futex: Add sys_futex_wake()")
>   cb8c4312afca ("futex: Add sys_futex_wait()")
>   0f4b5f972216 ("futex: Add sys_futex_requeue()")
>=20
> from the block tree.

fun fun fun..


> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
> index 5d05ab716a74,b1865f9bb31e..000000000000
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@@ -492,4 -492,6 +492,7 @@@
>   560	common	set_mempolicy_home_node		sys_ni_syscall
>   561	common	cachestat			sys_cachestat
>   562	common	fchmodat2			sys_fchmodat2
>  -563	common	futex_wake			sys_futex_wake
>  -564	common	futex_wait			sys_futex_wait
>  -565	common	futex_requeue			sys_futex_requeue
>  +563	common	map_shadow_stack		sys_map_shadow_stack
> ++564	common	futex_wake			sys_futex_wake
> ++565	common	futex_wait			sys_futex_wait
> ++566	common	futex_requeue			sys_futex_requeue

So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
Alpha does not follow the unistd order and meh.

> diff --cc include/uapi/asm-generic/unistd.h
> index 00df5af71ca1,d9e9cd13e577..000000000000
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@@ -822,12 -822,15 +822,18 @@@ __SYSCALL(__NR_cachestat, sys_cachestat
>  =20
>   #define __NR_fchmodat2 452
>   __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> + #define __NR_futex_wake 454
> + __SYSCALL(__NR_futex_wake, sys_futex_wake)
> + #define __NR_futex_wait 455
> + __SYSCALL(__NR_futex_wait, sys_futex_wait)
> + #define __NR_futex_requeue 456
> + __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
>  =20
>  +#define __NR_map_shadow_stack 453
>  +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
>  +
>   #undef __NR_syscalls
> - #define __NR_syscalls 454
> + #define __NR_syscalls 457
>  =20
>   /*
>    * 32 bit systems traditionally used different

This seems to have the hunks in the wrong order, 453 should come before
454 no?

