Return-Path: <linux-kernel+bounces-120033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7763188D08D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CFD328CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360C13DB92;
	Tue, 26 Mar 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htXjJYXD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D057173;
	Tue, 26 Mar 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491056; cv=none; b=PaGaCCXJjhDWKYrT2xvhKubD40/jHNbGqmV9A5MuP1t/sHmBcmClAZZNYpPH8cv0XglcWdNlV4T9YMAzpn3dURbYl4DD44de/u9wBWFVUnBqprAAkYgi8hlmdyr4YZrC/v4+BZZqIbUILIeaWmPrcQ+gi2wD1mcz5y20CDSbQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491056; c=relaxed/simple;
	bh=cG29oNcr0+V5KGbAdPJZvHwXg0KTPqsp1JrVZjQvHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9ecAj6I25Jb4MM3sYmMqTs6wnY+g96WtFHica9PrU0Vx+rZYtRZCPI98ojMnFAD7jy/atB4bKmXDN/6p0HY3fgVuc/xjmSWHRLTG9x+NnyJ6PWHaNODuyx6VSaBjS66+NfD2TOSBMXZH5phZ+RaXMbJAL4RUSVaG4ffGfVyEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htXjJYXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79376C433F1;
	Tue, 26 Mar 2024 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711491056;
	bh=cG29oNcr0+V5KGbAdPJZvHwXg0KTPqsp1JrVZjQvHzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htXjJYXD0wfM/cszoAtDSzVwT6tZNjV5F4xuXBykzildPbNdIRjBsZmHBPKVlZg1L
	 gb1LdQGog9GC3iZcjlW3gU29VMlgmPR3Za1rHFsopjUhWbH1S5XRtofyDE4ssjvo1g
	 m8/DX/oc6h2cGx/ZmmQHI0tn8BRAdJ/903hRWmY+fidSYIAMeDOmlxbWdOPxERjlC7
	 KeLEOaaHIRwodlkLfURxwuSiY0whNWAHVTi0oyUC4NQl8+hcVH2N6bczEFb+rr7Sel
	 zpupYmYYJTX44D7CZK+MUp07D1tDbEjJxx/NsLZLwqLXlYvqvBoRo3jA/XhMJHQvyF
	 kWYiSzx/Z9Bfw==
Date: Tue, 26 Mar 2024 22:10:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: kernel@esmil.dk, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shengyu Qu <wiagn233@outlook.com>,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
Message-ID: <20240326-ladylike-retold-9034734c2445@spud>
References: <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240326-create-motivate-2792be1692c5@spud>
 <f472affe-d1ef-cbdb-b5c5-76f6b3ac78b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/H/qRSs0lzpUPZPK"
Content-Disposition: inline
In-Reply-To: <f472affe-d1ef-cbdb-b5c5-76f6b3ac78b3@gmail.com>


--/H/qRSs0lzpUPZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 03:06:33PM -0700, Bo Gan wrote:
> On 3/26/24 1:37 PM, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > On Thu, 07 Mar 2024 20:21:12 +0800, Shengyu Qu wrote:
> > > Interrupt line number of the AXP15060 PMIC is not a necessary part of
> > > its device tree. And this would cause kernel to try to enable interru=
pt
> > > line 0, which is not expected. So delete this part from device tree.
> > >=20
> > >=20
> >=20
> > Applied to riscv-dt-fixes, thanks! And I didn't forget, so I re-wrote
> > the commit message to add some more information as promised.
> >=20
> > [1/1] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2=
 board
> >        https://git.kernel.org/conor/c/0b163f43920d
> >=20
> > Thanks,
> > Conor.
> >=20
> Hi Conor,
>=20
> Thank you very much for taking care of this. Actually the PLIC may silent=
ly
> ignore the enablement of interrupt 0, so the upstream openSBI won't notice
> anything. My modified version, however, will deliberately trigger a fault
> for all writes to the reserved fields of PLIC, thus catching this issue.
>=20
> Hope it can clarify things a bit more.

https://git.kernel.org/conor/c/0f74c64f0a9f

Better?


--/H/qRSs0lzpUPZPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgNH6wAKCRB4tDGHoIJi
0qqvAP9sYNmVhWhKIaWrwI0qOJdUWNbIMUN6dcH31ErYQl6WHwD/QoreijKXvG8q
TU3kR9EpQtoazy4ACLIGRSbE/o2ovgM=
=CI0C
-----END PGP SIGNATURE-----

--/H/qRSs0lzpUPZPK--

