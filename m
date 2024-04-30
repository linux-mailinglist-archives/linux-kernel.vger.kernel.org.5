Return-Path: <linux-kernel+bounces-164414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BA8B7D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB11C233B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724A17994C;
	Tue, 30 Apr 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDZB5/SZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BE12C7FA;
	Tue, 30 Apr 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495559; cv=none; b=QJq+NciT2WUxf2P9vSUT/VtNAcQwpzEg8iCi3AsSS8V5U5HJajo0+oqBylYHI4L0tLwXe56C0QlfD/FBT+6Vk06DP74jh8QoEQV3WkJnUJtLavz/NxXcNiXkXUbqiLhd1i90K6YirpQ9pNqe1sERmcGQYBuvXuYbdhnZ0CMQZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495559; c=relaxed/simple;
	bh=whThbLhJehj+vJNYPrBx5LJzg4oR+50VDinWzCi1mqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSUJE+cJg5e4v7i9lxxqnsNiLauFgAJHRzQRa3QWVGmNyqw1dVsfwFJIHxGOIe4sNJDpnIbu+aHMmmQTZzH5OoUgmkzHGe3BOROJqHo9JJgwfZIp6LXGUDH5Z0JMzE9aGcZ3SG6L9MqycTPyQvR96KRFJA8Y/KSF4nZt1i0E/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDZB5/SZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3499C2BBFC;
	Tue, 30 Apr 2024 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714495559;
	bh=whThbLhJehj+vJNYPrBx5LJzg4oR+50VDinWzCi1mqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDZB5/SZztKxmERhUPcSdf1UFRBYXi9yrsi9ztHk2+oInXHVuo1nEkH8wrkEiEN30
	 sZDX28sBq6mApRl1UhIQ5ktRacHF+nBMqejBlRF6rQndLFC9871R1BgZ9zj+yrboZi
	 mQNhRH76IsvQPxqrr23GkbaL0/V0skmgZgn3ZPqP84ial5OI4872YMlEOYfnz5jJ7H
	 JtSqfdu+kB3T/DfJqgNRST1HYcx1A6dnH3sbn8vzKNNnutO0BwARW8HNEqswm+OPbm
	 KsAYQBbyejfPCUStHbDh1PzeTsKNLcmBcy15fPBJx0gF1R48XMoeJ0RdxDbYclCECn
	 c3H5EWX3+pdqQ==
Date: Tue, 30 Apr 2024 17:45:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
Message-ID: <20240430-booth-spinster-bf59f780f10a@spud>
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
 <ZjEQKqkWA66HtiD4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMltWNAOmxMHJ1q9"
Content-Disposition: inline
In-Reply-To: <ZjEQKqkWA66HtiD4@smile.fi.intel.com>


--rMltWNAOmxMHJ1q9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 06:37:14PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 30, 2024 at 05:27:17PM +0200, Petar Stoykov wrote:
> > From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 2001
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > Date: Mon, 29 Apr 2024 16:41:30 +0200
> > Subject: [PATCH 0/3] Add support for Sensirion SDP500
> >=20
> > This patch series
>=20
> It's not. I mean from the email chaining perspective. Have you forgotten
> to add --thread to git format-patch?
>=20
> Also, what is that in above?

Looks more like patches pasted into gmail or w/e, rather than sent with
git send-email.

--rMltWNAOmxMHJ1q9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEgQgAKCRB4tDGHoIJi
0p1JAP9nApeDk2wwuTo+HfdptPW9V/ztL01XegpGhD8dVbxn7gEAz6TDsELkSn12
suoTxHy6QW5v3r4oBt40mdnn+Rzkngo=
=RMsK
-----END PGP SIGNATURE-----

--rMltWNAOmxMHJ1q9--

