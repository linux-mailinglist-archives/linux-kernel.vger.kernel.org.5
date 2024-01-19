Return-Path: <linux-kernel+bounces-30668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571C8322D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6F31F2330A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812C10E4;
	Fri, 19 Jan 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lSBy4ghG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763881F;
	Fri, 19 Jan 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625933; cv=none; b=tC6wUFvDVf5edrDwCaMcKWpUk58vzYtUEthCbu0ed0XH8GuJkvdoYQuNL8kaZ48P55toagd0Bjo2jNMkfXM0Up9LK58mq4lZab7Ky9AUiJALMtGHJDS4lHl3Ry4duS0YGaT4HUU9N9YfBFrudvu5Sz52SXWZt9Q4UJh2seYSqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625933; c=relaxed/simple;
	bh=z0fVImkm7UGSmqgWkIF+werv/LoyB0dHD2X3KsTXHlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7Kw7dkn+vXcdbHFCcgCPOtCSAcMlkSwhEiuqw/pvuCZIvjTjULUGixwk7ETOLHjO5/8wUmzUDbzNPrCIDr/bBDcW+3g7ayE+U4Z/xbXMXiacG99lZiCDI7eM+UWeYkInjD3mTVJV5XUvp1SYGux+ikYTAUiqZ2SS3TY/mPOxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lSBy4ghG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705625925;
	bh=43Ub4cxvhf4UbencJZZh1E96E6g/2qxuS/dzdCa2liY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSBy4ghGe/51Y2lDRsKIun3YhCV07Bi8ZiVOBS3k2yUfyeuOQcflB2Fzoe3vr5W3y
	 7HQN6425dTl7Gr++PCG736NzCH7tvzCb2aIlcn3fYiKt60mgjfBhYMr5xvt3RmPhG5
	 raZ7Y2+ZUcfWyGI4EhF4yDGV09fJ8CJyJS2OczvXkwtGpR5K8xhGDY/lWTamMg+ave
	 gMVwZDoEgyPOgjoOw3Gi9ehiYLdXQco00nRjjs9n8BZktvfxHLT05/yZeBngx3OU+V
	 YqmtrA5xMuBU3HOW3GqQK2r4ocHVJgzBCrHYJfdWcz9YNUpk0aV4WGiPiDp7URYWzP
	 7eTbl4pMOrQZg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TGLpY2SD9z4x5m;
	Fri, 19 Jan 2024 11:58:45 +1100 (AEDT)
Date: Fri, 19 Jan 2024 11:58:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi
 Sankar <quic_sibis@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the devicetree tree
Message-ID: <20240119115843.5556189a@canb.auug.org.au>
In-Reply-To: <20231211160510.0aef871b@canb.auug.org.au>
References: <20231211160510.0aef871b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S/UQqlq2sNIGyL.SIsfvLS4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S/UQqlq2sNIGyL.SIsfvLS4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 Dec 2023 16:05:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the devicetree tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/clk/qcom/gcc-x1e80100.c:6786:15: error: variable 'gcc_x1e80100_dr=
iver' has initializer but incomplete type
>  6786 | static struct platform_driver gcc_x1e80100_driver =3D {
>       |               ^~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:10: error: 'struct platform_driver' =
has no member named 'probe'
>  6787 |         .probe =3D gcc_x1e80100_probe,
>       |          ^~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:18: warning: excess elements in stru=
ct initializer
>  6787 |         .probe =3D gcc_x1e80100_probe,
>       |                  ^~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:18: note: (near initialization for '=
gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c:6788:10: error: 'struct platform_driver' =
has no member named 'driver'
>  6788 |         .driver =3D {
>       |          ^~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: error: extra brace group at end =
of initializer
>  6788 |         .driver =3D {
>       |                   ^
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for '=
gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: warning: excess elements in stru=
ct initializer
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for '=
gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_init':
> drivers/clk/qcom/gcc-x1e80100.c:6796:16: error: implicit declaration of f=
unction 'platform_driver_register' [-Werror=3Dimplicit-function-declaration]
>  6796 |         return platform_driver_register(&gcc_x1e80100_driver);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_exit':
> drivers/clk/qcom/gcc-x1e80100.c:6802:9: error: implicit declaration of fu=
nction 'platform_driver_unregister'; did you mean 'driver_unregister'? [-We=
rror=3Dimplicit-function-declaration]
>  6802 |         platform_driver_unregister(&gcc_x1e80100_driver);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         driver_unregister
> drivers/clk/qcom/gcc-x1e80100.c: At top level:
> drivers/clk/qcom/gcc-x1e80100.c:6786:31: error: storage size of 'gcc_x1e8=
0100_driver' isn't known
>  6786 | static struct platform_driver gcc_x1e80100_driver =3D {
>       |                               ^~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platfor=
m.h")
>=20
> interacting with commit
>=20
>   161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for =
X1E80100")
>=20
> from the qcom tree.
>=20
> I have applied the following merge resolution patch.  This patch could
> be applied to the gcom tree.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 11 Dec 2023 15:47:55 +1100
> Subject: [PATCH] fix up for "of: Stop circularly including of_device.h an=
d of_platform.h"
>=20
> interacting with
> "clk: qcom: Add Global Clock controller (GCC) driver for X1E80100"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/clk/qcom/gcc-x1e80100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80=
100.c
> index 74db7fef237b..d7182d6e9783 100644
> --- a/drivers/clk/qcom/gcc-x1e80100.c
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -4,8 +4,9 @@
>   */
> =20
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
> =20
>  #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
> --=20
> 2.40.1

Did this get lost somewhere among the merges?  I am still applying the patch
to linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/S/UQqlq2sNIGyL.SIsfvLS4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWpyUMACgkQAVBC80lX
0GyWkQf+L0vDJrDDH7ETJZAIiuSjI874TntKzNyCasngpcN2J2sFxUweE51ghqrW
h3WPB3fpnddjz1IGkIOZEPMWVjxXK+NuyI8XIlvrk0p3Vs8uFNJAtX9vTkcTpAlf
it4P/WsdikzL1Q0iwzM3RCgIV8OtfvsDKjMZSLU1DxIG82DtAUMx7O4fKdGBnbWM
VFPhJIPP9EhSX2pjQZXiHcXR5UtYiDACpipAYcF30unu31g5UlWutSpjXiCGklig
UxAtNhFebWTZbGs0yHdTwWabW5WFvxh0VxNyv+Fv9dWfUKNj1JWQkFnonfZCO1Fh
gpsnQSXE7WNTTc5NQwd9fna3rB/rBA==
=2/Ew
-----END PGP SIGNATURE-----

--Sig_/S/UQqlq2sNIGyL.SIsfvLS4--

