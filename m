Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F67DC5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJaFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJaFiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:38:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBFDF;
        Mon, 30 Oct 2023 22:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CB3C433C8;
        Tue, 31 Oct 2023 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730692;
        bh=74TnMIViJ53aWi+jH3OPEsmr3nmy5Zut75G5OW8eiEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jQ7N8KkeWhaWp0An7PTtL+2hiRHJyCTYTEXmchMOJX89G+zyV3omLOCg0o7nlDndQ
         c83SvYFbTOEOg65yek326JLs/+T64I02+ymj6L1Qn4zJoTCI+0Zc99/cNZs5jvI5fK
         ifMJR7DYvefj7vzTlzy/jXVRWhjAU6JpRReHMYtyDrbl5ikiRZ2YaoLa92YykZQzBk
         CM2HNB8vsyBNUfxsgu2YY4ADtIBZAPoRbmwCcnGisIyhWx+X2yv80oNVocFRqO48ak
         Zsrz+AdZRwkMia/mOkyVOjongulLkoGPMXB9vmAEblP2JasPxpR5fZdvnOPnP5dnfU
         KJQyhtq633pwg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3528696fac.0;
        Mon, 30 Oct 2023 22:38:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxu5Y5kML4rV3NlYrXtn6WmEmXvPI+qDli+m1H0ycs69zcOsorc
        kW+rz+3XbpWc4l42J/ds7yWyHB3cSro0RsWfWN4=
X-Google-Smtp-Source: AGHT+IHLaZDG+EB683EmjfX64T9gJ5sdGaTxbuxC+FcHcyrmNf41binky8xIbf99uvFODJ8XIFHe6+9HKbEkxNdTan4=
X-Received: by 2002:a05:6870:90d5:b0:1d0:d9e2:985f with SMTP id
 s21-20020a05687090d500b001d0d9e2985fmr12476968oab.57.1698730691785; Mon, 30
 Oct 2023 22:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <202310282049.HXCHtgEz-lkp@intel.com> <20231028093605.b516ad5d8ca820ec76da3072@linux-foundation.org>
In-Reply-To: <20231028093605.b516ad5d8ca820ec76da3072@linux-foundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Oct 2023 14:37:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxbwMW0WCAxBfHp6sSiqw+djE8SCGJr2CSeiOp=NDeHQ@mail.gmail.com>
Message-ID: <CAK7LNATxbwMW0WCAxBfHp6sSiqw+djE8SCGJr2CSeiOp=NDeHQ@mail.gmail.com>
Subject: Re: [akpm-mm:mm-nonmm-unstable 18/58] ERROR: modpost: vmlinux: local
 symbol 'kthread_stop_put' was exported
To:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        =?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= 
        <maskray@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: RISCV, toolchian folks)

Original Thread:
https://lore.kernel.org/oe-kbuild-all/202310282049.HXCHtgEz-lkp@intel.com/


