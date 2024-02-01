Return-Path: <linux-kernel+bounces-48713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BD846016
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE71C28771D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659884FA6;
	Thu,  1 Feb 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqKSHXuv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962682C88;
	Thu,  1 Feb 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812677; cv=none; b=uPKlg5l0DMsmzEj6NuNv+DICq/PIMhwVmvZfQ0r49OSyanm5dv9tKn2zkCaVPykGjTuZhRuxswaA3FqA765zImwpcUo6YUa55xlvZdRPz7E/PM3wlt+9A/cp4Ec0WiESNBa/NC5GHBxcFD0pnAotb6MOHFhHBg98/utpFlF4Ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812677; c=relaxed/simple;
	bh=0JVpzxvxHW0CTZLMhUSI5/1YEsJwW5sGalQevgBRPig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei8QeG3OC17HdO9BTvpwnbP2z4cZbEPRq6NfvpsJg5/8IGIibiigPa3Z7pD7svIg5SYTpuZTGNkOJkf4o8Bpr40xIl16TS6yJhLct/ChrZtFAdnnYdWz4VwDceDFdQdlrlGB320msiIr9yoEd6Ey60SJTfES8RdSaIzpfMwDWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqKSHXuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE0DC433F1;
	Thu,  1 Feb 2024 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812677;
	bh=0JVpzxvxHW0CTZLMhUSI5/1YEsJwW5sGalQevgBRPig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqKSHXuvgjL0C8Scyh/DKYXAe4w5/voFVCi4sLwxrmUFM5F3on17NUnZV9s8sw6Gi
	 feC+RN7VeJpPn/2WZ23ZHgGsF5+zX1MivRCZ05qAk1JesfpQc3QYkPbqjAv51qG1qG
	 ISNyF6TRUbzIkdJrGqtWyBm4Bthu8S+wcVrMn5covTI1GmZZigKzLimm+lYO33bypA
	 6AL9redV6TPUGkUHLiUrm/pWbjYnnwKhKfcH2WyMNtX8W22AnPlu924unKphfawY62
	 LIvQ0tOJQBmWeTdkW7Cxn95xr6+9YgEe+bWeJWl2KRjOOYn6Br4CmHRPBxOxWbnlc6
	 CKL6LUYcHZkZQ==
Date: Thu, 1 Feb 2024 18:37:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbdjI=?= =?utf-8?Q?=5D?= riscv: dts:
 starfive: jh7110: Add camera subsystem nodes
Message-ID: <20240201-handiwork-excretion-36aa2eea0709@spud>
References: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
 <20240131-recycling-entering-b742e0e835eb@spud>
 <SH0PR01MB06675EF7ACD1452C4DEBE45FF243A@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aKOGQMxv8o8LMxKI"
Content-Disposition: inline
In-Reply-To: <SH0PR01MB06675EF7ACD1452C4DEBE45FF243A@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>


--aKOGQMxv8o8LMxKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 01:42:13AM +0000, Changhuang Liang wrote:
> Hi, Conor
>=20
> > On Tue, Jan 30, 2024 at 12:25:09AM -0800, Changhuang Liang wrote:
> > > Add camera subsystem nodes for the StarFive JH7110 SoC. They contain
> > > the imx219, dphy-rx, csi2rx, camss nodes.
> > >
> > > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > > ---
> > >  .../jh7110-starfive-visionfive-2.dtsi         | 103
> > ++++++++++++++++++
> > >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 ++++++++++++
> > >  2 files changed, 170 insertions(+)
> > >
> > > diff --git
> > > a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > > b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > > index b89e9791efa7..e0027bb379ef 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > > @@ -30,6 +30,37 @@ cpus {
> > >  		timebase-frequency =3D <4000000>;
> > >  	};
> > >
> > > +	imx219_clk: imx219-clock {
> > > +		compatible =3D "fixed-clock";
> > > +		clock-output-names =3D "imx219_clk";
> > > +		clock-frequency =3D <24000000>;
> > > +		#clock-cells =3D <0>;
> > > +	};
> >=20
> > Why do you need an output name here?
>=20
> The output name can be unnecessary.=20
>=20
> > Also, where does this clock come from? Is it an oscillator on the board?
> >=20
>=20
> This clock come from imx219, not the VisionFive 2 board.

If the camera is not on the visionfive 2 board, why are you adding this
to visionfive-2.dtsi?

--aKOGQMxv8o8LMxKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvlAAAKCRB4tDGHoIJi
0t7uAP99Kv0Ha56vaQ3FmdELSrLyGZPzRKwDjvkXfD/FjO5zzwD/Y5FDv6A1egV9
RKSaWFPmNuF8uiKHjPFGwcVibWqw8gs=
=+5Bw
-----END PGP SIGNATURE-----

--aKOGQMxv8o8LMxKI--

