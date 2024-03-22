Return-Path: <linux-kernel+bounces-111960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC267887348
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB6E1C20938
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28966A033;
	Fri, 22 Mar 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxwmK++Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF669D29;
	Fri, 22 Mar 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132712; cv=none; b=fd85bWIW6ZzItBXCuALTajCzbMqcmqfKC7PryseRV/4VKgQPoTthLZTms1TBRXxCCWvAs2ZW2ZyqrtP8zgwTyg7Y8hVaTokxGcmkCsmlI0HvgPkdTE7xp5SKNn7WXymSSqxt+1wXrG4GpBdH4MPeTVU738x+7XdBhh2HHtQ7v9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132712; c=relaxed/simple;
	bh=dGXvkLMPPQVAOLkprdbj8xiYHcO7h+HauIpMdGVUH9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1+2wbFUzZ6PFEOxaYXG7mHrW8sAd/jAivIRwTtBeqWSFPwFsflsRsyEhEARAKDKPqxHP2D7vWoQkQ22B6UzEU+SZe3dPPk7UvH8mwuJJ0eSrs1lG8Fw8DzWEnm6NZ++bZvMtfdpq9KWxc26t8OshpKYM/XxUeJvWxbJpQV08D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxwmK++Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380B7C433F1;
	Fri, 22 Mar 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132712;
	bh=dGXvkLMPPQVAOLkprdbj8xiYHcO7h+HauIpMdGVUH9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxwmK++Y/vUd8E2N4UhgdjHikoIgWFpKuIbYWXOqHMl70z3ZkxaOl0gZ4W0IKtEhW
	 +Ip96pnq5p5rIcAztiA2cCGGPpZ9ztHWsS/XH6ybLlVNPYPUwnTxTifuEcDHZHsDMX
	 8KP8ZVA8CE6LYaCHvutLVDh6pzTqrCQXzNj9EcXjjlrQtPGtaWq6N9FqzKRP7nZwq+
	 vf307QHyWmdNxuJr+iao/5DcSfOrtmUHAU2h0Mu900gHytZKzVDFxI21GgGnXiMhRm
	 gUG9aMOj4PxcasHyCBXkgZ5byakqjismGFyOLjCOL0yXxZebMSFccZ75XYbUb84AN5
	 6XnKQhGdzs0OQ==
Date: Fri, 22 Mar 2024 18:38:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Message-ID: <20240322-stand-crewman-f10696eba901@spud>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bcPcRlrsONNXRmNQ"
Content-Disposition: inline
In-Reply-To: <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>


--bcPcRlrsONNXRmNQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 02:43:52PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> This commit adds support to validate the 'interrupts' and 'interrupt-name=
s'
> properties for every supported SoC. This ensures proper handling and
> configuration of interrupt-related properties across supported platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3->v4
> - Reverted back to v2 version of the patch.
> - Used suggestion from Krzysztof for interrupts

It seems fine to me, but maybe Krzysztof wants to take another look.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bcPcRlrsONNXRmNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3QIwAKCRB4tDGHoIJi
0uLPAQD6pthjYegxkBuqJGFZzvToACvAKxjZhEbLIXP4mWNezgEA5/iZqaufvtZW
xBaxpbrjNRS7X6onI8a84vYjH2gbiws=
=Pc1V
-----END PGP SIGNATURE-----

--bcPcRlrsONNXRmNQ--

