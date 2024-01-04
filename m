Return-Path: <linux-kernel+bounces-17073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC38247F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E9D1C22540
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1128DD1;
	Thu,  4 Jan 2024 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA6ZNlbl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265D28DB0;
	Thu,  4 Jan 2024 18:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E50C433C7;
	Thu,  4 Jan 2024 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704391629;
	bh=2g4riwRlJYPaXC4pPnyGhw8jIgLWVYYCfFGE3oWgRxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA6ZNlbl+HEha9Rm2MGfY7kGSNXWKOSH99nnBthw4IQK1fwi3DoVl5RdvrD1d1wOg
	 tGFB1K/B7bujJ9Jst1DJC0F/m4TGAMyMr+R42PTZyCM8iV1flFO6V+MlTfRFOVwr/D
	 6Y/sz+3Y4aKz1M5gsBzqssqQ+crQGKQtXpOdDqpiKavtDjGO96uhJ8lr5CVqFl6PrA
	 Vmn5magbGW7KrOYmKEDOfMHuDwE+CW8jk1cZROSzaVFtqeungQDCeyMrb+U3tIJVMG
	 FrcsO8dHJ+pQ2iMUw5jLp6ubHeM5tz+qYM+wHak65qGK34QjYxqxQSFE4pkkwM6VwR
	 rnGbfRGSMKuNw==
Date: Thu, 4 Jan 2024 18:07:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Yuklin Soo <yuklin.soo@starfivetech.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Message-ID: <20240104-thread-jot-53ee01efc63b@spud>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <CACRpkdYL8wK2vX7P7p4QvU9VV2CPjRv_aXiLqO+07MMCCKKk4Q@mail.gmail.com>
 <6c861db8-f6cd-4e12-856a-ef45efc654a2@linaro.org>
 <ZQ0PR01MB130273F2A3286849FB5BB0C9F667A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5tQP8I1x4qTGmqU1"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB130273F2A3286849FB5BB0C9F667A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>


--5tQP8I1x4qTGmqU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 03:12:31AM +0000, Yuklin Soo wrote:
>=20
>=20
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Thursday, December 21, 2023 11:45 PM
> > To: Linus Walleij <linus.walleij@linaro.org>; Yuklin Soo
> > <yuklin.soo@starfivetech.com>
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Hal Feng
> > <hal.feng@starfivetech.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> > Jianlong Huang <jianlong.huang@starfivetech.com>; Emil Renner Berthing
> > <kernel@esmil.dk>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Drew Fustini <drew@beagleboard.org>; linux-gpio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > riscv@lists.infradead.org; Paul Walmsley <paul.walmsley@sifive.com>; Pa=
lmer
> > Dabbelt <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>
> > Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100=
 pinctrl
> > bindings
> >=20
> > On 21/12/2023 14:57, Linus Walleij wrote:
> > >> +          drive-strength:
> > >> +            enum: [ 2, 4, 8, 12 ]
> > >
> > > Milliamperes? Then spell that out in a description:
> >=20
> > Or just use drive-strength-microamp
>=20
> Suggest changing =E2=80=9Cdrive-strength:=E2=80=9D to =E2=80=9Cdrive-stre=
ngth: Drive strength in mA=E2=80=9D since the unit is in mA.

Just call the property "drive-strength-microamp". We have existing users
of that property.

Cheers,
Conor.

--5tQP8I1x4qTGmqU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZbzxwAKCRB4tDGHoIJi
0q7mAQCKFq6hqG7JgQvVCfALjMOSzO+iKRfObMSQ6yyM/rg58AEAtyRFbdlGJiZB
GDLJ3QYvJCZAipAuCc44uWnALtuSBAI=
=6FU+
-----END PGP SIGNATURE-----

--5tQP8I1x4qTGmqU1--

