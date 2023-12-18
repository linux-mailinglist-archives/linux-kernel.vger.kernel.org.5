Return-Path: <linux-kernel+bounces-3867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E1817456
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C18F1F22B15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031A3A1CF;
	Mon, 18 Dec 2023 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYV+TcCa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B583A1B6;
	Mon, 18 Dec 2023 14:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE83C433C7;
	Mon, 18 Dec 2023 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702911336;
	bh=UURxzOfkRIDHP70cvgvabsbuX8qYqf3ZrFU1zvZQ5io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYV+TcCaadw6lq0zV3I5VHGhBYyeOsb4W6fJsF0FwmPXqaiQzo8ETfsFVoKdG4H4r
	 4FxLC1NHykn9egLbaV01V2uQZcAvzM0WIYhxwDQ5arilC1ErwjP/WF2vq0ZRYWaehl
	 LkIOcVKNF1VQdHzGVBK/2QWWZslD4MZm5EkzVl7DxdOoU0wKrvU+4DYHBjtfMIhtzN
	 gppALRstSpSl8dzJr3HIgkD108tzNVXYOPehYAbaSDYSjp2WFgRiYVcRWIBCW5zn1S
	 eP4+ZQrGmDErsaMBDg6XsT/00sDb7l9+5VoMkJapgS9Than61l+X3VkW096rY1PFRZ
	 eYCZ3s4lFYlbA==
Date: Mon, 18 Dec 2023 14:55:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] cpufreq: sun50i: Add D1 support
Message-ID: <20231218-blabber-slapstick-ab7ae45af019@spud>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218110543.64044-4-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Y/+A79iTqO1pQeH"
Content-Disposition: inline
In-Reply-To: <20231218110543.64044-4-fusibrandon13@gmail.com>


--4Y/+A79iTqO1pQeH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:05:41PM +0100, Brandon Cheo Fusi wrote:
> Add support for D1 based devices to the Allwinner H6 cpufreq
> driver
>=20
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index 32a9c88f8..ccf83780f 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver =
=3D {
> =20
>  static const struct of_device_id sun50i_cpufreq_match_list[] =3D {
>  	{ .compatible =3D "allwinner,sun50i-h6" },
> +	{ .compatible =3D "allwinner,sun20i-d1" },

I thought the feedback in v2 was to drop this change, since the
devicetree has the sun50i-h6 as a fallback compatible?

--4Y/+A79iTqO1pQeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBdYgAKCRB4tDGHoIJi
0tB6AP91iVWjmaYX10I36D86nBIbqoU4U/4Umgf27YchmH4OsQD/ZV/idPgamnZq
+RnYLmusNu1HEX5o2wVaNtYGhLIC3gs=
=W0H8
-----END PGP SIGNATURE-----

--4Y/+A79iTqO1pQeH--

