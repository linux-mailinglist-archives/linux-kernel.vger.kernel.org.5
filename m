Return-Path: <linux-kernel+bounces-165594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289C8B8E59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A3D281224
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D748DF51;
	Wed,  1 May 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBgqQCku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5D8F6D;
	Wed,  1 May 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581549; cv=none; b=eyDZisopgsXrslBioFTEfDVQQisXm6roHbAkas1sU5SEe0aV4E19ySJGWmnR0v4TbcdvHwz+kWkSDz+K3CXeuRM1DlqBq3wHHAmi9N4a99OFxUtDHNhzV95AStWklDFa0oK7j977mIR5/nKIkN727XCmDi02NEdXjfYALNFZM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581549; c=relaxed/simple;
	bh=k/GVusRHOyex5CyvjGxaO6gyf6xeCU6g2W+wW2wckwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnQRt92ckJUFhUczhj4drjjvoeaQaiNiPUuFh16JFvMCXgsH2C8FV8rU+yIVQAdCsPySUGfPgttG6fLeC/yX43hfK3WO04sFvB4/CqCxMi4F8OZHL5oaMALhOLjXcc7pl8kf+EYX/Z6Tv3pk1l3RShgsyncD14+guMGkrL5uV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBgqQCku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305EFC4AF14;
	Wed,  1 May 2024 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714581548;
	bh=k/GVusRHOyex5CyvjGxaO6gyf6xeCU6g2W+wW2wckwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBgqQCkuMQ4/OQ71Ase8a78abZi33+i2C/O015Xi+/9hau7DSWR4iT3ARSSNbz1Sk
	 NX6VmtQv5iekEMK64mVICEsALTaBNAw+Q0mWgqf/XKhsiX70PCH3ix2AfYwpPyueuP
	 OZFKhZeMC+Jnf/UalQwesiIWj2e5ksM4d7Muz1m0RmQMr3TD47QhoCKVYoNr2lZ/xH
	 SlNV4MlC7Yze1wmxttwxcKHpuEIeiXg5l9DnFcRll8wdxxkEwsKgDIeJj28bc060DR
	 CbXhSoTWMILzORQMkxHmASm5JnD81UPD8vWUsot2EWE8hSb2zUUqtcW7NDzrZF7L4t
	 EET7hpybIoGsw==
Date: Wed, 1 May 2024 17:39:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
Message-ID: <20240501-synthesis-repose-30563cffd41e@spud>
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
 <ZjEQKqkWA66HtiD4@smile.fi.intel.com>
 <20240430-booth-spinster-bf59f780f10a@spud>
 <CADFWO8FzQ8FgD5a2jKECaMRX65_1Nd6vsgh43bXqsSz52xtZKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8YvzeVVYX/1w9PwP"
Content-Disposition: inline
In-Reply-To: <CADFWO8FzQ8FgD5a2jKECaMRX65_1Nd6vsgh43bXqsSz52xtZKw@mail.gmail.com>


--8YvzeVVYX/1w9PwP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 12:47:32PM +0200, Petar Stoykov wrote:
> On Tue, Apr 30, 2024 at 6:46=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Apr 30, 2024 at 06:37:14PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 30, 2024 at 05:27:17PM +0200, Petar Stoykov wrote:
> > > > From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 2=
001
> > > > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > > > Date: Mon, 29 Apr 2024 16:41:30 +0200
> > > > Subject: [PATCH 0/3] Add support for Sensirion SDP500
> > > >
> > > > This patch series
> > >
> > > It's not. I mean from the email chaining perspective. Have you forgot=
ten
> > > to add --thread to git format-patch?
> > >
> > > Also, what is that in above?
> >
> > Looks more like patches pasted into gmail or w/e, rather than sent with
> > git send-email.
>=20
> For stupid reasons I can't use git send-email. I thought I will manage wi=
th
> using gmail alone. The thing at the start is a mess-up of copy paste inde=
ed.

As Konstantin pointed out, the b4 web submission endpoint is ideal for
this kind of scenario.

--8YvzeVVYX/1w9PwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJwJwAKCRB4tDGHoIJi
0g9UAP9+bM+S+0AcCnYdrAuYhmDG77Pyf38FkKki3tanp2jX4gD+LsKR2E9LjHk0
7dpTztDA6kRr+0D9uidJlnv1l3fgwAU=
=NZ84
-----END PGP SIGNATURE-----

--8YvzeVVYX/1w9PwP--

