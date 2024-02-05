Return-Path: <linux-kernel+bounces-53069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC684A051
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8323D1C21029
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1F41748;
	Mon,  5 Feb 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQo/MQzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF713FB14;
	Mon,  5 Feb 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153088; cv=none; b=P68A57aOwtWGQsvylwgMOt5jVumkRoWBYh8ZDZA7anX+Ay1Oo0I/yBiHJocV5lh4g55p82LL61nt6/ClrRyo7/Bd4VovAWiNc/r5igwouuzctv44EeXdXUEk6JEDQ36yOhgUUwN29krNIMtPyoWezkYt6u0u72z5usGQJQU4Ypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153088; c=relaxed/simple;
	bh=xkNsqaF4QqQI9IylasZgW4zPIt2p4Sbxb4KlMbNWs6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q86o/EhMqYRTkbXjLu4DVnVgGsbWBl88DAzWcUS0XgB7lEPYzybejZ70Rt30ZjlXGMGKObPUugQkuh/diaaM41PEMa99sV2YLaEurNh0IsM/4Y8KAF0w3afardw+9g5VYdIFUNGsyx8P/hCzZpOp0J2f9SJ56RXMxI0qslEiCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQo/MQzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10180C433C7;
	Mon,  5 Feb 2024 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707153087;
	bh=xkNsqaF4QqQI9IylasZgW4zPIt2p4Sbxb4KlMbNWs6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQo/MQzHt66cRQdouAnYcBrYhyVjlxZ4sDqniOwVsAQ7oTJhre+QB3tFbKOn+/uE4
	 TsL862+3/4mdbkCd4b/rpnVwL6OSEpQ52/ve1NY9liOP85JlfUbSQHP7QU/KLZv+4w
	 So6BzdbPYUVjdezJ/bRw/d2pBPokD08uHgbd1GiDmeGbwgalIs72b26elLdtvFQEgS
	 5vUHhNDrueZw0tUFde9lip1UnCL1SK5plfqQ9rk8QVMgyIFrDr70IsF5ne7uQUvdfk
	 ZMCNuHj9nZwbmh4vjdTIHO6k6UCEw2Ey5VhhI+PS9pFx1c375TwPOF8q0F+UfgMYzO
	 ru2KgiE+m0eXg==
Date: Mon, 5 Feb 2024 17:11:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240205-grudge-abrasion-d20b0c202d67@spud>
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
 <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
 <20240131163516.000043df@Huawei.com>
 <20240131-stylized-defile-d8fe346ab197@spud>
 <CABqG17iNxfKFNqydkgo6gL8ZmaZ_bqm=pG8kNEhzx_h2eaGuhQ@mail.gmail.com>
 <e8b30740-379c-9ab0-6bd7-d4726f822381@axentia.se>
 <20240202-shone-footwork-b247b1ae8e06@wendy>
 <CABqG17hRF3HaqfvXkT2go2S00JTRqCzremg1Nh=cSEUbcO_2pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y1VVmDQJUPxVz3DC"
Content-Disposition: inline
In-Reply-To: <CABqG17hRF3HaqfvXkT2go2S00JTRqCzremg1Nh=cSEUbcO_2pw@mail.gmail.com>


--Y1VVmDQJUPxVz3DC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 07:24:07PM +0530, Naresh Solanki wrote:
> Hi Conor, Peter,
>=20
> On Fri, 2 Feb 2024 at 18:39, Conor Dooley <conor.dooley@microchip.com> wr=
ote:
> >
> > On Fri, Feb 02, 2024 at 12:49:26PM +0100, Peter Rosin wrote:
> > > 2024-02-02 at 11:43, Naresh Solanki wrote:
> > > > On Wed, 31 Jan 2024 at 22:24, Conor Dooley <conor@kernel.org> wrote:
> > > >> On Wed, Jan 31, 2024 at 04:35:16PM +0000, Jonathan Cameron wrote:
> > > >>> On Wed, 31 Jan 2024 09:29:59 +0100
> > > >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > > >>>> On 30/01/2024 12:56, Naresh Solanki wrote:
> > > >>> Conor requested an example of the device acting as a consumer and=
 a provider.
> > > >>> Might have meant in the patch description?
> > > >>>
> > > >>> Conor?
> > > >>
> > > >> I wanted it in the property description to help with understanding=
 when
> > > >> to use it. I don't think the extra example nodes actually help you
> > > >> understand what it is doing, only how to write one yourself once y=
ou
> > > >> know you need it.
> > > >
> > > > I'm not sure if I get it right but what I understood is that a
> > > > voltage-divider can
> > > > also be a provider to other devices & hence the property.
> > > > Also do you want me to put a complete example of it in description ?
> > >
> > > My understanding is the requested example in the description should n=
ot
> > > be exactly /how/ to hook up the voltage-divider as a provider, but
> > > instead have some words about why it is interesting to do so at all. =
And
> > > those words would also make it clear that is even possible. The latter
> > > is something which, to be honest, is perhaps not all that obvious. It
> > > has always been totally obvious to me of course, sorry for not being
> > > clearer when I wrote the binding...
> >
> > Yeah, you're right about what I was looking for Peter.
> >
> > In my original request, which I think I already linked to in this
> > thread, I said that I would like an example like the one that Peter had
> > used to explain to me the scenario in which someone would want to use
> > this feature:
> > https://lore.kernel.org/all/536971eb-51f0-40e5-d025-7c4c1d683d49@axenti=
a.se/
> ok. Based on my understanding, I'll update the property description
> with an example.
>=20
> description:
> In addition to consuming the measurement services of a voltage output
> channel the voltage divider can act as a provider of measurement
> services to other devices.

> This is particularly useful in scenarios wherein,
> ADC has analog frontend such as voltage divider then consuming its raw
> value isn't interesting.

This sentence is structured pretty weirdly, it's missing articles and
prepositions, but you have the right idea here, thanks.


> It is desired to get real voltage before
> voltage divider.



--Y1VVmDQJUPxVz3DC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcEWugAKCRB4tDGHoIJi
0hR7AP908arHTIG2+4rd+yfEy8RybMPrJr/un2iYCVbYLcb5+wD+LT+7PZ8kMDb1
SyS7W+TUBWeNHP+dnmZ+w1YX2iMQmQ0=
=3jOw
-----END PGP SIGNATURE-----

--Y1VVmDQJUPxVz3DC--

