Return-Path: <linux-kernel+bounces-94435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC215873FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D61C22DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412E65B5A3;
	Wed,  6 Mar 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeeSyNqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A844136647;
	Wed,  6 Mar 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750334; cv=none; b=E7lntxn6rVlV2gPbOY0NWt/UMbgjGZiB8hKMFNh5J3UjzCX9DP4VtUBgvbV9q4JX6sAiNBwXtqDqPYqKSBfqqP39Dkl6LcDI6PSqFaKKqjzwmpgTtl8N+GP7qSGuOw+eXSuFsP/WPSCIBZvq1G/RgmitRJAGFIn/XKE1fvpFGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750334; c=relaxed/simple;
	bh=kfD++rq2txCqw0jAqPOlnxNi2nkm6gneXpkvEXoxrAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnNbbcJ/7Rl8lLgRHIkD8NQ2yXps+hA7ns3DbD0WskQos5H/KwwwnqBwmRgDXdwk9b8fz6jxZc0HGms26jdUupZ43yOh5etzEYTQG2A8QJlh1/1ka3UGh4BDrMOUt+AUMN5RtMs8apuaWf1t10sfJgJO/u0ZBMe+pVsHMnY0g9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeeSyNqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D09C433C7;
	Wed,  6 Mar 2024 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709750334;
	bh=kfD++rq2txCqw0jAqPOlnxNi2nkm6gneXpkvEXoxrAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeeSyNqIsZglrPShzoRXGvqrWjYwNXuGG1XNHIihnHSQrAyhxRQifxYQ04SGBjMJ/
	 JT8vOv/gtDAuOEXIlYAHCWww9liyp9lTK5oB0rRZyfcWAoikCchzzAiVnznaKKptPi
	 u/WNUiXTeVcTkmif7yMA91ZNU0VSx1s7W+SQrtIgKy9irffjompJHfcgRhvieOAYKX
	 xfh717jwh3mm7uKEryTx8BZbEaRpWyGC2Bt8VJv2DD0Zt09uzdg9OKjDhePfO4OITw
	 NT+B9Yo70X+MZmSBHaprCUrw7YkPpmmJ9TzS7CLPkx9wskL8oqFnbbREX6b8Mbv9Un
	 rrjUEJHKk2Qww==
Date: Wed, 6 Mar 2024 18:38:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Message-ID: <20240306-decay-overbid-9c8ea43a511f@spud>
References: <20240305210747.1377506-1-naresh.solanki@9elements.com>
 <a32a2655-7561-4339-8521-bc2558e0bdb1@linaro.org>
 <CABqG17hYK8MFMPVNXxZ6JT4TW00PPt48q1qZBzS=gJrpC--iTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u0h1zxd+rTjHEzzW"
Content-Disposition: inline
In-Reply-To: <CABqG17hYK8MFMPVNXxZ6JT4TW00PPt48q1qZBzS=gJrpC--iTg@mail.gmail.com>


--u0h1zxd+rTjHEzzW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 03:20:02PM +0530, Naresh Solanki wrote:
> Hi Krzysztof,
>=20
>=20
> On Wed, 6 Mar 2024 at 12:44, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 05/03/2024 22:07, Naresh Solanki wrote:
> > > Add properties for interrupt & regulator.
> > > Also update example.
> >
> > Nothing improved.
> Yes, Just aligned the regulator node name in this revision.
> I missed aligning the commit message.
>=20
> I'll fix in next revision & update commit message as:
>=20
> tda38640 has a single regulator output along with
> CAT_FAULT# pin to report internal events.
> Hence add properties for regulator & interrupt.
>=20
> Let me know if any others changes needed.

That should be fine - but your line wrapping is really odd, you can make
use of 72 characters but you are wrapping at ~50.

--u0h1zxd+rTjHEzzW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei4OQAKCRB4tDGHoIJi
0n7jAPwKvQrBfrsUxvl2QTr+YD0ug4izORhvnuT6N4E35d1oSgEA/er1Kl9fPvAI
sOVclw+5IBXV2BxhdiWTX9cqMzrM2gY=
=F0UV
-----END PGP SIGNATURE-----

--u0h1zxd+rTjHEzzW--

