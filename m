Return-Path: <linux-kernel+bounces-166618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B88B9D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8091F22969
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525E15AD99;
	Thu,  2 May 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdGtJqcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10B15AACA;
	Thu,  2 May 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662921; cv=none; b=iPsPwPH8Feh2JNbd5m/KqK7aT0meEHaucNk+At2irDEiZr48wZ8OIvzdRFDpY9gOvSBAHW7D4RkWEcjXTGbGJ6aVbqa8KDEr4vvnIIyOYxPE2UEpVKBdMOQODZo2iIlmay+V4Gfs8RLap0G2P0ZVHrw7Lrsoy8KaLhBcjsPdI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662921; c=relaxed/simple;
	bh=FisbOIvpsVFit1c3nYfm8hroZ9Szugxt6WvcPdNmDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOzarQXgmLrCpB37ubL54mbooIWPdUgQv+CiAK7pAmB65TH7CcK31Yer7/rDw9Mz01Wkq5pAbClqzV6SdFERlgS6HI6FugHZW+9VKmP4o2t7jEzKeUYDC6jHFF0Dr8O28hL+AXPh/Z5R5Mu487+Vs8RLKSbmUhVrgdIxMzgX25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdGtJqcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55E1C113CC;
	Thu,  2 May 2024 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714662920;
	bh=FisbOIvpsVFit1c3nYfm8hroZ9Szugxt6WvcPdNmDXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdGtJqcd5fVh7bj9oZhXSfqR81kQ8rxg8zX7EWRjtJ2fxwk0Q8JMCPPJyxpom/Fth
	 QVE5kX7tB6l6erQl2nFTBv4NO1aJ5S3wpPlZeOdRf8s+IqzeorbY/hvGx6a3z2x7us
	 krVANv49x9ACe1fcgByZlVCWbCZol5pQ53pw717SHj3KoFDXmdpFMXCQ8P84PmQT7R
	 FNyEuNwPptKypEI+EBm/bKAYrlj0GrfSgsoLs0HMb3SJQdV8BuzQRyBkD7DglZnmuj
	 M69io1YoV9YM+0892j61PF87j+WVVeLu5pv2c3hrC5R2GgMq252AYIUgytHmyNY5bP
	 bDXqfXj230J2g==
Date: Thu, 2 May 2024 16:15:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240502-gains-finless-1168f9f0622f@spud>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>
 <20240501131556.GA2931109-robh@kernel.org>
 <CAH2o1u5OYORHNuBC17DHkRFm6D6b8qaQVep8vX4kVzJAkk36HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SXPzoaVNzsHbB3bu"
Content-Disposition: inline
In-Reply-To: <CAH2o1u5OYORHNuBC17DHkRFm6D6b8qaQVep8vX4kVzJAkk36HA@mail.gmail.com>


--SXPzoaVNzsHbB3bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 07:47:41PM -0700, Tomasz Jeznach wrote:
> >
> > 'qemu,iommu' is too broad. Could be other QEMU implementations of an
> > IOMMU. So 'qemu,riscv-iommu'.
> >
> I'm ok with that. Any objections from others?

None here, you can keep my tag with the things Rob noticed.

--SXPzoaVNzsHbB3bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjOuAgAKCRB4tDGHoIJi
0g/XAP49wf/9XIdSLHOzXM2XNwC6zzNqel9e+7K0mLiSKhi7IQEA7aVbXkabNtlR
W/eULVth2tAgbe5pRhdFwJFXa3pR7Qo=
=z6Kf
-----END PGP SIGNATURE-----

--SXPzoaVNzsHbB3bu--

