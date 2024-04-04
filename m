Return-Path: <linux-kernel+bounces-131575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26F8989A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35E21C29F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB401292FC;
	Thu,  4 Apr 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="mUA21glA"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082C129A75
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239982; cv=none; b=bnVwjRxCdEHh949SjmcU3kBApRkPlhMjmCgMtKwptWdUzmXJzXyPTFpHosKkvOkzPrH0bxcDuaZXdF9RZPHlbFpFLZh4PAXM91W2SEIehvQXtSFK1tXZraWBBMJrNXpK5Il9J21lFBoJy6FjvRSbXpWOnjGn8d4iwckR/loV9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239982; c=relaxed/simple;
	bh=24DVCB0AtO6sSu8g6iu7VSYImGTEkT8jVFxncvRBhFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwRab4VTyGPHnXXNL3uZDuJijKEdwbusj3dtSaSsYosKjEZa4ZKborG+Baz2h+/6FRCCx8daXEIEBdU0L1Gyd+azhpPMa9WRi+vAGBFmgx9xMCBnwIhv0OxB766mimgP87Z8iISz8ZqiZyJc8gG15G1tJpz2c8Snwp1mdaUdJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=mUA21glA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1070653276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1712239978; x=1712844778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptApJg0lZA58LEoF0DTe5yUBAeVKWs9Xi1CFZCKcXxk=;
        b=mUA21glAzn3GYXuuB27gAwTa61C8yJVtmMH0SkjKgjmOefSpecUzJXvLpjtOxAK7/a
         lgg27jOxkUSqqOf6rqk6Z4X95V5saD8PE3oTlZB7qURtAqbZjBit8V9SnXLbDn0E/w5O
         azwFkwg/4ec8fgoV/jXskWsaZ5jTHMVbvjHbTKdy3HSnAnzmUQwOYRdp7Gdu0Lt32w8q
         4zAM5f4A76HuxkINeFcA15Emm83Xh/+jGdWkeEtFeIMj5VZh3ernuXl27V0Q99B1PSsE
         kHnZ3FfqhkxzJqh2JbHVyoPADdh7QV/lsrqJ1cytAKXsZZfTC58h1PVeTFQQVa3yOMz7
         U6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712239978; x=1712844778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptApJg0lZA58LEoF0DTe5yUBAeVKWs9Xi1CFZCKcXxk=;
        b=Bdm8VKunWnNCReICynTyXDoPk5sakHOPMZ1yoJ4XwNwoI0sPddygJYMbqIsIz27rXH
         E2wW6MBNSVBSqIWuDCs+CmM6kkpfzb4HRa1Y/X6p29RmRKEHDD2QtjjpdXnvBuf2hesp
         A7/TmC5tjfnnDghg5blSzETfK123NtpJY5QUZwGfdtzZCr5i2MhYq8T/E3xqWU3volgR
         OZeNT05RoDV4s97YqkPBs9elG3v4LLiH5jMQRjUawqW2I4YFJ5HTcPkRiQdYZclViWPJ
         0ua+ZN1vV4dTwu9BG8yKDLXqpGVPDtfqayrGRJ6JNv28PdJ+qYeei/tsbWeMNPmFYHZQ
         +lNA==
X-Forwarded-Encrypted: i=1; AJvYcCXS18VKXG/LQsNh1haHZ6fDCSmDsVp4OcatgMpTqP2jeCamzqymJDbCj8tagI76tbFgXCnRX8kWC4udC8QjYmT2EMFRzmKKcyI835qh
X-Gm-Message-State: AOJu0Yx1qsHJYVy9wTsyhaC0KGPOyU40cC3ASOJzRWLC5KVQscSgpIZV
	6HQiJmTGA3jEuNojqhAKAoDSKoUNd/5eZvEe5nhvbh5Cnr8td0Kq1mLF+8N3wnQLlRekrGzOgUy
	ViDeMZLOweFgBtq+OGv1GzoVZSCSAQsLTxylcZg==
