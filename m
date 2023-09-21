Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFD7AA297
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIUVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjIUVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:21:54 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0023AB2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:49:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414ba610766so110221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695329398; x=1695934198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh6IU7l+47WVk29lRNIwzcthY2OavZyY10j7V0QRROQ=;
        b=C8nQMuDgu7w9ER3QusbT0MV2CCDbhmt6B/+437cUrdtUkpKoUAeaKG4srQwnJCJ2Lv
         uZr/q0FWbxF3oVyfYRRydQm+R2ZU0q+xdHF2TDdFWnqxvVLNc5DoCHyAxnmGALJNWklO
         XlbgIpai4qtvz1a8zhEVHOnSdx0MOBcNDHl6B/gQrdHw5n0EnUmCYKceohTpf9JDCtNy
         CrJd9kOw61iGP+dHsFYmYKho9AEnQKp0y0kculbx67Al769rdd8X7vJKRwPcBv5MyPfi
         PCUTtvDYA1zAb4LY9XkI9unBRrO6/pOX9p0ro8vtNy1d5O+x6m3eone0VRqu7dr5Ka33
         D0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695329398; x=1695934198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qh6IU7l+47WVk29lRNIwzcthY2OavZyY10j7V0QRROQ=;
        b=AbBsb8A3MWghTiUc49m1gMcvZrtiWcIErl1hta0bIvWVEfptRHcW0+SbcgO1HDTa4N
         XMfY3Gqf0WDRKh75ehNzZXDoG/moB0dNuoXWj1pXOODRZDB0zX8bvkcomMszYYZSyWxN
         jBNANJNe89sf471+mBcL5LxRLpwmZd0zkA2J8ihpJOX/4pcMOWKkN1p7FA5YCX686PgN
         rX5OR+0LOsTP1yJs9oYA11dX67Y+swAa1JhdRc1d+diPO0Aep7ITBJDgd0GodPrZVC1J
         XqBbYcedpTQOiLRlNA6rXgUvKTN0v47JsFZkHWSMuoFbX96ceufmAYYuR72Id2UAzcEY
         ntnQ==
X-Gm-Message-State: AOJu0YyDwzw87WKkN18FxjYTo9PL4aE8tZWfBrKvi9oLW0bn94YDokfM
        YiODN5nLm/79NpZh1biKM7daYyBPxA7fI0oJS8zd3w==
X-Google-Smtp-Source: AGHT+IFGwQ1FeVPJ97J3G1IlVsExp5/EPDgKPo6q2mVerDf97KxTlSJlpjszXhIfW9sENf2e372EC5OpENIRboN35R0=
X-Received: by 2002:a05:622a:1490:b0:417:ccca:25a3 with SMTP id
 t16-20020a05622a149000b00417ccca25a3mr24132qtx.12.1695329398122; Thu, 21 Sep
 2023 13:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de> <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de> <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
 <20230915065120.GQ637806@pengutronix.de> <CAGETcx-stUfkVmkwGhj7iBWfCRsY5uZ=CxJdX9pPY6OO6oGUhg@mail.gmail.com>
 <20230921135756.GT637806@pengutronix.de>
In-Reply-To: <20230921135756.GT637806@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 21 Sep 2023 13:49:21 -0700
Message-ID: <CAGETcx8Ora87tbjVek-2WZW1QqHp+uB63r4w73ekBByPUDdTpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain dependency
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 6:57=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>
> On Wed, Sep 20, 2023 at 03:00:28PM -0700, Saravana Kannan wrote:
> > On Thu, Sep 14, 2023 at 11:51=E2=80=AFPM Sascha Hauer <s.hauer@pengutro=
nix.de> wrote:
> > >
> > > On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
> > > > On Tue, Sep 12, 2023 at 11:58=E2=80=AFPM Sascha Hauer <s.hauer@peng=
utronix.de> wrote:
> > > > >
> > > > > On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> > > > > > On Tue, Sep 12, 2023 at 4:07=E2=80=AFPM Linus Walleij <linus.wa=
lleij@linaro.org> wrote:
> > > > > > >
> > > > > > > Top posting to bring Saravana Kannan into this discussion.
> > > > > > >
> > > > > > > This looks like a big hack to me, Saravana has been working
> > > > > > > tirelessly to make the device tree probe order "sort itself o=
ut"
> > > > > > > and I am pretty sure this issue needs to be fixed at the DT
> > > > > > > core level and not in a driver.
> > > > > >
> > > > > > We could merge all the IO domain stuff into the pinctrl node/dr=
iver,
> > > > > > like is done for Allwinner? Maybe that would simplify things a =
bit?
> > > > >
> > > > > I thought about this as well. On Rockchip the pinctrl driver and =
the IO
> > > > > domain driver even work on the same register space, so putting th=
ese
> > > > > into a single node/driver would even feel more natural than what =
we have
> > > > > now.
> > > >
> > > > Then we should try to do this and fix any issues blocking us.
> > > >
> > > > > However, with that the pinctrl node would get the supplies that t=
he IO
> > > > > domain node now has and we would never get into the probe of the =
pinctrl
> > > > > driver due to the circular dependencies.
> > > >
> > > > From a fw_devlink perspective, the circular dependency shouldn't be=
 a
