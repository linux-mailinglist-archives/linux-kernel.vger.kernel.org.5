Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA7756151
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGQLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGQLP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:15:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DCE45;
        Mon, 17 Jul 2023 04:15:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99364ae9596so635104366b.1;
        Mon, 17 Jul 2023 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689592557; x=1692184557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBg+se2TKplOLO7bdoST+fqCafmJ3rdJVHXdD1afWpc=;
        b=LwywWnnUf9nrWR1QpAxn5d4V3AGNUgIQIRaJ9H+EF8jnJNowrQWIMLx1OPEwd0s1oS
         p0+rWQG8qvof7Ung8cO6OV19GHuMhJ3HMK2OJ0mjN90bM7nFSS/lox0jxW2k9e0otUme
         P5JK7Tv2hP+RuPQGnm0cpmNBh6j/o2d8Xjdcys3vqCEt9kCnJwTb+1BDP1mLOLWKJaxe
         QWSwNyXkpJe1yMlQFxw5UuaxTS6mMkaJlEulNRM3ThN56z72qbv6LiHBpgdnkC79py4h
         V4Ta9FtgjRnPY7cA7sK2M/80QB6yAaTZp6CohQa2w54fAd7ajBqNMOZUx7LM0eLrjcZ8
         ZR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592557; x=1692184557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBg+se2TKplOLO7bdoST+fqCafmJ3rdJVHXdD1afWpc=;
        b=HVEdcXisHwk9L/c/3jqf69Ch1jbcU7hduhCUxoeiYDjgRXTfSaxxH7GJn0RWFmEuqK
         /T0VIW/X771HClhnBSeDW6M2i+YPSTQsz3SvJMgDltAvmVlk17u4MaoPlrX4H7wV1kNu
         tW/zRxyXxcCJZg7nrIcNA30ru0ae90Up5m5vHHC48BMX4R73UXBgkqRZhsnD+/Vh8u8A
         WIL6YTZvhgrBXRF1eTHmIeJk5di0bG4Ex24f99Ne46SdAY0SWusCR2kgAAC2/5Tx3j3o
         wI7HnYy6gWdCAKYFaOdoRZ5I2RqKqttUagQPsYklO/oXma2SijB+oPMCtR7ODIzXhy72
         bTnw==
X-Gm-Message-State: ABy/qLZN9oemFKGacrgananObTLGqoTVj6RDkrlLbJEV6O1dP8hv8YTe
        vPnVDa5dzKj4q6/GWHsB/k0u81zAluZJEOjidkDKFwXecSM=
X-Google-Smtp-Source: APBJJlGOwew/CPDHF3J6JBHnS20pV1qd9EE64X8GjAtKJ9VxhO3/n1sPRDTO0MzC9Gch/OWqDF7/rwy+/1yLwSBs0tM=
X-Received: by 2002:a17:906:7397:b0:994:18c4:3303 with SMTP id
 f23-20020a170906739700b0099418c43303mr11255906ejl.18.1689592555983; Mon, 17
 Jul 2023 04:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-7-fabrizio.castro.jz@renesas.com> <CAHp75VdyUhvk9JA4oW6iYjK=YdatjG3OVa0APMQrc+un2EyadQ@mail.gmail.com>
 <TYWPR01MB8775831C81B7153DB24F86C2C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB8775831C81B7153DB24F86C2C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 14:15:19 +0300
Message-ID: <CAHp75Ve7dHQVtYWvq8DjtGe+9nM_vkkmLj2-MUvwzozqOXAaTQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] spi: rzv2m-csi: Squash timing settings into one statement
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 1:44=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > On Sat, Jul 15, 2023 at 4:04=E2=80=AFAM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:

...

> > >         /* Setup clock polarity and phase timing */
> > > -       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
> > > -                               !(spi->mode & SPI_CPOL));
> > > -       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
> > > -                               !(spi->mode & SPI_CPHA));
> > > +       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_MODE,
> > > +                               ~spi->mode & SPI_MODE_X_MASK);
> >
> > I think this now regresses due to the absence of parentheses.
>
> This looks okay to me. CSI_CLKSEL_CKP needs to contain the inverted value
> of SPI_CPOL, and CSI_CLKSEL_DAP needs to contain the inverted value of
> SPI_CPHA, and that happens with both use cases.

Ah, this is interchangeable since we will get the same bits in the end, ind=
eed.

--=20
With Best Regards,
Andy Shevchenko