X-Google-Smtp-Source: AGHT+IFY4/FdCnSuzKJ1eMiQ01HA592h+X+sKaRzMe2lVBT5Rjt65RxAtvBBhTXwCHu7tLtZ/tYJJVE8QkX+SGVDQGs=
X-Received: by 2002:a25:848e:0:b0:dcf:a52d:6134 with SMTP id
 v14-20020a25848e000000b00dcfa52d6134mr2583779ybk.26.1712239978579; Thu, 04
 Apr 2024 07:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403150355.189229-1-git@luigi311.com> <20240403150355.189229-24-git@luigi311.com>
 <Zg2DBasC501hMQSS@kekkonen.localdomain> <wjlcde7yoooygj4hhdmiwrdloh6l4p6i2qbmjek5uwsifyzwgu@xjhutvmsdfou>
 <dd0e64c8-5eef-421a-9d9f-8a5865743369@luigi311.com>
In-Reply-To: <dd0e64c8-5eef-421a-9d9f-8a5865743369@luigi311.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 4 Apr 2024 15:12:42 +0100
Message-ID: <CAPY8ntAcB3wyLj1wNE5YBx0_UGRiXEv6057XfEBfjk8NOLC9yQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for
 powerdown gpio
To: Luigi311 <git@luigi311.com>
Cc: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pavel@ucw.cz, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luigi

