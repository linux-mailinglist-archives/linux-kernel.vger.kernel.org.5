Return-Path: <linux-kernel+bounces-27624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889682F327
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2F81C231E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5971CD10;
	Tue, 16 Jan 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7xXYZef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD951CD07;
	Tue, 16 Jan 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426062; cv=none; b=DKaGQkYPBJQVcTxtKzBEdiMlcbtYv3vci0aIYNPVLp1wcvQoSoACY76CDHiOPeUHbCnIqKKCgfMhpwJbRMvsW1vhDgllct/2NMPVaNk9+V3oMOly+ovq8AZq/KzB6fymiE8doiNh9QgmKmdiGHEgpBVX4tq+esfmI6lY7yyP/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426062; c=relaxed/simple;
	bh=F0m7WszRnbOFEV/7dKFI1v5hbATkstlQoZ5sZXa7SMc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=GfwUecewwgY483Ioi2iTyh3L4XMHxlNtAF/71uMasV16gLqCsZjvWEFrcTwPLE3remUetRNG/JoUfeDm50V2+3p+DrFgfMYr7fPc8UOKkz1dgiWaWD50PRHMEq5+fpPLm/oXDsgw/2FAghwpchTIluA5hev5bqvKdo+oqVKxdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7xXYZef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358DEC433C7;
	Tue, 16 Jan 2024 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705426061;
	bh=F0m7WszRnbOFEV/7dKFI1v5hbATkstlQoZ5sZXa7SMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7xXYZefE6IgF6jGnqnIdZp1qM5fs7BesIzbnVR17aW7yD6v95+52ch4u+oMeUNtw
	 i+jSELjufOLBN0KEPgTCxfJIXCA+eLbd/VmHN7vby9cxH8Gq8iJgLn62+KJv8v2QqQ
	 ozctigwLcoGXaBujyAeeOAemgqAYmIPxGYpPwP8LkAq84D+fLHDu9DAErapa35XBvL
	 79Tr3pW+Ap2mxkL02lwHv60yI/+zloMv2roPZh/YXpUbKRSSvJyyQ8gOdrPsj+FQRB
	 OQQnbgrGXIsOL85XlNdryy2Tst3fwjaq85UxoHN66LI316SOkbpjoleaddpP8jQkAH
	 PuYucQzc1jWlQ==
Date: Tue, 16 Jan 2024 17:27:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: silead,gsl1680: do not override
 firmware-name $ref
Message-ID: <20240116-culminate-music-1ce4ada58edf@spud>
References: <20240115182057.1610195-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jPUmpLPVy6cMKpxP"
Content-Disposition: inline
In-Reply-To: <20240115182057.1610195-1-krzysztof.kozlowski@linaro.org>


--jPUmpLPVy6cMKpxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 07:20:57PM +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>



--jPUmpLPVy6cMKpxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa8iQAKCRB4tDGHoIJi
0huuAPoCx3g9gsIcadCaO0TIoyycQarpVU6FxILXNR2aXwfQfgEAh75nxTEKsu6O
ajDVtX4dCdYKECHfSG+6DkTV4ucowwY=
=wK0V
-----END PGP SIGNATURE-----

--jPUmpLPVy6cMKpxP--

