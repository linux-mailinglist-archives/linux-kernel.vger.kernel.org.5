Return-Path: <linux-kernel+bounces-151613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128D8AB125
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018AB284955
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41E12F38F;
	Fri, 19 Apr 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPcsDq1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2B1E893;
	Fri, 19 Apr 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538615; cv=none; b=mgT9pEcx9FiLo+XzMHNqKkAjRwc4B7PDqNXTinkook63Pe4nHA3Wz5ZaoL6LCKKHJIDSu0KzGNPpQPmkx7FxYUJE+OusqSmHgHyXT+EBdmiuKdkWqMKs50Ys5VybBsOp3Ry8Wwz3gXo/7Gyz6FIPWoGtmKvfJkt8+kkbCNUpIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538615; c=relaxed/simple;
	bh=/WmQL2CDxZnqxFZNdiGaGtEwcf5Tmwl5pXVCQ0Uu2Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzjURNr0fQKE72ML3LLF4stBNJCc5UstXn8mqDtMvuNBamsSBgPMttbXFeclXc52IeuDyatfjmCtvp2nBUhXTGQ3AxVzC8CVgPT84Dc8W9h83qUg9ObvI4/u4UiWm7t7OxGQlJSQ753S/AUIgzcSFUTEN2lHjD4w/r/0G/I2NJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPcsDq1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BFFC072AA;
	Fri, 19 Apr 2024 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538615;
	bh=/WmQL2CDxZnqxFZNdiGaGtEwcf5Tmwl5pXVCQ0Uu2Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPcsDq1trS8BASw+d4kQ/K+dSPKMcZyGWQqeSx+Ri5vGov1iiXelZMt3O99w7UShc
	 +NNy1T0ryVmBNDIonizaa0RiOaCQt+tkowPgN10DZFHvacmRAbNtNUUPbPextfom3x
	 TZe9ASy/ljgyAIKtB2brpy7lAoC4o8OzxXx81ONWGkoPwd09CVL7DE9sdiE3UwGbNs
	 H3q6Hq3eyRzQe7bg8kOO1pnYCxgsHLepz6eyg2R/fwOPI/X0sHH4gxi9uQMPq7W5OV
	 +GQCg+HdWhQGAPcY7dQaAARkh654jDt28iI/j9I814vXc257guO6CLrW7jLT+SS29p
	 OkTId4sj34nlQ==
Date: Fri, 19 Apr 2024 15:56:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Konstantin P." <ria.freelander@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konstantin Pugin <rilian.la.te@ya.ru>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <20240419-defection-bagful-12d55d763b0f@spud>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
 <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <20240419-glue-pyramid-584728c0076a@spud>
 <CAF1WSuy4OJVTU5VJdn23BSw4aTAq7i8UQ416V7BxveuQ+5=-1w@mail.gmail.com>
 <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
 <CAF1WSuzVLrsYt6+CyMHJuRbuXNEy2XnWhbHkcPHT3xXpB3Yh-Q@mail.gmail.com>
 <ZiKFNllT9tMHlH7M@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3QBmqN9SXTsyWoKd"
Content-Disposition: inline
In-Reply-To: <ZiKFNllT9tMHlH7M@smile.fi.intel.com>


--3QBmqN9SXTsyWoKd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 05:52:38PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 19, 2024 at 05:34:44PM +0300, Konstantin P. wrote:
> > On Fri, Apr 19, 2024 at 5:24=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > > On 19/04/2024 16:17, Konstantin P. wrote:
>=20
> ...
>=20
> > > Commits must stand on their own. Cover letter is not merged. This is =
the
> > > place where you add new hardware, so here you describe and explain the
> > > hardware.
> >=20
> > It is also described in patch 3 in the series. I need to repeat this
> > description in patch 2 too?
> >=20
> > Cite from patch 3:
> >=20
> > XR20M1172 register set is mostly compatible with SC16IS762, but it has
> > a support for additional division rates of UART with special DLD regist=
er.
>=20
> The point is, if I got it correctly, to have a few words in the descripti=
on
> of the DT binding itself, so whoever reads the bindings (w/o even accessi=
ng
> the Git history of the project) may understand this.

Yes, each patch must independently justify the change - although in this
case it is about the history not people reading the bindings as I was
talking about the commit message and not the contents of the diff.
It's especially true when I only get sent the bindings patch, although
=66rom other messages in this thread that may not have been intentional.

Thanks,
Conor.

--3QBmqN9SXTsyWoKd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKGKwAKCRB4tDGHoIJi
0q0PAP44mYOzU2Bud3h4ppjoMoHflukxo0/CWv1h/ScDLfOD0gD+I57CXhw3f2IP
bJ5AsqUviTEcb5TEYLOuvx7JV0WL7gU=
=jgJr
-----END PGP SIGNATURE-----

--3QBmqN9SXTsyWoKd--

