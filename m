Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0147F9075
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZA3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKZA3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:29:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790A110
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 16:29:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA78C433CB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 00:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700958564;
        bh=QD1q6KK1C7lzvBeT+vzWvvKJ2ThbQAIXhMHqV30TTDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gnx4yu9WbdmNfGew5PiEqN/afohLku5RGr8NL0Rp0O8n8AC/CRL5ayyMabetcOSto
         DZUpnn/thnC0aFrtzg8pNtBL5ZxYi8tEeQyYcuS1DL0SzEOG/V67Ogr+Gck9lW7KW8
         HbfOoX61/Ls8wcHAGvtklymO8FHhCy0/PldqBawNsqBnuu2eTUwPCN09QrHnQsg/gg
         wc8dO5Gia3Y9VeZ7+kZfs4TzVsqWtWlOomgdDEY4Qms4/82cFLy0hlDwfdxKwcdCK7
         3aVlIQ0Q0kkOmQ61rFjEnu3bIg2BFHK1t6y0/p4z/wzESfWf+GEJLx4cMZs4AT+Kn6
         61sHfX/M7KvaQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so34498411fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 16:29:24 -0800 (PST)
X-Gm-Message-State: AOJu0YxgRKzK8rLBxHLLm+m3IBl1hL4gSxPZV907a0+b6NRb10jShMqz
        J/zLV1jLSJL1QdoyI7ETTMqY7xEEotAx1BTa9PA=
X-Google-Smtp-Source: AGHT+IEZPHaVURO2Y4180HzXfLU0Noee2Eb21b4cP6JX5WZAph6aSE67qeGcMXdz4GOSP1Sl5GbZoAq6tV1KNRG2xNw=
X-Received: by 2002:a2e:93cf:0:b0:2c6:f276:34bf with SMTP id
 p15-20020a2e93cf000000b002c6f27634bfmr4835321ljh.45.1700958562514; Sat, 25
 Nov 2023 16:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20231125013025.3620560-1-guoren@kernel.org> <202311251711.9SeU47cN-lkp@intel.com>
In-Reply-To: <202311251711.9SeU47cN-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 26 Nov 2023 08:29:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShio6iaAKpy_rpnufp9hB54r+t_+0wPZy7eJUpcErY5Q@mail.gmail.com>
Message-ID: <CAJF2gTShio6iaAKpy_rpnufp9hB54r+t_+0wPZy7eJUpcErY5Q@mail.gmail.com>
Subject: Re: [PATCH V2] locking/atomic: scripts: Increase template priority in
 order variants
To:     kernel test robot <lkp@intel.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, keescook@chromium.org,
        paulmck@kernel.org, ubizjak@gmail.com, tglx@linutronix.de,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 5:11=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kees/for-next/pstore]
