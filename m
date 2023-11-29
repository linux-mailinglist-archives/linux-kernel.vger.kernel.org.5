Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DD7FDED7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjK2Rty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2Rtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:49:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7328CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:49:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F0C433C7;
        Wed, 29 Nov 2023 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701280198;
        bh=hOv0atHingnUJuqYGWuaNZX1Z0M6TjcYBZp5aRGip38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HSZ0Bk+XmVmFmLv332NYdThxfq4coZgxOk/QGCVmtzUcqbP97NlHYXwFbriiyC9FH
         d7/i+52mNChc0yjo6/jXpoAsN+V5rk2WU0NQRFX8RY+48z8kY4qWBHx2BeG1poDNHK
         K/xwWP38VggGm4bT8c6GbPVqQEGov8dERZjxti4jevPG5l3dDhxzlO5QuV9tWcKJYo
         ZC9huQ3TP9gplgB3P0TMLjTogFgeQKOxgo4E/PjbsPtu38ro5u6PfYzJvA7+vXzZ+0
         xhz1vMusrIAxnD4UEQaLNFGsIVKMi1vSUOYnFXILQicFq7V0ZJnyhiBs1v52yDZt7V
         mdUXs2OqlgUpQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1fa0885e1c2so3186478fac.0;
        Wed, 29 Nov 2023 09:49:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7QVeVut9Q7yfnjijicfKXvqiypvOMzedrrYJznFq8/TgZ5YU2
        mbkk4UEEicsIUvs4EzeABjNS0A2eh5zxkvpVA1M=
X-Google-Smtp-Source: AGHT+IGPL/pndXjMwP7hy3JldohpjQSp00uVIIbyXY3nxHbNA9I2y0xKAZxcbbFRrog0l235VVgYmZxUmeL8Cb87sfc=
X-Received: by 2002:a05:6870:82a5:b0:1fa:2888:701d with SMTP id
 q37-20020a05687082a500b001fa2888701dmr17426756oae.8.1701280197666; Wed, 29
 Nov 2023 09:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
 <CAK7LNASVMjVg4dr=KdSDHwGww_47H78H7rMXA=wf+ncugesDSA@mail.gmail.com>
 <CAL_Jsq+N0GxwZ2YmspEzfiuGOw7M+DmYkyhLgaYtk+Ov2ycY_A@mail.gmail.com>
 <CAK7LNAT6-pBjUbB+Fcik27QWniK7BizvoUG+EiFvFtJ+MTdmJA@mail.gmail.com> <CAL_JsqJSFnVG6+CfcbgVFGo3EyiSTt-et0NSW2qWjei+zXURcg@mail.gmail.com>
In-Reply-To: <CAL_JsqJSFnVG6+CfcbgVFGo3EyiSTt-et0NSW2qWjei+zXURcg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 30 Nov 2023 02:49:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrRwzrU0m0SVOfnJj87hw4kL2YpDK0xRCwuW6fYT9OGg@mail.gmail.com>
Message-ID: <CAK7LNARrRwzrU0m0SVOfnJj87hw4kL2YpDK0xRCwuW6fYT9OGg@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 7:25=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Nov 28, 2023 at 6:03=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Mon, Nov 27, 2023 at 11:03=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> > >
> > > On Thu, Nov 23, 2023 at 1:39=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Thu, Nov 23, 2023 at 7:12=E2=80=AFAM Rob Herring <robh@kernel.or=
g> wrote:
> > > > >
> > > > > This series adds support to set the dtc extra warning level on a =
per
> > > > > arch or per platform (directory really) basis.
> > > > >
> > > > > The first version of this was just a simple per directory overrid=
e for
> > > > > Samsung platforms, but Conor asked to be able to do this for all =
of
> > > > > riscv.
> > > > >
> > > > > For merging, either I can take the whole thing or the riscv and s=
amsung
> > > > > patches can go via their normal trees. The added variable will ha=
ve no
> > > > > effect until merged with patch 2.
> > > > >
> > > > > v1:
> > > > >  - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kern=
el.org/
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > >
> > > >
> > > > There were some attempts in the past to enable W=3D1 in particular =
subsystems,
> > > > so here is a similar comment.
> > > >
> > > > Adding a new warning flag to W=3D1 is always safe without doing any=
 compile test.
