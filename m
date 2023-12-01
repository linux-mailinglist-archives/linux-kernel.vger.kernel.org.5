Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B213800732
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbjLAJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378020AbjLAJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:35:36 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED9CB1BD8;
        Fri,  1 Dec 2023 01:35:39 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6E3920B74C0;
        Fri,  1 Dec 2023 01:35:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6E3920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701423339;
        bh=Bffr6cUHoaJEWdtogE3HmLbq5z1i65W9aVlQ2dxhvrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YX6HmGPwcvlcel9im8pSCL/unleMxL3MgTFCyaqA9PCr3fXLhh142YDxsjFg8bCsy
         1OV+QJ0S4sFoHpB2EGWmiGaVaD5suKHegn0j5kAyfhBUHyXPn8IsMBtoBgaqE9jHjx
         LR8jq1q0LfzbAoICo6jjJ3Bkg3z6uRmdfyQDNhn4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Daniel =?ISO-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Date:   Fri, 01 Dec 2023 10:35:33 +0100
Message-ID: <4879383.31r3eYUQgx@pwmachine>
In-Reply-To: <2023120134-sabotage-handset-0b0d@gregkh>
References: <20231130162133.035359406@linuxfoundation.org> <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com> <2023120134-sabotage-handset-0b0d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Le vendredi 1 d=E9cembre 2023, 09:21:33 CET Greg Kroah-Hartman a =E9crit :
> On Thu, Nov 30, 2023 at 12:11:31PM -0600, Daniel D=EDaz wrote:
> > Hello!
> >=20
> > On Thu, 30 Nov 2023 at 11:44, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 11/30/23 09:21, Daniel D=EDaz wrote:
> > > > Hello!
> > > >=20
> > > > Lots of failures everywhere:
> > > > * clang-17-lkftconfig                 arm64
> > > > * clang-17-lkftconfig                 arm64
> > > > * clang-17-lkftconfig                 arm64
> > > > * clang-lkftconfig                    arm64
> > > > * clang-lkftconfig                    arm
> > > > * clang-lkftconfig                    i386
> > > > * clang-lkftconfig                    x86_64
> > > > * gcc-12-lkftconfig                   arm64
> > > > * gcc-12-lkftconfig                   arm
> > > > * gcc-12-lkftconfig                   i386
> > > > * gcc-12-lkftconfig                   x86_64
> > > > * gcc-12-lkftconfig-64k_page_size     arm64
> > > > * gcc-12-lkftconfig-64k_page_size     arm64
> > > > * gcc-12-lkftconfig-armv8_features    arm64
> > > > * gcc-12-lkftconfig-debug             arm64
> > > > * gcc-12-lkftconfig-debug             arm64
> > > > * gcc-12-lkftconfig-debug             arm
> > > > * gcc-12-lkftconfig-debug             i386
> > > > * gcc-12-lkftconfig-debug             x86_64
> > > > * gcc-12-lkftconfig-debug-kmemleak    arm64
> > > > * gcc-12-lkftconfig-debug-kmemleak    arm
> > > > * gcc-12-lkftconfig-debug-kmemleak    i386
> > > > * gcc-12-lkftconfig-debug-kmemleak    x86_64
> > > > * gcc-12-lkftconfig-devicetree        arm64
> > > > * gcc-12-lkftconfig-kasan             arm64
> > > > * gcc-12-lkftconfig-kasan             arm64
> > > > * gcc-12-lkftconfig-kasan             x86_64
> > > > * gcc-12-lkftconfig-kselftest         arm64
> > > > * gcc-12-lkftconfig-kselftest-kernel  arm64
> > > > * gcc-12-lkftconfig-kselftest-kernel  arm
> > > > * gcc-12-lkftconfig-kselftest-kernel  i386
> > > > * gcc-12-lkftconfig-kunit             arm64
> > > > * gcc-12-lkftconfig-kunit             arm64
> > > > * gcc-12-lkftconfig-kunit             arm
> > > > * gcc-12-lkftconfig-kunit             i386
> > > > * gcc-12-lkftconfig-kunit             x86_64
> > > > * gcc-12-lkftconfig-libgpiod          arm64
> > > > * gcc-12-lkftconfig-libgpiod          arm
> > > > * gcc-12-lkftconfig-libgpiod          i386
> > > > * gcc-12-lkftconfig-libgpiod          x86_64
> > > > * gcc-12-lkftconfig-perf              arm64
> > > > * gcc-12-lkftconfig-perf-kernel       arm64
> > > > * gcc-12-lkftconfig-perf-kernel       arm
> > > > * gcc-12-lkftconfig-perf-kernel       i386
> > > > * gcc-12-lkftconfig-perf-kernel       x86_64
> > > > * gcc-12-lkftconfig-rcutorture        arm64
> > > > * gcc-12-lkftconfig-rcutorture        arm64
> > > > * gcc-12-lkftconfig-rcutorture        arm
> > > > * gcc-12-lkftconfig-rcutorture        i386
> > > > * gcc-12-lkftconfig-rcutorture        x86_64
> > > >=20
> > > > It's essentially this:
> > > >=20
> > > > -----8<-----
> > > >=20
> > > >    make --silent --keep-going --jobs=3D8
> > > >=20
> > > > O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dx86_64 SRCA=
RCH=3Dx86
> > > > CROSS_COMPILE=3Dx86_64-linux-gnu- 'CC=3Dsccache x86_64-linux-gnu-gc=
c'
> > > > 'HOSTCC=3Dsccache gcc'
> > > >=20
> > > >    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
> > > > unreachable instruction
> > > >=20
> > > >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > > >=20
> > > > `__trace_kprobe_create':
> > > >    trace_kprobe.c:(.text+0x2f39): undefined reference to
> > > >=20
> > > > `kallsyms_on_each_symbol'
> > > >=20
> > > >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > > >=20
> > > > `create_local_trace_kprobe':
> > > >    trace_kprobe.c:(.text+0x384b): undefined reference to
> > > >=20
> > > > `kallsyms_on_each_symbol'
> > > >=20
> > > >    make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
> > > >    make[1]: Target '__all' not remade because of errors.
> > > >    make: *** [Makefile:226: __sub-make] Error 2
> > > >    make: Target '__all' not remade because of errors.
> > > >=20
> > > > ----->8-----
> > > >=20
> > > > It only affects 5.15. Bisection in progress.
> > >=20
> > > I guess it will point to
> > >=20
> > > >> Francis Laniel <flaniel@linux.microsoft.com>
> > > >>=20
> > > >>      tracing/kprobes: Return EADDRNOTAVAIL when func matches sever=
al
> > > >>      symbols
> >=20
> > It sure did!:
> >   commit 7b4375c36a4c0e1b4b97ccbcdd427db5a460e04f
> >   Author: Francis Laniel <flaniel@linux.microsoft.com>
> >   Date:   Fri Oct 20 13:42:49 2023 +0300
> >  =20
> >       tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> >       symbols
> >      =20
> >       commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.
> >=20
> > Reverting that commit made the build pass again.
>=20
> {sigh}
>=20
> Francis, I think this is the second or third time this has happened with
> the attempt to get this patch merged.  I'm going to go drop it from all
> of the pending stable queues again, and please, if you wish to have it
> applied in the future, I am going to have to see some proof it was
> actually tested on the architectures that it keeps breaking.

Sorry for the disagreement, for this one, I had to add the CONFIG_LIVEPATCH=
 to=20
then be able to call kallsyms_on_each_symbol(), as on 5.15, this function i=
s=20
within a ifdef guard [1].

I suppose you do not want to add CONFIG_LIVEPATCH to default config, so I w=
ill=20
try to find a way for this specific kernel!

Did you get problems only for 5.15 kernel? Or others too?
In the second case, can you please link me the problems and I will polish=20
everything.

> thanks,
>=20
> greg k-h


Best regards.
=2D--
[1]: https://elixir.bootlin.com/linux/v5.15.140/source/kernel/kallsyms.c#L2=
07


