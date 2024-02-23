Return-Path: <linux-kernel+bounces-78383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476D8612C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F581F2324C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D17EEFF;
	Fri, 23 Feb 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTUYTql4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42446280B;
	Fri, 23 Feb 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695125; cv=none; b=erqkm0wjqBOHc9oNU+iKEU9UD1iDMRLWoSa9SRTHovVcUufyYqktzBe/L6eK56NAHEgLS9xsQd/g397iRzZMrlDJm9AkoJcxnI6AkzE0YJYPlvfwWbPV+zo01zcm8uXHpDEi84BXXq3d42iLER3YLRgK8Q5Xe95MHYqT7qgoWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695125; c=relaxed/simple;
	bh=gQn5UTl5JKh4D4SB6kO6dJWyPw+k9QH+4jgr3Jr1P9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eacvOX8i0nLp5Noube1ecOV6Y63JSsDsN0PbsbTOfSIBBshKsVtHQzaGRTEsJLZbRqoaQrBYPSVVdKPDo/SnjHuWEdDpOvJb3s8IQbOQAu8Y8DMDAXH4a93LbXzQGGMMtBEQJyW9cUaJB9CcnS04Ioez9ivm+xSFDlmmKiTBAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTUYTql4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1D5C433F1;
	Fri, 23 Feb 2024 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695125;
	bh=gQn5UTl5JKh4D4SB6kO6dJWyPw+k9QH+4jgr3Jr1P9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTUYTql4jfqmXOuIjA7PJ2Mb6oP7H/d9E3ZkLfsEpPIeL4AeITRTUkOFP2exhYZix
	 18vBvcdy7pjQgYfVgHRT/zUcFYTJEnWjVMtUIxyNMW6rKdnPNqsBDsL2cERV1YKCtL
	 B2cd2lazMu4ODZS9TvOj9+/X/cAJVVte3QL8ieoc6W4osBCcupuxK6+3VoIXktwZ8z
	 ec47J/Hh6FFsu8Ka/3HawSpWetQUX/qVyBTSTst7L2c3muTUJw9Jh3dsamrKXv1ZZy
	 2nYUV3O3wAoG7hxSyavBLkT9cgBRuCQrllz4wOKtkxJL/amYhdr8P6XsA6NCrZBNHo
	 221fIoHMictLg==
Date: Fri, 23 Feb 2024 13:31:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <ZdieTjUeTLXvp39E@finisterre.sirena.org.uk>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
 <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>
 <ZdYDJPe1n5-V-AnT@FVFF77S0Q05N>
 <7fe52cb9-12b9-4b03-8e55-08e59b4bef27@sirena.org.uk>
 <b2dfcaf1-f466-4e81-8ca4-02bf3fa837e5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4llPrfxUQhdEFbq0"
Content-Disposition: inline
In-Reply-To: <b2dfcaf1-f466-4e81-8ca4-02bf3fa837e5@arm.com>
X-Cookie: You might have mail.


--4llPrfxUQhdEFbq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 10:58:12AM +0530, Anshuman Khandual wrote:
> On 2/21/24 19:37, Mark Brown wrote:
> > On Wed, Feb 21, 2024 at 02:05:24PM +0000, Mark Rutland wrote:

> >> Sure, we're inconsistent. I'd just prefer that there's *some* local ordering
> >> here, as the patch is neither ordered as above nor by encoding:

> > I agree, I'm just saying that if we're going to fix the ordering it'd
> > probably be better to go along with what the rest of the file is doing.

> Sure, will change the registers order as has been suggested earlier i.e
> alphanumerically instead. Because ordering registers with encoding will
> push BRBCR_EL2/12 after all other BRBE registers, including BRBIDR0_EL1.

> After the change

> BRBCR_EL1
> BRBCR_EL12
> BRBCR_EL2

The _EL2/12 registers generally come at the end of the file due to the
way the encodings work?

--4llPrfxUQhdEFbq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXYnkEACgkQJNaLcl1U
h9Bl7Qf/T6AgPiF3hy4ca5oIw9FbPpc/LuFaIqEzsSx0bRIxMIzzxJXU8vg8ybuN
OENNS3EwOwe1WWO0bLK0CRa7xrNbw+/UKGIDMpcDSB3BsCWRoaPOXDlzm8FO41Xv
5txtkQxK70NgX73qqOcN3HR4rEnM6MNbAYnIJKFrJ0Q5ziH8Th7DwIUSFRGiwPbk
zUoyEfmPM7HSOOp5F7YwvZVByfXxEnsMufrAOPjmTnULJKRil2y6YZIxwjwHx8eo
ETEjNcnJimHc8kpO1u5LVLykQDRDOk9M/3a3MS/mbr4iEXc4FxR0ULR8OAxvFj5e
cGqUKN3QrTI9u/8xU6EmL4fXZBjkEA==
=k3W3
-----END PGP SIGNATURE-----

--4llPrfxUQhdEFbq0--

