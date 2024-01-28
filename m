Return-Path: <linux-kernel+bounces-41578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6A83F4D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF35E1C21301
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5514A87;
	Sun, 28 Jan 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="vxZpAxfC"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DADDD1;
	Sun, 28 Jan 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434730; cv=none; b=bi2QGOlgOn62A6tuhU4M5fnQjT3WYiWqAvCK/CmxoUpzPTg/LxX110JH1Goo623b1ZMIbINNnBKXDQYZjCe+ueej8Bke2VzIjtcpFv4E5p575/sPJbssPBYsIoWDcLgmV3YY02wuagWRRH911zsAXnQI3FiJIeAo8cFUgvYKcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434730; c=relaxed/simple;
	bh=fO5fYT35Z7MKeF67leMqLfINjyNPp1p8IGLqCFKXs18=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=dwWnr+LzfYZh9AdE4BVhkC72Y+CfZbxKPTAPLx2w+wcU3PUjDtR42IzSVmc+AXgyh4ppi3YZZmq29PJfsCRFUJbzXI3G7EMYuoNVvs2JLMl8/iQ/tYjzT7F7bqgdaADKOu9zJx0tJJiiA+hJKOG49l2TqMIIHw4Y2l7g0PendSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=vxZpAxfC; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 69FF9283C55;
	Sun, 28 Jan 2024 10:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1706434717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlGNDBEfBFU3AoPRlSCYcJlBbV7WU9V8gU5maCx3FEQ=;
	b=vxZpAxfCscrgPaGQ5mGojnxv9NP3lSv+1V+7cUrVS1vjSHhLauQPfExFirKYlzhNS2hisK
	g176AifOVkJDLQIQw5EB+ImP3ib9GFiWZq30xdv9mQNJPx46S8QTfuvaYRmcS45rr5fHzW
	lFhej5tu77C79i9J/gZEVsJktEcSc4A=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 43283442392;
	Sun, 28 Jan 2024 10:38:37 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jan 2024 10:38:36 +0100
Message-Id: <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
 <20240125122634.GE74950@google.com>
In-Reply-To: <20240125122634.GE74950@google.com>

Lee,

thank you for your feedback.

On Thu Jan 25, 2024 at 1:26 PM CET, Lee Jones wrote:

[...]

> > +#define PM88X_REG_INT_STATUS1			0x05
> > +
> > +#define PM88X_REG_INT_ENA_1			0x0a
> > +#define PM88X_INT_ENA1_ONKEY			BIT(0)
> > +
> > +enum pm88x_irq_number {
> > +	PM88X_IRQ_ONKEY,
> > +
> > +	PM88X_MAX_IRQ
> > +};
>
> An enum for a single IRQ?

There will be a lot more IRQs but I have only added this one so far as
it is the only one used by this series -- is that OK?

> > +static struct reg_sequence pm886_presets[] =3D {
> > +	/* disable watchdog */
> > +	REG_SEQ0(PM88X_REG_WDOG, 0x01),
>
> Easier to read if you place spaces between them.
>
> > +	/* GPIO1: DVC, GPIO0: input */
> > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
>
> Shouldn't you set these up using Pintrl?

You mean to add a new MFD cell for the pins and write the respective
driver? The downstream implementation has no such thing so I'm not sure
if I would be able to do that from scratch.

> > +	/* GPIO2: input */
> > +	REG_SEQ0(PM88X_REG_GPIO_CTRL2, 0x00),
> > +	/* DVC2, DVC1 */
>
> Please unify all of the comments.
>
> They all use a different structure.
>
> > +	REG_SEQ0(PM88X_REG_GPIO_CTRL3, 0x44),
> > +	/* GPIO5V_1:input, GPIO5V_2: input */
> > +	REG_SEQ0(PM88X_REG_GPIO_CTRL4, 0x00),
> > +	/* output 32 kHz from XO */
> > +	REG_SEQ0(PM88X_REG_AON_CTRL2, 0x2a),
> > +	/* OSC_FREERUN =3D 1, to lock FLL */
> > +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL1, 0x0f),
> > +	/* XO_LJ =3D 1, enable low jitter for 32 kHz */
> > +	REG_SEQ0(PM88X_REG_LOWPOWER2, 0x20),
> > +	/* OV_VSYS and UV_VSYS1 comparators on VSYS disabled, VSYS_OVER_TH : =
5.6V */
> > +	REG_SEQ0(PM88X_REG_LOWPOWER4, 0xc8),
> > +	/* set the duty cycle of charger DC/DC to max */
> > +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),
>
> These all looks like they should be handled in their respective drivers?
>
> "patch"ing these in seems like a hack.

