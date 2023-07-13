Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E921A7528EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjGMQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGMQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:39:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220530E2;
        Thu, 13 Jul 2023 09:38:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992af8b3b1bso129876466b.1;
        Thu, 13 Jul 2023 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266278; x=1691858278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTECy0XE9pksvk9rdGARn97yQLZqz//+TnGl/dlhC8U=;
        b=LxmQm36UdLQFMfeY8RdzbMNvYNdRO3URIM2OIPYsIdK1cKvUj9Ws0A/Yc9Sr6UWgjD
         XSvC+1+8qKw7jZeFn+070dRy6AmOsjW4s+xqVsrOXwGutRjhn8aRKPUAlqv4KfQLcEcY
         VHAiiebL9Bt8ehlrlSIR/qbz5xy2K1DCBpMOMLoUyruZhV4ozqCXTrpwe8iqBe+KHwIQ
         fIp5x0kZS8TGi/PwAhYDafhvnU0oXsxxzFxVrE5VdkqDWlj67ITUtyehmpeO8bkWZI9i
         Nd4NqOL5vpu1+8J1W63f8lyZrzPwfn7nNbklr9FhVM5SQPk7aa541SWy+mzph8eQxRk8
         uCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266278; x=1691858278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTECy0XE9pksvk9rdGARn97yQLZqz//+TnGl/dlhC8U=;
        b=bp9rJp86gziskVtkkUsJ44TvRjchlTFFOBkYgDaxhcO+xnJgQKqcM7d/AqqHMZCW4V
         SfIgkCTNpNuvcCC2oOP7m4ejqntSbs6OpJg4/DSYXADJW3Dp3N7BAhh2HqJpJX2tajkg
         yai4/97wKV0PMZQQxP8/hCXeCuKnHs29AL2uSPP0i3/++ikB7Ltn9EOMgjJRCi0E8QTm
         R8q5yN2zwV38iHfWKJoTim4KA8pMhy/16rg/ivlMZ3JSsnRXVlM09pjVJXJ2l9RQSdeZ
         SMXB7/DAWzGJnMq4Q/VI9Z2zU5GccondEqsPaUQ9bKDxGkOIAOYzIRIWiURw2WwHvR3F
         fbIA==
X-Gm-Message-State: ABy/qLag7fQViwS5vKHooFizebG3X8LyAcKsUlbXgB7Rmjwfh8xO1g7C
        DvkFwS0E5j64plnc1ZQxCKuziABauMxs45urKOw=
X-Google-Smtp-Source: APBJJlGzH3G9XAI9c6oMbI4Oz6FFlkjKXtasXUPbuk8ioVjP+JYGwaJgV512pPkq6HUAcrL7dexnIafPgpeALgsVoTo=
X-Received: by 2002:a17:906:1d6:b0:993:ce6c:685c with SMTP id
 22-20020a17090601d600b00993ce6c685cmr1647900ejj.18.1689266277529; Thu, 13 Jul
 2023 09:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com> <ZKVI4XPbPXfzQa9J@surfacebook>
 <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jul 2023 19:37:20 +0300
Message-ID: <CAHp75VcJvRq7BotoODW_BOh84+TD_1Q3vbXSQv3FCiJfnBx8Vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 6:52=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:

...

> > > +#define CSI_CKS_MAX                0x3FFF
> >
> > If it's limited by number of bits, i would explicitly use that informat=
ion
> > as
> > (BIT(14) - 1).
>
> That value represents the register setting for the maximum clock divider.
> The maximum divider and corresponding register setting are plainly stated
> in the HW User Manual, therefore I would like to use either (plain) value
> to make it easier for the reader.
>
> I think perhaps the below makes this clearer:
> #define CSI_CKS_MAX_DIV_RATIO   32766

Hmm... To me it's a bit confusing now. Shouldn't it be 32767?

> #define CSI_CKS_MAX             (CSI_CKS_MAX_DIV_RATIO >> 1)

Whatever you choose it would be better to add a comment to explain
this. Because the above is more clear to me with BIT(14)-1 if the
register field is 14-bit long.
With this value(s) I'm lost. Definitely needs a comment.

...

> > > +static const unsigned char x_trg[] =3D {
> > > +   0, 1, 1, 2, 2, 2, 2, 3,
> > > +   3, 3, 3, 3, 3, 3, 3, 4,
> > > +   4, 4, 4, 4, 4, 4, 4, 4,
> > > +   4, 4, 4, 4, 4, 4, 4, 5
> > > +};
> > > +
> > > +static const unsigned char x_trg_words[] =3D {
> > > +   1,  2,  2,  4,  4,  4,  4,  8,
> > > +   8,  8,  8,  8,  8,  8,  8,  16,
> > > +   16, 16, 16, 16, 16, 16, 16, 16,
> > > +   16, 16, 16, 16, 16, 16, 16, 32
> > > +};
> >
> > Why do you need tables? At the first glance these values can be easily
> > calculated from indexes.
>
> I think I am going to replace those tables with the below (and of course
> adjust the callers accordingly since the argument is not an index anymore=
):
>
> static inline unsigned int x_trg(unsigned int words)
> {
>         return fls(words) - 1;
> }

OK, but I think you can use it just inplace, no need to have such as a
standalone function.

> static inline unsigned int x_trg_words(unsigned int words)
> {
>         return 1 << x_trg(words);
> }

Besides a better form of BIT(...) this looks to me like NIH
roundup_pow_of_two().

...

> > > +   /* Setup clock polarity and phase timing */
> > > +   rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
> > > +                           !(spi->mode & SPI_CPOL));
> > > +   rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
> > > +                           !(spi->mode & SPI_CPHA));
> >
> > Is it a must to do in a sequential writes?
>
> It's not a must, I'll combine those 2 statements into 1.

If so, you can use SPI_MODE_X_MASK.

...

> > > +   controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
> >
> > SPI_MODE_X_MASK
>
> This statement sets the mode_bits. Using a macro meant to be used as a
> mask in this context is something I would want to avoid if possible.

Hmm... not a big deal, but I think that's what covers all mode_bits,
and mode_bits by nature _is_ a mask.

--=20
With Best Regards,
Andy Shevchenko
