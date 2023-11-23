Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231F7F5EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKWMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjKWMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:01:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681B1A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:01:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C31C433CD;
        Thu, 23 Nov 2023 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700740894;
        bh=O0KmdSGxCuQhaLjAepXLnzFblGpCjlLbqUPX4wb97x0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kS1okNpzujNNw/x/VQUygpXQNKyT7qe3NWEy9iSrouVQ6TUCTn6VfC14Txvw++BVV
         iP8JUYYi2LufvwJjHcJ18sn0TUSo+HCxS+TcMGn1DwamM80Fd1CUi+OdYJIb7rS/m2
         MTtmBPoDEZRVZJyo/v+luSJdHaPmasoHDTDlOYmfroEoKkGD5EbEJw/Het6UV+/41Y
         OKzJasOj0E1bo4jrK6Pv7dwiFXmOxZzrcPxGYhFIpJLUzQNwW+E9k+ncUxqWog/Plh
         FiLM5FdWXnNolHuf1g1sqTtJzrSUgUUwj5/lKX6Lt6rMEJqrbM2BNXczL877bCqro/
         ZXM2hl3SRRaLQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1efb9571b13so474749fac.2;
        Thu, 23 Nov 2023 04:01:34 -0800 (PST)
X-Gm-Message-State: AOJu0YwwtRlU18FTKxNp+yPnkRUYI6FauS5bjJ/L5q5eNOQeqN9FdlFg
        ZSw7m7UEOE3LA36SLBMtv1RpRWtUmFNM9DomflA=
X-Google-Smtp-Source: AGHT+IFPWqcWm1vj9d+/mSuXvSBN4xPQg2Cs74iia34uCpa531SKpvW8e3BZggfqXVk4Lz+CoMinflKiObT0Xe10rJE=
X-Received: by 2002:a05:6870:f78b:b0:1f9:34b3:7ae9 with SMTP id
 fs11-20020a056870f78b00b001f934b37ae9mr7617512oab.17.1700740894160; Thu, 23
 Nov 2023 04:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
 <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com> <20231123-deviator-camisole-645715ad02e9@wendy>
In-Reply-To: <20231123-deviator-camisole-645715ad02e9@wendy>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Nov 2023 21:00:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6e9=RtCJYSof8NwOD2npoKNRN-Fo8GBLvYS0sz5DsqQ@mail.gmail.com>
Message-ID: <CAK7LNAQ6e9=RtCJYSof8NwOD2npoKNRN-Fo8GBLvYS0sz5DsqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 6:44=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Yo,
>
> On Thu, Nov 23, 2023 at 04:38:37PM +0900, Masahiro Yamada wrote:
> > On Thu, Nov 23, 2023 at 7:12=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > This series adds support to set the dtc extra warning level on a per
> > > arch or per platform (directory really) basis.
> > >
> > > The first version of this was just a simple per directory override fo=
r
> > > Samsung platforms, but Conor asked to be able to do this for all of
> > > riscv.
> > >
> > > For merging, either I can take the whole thing or the riscv and samsu=
ng
> > > patches can go via their normal trees. The added variable will have n=
o
> > > effect until merged with patch 2.
> > >
> > > v1:
> > >  - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kernel.o=
rg/
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> >
> >
> > There were some attempts in the past to enable W=3D1 in particular subs=
ystems,
> > so here is a similar comment.
> >
> > Adding a new warning flag to W=3D1 is always safe without doing any com=
pile test.
> >
> > With this series, it would not be true any more because a new warning i=
n W=3D1
> > would potentially break riscv/samsung platforms.
>
> We carry a copy of the dtc in scripts/dtc, so I would expect that before
> an upgrade is done that would introduce new warnings we can fix them in
> the relevant platforms.


It might be easy to fix up only riscv and samsung platforms.

If more and more platforms add KBUILD_EXTRA_WARN=3D1 in their Makefiles,
it will become harder to sort them out before adding a new warning flag.


The sync of scripts/dtc will be delayed until then, or
you will end up with demoting them (i.e. delete KBUILD_EXTRA_WARN=3D1).



> Perhaps I am misunderstanding something there,
> but I'm sure Rob can clear it up if I made a mistake.
>
> > Linus requires a clean build (i.e. zero warning) when W=3D option is no=
t given.
>
> For RISC-V at least, there are currently no W=3D1 warnings while building
> the dtbs (because I put effort into fixing them all) and I would like to
> keep it that way, so that requirement is not a concern.
>
> Cheers,
> Conor.
>


--=20
Best Regards
Masahiro Yamada
