Return-Path: <linux-kernel+bounces-66963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDF85641F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3494528241A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706812FF96;
	Thu, 15 Feb 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYnpbPv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA012FB27
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002870; cv=none; b=mZYo0R5SGKdf1JGa7OuWRcLRF7UKW7HVkInlxOUvGUJm8vDHlGs6ZZSfRHIQ+utqzJyDDoSRDk5LdHnDKbaGis4HtrDZGdzNWkHv2umskp6hZ0yR3TleKtTRXfHZWYxRRizSBkGGowwGUl8wLrXUakI/AozyHdIxlmg1BbikiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002870; c=relaxed/simple;
	bh=aUWWrfsL8ZnO6US7lu0C+z2+ofPyZmFmbK5Cal70MlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDk9wul9eMAfg0D4gU0PMD38MXha1Yf37J3fXA+ganoBUW3QdEdhGlsSu1hOoJkhhDRL1GAdo4FcEUnRLsRSgL0fIcgUM7RgIsawe1QQj1oEI0otI9b5SeALA3wnGkj/jYX0DIyumzsn+4adOSNF7OUyNx4uFmZlJs3f8CNULY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYnpbPv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529DDC43394;
	Thu, 15 Feb 2024 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708002869;
	bh=aUWWrfsL8ZnO6US7lu0C+z2+ofPyZmFmbK5Cal70MlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYnpbPv0Jd/r16AM8nCmg/DMjAtayMYZjHFhTD2Q+754ZN2ljgeV1VDZG3MGZeTX8
	 +ZirYFi1DQaCj00GVwT/fEqDdY9bligPiF0Gj8VJIGxLn7eId+e9KKU2qd9+7CfCqI
	 lSybdqQjUIlDAAKKIZGNx15OiJzYYsnBc6AUOYez/sBBhYZDDU2/WV0cS/qmGwOl+Y
	 4lbv5JjayxylxdjSgbt0nJQ/n8YO8zHxATiMcYlKvFvDe4It03omd7MCz+u5ZduP0C
	 /ssjt8R++j2ddB+AwJyD8A3LmDprJkNmZ7EHq2hZJZBJnGokPsWhn0xXHe91BOzOJC
	 swfgXOdnpsbgA==
Date: Thu, 15 Feb 2024 13:14:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified
 privileged ISA versions
Message-ID: <20240215-icy-oblong-67adb68a4074@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
 <20240213-88c9d65fd2b6465fc4793f56@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ty9sdf64Wa8pEu18"
Content-Disposition: inline
In-Reply-To: <20240213-88c9d65fd2b6465fc4793f56@orel>


--Ty9sdf64Wa8pEu18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 03:25:44PM +0100, Andrew Jones wrote:
> On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:

> Note, QEMU doesn't add these extensions to the ISA string yet, but I think
> it should start, particularly the profile CPU types which should ensure
> all the profile's mandatory extensions are added to the ISA string in
> order to avoid any confusion.

Something to note about these "mandatory extensions" that are names for
things we already assumed were present - they're utterly useless and any
DT property should note their absence, not presence, in order to be of any
use. Anything parsing a DT cannot see "svbare" and gain any new
information, since the lack of it could be something that predates the
definition of "svbare" or something without "svbare".

Shit, but that's exactly why I deprecated riscv,isa.

Cheers,
Conor.

--Ty9sdf64Wa8pEu18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc4OMQAKCRB4tDGHoIJi
0gBfAQDHitJRjjkm8BAASaylKf3zcVB6vWarMERcGPovak8WmQD/dIaz8rDrvtlD
sOoKf0i7vy+Ub2viaSLzs3SD3hV4Two=
=dUI9
-----END PGP SIGNATURE-----

--Ty9sdf64Wa8pEu18--

