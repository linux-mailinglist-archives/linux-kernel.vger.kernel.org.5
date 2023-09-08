Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA8798B97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbjIHRuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbjIHRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:50:04 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D81FC9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:49:59 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so862275241.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1694195399; x=1694800199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxkJiBKLveTjR/MyjvH4BgWR32mfxg/8UW+rZs4kCOM=;
        b=T1NNv06h/qjDjtVBaLGVroaW7NGJTwQNHKLQDgzWig8fdIRKary97o9jEViPxV5gfP
         sb/tiQKTiBeCy+Qf0ueQj16nIgdcIEKunVcQnh3IWBOVgT+iqgAXkaNXyKl9IrtHB8dU
         C8e3+rHYR7s2RpXHE6SB5s05TbdjiwBf/vD9azzvshRATNdTpJJFZgBwNR7WYu+dQT6G
         ntV1U93abCfHhZUHS5wfAtoKvKc3jGDRASiJ+ZDcf1sw4PvjB5zuptTHqj2GusV23FYP
         wwD8oj5Qe4E9hkkzqxm+oKYrzh8K5KfCVFQUAfPgdu9ODl/V8Z0mgN9MeKDXxI4AZH+j
         GiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195399; x=1694800199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxkJiBKLveTjR/MyjvH4BgWR32mfxg/8UW+rZs4kCOM=;
        b=Z35hrVAc5UH159ovlZvjzLaGDF6026dYY7Lnn0wSGwSeaHFEZLYwE0iqeTwFXZGYJV
         BOAXk8DjCbN38f7AXaCasovmS2qtdCD1w4H+KtRi3/9kgvO+f8osU59gTLI8etEbAxHr
         k+z7D+Pf6M0TUFBHTjyKYXpLIxqH8/KqV0ZI9VzAtguyuwijIJGBhqpCSerzt/93rj83
         FqLOv2zpTaNNiLrOOp/yAFmY2J8s4Q+LRuiBZ0cx7D9bq61TXLERpHsRQq+KJdRVotbR
         XN8ANUpGDAIFghv2wV0wX5GXj5LiLvoUbdc+e7kEPdyqw2iqg/mUOc3fmbNtFLLvxufW
         eMug==
X-Gm-Message-State: AOJu0Yxxx4B8nvDzkj1LtTpTz3/nRf/dxxdFzXN3aWI1c9tG/9kk9qoZ
        Tle1nq7zLTtxRR4J8ukNJNHzT6jXKlctHXEW8Ln/Kg==
X-Google-Smtp-Source: AGHT+IGawjhNhMCD6wKUit8+66aH+EtzGvqGSZLgsVqp8xopld5IS+giA+svIo6DY0gy8EZu4aziUKcvEm8x4vLF5dM=
X-Received: by 2002:a67:fe92:0:b0:44d:482a:5444 with SMTP id
 b18-20020a67fe92000000b0044d482a5444mr3406902vsr.21.1694195399082; Fri, 08
 Sep 2023 10:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230908124344.171662-1-umang.jain@ideasonboard.com>
 <20230908124344.171662-3-umang.jain@ideasonboard.com> <vp3bbkaibfzdxzgv5xedpneqtyxqxlvioou5whb567s5txtgve@a4xr3wtmjqzu>
 <CAPY8ntCYz3D77R7G+JTKvOWW4uNTj-wKrsjJ7ASw_RoN4FU-ow@mail.gmail.com> <169419419630.3437168.7121485951334169757@ping.linuxembedded.co.uk>
In-Reply-To: <169419419630.3437168.7121485951334169757@ping.linuxembedded.co.uk>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 8 Sep 2023 18:49:42 +0100
Message-ID: <CAPY8ntAQvKhrFBP6b=RxOSc+siB+fwEep+83Y=gVcQeiLTUk3A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add driver for IMX519 sensor
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran

