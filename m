Return-Path: <linux-kernel+bounces-109321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CFF881790
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F459B234BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6E8563C;
	Wed, 20 Mar 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJgEulWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EB8529D;
	Wed, 20 Mar 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960719; cv=none; b=htLVzJFNe4nBh6z4oAtYOXrCoI5KtKaO4ZiEALFEqwPhy/lkmnNEjMeejp2R/z2+OOzelGGx69c9WYdoZgUPabpIs4628ew9Wrl6Zp1wRQerNVPoSImIW22Z1It2/cBq++5XdfVrTi4rUu5T7sYBNMkeDR9ZGo4L6OorM9p+U3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960719; c=relaxed/simple;
	bh=d6TEWqNHGarTNFqrsWL72liC44WwQujen/XgSqv+mE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnrb5RmmeEJer5LCms291FlMmjd4weFHBEA9kTrZuqnj60mwytw7mci172ceq4aPnl1fp23cQXgx6GpD5yoa99tFKRExIlR2Ue8tQUx92IiJqMDFBAJ1SDe1vIpOUWSrHwqGOa912Kc4+kLzGnmS2wJjdHAOw4A5CkySU6bMFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJgEulWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3383AC433C7;
	Wed, 20 Mar 2024 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710960718;
	bh=d6TEWqNHGarTNFqrsWL72liC44WwQujen/XgSqv+mE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJgEulWZb6a9Mxsm87VZj70L5vi/qsM07l8UWwwHVxy601XWOo1CL64DxxjXBM8eS
	 iRHp+MgvuzrIojxYqpRWJorzS2mkyGPklEIQNbir5ZfwMiEXpUqvwF7+sMS5jukW+J
	 WXA6qqWF2f6gloX+W6AgF2BSf4StcZeg50qhA9ruELpijdc7QmVFngiCIlQBrgoX/l
	 n6oqoLsQQsPa1ulDvjIDDz09b5xV5x8ap+d5+t+GsdNajB/eDvjjOo04zLcORmFBP7
	 0GHbvASk59MiKYEiBAP8PSI0+DRQIkyV6waMfPGVrRNAm0lIeq8cuOsx+y1sqfN27l
	 bgSpcDiCedT4w==
Date: Wed, 20 Mar 2024 18:51:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
Message-ID: <20240320-harmful-carpenter-40a7de0f273e@spud>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
 <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
 <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
 <20240306-scowling-mortify-9b427c80e8ab@wendy>
 <tencent_91E604E3B4D51DA37045625242A81B07F909@qq.com>
 <20240320-ideology-pasty-d3aea07cc519@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yFaj5iez9WvDhwVq"
Content-Disposition: inline
In-Reply-To: <20240320-ideology-pasty-d3aea07cc519@spud>


--yFaj5iez9WvDhwVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2024 at 05:39:14PM +0000, Conor Dooley wrote:

> I got a k230 board (the canmv one) so I should be able to test this
> myself before picking stuff up.

I've taken a bit of a look at the "sdk" and appears to be a complete
mess to a non-chinese speaker like me.
I know you linked a copy of opensbi to use with this, but do you also
have a version of U-Boot to use with this that is not riddled with
crap and will compile with a normal toolchain?

I have chanced upon Courmisch's repo that looks significantly more
usable than whatever Canaan have so I guess I will use that:
https://code.videolan.org/Courmisch/k230-boot

:)

--yFaj5iez9WvDhwVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfswSQAKCRB4tDGHoIJi
0qlkAQC7FRjew00zC3r7BNoqFE00Z9wOqBZuIoF6dxLOsByqkwD+K9VLMOVa85Yz
5lMzqwe7/O9GkMdlnk6wso/HM0S7Kw8=
=jLB8
-----END PGP SIGNATURE-----

--yFaj5iez9WvDhwVq--

