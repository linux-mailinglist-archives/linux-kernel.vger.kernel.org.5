Return-Path: <linux-kernel+bounces-59166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428084F26D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C7E1C22862
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409F67C6C;
	Fri,  9 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzd2xvZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990D679E2;
	Fri,  9 Feb 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471690; cv=none; b=AMppaNsWsRM8l+AsbqBAz6eIsmCvas7BZQDl0AcMZtfOJ9FNT6nuM6PshR8xOzcGZPJjmQGZ6b0q2ypXr6X7/pT2DC5ymQU7wbNXLp6LH1T0BgYu0zTVX1KciBCZ9pjJxQwAxAp0IvcOdzbL0nQhLpeJFuWUnljdwnIxYrM2UBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471690; c=relaxed/simple;
	bh=BEszwlutbx0qxg3vANAhIWjSGJaJS3pDHYYZUUm2WQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWHJxfqVBkByYC2oX2iIk2tusF2vKngAJHbZM6vSmZNtqjUeqW2MkBT/Jyz7Ioi9UW+XksJ0oTiqLonHmmTXYrH+HA/l2XJVdSSIFremvocfayvEFb6doMu6aoWwWxnirEdBaf4eVYfll22tFMpBWVGH1XQotjGOner+DV3HZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzd2xvZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4DC433F1;
	Fri,  9 Feb 2024 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471690;
	bh=BEszwlutbx0qxg3vANAhIWjSGJaJS3pDHYYZUUm2WQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzd2xvZZZP5SASu6ATZPmjqgMI2HfMroShU4nHQLy4ZqMd+6JcYpmR54OrNS69JtB
	 x+f/5oqlVaKZgPm5VT/9Kx6XPB02rxO7GLxhxxL8FPyYWaC/uD2XltiYzJTITE/U7g
	 Z+fe72yIVa3Ojc8UsgKn50HEsFpYtylpsncZ+3qIkg3e6vsNYEG/rTCsnbsEh+dLIJ
	 xLNXwxb3fa+0u4MtRwdyLMHzH0u7RC+I98Mk1nNTycztbr7pXi75wDvjAlG3IQU9cQ
	 R7nWYqW+bzgrJalfFyguxRW78Q4KLJaKEAfNc5Bw9sREZiCGVND0C7V7HZLzU/6bin
	 chFVSps7xSPhg==
Date: Fri, 9 Feb 2024 09:41:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Message-ID: <20240209-scrambled-prankish-77032c31ec62@spud>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <20240208-daintily-craftsman-c7f514d49c0f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WpMqNRNAiaWqsI35"
Content-Disposition: inline
In-Reply-To: <20240208-daintily-craftsman-c7f514d49c0f@spud>


--WpMqNRNAiaWqsI35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 11:10:32PM +0000, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 02:50:15PM +0530, Dharma Balasubiramani wrote:
> > +  "#interrupt-cells":
> > +    const: 3
> > +    description: |
> > +      The 1st cell is the IRQ number (Peripheral IDentifier on datashe=
et).
> > +      The 2nd cell specifies flags:
> > +        bits[3:0] trigger type and level flags:
> > +          1 =3D low-to-high edge triggered.
> > +          2 =3D high-to-low edge triggered.
> > +          4 =3D active high level-sensitive.
> > +          8 =3D active low level-sensitive.
> > +        Valid combinations: 1, 2, 3, 4, 8.
>=20
> Shame that these are not aligned with the IRQ_TYPE defines :(

Dharma pointed out to me that these are the same and I just looked at
the wrong header file.

--WpMqNRNAiaWqsI35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcXzGAAKCRB4tDGHoIJi
0j2XAP9hCao1O+BKFrkbwjtB7N9o1ioS94d90/QcqouAC/MopAD/XVF45cFeE3OG
RRtLqJSmfqxmGWgaHIj4Mx60Xn/EOwk=
=DCZo
-----END PGP SIGNATURE-----

--WpMqNRNAiaWqsI35--

