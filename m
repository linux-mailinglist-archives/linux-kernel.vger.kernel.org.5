Return-Path: <linux-kernel+bounces-83269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5686910E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20094B2790D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB713AA28;
	Tue, 27 Feb 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUo8ltF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF213329D;
	Tue, 27 Feb 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038617; cv=none; b=bU7XTQcByWv+ouL3ZaEvbjhuBUPgrOQeJ5J5TdrhHO0KoF7HfTYKanb7ojXc9Er7IGPtWFWYR6YZPjZOZNdr8J+mV429NvqhWwKN44mH1wqWJPEZwsugWuobgOC4bSdZ6anHMQhZJRFtwv5Lnhuhm9akx9Q28CB5eXKYgZnHyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038617; c=relaxed/simple;
	bh=apcxIyzn0k7+m12GtqffHekIeQvQq1MA8T3i+VB34z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSxG86yxnHHAbvrWs6AOLRHloMFs32kPHfNrIbouDk0RxNN0T4duDwnlqwLl8g8sc5u2zHBIp2tPbwwr5pnZjzF5b2pmSzGBHBODQk/uvgx6XfU5Z0HfeSz5jtGfc2B+vs8hqBIzi6seznrrA7BNwNJCwXJuaxAG5h0Lz0/NqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUo8ltF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF135C433F1;
	Tue, 27 Feb 2024 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709038616;
	bh=apcxIyzn0k7+m12GtqffHekIeQvQq1MA8T3i+VB34z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUo8ltF1j64VnsC26KES1wChaS26QqTrp61YOIGHMHhZxScak6IKV2RWQtzoE9thm
	 kLXSfT0/G8rTwU1OGzTfZhdeJ2kxVLGwY7UTk8pVm40tqNJNRAyLTyngpiI0LuGwq+
	 j03DRUz1EX7GleuhrOf/TcJfotZV3wxhg5aJsI+MPf1FH+r7bkObaWPqM9GDccXHaj
	 h+UoVYaTSp2WsYWtz/srtLi74k+AEmimwGvMoClPv5LjCq+ub6867ZfXXNsYHrnjLU
	 bosIgaCA/FmPW04D7tnxCX2iEe/OImYWqYH7uS+ReWNffJzwOSJ6f5oW81VVmVcj5J
	 J5SPOWmsZH8qA==
Date: Tue, 27 Feb 2024 12:56:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier =?iso-8859-1?Q?Garc=EDa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert the Imagination Technologies SPDIF Input
 Controllerto DT schema.
Message-ID: <4b4b4eb8-a160-455f-a787-156d3c933306@sirena.org.uk>
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h+L9bvOLfgbqbaMj"
Content-Disposition: inline
In-Reply-To: <20240227123602.258190-1-javier.garcia.ta@udima.es>
X-Cookie: Please go away.


--h+L9bvOLfgbqbaMj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:35:55PM +0100, Javier Garc=EDa wrote:
> Convert the Imagination Technologies SPDIF Input Controllerto DT schema.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.

> +title: Imagination Technologies SPDIF Input Controller

> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

I'm not sure they'd agree with that...

--h+L9bvOLfgbqbaMj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd3BMACgkQJNaLcl1U
h9BFeAf9F2UrHSUmj5HdrZl50lIgzVj+ydziDWHATv5g06rwiGkOPZBpBwwwPZLn
AamwLnKbU2jaHXzVfkcpjdsjUHmPVOyZyAY5VKClzx8x/cjQJa+kMyb4HOjfudpy
adLQrz6l+Vv2N+y49R05UImy+r6NNiYvO6zTyUu/Nxi6efggwqZJ1iWSpC7fU5wd
HWZ/K0wgvc26vGsy5biTtR2L8MQY+qEEh1Rx3rnG+jUuLWt6K51BobL88b1GyV+b
gX7BF5vj9Ekj47UtSK4rtqV1BvZeERgmGKjiEgnR3PNXe0yGqMOheKNvvGyI9SuK
qh7Nc6dNcdzCJmtEM1K5tH8BonlyoQ==
=lxob
-----END PGP SIGNATURE-----

--h+L9bvOLfgbqbaMj--

