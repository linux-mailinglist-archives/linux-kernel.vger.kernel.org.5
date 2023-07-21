Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4075C9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGUOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGUOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8110FC;
        Fri, 21 Jul 2023 07:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 916C661B27;
        Fri, 21 Jul 2023 14:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F5C433C9;
        Fri, 21 Jul 2023 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949200;
        bh=XBwGSgfb91aZTcXQcRaqrfEq1FhhZU+7msWkFqElwLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HJThixFni40FQB1x4OklWqk3+lPAEwG2x8ONGhowoeP9S3pVcc2MMZhhnadlNzvAX
         3sTcUvqxgMQcfZinTLzB1y3IncrcKDWmfzUq5D/UOR6YxVN5OJ8AGZlQvu2Ze+fQJx
         dhCIVU9//2NF7LmuQ789h1g7wJ+5lW22ZQxsApfz2R8MSBVG4GEuWWAznFMwoyZxMN
         DE8bp/EpI5qGDC3iQNSR4dD767BBvn4e+Re6crcOcRiIbY0jME8N9kWCUS68yxi3VA
         kLIJgcq3WbI2pDoFp7MayHDDjqi4vUsaiSOe7RL/NzEXlkGp4MiqU9Tw8Dr/bhLK+p
         svD7Q9GW7EWIw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b708e49059so29999501fa.3;
        Fri, 21 Jul 2023 07:20:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLYnagObCNRfsJMm+fNsZiGsxaDtl4+O9kq+SWVrBjuHbLuvyRMm
        t7SYfL6M4jj6kv7sSsidIQ3DiJBGNnWVtGBjPgg=
X-Google-Smtp-Source: APBJJlFz5EHQYOhoaq0+KZ3lz/mytul9AdWWNxcFFonXEK+Qst3wpr+ob/OcMAJxkrsxfKIeHpEgeQGnLZIEUvUExIk=
X-Received: by 2002:a2e:90ca:0:b0:2b6:d8e4:71b3 with SMTP id
 o10-20020a2e90ca000000b002b6d8e471b3mr1788076ljg.21.1689949199275; Fri, 21
 Jul 2023 07:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASc9vXvHiDRarbKXq-m-9r0wso2VydBFMfd4sCt0mA_8w@mail.gmail.com>
 <mhng-e12b1787-9deb-487c-a595-2fb4c3f91178@palmer-ri-x1c9>
In-Reply-To: <mhng-e12b1787-9deb-487c-a595-2fb4c3f91178@palmer-ri-x1c9>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 23:19:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKCNitdcWKmvJEWxq5YWq8RpFS+K=Xzji0Zx8wQikq_Q@mail.gmail.com>
Message-ID: <CAK7LNATKCNitdcWKmvJEWxq5YWq8RpFS+K=Xzji0Zx8wQikq_Q@mail.gmail.com>
Subject: Re: [PATCH -next] modpost: move some defines to the file head
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     wangkefeng.wang@huawei.com, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 21, 2023 at 11:01=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> On Fri, 21 Jul 2023 04:58:20 PDT (-0700), masahiroy@kernel.org wrote:
> > On Thu, Jul 13, 2023 at 1:28=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc=
.com> wrote:
> >>
> >> On Wed, 12 Jul 2023 08:55:23 PDT (-0700), masahiroy@kernel.org wrote:
> >> > +To: Luis Chamberlain, the commiter of the breakage
> >> >
> >> >
> >> >
> >> > On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Kefeng Wang <wangkefeng.wan=
g@huawei.com> wrote:
> >> >>
> >> >> with "module: Ignore RISC-V mapping symbols too", build error occur=
s,
> >> >>
> >> >> scripts/mod/modpost.c: In function =E2=80=98is_valid_name=E2=80=99:
> >> >> scripts/mod/modpost.c:1055:57: error: =E2=80=98EM_RISCV=E2=80=99 un=
declared (first use in this function)
> >> >>   return !is_mapping_symbol(name, elf->hdr->e_machine =3D=3D EM_RIS=
CV);
> >> >>
> >> >> Fix it by moving the EM_RISCV to the file head, also some other
> >> >> defines in case of similar problem in the future.
> >> >
> >> >
> >> >
> >> > BTW, why is the flag 'is_riscv' needed?
> >> >
> >> >
> >> > All symbols starting with '$' look special to me.
> >> >
> >> >
> >> >
> >> > Why not like this?
> >> >
> >> >
> >> >        if (str[0] =3D=3D '$')
> >> >                  return true;
> >> >
> >> >        return false;
> >>
> >> There's a bit of commentary in the v1
> >> <https://lore.kernel.org/all/20230707054007.32591-1-palmer@rivosinc.co=
m/>,
> >> but essentially it's not necessary.  I just wanted to play things safe
> >> and avoid changing the mapping symbol detection elsewhere in order to
> >> deal with RISC-V.
> >>
> >> IIRC we decided $ was special in RISC-V because there were some other
> >> ports that behaved that way, but it wasn't universal.  If folks are OK
> >> treating $-prefixed symbols as special everywhere that's fine with me,=
 I
> >> just wasn't sure what the right answer was.
> >>
> >> There's also some similar arch-specific-ness with the labels and such =
in
> >> here.
> >
> > Hi Palmer,
> >
> > I am not a toolchain expert, but my gut feeling is
> > that the code was safer than needed.
> >
> >
> > I'd like to remove the 'is_riscv' switch rather than
> > applying this patch.
> >
> > Will you send a patch, or do you want me to do so?
>
> I've pretty much got it already.  Do you want it on top of the original
> patch, or just squashed in so you can drop it?



It is up to Luis Chamberlain.

The original patch does not exist in my kbuild tree.
(and I was not even not CC'ed, so I had not noticed it
before I saw this report)




commit c05780ef3c190c2dafbf0be8e65d4f01103ad577
Author:     Palmer Dabbelt <palmer@rivosinc.com>
AuthorDate: Fri Jul 7 09:00:51 2023 -0700
Commit:     Luis Chamberlain <mcgrof@kernel.org>
CommitDate: Mon Jul 10 12:45:23 2023 -0700

    module: Ignore RISC-V mapping symbols too

    RISC-V has an extended form of mapping symbols that we use to encode
    the ISA when it changes in the middle of an ELF.  This trips up modpost
    as a build failure, I haven't yet verified it yet but I believe the
    kallsyms difference should result in stacks looking sane again.

    Reported-by: Randy Dunlap <rdunlap@infradead.org>
    Closes: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c=
2@infradead.org/
    Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
    Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
    Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>




--
Best Regards
Masahiro Yamada
