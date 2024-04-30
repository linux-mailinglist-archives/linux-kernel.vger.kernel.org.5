Return-Path: <linux-kernel+bounces-164502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EB8B7E55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3631F22F12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3417BB19;
	Tue, 30 Apr 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZCBhL1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047017B4F7;
	Tue, 30 Apr 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497668; cv=none; b=Dci5bDPFTjdgJV8odzoBTuZTpfjlOkCLcC6OWj6o5Sopva9YQTxvIhsbB1FZfuih3sG0eFgawFQSd5n/8ioeW2OaP7ygcQgmKVaAnvcZBxgj2yWTHZ82k1jZcwVB9hxxwdbFVhi0UOtquNnA4ResWEhc43c3zDIj2NsRke/8J9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497668; c=relaxed/simple;
	bh=WBWYFzFqdOvu2TvD7AsjXQVL81Xq44GKfndV58CUBao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HevySdJsdoUAIR+uYzHJ67p2P3cKHEVTZExkt3rHwTWPLNH+8jQx0nJPz9WyBFoSr6zXLk9g1weFRYh318fvypFVnzhPBbXtaOSJFEvLTluWBOLX4ANR84d56LOpOLzZTjrT57Pf3RXAgZglXtRu+ntLvnjZaK2+O6uuaI6iRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZCBhL1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20069C2BBFC;
	Tue, 30 Apr 2024 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497667;
	bh=WBWYFzFqdOvu2TvD7AsjXQVL81Xq44GKfndV58CUBao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZCBhL1BOXlLkZMjKALy9Z1yO3OyOEdBSHpe7McR1ZS0BsorzFKd/hPzHbn4etIgY
	 +5plPMYLvBXSlg5pH3/V0wsm3OOo9tmG/12pA/TuWAwoGwakPqvr94J8T7xMxzYAf1
	 F9WfbF1RNilMwQ9ipk5waknJ0eSAq19vfeGQvi5ONt8j1fSfEdqxi/uunslUAwZ/dM
	 mBNnDsAG2phbLX3ucmPeAS+FLJ7u7ggTO73iiIFP58btQII5mQEJYXVQtbdPqUEMYP
	 6IDJlgUygWHT0K4xstK8koiL+ZEkX8bWeuSiJcXYkpFwk9s79sNBZbBfM9ubckGQQ+
	 HQoqSCqo8PooA==
Date: Tue, 30 Apr 2024 18:21:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240430-winnings-wrongness-32328ccfe3b5@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-6-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/OFAIs/FPFUuexLI"
Content-Disposition: inline
In-Reply-To: <20240430162946.589423-6-alisa.roman@analog.com>


--/OFAIs/FPFUuexLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
> +      diff-channels:
> +        description:
> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> +          appropriate value from 1 to 16.
> +        items:
> +          minimum: 1
> +          maximum: 16
> +
> +      single-channel:
> +        description:
> +          Positive input can be connected to pins AIN1 to AIN16 by choosing the
> +          appropriate value from 1 to 16. Negative input is connected to AINCOM.
> +        items:
> +          minimum: 1
> +          maximum: 16

Up to 16 differential channels and 16 single-ended channels, but only 16
pins? Would the number of differential channels not max out at 8?

--/OFAIs/FPFUuexLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEofAAKCRB4tDGHoIJi
0qLmAP0QGbVIcmLkp0VD56j2KCS9uFbCschdqFg8hKbeNQZEBgD/ce4phSgV8r90
d/yEM5OLPAtXnNIJd1nwpvkn3yIwiAI=
=xXA6
-----END PGP SIGNATURE-----

--/OFAIs/FPFUuexLI--

