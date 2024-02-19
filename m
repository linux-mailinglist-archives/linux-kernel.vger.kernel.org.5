Return-Path: <linux-kernel+bounces-71528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00F85A6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6721C20C27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962183839B;
	Mon, 19 Feb 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Irf7rv7D"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52438398
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354663; cv=none; b=DcF4QZApHQRfse9wGUWZtpTWre4MuQ4xDCO5R9Ehly9uExyRFEl+ib9Ug9XWZJd27uwFJyz0frhBIb9s1mM8+v3D5eSiItHPILkbrU0kJg/UHpRnZAC3clpsslX0cCzMVY07fo+ySvpbMxYpGmg0/0/NgaZkaZbxzHuW6fkbNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354663; c=relaxed/simple;
	bh=cgIJomylKJmw1MjPahqQrgtPvISDy/ZNJJQgBbz/i+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkCqpAV9eVOdRGpPlYlpRp6pY+pcrzuvwjwMDinxGwGjRCt4FgENM4hAp43d7b6JNu3X4D6WUjXQayq9PVRi/jY+Re919x2pktepuiQmgx/s7/ZqanQ175G4Q3KGA0m0qp49BRZf8vuVcbRwG35SeuXo5mv+S1y9qQhh0Y6qHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Irf7rv7D; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cgIJ
	omylKJmw1MjPahqQrgtPvISDy/ZNJJQgBbz/i+g=; b=Irf7rv7DGWTeVhnh58gs
	nDHu/72YLxcaxh3jcyJDDvY14atEo23pSGsuUlfksCmP9NC5zho0POTQO5gkiX25
	MNoJIHXNus4yf2jXBY7kPJV5vd7kLcE04CcvWLrcWKLVk/GmlwRl/dIWus141Dni
	Fhla/bxt9qEFQov4i9YBdmTtSQ7LgxMVvEBf6vjiX9FpGq6dbmlpJfTAbt/wQiT2
	wWVdIbdMaK/i+dfoiR3VDLyzaXOq8yjLTP5at3ClTm08lJ7CIOfZHUJ+c4XBD3m3
	yCoHTKNoz2sxND2aEOHPH4CHGNJ8RcsD4AX7X69Z/agZusfHBK2Wn2MKcxnpvH4/
	Fw==
Received: (qmail 2952058 invoked from network); 19 Feb 2024 15:57:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Feb 2024 15:57:31 +0100
X-UD-Smtp-Session: l3s3148p1@+rAlUL0R6q0ujnsZ
Date: Mon, 19 Feb 2024 15:57:31 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4M
 support
Message-ID: <ZdNsW4T5W1UnUdns@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <263d6626fd4fa51b175b5c7a53e6a363e2c91519.1708354280.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzv5DsbBMYz4I71I"
Content-Disposition: inline
In-Reply-To: <263d6626fd4fa51b175b5c7a53e6a363e2c91519.1708354280.git.geert+renesas@glider.be>


--hzv5DsbBMYz4I71I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 03:52:19PM +0100, Geert Uytterhoeven wrote:
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--hzv5DsbBMYz4I71I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXTbFYACgkQFA3kzBSg
KbZjPA//XSt9MiUijbg7tWB9z9bJAM7+4eH+4aR0U1kfcGkzsilox+wS+V8ji+YJ
WXwbLcVwbQoqkZdTBgvxenPH0IoZ+kLZTlxzaR+1NEh53qcyXSdUg81FLZI70sLy
a6UB/WPkNETRlCiDPFFTI9qhah1eXUVk4J0Oo1Z8BGW3T+IdRJPsPkVHlPiQfvnP
Wu14/hreGS9tuy9g4X2o+hqWfyT5jgM1ynQ8vUBOm0HCtuDR9XjMn+w68qOOK0KL
4fII6rxq2KLISvDSugwL42tIyBImlxbI/9d+cn2LJJOELoduJyQaaDJ1ww+jviHh
P8h443iAEoOXH+Nm+VpQCGV61Je9zLG4M4JpoN9WjaakmOYXPD9ZamEk8f8dYhtI
fIGp/Zr+9vm6n/POVt0VOQzcnMfsdtYRdBvN1WBmV8caW3dwFYSlpVbtnzPenxM0
lrbmb4uOG030kizxWFOZv63grqj+S+3/N3xGi4k2PFTs43kK18p10sOxyMXz6UXa
1FWKW5zfCg0MNI6KkGaTmOdoGKZDZ+q62V1Uoz9DQZV9XA73odudfIXZLRVJZgV+
wk6LGrWW9PHH4fCp2L+AhtsuHL13d5pc250aXuF6dKbuV1GZ1uV3TvuavtUjYveW
xRSROxUOUFrlj/z6wHo/QQkTUWAR6U6MTGMw9LGlBlngbLIfz0c=
=JKAo
-----END PGP SIGNATURE-----

--hzv5DsbBMYz4I71I--

