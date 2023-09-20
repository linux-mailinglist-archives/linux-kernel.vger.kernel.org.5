Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7B7A8F16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjITWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITWBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:01:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE54CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:01:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41761e9181eso64431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695247265; x=1695852065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySgTFRif0OhDbbpB+8wVZjSypEFgsdIXoRMvaDKaYV0=;
        b=SuYBAF5i6Q5CuZyDineu84uzq4HnJdkdrfIkfwCtYmOtwGqCdd5rg79usviFIJ0b6L
         +b6CCmxQr7DMuMMsOZIsYsARmv70PUK/A1oSCIpjO6WMJUgt3UdCHSI1yBKRETzmTkMu
         VL3tRVulu3reQxw7LAewIYQ7jf/oQyFXol66BC/Aswtlo6gMmcyY+jaoVmLImucHay8C
         Bl9ot+OzMY56D9Iwci90cBCcAaAoGRuNlyxyjncGJtAuwVcJj8HhndoU0TYtOy0MjGfm
         dih77nfQpEFPgJ21Ei6yBkiiNa9kAc5BNMu/USDnV3TWpIZjkcOWAdJU40AtrwJSDwME
         hIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695247265; x=1695852065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySgTFRif0OhDbbpB+8wVZjSypEFgsdIXoRMvaDKaYV0=;
        b=Uf7nMYnRynM5Z3x/Ln9sMsFDZ3d7S2DiHDXKiXPTctWtq3MxXyzfnWY0doWlvp8snK
         mY8jXRQi35eDs/sxwAudmU5SlsTkCcpPya4eoFg6tHE6MMBL3nEPZ5XAltC+yBGsotP7
         kzVixzea1Hb6WSwibsy61tMANPr4johOXw4tYZia5DssvD9qdA7qUBHu8YYDdtZwcYFV
         s0rGQRm4Ne7c8MfB7bcextQ1mH8V3BlJvpBNhCHRA6KYubUtH+mFpXHjd3juzP8okQzf
         l3FvR39BG8MrL/xUDAToY9tP8xC5nbYwQO392qvrD3PKlfJQevD+jP9F3jXIbhzhfu4a
         rssA==
X-Gm-Message-State: AOJu0YzxbMRfeH1HgDTCgeREC/1CAsZBQtd1CEeK8Z2P1q3voU4rX30b
        sumGTN2FrEMjcYef9kouldxfw2jtH4WR7BFGBb6gFQ==
X-Google-Smtp-Source: AGHT+IEIOGxOAfu95VjtBYDLxqKoGbq4TqwAOEQIYf2CdZGJkcySlLQPkIPiA1p0zbP/TrMmND9qvTxVsJtv7K76oBM=
X-Received: by 2002:ac8:7f48:0:b0:412:16f:c44f with SMTP id
 g8-20020ac87f48000000b00412016fc44fmr84660qtk.6.1695247264772; Wed, 20 Sep
 2023 15:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de> <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de> <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
 <20230915065120.GQ637806@pengutronix.de>
In-Reply-To: <20230915065120.GQ637806@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Sep 2023 15:00:28 -0700
Message-ID: <CAGETcx-stUfkVmkwGhj7iBWfCRsY5uZ=CxJdX9pPY6OO6oGUhg@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:51=E2=80=AFPM Sascha Hauer <s.hauer@pengutronix.=
de> wrote:
>
> On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
> > On Tue, Sep 12, 2023 at 11:58=E2=80=AFPM Sascha Hauer <s.hauer@pengutro=
nix.de> wrote:
> > >
> > > On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> > > > On Tue, Sep 12, 2023 at 4:07=E2=80=AFPM Linus Walleij <linus.wallei=
j@linaro.org> wrote:
> > > > >
> > > > > Top posting to bring Saravana Kannan into this discussion.
> > > > >
> > > > > This looks like a big hack to me, Saravana has been working
> > > > > tirelessly to make the device tree probe order "sort itself out"
> > > > > and I am pretty sure this issue needs to be fixed at the DT
> > > > > core level and not in a driver.
> > > >
> > > > We could merge all the IO domain stuff into the pinctrl node/driver=
,
> > > > like is done for Allwinner? Maybe that would simplify things a bit?
> > >
> > > I thought about this as well. On Rockchip the pinctrl driver and the =
IO
> > > domain driver even work on the same register space, so putting these
> > > into a single node/driver would even feel more natural than what we h=
ave
> > > now.
> >
> > Then we should try to do this and fix any issues blocking us.
> >
> > > However, with that the pinctrl node would get the supplies that the I=
O
> > > domain node now has and we would never get into the probe of the pinc=
trl
> > > driver due to the circular dependencies.
> >
> > From a fw_devlink perspective, the circular dependency shouldn't be a
> > problem. It's smart enough to recognize all cycle possibilities (since
> > 6.3) and not enforce ordering between nodes in a cycle.
> >
> > So, this is really only a matter of pinctrl not trying to do
> > regulator_get() in its probe function. You need to do the
> > regulator_get() when the pins that depend on the io-domain are
> > requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?
>
> That's basically what my series does already, I return -EPROBE_DEFER
> from the pinctrl driver when a pin is requested and the IO domain is not
> yet ready.
>
> >
> > Is there something that prevents us from doing that?
>
> No. We could do that, but it wouldn't buy us anthing. I am glad to hear
> that fw_devlink can break the circular dependencies. With this we could
> add the supplies to the pinctrl node and the pinctrl driver would still
> be probed.
>
> With the IO domain supplies added to the pinctrl node our binding would
> be cleaner, but still we would have to defer probe of many requested
> pins until finally the I2C driver providing access to the PMIC comes
> along. We also still need a "Do not defer probe for these pins" property
> in the pingrp needed for the I2C driver.

