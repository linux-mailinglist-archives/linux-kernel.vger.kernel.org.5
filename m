Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4E75C63D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGUL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGUL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1E19B2;
        Fri, 21 Jul 2023 04:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDEE61A73;
        Fri, 21 Jul 2023 11:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CB3C433CB;
        Fri, 21 Jul 2023 11:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689940737;
        bh=CMwTGHPOFWDu+r1fKACWnaAjI/cA9gmdXSJR7pRs1MM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0Vk7T6sBjEX+cw4/0vYaVt70LOjpLARDiFaic0LzUvWVmcEi7eBbfENn2asSxWsW
         +STjvn1vZa3M7PPECSAKvXa2xQIAFlyLWPGUh2Y/qbemXtEs0gsS9tsfOratcNvEBQ
         4Q9vzHCwLp/DvrP4KJZusCEgAWkUM5U/TYJoECFyQx/RItnslRySfwjjEbjVrwDdYa
         LSjZ7SVg1535QUQ/BRE/LUdeC+im+5Sh6wulPEs8wJrK8vKvhvve5s8mhPbyAoKVVo
         CcjD/WRQ+B95aTEdTo1pQOfJN8XY7EXc+Gs8ETWYLJ6goVjBonRAJAYp9J2wltsp7m
         czwD8aTHQGbFQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5658573b1faso1160367eaf.1;
        Fri, 21 Jul 2023 04:58:57 -0700 (PDT)
X-Gm-Message-State: ABy/qLbyuuFTwzFDb5TH8EOuRlDMfBe62mSQL5qujUr8y2sZMuUuu2QF
        pTgfz4fpot75K80Cos5qLUYvFmYBaFdPM3fbB38=
X-Google-Smtp-Source: APBJJlEkqcf+FkrB8BMv4gOisPkUYacPF8cDezX3/NFqU1R+Mf+F+d+W+IkZuldqsULRRV/apmAzfdMylChMNAHnKbY=
X-Received: by 2002:a4a:6f46:0:b0:566:f3f1:5f5c with SMTP id
 i6-20020a4a6f46000000b00566f3f15f5cmr1281074oof.9.1689940737193; Fri, 21 Jul
 2023 04:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARuR5cturyngN31Oy=PwMG_-p5iOek2BuDSKHSyZg44Xg@mail.gmail.com>
 <mhng-7876bf10-0477-4ca6-af22-e3479e8ad123@palmer-ri-x1c9a>
In-Reply-To: <mhng-7876bf10-0477-4ca6-af22-e3479e8ad123@palmer-ri-x1c9a>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 20:58:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASc9vXvHiDRarbKXq-m-9r0wso2VydBFMfd4sCt0mA_8w@mail.gmail.com>
Message-ID: <CAK7LNASc9vXvHiDRarbKXq-m-9r0wso2VydBFMfd4sCt0mA_8w@mail.gmail.com>
Subject: Re: [PATCH -next] modpost: move some defines to the file head
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     wangkefeng.wang@huawei.com, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 1:28=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> On Wed, 12 Jul 2023 08:55:23 PDT (-0700), masahiroy@kernel.org wrote:
> > +To: Luis Chamberlain, the commiter of the breakage
> >
> >
> >
> > On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Kefeng Wang <wangkefeng.wang@h=
uawei.com> wrote:
> >>
> >> with "module: Ignore RISC-V mapping symbols too", build error occurs,
> >>
> >> scripts/mod/modpost.c: In function =E2=80=98is_valid_name=E2=80=99:
> >> scripts/mod/modpost.c:1055:57: error: =E2=80=98EM_RISCV=E2=80=99 undec=
lared (first use in this function)
> >>   return !is_mapping_symbol(name, elf->hdr->e_machine =3D=3D EM_RISCV)=
;
> >>
> >> Fix it by moving the EM_RISCV to the file head, also some other
> >> defines in case of similar problem in the future.
> >
> >
> >
> > BTW, why is the flag 'is_riscv' needed?
> >
> >
> > All symbols starting with '$' look special to me.
> >
> >
> >
> > Why not like this?
> >
> >
> >        if (str[0] =3D=3D '$')
> >                  return true;
> >
> >        return false;
>
> There's a bit of commentary in the v1
> <https://lore.kernel.org/all/20230707054007.32591-1-palmer@rivosinc.com/>=
,
> but essentially it's not necessary.  I just wanted to play things safe
> and avoid changing the mapping symbol detection elsewhere in order to
> deal with RISC-V.
>
> IIRC we decided $ was special in RISC-V because there were some other
> ports that behaved that way, but it wasn't universal.  If folks are OK
> treating $-prefixed symbols as special everywhere that's fine with me, I
> just wasn't sure what the right answer was.
>
> There's also some similar arch-specific-ness with the labels and such in
> here.

Hi Palmer,

I am not a toolchain expert, but my gut feeling is
that the code was safer than needed.


I'd like to remove the 'is_riscv' switch rather than
applying this patch.

Will you send a patch, or do you want me to do so?




--
Best Regards
Masahiro Yamada
