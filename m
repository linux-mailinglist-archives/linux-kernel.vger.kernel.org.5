Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91367B3FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjI3KYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3KYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:24:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CDE5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:24:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A45C433C8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696069488;
        bh=ywUyJEuvnD0Kgh/Zdaq0tfehPoYx9KX55IzcG8hICEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MxFwfYaOxaybirbDqia4s9Jeg1tkYSJOUnqURDXYpjT74rStmD3hwGIRwzZDzUYwq
         WjBReF2NVj5yvBHquqzritT7CX/QYVE/0gMrnkFy+jvc8FYWTH/8nFkEvZc1jLpWYF
         7d3yKt/4FpG8k2ceCgYnyDfx6z5uquwQcABLjNq3OqEu7gdavt3/zEqD3BVDlAnH4f
         5YafvbpcNTY3DWmp7DtOQp4j9HprnZMPV4DbkUTKO79MfSz+WGmlNU7ucgl/87BmQr
         I1Scgy1wCk9yXxia1B4dEp4/6TaucijUIeY1/cZC7ToUYpiaMWSD60THVjnnVceut+
         S5iuyGbycaEDw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1dc6195bf93so7993337fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:24:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyktvmiILCrxNyYQabvdt8fzJ1CZIdD93lcyXN7uKKBZyA6BE7o
        ikG7MOSnConUc3YA+8jfPNLGphwYbkswjEYKMGE=
X-Google-Smtp-Source: AGHT+IFQY627N4XOGyg1zrHOyarFome//M5MMfUPvElHfYga63GM8cBT9gzNQaseQuRx+LxO0LDTMzT33lUgZv6xYM4=
X-Received: by 2002:a05:6870:b4a1:b0:1d5:5660:3ae0 with SMTP id
 y33-20020a056870b4a100b001d556603ae0mr7274199oap.20.1696069487933; Sat, 30
 Sep 2023 03:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh> <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
 <cff33e12-3d80-7e62-1993-55411ccabc01@collabora.com> <CAKwvOd=F29-UkNO7FtUWpVV=POOZLb6QgD=mhLMWtRfkRSSi2A@mail.gmail.com>
 <a037a08c-44c4-24e8-1cba-7e4e8b21ffaa@collabora.com> <CAK7LNAS8Y9syCiHMO2r75D6hgCSsDDvJ_=VMKpYqjondnbSZjw@mail.gmail.com>
 <267b73d6-8c4b-40d9-542d-1910dffc3238@leemhuis.info> <2833d0db-f122-eccd-7393-1f0169dc0741@collabora.com>
 <26aa6f92-2376-51a4-bbdc-abbbd62c23d2@leemhuis.info> <859c6dde-37ad-492e-baa0-4ea100d8381f@leemhuis.info>
 <b31cae57-89ab-eb8b-1085-1d7476735d58@collabora.com>
In-Reply-To: <b31cae57-89ab-eb8b-1085-1d7476735d58@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Sep 2023 19:24:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQCNVHg=brV-iPL__HAhoNtAKzCiiG2M3Q9jkMvTnrbog@mail.gmail.com>
Message-ID: <CAK7LNAQCNVHg=brV-iPL__HAhoNtAKzCiiG2M3Q9jkMvTnrbog@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, Nick Desaulniers <ndesaulniers@google.com>,
        kernelci@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
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

On Fri, Sep 15, 2023 at 6:33=E2=80=AFPM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> On 11/09/23 15:35, Thorsten Leemhuis wrote:
>
> Hi Thorsten,
>
> > On 29.08.23 13:28, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 11.07.23 13:16, Shreeya Patel wrote:
> >>> On 10/07/23 17:39, Linux regression tracking (Thorsten Leemhuis) wrot=
e:
> >>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-postin=
g
> >>>> for once, to make this easily accessible to everyone.
> >>>>
> >>>> Shreeya Patel, Masahiro Yamada: what's the status of this? Was any
> >>>> progress made to address this? Or is this maybe (accidentally?) fixe=
d
> >>>> with 6.5-rc1?
> >>> I still see the regression happening so it doesn't seem to be fixed.
> >>> https://linux.kernelci.org/test/case/id/64ac675a8aebf63753bb2a8c/
> >>>
> >>> Masahiro had submitted a fix for this issue here.
> >>>
> >>> https://lore.kernel.org/lkml/ZJEni98knMMkU%2Fcl@buildd.core.avm.de/T/=
#t
> >>>
> >>> But I don't see any movement there. Masahiro, are you planning to sen=
d a
> >>> v2 for it?
> >> That was weeks ago and we didn't get a answer. :-/ Was this fixed in
> >> between? Doesn't look like it from here, but I might be missing someth=
ing.
> > Still no reply. :-/
> >
> > Shreeya Patel, does the problem still happen with 6.6-rc1 and do you
> > still want to see it fixed? In that case our only option to get things
> > rolling again might be to involve Linus, unless someone in the CC list
> > has a idea to resolve this. Might also be good to know if reverting the
> > culprit fixes the problem.
>
>
> I don't see this issue happening on 6.6-rc1 kernel and it was only last
> seen in 6.5 kernel.
> But there was no fix added to Kbuild in the meantime so not sure which
> commit really fixed this issue.
>
> For now we can mark this as resolved and I'll keep an eye on the future
> test results to see if this pops up again.
>
>
> Thanks,
> Shreeya Patel
>
> #regzbot resolve: Fixed in 6.6-rc1 kernel, fix commit is unknown.



Not fixed in 6.6-rc1.

I submitted a patch to shoot the root cause.

https://lore.kernel.org/all/20230925110023.1796789-1-masahiroy@kernel.org/


Now it is in Russell's patch tracker.




--=20
Best Regards
Masahiro Yamada
