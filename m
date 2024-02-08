Return-Path: <linux-kernel+bounces-58495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E455684E720
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BAD28240F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5282D76;
	Thu,  8 Feb 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+QkjLQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717191E485;
	Thu,  8 Feb 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414656; cv=none; b=O7t7Fxdu76f4y+dqX8Og0WepFIC1bj64PQaagSWsevLemi0QBX+8suOSpG63tLja30S8wSMgkfNYcGOouK9ALrcHFOoF7D+bK1uv1/yy/SqwN8NHJLDuU7WpXwFeYpX3x55fjN8Tha+nsKUo71cvSzHwjmdluqRniGPujXwQ/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414656; c=relaxed/simple;
	bh=+kEDfdlv9XNinweS4v3itMbR6S6QdBtObRcyi3RJV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRvzwHgRLcAYSizmRVUi2hK7oG1Y9OuF2aUycnepLUX1lZtW1gLsXTf0pnE02/r6pf3wmIryU8UUO3u3qsdy0CRB+EPS+J0cGYDEkEUlT4Mghd2LvudX6RCKbrgphsZcSZ/A4V+yFkXL29eHKZzPgn8RB666RxkBvgsuS1ukP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+QkjLQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE12C433F1;
	Thu,  8 Feb 2024 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707414656;
	bh=+kEDfdlv9XNinweS4v3itMbR6S6QdBtObRcyi3RJV+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+QkjLQ5l+xp708zUy2GTPrTWpyTLmW6ZkNxjRZRncAG5/0PEoCEexd5W+Mj0PTku
	 adXmiiSZZgo+bWBZE8RiWHfMaEEuzIlxudG31+op9LMwwyvY9IJdvt68HNcF2KGL2b
	 S11nTfBlBDLKPS4fEC2ZwZptUtfSpv1+mzYwS7lwf5mTsZQYLeDSJX61nfgAp3mfum
	 dUJKN05LpRHrweWB5N/98/+VVG/w+fyoDgjoMd4W3LZoL5SHbvQTgJpe0vV5sNL+Do
	 C/M/LbfPtZ3td4uYUIKSg9dUg0+m/f+3DRKiBqvOz+j5g1mOCo0krSi/3dJHUtgfPr
	 uh3mjBjk43PKA==
Date: Thu, 8 Feb 2024 17:50:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <20240208-chute-bacteria-75425bd34dc9@spud>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
 <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FlNSfptlnrt2zUyd"
Content-Disposition: inline
In-Reply-To: <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>


--FlNSfptlnrt2zUyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 06:58:57PM +0200, Andy Shevchenko wrote:
> Add initial device tree documentation for Maxim MAX6958/6959.

Why "initial"? Are there elements this display that you've not
documented yet?=20

> +title: MAX6958/6959 7-segment LED display controller with keyscan

> +properties:
> +  compatible:
> +    const: maxim,max6959

Where's the max6958's compatible? I don't see it in your driver either.
It seems that the max6959 has some interrupt capabilities that are not
available on the max6958, so a dedicated compatible seems suitable to
me.


Cheers,
Conor.

--FlNSfptlnrt2zUyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUUewAKCRB4tDGHoIJi
0n2pAPwI2dXVgeT2w9eJ8Mx8aPl+Sfz7Ni3EVvM/VZ5G9VRSmAEAwijosMmSBHzh
rwVD8fmHHxZDKjGRCUw7Y2qo3JeTGgU=
=rCYS
-----END PGP SIGNATURE-----

--FlNSfptlnrt2zUyd--

