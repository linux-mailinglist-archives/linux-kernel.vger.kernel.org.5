Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1737AC114
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIWLU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIWLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:20:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C5199;
        Sat, 23 Sep 2023 04:20:19 -0700 (PDT)
Received: from g550jk.localnet (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 54D47D0F49;
        Sat, 23 Sep 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695467987; bh=wsBaglYAmYjbumCRjQtjc66/0govKpHw/ihiiK++rxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ICTc9yyrhI4NAI0u465gK2WfY9QJLR9RBD4xvgyu+SniW9/J40Am1be2nEZ7bnNq6
         ZA8mZAhV9Z4dVi4mdnFXYG7nfMoQC1KdTs0o4k2WrAb31Q9QCXAz/dHgHKEnrVusN1
         KqR7GW1GFaflJys0xniuAzz0EG9tT2FixKqbJxD4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: msm8226: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 13:19:46 +0200
Message-ID: <7570584.EvYhyI6sBW@z3ntu.xyz>
In-Reply-To: <ZQ63VCVfR51Ueunv@gerhold.net>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
 <10339711.nUPlyArG6x@z3ntu.xyz> <ZQ63VCVfR51Ueunv@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 23. September 2023 12:00:52 CEST Stephan Gerhold wrote:
> On Sat, Sep 23, 2023 at 11:32:47AM +0200, Luca Weiss wrote:
> > Hi Matti,
> >=20
> > On Samstag, 23. September 2023 00:40:26 CEST Matti Lehtim=E4ki wrote:
> > > Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> > > through MPM-connected pins.
> > >=20
> > > Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> > > ---
> > >=20
> > >  drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > b/drivers/pinctrl/qcom/pinctrl-msm8226.c index
> > > 994619840a70..1e46a9ab382f
> > > 100644
> > > --- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > +++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > @@ -612,6 +612,16 @@ static const struct msm_pingroup msm8226_groups[=
] =3D
> > > {
> > >=20
> > >  #define NUM_GPIO_PINGROUPS 117
> > >=20
> > > +static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] =3D {
> > > +	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8 },
> >=20
> > I'm not really convinced this is the correct order of values...
> >=20
> > Let's look at downstream:
> >   qcom,gpio-map =3D <3  1>,
> >  =20
> >                   <4  4 >,
> >                   <5  5 >,
> >                   <6  9 >,
> >                   [...]
> >=20
> > From Documentation/devicetree/bindings/arm/msm/mpm.txt downstream:
> >   Each tuple represents a MPM pin and which GIC interrupt is routed to =
it.
> >=20
> > So first is pin number, second is interrupt number.
> >=20
> > And check mainline:
> >   /**
> >  =20
> >    * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
> >    * @gpio:          The GPIOs that are wakeup capable
> >    * @wakeirq:       The interrupt at the always-on interrupt controller
> >    */
> >  =20
> >   struct msm_gpio_wakeirq_map {
> >  =20
> >   	unsigned int gpio;
> >   	unsigned int wakeirq;
> >  =20
> >   };
> >=20
> > So here we also have the order pin-interrupt, not the reverse order.
> >=20
> > Therefore I believe the order in this patch is incorrect, and it should
> > rather>=20
> > be:
> >   { 3, 1 }, { 4, 4 }, { 5, 5 }, { 6, 9 }, { 7, 13 }, { 8, 17 },
> >   [...]
> >=20
> > Or do you think I'm missing something?
>=20
> Yes :)
>=20
> Let's look at the later entries:
> > > +	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 }, { 35, 14
> >=20
> > },
> >=20
> > > +	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19 }, { 48, 20
> >=20
> > },
> >=20
> > > +	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25 }, { 62, 26
> >=20
> > },
> >=20
> > > +	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31 }, { 68, 32
> >=20
> > },
> >=20
> > > +	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 },
> > > +	{ 108, 38 }, { 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 },
> > > +};
> > > +
>=20
> For example: { 113, 55 }, i.e. { .gpio =3D 113, .wakeirq =3D 55 }.
>=20
> MSM8226 has GPIOs 0-116 and 64 MPM pins/interrupts. The order in this
> patch is the only one that can be correct because the definition would
> be invalid the other way around. 113 must be the GPIO number because it
> is larger than the 64 available MPM interrupt pins. :)

So basically you're saying downstream is wrong / buggy?

=46rom qcom,gpio-map =3D [...], <55 113>; it's taking the properties like t=
his
(drivers/soc/qcom/mpm-of.c):

  unsigned long pin =3D be32_to_cpup(list++);
  irq_hw_number_t hwirq =3D be32_to_cpup(list++);

Your explanation does make sense I guess but somewhere the link downstream =
=2D>=20
mainline must be broken, no?

Regards
Luca


>=20
> Thanks,
> Stephan




