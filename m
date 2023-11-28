Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3F7FB9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjK1MCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344268AbjK1MCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:02:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E302B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:02:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D59C43395;
        Tue, 28 Nov 2023 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701172978;
        bh=tkisRUNNY/d67zoz0XA6BZXue7+K+QjhY+cL0sK45N8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sv0moNEISqAvIRepmeldusBufgOdTcqt5uw7EgC03dJNooOu6yLd9UagBF49Pq5oV
         nuxldMXUbHev2H7y9Z0bND2qTUshxyEHfw40PUMU5GRpmnlw3/lmIFw3bmo2oi4HKK
         3nv7+VgALDGdeBGLMdVtFpfC/dwrXrZf5RrrvEiE3ppWMZaF7+2JP5BLcT2pu8gpqF
         t9PImNSajJ3jx70BxXDGfAEBM0EIfnyjL66CugRoFldWEmOXJKI+gpDPfR9xQRfyMi
         uwtuEm2YpH3wWALrbtqg9gCvW1smFJ0BXnCMtILNLb39eIl7Ts+y8liW6eDOuA0XUq
         CiDCP3bAiiDbA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa486a0e10so1387578fac.3;
        Tue, 28 Nov 2023 04:02:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxBp5OpxrU7RhSBFyROqalFRhDW9ewwn+HlOtHqfegueV0K1g51
        4r/stXtFkG5DEbpuZsv/4h0a2dQs3osWpzelLqM=
X-Google-Smtp-Source: AGHT+IEFDfYBlWh8jfejCGx1eDJyhRxoHb509GRWFdAaRY+qU5DbRfAMND1PnS9hMDUW0DhzFL5FYkPa7akv32zR/1E=
X-Received: by 2002:a05:6871:5824:b0:1fa:26b7:af18 with SMTP id
 oj36-20020a056871582400b001fa26b7af18mr12432388oac.17.1701172977577; Tue, 28
 Nov 2023 04:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
 <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com> <CAL_Jsq+N0GxwZ2YmspEzfiuGOw7M+DmYkyhLgaYtk+Ov2ycY_A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+N0GxwZ2YmspEzfiuGOw7M+DmYkyhLgaYtk+Ov2ycY_A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Nov 2023 21:02:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6-pBjUbB+Fcik27QWniK7BizvoUG+EiFvFtJ+MTdmJA@mail.gmail.com>
Message-ID: <CAK7LNAT6-pBjUbB+Fcik27QWniK7BizvoUG+EiFvFtJ+MTdmJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
To:     Rob Herring <robh@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:03=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Thu, Nov 23, 2023 at 1:39=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
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
> The difference here is the people potentially adding warnings are also
> the ones ensuring no warnings.
>
> > Linus requires a clean build (i.e. zero warning) when W=3D option is no=
t given.
>
> Linus doesn't build any of this AFAICT. We are not always warning free
> for W=3D0 with dtbs.



Does it mean, you can enable all warnings by default?






>
> Rob
>


--=20
Best Regards
Masahiro Yamada
