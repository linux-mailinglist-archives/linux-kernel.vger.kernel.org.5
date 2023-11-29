Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57867FDAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjK2PCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjK2PCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:02:06 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681CD63;
        Wed, 29 Nov 2023 07:02:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 323E0E0005;
        Wed, 29 Nov 2023 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701270130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqEXn4TkNGmRqOG8wUHq0Wi1OtW5C8oFhPUq5ry9A8E=;
        b=E+jLAui0VL91nd52Dvf3cRY0kx7RLWv49clkgeDoW80bFX6OLdPW8bq/jKE9X7eTmJe6PF
        z2J9HMO1R/IJFwr8oZEz3HHa1noeLNzk+3heXTuIxWfeuIZ3aEibhCqcAsM4t7Qe9HXzc8
        YA5cP88WBKEzqKczbe9JHSHfS5zKORGDRT52GJnl647+KN8LCeMIH5VaCfszweBSIzkK0q
        RGqMm+FZvpRRfil41AaRZUWU+Vk7S8R8PV6sflgaODMafXaaBcsOJfW7PMyr3N1mMWuiTS
        v8FDtsZQDMfMwcl2/3bfVyebkRcp1xTLhMXl7deko05NeNn8bVelDqOAABlS8A==
Date:   Wed, 29 Nov 2023 16:02:08 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH v9 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZWdScBVicBfjPuVA@aptenodytes>
References: <cover.1700235276.git.mehdi.djait@bootlin.com>
 <dc65a89e7803782a75bf663158e031356ef7cb1a.1700235276.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mt5NDXBwaHl6onk+"
Content-Disposition: inline
In-Reply-To: <dc65a89e7803782a75bf663158e031356ef7cb1a.1700235276.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mt5NDXBwaHl6onk+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

On Fri 17 Nov 23, 16:42, Mehdi Djait wrote:
> The Techwell video decoder supports PAL, NTSC standards and
> has a parallel BT.656 output interface.
>=20
> This commit adds support for this device, with basic support
> for NTSC and PAL, along with brightness and contrast controls.
>=20
> The TW9900 is capable of automatic standard detection. This
> driver is implemented with support for PAL and NTSC
> autodetection.

Very nice work on this iteration, I am quite happy with it!

There is just one cosmetic comment below. With that fixed, you can add my:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  MAINTAINERS                |   6 +
>  drivers/media/i2c/Kconfig  |  15 +
>  drivers/media/i2c/Makefile |   1 +
>  drivers/media/i2c/tw9900.c | 777 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 799 insertions(+)
>  create mode 100644 drivers/media/i2c/tw9900.c

[...]

> diff --git a/drivers/media/i2c/tw9900.c b/drivers/media/i2c/tw9900.c
> new file mode 100644
> index 000000000000..895ca459087b
> --- /dev/null
> +++ b/drivers/media/i2c/tw9900.c
> @@ -0,0 +1,777 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Techwell TW9900 multi-standard video decoder.
> + *
> + * Copyright (C) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-subdev.h>
> +
> +#define TW9900_REG_CHIP_ID			0x00
> +#define TW9900_REG_CHIP_STATUS			0x01
> +#define TW9900_REG_CHIP_STATUS_VDLOSS		BIT(7)
> +#define TW9900_REG_CHIP_STATUS_HLOCK		BIT(6)
> +#define TW9900_REG_OUT_FMT_CTL			0x03
> +#define TW9900_REG_OUT_FMT_CTL_STANDBY		0xA7
> +#define TW9900_REG_OUT_FMT_CTL_STREAMING	0xA0
> +#define TW9900_REG_CKHY_HSDLY			0x04
> +#define TW9900_REG_OUT_CTRL_I			0x05
> +#define TW9900_REG_ANALOG_CTL			0x06
> +#define TW9900_REG_CROP_HI			0x07
> +#define TW9900_REG_VDELAY_LO			0x08
> +#define TW9900_REG_VACTIVE_LO			0x09
> +#define TW9900_REG_HACTIVE_LO			0x0B
> +#define TW9900_REG_CNTRL1			0x0C
> +#define TW9900_REG_BRIGHT_CTL			0x10
> +#define TW9900_REG_CONTRAST_CTL			0x11
> +#define TW9900_REG_VBI_CNTL			0x19
> +#define TW9900_REG_ANAL_CTL_II			0x1A
> +#define TW9900_REG_OUT_CTRL_II			0x1B
> +#define TW9900_REG_STD				0x1C
> +#define TW9900_REG_STD_AUTO_PROGRESS		BIT(7)
> +#define TW9900_STDNOW_MASK			GENMASK(6, 4)
> +#define TW9900_REG_STDR				0x1D
> +#define TW9900_REG_MISSCNT			0x26
> +#define TW9900_REG_MISC_CTL_II			0x2F
> +#define TW9900_REG_VVBI				0x55

Please reintroduce the newline here...

> +#define TW9900_CHIP_ID				0x00
> +#define TW9900_STD_NTSC_M			0
> +#define TW9900_STD_PAL_BDGHI			1
> +#define TW9900_STD_AUTO				7

=2E.. and here to separate between register definitions and more general va=
lues.

> +#define TW9900_VIDEO_POLL_TRIES			20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Mt5NDXBwaHl6onk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVnUnAACgkQ3cLmz3+f
v9FDmAf+JO+XU2DEEL1k7QGncbc3yYPy1S/nrSHdwgazhkCcEUsOhO33tsv6Cha0
XB2pQEq3vYMH0KweFc2cD1ljvioqld//oxl1bgCNu2BkpcJxU5KwEfOO0Xxi4c+k
gnkhovi2t/8z4yQ2jPQQfaaJre9IsQN7EBlRz7Gf+toXfiyzJNgcIuVk5LtoH26B
CZNDNVHuRSLovT7SHBfNRKucRyZdNB64yyHurJwSbrAb6dVKAuJul422LRYT1TUD
PCYULKA+gfytvbH+VUQwsBC82ThQZND4YhouBj1TjSKsTBmjE5jzvUFZPg8bhtoa
7UdiOQIPyb7Rn4p8hPv2gWqal8idbg==
=q+aS
-----END PGP SIGNATURE-----

--Mt5NDXBwaHl6onk+--
