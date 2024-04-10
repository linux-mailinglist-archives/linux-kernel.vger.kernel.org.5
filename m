Return-Path: <linux-kernel+bounces-139144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46689FF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30E31F25E17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF372180A8D;
	Wed, 10 Apr 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcuTXzk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225017F36C;
	Wed, 10 Apr 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771273; cv=none; b=atOwB/tmtVZdt0wLE+E2+DBIfYwjEhE/QCnDhC01n+7ufundYp5QHYYkKh79p7gFbhHHCDEifhCi3nAnrmCsE5/T3Ygl/OHwwQJND3vmmM1mXelSACix1i1AORek6lyeAUwEShDglstxJ493RpIhbjG4e312hEKXBIxaZsQxg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771273; c=relaxed/simple;
	bh=pNdVV+75knRysY/hsbPP+XHfRDHsUixHnqw79Bm+MJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fki/s2Elav4syeR4KRyQDMU9iEo0oRhFR8XWaTzfPpSMvvqBn0fsQy52ZM+NdLL50TT0yxaCOw4XAF7aFNwlKN25D/hQQcMFH7e9eClXWIReG+lk1LT9RQx5mAS9Fj8hJbs4ItFQieGmUO0IsPwToK+Qgiu2YGM7490QjqWkNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcuTXzk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67380C43390;
	Wed, 10 Apr 2024 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771272;
	bh=pNdVV+75knRysY/hsbPP+XHfRDHsUixHnqw79Bm+MJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcuTXzk53QUv7yzxQgNLs8gWhhaYa0uriJUCeSVQtqw6mAoCBhBJCRCQ813RW7yOa
	 G/A4BFnhcyaBPo85GH+dG1M68uthtslSG98P1N2Nc9JHlx9Ghx0GcNvFk8shiY8x1k
	 xj28oMM+bwIRG7a9Y8Ma9yJp+KNhV/0sngACWI3ic0NBEenfj0NcPdNmcq7AsGO5rx
	 fad2XgJIrglXpQSNAUUFZAL2ycKo0V5v7qrKU47d9TAXYbWcz+26KqHjQtBDCnx+r0
	 0hnBXaOomLjCdk7tUNinnoZIDw4YPasz8ioAfomQKzpPjuuZeBcyJw58a5EzY1tisd
	 O49kIRRxgMIdg==
Date: Wed, 10 Apr 2024 18:47:46 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5 support
Message-ID: <48b302d4-a835-41fe-aa22-2b79ea01c7a4@sirena.org.uk>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MxtsBf7T/9C7oqKy"
Content-Disposition: inline
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
X-Cookie: Join the march to save individuality!


--MxtsBf7T/9C7oqKy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:29:03AM +0200, Th=E9o Lebrun wrote:

> V1 cover letter [5] contains a brief summary of what gets added.

Please make your cover letters stand alone things, things like a basic
description of the contents of the series should just be included
directly.

--MxtsBf7T/9C7oqKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYW0MEACgkQJNaLcl1U
h9AIJwgAgF4+CxnKc6DP5yCGYWySSpmbeaIK2XNWOU0gi97h3kWAqzcL5bIaOQzW
2YqOg18yh4oGytWwAMsFSVscj0YDyQD7A/MsP0A5d1eZ4KAu9u5RN5oNdZO3gL2v
ojkHdR2ygMlBTVXUv098a9LO6V6LEt8edAF4hlgARNgZlFuyAovIMTsDVqR2QTWm
82UII45YVBKaCWGOz44LrAWVwyQT6hJ4n88+mURXe/AJw43XdkWryfYvzcRA+LTH
VfLT3c65h9HOGdPHz77e7gHd2khnyozRvQDfpjMfLeoMS7Ij7aqurcMtoQFy5e7t
TqmjAWnojFy3DVG7dyMbSjFcOnTOTw==
=1tM3
-----END PGP SIGNATURE-----

--MxtsBf7T/9C7oqKy--

