Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3580DD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbjLKVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjLKVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:36:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565191
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:36:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3362216835eso1066270f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702330597; x=1702935397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vppo7NU6Ebv3ckyFDeCWLvuP+8JGYLLMsJt0+DiFg4=;
        b=L81RxHK2ivdJqq4w1xMe9Slxy5EIk5AabWm7xpA/HedrHwJ+8xThUL8t8SjfhlhWsN
         m+KORRqKv7gUC0KYoYaIWB+gYrpj/5y5Kp5+59FPiMZq9X/E6Mg5D/JC4ksJ5cErBn/V
         nYsaQj0Um3yMHZ2b8WpxbwlyR4MgPxOg1Tbiw3JZWFLC2MBSUCDn9Hk4MNABW5JfcXxm
         zjxKvaymnGcCDgCKvZt+RD4bfEzjf/Roc8oihqvUBUAR+O47rRLRKpWzzJ+szDfsYjG0
         pDbj4S+OfJbLCiyoiiOc9VU56jZWQQF5kI2QS4UsJvwHnjOa5Wmk1yXn7kNwlxTMMVvO
         V4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330597; x=1702935397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vppo7NU6Ebv3ckyFDeCWLvuP+8JGYLLMsJt0+DiFg4=;
        b=WpG0MHaAreJL1+DH1sqCI+lM1cshM8V9O3pKvYtkZyYJoszBnZv+zctUWdkfUfvv14
         wL4EUJmFOrZdHl0a+z1uOrTYO9FMoWoKdxzLE4HsbUjP8Nx1SgPaQAFbQDmAVRTK8xuh
         97uRO+4xuSUa/uViHB4z7AVo/lMo8JE6+jnljveLy3mNh0z3bYwO3x+iys3UFIler1de
         OaDJFCupyFiybfjGfPwFMZFfz4sr6ao0E6zdwh3NlF3s5fZOf19ZBRt0KvsaL8YxGpYC
         1HGojoMOVPgzgFVgPDB3Kk+LAl4fvfUYgvoZPDWwPK5Lp8pLEybRuOd2lRaBRtv2sXeb
         UOhw==
X-Gm-Message-State: AOJu0Yx4Hib3m8XW+fKhYYt+LkCiMKxdrgUdZgH6Mv9iOMbugjLfpXAU
        PEKW3qdgRqYf6I/zjEIzCVGRL01tsaiw8TydyseKSw==
X-Google-Smtp-Source: AGHT+IFUuTHQMfY1vC2ANr/q6GuCdL0vi+i/MuA/El7BUOtHVuk8oqmOKJ1YMKuhUCkiYpQTE6InNJ0NS0A8ml7jGCo=
X-Received: by 2002:a5d:510e:0:b0:333:55da:62b4 with SMTP id
 s14-20020a5d510e000000b0033355da62b4mr2424433wrt.111.1702330596929; Mon, 11
 Dec 2023 13:36:36 -0800 (PST)
MIME-Version: 1.0
References: <202312120116.CP1IYKWT-lkp@intel.com>
In-Reply-To: <202312120116.CP1IYKWT-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Dec 2023 13:36:22 -0800
Message-ID: <CAKwvOdk-f2CzzeKjEWyBi9MNM4spo9o90J_rsqtdNBy15GZ+Qw@mail.gmail.com>
Subject: Re: arch/mips/include/asm/mipsregs.h:2791:3: error: instruction
 requires a CPU feature not currently enabled