To be honest, I don't really know why these are required and what effect
they have -- the comments above taken from the downstream version are
the only thing I have to go by. I might try removing them to see if
there is any noticable change and whether they could be added only later
with the respective drivers.

>
> > +};
>
> Why this instead of=20

What are you refering to here please?

> > +static struct resource onkey_resources[] =3D {
> > +	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
> > +};
> > +
> > +static struct mfd_cell pm88x_devs[] =3D {
> > +	{
> > +		.name =3D "88pm88x-onkey",
> > +		.num_resources =3D ARRAY_SIZE(onkey_resources),
> > +		.resources =3D onkey_resources,
> > +		.id =3D -1,
> > +	},
> > +};
>
> It's not an MFD if it only supports a single device.

As I have noted above with respect to the IRQ enum and also in the
commit message, I have so far only added the parts which there is
already use for. I intend to add the other parts along with the
respective subdevice drivers, please see my regulator series [1] for an
example.

I thought this approach would make for shorter and simpler patches and
also would allow me to make more informed decisions as I familiarize
myself with the downstream subdevice drivers more closely one by one.

> > +	i2c_set_clientdata(client, chip);
> > +
> > +	device_init_wakeup(&client->dev, 1);
> > +
> > +	chip->regmaps[PM88X_REGMAP_BASE] =3D devm_regmap_init_i2c(client, &pm=
88x_i2c_regmap);
> > +	if (IS_ERR(chip->regmaps[PM88X_REGMAP_BASE])) {
>
> Just define different regmaps if you really need them.

You mean not to use an array of regmaps but add new struct members
instead? One for each regmap?

> > diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> > new file mode 100644
> > index 000000000000..a34c57447827
> > --- /dev/null
> > +++ b/include/linux/mfd/88pm88x.h

[...]

> > +#define PM88X_REG_ID			0x00
> > +
> > +#define PM88X_REG_STATUS1		0x01
> > +#define PM88X_ONKEY_STS1		BIT(0)
> > +
> > +#define PM88X_REG_MISC_CONFIG1		0x14
> > +#define PM88X_SW_PDOWN			BIT(5)
> > +
> > +#define PM88X_REG_MISC_CONFIG2		0x15
> > +#define PM88X_INT_INV			BIT(0)
> > +#define PM88X_INT_CLEAR			BIT(1)
> > +#define PM88X_INT_RC			0x00
> > +#define PM88X_INT_WC			BIT(1)
> > +#define PM88X_INT_MASK_MODE		BIT(2)
> > +
> > +#define PM88X_REG_WDOG			0x1d
> > +
> > +#define PM88X_REG_LOWPOWER2		0x21
> > +#define PM88X_REG_LOWPOWER4		0x23
> > +
> > +#define PM88X_REG_GPIO_CTRL1		0x30
>
> These don't really need to be spaced out, do they?

I have spaced them out already as I expect to add some related
definitions to each of these in the future and thought it would then
perhaps be more easily readable like this.

[1] https://lore.kernel.org/all/20231228100208.2932-1-karelb@gimli.ms.mff.c=
uni.cz/

Kind regards,
K. B.

