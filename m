Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D392E7FD31F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjK2Jr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjK2JrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:47:20 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190419B2;
        Wed, 29 Nov 2023 01:47:25 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cd59f77d2dso61316997b3.3;
        Wed, 29 Nov 2023 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251244; x=1701856044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qPZDWdHAVcZMmK+WGuyolxgHPOaDer+ydi9AIrYvTQ=;
        b=MW6KFfWpnvkPazes9uJ5z3lzR0/JXzHUa94TnVNHTczlOx2MK2qrjALRBSKjDvmoJ0
         gFeL/XI0+W1iDNNOz9ssrQWDuAW4AmeN6Y/ReJ4+WhsIoF0re+LQvRxSR9HZyQ6R75ja
         ePp88dkeJcmyx+FOH9N7SaQ8iWyp7YFxNI6cCRwhHqJSKTW/R9QMlboZraOA+cyEyQqp
         lhH9sMA9M7prY2BWz2hfUe+dzLg+fEi1XfUf/6zP9q40A/t3V6d6tOgRKXX2x+Yta10Q
         SaSUDNC/rQY76avhSbYu5c6fEu6Uy4nNV13dL1DCo8aIH0cciUgD2hs7g0WWWkNruVI3
         OWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251244; x=1701856044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qPZDWdHAVcZMmK+WGuyolxgHPOaDer+ydi9AIrYvTQ=;
        b=Di889yTrXmN8y+1Axyv4J3Bff1jqFk10jbCCpuUTZDhJN5S6U86Ao8ulZB04ToNepA
         qqjBS950tp6NXl93MbBckYliMj1jNBWmGQPgzwvIdJ9S/3+m+wQroRTt23Mi+WcJEFbe
         OUl8M2gow5Vwq84zmeRcd9IiMLxjmmwL3ww0JdRn52ibzEWm+B6HB1GmLo5MyZlZ3hbK
         X3iNGdD3eL3MPj2dy4OoPVMRC2CEn2H3p0/nPK/C/XOgmfCcUcbHV8y8iccW9Co/go75
         2K6AQxeeb4zxgY+eI1udMP9icJZV/S7r3i+zBmbp9QAASVgMFQ2y0nJtD2JYZyOTwVBb
         I6hw==
X-Gm-Message-State: AOJu0YwM5uNbiPAlGcp2qBxKlrvTBNhhMGFyHq4dWAAc48k0yDTAzpmq
        4eRAkDVJjRUQPgut45sqPKrfpAtVlQohTL4HMu4=
X-Google-Smtp-Source: AGHT+IHo3hOA6n+50usE2zETLAZfmRy84YOaqNPgxqWdzxdFZ6HxjtqIsiK8LuAqCaDWMDM32YJyquYVVs8cvI/HS8M=
X-Received: by 2002:a0d:cf44:0:b0:5c7:47f:59e8 with SMTP id
 r65-20020a0dcf44000000b005c7047f59e8mr22095699ywd.42.1701251244173; Wed, 29
 Nov 2023 01:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20230928224051.160851-1-tmaimon77@gmail.com> <7d529b2b9a16f238f533f1c03b4261b2.sboyd@kernel.org>
In-Reply-To: <7d529b2b9a16f238f533f1c03b4261b2.sboyd@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 29 Nov 2023 11:47:12 +0200
Message-ID: <CAP6Zq1ie_meX9Kuz3C8KBkYWxjLBDtimk3PS9=zYOhrGxFikBg@mail.gmail.com>
Subject: Re: [PATCH v20] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au,
        mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for your comments and sorry for the late reply.

On Sat, 7 Oct 2023 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2023-09-28 15:40:51)
> > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > new file mode 100644
> > index 000000000000..e575a8676ca3
> > --- /dev/null
> > +++ b/drivers/clk/clk-npcm8xx.c
> > @@ -0,0 +1,547 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> [...]
> > +
> > +/* configurable dividers: */
> > +static const struct npcm8xx_clk_div_data npcm8xx_divs[] = {
> > +       { NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC,
> > +       { .name = NPCM8XX_CLK_S_PRE_ADC, .index = -1 },
> > +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
>
> Please format this some other way. I assume one line means one clk, but
> here it is actually three lines. Perhaps something like this?
Ready in V21
>
> > +       {
> > +             NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC,
> > +             { .name = NPCM8XX_CLK_S_PRE_ADC, .index = -1 },
> > +             CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC
> > +       },
>
> Please stop using the .name member of struct clk_parent_data. That
> member is only there to support drivers that are migrating from a
> binding that didn't specify the parents of clks that are outside of the
> clk controller with the clocks property in their DT node. I see that the
> dts exists upstream, but luckily we don't have a driver merged, so we're
> free to change the binding to specify clks external to the node. The
> .fw_name member will match a 'clock-names' element for the registering
> driver's node. The .index member will match the index in the 'clocks'
> property. Neither of those properties exist in the nuvoton,npcm845-clk
> DT binding, so neither of those members shall be present. This means
> that either the binding needs to be updated, or the clk_parent_data
> structure should be replaced with clk_hw pointers to describe parents.
> I'm going to guess that there aren't any external clk parents, so to
> keep things simple this driver should change to use direct clk_hw
> pointers to describe topology.
Ready in V21
>
> > +       { NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, { .hw = &hw_pre_clk },
> > +       CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
> > +       { NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
> > +       { .hw = &npcm8xx_muxes[6].hw }, CLK_DIVIDER_READ_ONLY, 0, -1 },
> > +       { NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
> > +       { .hw = &npcm8xx_muxes[3].hw }, 0, 0, NPCM8XX_CLK_UART },
> > +       { NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
> > +       { .hw = &npcm8xx_muxes[2].hw }, CLK_DIVIDER_READ_ONLY, 0,
> > +       NPCM8XX_CLK_MMC },
> > +       { NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
> > +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB }, 0, 0,
> > +       NPCM8XX_CLK_SPI3 },
> > +       { NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
> > +       { .hw = &npcm8xx_muxes[7].hw }, CLK_DIVIDER_READ_ONLY, 0,
> > +       NPCM8XX_CLK_PCI },
>
> BTW, I looked at the dts file upstream (nuvoton-common-npcm8xx.dtsi).
> The reset and clock controller start at the same address, which can only
> mean that they're actually the same device. The two nodes should be
unfortunately, It is two services (reset and clock) that are handled
in the same memory space.
> combined into one node and one driver should match that compatible so
> that one IO mapping is made for the entire clock and reset contoller
> register space. If you want, that driver can make two auxiliary device
> drivers for the reset and clk parts of the io space and then those two
> drivers can reside in drivers/reset and drivers/clk. I don't know where
> the driver goes that matches the compatible node though, probably in
> drivers/soc. This allows us to properly model the logical components
> that make up the device in hardware (clks and resets) while also
> allowing any device specific things for that entire register space to
> live in the soc driver. For example, if some power domain needs to be
> enabled to access that register space it would be attached to the soc
> driver.
Sorry I didn't understand, do you mean to have one driver that handles
the clock and the reset modules and will sis under driver/soc
or one driver that handles the reset and clock IO space?

What about using regmap to handle the clock and the reset? for this,
the NPCM clock driver will use a unique clock setting like it is done
in Tegra clk.
https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/clk/tegra/clk-divider.c
instead of using clk_divide and clk_mux default services.

Thanks,

Tomer
