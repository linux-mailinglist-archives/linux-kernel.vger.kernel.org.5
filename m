Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C627BD3BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbjJIGpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbjJIGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:45:07 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C5CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:45:04 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49a99c43624so1460004e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696833904; x=1697438704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4yu13CTAk93CAArrQHw56fb0+67aBBNyd2lqpOlVos=;
        b=jz0GNJteoepxlobVf2mIIjhcHbFtyYk/jnT8h5e1YRs67azmOgBeJ27vu/cC0Yb13o
         +8FFohl26xyg5DSIbU91SP2IkXT4nRlsrXYgK0kdHt+5LxRtNzkDs5VdvMf0anQIt6fn
         4sGVlaDyStmIbQDJumW/jGPdJ7bV+mIa4LfbXc51V9tM2XlJ7wX6KBQVNHETPTTCmy3j
         LR4OuEkLQtbcIuoNvE68og2jnoU5OIwnkPqRxHmSieQYuosGLzgy6Ury0lbJlVJUJnN9
         0GXkvyKGpxoMbS8SSSUR4LfJ7NsJQXz5UMd70Um7IUyEogbCKGK7Dw4eU5M/nMiCg0T8
         ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833904; x=1697438704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4yu13CTAk93CAArrQHw56fb0+67aBBNyd2lqpOlVos=;
        b=YZiHK6kWuTU1FgGrmlly2r1KcyKjy4J/9sGkeQ3XPSjit5eIS5C11q4Nyq/6KwhiNz
         9WQjJhqhvYkodcCaloYFiztC+ZQX6KNxUqCEDTfjmijhWUp0a0RY6BCzxCODaMq5jbKm
         zwpIH4YdWv8OJe+jiOm17f4BsDw6kj4gIiSp+aYNO6AZDR2nlpL/tUgYt3MYOyaXCNQ6
         m9Q6vXwxfZcNGw2WeAZBnZPS49WqJswsT1SzbL1eEd6MTbLBWiVbFoXZAQF5nYJso9E3
         gYjB/R8/EOvw2An7IOPbbBUzdLXDN8GVk24kilb6cXkvOYcHtBBZ3nefxgqoyBFPR4R2
         PRgQ==
X-Gm-Message-State: AOJu0Yyv2JZ0mF6ChNWf7EoFDDEPK2pExa8ABJAFNhPxjUvll1rjrhU/
        Gx5uWjGpgXuMcy0+H/QSTie4niy7qdOeuGUq/2Nb9g==
X-Google-Smtp-Source: AGHT+IFwdJ3g2kY1EDQtNRQMEfDoYkKFxUGRHpuNEpFqAeGCorLDyYlPkv4+sRRKBolFWBnTDxdV+apacMAn1KDYvSc=
X-Received: by 2002:a1f:c342:0:b0:49c:79f3:27a4 with SMTP id
 t63-20020a1fc342000000b0049c79f327a4mr11677190vkf.3.1696833903919; Sun, 08
 Oct 2023 23:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094604.14179-1-brgl@bgdev.pl> <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
 <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
In-Reply-To: <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 08:44:52 +0200
Message-ID: <CAMRc=Me1k6hxazSB1Qnh0D6QtLr-LuDxjKkXbYaRzcP+2vXj+w@mail.gmail.com>
Subject: Re: [PATCH] hte: allow building modules with COMPILE_TEST enabled
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 5:31=E2=80=AFAM Dipen Patel <dipenp@nvidia.com> wro=
te:
>
> On 9/25/23 1:37 AM, Bartosz Golaszewski wrote:
> > On Mon, Sep 11, 2023 at 11:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Allow building all HTE modules with COMPILE_TEST Kconfig option enable=
d.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >> This was part of a wider series but since this is independent, I'm sen=
ding
> >> it separately.
> >>
> >>  drivers/hte/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> >> index cf29e0218bae..083e67492bf2 100644
> >> --- a/drivers/hte/Kconfig
> >> +++ b/drivers/hte/Kconfig
> >> @@ -16,7 +16,7 @@ if HTE
> >>
> >>  config HTE_TEGRA194
> >>         tristate "NVIDIA Tegra194 HTE Support"
> >> -       depends on ARCH_TEGRA_194_SOC
> >> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> >>         help
> >>           Enable this option for integrated hardware timestamping engi=
ne also
> >>           known as generic timestamping engine (GTE) support on NVIDIA=
 Tegra194
> >> @@ -25,7 +25,7 @@ config HTE_TEGRA194
> >>
> >>  config HTE_TEGRA194_TEST
> >>          tristate "NVIDIA Tegra194 HTE Test"
> >> -        depends on HTE_TEGRA194
> >> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
> >>          help
> >>           The NVIDIA Tegra194 GTE test driver demonstrates how to use =
HTE
> >>           framework to timestamp GPIO and LIC IRQ lines.
> >> --
> >> 2.39.2
> >>
> >
> > Hi Dipen!
> >
> > Any comments on this, the other patch with a comment update as well as
> > the one addressing usage of gpiochip_find() in HTE drivers?
> Sorry for the late response, This looks good to me. I will review and tes=
t
> rest other patches.
>
> >
> > Bart
> Acked-by: Dipen Patel <dipenp@nvidia.com>

Hey, can you pick this up into your tree as well?

Thanks,
Bartosz
