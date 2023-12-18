Return-Path: <linux-kernel+bounces-3496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB96816D10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E611C23134
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79631C290;
	Mon, 18 Dec 2023 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jNzKRNbn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5031A77;
	Mon, 18 Dec 2023 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702899811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LNg5IATYeTVfmVN7U+vHHKtunfYiqKkNJSMnTCvWnvs=;
	b=jNzKRNbn+bk2+FLVUVK40QmeVTpHZZctmN3P6eddA1ljbeOvrTQZjMevXhU3eyE+JRSULY
	MXA/0ANVEXaA9ipwzLvz9bR5HXNpBcPgVshIzvBRWYX8Agfdko91rTKybU8dPC6Qaa7YFr
	1HCeMNUXlrsBd5IntbeD3N6AB/bswwI=
Message-ID: <5b127bcdd11ebb6857c9ecd70b946a5add7a93e9.camel@crapouillou.net>
Subject: Re: [PATCH v5 03/13] pinctrl: ingenic: Use C99 initializers in
 PINCTRL_PIN_GROUP()
From: Paul Cercueil <paul@crapouillou.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Biju Das <biju.das.jz@bp.renesas.com>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, Jianlong Huang
 <jianlong.huang@starfivetech.com>, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Dong Aisheng
 <aisheng.dong@nxp.com>,  Fabio Estevam <festevam@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,  Pengutronix Kernel
 Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, NXP
 Linux Team <linux-imx@nxp.com>, Sean Wang <sean.wang@kernel.org>, Lakshmi
 Sowjanya D <lakshmi.sowjanya.d@intel.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>
Date: Mon, 18 Dec 2023 12:43:28 +0100
In-Reply-To: <ZYAhyWxh5sEyK1RC@smile.fi.intel.com>
References: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
	 <20231211190321.307330-4-andriy.shevchenko@linux.intel.com>
	 <fb29c3bca8d245e3f7496539b7293aa4fc4bccd0.camel@crapouillou.net>
	 <ZXmv81bJRMqB1GLY@smile.fi.intel.com>
	 <9cbaf60cd6cf1a581e7587088f71ca7cf6b6ff37.camel@crapouillou.net>
	 <ZYAhyWxh5sEyK1RC@smile.fi.intel.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy,

Le lundi 18 d=C3=A9cembre 2023 =C3=A0 12:41 +0200, Andy Shevchenko a =C3=A9=
crit=C2=A0:
> On Sun, Dec 17, 2023 at 03:43:24PM +0100, Paul Cercueil wrote:
> > Le mercredi 13 d=C3=A9cembre 2023 =C3=A0 15:21 +0200, Andy Shevchenko a
> > =C3=A9crit=C2=A0:
> > > On Wed, Dec 13, 2023 at 10:55:46AM +0100, Paul Cercueil wrote:
> > > > Le lundi 11 d=C3=A9cembre 2023 =C3=A0 20:57 +0200, Andy Shevchenko =
a
> > > > =C3=A9crit=C2=A0:
>=20
> ...
>=20
> > > > > -#define INGENIC_PIN_GROUP(name, id, func)		\
> > > > > -	INGENIC_PIN_GROUP_FUNCS(name, id, (void *)(func))
> > > > > +#define INGENIC_PIN_GROUP(_name_, id,
> > > > > func)						\
> > > > > +	{					=09
> > > > > =09
> > > > > 			\
> > > > > +		.name =3D
> > > > > _name_,						=09
> > > > > 	\
> > > > > +		.pins =3D
> > > > > id##_pins,					=09
> > > > > 	\
> > > > > +		.num_pins =3D
> > > > > ARRAY_SIZE(id##_pins),					\
> > > > > +		.data =3D (void
> > > > > *)func,							\
> > > > > +	}
> > > >=20
> > > > This INGENIC_PIN_GROUP() macro doesn't need to be modified,
> > > > does
> > > > it?
> > >=20
> > > We can go either way. I prefer to go this way as it reduces level
> > > of
> > > indirections in the macros. It makes code easier to read and
> > > understand.
> > > But if you insist, I can drop that change in next version.
> >=20
> > I like the patches to be minimal. But I understand your point of
> > view
> > as well.
> >=20
> > If you have to issue a v6, maybe state the reason why you also
> > modify
> > INGENIC_PIN_GROUP() then. But I don't care enough to request a v6
> > just
> > for that.
> >=20
> > So:
> > Acked-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Thank you!
>=20
> But as I already noted, the series had been applied (by Linus W.)
> and this does not seem to be a critical to fix, do you agree?
>=20

Well I only suggested to change the commit message - so no, it is not
critical to fix.

Cheers,
-Paul

