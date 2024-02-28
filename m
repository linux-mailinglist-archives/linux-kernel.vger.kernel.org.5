Return-Path: <linux-kernel+bounces-84864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5482C86ACC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003461F22F29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0C12C535;
	Wed, 28 Feb 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G687O2cE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCA25624;
	Wed, 28 Feb 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118995; cv=none; b=NcOE+eL/tX0sPwKuEmAirSWgJQgp2SC2phdPOPyZyeKQ3cHlDWf8yFhu1NqSzYAVSje8uPzxexTHwnWU6qM04dsaUv8dnCf7xFWr/QqUdfu2pXjy2eau+zOJI0CI1k+6lkNjfg6gp21YbIGJbCb6zFdr5Vb90isU/NmgkoKooqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118995; c=relaxed/simple;
	bh=2BOEP3WVg6yAiJknU2Zv2AyuwWdxBqWBV3FP0Ovfe80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADbLRR44sx4AuHR4Tb25EZAN95LqtM/Q8cfdDGEfgyJgDWtainzCyYRL7ZOUtWF8dGh7YvQ+wpgKFgKD4JKxdW7yY6LsIDLit0LdsEY97qyNPGDVqE6E7Mu8vHxiYz2OOFVbcjZDHJzOdYAsaZb3VF8WN9hPuF4xveSr/PsKC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G687O2cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BDDC433C7;
	Wed, 28 Feb 2024 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709118995;
	bh=2BOEP3WVg6yAiJknU2Zv2AyuwWdxBqWBV3FP0Ovfe80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G687O2cEV14E2jPJ1Ta9LlkuY9wcTTeLyoxD6HVQoMhDPPX6fNPag8bOAWGOmqPLp
	 y8jzzdCSag/ZchYeVV2R/bgDF9n9zDdfAC4+9lV4C1MdDTcrZccKkNIRPHNqIAqP0s
	 8lelWvs6K+7TefnnfQkrJkb5GqhF6bIAy8x9nNGisJyQe8FhS/JJCrOqwfZma1K0lc
	 1Pp2BZxUwDSSS5PrsRkaWuRTLboedkyDAA3iU+gi8zocsdvfCN7ZOJk55qBu/HlLFS
	 tUgmGjXDB9G+mr0SGRDoptgzXn8ZelAhr592rc6xg8ujuy27ycul9OoVsEY81BwKGz
	 fsyk3NpwsIoOg==
Date: Wed, 28 Feb 2024 11:16:29 +0000
From: Conor Dooley <conor@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas
 RZ/V2H(P) System Controller
Message-ID: <20240228-suds-gradation-bbaa44b1038c@spud>
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8e4e05f9-5bd1-4f31-a2ae-fc1567405c11@linaro.org>
 <CA+V-a8vSCif-JXGFtn9k-JRBsV3sKH4YoGJzQbum0DV1JS5hmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dGN/zjYuo5Wz6S60"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vSCif-JXGFtn9k-JRBsV3sKH4YoGJzQbum0DV1JS5hmg@mail.gmail.com>


--dGN/zjYuo5Wz6S60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 09:43:22AM +0000, Lad, Prabhakar wrote:

> Sure I will add "|". On that note some bindings have "|+" and some "|"
> what is the preferred one?

I don't think the + should be used anywhere, it preserves all newlines
at the end of a block of test. Maybe there's some specific instances,
but in general I don't see a reason to use it.

--dGN/zjYuo5Wz6S60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8WDQAKCRB4tDGHoIJi
0oODAQDvqH1UidBbb/nnLMIxRaduWzMfpRH/a2BlFuvLNBp7AQEAyNhAGsc6MP7q
Hxgg9cxjCjRPHv6DfrOZeThngMQ0dwM=
=H17n
-----END PGP SIGNATURE-----

--dGN/zjYuo5Wz6S60--

