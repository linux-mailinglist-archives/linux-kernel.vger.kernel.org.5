Return-Path: <linux-kernel+bounces-56697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511984CDBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB6C1F238E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FA7F7EB;
	Wed,  7 Feb 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE3lMhLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5E7F492
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318631; cv=none; b=WyIoa7NGxmNSSID6I/6bqCC2OAtW23X6SLB43VJwbNIYbEOkQwYwIC86J75SLbtQRegVzUIJ0OoEkvKqp1LT2dI/1ElKo6CseXM7ujQFJFkr4bz1tnFliLUxrc0DoD9T/EaB6faT54/CU+KKUDd0UAqo20anfsEj7qToyZHE1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318631; c=relaxed/simple;
	bh=z7kDN/9RKM6srpE/iDGZ736vndtbrUwfOgAVPlVsV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4IUmlSpvXoO3jJY9DmDPoa+bdS/HDDyL2R/uxKaHiKdxvSlpPVaJtAEDkymjpsSL+jGk7erfhhMTNhBA+UVYbm0lRa5qnQoQPZTlcMTnDfwSqwzm1rj81782JHPL/SgXMAljsDdIgcn0tdUZGtqs4C2ZqMZevqom1pd/Wj3QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE3lMhLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAB7C433C7;
	Wed,  7 Feb 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318630;
	bh=z7kDN/9RKM6srpE/iDGZ736vndtbrUwfOgAVPlVsV8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE3lMhLzAQH18yuIFUsYKJa4oavc9S+ZOM7C87o/RkVIWyhbHXOykv11LTlT0ubiE
	 pwfTt7gkZyE7mEjL8PFIPp6AEj0xRRO9eEPMdIGyh4oErPT67Y6gyiC76DwyW8DBcP
	 K865XTkME9n+0BPkOXHxI+XXst2C+b1/5ODZrgEEHAIX19ds+G2AlR9ZSn2KHjaQjT
	 0UgPqQZEysM0A+U2eaEgtfs1BQ9X53w/Qme9+jzY1vhMX6SikFCfGVk8OsoEhFd2y/
	 lJXOCbmLtYx8/OddTinzzv4OWRFB84YAbqGztCANDBMHCxMZDOOsLi9z0ZahG4mSS0
	 SM3h5NsFOmXdg==
Date: Wed, 7 Feb 2024 15:10:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Message-ID: <ZcOdZNEDXy14OGGI@finisterre.sirena.org.uk>
References: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>
 <ZcNxJ56+bvcUTGlT@e133380.arm.com>
 <ZcN8OltRDUlDlTHQ@finisterre.sirena.org.uk>
 <ZcOIAck16ZyUi/yj@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6wd8y45bC39+B3ls"
Content-Disposition: inline
In-Reply-To: <ZcOIAck16ZyUi/yj@e133380.arm.com>
X-Cookie: You might have mail.


--6wd8y45bC39+B3ls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 01:39:13PM +0000, Dave Martin wrote:

> How about something along the lines of:

> /*
>  * Yes, this is 512 QUADWORDS.
>  * To help ensure forward portability, this is much larger than the
>  * current maximum value defined by the SVE architecture.
>  * While arrays or static allocations can be sized based on this value,
>  * watch out!  It will waste a surprisingly large amount of memory.
>  * Dynamic sizing based on the actual runtime vector length is likely to
>  * be preferable for most purposes.
>  */

That works for me.  The cost of initialising can also add up in
emulation.

--6wd8y45bC39+B3ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDnWMACgkQJNaLcl1U
h9D6Ugf+JL/cppHvNNJuGS1wEso5Ew3SN0U8U6OhO0o5/EchygtGZBzmsIHkBxLG
wLq303vk0lALc3LB0j7Q43kaPzFDg/vIUPbCbdfAohqqVt/3+afBRlFAc3eMg8E9
0bSv+tlbM7TQOZaaC6JPI0jDhxhCCCX97dQ3IxqFo5wq4TYdmo9G6I3LCNVaeCuU
q78btLKrrXrXkFAcSdWv2FEUiHeuGDkcrjFS9g6H6Gskrmk0aVWciWjTXC3Jcpel
PIVNc8sOCdfnc/QgO61YjxopAV84gnDAlcblSEUoRLsCRKY51o0NvPusGCSsOkUd
EX30mUNpWRh2Z2cteqzTcGINiQMXEg==
=z019
-----END PGP SIGNATURE-----

--6wd8y45bC39+B3ls--

