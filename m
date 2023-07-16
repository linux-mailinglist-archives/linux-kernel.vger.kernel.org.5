Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648C754E63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGPKzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPKzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 06:55:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409D10FE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 03:55:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so5441760e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689504929; x=1692096929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRj53D+WEUxtTgjHcIaXf65gwyPY5iEFP7btFKZGgIc=;
        b=4pHEL2Xx5puQ4s3Dkya4+HhyaxO5Tyv6Wd6IYWZhc+1YQ7yrMmWyQCtlgIusCUtQUL
         0R+qP/XqfIt5dE/xpd9CNLjO1MzxhAWkqDB0/tMmoSBbDsxDKIqHVDmyZMOeebF47xWc
         7rUm4vh5mcqQ8LlxxflJknwLp/4tgh0X2QYAQbnKP0BvXfXdHety4EBJZvC3+EXoVwJs
         /n2s7f6ayjaIU4fbvntRGnye/ztsP20/VgtYLbqjN2FeYOgnn2ZZkp+eDRBB2C4c0wuN
         cy1irghnE7YTUe7H1a+HSkbNHPGNxDP3JoyvArPc4lBjAw+tx15WbZNsLFEb48gUUDhn
         rDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689504929; x=1692096929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRj53D+WEUxtTgjHcIaXf65gwyPY5iEFP7btFKZGgIc=;
        b=I+SoIZqT8MghsMCSILd3PO5Xo1yfEpC32V3oY/jbCRf247JLNWolGH2PNEMXDaiDpn
         wifuh+39mr4ZqexnHepRG3ZYDGPE3N+pPfs7V0z547WQvkoZW4qQzEPKKrI7IKZW6joK
         dOiBeQusswCDGNQmWY/1TQ4TzAf27UlelrfXOyVOflSewC7Oxub/XCCxKz6pxVKWgTWB
         A7u1/oHUw3IuS1uyUtjsy4ZFZjQADTck3aiV9ekeq71YFlMginBn5NpPm2h/Exsp/vja
         Ww+qVzeuB0MjqW2xgDDqhVPd3i+SLsC80GZMQZ913H/RT28aFlj1QVzRgKddAZzHJGY7
         tblQ==
X-Gm-Message-State: ABy/qLa67r2kctLqigASqaNMlOQfxbxwxqznEJamOUFT7c8iL3lHw0Z9
        HPfF7k2FiflfzdJquVLgadN7yYe8LIn3i4ar0tk//Q==
X-Google-Smtp-Source: APBJJlEtKjyj1HRwslkInMcIb9BW4D5pjbaZP9j2e2vxft1FXh+0BE1rn9hvBIYPbbIfCZzWwNvBs+A0GGFQ2QgjC8Q=
X-Received: by 2002:a05:6512:3995:b0:4fb:c881:be5b with SMTP id
 j21-20020a056512399500b004fbc881be5bmr6793976lfu.2.1689504928722; Sun, 16 Jul
 2023 03:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <20230713202123.231445-2-alex@shruggie.ro>
 <20230714172444.GA4003281-robh@kernel.org>
In-Reply-To: <20230714172444.GA4003281-robh@kernel.org>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 16 Jul 2023 13:55:17 +0300
Message-ID: <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To:     Rob Herring <robh@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Jul 13, 2023 at 11:21:23PM +0300, Alexandru Ardelean wrote:
> > For VSC8351 and similar PHYs, a new property was added to generate a cl=
ock
> > signal on the CLKOUT pin.
>
> Sorry, didn't think about it on v1, but I would imagine other vendors'
> PHYs have similar functionality. We should have something common. We
> have the clock binding for clocks already, so we should consider if
> that should be used here. It may look like an overkill for what you
> need, but things always start out that way. What if you want to turn the
> clock on and off as well?

So, there's the adin.c PHY driver which has a similar functionality
with the adin_config_clk_out().
Something in the micrel.c PHY driver (with
micrel,rmii-reference-clock-select-25-mhz); hopefully I did not
misread the code about that one.
And the at803x.c PHY driver has a 'qca,clk-out-frequency' property too.

Now with the mscc.c driver, there is a common-ality that could use a framew=
ork.

@Rob are you suggesting something like registering a clock provider
(somewhere in the PHY framework) and let the PHY drivers use it?
Usually, these clock signals (once enabled on startup), don't get
turned off; but I've worked mostly on reference designs; somewhere
down the line some people get different requirements.
These clocks get connected back to the MAC (usually), and are usually
like a "fixed-clock" driver.
In our case, turning off the clock would be needed if the PHY
negotiates a non-gigabit link; i.e 100 or 10 Mbps; in that case, the
CLKOUT signal is not needed and it can be turned off.

Maybe start out with a hook in 'struct phy_driver'?
Like "int (*config_clk_out)(struct phy_device *dev);" or something?
And underneath, this delegates to the CLK framework?

I'd let Andrew (or someone in netdev) have a final feedback here.

I can (probably) try to allocate some time to do this change based on
the MSCC driver in the next weeks, if there's a consensus.

Thanks
Alex

>
> > This change documents the change in the device-tree bindings doc.
>
> That's obvious.
>
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >
> > Changelog v1 -> v2:
> > * https://lore.kernel.org/netdev/20230706081554.1616839-2-alex@shruggie=
.ro/
> > * changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-=
mhz'
> >   as requested by Rob
> > * added 'net-next' tag as requested by Andrew
> >
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 0a3647fe331b..085d0e8a834e 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >                         VSC8531_LINK_100_ACTIVITY (2),
> >                         VSC8531_LINK_ACTIVITY (0) and
> >                         VSC8531_DUPLEX_COLLISION (8).
> > +- mscc,clkout-freq-mhz       : For VSC8531 and similar PHYs, this will=
 output
> > +                       a clock signal on the CLKOUT pin of the chip.
> > +                       The supported values are 25, 50 & 125 Mhz.
> > +                       Default value is no clock signal on the CLKOUT =
pin.
> >  - load-save-gpios    : GPIO used for the load/save operation of the PT=
P
> >                         hardware clock (PHC).
> >
> > @@ -69,5 +73,6 @@ Example:
> >                  vsc8531,edge-slowdown        =3D <7>;
> >                  vsc8531,led-0-mode   =3D <VSC8531_LINK_1000_ACTIVITY>;
> >                  vsc8531,led-1-mode   =3D <VSC8531_LINK_100_ACTIVITY>;
> > +                mscc,clkout-freq-mhz =3D <50>;
> >               load-save-gpios         =3D <&gpio 10 GPIO_ACTIVE_HIGH>;
> >          };
> > --
> > 2.41.0
> >
