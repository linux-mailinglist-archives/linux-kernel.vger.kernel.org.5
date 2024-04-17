Return-Path: <linux-kernel+bounces-148752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26478A86FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CB11F225D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9D146A80;
	Wed, 17 Apr 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWbx16Co"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6713C3EF;
	Wed, 17 Apr 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366394; cv=none; b=dGzWG4Kdb9w0yks/zgk0EY/1ZUTmrxCAfW9U5SZIgWfdSsrNklavvglFLJrDpdd9DseUeOab6FWwfXsvdI4VuRXzPetd/4b1FZlLo+Oa7fw+9yb0mq8TtlHJxJM+0dD/uWg8jhENUcqqWDLGOulvWKQnSZiiZF7TIiufvvbF0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366394; c=relaxed/simple;
	bh=csO/QBIY5zA9U55g4bmdwzHQOXGd09d6ZZbozBhSl4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF0E8Yb7d6NxZUic0q0Qj6GWPFezWUS8XsYx/wEjVAxu3wmYEeSZ+2by1Uhc89NdETYy9lgKmLsUCwjgxSkDQ14iTPwceTQwc82RjkOMiY0MkOWSB8xcbsB65JPUpZ7ZEhW8Rf9DCnIzV7DOZJqXJbtVGCEikLLNp2WtBsW251w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWbx16Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67620C072AA;
	Wed, 17 Apr 2024 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366393;
	bh=csO/QBIY5zA9U55g4bmdwzHQOXGd09d6ZZbozBhSl4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWbx16CozNaA6xrWLXzFjR3qfMbBP2psA8necDIweTlfJOzHkeCWSIs0UfQstgqxm
	 D6B572ou01naWEDwbo/TJYW8VJxw53oDsAyBv9/DptJ42ri4yEhUBEwvStUXt7B+Tu
	 01QoTScXr7YvGckqHEYzfm5QjLeY3eVV/KA6Ozp1spGnZvUWWoscoNYb8L1BRbWVVJ
	 cHgsrGg7ei51FkYVIoToGWyBGkyTEyy/aeMEgffHXaaEnpYkjBlF6sUd+D+8IJVd4L
	 +sx92YX9tvwz4ucnxrqCRjUm86f0rEmA7+WYBNH/YS+yAW07xfeHxJqgpO6h6GUO6i
	 YTgnKq+fwcOcA==
Date: Wed, 17 Apr 2024 16:06:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S
 board support
Message-ID: <20240417-guts-overture-b04cd1b8565a@spud>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lXrJLg2sMSILQKj3"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>


--lXrJLg2sMSILQKj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:34:44PM +0800, Inochi Amaoto wrote:
> On Wed, Apr 17, 2024 at 08:53:11AM GMT, michael.opdenacker@bootlin.com wr=
ote:
> > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> >=20
> > This adds initial support for the Milk-V Duo S board
> > (https://milkv.io/duo-s), enabling the serial port,
> > making it possible to boot Linux to the command line.
> >=20
> > Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.94607491=
36730849811.robh@kernel.org/T/#t
> >=20
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/Makefile           |  1 +
> >  .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> >=20
> > diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/=
sophgo/Makefile
> > index 57ad82a61ea6..e008acb5240f 100644
> > --- a/arch/riscv/boot/dts/sophgo/Makefile
> > +++ b/arch/riscv/boot/dts/sophgo/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_SOPHGO) +=3D cv1800b-milkv-duo.dtb
> >  dtb-$(CONFIG_ARCH_SOPHGO) +=3D cv1812h-huashan-pi.dtb
> > +dtb-$(CONFIG_ARCH_SOPHGO) +=3D sg2000-milkv-duos.dtb
> >  dtb-$(CONFIG_ARCH_SOPHGO) +=3D sg2042-milkv-pioneer.dtb
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/ri=
scv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > new file mode 100644
> > index 000000000000..c1ecf97d5e93
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.c=
om>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "cv1812h.dtsi"
> > +
> > +/ {
> > +	model =3D "Milk-V Duo S";
> > +	compatible =3D "milkv,duos", "sophgo,cv1812h";
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@80000000 {
> > +		device_type =3D "memory";
> > +		reg =3D <0x80000000 0x20000000>;
> > +	};
>=20
> Add a cpu specific file, and move this to it.

I take it that the memory is integrated into the package then?

--lXrJLg2sMSILQKj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/ldQAKCRB4tDGHoIJi
0iovAQCARQaWa7RNYeDT5gcMiHGFrrlUp4jfG1PWfDEvDUPcHQEA0kweLkHMyqlV
Z8fNVOz8ExbRPorZsQGP0jhPfhdVRwg=
=xsp0
-----END PGP SIGNATURE-----

--lXrJLg2sMSILQKj3--

