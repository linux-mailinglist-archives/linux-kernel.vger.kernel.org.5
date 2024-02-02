Return-Path: <linux-kernel+bounces-50171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5659847548
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535C61F271BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9614900C;
	Fri,  2 Feb 2024 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNCqFUzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB671487DB;
	Fri,  2 Feb 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892444; cv=none; b=EIo8PNCK+fyTWscE6BXtqlDUNC0q+NldArI/01XOmeh+jgQQMZFT22VI5OMvZvemBZsbgCsPCdNlYXH4laP8iD/ysso6CH54zE6Y0DUmiRpSmmF9e4FANiFc5WWvk2/lgtKEI7V0GSkB6dGw/LZhhUiFTd9qLokfVGiUtCwDwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892444; c=relaxed/simple;
	bh=qVGQPqaAKKe4rQPmvSxnfJxycvP91+EBvnjm6km00sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDiWhonAYmRYEpYa3/Eu7fCigT+6r2on+Lt3WkSCiATFGW4eBhNLNG+oY8ckSqNMbVjVaWHXkafkxTbCD9Pgor6Ka9L2lzVZsSQFRy3p2NuvuIqG+Px42HF5ITCt3p0LJ1d0jBV/xQbPMSokwCVJtFLX4xLw8EGP8IwzjTVoFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNCqFUzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221D2C433C7;
	Fri,  2 Feb 2024 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892442;
	bh=qVGQPqaAKKe4rQPmvSxnfJxycvP91+EBvnjm6km00sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNCqFUzTNiblKPnDQEd8pje0NXH4Zy3nqDPZrHBJIwDuSZulOTSYJkzEPpxXJpnY8
	 Fgqdae3dL6Vcw/z+hwVavA4mh7DTV7iDwNFjErVaF1pN5BFxrVOC5bvF9VCrcHulQO
	 mGICncO3/J/ZBtMCbf7tX9MuYMP3folEPxo3ga2eyR2wmKnUWd3xmxZ3Kq5H5ydOaO
	 1X35NC29UpyzTygfL5wyXagjVz73WuiNWiYduyyCwvHEW6tb2CLuOAb5Chrc8ccBCA
	 Sw+BrWqr4Jwm1F1zRshfaSk5DhZwfl9Yt1Iqx+ylGW6cxMPwFlqONy6GjGFXPaFaRO
	 tl1d0paIiPePw==
Date: Fri, 2 Feb 2024 16:47:17 +0000
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
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFt2Mg==?= =?utf-8?Q?=5D?= riscv:
 dts: starfive: jh7110: Add camera subsystem nodes
Message-ID: <20240202-spoiler-deceit-0e9ac720fd2c@spud>
References: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
 <20240131-recycling-entering-b742e0e835eb@spud>
 <SH0PR01MB06675EF7ACD1452C4DEBE45FF243A@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>
 <20240201-handiwork-excretion-36aa2eea0709@spud>
 <SHXPR01MB0671975B6B2455E43A5C7D86F242A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BCDHEep2tdoQkpJp"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0671975B6B2455E43A5C7D86F242A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>


--BCDHEep2tdoQkpJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 02:29:16AM +0000, Changhuang Liang wrote:
>=20
> Hi, Conor,
>=20
> [...]
> > > > > +	imx219_clk: imx219-clock {
> > > > > +		compatible =3D "fixed-clock";
> > > > > +		clock-output-names =3D "imx219_clk";
> > > > > +		clock-frequency =3D <24000000>;
> > > > > +		#clock-cells =3D <0>;
> > > > > +	};
> > > >
> > > > Why do you need an output name here?
> > >
> > > The output name can be unnecessary.
> > >
> > > > Also, where does this clock come from? Is it an oscillator on the b=
oard?
> > > >
> > >
> > > This clock come from imx219, not the VisionFive 2 board.
> >=20
> > If the camera is not on the visionfive 2 board, why are you adding this=
 to
> > visionfive-2.dtsi?
>=20
> It seems that I need to use dtso. Right?

Yes. FWIW, the same comments as applied for the sound card Walker tried
to add applies here too, unless this ships with the boards:
| I'm not against allowing in-tree overlays for hats/capes/daughter-boards
| that come bundled with a board, but accepting ones for a hat that
| someone decided to use theoretically has no limit! The "someone" in this
| case might be a StarFive developer, but it could be any random one of
| your customers next!
https://lore.kernel.org/linux-riscv/20230510-riveter-ridden-3f056251e623@sp=
ud/

I figure this is a similar case as that?

--BCDHEep2tdoQkpJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0clQAKCRB4tDGHoIJi
0s6AAP9L5qiPX0VFQUsozcIGbJ6jTWsVE9WjcORf+MEOv8bBLwD/eAwDIKs2E/3d
hREM5pnSpQkMLMCQ+cIoxbBnsRfWGgY=
=bMIQ
-----END PGP SIGNATURE-----

--BCDHEep2tdoQkpJp--

