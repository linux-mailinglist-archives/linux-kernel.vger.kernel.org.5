Return-Path: <linux-kernel+bounces-35851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096883975C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B30A289A47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3F81AA1;
	Tue, 23 Jan 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppuFVYeb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADD7F7EF;
	Tue, 23 Jan 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033518; cv=none; b=m+1SLd5KVnN9rHGvFZ1PcfkJBtHYVZwMFY9313xE+LCTjuJ9qTRETMa8pKeyfyGjLa1AvDyAyan/SSC2QFjtf7kA0ExmiJAkuwpa9DdHOYSO7jny8m1OR+HGXJMEw4IF88urra773XaKgEHwqR2lAfu38knhTlGcyL9ToBLPqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033518; c=relaxed/simple;
	bh=Qf9mEHht3yUIqrNjZxcQ0bvTqZFpCh/XYVvpOp1vhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIhDHhI8h9AcHdAgEl2rHPO0jTB2jQozs6H3YF8heI6QytNUKK3iFiiCGi8wZzJclVxQEGO8Twdd7HOsUtyJXUGZAKSmA815Jk69QbBPf4maFJiOns0sXpnSs/CE7/Rj2I18JU4xvdAOca77tFnKwkvoUnqAed/HMccge0+erzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppuFVYeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27E7C433C7;
	Tue, 23 Jan 2024 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706033517;
	bh=Qf9mEHht3yUIqrNjZxcQ0bvTqZFpCh/XYVvpOp1vhmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppuFVYebG5/NFWOdMx0aN3LAZR5fz7XrXEFb9o2k0quNnBo4yC2Z5fY4Gm1Vt7jYJ
	 4t2l0Td6vG/kjN3Rr5JFnBE7N6FpUgZ0wE+DnWihwKhFbGNGfzHHoeN7/DNh0IJ8VF
	 xIcmmzyjga/W76qQnB94MosrRVU7ZQc0lvNL9r2EAWaA7yyf8Fi2qSMv1MkSyZKXrY
	 TeVi6nzpG9zBF31kiv2tfDACH4MZYUO3vyPacMvoX+7G1iXEN/+R8Np7N/sfwayHD2
	 Un09gAz7CnKaIjLJSGlYCwFz5X89gYXIp+VdaMd972HYDMzhjsaq72R/ml37YmutEv
	 GjaBZNK+LWDQA==
Date: Tue, 23 Jan 2024 18:11:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Message-ID: <ede05e2d-0cde-4de1-b2db-d40df19d7075@sirena.org.uk>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
 <Za/e15zUOEaa1b7d@e133380.arm.com>
 <991d84b4-e184-4fd6-900f-601f8c31d518@sirena.org.uk>
 <Za/9SawqwXmlG/9B@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmVr7hQh/YIa4C2A"
Content-Disposition: inline
In-Reply-To: <Za/9SawqwXmlG/9B@e133380.arm.com>
X-Cookie: Stay together, drag each other down.


--gmVr7hQh/YIa4C2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 05:54:17PM +0000, Dave Martin wrote:

> I still feel that it is iffy practice for userspace to rely on the
> extra bits being zeroed -- I think the architecture hides this
> guarantee anyway whenever you go through a function call confirming to
> the regular procedure call standard (including the syscall wrappers).
> But there may not be a lot of point trying to put people off if we
> can't force them not to rely on it.

I do tend to agree that the requirement to zero is excessively zealous
and that the risk from relaxing it is minor (it's stricter than the
function call ABI), I did leave a sysctl as a mechanism for restoring
compatibility in the case where we did run into issues in my original
series but I didn't expect to need it.  If you convince everyone else
I'd be happy to relax things but I don't super care either way.

--gmVr7hQh/YIa4C2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwAWcACgkQJNaLcl1U
h9COVQf/a705pbZzwJ+u2yYjjQXP3ai6RIMlH0LuxLO1/fEdLadBHlLc7PIbq/c1
e1ObAegI5TXMIvKnpiuUg/uBv2ona5Vw5uXxyxqw5P5mvh66oZeC/t4N24jJ1lzX
UafQyWkRLbSPrEQSK3ydTOm424O8wiPvAHmppXmCh+ApOtq0wExwLF0QtxCnURPj
SSs/qqTWSHZOeeGvv0H3mMvoYHV8bjckc4vd+0W8O5XRM54cHkKS7gl3dhqKk8dV
48qeLfcdLVg2kwnOA6ezy0uOdKWhwCXrRDans4id5epvMu8JRV3T7W50tLX99pw0
3hvF/Zv+EM0ZhHcjZxiBLWoGDedfCQ==
=DePV
-----END PGP SIGNATURE-----

--gmVr7hQh/YIa4C2A--