On Fri, 8 Sept 2023 at 18:30, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Dave,
>
> Quoting Dave Stevenson (2023-09-08 17:57:01)
> > Hi Jacopo
> >
> > On Fri, 8 Sept 2023 at 17:24, Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com> wrote:
> > >
> > > Hi Umang
> > >
> > > On Fri, Sep 08, 2023 at 08:43:44AM -0400, Umang Jain wrote:
> > > > From: Lee Jackson <lee.jackson@arducam.com>
> > > >
>
> ... <snip>
>
> > > > +/* Power/clock management functions */
> > > > +static int imx519_power_on(struct device *dev)
> > > > +{
> > > > +     struct i2c_client *client = to_i2c_client(dev);
> > > > +     struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > > +     struct imx519 *imx519 = to_imx519(sd);
> > > > +     int ret;
> > > > +
> > > > +     ret = regulator_bulk_enable(ARRAY_SIZE(imx519_supply_name),
> > > > +                                 imx519->supplies);
> > > > +     if (ret) {
> > > > +             dev_err(&client->dev, "%s: failed to enable regulators\n",
> > > > +                     __func__);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     ret = clk_prepare_enable(imx519->xclk);
> > > > +     if (ret) {
> > > > +             dev_err(&client->dev, "%s: failed to enable clock\n",
> > > > +                     __func__);
> > > > +             goto reg_off;
> > > > +     }
> > > > +
> > > > +     gpiod_set_value_cansleep(imx519->reset_gpio, 1);
> > >
> > > Usually on power_on the reset/poweron gpios are set to logical 0.
> > > If this works for you I think you need to invert the line polarity in
> > > your .dts.
> >
> > XCLR needs to go high for IMX519 to power on.
> > I think it possibly depends on what you've named it - reset vs power_on
> >
> > Quick sample (admittedly on 6.1 as that's what I happen to have):
> > gpiod_set_value_cansleep(XXX_gpio, 1); in power_on.
> > - imx219
> > - imx214
> > - imx274
> > - imx334
> > - imx335
> > - ov7251
> >
> > gpiod_set_value_cansleep(XXX_gpio, 0) in power_on
> > - imx290
> > - imx296
> > - imx412
>
> As this is a camera connected using the Raspberry Pi connector - I have
> been looking in this area too to add support for an IMX283.
>
> It occured to me that the GPIO line on the RPi Camera Connector seems to
> be named 'POWER_EN' ... and is usually responsible for enabling the
> power to the regulators on the camera module...
>
> It seems to me more 'clean/clear' to do something like the following:
>
>
> / {
>         /* 12 MHz Crystal on the camera module */
>         imx283_inclk_0: imx283-inclk-12m {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 status = "okay";
>                 clock-frequency = <12000000>;
>         };
>
>         reg_imx283_0_3v3: regulator-imx283-0-vdd3v3 {
>                 compatible = "regulator-fixed";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_csi0_pwdn>;
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>                 regulator-name = "IMX283_0_POWER";
>                 gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
>                 vin-supply = <&reg_csi1_3v3>;
>                 startup-delay-us = <300000>;
>                 enable-active-high;
>         };
> };
>
>
> &i2c2 {
>         sensor@1a {
>                 compatible = "sony,imx283";
>                 reg = <0x1a>;
>
>                 clocks = <&imx283_inclk_0>;
>                 clock-names = "xclk";
>
>                 rotation = <180>;
>                 orientation = <0>;
>
>                 status = "okay";
>
>                 VANA-supply = <&reg_imx283_0_3v3>; /* Analog 2.8v */
>                 VDIG-supply = <&reg_imx283_0_3v3>; /* Digital Core 1.05v */
>                 VDDL-supply = <&reg_imx283_0_3v3>; /* IF 1.8v */
>
>                 port {
>                         imx283_0_ep: endpoint {
>                                 remote-endpoint = <&mipi_csi_0_in>;
>                                 clock-lanes = <0>;
>                                 data-lanes = <1 2 3 4>;
>                         };
>                 };
>         };
> };
>
>
> I wondered if that's more clear than using a 'reset' line which isn't
> actually what the schematics show.

That's almost exactly what Raspberry Pi do :-)
About the only difference is that our overlays only assign one supply
(generally vana) to the regulator that controls the GPIO, with the
others attached to a dummy regulator.

It's a little spread between files, but combine:
https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/overlays/imx219.dtsi
https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/overlays/imx219-overlay.dts
with cam1_reg definition in
https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/bcm270x.dtsi#L178-L184
and then the per board configuration of where the control GPIO is in
https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/bcm2711-rpi-4-b.dts#L396-L398

You'll find the same arrangement for the imx519 in imx519.dtsi and
imx519-overlay.dts

Exposing the (optional) reset GPIO is generally so that it is
accurately describing the hardware, and there is the option for
driving all regulators, clocks, and reset lines from the SoC.

> > > > +     usleep_range(IMX519_XCLR_MIN_DELAY_US,
> > > > +                  IMX519_XCLR_MIN_DELAY_US + IMX519_XCLR_DELAY_RANGE_US);
> > >
> > > fsleep() will do
> > >
> > > > +
> > > > +     return 0;
> > > > +
> > > > +reg_off:
> > > > +     regulator_bulk_disable(ARRAY_SIZE(imx519_supply_name), imx519->supplies);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int imx519_power_off(struct device *dev)
> > > > +{
> > > > +     struct i2c_client *client = to_i2c_client(dev);
> > > > +     struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > > +     struct imx519 *imx519 = to_imx519(sd);
> > > > +
> > > > +     gpiod_set_value_cansleep(imx519->reset_gpio, 0);
> > > > +     regulator_bulk_disable(ARRAY_SIZE(imx519_supply_name), imx519->supplies);
> > > > +     clk_disable_unprepare(imx519->xclk);
> > >
> > > Usually, the reverse power up sequence is used. It shouldn't make any
> > > difference, unless the datasheet prescribes this sequence.
> >
> > I'd agree.
> > T1 from XCLR falling to VANA/VDIG/VIF falling is 0us, so XCLR must go
> > low first. VANA, VDIG, and VIF can then fall in any order.
> >
> > The diagram shows INCK stopping before XCLR is dropped.
> > Driving a clock signal into powered down electronics is generally "a
> > bad thing", so the clock should be stopped before the regulators are
> > killed.
> >
> > Again this is copied from imx477. Our modules don't matter as all 3
> > regulators, clock, and XCLR are sequenced off one GPIO.
>
> Indeed, that's the part that makes me think modelling the regulator part
> rather than a reset gpio could potentially make sense, but I'm sure this
> is one of those scenarios that someone is about to shoot down my idea
> ;-)

Going back about 4 years I used to have the firmware patching the
reset GPIO for the relevant sensor driver.

That fell apart with the CM4 where there is one shutdown line fed to
both camera ports - only one driver instance could claim the GPIO.
Switching to regulators meant that the regulator framework did all the
required refcounting for me, and life was happy again. It is also
easier to define the relevant GPIO for the regulator at a platform
level, rather than in the overlays, therefore the firmware didn't need
to do any patching.

  Dave
