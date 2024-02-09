Return-Path: <linux-kernel+bounces-59191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0484F2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009DAB26FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86C67E8E;
	Fri,  9 Feb 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Fm25qonm"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB667E7A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472968; cv=none; b=uMvz7bDJFMzUcWYQQ+IpRM1382QBAEsnDskE/d5ZsgA2pgQdPl3iWqQNN9MkFVkXHg1geGURIzLfhjLOfoDCXazJF9/rzGNolNYX2qlT0zQcfW/CB4X8EN8q/ARD5ize2P4lOcOtU4OQcroqTDV1uQS6Ca+wuTyGSfVGXaojhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472968; c=relaxed/simple;
	bh=Bi+sGyNvOR62wN+JJtYz3HaBgB3hRp81dt1ufMAnmT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B55XzLmODf2WV7wbMWA0ird3/ps+WuTfpD5hFZZeKLA1OeZoNFjgah0lm5TTmqTGcWs4PhTM8gAGeGlxII6mNYx3m+sc17cQrvDTXs19jA29nZqRTbBOpHsGSfwVGDuiR5uArU8yXY9qspuk1sB/9WzTGPBNfy7yV1vTnbje88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Fm25qonm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=m1ha
	lP4L59XBQToxYQpLVlEa4LfoxnxmRFFhYmeDLBc=; b=Fm25qonmUhqN8ki1mF/I
	OlFqTN7tsTcJAYrVxBhZu2xM3c4M31ZASZYs4uD0n3AH4Bi0p9t/YChIhwmpg6L7
	M8KnAmL22zhZa0fcATLhLhqmuo0Tgc9qtrbvi2oJKX0NIC04XXffJXnZBm1BVMS8
	Uas469Iw5S1GIrecG+Q9YNR0kHx8bM45FD4zTG63SMorZQFfQm8Vg/wVgyAD8m3S
	ewZoE9hKhMOYdzT1lsBMwgMBsPFqrThU2UU8FElU3JsKKq8GLXeoK1M8sA8bl7ai
	WyaY55xMoVdRT4+3yQmWaII53UaykbkO2X2OkN/cd7+Z+tJfLN6QE5XumI0n7Vjs
	Xw==
Received: (qmail 2995670 invoked from network); 9 Feb 2024 11:02:39 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 11:02:39 +0100
X-UD-Smtp-Session: l3s3148p1@oPExB/AQ7K4ujnsZ
Date: Fri, 9 Feb 2024 11:02:38 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
Message-ID: <ZcX4PpvBXeyCmFie@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lee Jones <lee@kernel.org>, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209075839.GH689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dIGJDLVl58ggahuo"
Content-Disposition: inline
In-Reply-To: <20240209075839.GH689448@google.com>


--dIGJDLVl58ggahuo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 07:58:39AM +0000, Lee Jones wrote:
> On Fri, 09 Feb 2024, Wolfram Sang wrote:
>=20
> > The MFD parts of the TMIO have been removed by Arnd, so that only the
> > SD/MMC related functionality is left. Remove the outdated remains in the
> > public header file and then move it to platform_data as the data is now
> > specific for the SD/MMC part.
> >=20
> > Based on 6.8-rc3, build bot is happy. Branch is here:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdh=
i/tmio-simplification
> >=20
> > I'd suggest this goes via the MFD tree, so the series would need acks
> > from the MMC and SH maintainers. Is that okay with everyone?
> >=20
> > All the best!
> >=20
> >    Wolfram
>=20
> Could you please change all of the subject lines with "mfd" in them
> i.e. all of the commits which touch include/linux/mfd and ensure the
> description starts with an upper case char?
>=20
> I like all commits that touch drivers/mfd and include/linux/mfd to have
> the same formatting structure.

Sure, I'll just wait one day for other review comments. Thanks for your
review!


--dIGJDLVl58ggahuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXF+DsACgkQFA3kzBSg
KbYFpQ/+Jd2hnh/6tOmDqsof1hNES72vrvEXwVOa2RbpuW7rgFi2yReV5283uKHq
s0FiHqVUYHcwr+fIGlctWGLTqhdsIsuxaEdz6W1fz522gwGYRhaGydDO3kCoEcXR
C83yNZZ3uBu/C4xyRWvHv1jb61YXOiUhwBprXPtKy2af0hDajDkt7OMSzNIWkyTL
+cEqR9TKOjbtR94zVLBfmIxt/7Y8g3e0mKK+CGR7WZB54U8M8EUl/RhUmx1mIrQB
iaJpNmdH/jP/8F6PkkIWuR5w6w7b0BpTjztEpeM+ggMYza5TtbXV+J+jWqPUpkRF
HywyB/07IVrR/7oXEjPto5gkxgTrcA/XTXItJ+GHOq80khnn7SGL6p++ova1hwbC
hs5Ky7dfQj6tkVosOvyLolQoasM5Txpm1MnRrIGd9Rmq5T3HIowd2Lv5R/OqCQ4h
bLXhQFvdaebPefwylRVXjJM7yt5zmL2nZYnrsqLYskE1aAvySkYSobWj6/ji2Cwo
fVLTh+Fd6FFbEiAhR33edwrIHEVXrYVOLophBUzajLVI6pWxuK7CjRKQ/m0cYt/e
Nukjzg4dnEryn0KhW5y287yfEsHBz4j7xVelBPEocMK4XzTmG2ac/yk+R/WakDmx
Lv8s8vS6PtwN9j0WJWpfvFYmVQmRqR32Lx+iX4sTOocOeZBx5PE=
=QnyR
-----END PGP SIGNATURE-----

--dIGJDLVl58ggahuo--

