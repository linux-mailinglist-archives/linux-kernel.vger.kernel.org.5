Return-Path: <linux-kernel+bounces-32512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E321835C87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B7BB26696
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C020DFE;
	Mon, 22 Jan 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1URRlGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50120DE1;
	Mon, 22 Jan 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911897; cv=none; b=PR4Z5Cxx15WZOXvYHGLWVHsCb96Jo/LjlkJywC7slLJYUpqCML97F/VAkbqCNC6r/hSKrJfr2nBa5FjsxPUxnZ6xjULgikkfxIhzF0C7C9+dvBGRqv+PAoUMoI1fAIzQjAarCwMoyrnLrTdD6vgArcO5NYt+5uoBku4Zg+Y8vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911897; c=relaxed/simple;
	bh=drF9HS0qNEy+0/grGYgRcmiwZBDcpQyCv996fd/G5Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXKt000/T8Aa0YK9G8y4fBcRSBYqzRdbizfGdwT8s+5WzCSeZ0E/sKuDmQZ3JJP6OQ2gFg2BLVcBen7QSVWwTn8R9nEEwWNFLEd4YTIhF3U136KeLe1xL2uiO2JkqsRp0Mx4HsMqREkgS9jeJV5e+BZ7uSBwG0Sh6WBe9JXe43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1URRlGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E8C433C7;
	Mon, 22 Jan 2024 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705911896;
	bh=drF9HS0qNEy+0/grGYgRcmiwZBDcpQyCv996fd/G5Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1URRlGjJA38bXP5Tqq7X0QiPyWe3UraXQYziiFt47585KnHSGCL0jFjJwEmzttNe
	 i2sGsduyPw2Sg1I6HXBlaiQ3g9W51qyA8zeUoJFdgwPA8Cm7eSnjqMH/eVdgQlyoXw
	 0McCO5WsZwHz4i1coBWQBIgcnyJR2yFipOTrLmYtOth4Y9xXxJoaDrMC8fzMKnmxaX
	 UkGde0+cJfWZ21larnsTS7hcRJ+jZUe36eTbgWWA0sJTX0msi+zXPEUToMVXZjTpRx
	 RbW16AveJ/rfSy4EPmMpApjuHanWfaPCZU4CE/3jzTjygb0GjWBB4q5iPKBcCf+H2+
	 S9s+9RrCs2Rhw==
Date: Mon, 22 Jan 2024 08:24:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_v1_1=2F2=5D_dt-bindings?= =?utf-8?Q?=3A?= media: starfive: Match
 driver and yaml property names
Message-ID: <20240122-uncivil-almost-631137081fd9@spud>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <20240119-preamble-calm-7724e17fcebc@wendy>
 <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="691fbi7YiHqy5KOf"
Content-Disposition: inline
In-Reply-To: <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn>


--691fbi7YiHqy5KOf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 01:33:56AM +0000, Changhuang Liang wrote:
>=20
> > On Fri, Jan 19, 2024 at 12:57:22PM +0000, Changhuang Liang wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >
> > > Hi , Conor
> > >
> > > > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 1/2] dt-bindings: media: starfive=
: Match driver
> > > > and yaml property names
> > > >
> > > > On Fri, Jan 19, 2024 at 02:06:38AM -0800, Changhuang Liang wrote:
> > > > > Drop some unused properties for clocks, resets and interrupts for
> > > > > StarFive JH7110 camera subsystem.
> > > >
> > > > What do you mean "unused"?
> > > >
> > > > Do these clocks etc exist but are not used by the driver?
> > > >
> > > > Or do they not exist at all?
> > > >
> > > > The two are very different!
> >=20
> > > These clocks etc exist but are not used by the driver.
> >=20
> > That's not an acceptable reason for removing them from the binding. If =
they
> > exist, they should be documented, regardless of whether the driver make=
s use
> > of them. NAK.
>=20
> If so, how to avoid the warning of dtbs_check.

By also adding the clocks, resets and interrupts to the dts.

--691fbi7YiHqy5KOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa4mUwAKCRB4tDGHoIJi
0h/FAP9OymvQKrw2lHv7pji+pa6/xaJNsKHlv4dCxUXnS+SjUgD+ItSiNki3Vypi
yxKXpfp0nWKwBR7x5uxNdhSO9OoXtQs=
=tSBw
-----END PGP SIGNATURE-----

--691fbi7YiHqy5KOf--

