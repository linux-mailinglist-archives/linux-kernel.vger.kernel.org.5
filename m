Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A829B7AC163
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjIWLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjIWLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:49:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC649F;
        Sat, 23 Sep 2023 04:49:20 -0700 (PDT)
Received: from g550jk.localnet (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CC44BD0F49;
        Sat, 23 Sep 2023 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695469759; bh=kBe11jmRLaOVJhGVOL0BQH3axSYxyviTE0+dWdDMB9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m6ONAgACgDg9nRxAFYlumXEaFnN7FSjLIuGbfeBQCTIbabGyec+zsn79N4v/C40Qv
         QLJuP5wYu4Yo8q2mwpSs/uPS1Zjnr4+AGu3AR1MBenW3+C21m0WKAcJCYBKXDkvxDy
         dU3DYUWWv34N783Gvg0vg2dl4cubFqAYoq0Qgxz0=
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
Date:   Sat, 23 Sep 2023 13:49:17 +0200
Message-ID: <3182524.5fSG56mABF@z3ntu.xyz>
In-Reply-To: <ZQ7NcuLOAwAJgQNr@gerhold.net>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
 <7570584.EvYhyI6sBW@z3ntu.xyz> <ZQ7NcuLOAwAJgQNr@gerhold.net>
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

On Samstag, 23. September 2023 13:35:25 CEST Stephan Gerhold wrote:
> On Sat, Sep 23, 2023 at 01:19:46PM +0200, Luca Weiss wrote:
> > On Samstag, 23. September 2023 12:00:52 CEST Stephan Gerhold wrote:
> > > On Sat, Sep 23, 2023 at 11:32:47AM +0200, Luca Weiss wrote:
> > > > Hi Matti,
> > > >=20
> > > > On Samstag, 23. September 2023 00:40:26 CEST Matti Lehtim=E4ki wrot=
e:
> > > > > Add pin <-> wakeirq mappings to allow for waking up the AP from
> > > > > sleep
> > > > > through MPM-connected pins.
> > > > >=20
> > > > > Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> > > > > ---
> > > > >=20
> > > > >  drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > > b/drivers/pinctrl/qcom/pinctrl-msm8226.c index
> > > > > 994619840a70..1e46a9ab382f
> > > > > 100644
> > > > > --- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > > +++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > > @@ -612,6 +612,16 @@ static const struct msm_pingroup
> > > > > msm8226_groups[] =3D
> > > > > {
> > > > >=20
> > > > >  #define NUM_GPIO_PINGROUPS 117
> > > > >=20
> > > > > +static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] =3D {
> > > > > +	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8=20
},
> > > >=20
> > > > I'm not really convinced this is the correct order of values...
> > > >=20
> > > > Let's look at downstream:
> > > >   qcom,gpio-map =3D <3  1>,
> > > >  =20
> > > >                   <4  4 >,
> > > >                   <5  5 >,
> > > >                   <6  9 >,
> > > >                   [...]
> > > >=20
> > > > From Documentation/devicetree/bindings/arm/msm/mpm.txt downstream:
> > > >   Each tuple represents a MPM pin and which GIC interrupt is routed=
 to
> > > >   it.
> > > >=20
> > > > So first is pin number, second is interrupt number.
> > > >=20
> > > > And check mainline:
> > > >   /**
> > > >  =20
> > > >    * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pi=
ns
> > > >    * @gpio:          The GPIOs that are wakeup capable
> > > >    * @wakeirq:       The interrupt at the always-on interrupt
> > > >    controller
> > > >    */
> > > >  =20
> > > >   struct msm_gpio_wakeirq_map {
> > > >  =20
> > > >   	unsigned int gpio;
> > > >   	unsigned int wakeirq;
> > > >  =20
> > > >   };
> > > >=20
> > > > So here we also have the order pin-interrupt, not the reverse order.
> > > >=20
> > > > Therefore I believe the order in this patch is incorrect, and it
> > > > should
> > > > rather>
> > > >=20
> > > > be:
> > > >   { 3, 1 }, { 4, 4 }, { 5, 5 }, { 6, 9 }, { 7, 13 }, { 8, 17 },
> > > >   [...]
> > > >=20
> > > > Or do you think I'm missing something?
> > >=20
> > > Yes :)
> > >=20
> > > Let's look at the later entries:
> > > > > +	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 },=20
{ 35,
> > > > > 14
> > > >=20
> > > > },
> > > >=20
> > > > > +	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19=20
}, { 48,
> > > > > 20
> > > >=20
> > > > },
> > > >=20
> > > > > +	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25=20
}, { 62,
> > > > > 26
> > > >=20
> > > > },
> > > >=20
> > > > > +	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31=20
}, { 68,
> > > > > 32
> > > >=20
> > > > },
> > > >=20
> > > > > +	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37=20
},
> > > > > +	{ 108, 38 }, { 109, 39 }, { 110, 40 }, { 111, 54 }, { 113,=20
55 },
> > > > > +};
> > > > > +
> > >=20
> > > For example: { 113, 55 }, i.e. { .gpio =3D 113, .wakeirq =3D 55 }.
> > >=20
> > > MSM8226 has GPIOs 0-116 and 64 MPM pins/interrupts. The order in this
> > > patch is the only one that can be correct because the definition would
> > > be invalid the other way around. 113 must be the GPIO number because =
it
> > > is larger than the 64 available MPM interrupt pins. :)
> >=20
> > So basically you're saying downstream is wrong / buggy?
>=20
> "Misleading" or "confusing" would be the words I would use. :-)

;)

>=20
> > From qcom,gpio-map =3D [...], <55 113>; it's taking the properties like=
 this
> >=20
> > (drivers/soc/qcom/mpm-of.c):
> >   unsigned long pin =3D be32_to_cpup(list++);
> >   irq_hw_number_t hwirq =3D be32_to_cpup(list++);
> >=20
> > Your explanation does make sense I guess but somewhere the link downstr=
eam
> > -> mainline must be broken, no?
>=20
> After staring at mpm-of.c for a while I would say that there:
>  - downstream "pin" =3D MPM pin =3D mainline "wakeirq"
>    - because this is used as index to msm_mpm_irqs_m2a, which has a size
>      of MSM_MPM_NR_MPM_IRQS (64)
>  - downstream "hwirq" =3D GPIO / GIC IRQ =3D mainline "gpio"
>=20
> This means for <55 113>: pin =3D wakeirq =3D 55 and hwirq =3D gpio =3D 11=
3.
> Which matches the definition in this patch:
>   { .gpio =3D 113, .wakeirq =3D 55 } =3D { 113, 55 }

=46un, thanks for digging into it!

@Matti: I think I see one missing entry here "<41  115>," on downstream, so
{ 115, 41 } appears to be missing in this patch? Or is there a reason you=20
omitted that one? The rest looks correct :)

Regards
Luca


>=20
> Stephan




