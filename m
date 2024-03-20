Return-Path: <linux-kernel+bounces-109208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B00881630
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F0EB233D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB76A33F;
	Wed, 20 Mar 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjOUzHRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF9524B7;
	Wed, 20 Mar 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954665; cv=none; b=Mp2paL3fuYkeQEU4ZiI2P5Yj8v2swp336egOWPzwgQaS8vZBgKtdCk8D2c1kEPD2Xl9LdnXw/NWbgugBnufzXF7IU34zdDNYWzeuMepolW1vqMatmhBBcGQAM7f/iSXji5hetZDX5v1A3Wfi4Mhhk/1L+qu5uPRO5qAq1uasak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954665; c=relaxed/simple;
	bh=t8CRqEP0dKoimzLH4VBkhyKPm3MjY8JUsLWFCmT0B64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiQpaU/awaWWjpePEAhwT5VBMoEK07ZttXgz1i8Uo6lSIyXguG85RlvAkvKnRd4WuJzg0IAhjEonIUbULy9aN+ehO8KXybASZd/cJARws81veO74rsE7mrPU+PvkeuWKOpHJoKzRJi8vtwq+g6vnPapSaJc8UgRssXV59q6/c6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjOUzHRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB54BC43394;
	Wed, 20 Mar 2024 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954664;
	bh=t8CRqEP0dKoimzLH4VBkhyKPm3MjY8JUsLWFCmT0B64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjOUzHRGqnPI6bvK+TaaBh3eyJL76RN4Cex5y9L/SCTzwq7Chid2JgBPw6pVMAdqk
	 7aewmgpdK514n+4JF6aHy/09OQ8950ULaFHL2s7WkbJc4gkhjSs8scyFbj+aMzZdFi
	 tXBRjfVe/twgtZ4m6Ys5j+reo99w0Ad+5bH1z0zL1wNc0UNokTip5UgnNrP0ZP5kD4
	 V0GXMViqJChe3MEu0QyPM9EeJvPNIGi+PMLZpvPViF4QCHD37ujKERHZCTxid1gXG2
	 iD8yDFKE36OnRb7uhwvvIajpG0ncDL1oAikEkuk1wNp2qEimpe6uGjOch745Us6kiM
	 roXaZDHN5gWHg==
Date: Wed, 20 Mar 2024 17:11:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: lm87: convert to dtschema
Message-ID: <20240320-espionage-shrine-ed6a5ee04259@spud>
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
 <20240320-hwmon_yaml-v1-1-a349ca21ccab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llyvHfR3DnEXNxV9"
Content-Disposition: inline
In-Reply-To: <20240320-hwmon_yaml-v1-1-a349ca21ccab@gmail.com>


--llyvHfR3DnEXNxV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 06:04:57PM +0100, Javier Carrasco wrote:
> Convert existing bindings to dtschema to support validation.
>=20
> This is a straightforward conversion with no new properties.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--llyvHfR3DnEXNxV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsYpAAKCRB4tDGHoIJi
0jf/AQDehh8/jsAQ9Oniv/CHMVcLLI4/iLLzVGRj+1tdwGBDeQEAphqDoNDs4obW
eFppL+bwhypPAft3lBwfmtgH2GxS3Qs=
=EWMk
-----END PGP SIGNATURE-----

--llyvHfR3DnEXNxV9--

