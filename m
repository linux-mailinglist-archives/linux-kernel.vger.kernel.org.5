Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DA78FCA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbjIALtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349286AbjIALtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:49:15 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076D91;
        Fri,  1 Sep 2023 04:49:13 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34df30f4658so6050155ab.1;
        Fri, 01 Sep 2023 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693568952; x=1694173752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+e/eAvMe+DVjABjXSXWrDGT+BGDnGMUtgt70zYUfYA=;
        b=pouKShz+FcqKn7Id0ixs0JbrKiq9xlqXbhU8RzjSqP4r0x62L9MaiyHDG4Ax6oycDz
         kZONT9AnT8e6rKkmB7hR9aL/3ImfUnwqbXVzCeioOAM8L0zhpt2PIHNJ/j4RGn5JZ6T4
         SkVAQkPw0AXpG4Ek/xcu8j4ycar8mxtZ4bVhbEWYCtAEkXBytkRG689KDie6AMkuddlH
         0yIi2+hrplhC2S/uCTvd9biePMnjwrg8kvDATjN8OBRvqqeLtOrtpf1xL/1GAee4JKGG
         5JpnXo2pyJq/Z5tro7lAx8eWedNbXpvIyraJC7Z+/uBvTyqpFvUKCZtnU0wLs25wmZrU
         jDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568952; x=1694173752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+e/eAvMe+DVjABjXSXWrDGT+BGDnGMUtgt70zYUfYA=;
        b=Yw1Qmij3tUXhgtBPBMgUcgh/P++CRzN9miVfkU2jD/r9VO5oIXIYO03WCffO8SvVO1
         8MrMaqMqf6qaZOg8CjCaRyXMBPH1ocfxHe422W4yS6ZCaH9W2r3xd5fpHCX5cIR1kWWm
         5QGgZaX3GrE9Z5dBCZqJTnWGBA/1/ZsMZRqdR9oWgBtBdY03rXwd8mkjw3Fjb/dUZFNp
         ogFxxHZnYXZXg/6uAAPMX4YHSZneA7fzvYlwopj3HhHCJxr85tUfqq4/n082nFduPcf2
         SukOOZozYSwcLmaS+JNUan01MsMr6bJSQKXfU+n2pIXNPlYAtHIsCPCpQ8ijmc0eIMuN
         yYyg==
X-Gm-Message-State: AOJu0Yxv5kHLWQAbTV9l4c/1iX1BJf6AE/ZbFLeeCKYauUuLLqsrjwiI
        DRHKlCV85QNiGYw27wrLrSyUKsp3FNlJENry4W4=
X-Google-Smtp-Source: AGHT+IGNwT1Z1jiaZP8w6Rner6UNnFSZ/683YoXqGu4gF3yGLuui4YK31sogRBOGGFT7e6ixMY2yVrWwM8qRAKo1Wmk=
X-Received: by 2002:a05:6e02:1053:b0:34c:fed8:8df1 with SMTP id
 p19-20020a056e02105300b0034cfed88df1mr2266190ilj.6.1693568952451; Fri, 01 Sep
 2023 04:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVbR3mAgJ4UoeBSgesLPTuo-RVrRE_cLZZHwqJAhuVLFA@mail.gmail.com>
In-Reply-To: <CAMuHMdVbR3mAgJ4UoeBSgesLPTuo-RVrRE_cLZZHwqJAhuVLFA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Sep 2023 12:48:20 +0100
Message-ID: <CA+V-a8t348RAYu8ApmW-3WpPY_qmHKPX3=+Pc-y=n2nZ7DEocg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Kconfig: Allow selecting MMC_SDHI_INTERNAL_DMAC
 for RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Sep 1, 2023 at 12:40=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Sep 1, 2023 at 1:37=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Make MMC_SDHI_INTERNAL_DMAC visible for RISC-V architecture so that we =
can
> > select this config option for RZ/Five SoC which is based on RISC-V
> > architecture.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > I was in two minds here whether I should instead add dependency for
> > ARCH_R9A07G043 instead of RISCV. But adding dependency for RISCV allows
> > us to get this config option freely for future coming RISC-V Renesas
> > SoCs.
> >
> > Cheers, Prabhakar
> > ---
> >  drivers/mmc/host/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 554e67103c1a..5190881cb204 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
> >
> >  config MMC_SDHI_INTERNAL_DMAC
> >         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus ma=
stering"
> > -       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TE=
ST
> > +       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || RISCV || C=
OMPILE_TEST
> >         depends on MMC_SDHI
> > -       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
> > +       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || =
RISCV)
>
> This would expose this option to a growing number of non-Renesas
> RISC-V platforms.  What about using ARCH_RENESAS || COMPILE_TEST
> instead?
>
Good point. I'll make the changes as per below:

--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC

 config MMC_SDHI_INTERNAL_DMAC
        tristate "DMA for SDHI SD/SDIO controllers using on-chip bus master=
ing"
-       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
+       depends on ARCH_RENESAS || COMPILE_TEST
        depends on MMC_SDHI
-       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
+       default MMC_SDHI if ARCH_RENESAS
        help
          This provides DMA support for SDHI SD/SDIO controllers
          using on-chip bus mastering. This supports the controllers

Cheers,
Prabhakar

> >         help
> >           This provides DMA support for SDHI SD/SDIO controllers
> >           using on-chip bus mastering. This supports the controllers
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
