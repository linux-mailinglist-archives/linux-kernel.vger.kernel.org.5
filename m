Return-Path: <linux-kernel+bounces-52684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B37849B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64998B298EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615B1CD03;
	Mon,  5 Feb 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="b1jfRybE"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B71CD04
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138477; cv=none; b=XN9Aarsr/T8fjHE2Zv5jpr+yBJBi3yZ+e/qoNcxLmqnrSmo7kbQ5TnzR4bKVeL8W7jwsYCGsUi2j6xu6dPCCw16jiIsho9mjm0IAsCZ/H92v88m82YTB1EoYLhKEChtbo3rak1dS68nVd8xpE2h3LOUjbVwQCb4FJShYaAeMKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138477; c=relaxed/simple;
	bh=mb3CBFodfFLRuWMzMcYxvL+Qq437VHJxoAvJtMqZNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCUcId2V0TLxtaRdohqgWJPIstgScvKt+UhNVHPXDdNP20eB8BYtsRWZY0mb12w6Tvcekej82kXEFIqE9t/fNJXd+b/uXbqukpFS+PWZtwFhhP1H06BHd8plmM2Jl4TGeRB6+kuMtQEYxCWYJV77bm5hKrTxGYUh9LGSEY2/DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=b1jfRybE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vP0L
	TfSOvv04oCKDBTO5Ifc5yNAFcsSqOVecVHWl9Po=; b=b1jfRybE3ZdP5o5KTAhD
	mTL6/bRE2xHwvlafF9Oz2WR615XcW/4vEjBVLiK/dsvqxLOm03fir0SiAMG4wTOC
	5H03KG/oRXLZ+WSY8rfJN7alW1ItBqG2eCeKRQ0wUHptJOeBZc51EZQUWedVUb4D
	osWrbhlpqY3f+0n3+gWyo1satRHo6MX/zFco3fj2xLXbEzSEzaWkQYAUMichUhPW
	/0gLIVuOS9Chfw0jyIgSieVlZMN74HgZs4Q9/iNE0mKkgg7e3i87XtGKzB3GEI0T
	FRENYpcjIhzq11JNyN/tlga/ilRSslKHvoyMiYd0tjAz9iancKhaHvVQ+uL43xFQ
	ow==
Received: (qmail 827434 invoked from network); 5 Feb 2024 14:07:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Feb 2024 14:07:44 +0100
X-UD-Smtp-Session: l3s3148p1@UhG5JaIQLK8ujnsZ
Date: Mon, 5 Feb 2024 14:07:43 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
	masaharu.hayakawa.ry@renesas.com, takeshi.saito.xv@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZcDdn2AVz8FIXzak@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	yoshihiro.shimoda.uh@renesas.com, masaharu.hayakawa.ry@renesas.com,
	takeshi.saito.xv@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OJl2Hke6wUYqvGo9"
Content-Disposition: inline
In-Reply-To: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>


--OJl2Hke6wUYqvGo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

thanks for the updated version!

> To comply with this, the patch checks if this mismatch is present and
> updates the priv->smpcmp mask only if it is not. Previous code checked if
> the value of SMPCMP register was zero. However, on RZ/G3S, this leads to
> failues as it may happen, e.g., the following:
> CMPNGU=0x0e, CMPNGD=0x0e, SMPCMP=0x000e000e.

Can you add the current TAP number (variable 'i') to this printout?
According to my understanding, we should only mark this TAP good if it
is in the range 5-7. I need to double check with Renesas, though.

> Along with it, as mmc_send_tuning() may return with error even before the
> MMC command reach the controller (and because at that point cmd_error = 0),
> the update of priv->smpcmp mask has been done only if the return value of
> mmc_send_tuning(mmc, opcode, &cmd_error) is 0 (success).

This is a needed change, for sure.

> This change has been checked on the devices with the following DTSes by
> doing 100 consecutive boots and checking for the tuning failure message:

Boot failure is one test. Read/write tests should be another, I think.
Because if we select a bad TAP, bad things might happen later. To reduce
the amount of testing, read/write testing could only be triggered if the
new code path was excecuted?

Happy hacking,

   Wolfram


--OJl2Hke6wUYqvGo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXA3ZsACgkQFA3kzBSg
Kba1EQ//XACdt4i/fR0oXUL7zqQ/iNlftWWZFRf6sI4jYTfUTFcUM6Iy3b5qMnqa
Jo2HLRrVc/80MUkGVYHSr6MN/JnwrBOYwrHMwhVwT2Y2uZrHJPLxGqm7PJ/pexxU
h8+3uc5NL/xUoSETj6PFMlmB1H0Zx7rHO2vj1NLhnk4USThgZU0HBPAE1pw64UL9
m0kRyTcY+KBaVE1DaA5RJriDlH0oVpP43L/Uw2y624IK29EzrsxLmY0NWWlZoKE3
ncsqMWDyMrQnBzoM+wDyc8NsCS80WbTYZvqoh70Hv7z5K2yAmi7v5pUsbWYZC29E
6PV1Tjdstn1+zxVt+gcqE/i2X12ltvzCm8XHMDJriqaMp7Gm1sT4ZVxJ8+dTj1x3
Q21ojW9O1J6v3gf4pjqlcqUiJBvz+zq3oXRgBocKS3eP1bJDXkh25JocyB/a1LIY
NXeg0ZkBKlA0ag7ke9LB5088remEfliVX9a8l7J6CoJ+ZRKMhmkcsmsWXSFmfkhx
+sDMAUgPL311MTKMGt/QqFrXA08mlMCVxuPvcIgrINkuzXNRZXpVr5dAkTuZEBSi
1mZCtrmhOQF6f52hKqTkIYag3p61rDVc95OwdP5Xu7ftd+cILcmBBlZlwgVA17ER
rWuRXOEjvXSdC1veNWw9loJhb73nz0lEb6vBaRWMmwq1ayhdC48=
=fH1y
-----END PGP SIGNATURE-----

--OJl2Hke6wUYqvGo9--