On Wed, 3 Apr 2024 at 20:34, Luigi311 <git@luigi311.com> wrote:
>
> On 4/3/24 10:57, Ond=C5=99ej Jirman wrote:
> > Hi Sakari and Luis,
> >
> > On Wed, Apr 03, 2024 at 04:25:41PM GMT, Sakari Ailus wrote:
> >> Hi Luis, Ondrej,
> >>
> >> On Wed, Apr 03, 2024 at 09:03:52AM -0600, git@luigi311.com wrote:
> >>> From: Luis Garcia <git@luigi311.com>
> >>>
> >>> On some boards powerdown signal needs to be deasserted for this
> >>> sensor to be enabled.
> >>>
> >>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >>> Signed-off-by: Luis Garcia <git@luigi311.com>
> >>> ---
> >>>  drivers/media/i2c/imx258.c | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> >>> index 30352c33f63c..163f04f6f954 100644
> >>> --- a/drivers/media/i2c/imx258.c
> >>> +++ b/drivers/media/i2c/imx258.c
> >>> @@ -679,6 +679,8 @@ struct imx258 {
> >>>     unsigned int lane_mode_idx;
> >>>     unsigned int csi2_flags;
> >>>
> >>> +   struct gpio_desc *powerdown_gpio;
> >>> +
> >>>     /*
> >>>      * Mutex for serialized access:
> >>>      * Protect sensor module set pad format and start/stop streaming =
safely.
> >>> @@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
> >>>     struct imx258 *imx258 =3D to_imx258(sd);
> >>>     int ret;
> >>>
> >>> +   gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
> >>
> >> What does the spec say? Should this really happen before switching on =
the
> >> supplies below?
> >
> > There's no powerdown input in the IMX258 manual. The manual only mentio=
ns
> > that XCLR (reset) should be held low during power on.
> >
> > https://megous.com/dl/tmp/15b0992a720ab82d.png
> >
> > https://megous.com/dl/tmp/f2cc991046d97641.png
> >
> >    This sensor doesn=E2=80=99t have a built-in =E2=80=9CPower ON Reset=
=E2=80=9D function. The XCLR pin
> >    is set to =E2=80=9CLOW=E2=80=9D and the power supplies are brought u=
p. Then the XCLR pin
> >    should be set to =E2=80=9CHigh=E2=80=9D after INCK supplied.
> >
> > So this input is some feature on camera module itself outside of the
> > IMX258 chip, which I think is used to gate power to the module. Eg. on =
Pinephone
> > Pro, there are two modules with shared power rails, so enabling supply =
to
> > one module enables it to the other one, too. So this input becomes the =
only way
> > to really enable/disable power to the chip when both are used at once a=
t some
> > point, because regulator_bulk_enable/disable becomes ineffective at tha=
t point.
> >
> > Luis, maybe you saw some other datasheet that mentions this input? IMO,
> > it just gates the power rails via some mosfets on the module itself, si=
nce
> > there's not power down input to the chip itself.
> >
> > kind regards,
> >       o.
> >
>
> Ondrej, I did not see anything else in the datasheet since I'm pretty sur=
e
> I'm looking at the same datasheet as it was supplied to me by Pine64. I'm
> not sure what datasheet Dave has access to since he got his for a
> completely different module than what we are testing with though.

I only have a leaked datasheet (isn't the internet wonderful!)  [1]
XCLR is documented in that, as Ondrej has said.

If this powerdown GPIO is meant to be driving XCLR, then it is in the
wrong order against the supplies.

This does make me confused over the difference between this powerdown
GPIO and the reset GPIO that you implement in 24/25.

Following the PinePhone Pro DT [3] and schematics [4]
reset-gpios =3D <&gpio1 RK_PA0 GPIO_ACTIVE_LOW>;
powerdown-gpios =3D <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;

Schematic page 11 upper right block
GPIO1_A0/ISP0_SHUTTER_EN/ISP1_SHUTTER_EN/TCPD_VBUS_SINK_EN_d becomes
Camera_RST_L. Page 18 feeds that through to the RESET on the camera
connector.
Page 11 left middle block GPIO2_D4/SDIO0_BKPWR_d becomes DVP_PDN1_H.
Page 18 feeds that through to the PWDN on the camera connector.

Seeing as we apparently have a lens driver kicking around as well,
potentially one is reset to the VCM, and one to the sensor? DW9714
does have an XSD shutdown pin.
Only the module integrator is going to really know the answer,
although potentially a little poking with gpioset and i2cdetect may
tell you more.

  Dave

[1] https://web.archive.org/web/20201027131326/www.hi.app/IMX258-datasheet.=
pdf
[2] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-2=
0211127.pdf
[3] https://xff.cz/git/linux/tree/arch/arm64/boot/dts/rockchip/rk3399-pinep=
hone-pro.dts?h=3Dorange-pi-5.18#n868
[4] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-2=
0211127.pdf


> >>> +
> >>>     ret =3D regulator_bulk_enable(IMX258_NUM_SUPPLIES,
> >>>                                 imx258->supplies);
> >>>     if (ret) {
> >>> @@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
> >>>     ret =3D clk_prepare_enable(imx258->clk);
> >>>     if (ret) {
> >>>             dev_err(dev, "failed to enable clock\n");
> >>> +           gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> >>>             regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->suppl=
ies);
> >>>     }
> >>>
> >>> @@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
> >>>     clk_disable_unprepare(imx258->clk);
> >>>     regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> >>>
> >>> +   gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> >>> +
> >>>     return 0;
> >>>  }
> >>>
> >>> @@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *cli=
ent)
> >>>     if (!imx258->variant_cfg)
> >>>             imx258->variant_cfg =3D &imx258_cfg;
> >>>
> >>> +   /* request optional power down pin */
> >>> +   imx258->powerdown_gpio =3D devm_gpiod_get_optional(&client->dev, =
"powerdown",
> >>> +                                               GPIOD_OUT_HIGH);
> >>> +   if (IS_ERR(imx258->powerdown_gpio))
> >>> +           return PTR_ERR(imx258->powerdown_gpio);
> >>> +
> >>>     /* Initialize subdev */
> >>>     v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
> >>>
> >>
> >> --
> >> Regards,
> >>
> >> Sakari Ailus
>

