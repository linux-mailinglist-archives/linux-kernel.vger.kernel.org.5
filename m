Return-Path: <linux-kernel+bounces-135335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F989BF29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9941F22198
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B56E61B;
	Mon,  8 Apr 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADo9i2gD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F06CDA9;
	Mon,  8 Apr 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580097; cv=none; b=SCq7Nhph9ArEiSBi2KYxWVLdVQbrFX7mttVUFG5YOnXqTGLeLB9gIGMlptWT4Mjs1mevPz3rzelZKuoor0VWuwHK1u8rYXZiKVYRSRLcUuGDcw/UfffxrZ1lobOsv86PbbRMJpso657J1KC6sifeHp0jAg2h5vMNw3gWk2RxZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580097; c=relaxed/simple;
	bh=84XOeCfBTbfAfttwzGK3yMdnjmXgpOzlJpVU1/u2iwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfoRikhNE4F1iKoGclla1rACLuXm3UdRbiVfZNFDKH5atux2oUNu/wGmbonjL3mgEHv1kXkVfzNYXVhY0Edk7XDojhuwCahAWRDaTMlERl1VheChChizO/koQHgpfIs+Dw3iBJ16pFEEg+VKTl8OmrEEB4QlWeFJrbHRIySht/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADo9i2gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02028C433F1;
	Mon,  8 Apr 2024 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580097;
	bh=84XOeCfBTbfAfttwzGK3yMdnjmXgpOzlJpVU1/u2iwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADo9i2gDRMK9fGFxuyRBtekoT/HW6XfvyyIBJPylgXOsjOWfer5glc+0FAA2Zgo9E
	 KVq/2M72ncIn1oUdL/jiMVMN9tBKRDlXwGJvcM3UQr9b7TQ/EPfhREtdae0SiATLxc
	 fhKNpEjk6++Z16otyBAZtL6H+O7a/k8SMDxKzttxkZdAptOzdTEGv1efESdTIyKnRz
	 CwI70XxMnDpOkrxYWlzxgaRRc02ZtfNbGW0siFvn3tvd1QI/U60LaZvHOnFdl4fmcT
	 Kr28iG7YF4YnfdfOWKZIdCEBDxGrsV2A/MwgcCMqSmZfQQDVtwZ0bzKNPI0WH57c0B
	 e7oi/a/9Coefw==
Date: Mon, 8 Apr 2024 13:41:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 1/4] regmap: Add regmap_read_bypassed()
Message-ID: <043a984a-db22-4216-96d9-1fefe4694d88@sirena.org.uk>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
 <20240408101803.43183-2-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zejkK65P6uQG8f5B"
Content-Disposition: inline
In-Reply-To: <20240408101803.43183-2-rf@opensource.cirrus.com>
X-Cookie: Drive defensively.  Buy a tank.


--zejkK65P6uQG8f5B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 11:18:00AM +0100, Richard Fitzgerald wrote:

> I have a kunit test case for this. But it's based on top of a chain of
> other changes I've made to the regmap kunit test, so I'll send it with
> that chain.

The usual term is series or patch series...

--zejkK65P6uQG8f5B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT5fwACgkQJNaLcl1U
h9Bd2gf/aVxNn0Us1Z5jnN3TVYqcd+LL0xVE5/jlXAQJmUIqyWBzWxzmqMTFHfaR
CfWnsK6kciVGQdEfKJaWxWt0Xa4ouBC6N7k9AnUCtHVHe9ag6FMWaTOZAFPhczSi
5hk6zPZOjdiZk9NRBUB5SkLX195zJtMpu92HOOvgb/EjahoI/Gqt0vHPag27rsgv
5VnvTW3+HGkayPRoUVWCXgcm9A+SIpXMbS6sCYpA/1hHjUIa3UMd1R/ssoRuDjnR
CagEvIqMNUS4JovbB8KKdaUsEyDfqjQfXXp5k0w24if+sCPXrbDwLBpYuZqs0pnu
RrrfGlBL0NOgULLw3YOh3ZhTw2ADKw==
=SuRZ
-----END PGP SIGNATURE-----

--zejkK65P6uQG8f5B--