To:     llvm@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 9:48=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Nick,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> commit: f12b034afeb3a977bbb1c6584dedc0f3dc666f14 scripts/Makefile.clang: =
default to LLVM_IAS=3D1
> date:   2 years, 4 months ago
> config: mips-malta_kvm_defconfig (https://download.01.org/0day-ci/archive=
/20231212/202312120116.CP1IYKWT-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231212/202312120116.CP1IYKWT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312120116.CP1IYKWT-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/mips/kvm/tlb.c:13:
>    In file included from include/linux/sched.h:12:
>    In file included from ./arch/mips/include/generated/asm/current.h:1:
>    In file included from include/asm-generic/current.h:5:
>    In file included from include/linux/thread_info.h:14:
>    In file included from include/linux/restart_block.h:10:
>    In file included from include/linux/time64.h:5:
>    In file included from include/linux/math64.h:6:
>    In file included from include/linux/math.h:5:
>    In file included from arch/mips/include/asm/div64.h:89:
>    In file included from include/asm-generic/div64.h:55:
>    In file included from include/linux/log2.h:12:
>    In file included from include/linux/bitops.h:32:
>    In file included from arch/mips/include/asm/bitops.h:19:
>    In file included from arch/mips/include/asm/barrier.h:11:
>    In file included from arch/mips/include/asm/addrspace.h:13:
>    In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
>    In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
> >> arch/mips/include/asm/mipsregs.h:2791:3: error: instruction requires a=
 CPU feature not currently enabled
>                    _ASM_SET_VIRT
>                    ^
>    arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_=
ASM_SET_VIRT'
>    #define _ASM_SET_VIRT ".set\tvirt\n\t"
>                                       ^
>    <inline asm>:4:2: note: instantiated into assembly here
>            tlbgp
>            ^

https://github.com/ClangBuiltLinux/linux/issues/1532

>    In file included from arch/mips/kvm/tlb.c:13:
>    In file included from include/linux/sched.h:12:
>    In file included from ./arch/mips/include/generated/asm/current.h:1:
>    In file included from include/asm-generic/current.h:5:
>    In file included from include/linux/thread_info.h:14:
>    In file included from include/linux/restart_block.h:10:
>    In file included from include/linux/time64.h:5:
>    In file included from include/linux/math64.h:6:
>    In file included from include/linux/math.h:5:
>    In file included from arch/mips/include/asm/div64.h:89:
>    In file included from include/asm-generic/div64.h:55:
>    In file included from include/linux/log2.h:12:
>    In file included from include/linux/bitops.h:32:
>    In file included from arch/mips/include/asm/bitops.h:19:
>    In file included from arch/mips/include/asm/barrier.h:11:
>    In file included from arch/mips/include/asm/addrspace.h:13:
>    In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
>    In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
>    arch/mips/include/asm/mipsregs.h:2801:3: error: instruction requires a=
 CPU feature not currently enabled
>                    _ASM_SET_VIRT
>                    ^
>    arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_=
ASM_SET_VIRT'
>    #define _ASM_SET_VIRT ".set\tvirt\n\t"
>                                       ^
>    <inline asm>:4:2: note: instantiated into assembly here
>            tlbgr
>            ^
>    In file included from arch/mips/kvm/tlb.c:13:
>    In file included from include/linux/sched.h:12:
>    In file included from ./arch/mips/include/generated/asm/current.h:1:
>    In file included from include/asm-generic/current.h:5:
>    In file included from include/linux/thread_info.h:14:
>    In file included from include/linux/restart_block.h:10:
>    In file included from include/linux/time64.h:5:
>    In file included from include/linux/math64.h:6:
>    In file included from include/linux/math.h:5:
>    In file included from arch/mips/include/asm/div64.h:89:
>    In file included from include/asm-generic/div64.h:55:
>    In file included from include/linux/log2.h:12:
>    In file included from include/linux/bitops.h:32:
>    In file included from arch/mips/include/asm/bitops.h:19:
>    In file included from arch/mips/include/asm/barrier.h:11:
>    In file included from arch/mips/include/asm/addrspace.h:13:
>    In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
>    In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
>    arch/mips/include/asm/mipsregs.h:2811:3: error: instruction requires a=
 CPU feature not currently enabled
>                    _ASM_SET_VIRT
>                    ^
>    arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_=
ASM_SET_VIRT'
>    #define _ASM_SET_VIRT ".set\tvirt\n\t"
>                                       ^
>    <inline asm>:4:2: note: instantiated into assembly here
>            tlbgwi
>            ^
>    In file included from arch/mips/kvm/tlb.c:13:
>    In file included from include/linux/sched.h:12:
>    In file included from ./arch/mips/include/generated/asm/current.h:1:
>    In file included from include/asm-generic/current.h:5:
>    In file included from include/linux/thread_info.h:14:
>    In file included from include/linux/restart_block.h:10:
>    In file included from include/linux/time64.h:5:
>    In file included from include/linux/math64.h:6:
>    In file included from include/linux/math.h:5:
>    In file included from arch/mips/include/asm/div64.h:89:
>    In file included from include/asm-generic/div64.h:55:
>    In file included from include/linux/log2.h:12:
>    In file included from include/linux/bitops.h:32:
>    In file included from arch/mips/include/asm/bitops.h:19:
>    In file included from arch/mips/include/asm/barrier.h:11:
>    In file included from arch/mips/include/asm/addrspace.h:13:
>    In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
>    In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
>    arch/mips/include/asm/mipsregs.h:2801:3: error: instruction requires a=
 CPU feature not currently enabled
>                    _ASM_SET_VIRT
>                    ^
>    arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_=
ASM_SET_VIRT'
>    #define _ASM_SET_VIRT ".set\tvirt\n\t"
>                                       ^
>    <inline asm>:4:2: note: instantiated into assembly here
>            tlbgr
>            ^
>    In file included from arch/mips/kvm/tlb.c:13:
>    In file included from include/linux/sched.h:12:
>    In file included from ./arch/mips/include/generated/asm/current.h:1:
>    In file included from include/asm-generic/current.h:5:
>    In file included from include/linux/thread_info.h:14:
>    In file included from include/linux/restart_block.h:10:
>    In file included from include/linux/time64.h:5:
>    In file included from include/linux/math64.h:6:
>    In file included from include/linux/math.h:5:
>    In file included from arch/mips/include/asm/div64.h:89:
>    In file included from include/asm-generic/div64.h:55:
>
>
> vim +2791 arch/mips/include/asm/mipsregs.h
>
> ^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16=
  2780
> ^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16=
  2781  /*
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2782   * Guest TLB operations.
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2783   *
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2784   * It is responsibility of the caller to take care of any TLB hazar=
ds.
> ^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16=
  2785   */
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2786  static inline void guest_tlb_probe(void)
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2787  {
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2788         __asm__ __volatile__(
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2789                 ".set push\n\t"
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2790                 ".set noreorder\n\t"
> 00b4eb408aaff2 arch/mips/include/asm/mipsregs.h James Hogan    2017-11-22=
 @2791                 _ASM_SET_VIRT
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2792                 "tlbgp\n\t"
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2793                 ".set pop");
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2794  }
> 7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11=
  2795
>
> :::::: The code at line 2791 was first introduced by commit
> :::::: 00b4eb408aaff21aeb806de24c5ff25b398083a4 MIPS: VZ: Update helpers =
to use new asm macros
>
> :::::: TO: James Hogan <jhogan@kernel.org>
> :::::: CC: James Hogan <jhogan@kernel.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Thanks,
~Nick Desaulniers