> [also build test WARNING on kees/for-next/kspp]
> [cannot apply to linus/master v6.7-rc2 next-20231124]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/=
locking-atomic-scripts-Increase-template-priority-in-order-variants/2023112=
5-093207
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git fo=
r-next/pstore
> patch link:    https://lore.kernel.org/r/20231125013025.3620560-1-guoren%=
40kernel.org
> patch subject: [PATCH V2] locking/atomic: scripts: Increase template prio=
rity in order variants
> config: i386-defconfig (https://download.01.org/0day-ci/archive/20231125/=
202311251711.9SeU47cN-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231125/202311251711.9SeU47cN-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311251711.9SeU47cN-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/x86/include/asm/atomic.h:8:0,
>                     from include/linux/atomic.h:7,
>                     from include/linux/cpumask.h:13,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:23,
>                     from arch/x86/include/asm/timex.h:5,
>                     from include/linux/timex.h:67,
>                     from include/linux/time32.h:13,
>                     from include/linux/time.h:60,
>                     from include/linux/compat.h:10,
>                     from kernel/futex/core.c:34:
>    kernel/futex/core.c: In function 'raw_atomic64_cmpxchg_relaxed':
> >> arch/x86/include/asm/cmpxchg.h:130:2: warning: '__ret' is used uniniti=
alized in this function [-Wuninitialized]
>      __ret;        \
>      ^~~~~
>    arch/x86/include/asm/cmpxchg.h:87:21: note: '__ret' was declared here
>      __typeof__(*(ptr)) __ret;     \
>                         ^
>    arch/x86/include/asm/cmpxchg.h:134:2: note: in expansion of macro '__r=
aw_cmpxchg'
>      __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
>      ^~~~~~~~~~~~~
>    arch/x86/include/asm/cmpxchg.h:149:2: note: in expansion of macro '__c=
mpxchg'
>      __cmpxchg(ptr, old, new, sizeof(*(ptr)))
>      ^~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:91:29: note: in expansion =
of macro 'arch_cmpxchg'
>     #define raw_cmpxchg_relaxed arch_cmpxchg
>                                 ^~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:4107:9: note: in expansion=
 of macro 'raw_cmpxchg_relaxed'
>      return raw_cmpxchg_relaxed(&v->counter, old, new);
>             ^~~~~~~~~~~~~~~~~~~
>    In function 'raw_atomic64_cmpxchg_relaxed',
>        inlined from 'get_inode_sequence_number' at include/linux/atomic/a=
tomic-instrumented.h:2817:9,
>        inlined from 'get_futex_key' at kernel/futex/core.c:387:23:
>    arch/x86/include/asm/cmpxchg.h:128:3: error: call to '__cmpxchg_wrong_=
size' declared with attribute error: Bad argument size for cmpxchg
Gcc is okay, but Clang failed. I would dig it out.

>       __cmpxchg_wrong_size();     \
>       ^~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/include/asm/cmpxchg.h:134:2: note: in expansion of macro '__r=
aw_cmpxchg'
>      __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
>      ^~~~~~~~~~~~~
>    arch/x86/include/asm/cmpxchg.h:149:2: note: in expansion of macro '__c=
mpxchg'
>      __cmpxchg(ptr, old, new, sizeof(*(ptr)))
>      ^~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:91:29: note: in expansion =
of macro 'arch_cmpxchg'
>     #define raw_cmpxchg_relaxed arch_cmpxchg
>                                 ^~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:4107:9: note: in expansion=
 of macro 'raw_cmpxchg_relaxed'
>      return raw_cmpxchg_relaxed(&v->counter, old, new);
>             ^~~~~~~~~~~~~~~~~~~
>
>
> vim +/__ret +130 arch/x86/include/asm/cmpxchg.h
>
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   79
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   80  /*
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   81   * Atomic compare and=
 exchange.  Compare OLD with MEM, if identical,
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   82   * store NEW in MEM. =
 Return the initial value in MEM.  Success is
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   83   * indicated by compa=
ring RETURN with OLD.
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   84   */
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   85  #define __raw_cmpxchg=
(ptr, old, new, size, lock)                    \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   86  ({                   =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   87      __typeof__(*(ptr)=
) __ret;                                       \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   88      __typeof__(*(ptr)=
) __old =3D (old);                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   89      __typeof__(*(ptr)=
) __new =3D (new);                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   90      switch (size) {  =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   91      case __X86_CASE_B=
:                                              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   92      {                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   93              volatile =
u8 *__ptr =3D (volatile u8 *)(ptr);              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   94              asm volat=
ile(lock "cmpxchgb %2,%1"                      \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   95                       =
    : "=3Da" (__ret), "+m" (*__ptr)              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   96                       =
    : "q" (__new), "0" (__old)                 \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   97                       =
    : "memory");                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   98              break;   =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   99      }                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  100      case __X86_CASE_W=
:                                              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  101      {                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  102              volatile =
u16 *__ptr =3D (volatile u16 *)(ptr);            \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  103              asm volat=
ile(lock "cmpxchgw %2,%1"                      \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  104                       =
    : "=3Da" (__ret), "+m" (*__ptr)              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  105                       =
    : "r" (__new), "0" (__old)                 \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  106                       =
    : "memory");                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  107              break;   =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  108      }                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  109      case __X86_CASE_L=
:                                              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  110      {                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  111              volatile =
u32 *__ptr =3D (volatile u32 *)(ptr);            \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  112              asm volat=
ile(lock "cmpxchgl %2,%1"                      \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  113                       =
    : "=3Da" (__ret), "+m" (*__ptr)              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  114                       =
    : "r" (__new), "0" (__old)                 \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  115                       =
    : "memory");                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  116              break;   =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  117      }                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  118      case __X86_CASE_Q=
:                                              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  119      {                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  120              volatile =
u64 *__ptr =3D (volatile u64 *)(ptr);            \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  121              asm volat=
ile(lock "cmpxchgq %2,%1"                      \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  122                       =
    : "=3Da" (__ret), "+m" (*__ptr)              \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  123                       =
    : "r" (__new), "0" (__old)                 \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  124                       =
    : "memory");                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  125              break;   =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  126      }                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  127      default:         =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  128              __cmpxchg=
_wrong_size();                                 \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  129      }                =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18 @130      __ret;           =
                                               \
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  131  })
> e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  132
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Best Regards
 Guo Ren
