Return-Path: <linux-kernel+bounces-7714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABD81ABFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727121C22694
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D017D9;
	Thu, 21 Dec 2023 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opmQblqy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E112567;
	Thu, 21 Dec 2023 01:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAFAC433C7;
	Thu, 21 Dec 2023 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120794;
	bh=3q/je4lxiM88lpvgaF61zSPIgyprdo8v2CPqjz3q1IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opmQblqy1kblwTnTrw2H8sT3BN2wFlHh04CUp8N15C2cC233vLrCT8WAeW7yj8Esp
	 0i9BVNrC1itAe3TiB8nYnjRs9WtaGYBCGuD91AjLYybX3o6AkaZzZ8F11jAG6dSK2X
	 WYQLGuEi7FkbKBwxfu98I5LUmmf6c6P9mW4HdnZkJyCjlzo13nP5+0LvoAdEOqgIts
	 q0KBCL4+4BiMPtgz38OHRNfj/mRtIyHrmDbCDkzeDWfXWx1Nc1yDtZN5/5Wpv89fMo
	 TWn8oT+mrc0SKYfoFkROhvA0Gvjb37kDbdysQrWbpaHv5LnK75UoV3QvZl3CJL9K7K
	 QXQIdT28O3sjQ==
Date: Thu, 21 Dec 2023 01:06:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-ID: <b1b8cbdd-6d6c-4656-b17a-4d2dfb555f8a@sirena.org.uk>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
 <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
 <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
 <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gWCBnsT00SOVLyLa"
Content-Disposition: inline
In-Reply-To: <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
X-Cookie: bug, n:


--gWCBnsT00SOVLyLa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 06:06:53PM -0600, Daniel D=EDaz wrote:

> We have been seeing this problem in other instances, specifically on
> the following kernels:
> * 5.15.132, 5.15.134-rc1, 5.15.135, 5.15.136-rc1, 5.15.142, 5.15.145-rc1
> * 6.1.42, 6.1.43, 6.1.51-rc1, 6.1.56-rc1, 6.1.59-rc1, 6.1.63
> * 6.3.10, 6.3.11
> * 6.4.7
> * 6.5.2, 6.5.10-rc2

This is a huge range of kernels with some substantial reworkings of
the FP code, and I do note that v5.15 appears to have backported only
one change there (an incidental one related to ESR handling).  This
makes me think this is likely to be something that's been sitting there
for a very long time and is unrelated to those versions and any changes
that went into them.  I see you're still testing back to v4.19 which
suggests an issue introduced between v5.10 and v5.15, my change
cccb78ce89c45a4 ("arm64/sve: Rework SVE access trap to convert state in
registers") does jump out there though I don't immediately see what the
issue would be.

Looking at the list of versions you've posted the earliest is from the
very end of June with others in July, was there something that changed
in your test environment in broadly that time?  I see that the=20
logs you and Naresh posted are both using a Debian 12/Bookworm based
root filesystem and that was released a couple of weeks before this
started appearing, Bookworm introduced glibc usage of SVE which makes
usage much more common.  Is this perhaps tied to you upgrading your root
filesystems to Bookworm or were you tracking testing before then?

> Most recent case is for the current 5.15 RC. Decoded stack trace is here:
> -----8<-----
>   <4>[   29.297166] ------------[ cut here ]------------
>   <4>[ 29.298039] WARNING: CPU: 1 PID: 220 at
> arch/arm64/kernel/fpsimd.c:950 do_sve_acc
> (/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))

That's an assert that we shouldn't take a SVE trap when SVE is
alreadly enabled for the thread.  The backtrace Naresh originally
supplied was a NULL pointer dereference attempting to save SVE state=20
(indicating that we think we're trying to save SVE state but don't have
any storage allocated for it) during thread switch.  It's very plausible
that the two are the same underlying issue but it's also not 100% a
given.  Can you double check exactly how similar the various issues you
are seeing are please?

I have coincidentally been chasing some other stuff in the past week or
two which might potentially be different manifestations of the same
underlying issue with current code, broadly in the area of the register
state and task state getting out of sync.

--gWCBnsT00SOVLyLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWDj5MACgkQJNaLcl1U
h9D8yQf+O6aLYXO+eqsG/uShuVW2abRfdRrSWdr4CR8ZhbRnWwgeiNGH89O0lF1Z
U8uswFHmqnDkFV3peRN0jmsU/TlxwaO45LRUT0s/puEYMnLkaCEfTVfYahbs/6c7
DFO5/sNcBxO1/GaFrItZdOhJm9YIwbXsCAlPDIh2laOj4kpI6C/mO+rb4nFxyFJ4
1B0y4PBfT7kO+wP6sYKXfn76fGi5jgONmsV696UcPTfJFyQUfvFmgDWB6SM1xWr0
8n/62TCUwfxSgsnFVyvPJ+b2r5wObp3sV84nYHRPxom7WtXpwU9g6+t1At2UuRNV
g4aIscLDEL8j4Bifd7OpoyBVlnAvFQ==
=muue
-----END PGP SIGNATURE-----

--gWCBnsT00SOVLyLa--