> > > >
> > > > With this series, it would not be true any more because a new warni=
ng in W=3D1
> > > > would potentially break riscv/samsung platforms.
> > >
> > > The difference here is the people potentially adding warnings are als=
o
> > > the ones ensuring no warnings.
> > >
> > > > Linus requires a clean build (i.e. zero warning) when W=3D option i=
s not given.
> > >
> > > Linus doesn't build any of this AFAICT. We are not always warning fre=
e
> > > for W=3D0 with dtbs.
> >
> >
> >
> > Does it mean, you can enable all warnings by default?
>
> No, Linus might not care, but others (me) do. The whole point of not
> allowing warnings is the same. Get to zero warnings so any new
> warnings stand out. We now have some subset of platforms which are
> warning free and want warnings enabled by default to keep them that
> way. How do you suggest we do that?





You may not like it, but an alternative solution could be,
hard-code extra warning flags.


In my compile-tests, Samsung platform is not W=3D1 clean yet.
I see -Wunit_address_vs_reg, -Wsimple_bus_reg,
-Wunique_unit_address_if_enabled warnings.

I do not see anything else, so you can add the following three
flags to keep it warning-free.






diff --git a/arch/arm/boot/dts/samsung/Makefile
b/arch/arm/boot/dts/samsung/Makefile
index 7becf36656b1..1e15784ec51f 100644
--- a/arch/arm/boot/dts/samsung/Makefile
+++ b/arch/arm/boot/dts/samsung/Makefile
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+
+dtcflags :=3D \
+       -Wavoid_unnecessary_addr_size \
+       -Walias_paths \
+       -Wgraph_child_address
+
 dtb-$(CONFIG_ARCH_EXYNOS3) +=3D \
        exynos3250-artik5-eval.dtb \
        exynos3250-monk.dtb \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e01..aa5a5fc39cec 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -362,6 +362,9 @@ DTC_FLAGS +=3D -Wnode_name_chars_strict \
        -Wunique_unit_address
 endif

+# per-directory flags
+DTC_FLAGS +=3D $(dtcflags)
+# per-file flags
 DTC_FLAGS +=3D $(DTC_FLAGS_$(basetarget))

 # Set -@ if the target is a base DTB that overlay is applied onto







>
> I understand your point on W=3D1 in general, but I think it just doesn't
> apply in this case. In general,
> someone may be testing a new compiler and there's some new warning to
> enable, so they add it to W=3D1. They are working independently of any
> subsystem (and Linus) and introducing new warnings would be a burden
> to fix and a problem to leave. For DT, it is a bit different as adding
> new warnings, updating dtc version, and selecting warnings to enable
> are pretty much all done together.
> Plus, schema warnings have pretty
> much superseded dtc warnings. If we do add new warnings which can't be
> fixed up front, then we could still only enable the warning for W=3D1
> from the command line. Something like this on top of this series:
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 53a74e53e0ca..41307c6e1fee 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -341,6 +341,10 @@ quiet_cmd_gzip =3D GZIP    $@
>  # ----------------------------------------------------------------------=
-----
>  DTC ?=3D $(objtree)/scripts/dtc/dtc
>
> +ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
> +DTC_FLAGS +=3D -Wno-some_new_warning_we_need_off_globally
> +endif
> +

Hmm. Tricky, but works.

KBUILD_EXTRA_WARN_DTC=3D1 is weaker than KBUILD_EXTRA_WARN=3D1




>  KBUILD_EXTRA_WARN_DTC +=3D $(KBUILD_EXTRA_WARN)
>
>  # Disable noisy checks by default
>
--
Best Regards
Masahiro Yamada
