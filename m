Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779207F3C33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjKVDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:09:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA5912C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:09:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9AEC433C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700622585;
        bh=qdLHRBoKEw4gFMfVFRwpwvnicE8hhhtpNM9aNH2gRU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LzatzLY3wlxZBHabO1rjpjtfU3YxyoAswVHzrdW5Ns4NECFXf6w551ldjkuXp4iOJ
         xa38LiMC6Xjq+Td4ZN35aSjZWwY1tXzjmrVeLNLZFdq3YkjFp1cuzRyK5qZIXEHBUC
         upZzb96Cqv6nYzenxdTkaJqNFTszJFRiLu/kBg7pUMMKEiajN8UNikf58VENrwT6Y/
         p4+VwMv194wWxbMBzH3AWs3pO+XNA8YFDG7cSZ4954sxDjz5+e3xcXie3dkuqUKXI+
         6MVkLPRkkz+dcQX7Zo6XlUqo24IyvqZxaGXXshXp8wvEt6S8Yysu5wI158E0LZUq1g
         qZG98CkzKU3Tw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2977974fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:09:44 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+bzXkGeeSldHq0kTSTpl8GI2LCBl7IrRwtj8thbVGVMVW6bo9
        D9xUnxeAw7OW2DIX06/cVWtukhoLyy9WzEN6FH0=
X-Google-Smtp-Source: AGHT+IHCfjburBQ1UdmjywweePttcXq8IzEtQKzgns2nPfAmlJiNNiQj6TYBr2fVJWJRAVnlcJyJRUk5V/ku2eUIpJU=
X-Received: by 2002:a05:6870:8e0b:b0:1f9:5ae9:bb6e with SMTP id
 lw11-20020a0568708e0b00b001f95ae9bb6emr1378749oab.32.1700622584238; Tue, 21
 Nov 2023 19:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20231120232332.4100288-1-masahiroy@kernel.org>
 <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely> <87bkbnsa5r.fsf@kernel.org>
In-Reply-To: <87bkbnsa5r.fsf@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Nov 2023 12:09:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-_07_h1_jG606VX0WjJq8dEW+C_4E0f28mjyqFnCWFw@mail.gmail.com>
Message-ID: <CAK7LNAT-_07_h1_jG606VX0WjJq8dEW+C_4E0f28mjyqFnCWFw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
To:     "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 6:55=E2=80=AFPM Aneesh Kumar K.V
<aneesh.kumar@kernel.org> wrote:
>
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
> >> crtsavres.o is linked to modules. However, as explained in commit
> >> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
> >> and always-y"), 'make modules' does not build extra-y.
> >>
> >> For example, the following command fails:
> >>
> >>   $ make ARCH=3Dpowerpc LLVM=3D1 KBUILD_MODPOST_WARN=3D1 mrproper ps3_=
defconfig modules
> >>     [snip]
> >>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
> >>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such fil=
e or directory
> >>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/c=
ell/spufs/spufs.ko] Error 1
> >>   make[2]: *** [Makefile:1844: modules] Error 2
> >>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __=
build_one_by_one] Error 2
> >>   make: *** [Makefile:234: __sub-make] Error 2
> >>
> >
> > Thanks. Is this the correct Fixes tag?
> >
> > Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux")
> >
>
> I am finding a different commit ID:
>
> commit baa25b571a168aff5a13bfdc973f1229e2b12b63
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Fri May 12 01:56:49 2017 +1000
>
>     powerpc/64: Do not link crtsavres.o in vmlinux
>
>     The 64-bit linker creates save/restore functions on demand with final
>     links, so vmlinux does not require crtsavres.o.
>
>
> -aneesh



Yeah, I think the correct tag is:


Fixes: baa25b571a16 ("powerpc/64: Do not link crtsavres.o in vmlinux")


--=20
Best Regards
Masahiro Yamada
