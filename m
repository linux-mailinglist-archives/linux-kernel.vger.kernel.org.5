Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E551753331
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjGNHak convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjGNHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:30:38 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013D1FEE;
        Fri, 14 Jul 2023 00:30:37 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-577637de4beso14668317b3.0;
        Fri, 14 Jul 2023 00:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319836; x=1691911836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzJJuY0Q0DnF9HSa+BRB7ygjuyzDsySptgeRccjEUZo=;
        b=gIEfa0OtKuSEAb6Rz4MHadjbteYkmEppmVY96Xo6H2PrOeb6gG/JfJLsr81uStE3yz
         iod4ggWf7NC1h3TtPYn4cGqoVXvLQXISZkxWzmGMVi3tiOaJuwkYKeJpRqWbpV/rqlcz
         n4CK9ZAlP2t2yqWWWOwbyFHmym6NrOXAW5zOTnBA4qH2BePGKptbYk2Lx5nU0Ozj7/cu
         wUhfaochgGn5GbM4VsPY+oDXrmfKxp0tak9udpOnOFSDA1GweSZJJNWnU6jJoETLtiVI
         Lu+qzcPyZf8rxm0lGVWiA8DFEtu8czEy9QScAmONv9bLMXVjlyJ2ty8NrpLuVeE7aDh+
         neuA==
X-Gm-Message-State: ABy/qLYjxY6Ikp1Me1kycPWPW3lD5pDQHAuZW2FY40wgXKcf0k7fRmVA
        +XU1wdcgjY45dYvPb8zVDxkmhRDFlrxrRMz8
X-Google-Smtp-Source: APBJJlEpmowkDAklbYq9/hMdLgsc8bEx09Tv+opb6JsDgZcHK31CXfw2lVBk3kPnXNEitY6A3UKH5Q==
X-Received: by 2002:a0d:c584:0:b0:565:a0c8:7e66 with SMTP id h126-20020a0dc584000000b00565a0c87e66mr4166968ywd.0.1689319836409;
        Fri, 14 Jul 2023 00:30:36 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c78-20020a814e51000000b00579e5c4982fsm2202566ywb.36.2023.07.14.00.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:30:36 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57012b2973eso14496037b3.2;
        Fri, 14 Jul 2023 00:30:36 -0700 (PDT)
X-Received: by 2002:a0d:c802:0:b0:577:1533:ea95 with SMTP id
 k2-20020a0dc802000000b005771533ea95mr4217561ywd.28.1689319835841; Fri, 14 Jul
 2023 00:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com> <ZKVI4XPbPXfzQa9J@surfacebook>
 <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAHp75VcJvRq7BotoODW_BOh84+TD_1Q3vbXSQv3FCiJfnBx8Vw@mail.gmail.com> <TYWPR01MB8775E433ACFA2F78D357FF05C237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB8775E433ACFA2F78D357FF05C237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 09:30:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPOQZAM=Rq8tMLj8ikoCz_ff4kYF3_uuX7PKtBwaMGwA@mail.gmail.com>
Message-ID: <CAMuHMdUPOQZAM=Rq8tMLj8ikoCz_ff4kYF3_uuX7PKtBwaMGwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Fri, Jul 14, 2023 at 12:35 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
> >
> > On Thu, Jul 13, 2023 at 6:52 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> >
> > ...
> >
> > > > > +#define CSI_CKS_MAX                0x3FFF
> > > >
> > > > If it's limited by number of bits, i would explicitly use that
> > information
> > > > as
> > > > (BIT(14) - 1).
> > >
> > > That value represents the register setting for the maximum clock
> > divider.
> > > The maximum divider and corresponding register setting are plainly
> > stated
> > > in the HW User Manual, therefore I would like to use either (plain)
> > value
> > > to make it easier for the reader.
> > >
> > > I think perhaps the below makes this clearer:
> > > #define CSI_CKS_MAX_DIV_RATIO   32766
> >
> > Hmm... To me it's a bit confusing now. Shouldn't it be 32767?
>
> 32766 is the correct value.
>
> Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate the
> serial clock (output from master), with CSI_CLKSEL_CKS ranging from 0x1 (that
> means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided by 32766).
>
> >
> > > #define CSI_CKS_MAX             (CSI_CKS_MAX_DIV_RATIO >> 1)
> >
> > Whatever you choose it would be better to add a comment to explain
> > this. Because the above is more clear to me with BIT(14)-1 if the
> > register field is 14-bit long.
> > With this value(s) I'm lost. Definitely needs a comment.
>
> To cater for a wider audience (and not just for those who have read the
> HW manual), I think perhaps the below would probably be the best compromise:
>
> /*
>  * Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate the
>  * serial clock (output from master), with CSI_CLKSEL_CKS ranging from 0x1 (that
>  * means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided by 32766).
>  */
> #define CSI_CKS_MAX             (BIT(14)-1)

Or GENMASK(13, 0)

As we have

    #define CSI_CLKSEL_CKS          GENMASK(14, 1)

and bit 0 must of the CLKSEL register must always be zero, the actual
divider is incidentally FIELD_GET(GENMASK(14, 0), clksel).
No idea if that can be useful to simplify the code, though ;-)

> > > static inline unsigned int x_trg(unsigned int words)
> > > {
> > >         return fls(words) - 1;
> > > }
> >
> > OK, but I think you can use it just inplace, no need to have such as a
> > standalone function.
>
> The above is actually equivalent to ilog2()
>
> >
> > > static inline unsigned int x_trg_words(unsigned int words)
> > > {
> > >         return 1 << x_trg(words);
> > > }
> >
> > Besides a better form of BIT(...) this looks to me like NIH
> > roundup_pow_of_two().
>
> rounddown_pow_of_two().
>
> I have tested the driver with s/x_trg/ilog2 and
> s/x_trg_words/roundup_pow_of_two and it looks like I am losing tiny bit of
> performance (probably down to the use of ternary operators in both macros)
> but I think it's okay, let's not reinvent the wheel and let's keep it more
> readable, I'll switch to using the above macros.

You mean this is not lost in the noise of the big loop in
rzv2m_csi_pio_transfer(), which is even waiting on an event?
I find that a bit surprising...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
