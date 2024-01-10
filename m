Return-Path: <linux-kernel+bounces-22289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4781829BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFE5284F97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CD495E6;
	Wed, 10 Jan 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjet6GO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24048CD0;
	Wed, 10 Jan 2024 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DB3C433C7;
	Wed, 10 Jan 2024 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704895026;
	bh=KX4nMw3GLOvc32C67PKcjUg1rWDpL+ovEal4aND4JEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hjet6GO3YR2W/KNak5Dfzl4DlIFe81vwMyh5cdGSuKAmJo1bsESDB8fTLfmFUi2qL
	 UgYjMA/dOQ79uKwHJHIA0N7ZPqo2zNGyamShnHfn8rrTIFZm2kgHGG3OiBj1aBLVr1
	 IshXzjOubebWFuCpULUHCd5yZCFi047L05OSWtdYA/Ev0oYyHbwoDeaEaExYTNPGfs
	 v43xRDSRL1qe7SSNUaNL6iiOw9b5MPxWvdrUfsXo5cBkGQMMTTh7C8hY6zxm6loNlO
	 Ozuuv8aCoOBsjXQtL8M3Bf6zDth0/5iLlqi/J8NA8jzcaWZjiFlq3pHuMsMkp5Hhnb
	 jE99hI63dNV6A==
Date: Wed, 10 Jan 2024 13:57:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v6 0/4] Enable networking support for StarFive JH7100 SoC
Message-ID: <20240110-quaking-unlisted-dcae7229a9f8@spud>
References: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
 <CAJM55Z9tKQ_hpxrGUq1Rx1kxzzs-dyd=4yT1z=8B7KQ=CZ4mjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCGlZoctadBRtAPJ"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9tKQ_hpxrGUq1Rx1kxzzs-dyd=4yT1z=8B7KQ=CZ4mjA@mail.gmail.com>


--tCGlZoctadBRtAPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 02:38:26PM -0600, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
> > This patch series adds ethernet support for the StarFive JH7100 SoC and
> > makes it available for the StarFive VisionFive V1 and BeagleV Starlight
> > boards, although I could only validate on the former SBC.  Thank you Em=
il
> > and Geert for helping with tests on BeagleV!
> >
> > The work is heavily based on the reference implementation [1] and depen=
ds
> > on the SiFive Composable Cache controller and non-coherent DMA support
> > provided by Emil via [2] and [3].
> >
> > *Update 1*: As of next-20231214, dependencies [2] & [3] have been merge=
d.
> >
> > *Update 2*: Since v5, the dwmac patches will be handled via [4], while =
the
> >             clock patches subset via [5].
>=20
> I'm not sure my rb my sense when I'm listed as a co-developer, but this v=
ersion
> looks good to me:
>=20
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Cool, thanks. Cristian, can you ping this series once the binding gets
picked up by the netdev folks after the merge window closes?

Cheers,
Conor.

--tCGlZoctadBRtAPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6iLQAKCRB4tDGHoIJi
0kbPAP0dbSyLIRPKeMG1shbfbFYtzw73fBt52A+2sdrLbJM5aAD+PQu/udrSe+dz
2BrPH1XVoW3NkL079PPlz/HGQidT8AA=
=z7mA
-----END PGP SIGNATURE-----

--tCGlZoctadBRtAPJ--

