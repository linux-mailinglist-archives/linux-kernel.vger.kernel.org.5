Return-Path: <linux-kernel+bounces-65790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E08551DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24522283C56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B130129A99;
	Wed, 14 Feb 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhmO2/GB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2368527F;
	Wed, 14 Feb 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934345; cv=none; b=a8nAHkS0C/RtklU7JapLvyuKtazpM+fS8DeyDbr7sNoFyvl12ug3NUBx/1uNie/3g2ZFIEEe6v/n+6uXd/iUuaCeEmmfhDiw+1k93/o6vt0kxOMvGaOvf6dG228Q9FYTII3laiomOefVDFer/WeSb0sH56jzL+SAq8GvnNoEv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934345; c=relaxed/simple;
	bh=CDlqvcoUaaFjZ++J28H0zcJUMfv3V3DXrfQN3Lt2XuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZibZ6OsMahw/W1jKdRiS4stn2APEQzz38KplYUvxv6eyxVUR8WbI0cmfylEaHUYmKHFPRst2Zch8StI+J8Bbd2GaL+GgOrbC350EDR1h6pUWOf/u1LSEDmOOPBChWBxLB8xE3edSB2+frdlwzHwh7HL9SXtN2q1ddtiaVUWd2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhmO2/GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA1C433C7;
	Wed, 14 Feb 2024 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934344;
	bh=CDlqvcoUaaFjZ++J28H0zcJUMfv3V3DXrfQN3Lt2XuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhmO2/GBR4pf1wnPFAUrJMYYOsp1eWlMvm9qhAcjmfPzxb0H7Nd8STbTB38vJc8BW
	 /jPYSgEYnYxBmeAtTgMQHh/EJVBMmJryXTm/DbLiOBzTqPuXupLG6sWjwkE4Gb41m8
	 zEvigiSmLlhOLmOl3uYM8r3m5Stb0rMs1hR+kDEAGkHVKtXklHpObmo7526vO4AfnA
	 Y6GsRdd/T7IiO6BkyVSi/f7RBBwjyAKqKmb6vMxniPQXMHoxsOC2AwP8JFp1q89NXX
	 XiPsT42i1Oy3jmB0xfSz0An6xDCKX6YGPaSSU+cjBMfdbZxFVjlTfjEAUgvNbSMPcq
	 X6ARDw/uAme0w==
Date: Wed, 14 Feb 2024 18:12:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	David Heidelberg <david@ixit.cz>, Heiko Stuebner <heiko@sntech.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
Message-ID: <20240214-moocher-womanless-21201b67b76d@spud>
References: <20240214040731.3069111-1-tim@feathertop.org>
 <c03220db663279c9e83bab81f3d829e7@manjaro.org>
 <e952d127-b12d-4b5a-838b-807a876db707@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xM0QSn4CMXaJ9cxt"
Content-Disposition: inline
In-Reply-To: <e952d127-b12d-4b5a-838b-807a876db707@feathertop.org>


--xM0QSn4CMXaJ9cxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:27:08PM +1100, Tim Lunn wrote:
> Hi Dragan,
>=20
> On 2/14/24 15:14, Dragan Simic wrote:
> > Hello Tim,
> >=20
> > On 2024-02-14 05:07, Tim Lunn wrote:
> > > A couple of rockchip boards incorrectly list their vendor as Rockchip
> > > when they are in fact not manufactured by Rockchip.
> > >=20
> > > Fix the vendor strings to correctly list the manufacturer
> >=20
> > Just checking, have you verified that the old, incorrect "compatible"
> > strings from the board dts files aren't used anywhere in the kernel cod=
e,
> > such as in some drivers?
> >=20
> Yes I checked that, there are no remaining references to the old/incorrect
> compatible strings in kernel code

What about other code? Like a BSD or a bootloader? If nothing is using
them
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Fixes tags I think wouldn't go amiss, but I'm not expecting a resend
with them.

Cheers,
Conor.

--xM0QSn4CMXaJ9cxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0CgwAKCRB4tDGHoIJi
0rnIAP4266uBVs8L2WyYwA8DkZLeNbpLCOsYZojqX3g8t5zn2QEAmlVsc/c21nrD
IOXryV8IFMuPO4v9U4rwGrS6mo9QQQ4=
=kr05
-----END PGP SIGNATURE-----

--xM0QSn4CMXaJ9cxt--

