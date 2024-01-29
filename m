Return-Path: <linux-kernel+bounces-43142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A21840C49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F70C1C21725
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE715705F;
	Mon, 29 Jan 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppOhUUjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4015697A;
	Mon, 29 Jan 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546967; cv=none; b=aCRzi+oHXr4txE084lkL6+Usy3RortDgLr47sYYsysLo0htzWCZnVD2xfydrp3E1lTx4EZkifed06jLVYJ7pdjABQ53hSIuwP+RHpUQId6YvJDnlO8XLwwVlLpyr+jTQBjxgCXQUz0KVzvjAT2Sup9eaXzwyaMiXg1xPbaoO7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546967; c=relaxed/simple;
	bh=zOI5Zcych/Y1XbO/F2PeWSHwZzbVzcz0tvh/sGN6JJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1F7MJ+mYs31YrUJuKUxFYePizV3AqYN5eHSO0L+QTLH1nSgOAMoITBMEvFMmMLDAJA++mIcwtwDVkAbqqh2Sk9OfRECzbYN2/flvRfddccbGmnlUK+r6zsBpXkH6z3cgZ4XqjMbDtJo+Z6K3S8VrP98F30tKVa3N9P24P1R29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppOhUUjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C415C433F1;
	Mon, 29 Jan 2024 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706546966;
	bh=zOI5Zcych/Y1XbO/F2PeWSHwZzbVzcz0tvh/sGN6JJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppOhUUjlR8c1sPoKaP7d8lZkfZbmCVyZHzKAGGPKxki7UoGWs3CYi4geMI1j1UYkW
	 9mJuaqi+tg7WRomVymbe8osvygsfo+bXgDSyhOb8rLxWd7hmriSJ69VSXN8wcwbSnn
	 uaJUVm4TPCJSuxNGYv0bSAUj6GjIevBoeAVvGGo3dYD9v0LPTWVkTRLKL+vA+DvVvh
	 zYK7waSRqi/3eTHChqINR+RPMi+Ess6VPuv7g7d/16Kg6N3Gwq6RwZMrGbfEE4Rdpy
	 KIls2FpaelrUAedJz7CzAmGZzsmI3BKE5YWAIYALJcG7K6bNIc1XzVHsoMgu5VZpRO
	 d457376DKS42g==
Date: Mon, 29 Jan 2024 16:49:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <20240129-encode-catchable-f5712d561a47@spud>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WzYPB8b14vGEc5Ey"
Content-Disposition: inline
In-Reply-To: <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>


--WzYPB8b14vGEc5Ey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
> > On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
> > > On 23/01/2024 20:22, Frank Li wrote:
> > > > On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
> > > >> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> > > >>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> > > >>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > > >>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > > >>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > >>>>>>> Add device tree binding allow platform overwrite default valu=
e of *REQIN in
> > > >>>>>>> GSBUSCFG0.
> > > >>>>>>
> > > >>>>>> Why might a platform actually want to do this? Why does this n=
eed to be
> > > >>>>>> set at the board level and being aware of which SoC is in use =
is not
> > > >>>>>> sufficient for the driver to set the correct values?
> > > >>>>>
> > > >>>>> In snps,dwc3.yaml, there are already similary proptery, such as
> > > >>>>> snps,incr-burst-type-adjustment. Use this method can keep whole=
 dwc3 usb
> > > >>>>> driver keep consistent. And not all platform try enable hardware
> > > >>>>> dma_cohenrence. It is configable for difference platform.
> > > >>>>
> > > >>>> When you say "platform", what do you mean? I understand that ter=
m to
> > > >>>> mean a combination of board, soc and firmware.
> > > >>>
> > > >>> In my company's environment, "platform" is "board". I will use "b=
oard" in
> > > >>> future. Is it big difference here?
> > > >>
> > > >> Nah, that's close enough that it makes no difference here.
> > > >>
> > > >> I'd still like an explanation for why a platform would need to act=
ually
> > > >> set these properties though, and why information about coherency c=
annot
> > > >> be determined from whether or not the boss the usb controller is o=
n is
> > > >> communicated to be dma coherent via the existing devicetree proper=
ties
> > > >> for that purpose.
> > > >=20
> > > > Actually, I am not very clear about reason. I guest maybe treat off=
 power
> > > > consumption and performance.
> > > >=20
> > > > What's your judgement about proptery, which should be in dts. Such =
as
> > > > reg, clk, reset, dma and irq, which is tighted with SOC. It is the =
fixed
> > > > value for every SOC. The board dts never change these.
> > >=20
> > > Then it can be deduced from the compatible and there is no need for n=
ew
> > > properties.
> >=20
> > Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc =
usb
> > controller) appear regardless dma-cohorence or not, connect by AXI3 or
> > AXI4, needn't add new propterties.=20
>=20
> Anyone have objection? I will prepare v2 to fix rob's bot error.

I'm not sure what you want me to object to/not object to.
Your last message said "needn't add new propterties", seemingly in
agreement with Krzysztoff saying that it can be deduced from the
compatible. That seems like a good way forward for me.

Thanks,
Conor.

--WzYPB8b14vGEc5Ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfXEQAKCRB4tDGHoIJi
0pWQAQCcCKkGox59jv0pnLJIkeilqK8+unMnXzYPcoJYF7sjPgD6Ag9fzTbxR7O7
G3X9f7JRKJEEVCEgR/KaAofoyfZ4Fwk=
=+D8s
-----END PGP SIGNATURE-----

--WzYPB8b14vGEc5Ey--

