Return-Path: <linux-kernel+bounces-96001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4028755E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D07282E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928C131E4E;
	Thu,  7 Mar 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs+QXhVC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832C21A14;
	Thu,  7 Mar 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835264; cv=none; b=l3W66DUhhG23gX9HvngyqxP25KKl78tlzw2O4PFDcU20h5vWn59Jrubs4s7nCKuyCTSUlVbOlOh7bdpGJOPx1gba+2m+EBZbMykwpsfjPfOEh8Vric/raMoE4BPdn6IRlcc3Wgtp1Ng8JLejkdgxmcQDgmYqv3GrWFAnUWPy0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835264; c=relaxed/simple;
	bh=20r6C0Cvk2VdqRyx6dy4WLmP4PSKivLliJzJpVzkc3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMBNrqOqYCZFkHO5XLyLCQossQA9H6NI4+EBY2Q2pkdDv3IUvQob2vhcJoJoUj0SNjFrLOo+44R40ENc8UtLHq4RravNAIhoHNEkm6uVxo99BydNxVS39RyQaNRNvrjHuyAFjM2C2ROF7R1aIXnlIsnXkyibTdxwaW8JO9zJe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs+QXhVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A811C433F1;
	Thu,  7 Mar 2024 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709835263;
	bh=20r6C0Cvk2VdqRyx6dy4WLmP4PSKivLliJzJpVzkc3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs+QXhVCvaUvmaJJagrBX8G3H66YXEauXPbPtHNyfeTIL3EQWQNAuCLK3rAiHzTtf
	 3ShEATpHNFK7kiIkTINmOixb5t+i0E62nwaCmC39JF2K8cKNc0Ml7X+TXrxa8B6ikY
	 a75GmnlVPt95bl1K6ov8c5EhWea0dyoVEfocHig1GxqmfwLBzMknpWrGtCNkXxtOWx
	 OVXM2buDOanFKXzteFRcTWzl+4GL+6L9M5zxQnpdzZc0ZmpIwYCygLI68r6dLvlJnS
	 SDOtBgQAV+MNcv7q6U/5RW1iWSyZFoiIAs2dIuxF13Ovq3ocH5EPURZrgGH7TjOC5J
	 YblkwAqPUSxnA==
Date: Thu, 7 Mar 2024 18:14:17 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Kevin Hilman <khilman@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/9] dt-bindings: usb: ti,j721e-usb: fix compatible
 list
Message-ID: <20240307-suffering-skyrocket-3113838c5cdb@spud>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-1-5ec7615431f3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pqa1Qtm6gzddN83E"
Content-Disposition: inline
In-Reply-To: <20240307-j7200-usb-suspend-v4-1-5ec7615431f3@bootlin.com>


--pqa1Qtm6gzddN83E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 10:55:02AM +0100, Th=E9o Lebrun wrote:
> Compatible can be A or B+A, not A or B or A+B. B got added afterwards,
> we want B+A not A+B. A=3Dti,j721e-usb and B=3Dti,am64-usb.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the update.

--pqa1Qtm6gzddN83E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoD+QAKCRB4tDGHoIJi
0tLGAP9kEz0p6yt6oDzXTh6N/kxI8BPC+LKmUVTGAkNrmWqrOQEA23pMFGK5/FTa
TmvNQFaaOGysW1lDv+SZEr8cxw1SCwc=
=ZjoR
-----END PGP SIGNATURE-----

--pqa1Qtm6gzddN83E--