Sorry about the slow reply. Been a bit busy.

Oh, this is not true though. With the example binding I gave,
fw_devlink will automatically defer the probe of devices that depend
on pins that need an iodomain/regulator.

pinctrl {
    compatible =3D "rockchip,rk3568-pinctrl";
    i2c0 {
                /omit-if-no-ref/
                i2c0_xfer: i2c0-xfer {
                        rockchip,pins =3D
                                /* i2c0_scl */
                                <0 RK_PB1 1 &pcfg_pull_none_smt>,
                                /* i2c0_sda */
                                <0 RK_PB2 1 &pcfg_pull_none_smt>;
                };
    }
    ...
    ...
    pinctrl-io {
        compatible =3D "rockchip,rk3568-pinctrl-io";
        pmuio1-supply =3D <&vcc3v3_pmu>;
        cam {
            ....
        }
        ....
        ....
}

consumerA {
   pinctrl-0 =3D <&cam>;
}

With this model above, there are no cycles anymore.

pictrl doesn't depend on anything.
vcc3v3_pmu will depend on pinctrl (not shown in DT above).
pinctrl-io depends on pinctrl and vcc3v3_pmu.
consumerA depends on pinctrl-io.

So pinctrl probes first.
vcc3v3 will probe next.
pinctrl-io will probe now that the supply is ready.
consumerA will probe now that pinctrl-io is ready.

fw_devlink will enforce all these dependencies because it understands
pinctrl and -supply bindings.

-Saravana

>
> I would consider this being a way to cleanup the bindings, but not a
> solution at DT core level that Linus was aiming at.
>
> >
> > > >
> > > > IIRC on Allwinner SoCs the PMIC pins don't have a separate power ra=
il,
> > > > or if they do they almost certainly use the default I/O rail that i=
s
> > > > always on, and so we omit it to work around the dependency cycle.
> > >
> > > I looked into sun50i as an example. This one has two pinctrl nodes, p=
io
> > > and r_pio. Only the former has supplies whereas the latter, where the
> > > PMIC is connected to, has (found in sun50i-a64-pinephone.dtsi):
> > >
> > > &r_pio {
> > >         /*
> > >          * FIXME: We can't add that supply for now since it would
> > >          * create a circular dependency between pinctrl, the regulato=
r
> > >          * and the RSB Bus.
> > >          *
> > >          * vcc-pl-supply =3D <&reg_aldo2>;
> > >          */
> > > };
> > >
> > > At least it show me that I am not the first one who has this problem =
;)
> > >
> > > We could add the supplies to the pingroup subnodes of the pinctrl dri=
ver
> > > to avoid that, but as Saravana already menioned, that would feel like
> > > overkill.
> >
> > So my comment yesterday was that it'd be an overkill to make every
> > struct pin_desc into a device. But if you can split that rockchip
> > pinctrl into two devices, that should be okay and definitely not an
> > overkill.
> >
> > Maybe something like:
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
> > So pinctrl will probe successfully and add it's child device
> > pinctrl-io. i2c0 will probe once pinctrl is available. Then eventually
> > the regulator will probe. And after all that, pinctrl-io would probe.
> >
> > This has no cycles and IMHO represents the hardware accurately. You
> > have a pinctrl block and there's a sub component of it (pinctrl-io)
> > that works differently and has additional dependencies.
> >
> > Any thoughts on this?
>
> By making the IO domain device a child node of the pinctrl node we
> wouldn't need a phandle from the pinctrl node to the IO domain node
> anymore, but apart from that the approach is equivalent to what we have
> already.
>
> Given that fw_devlink allows us to add the supplies directly to the
> pinctrl node, I would prefer doing that. But as said, it doesn't solve
> the problem.
>
> Sascha
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
