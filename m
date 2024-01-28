Return-Path: <linux-kernel+bounces-41884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED483F92F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD62829EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ACC2E851;
	Sun, 28 Jan 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiJ7vVVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4592E637;
	Sun, 28 Jan 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467252; cv=none; b=hmmkWLt2T6MKyZJrvw/+iixzahokAgzhIv1uKmUTjuCZ6AAKBHnJmqLsKpuxVUum4JFvTysgEmWRrpi+3DE0pJ5VyO6h3XxZ7o5GYr/McAYOXIgB7/xJycfZsP889Sr2chHdU/8uOS62e/7Y6g4n2YHGUrZELK3+OLdqkJJcC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467252; c=relaxed/simple;
	bh=OXtCQ+vQ1QllQ0fm1DWTp+AwShfUxJ41JAM9Q4D/3mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Njt1glo20+D7ahrLGrQLnhuUuzAwD4JnHz4ApBxGt4vnL10sMu/hp77YA10e6IJiohcRnRWevwKZRNoruGJktDBHWxtmOSq2WjOxJesWWoYjiN5rJKrZ+UKGv848iPaNIhJpB3qoU3WcPHN58ozTxKCw9x713DpYLdjDp606c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiJ7vVVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE945C433C7;
	Sun, 28 Jan 2024 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467251;
	bh=OXtCQ+vQ1QllQ0fm1DWTp+AwShfUxJ41JAM9Q4D/3mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiJ7vVVwcmAM/YaQGCAQKsbQ3hGv1k6H7huHXmuJSjcpKHI3p4X9IHlf3BOJKQWkU
	 mfHVyTZUoWOml3cpuc1sKTEy/9456nMCeXnwkVyCLSMbRVJjeO8FIPUZ32elLRfZl2
	 9ohbg208dzlMfcWLi832BIp/1ryvtXn3AAf/aO2Tpv2Schm3it2tNzwcgHYM7EAiE0
	 NB53IUv5nSUlQS824qGMJUuMn2NFuNnNJpSYTD/TAF5Tmq7SDfOqHx9t4OlGffVqYH
	 dC8DQc8SRRhm7V13n0nBa0cWTWWitzU37dDLFlTT5poI5YG7LSRVfnN87FEBJ7GCm8
	 fEQWAsCmI33fA==
Date: Sun, 28 Jan 2024 18:40:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: riscv: cpus: reg matches hart ID
Message-ID: <20240128-wind-democrat-1de3e3463a34@spud>
References: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>
 <20240128-simile-endocrine-9e8af979d361@spud>
 <3f751ed6-871e-424e-a50e-4362e1bfb527@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RMll9tqlxaIRdVcU"
Content-Disposition: inline
In-Reply-To: <3f751ed6-871e-424e-a50e-4362e1bfb527@canonical.com>


--RMll9tqlxaIRdVcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 07:23:39PM +0100, Heinrich Schuchardt wrote:
> On 1/28/24 19:20, Conor Dooley wrote:
> > On Sun, Jan 28, 2024 at 07:06:21PM +0100, Heinrich Schuchardt wrote:
> > > Add a description to the CPU reg property to clarify that
> > > the reg property must match the hart ID.
> >=20
> > That is the expected usage alright. Did you come across something where
> > it was not being used in that way?
>=20
> No. I was simply missing it in the documentation.
>=20
> There is a page
> https://www.kernel.org/doc/Documentation/devicetree/bindings/riscv/cpus.t=
xt
> but that seems not to be generated from the kernel tree.

I think the hosted docs keep alive links files that were deleted in more
recent kernels. I have no idea about the details of that though...
The text binding was deleted back in 2019 in commit 4fd669a8c487
("dt-bindings: riscv: convert cpu binding to json-schema")


--RMll9tqlxaIRdVcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbafrwAKCRB4tDGHoIJi
0moSAQDmPjOOz770QqI7z7KSmgpBa++6nZ4ck6nCmwz4Ls5xUAEAstDvKMdK75zM
oorEXj0qITKBvzmMbcQZHPpM9yX8UgU=
=gXZf
-----END PGP SIGNATURE-----

--RMll9tqlxaIRdVcU--

