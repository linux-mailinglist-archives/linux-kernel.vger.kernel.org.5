Return-Path: <linux-kernel+bounces-108515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E96880B92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CF284107
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2181EB25;
	Wed, 20 Mar 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpqoZ53p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDB1E519;
	Wed, 20 Mar 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917928; cv=none; b=GOCM92SKeE+lGx75pOqkgclDwkBTLh+Ed/+sXK9T5It+nDQtyI3/A29aLWHMdHgugAu29wvc+iJPT6NSigER618fyw5K8Vj8VRModypY39Z88g5vVJ7uepMixX4q8FDGeq2VuTZBIu4fP2WTE9z0/vx0KLGzhc7KaN2xn9c7Icg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917928; c=relaxed/simple;
	bh=BsU/Q3JaZEvQOGQ+BygI1NyLrqO2MQHazo08rZYE5Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciXHMBNtdJ2vvVljfxIVnw27gAxGcnRr8cmbMKe3B/3z/fY/zSnKZp2Pbz44G4pYlSv7qzb6PPMxz801/zyvMza9er5NfBlDCGzqmvVvu8hkDx4Emqc5oRBc5ApFlcY3M6fXIu97kI4kOfBj3EE4YgSFldWhW4Qnb9AfSPaD/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpqoZ53p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62734C433F1;
	Wed, 20 Mar 2024 06:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710917927;
	bh=BsU/Q3JaZEvQOGQ+BygI1NyLrqO2MQHazo08rZYE5Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpqoZ53pKDyrLGy9FBGOf9dabjeTsBSiEP8h/ShLxg7Bzz2gAr2rqe2oEp5kO8Nhq
	 NTPqT0lWLQfVFFPUU4b6HQRACwpOvLkl8o4fJRl2zL6qMeoHKb0/tycgkwuxGdv4gL
	 7/JL2x43ougVWzIb5QKbrko8jb5QcOTM2Z4DTsiY+YC6/rE1Ny/ds6a4CPK96BBb9p
	 5u3DO3eni0U+vfjxHrFdV8pGVlCt2SSl+9AJmEA0yrovJzYbqoQbykLAFDf8u6TemD
	 UZJSOl2YbGo1LW11F0BPCZTBEZb9XGpwDW8SIKg7w2pMm8wohs7OVNOHyMNXuXzPFC
	 OHN8indnjubJw==
Date: Wed, 20 Mar 2024 07:58:44 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: timer: renesas,tmu: Add R-Car Gen2
 support
Message-ID: <ZfqJJC6Ljp09FNAw@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <cover.1710862701.git.geert+renesas@glider.be>
 <dd77275fef23ef3dc335a43ffa9aeca0ff7c41c6.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="INu9960U2T7NGcB1"
Content-Disposition: inline
In-Reply-To: <dd77275fef23ef3dc335a43ffa9aeca0ff7c41c6.1710862701.git.geert+renesas@glider.be>


--INu9960U2T7NGcB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:05PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on R-Car Gen2 SoCs.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--INu9960U2T7NGcB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmX6iSQACgkQFA3kzBSg
KbZ6Jw//coMKC/ycEIsWTkSTRoRtDixFJqKfCiPbP4J3oiWhrOGcPQ0n3fsC3Z+/
qfEbT9D/zrSLVfDcGC/GKfxN83hl/sFovIWrhB1mEITMGEAbRNPA835cMY4W9pXW
M/Bwsf3qx9N4NZ2KxqDTwx+lr10ZvgdlI8IIhgWsNUo8fNwoPbZBkcsCfHLMkecg
JvvaE5QvCVXur450E8AhImzMdVFNb3shujSgltEpqbGxxeTe5XGtTm/mUt8HORBh
Semq8jJhIHtIaNDQGfGRf1CwdaN7kHjKj57K2Iz3lWeH/+C3FbGwJdkr/65rrlMU
20uA239tOYp2SuOugtaL2Q9IZOP/IFVTuZc3byJhrGa+laHgilJrkXZi6BOQVUd6
Q6kpLsV/BilhCXuu2jNlqeyOjw5vRIwM1GpiwHuFZTTEiL9yhSv5qqSm3qPQZCgD
qVWDOoDUcbh8Dnz05vrOfkmi1Adw6hu6t8M+YMNeyG3sfutQIupj/1USl1+5Q19f
BVhAZqps9SNIsOh+SCwK8bG+eYW28BjX/z8XIPthe/9G3LaHldl89iA2Ta/jA8we
iuyCIXQHUeiNe2Knwl5qomZESciBmJbF0xnWAekfLD9vTL6nRDBtefYr3XtBjQCs
IqnzyrO3lM9lIg60y9fuV/geC6VYoLMIzd3iZBDhsqocogSrcJ4=
=BY80
-----END PGP SIGNATURE-----

--INu9960U2T7NGcB1--

