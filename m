Return-Path: <linux-kernel+bounces-96000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4DA8755E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40278B24D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B213175D;
	Thu,  7 Mar 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXwa0oFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BD130E3B;
	Thu,  7 Mar 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835187; cv=none; b=HUmjBshggF+++RqeYaZhZWVruHI/Eg4UBQSgJxSwXYsao7Zdff96t6oLlwcjHmGi6hQAVeEzCcxgi3gqxjKZhz8ZOoNErCwYEU62A0SKsB3/yfnLYyymeR0+9Y2kvInaVg3BJSWc3pbRIakpn8ZJO5F9w2GitXCu5zeuxrLBl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835187; c=relaxed/simple;
	bh=+mH2SovcBEzHJHWEO7SiXBBwLhLmYEC4pbWntEgMBDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOjPQJtahQVSUGvXo0cO2C5arxSm2Z2e67q1MXs7HeJ/FOekOATOx11E4naAJC/OsbXrFCW9eUqpKIW95cZemTXlOX+I/EFCAIlq2/++0EleKYcHJath4Jz5XCgHde+pQYRHQEA0euGZiNUdBmHjxcJsUYm2NnWy9LMEodFoewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXwa0oFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CABCC433F1;
	Thu,  7 Mar 2024 18:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709835187;
	bh=+mH2SovcBEzHJHWEO7SiXBBwLhLmYEC4pbWntEgMBDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXwa0oFED9KNaz+rvH5y4FDTh6+MClV0L5JSrc4FDIi71Kw6/ohUhLjjPvojbl12u
	 qF//QfwyAQlcPQ1IJD9U5zl7KQH3IjFbJH9Y8HaZkceHgcIyZ+Op9hIcYkKLO5wHLu
	 d4FMYrCUyAesy+CIjfYf6WXFRzNx2qwYGjVTco21YveY0n8f14i6eRxi+vCE6psCsT
	 pEtS/3NUdDNPIWVQW/s1Vk6RiMvFQXBuGo5PZ85G+eeadWSKw0s/lyFrM8W9Il7a+L
	 jU1+tE30OhvsFhXba8DKHdXHkUcA3Ourm8dJDFpt05vqYzcKukkqJPWICgpxLm4BCJ
	 NTD2x+2CcijUQ==
Date: Thu, 7 Mar 2024 18:13:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Message-ID: <20240307-thread-trailing-e42a41a0e4f1@spud>
References: <20240307113325.3800181-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABrBZXC8QoK3sTMd"
Content-Disposition: inline
In-Reply-To: <20240307113325.3800181-1-naresh.solanki@9elements.com>


--ABrBZXC8QoK3sTMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 05:03:24PM +0530, Naresh Solanki wrote:
> tda38640 has a single regulator output along with CAT_FAULT# pin to
> report internal events. Hence add properties for regulator & interrupt.
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

thanks,
Conor.

--ABrBZXC8QoK3sTMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoDrgAKCRB4tDGHoIJi
0kaWAQD+KpxaR8EsxKPZT8mJp8ZKc8aj02SJDlkmZUY7chg5YwD/Vo8Bas42xryP
lFzp0PimZXmDzF0uN3vKX7nKA985GwA=
=o9EQ
-----END PGP SIGNATURE-----

--ABrBZXC8QoK3sTMd--