> > > > problem. It's smart enough to recognize all cycle possibilities (si=
nce
> > > > 6.3) and not enforce ordering between nodes in a cycle.
> > > >
> > > > So, this is really only a matter of pinctrl not trying to do
> > > > regulator_get() in its probe function. You need to do the
> > > > regulator_get() when the pins that depend on the io-domain are
> > > > requested. And if the regulator isn't ready yet, return -EPROBE_DEF=
ER?
> > >
> > > That's basically what my series does already, I return -EPROBE_DEFER
> > > from the pinctrl driver when a pin is requested and the IO domain is =
not
> > > yet ready.
> > >
> > > >
> > > > Is there something that prevents us from doing that?
> > >
> > > No. We could do that, but it wouldn't buy us anthing. I am glad to he=
ar
> > > that fw_devlink can break the circular dependencies. With this we cou=
ld
> > > add the supplies to the pinctrl node and the pinctrl driver would sti=
ll
> > > be probed.
> > >
> > > With the IO domain supplies added to the pinctrl node our binding wou=
ld
> > > be cleaner, but still we would have to defer probe of many requested
> > > pins until finally the I2C driver providing access to the PMIC comes
> > > along. We also still need a "Do not defer probe for these pins" prope=
rty
> > > in the pingrp needed for the I2C driver.
> >
> > Sorry about the slow reply. Been a bit busy.
> >
> > Oh, this is not true though. With the example binding I gave,
> > fw_devlink will automatically defer the probe of devices that depend
> > on pins that need an iodomain/regulator.
> >
> > pinctrl {
> >     compatible =3D "rockchip,rk3568-pinctrl";
> >     i2c0 {
> >                 /omit-if-no-ref/
> >                 i2c0_xfer: i2c0-xfer {
> >                         rockchip,pins =3D
> >                                 /* i2c0_scl */
> >                                 <0 RK_PB1 1 &pcfg_pull_none_smt>,
> >                                 /* i2c0_sda */
> >                                 <0 RK_PB2 1 &pcfg_pull_none_smt>;
> >                 };
> >     }
> >     ...
> >     ...
> >     pinctrl-io {
> >         compatible =3D "rockchip,rk3568-pinctrl-io";
> >         pmuio1-supply =3D <&vcc3v3_pmu>;
> >         cam {
> >             ....
> >         }
> >         ....
> >         ....
> > }
> >
> > consumerA {
> >    pinctrl-0 =3D <&cam>;
> > }
> >
> > With this model above, there are no cycles anymore.
>
> The cycles are gone because you skipped the problematic case in your
> example.
>
> Replace consumerA in your example with the I2C node providing access to
> the PMIC which provides &vcc3v3_pmu and then you have the cycles back.

When you are talking about the I2C node that's the bus master for the
PMIC providing the supply, wouldn't it be dependent on "i2c0_xfer"?
And not "cam"?

Otherwise there's a cyclic functional dependency in hardware that can
never be met? Because in that case, your changes would end up
deferring the I2C device probe too.

I'm basically asking to split out the pins that need IO domain to work
into a new subnode "pinctrl-io" of the main "pinctrl" device node.

> The I2C master device needs the IO domain which needs a regulator
> provided by a client on the very same I2C master. The cycles are
> actually there in hardware, you can't define them away ;)

Right, there can be a cyclic connection dependency in hardware and you
can't define them away. But clearly the I2C master doesn't need the IO
domain to work for the I2C to be initialized, right? Otherwise, how
can the I2C hardware be initialized? It doesn't matter what OS we
have, that hardware can't work. So, what am I missing? We are clearly
not on the same page on some details.

Thanks,
Saravana

>
> Sascha
>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
