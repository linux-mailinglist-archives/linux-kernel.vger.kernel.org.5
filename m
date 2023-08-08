Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74527748C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjHHTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbjHHTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:39:29 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289D59DC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:51:13 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4476f713e15so2093780137.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691520672; x=1692125472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7dpQqp3igR4lqKwjP6w0osFBZ3PZiFfViS04CWVCyo=;
        b=Dae7k/MTdvWO8tc8PGMalRBZD7+LodSwirAQ0ikfwqi2jzx1bUTwlYQqX8bEyFnghK
         yfSOiT23O+GAkmFXdGmZ0Z6jDMErp3R7PJKSwguXcGUsoFXTFUC9kGw8ONL6j2BYDNtw
         /Ss9VZ3UW2K6FC8fYBnbFwkKhf44tqzracC0wrwL9MadR15RmrnkdO23W4mO6hnI29uh
         VAKd17wxMUWrQ622YtVvLVgIyUz88kFFW6GZYwTFCbHApZIbg8AOR4KB151RZi07b5Xf
         y6ATNEYRIvfFevZN83CTpsymKBcjlQWGJh0fqijT0XcSpvYGtPgxWhX5GnK8aSv0jfIo
         pMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520672; x=1692125472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7dpQqp3igR4lqKwjP6w0osFBZ3PZiFfViS04CWVCyo=;
        b=TRQvt/xsm5G83v+v60eHgHD+C/MDFoodCMqXixQZU9QlGg/mBudkP6TYDLFJ2uP+EY
         TwkZFwEz9TjAbA3QLNoUuy9VBTCNsY85/Re3xUcTYs8hDa5yUVhWMwuRfAgQn5++OSEj
         x0TOH81i4yDkOYJdvgV0WbXcApshe+/6NxB+OEUoVSHSKFXLYDXNVvosNIKUx+uq6kay
         pT7wZIx4GpucA2foMJwogRHoKMG805G6S+i4PNv/WOU5SvTRIs0HICRTc19apJ3tBgfI
         hEZjXSmt4VcDThL+V+l3VKK8yj3gSt3Ah88v28LBICfO4EE4+n6usL69Bc45Ii+4iCva
         0FJQ==
X-Gm-Message-State: AOJu0YzjKj9gZj9razusdzgkavibU/2skvJvxt6tLDpk8uRWhDN8rnKc
        B8rhHjQF6jge4gXIH5/XZ95+mg6lPowKKn+rNfAs7w==
X-Google-Smtp-Source: AGHT+IEo9vua2y2D8pNsCaUFO3D6FDvMRdlptQj5UA2pUH1+fSZOWabaRNMUZxr1m1TOnki80MoL1YQq6NhTaYYzsMA=
X-Received: by 2002:a67:d085:0:b0:447:4b52:5c8 with SMTP id
 s5-20020a67d085000000b004474b5205c8mr798787vsi.26.1691520672390; Tue, 08 Aug
 2023 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230808120254.11653-1-brgl@bgdev.pl> <82cd26a3-e63d-4251-9d43-d1d7443b9cce@lunn.ch>
In-Reply-To: <82cd26a3-e63d-4251-9d43-d1d7443b9cce@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Aug 2023 20:51:01 +0200
Message-ID: <CAMRc=MfDtCj0ML-FQH8-Cm23YupOnmScBqKDrLExqSjqeHhOSg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: don't create the MDIO bus if
 there's no mdio node on DT
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 8:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Aug 08, 2023 at 02:02:54PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The stmmac_dt_phy() function that parses the device-tree node of the MA=
C
> > and allocates the MDIO and PHY resources misses one use-case: when the
> > MAC doesn't have a fixed link but also doesn't define its own mdio bus
> > on the device tree and instead shares the MDIO lines with a different
> > MAC with its PHY phandle reaching over into a different node.
>
> It does not share the MDIO lines. The other MDIO bus master happens to
> have two PHYs and there are no PHYs on this MDIO bus, so no point
> instantiating it.

Yes, I sent it before we established that thanks to Andrew's input.

>
> >  static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
> >                        struct device_node *np, struct device *dev)
> >  {
> > -     bool mdio =3D !of_phy_is_fixed_link(np);
> >       static const struct of_device_id need_mdio_ids[] =3D {
> >               { .compatible =3D "snps,dwc-qos-ethernet-4.10" },
> >               {},
> >       };
> >
> > +     if (of_phy_is_fixed_link(np))
> > +             return 0;
> > +
>
>                 /**
>                  * If snps,dwmac-mdio is passed from DT, always register
>                  * the MDIO
>                  */
>                 for_each_child_of_node(np, plat->mdio_node) {
>                         if (of_device_is_compatible(plat->mdio_node,
>                                                     "snps,dwmac-mdio"))
>                                 break;
>                 }
>
> The comment suggests it should always be registered. This MAC might
> have a fixed-phy, but that does not mean there is not an Ethernet
> switch on the bus, or a PHY for some other MAC etc. MDIO busses
> masters should be considered fully independent devices.
>
> https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf=
/vf610-zii-ssmb-dtu.dts
>
> &fec1 {
>         phy-mode =3D "rmii";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_fec1>;
>         status =3D "okay";
>
>         fixed-link {
>                 speed =3D <100>;
>                 full-duplex;
>         };
>
>         mdio1: mdio {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 clock-frequency =3D <12500000>;
>                 suppress-preamble;
>                 status =3D "okay";
>
>                 switch0: switch0@0 {
>                         compatible =3D "marvell,mv88e6190";
>                         pinctrl-0 =3D <&pinctrl_gpio_switch0>;
>                         pinctrl-names =3D "default";
>                         reg =3D <0>;
>                         eeprom-length =3D <65536>;
>                         interrupt-parent =3D <&gpio3>;
>                         interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
>                         interrupt-controller;
>                         #interrupt-cells =3D <2>;
>
> Both a fixed link, and something on the MDIO bus....
>
>      Andrew

Makes sense, we can drop all my stmmac patches from today, I need to
rethink it in detail.

Bart
