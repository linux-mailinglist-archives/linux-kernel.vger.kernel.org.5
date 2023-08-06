Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C755771424
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHFJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjHFJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 05:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468861BFC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 02:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C271260FCF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 09:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6BEC433CB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691313401;
        bh=jifb9YG4Rr6HXqnZjYB7v41LYGfsqhR3YX17d3VIXRo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xkm+Vy4AZQVhElkPv8pOnKa8sEbqYec8OuYslYcCv74rHx/U+z/QNvplxoQdiDeUM
         tLB1szcGSl6M7c0Oi8K8lxlziy2WJp7y8FaPBw0Dl6G440XDcd2oBJLOKsQqkh12LI
         CuhZyeGyqZq8sUhLlwKBCaTht69bWOIiFEuzVrt6ZFDydRsc4F9gURZDaNHzyEtgUF
         6QRtoGNvCMkyaqtPGP7t451hIwP4rAevehFzeS54Fh26oWzMvZYWkqnTbomu/ABhuV
         V9eUEraD8XBdEmD7csBIuDS/rhxxlC2nXUVsK211b1mSMtpN1nT+f1ImuY5Ws/gXS+
         m3Kq2dwvsvJmA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so2539744a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 02:16:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWr12r7ELifACY1LUiJo/jLqQ5m0s1zIvn0MEoXHjEIAWkluOf
        ZW3OIB4UI/nknvKRuvJi7LctU3X9f7jmcK3wpeg=
X-Google-Smtp-Source: AGHT+IE44ZgJDuzU2/E4B4XddjcS5qKjR0In7pq4IcQqpa+gfmTZKMitg1QKWUctRDdgDPeBnxJwq8yQwXa08M9rsE8=
X-Received: by 2002:aa7:cac2:0:b0:522:3ef1:b10 with SMTP id
 l2-20020aa7cac2000000b005223ef10b10mr4773223edt.6.1691313399306; Sun, 06 Aug
 2023 02:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230806083021.2243574-1-kernel@xen0n.name>
In-Reply-To: <20230806083021.2243574-1-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 6 Aug 2023 17:16:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ypd-+z-KbeGM6C_mNk0aggk2yhdDik-XfPNWqsO=j=A@mail.gmail.com>
Message-ID: <CAAhV-H4ypd-+z-KbeGM6C_mNk0aggk2yhdDik-XfPNWqsO=j=A@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Sun, Aug 6, 2023 at 4:30=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
e:
>
> From: WANG Xuerui <git@xen0n.name>
>
> As explained by Nick in the original issue: the kernel usually does a
> good job of providing library helpers that have similar semantics as
> their ordinary userspace libc equivalents, but -ffreestanding disables
> such libcall optimization and other related features in the compiler,
> which can lead to unexpected things such as CONFIG_FORTIFY_SOURCE not
> working (!).
>
> As it turns out to be the case, only the memory operations really need
> to be prevented from expansion by the compiler, and this is doable with
> finer-grained -fno-builtin-* toggles. So only disable memcpy, memmove
> and memset, while leaving other builtins enabled, to fix source
> fortification among others.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1897
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>
> Changes in v2:
>
> - Keep the memory operation builtins disabled, add comments, and tweak th=
e
>   commit message along the way.
>
>  arch/loongarch/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index b1e5db51b61c..34fc48df87f2 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -83,7 +83,14 @@ KBUILD_CFLAGS_KERNEL         +=3D -fPIE
>  LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-li=
nker -z notext
>  endif
>
> -cflags-y +=3D -ffreestanding
> +# Make sure the memory libcalls are not expanded by the compiler, for be=
tter
> +# control over unaligned accesses with respect to CONFIG_ARCH_STRICT_ALI=
GN,
> +# and also for avoiding https://gcc.gnu.org/PR109465.
> +#
> +# The overly broad -ffreestanding is undesirable as it disables *all* li=
bcall
> +# handling, that unfortunately includes proper FORTIFY_SOURCE instrument=
ation.
I think these comments should go to commit message rather than here,
because after this patch there is no -ffreestanding in Makefile.

Huacai

> +cflags-y +=3D -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-mems=
et
> +
>  cflags-y +=3D $(call cc-option, -mno-check-zero-division)
>
>  load-y         =3D 0x9000000000200000
> --
> 2.40.0
>
>