On Sun, Oct 29, 2023 at 1:36=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 28 Oct 2023 20:29:18 +0800 kernel test robot <lkp@intel.com> wrot=
e:
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-=
nonmm-unstable
> > head:   d431880137b55533f664056070226a88dba99637
> > commit: 6309727ef27162deabd5c095c11af24970fba5a2 [18/58] kthread: add k=
thread_stop_put
> > config: riscv-randconfig-c033-20221102 (https://download.01.org/0day-ci=
/archive/20231028/202310282049.HXCHtgEz-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231028/202310282049.HXCHtgEz-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310282049.HXCHtgEz-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > ERROR: modpost: vmlinux: local symbol 'system_power_efficient_wq' was e=
xported
>
> [ it now proceeds to list 16000 more such "errors" ]
>
> I see no error here - these symbols are exported because modules use
> them.  Unless I misinterpret the intent of this modpost check.
>
> Masahiro, could you please take a look?


I was able to reproduce the issue even in the mainline kernel.

But, the warnings are not only the export symbols,
but also a ton of false-positive section mismatch warnings.

To me, the RELA sections look broken when the vmlinux size
grows to a certain extent.

I suspected a toolchain bug, but I am not 100% sure.

In my investigation, this happens under some conditions.

 - It happens on RISCV 32-bit
 - It happens with GCC. LLVM is no problem.
 - It happens when the vmlinux size grows


I attached a simple reproducer script at the end of this reply.


Please checkout the v6.6 tag.
Run the reproducer, with the yes2modconfig line commented out.


When vmlinux.o is small, the relocation info looks sane.
For example,

$ riscv64-linux-gnu-size vmlinux.o
   text    data     bss     dec     hex filename
10762048 905937 342657 12010642 b74492 vmlinux.o
$ riscv64-linux-gnu-readelf -r vmlinux.o  | grep -m1 -A10 rela.export_symbo=
l
Relocation section '.rela.export_symbol' at offset 0x1d9491d4 contains
9789 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000004  c3130301 R_RISCV_32        00000024   system_state + 0
00000010  c33b6901 R_RISCV_32        00000018   static_key_initialized + 0
00000018  c3024d01 R_RISCV_32        00000014   reset_devices + 0
00000020  c33b9e01 R_RISCV_32        00000008   loops_per_jiffy + 0
0000002c  c2f57201 R_RISCV_32        00000110   init_uts_ns + 0
00000038  c3233601 R_RISCV_32        00000354   wait_for_initramfs + 0
00000040  c2ffff01 R_RISCV_32        00000340   init_task + 0
00000048  c313fc01 R_RISCV_32        00000b58   riscv_cached_mvendorid + 0
00000050  c2f78a01 R_RISCV_32        00000b7e   riscv_cached_marchid + 0







Run the reproducer, with the yes2modconfig line in.

vmlinux.o gets bigger, and the relocation info is messed up.
ELF_R_SYM() starts to point local symbols ".LASF*"


$ riscv64-linux-gnu-size vmlinux.o
   text    data     bss     dec     hex filename
16831652 1141862 390321 18363835 11835bb vmlinux.o

$ riscv64-linux-gnu-readelf -r vmlinux.o  | grep -A10 rela.export_symbol
Relocation section '.rela.export_symbol' at offset 0x3201524c contains
11648 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000004  3f41b601 R_RISCV_32        01302449   .LASF1851 + 0
00000010  3f3f4301 R_RISCV_32        012ffca4   .LASF1225 + 0
00000018  3f40d201 R_RISCV_32        01300bc1   .LASF1623 + 0
00000020  3f646a01 R_RISCV_32        01319a43   .LASF5361 + 0
0000002c  3f2f6201 R_RISCV_32        012f5c1f   .LASF3521 + 0
00000038  3f168701 R_RISCV_32        012dd796   .LASF4363 + 0
00000040  3f5d8c01 R_RISCV_32        01319a26   .LASF3685 + 0
00000048  3f092501 R_RISCV_32        012e5792   .LASF939 + 0
00000050  3f22b501 R_RISCV_32        012f89a4   .LASF277 + 0





This is the reproducer shell script.

------------------->8-----------------------------
#!/bin/sh

set -e

# I used riscv64-linux-gnu-gcc available on Ubuntu.
# Instead, you can also use riscv32-linux-gcc, riscv64-linux-gcc, etc.
# provided by the 0day.

export CROSS_COMPILE=3Driscv64-linux-gnu-

make ARCH=3Driscv defconfig

#
# Configure for 32-bit
#
make ARCH=3Driscv 32-bit.config

#
# Turn =3Dm into =3Dy in order to grow vmlinux
#
make ARCH=3Driscv mod2yesconfig

#
# Enable DEBUG_INFO
#
./scripts/config -d CONFIG_DEBUG_INFO_NONE
./scripts/config -e CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT

# sync the .config
make ARCH=3Driscv olddefconfig

make ARCH=3Driscv -j$(nproc) vmlinux_o
------------------------>8------------------------------------



--=20
Best Regards
Masahiro Yamada
