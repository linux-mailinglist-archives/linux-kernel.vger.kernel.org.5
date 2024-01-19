Return-Path: <linux-kernel+bounces-31390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B5832DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCDD280FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16A55C19;
	Fri, 19 Jan 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSXISuze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856674C624;
	Fri, 19 Jan 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683882; cv=none; b=Z+NSAc3g+P+l+LSBGu9huLZjomy8ZnrjPC+CjEHpJB/tld0cyWVxMP6mpGEz72hWb8u0NErsewLmIFnRPY528syL8uN7Kn2fss7jP3LRh4rDjI/RDkeCbjfjCMG6/kxBJWHIEeQNszFnrQZ61cGqeo/zzaAwOYOBoCJvQOqJaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683882; c=relaxed/simple;
	bh=tvfI8kzKELJg8x51eYsi4QeGQs90pS6wbtnENBmug60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUknaLLRdW3AxTA6m9QXy6uaXExEnI1jFb0waMMSJrjXaO9Tnnsf4at7dwahNEHqBJNXbRjjVozPcnqbbUZEaX0jl4eCUuiSSEgcK0XGOuToltvFsRnsRx6oKcHwjploMSY7KPMV+cYbnFYuR3rsdiM2ldg76lamcXfzI1ChrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSXISuze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F17C433C7;
	Fri, 19 Jan 2024 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705683882;
	bh=tvfI8kzKELJg8x51eYsi4QeGQs90pS6wbtnENBmug60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSXISuze5qHDFLd+8VIc670Qh4sfOq0Q9HsJU09eHWdo6qBL7KyIFvRN2hMPNHC9e
	 nzytI2kZ3IeSWiAJ5mOsLjDjIrb+/C9B6vdVWUBGoiLP/M4Irl7kQpf5QmGvM/N3uJ
	 n5HJ/AXMY+SxfLpeBQHGjk8ljy23nTkpZDvTxjYWggOytjqPJJnw+UREkmID1xhhAb
	 UdsCtNvnu7laUhbyDOU8nJKxaN4vm3Rx5FET/e8eIj0RcUgt2p1djP+DUI2Pva1Bpb
	 KYJ9Pp0e8//x5vSyoCLH0qCmBEGJl7HcQPzvqzUKwPIx5DQNMxZvhNaYLqeqqUsKCi
	 aKCikeAxBareA==
Date: Fri, 19 Jan 2024 17:04:36 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Frank Wunderlich <linux@fw-web.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: Aw: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988
 reset IDs
Message-ID: <20240119-dupe-obligate-707b3a01b356@spud>
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
 <20240118-calcium-krypton-3c787b8d1912@spud>
 <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
 <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hqUNFAuri8IfMYKy"
Content-Disposition: inline
In-Reply-To: <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com>


--hqUNFAuri8IfMYKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:28:30AM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/01/24 23:00, Frank Wunderlich ha scritto:
> > > Gesendet: Donnerstag, 18. Januar 2024 um 17:49 Uhr
> > > Von: "Conor Dooley" <conor@kernel.org>
> > > On Wed, Jan 17, 2024 at 07:41:10PM +0100, Frank Wunderlich wrote:
> > > > From: Frank Wunderlich <frank-w@public-files.de>
> > > >=20
> > > > Add reset constants for using as index in driver and dts.
> > > >=20
> > > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > > ---
> > > > v3:
> > > > - add pcie reset id as suggested by angelo
> > > >=20
> > > > v2:
> > > >   - add missing commit message and SoB
> > > >   - change value of infrareset to 0
> > > > ---
> > > >   include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/i=
nclude/dt-bindings/reset/mediatek,mt7988-resets.h
> > > > index 493301971367..0eb152889a89 100644
> > > > --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> > > > +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> > > > @@ -10,4 +10,10 @@
> > > >   /* ETHWARP resets */
> > > >   #define MT7988_ETHWARP_RST_SWITCH		0
> > > >=20
> > > > +/* INFRA resets */
> > > > +#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
> > > > +#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1
> > >=20
> > > These are just "random" numbers, why not continue the numbering from =
the
> > > ETHWARP?
> >=20
> > i can do...basicly these consts are used in DTS and driver only as inde=
x.
> >=20
> > @angelo what do you think? I though also in leaving some space to allow=
 grouping RST0 and RST1
> > when more consts are added, else the numbers are mixed up.
> >=20
> > so e.g. let RST0 start at 20 and RST1 at 40 (or even higher, because RS=
T0 and RST1 can have up to 32 resets).
> > That will allow adding more reset constants between my values and havin=
g raising numbers.
>=20
> The resets are organized on a per-reset-controller basis, so, the ETHWARP
> reset controller's first reset is RST_SWITCH, the second one is RST_somet=
hing_else,
> etc. while the first reset of the INFRA reset controller is PEXTP_MAC_SWR=
ST.
>=20
> That's why ETHWARP has a reset index 0 and INFRA also starts at 0.
> I think that the numbering is good as it is, and having one driver start =
at index 5
> while the other starts at index 12 would only overcomplicate registering =
the resets
> in each driver, or waste bytes by making unnecessarily large arrays, for =
(imo) no
> good reason.
>=20
> This is one header, but it should "in theory" be more than one... so we w=
ould have
> one for each hardware block - but that'd make the reset directory over-cr=
owded, as
> other MediaTek SoCs have got even more resets in even more hardware block=
s than the
> MT7988. That'd be something like ~4 reset headers per SoC (and will incre=
ase with
> newer ones)...
> ...and this is why we have one binding header for resets.

That's okay. The commit message leaves me, who clearly isn't a mediatek
guy, with no information as to why these are not one contiguous set.
IMO being for different reset controllers entirely is fine.

> On the topic of leaving space to allow grouping RST0/RST1: -> No. <-
> The indices have to start from zero and have to be sequential, with no ho=
les.

Agreed.

--hqUNFAuri8IfMYKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqrpAAKCRB4tDGHoIJi
0kpNAP0fXJ5CKQv/dcdDfDwM6QxpaHDnXco2vvD9zatS35PP3QEAyXeJjQ1mosMC
HzNIVUEk3x7CKsrxFYlJvszPHJz8fAs=
=leay
-----END PGP SIGNATURE-----

--hqUNFAuri8IfMYKy--

