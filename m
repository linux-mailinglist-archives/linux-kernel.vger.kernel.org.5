Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABAC79B576
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbjIKU6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbjIKQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:31:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6FC5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:31:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3DAC433C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694449875;
        bh=f3Qo6vrFojIPwWqmmZcbQ18TQJdcfxhyQGQLG3jKQTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FCDAh3+lVLkldKUGjU089uedxOobflo8NE7QBVwSUeOeZY/HE2dsrqtbzUunspkxV
         DxaMX7tTQYQLvpgj2B2bMFVUcX82nXTRqwhGG5xBeeIZHLMT71IA00XrxUjmkJi2QE
         W0JcdypccA9nVQB3j6YGhtfwUE2ZhN+NFcR221G/11nuHwm8q/gLhArLxdGzHaDPC7
         XM7YVffg12FPAVg7uNZ1qhmdm7fGZthHeQXEorK3aF973wvhbHz5ygH1daiwjm+DwJ
         tU7JXRi48nitrD7dfF02JkhmIa8p8MNOKthxcRhZJfOZy6xv7JZJAAs0GJN/bc4Jrj
         RlpeiVGtS5yjA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-500a398cda5so7724568e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:31:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxdAWlXp8MkJ5G7/gNOqOH+Sj8gpqHToc8NwcYzHnarUdGFCfR7
        wcWQlppmPobBlwu/G/GvWRh9y7kb+qMtusbxxaQ=
X-Google-Smtp-Source: AGHT+IFUCSWoNbCnVdv+73dqZmj9FkBmSsJ2WzqpqM3ykhn0+wQPE5+sRP8nObYHWezRHG2xouoG5bQu8UF0YTh+jWU=
X-Received: by 2002:a05:6512:281c:b0:4fe:ecd:4950 with SMTP id
 cf28-20020a056512281c00b004fe0ecd4950mr10349873lfb.1.1694449873780; Mon, 11
 Sep 2023 09:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
In-Reply-To: <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Sep 2023 09:31:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4CejZE443U1U+Svc-auPvOp97UcS3Die=rkstz0HRExw@mail.gmail.com>
Message-ID: <CAPhsuW4CejZE443U1U+Svc-auPvOp97UcS3Die=rkstz0HRExw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
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

On Mon, Sep 11, 2023 at 9:00=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 8, 2023 at 4:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > With LTO enabled, ld.lld generates multiple .text sections for
> > purgatory.ro:
> >
> > $ readelf -S purgatory.ro  | grep " .text"
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >   [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
> >   [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
> >   [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
> >   [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
> >   [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
> >   [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0
> >
> > This cause WARNING from kexec_purgatory_setup_sechdrs():
> >
> > WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> > kexec_load_purgatory+0x37f/0x390
> >
> > Fix this by disabling LTO for purgatory.
>
> Thanks for the v2!
>
> >
> > Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot section=
s")
>
> Dunno that this fixes tag is precise.  I think perhaps
>
> Fixes: b33fff07e3e3 ("x86, build: allow LTO to be selected")

Thanks for the correction!

>
> would be more precise.
>
> > Cc: Ricardo Ribalda <ribalda@chromium.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: x86@kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Song Liu <song@kernel.org>
> >
> > ---
> > AFAICT, x86 is the only arch that supports LTO and purgatory.
> >
> > Changes in v2:
> > 1. Use CC_FLAGS_LTO instead of hardcode -flto. (Nick Desaulniers)
> > ---
> >  arch/x86/purgatory/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index c2a29be35c01..08aa0f25f12a 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -19,6 +19,10 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS -D__NO_FORT=
IFY
> >  # optimization flags.
> >  KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
> >
> > +# When LTO is enabled, llvm emits many text sections, which is not sup=
ported
> > +# by kexec. Remove -flto=3D* flags.
>
> -flto* in LLVM implies -ffunction-sections, which creates a .text.<fn
> name> section per function definition to facilitate -Wl,--gc-sections.
>
> Overall the question here is "do we really need to optimize kexec?"
>
> If the answer is yes, then this patch AND 8652d44f466a are both
> pessimizing kexec (though having it work at all is strictly better
> than not at all).  The best fix IMO would be to provide a linker
> script for this purgatory image that rejoins the text sections back
> into one .text.  For example:
>
> commit eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
>
> I assume people do care about the time to kexec, hence the raison
> d'etre for projects like kpatch.

AFAICT, optimizations like LTO and PGO can give a few % of
improvement, which is probably not important for kexec. The benefit
is in the order of seconds (or less?). The benefit of kpatch is that we
can keep the workload running while fixing the kernel bug. Based on
our experience at Meta, it may take hours to graceful shutdown the
application to run kexec. In this case, a few seconds of improvement
(via LTO/PGO purgatory) doesn't save us much.

Thanks,
Song

>
> I'm fine to sign off on this approach if we don't really care, or want
> to care more later, but we can do better here.
>
> > +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked=
,
> >  # also link a purgatory.chk binary without -r to check for unresolved =
symbols.
> >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
