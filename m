Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF77AD8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjIYNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIYNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:19:51 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5A127
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:19:44 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59c0b9ad491so75549457b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647983; x=1696252783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxcsoZ0xLkSaR9KvbRz9tqLOvey6ZsTOWgCgXDOLYzQ=;
        b=NiRw72CF44qD5RVEI4kmkzdIE9ee+3ZrxznvKmTjcstj/djsgS2ZSul6Yf4cXCFtEi
         V38ePqG50wqqK2umzgznK5f/1istebfAEo6AevT+9fgdfCbAd0JQlfJ9CC7PrZ92DHJQ
         RDsSMqW01Cbo2ie0m+fEqgaypR9cqlMYiZz+1VoiJk6/EJV9o+vlYWTMz3CUurcNUJFr
         LjIEhDTx6ad6//cW4bC8opbrhvJZaY60dZObGU/3bZ8B1WGPt+Odk8z9w4qS+KUhvse+
         rMlCwNMvIxM+44YiWQo6fXX0YR2WEzLuYuZox4PJidi/JVOkMj0ntUiyHTdbtyVnGZcJ
         zkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647983; x=1696252783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxcsoZ0xLkSaR9KvbRz9tqLOvey6ZsTOWgCgXDOLYzQ=;
        b=cpQ2JPJmjRQa7BgoWciMtlYrdqndk840+GeWc2hYbOeWrpyP9Mo5FRHWJgZr3XCapA
         q7N58bQSqn1Uwsqj5LlhDKqpHcDkqondtZdxMDESbDca0zlDSUGycIgm9dRwmZwS06A8
         XuyDcqh9UGJ2c3bBcy4m3JO+eceeVumrWMRI89o5mvJX4O4cp8RRjEBguYUnqtsOlLWU
         QFM5M0UE0bQPvpXygUIWWyHafqLYJ9txrIOddmnaaxduZlGPsid2FuqUvOl6/M9eYeuc
         awLobUvXV3bgDaw8igU5YvFT/Dndzf0wmrnl1C/UKdNW0J0WHqG6fGDeow6WodKJuu/Y
         UUVA==
X-Gm-Message-State: AOJu0YxKQw1no4BRgk+SEKeZ71ROp7tuUp274W7zgFNGxfJ4bH/sQQ7r
        Ij8g85u0uPkhq9QI/dIwA7tu3h0Z6YJsFjwfx+jlCA==
X-Google-Smtp-Source: AGHT+IEp1iHR121kzotgjzMhLMq2qfNvPKxxyO5GLYRSemVkpZ14ry7yATEh5Q8hfy1iqDe+/zxbrW+97FmCXF1eaG8=
X-Received: by 2002:a81:4e12:0:b0:5a1:d352:9fe1 with SMTP id
 c18-20020a814e12000000b005a1d3529fe1mr115994ywb.42.1695647983132; Mon, 25 Sep
 2023 06:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com> <CACRpkdYYKAFLvpKH0ih5qZVbv7L3auny5WWx+qKa_HD1o-vsog@mail.gmail.com>
 <OS0PR01MB5922A256D2C57963ADEBCEDB86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CACRpkdbM+XNjvxBZQFzZCsU+3V7PucBhbi_WjVtnGpakFQasAw@mail.gmail.com> <OS0PR01MB592202B4523DDC18B3E4511D86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592202B4523DDC18B3E4511D86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 15:19:32 +0200
Message-ID: <CACRpkdYXXWVemZ0TBKN46rTTO4yChLjfsKioNm-HSZrNKQZDZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 4:06=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:

> > > 2) Digital Noise Filter Clock Selection Register (FILCLKSEL):
> > >
> > > The FILCLKSEL register selects the divided clock to be input to digit=
al
> > noise filters.
> > >
> > > 00b: Not divided (initial value)
> > > 01b: Divided by 9000 (41.666 ns x 9000 =3D 375,000 ns)
> > > 10b: Divided by 18000 (41.666 ns x 18000 =3D 750,000 ns)
> > > 11b: Divided by 36000 (41.666 ns x 36000 =3D 1,500,000 ns)
> > > Note: This value is the value when the external clock is 24MHz.
> > >
> > > Q1) What is the recommended way to associate the above values with
> > >     PIN_CONFIG_INPUT_DEBOUNCE?
> > >
> > > Eg: I need to configure filter on, 8 stage filter , a divisor of 1800=
0
> > for a mechanical button bounce noise.
> >
> > As per the generic pin config and DT bindings:
> >
> >  * @PIN_CONFIG_INPUT_DEBOUNCE: this will configure the pin to debounce
> > mode,
> >  *      which means it will wait for signals to settle when reading inp=
uts.
> > The
> >  *      argument gives the debounce time in usecs. Setting the
> >  *      argument to zero turns debouncing off.
> >
> >   input-debounce:
> >     $ref: /schemas/types.yaml#/definitions/uint32
> >     description: Takes the debounce time in usec as argument or 0 to
> > disable
> >       debouncing
> >
> > The recommended way is to pass the desired clock cycle in microseconds =
as
> > the argument to the pin config.
>
> How to add number of FF stages info on top of this clock cycle?

You don't, look below.

> Use some encoding in DT and decode it in driver??

No you put in the desired delay in microseconds, the  you use
the table that you already provided to look up the appropriate
divisor:

> 00b: Not divided (initial value)
> 01b: Divided by 9000 (41.666 ns x 9000 =3D 375,000 ns)
> 10b: Divided by 18000 (41.666 ns x 18000 =3D 750,000 ns)
> 11b: Divided by 36000 (41.666 ns x 36000 =3D 1,500,000 ns)

For 0, 375, 750 and 1500 us...

> Note: This value is the value when the external clock is 24MHz.

And this can be provided from the clock framework, and then
you need some more elaborate math to calculate the right
divisor from the parameter in the device tree.

Yours,
Linus Walleij
