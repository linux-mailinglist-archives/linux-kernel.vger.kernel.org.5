Return-Path: <linux-kernel+bounces-163621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20B8B6DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9F2281C95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1EB127E02;
	Tue, 30 Apr 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f2VFFO2N"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CC4501C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468240; cv=none; b=SgRD6hRUfTsUZhLR6s2pU9Cs8qJfgY2R0nDZEoXxjR54Su7rG0ylxh+9Gh9KHXvCVI8E2BHFlUyGxyklhN+HGY4mvmDO+oR1mblBfwQngtcWvnmniOWIZWiQb/k88zmT2TfRQTIGXvFYGkkRlogo9ObFxTpqsxoXBUNUZbyitjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468240; c=relaxed/simple;
	bh=EnpC8uxdaBLW+uWUMw9JJXC1K+AjyDTh9tv4xrNIOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk3e6KiGZVPQ/pju924+8RjCU4dq1rML4B6sEBsQwCUJv2XtTQk3ei/KUFbB0h/TCXWrp4ZexMxBC4taxVmA3EFp67LpQEK41G5wry1O3E65b5yiQpoosC3V8OJC3kdtYbfdQ3WWvcZtWmi1QMCRxdqXuPiF8Jd048gShKann+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f2VFFO2N; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=QJb4
	ulNH2VMgB23s2bKMJ77ejPMzfrg0P2qy+6olDX4=; b=f2VFFO2NU+TWRiqZ/1o9
	4J6WInkbsJkiez5lhD2sEvYzfWiIJXZ70xNiNBDKGMwpTmXZ2O/ZmjA5lqgLwBoq
	f61buPFYT3ZfjTd5tuNDAhzYz0dToa5H/WqFBMryj0X3ViTaDws9Glx++eKhdpPC
	Nwi0tnlAK3E2w7JkyzO7UE3nOrVBV1gdadLwO/uf1PETVzpEjEvPgFPFlei9eHSc
	rED5CxPg7bLUcxRRrKZNnL42jbzC8Zr4L7sN2UjaRHyNhLVO7OPKf0urtiF1dZpP
	g/7l20tEfqk++x+WZgVj5SUmyajdyBdswyhJzNh+kxE+F8SkXroUvCKiBo3qRGf2
	uw==
Received: (qmail 2570745 invoked from network); 30 Apr 2024 11:10:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 11:10:33 +0200
X-UD-Smtp-Session: l3s3148p1@tPMKvkwXBJtehhrb
Date: Tue, 30 Apr 2024 11:10:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Message-ID: <h2fhduxr5bv3m7vkxl2ga6pqkkv5mlzpwgk2q6lfsnz3l63ckk@pyzj2vt4jkfw>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7owwzlqyi25o6qu"
Content-Disposition: inline
In-Reply-To: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>


--n7owwzlqyi25o6qu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Wed, Apr 10, 2024 at 04:54:16PM +0300, Claudiu Beznea wrote:
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops =3D NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>=20
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>=20
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

So, I tried to find a place where we would need only one call to
renesas_sdhi_sdbuf_width() but I also couldn't find a sweet spot. So,
this approach seems also best to me.

> +
> +			/*
> +			 * In case the controller works in PIO mode the SDBUF
> +			 * needs to be set as its reset value is zero.
> +			 */

But I think we can shorten the above comment to something like:

			/* Ensure default value for this driver */
> +			renesas_sdhi_sdbuf_width(host, 16);

D'accord?

Happy hacking,

   Wolfram


--n7owwzlqyi25o6qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYwtYUACgkQFA3kzBSg
KbYqdhAAh1BHkpYuhh4UgC9lTha0M8cRwfM9fPYYxLfGuMgJkUlTzNpqu1rOSsSJ
QyN4vggjd5lhvLmBwNLIpeDPSt8sM2Pp2rKbyZj89SHlRShvzZkSSkWSwRDu+gbL
k2l2mU/0xhrMkO3s3ZX7FcA5HGok/qb44xGMqaBVI4cvdZd4uEGPNDxXi6Yijd48
gAxLCh3PN1gwMVETT9qt9ckp2LEtFM1omIbXic/yvry1572d9ujoqCeN7E+mx8wi
26vWP1pVRCUFhTLJVysz6B5kh1JBBamjR7iSQnSl9K1dICIVkHlZF6WbAh3FBqbJ
nW4C6JVl6rWg2VosQ4sBfe105PpZw3sjyuaOELh2HXFhfrFKl9QlUd4spkVqxAVz
BCptmAs4PgUBaOcIoM7RrPteLvTOLprdHwWI+qJbSuMZJr0bVsYBbkcDEFXRGpdf
TlwBChaFj2CFnCLAYVBTFBdLmsRGUOUhFC5PE0Ev93m7rXxd1AfiDRV3KKF0jKGW
V4hNyDBrdmaSJnZb3eCQhzyJ+5SyjNQhhRO+C4qpqfMK2Yx86G77jJtVBrZTVS8n
JY1cZg7fnE2Et2mmpkbw5+VrBdPks0YEU5IGDquBGQ/Iyrt7liR/dWCVtb/YsYe+
XbHVJiutlclajSwTBBfyxTggxyXdkHkXWxAnHuSm8W5WDZa4axk=
=1g6D
-----END PGP SIGNATURE-----

--n7owwzlqyi25o6qu--

