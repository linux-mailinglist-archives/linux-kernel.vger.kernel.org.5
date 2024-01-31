Return-Path: <linux-kernel+bounces-46432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C5843F90
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EA7286985
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44C79DD9;
	Wed, 31 Jan 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW6NwkLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2F6996D;
	Wed, 31 Jan 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704971; cv=none; b=gJGOXs3iJIWCjDE8kJmd4xQIklqS4mRFB7d7KqAhsEeD7X2At6tPrn6Tz5/NtUV7eh+15oHtx5pkGH+ETyKBaWYwQm/vEVeY/PLJZcPEVdEYjDcVXkmKid903+8V6qFREko02idOAkMSC+LDg0kpWEEP/efKd23npaxpSVoGG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704971; c=relaxed/simple;
	bh=Yw9YLwE4bTgmSbMQeZgcW6uRr61ZVfbeWomDVZwmev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9piL4JvjSjVzmqkG418SU15d4g6SJxCL1riNGJTMhvX4RhSATLloNwnQUXSJXndBTk7ho082QXnecq/UF2LPAbIeBfs+74eYCLSYuzMTdQy4cDYMGUcztvFLkA9jOVcuGmKKLai+tECp0103mQhjgy8N5DjH2B3DOGrtB2HAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW6NwkLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D5CC433F1;
	Wed, 31 Jan 2024 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704970;
	bh=Yw9YLwE4bTgmSbMQeZgcW6uRr61ZVfbeWomDVZwmev0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bW6NwkLYIZVPoqAEgmAAIaX4MvEwsrfESf4cUa8gbQVRRoUv//rm3aLqDWsLTB2+d
	 t7Vr1SdcH6k0t3lRmZeiZRdKUYD9ezvB60/oxNIS3AfOM+KIR+iipt+a2qcnQUVJn1
	 io+sUvevYuXd27Qu0emYKLY9xsFYN0GbcvJtORv4d5rEOPxJOTgRgcpuV8uHFuyzFb
	 EAY0p8gze6FTHwEPmviexWdd1BQCAzTMY1CNgaFzRJ78dA86D8ISpuhyDg/3DlRnvE
	 7+vAwB0vtu1sxpb9urfALNUco4NL5R+G9rmYySrsycJQYOchM98xqqOU1Thbii6fHC
	 zG+w8sL2h612g==
Date: Wed, 31 Jan 2024 12:42:45 +0000
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
Message-ID: <1b3064d0-d41d-414a-85ad-5202a089ad5e@sirena.org.uk>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
 <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
 <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
 <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
 <b1b8cbdd-6d6c-4656-b17a-4d2dfb555f8a@sirena.org.uk>
 <787d3fb1-7aad-4e92-8a22-360b92f46c68@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LcSh5X4TdHiaSEzi"
Content-Disposition: inline
In-Reply-To: <787d3fb1-7aad-4e92-8a22-360b92f46c68@linaro.org>
X-Cookie: I will never lie to you.


--LcSh5X4TdHiaSEzi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:15:11PM -0600, Daniel D=EDaz wrote:

> > That's an assert that we shouldn't take a SVE trap when SVE is
> > alreadly enabled for the thread.  The backtrace Naresh originally
> > supplied was a NULL pointer dereference attempting to save SVE state

=2E..

> > given.  Can you double check exactly how similar the various issues you
> > are seeing are please?

> I'm not sure of how similar the test cases are, but I'm inclined to
> think its occurrence is not related specifically to ftrace or one test
> case. It looks like these appear on FVP and Qemu-arm64, on several LTS

That question is not about the test that is running, that question is
about the error that the kernel reports.  There were two different but
potentially related kernel errors in the reports that you and Naresh
sent, I'm asking how similar the other cases actually are - is it more
instances of these two issues, are there possibly other issues?

--LcSh5X4TdHiaSEzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW6QEQACgkQJNaLcl1U
h9D88wf8Cb366GwwKV1HpvWfjvF6pI3NDFA3D1AMxUuPrRD6QTrKVnsJOCyz2pdX
WKAuINE8bLazLTUL+F7UhHH0wZj2DcwLeH8Zu93OAfM824aVAAUqVKQxigL01VnX
q4FAip2FZUwQLGPnViIeT5RA8wne4RHvcUrxIjHSeQvPCiK2NgMHynQl4h6MsDIe
1lIn3OUDXW+GSt7gcndvGkoAxayb0tLMrPcr3+nwEDj8OhMog/H3YQ6TygLSZg50
5Ayq3GHGsA7A+3wABc1zmA+aaapDCoM2Hj4gbEQrpGEA2YaSud8FGG7OQ4Zv5zzn
hHa1zWevvdrzvtejMvX096LcjSTlWA==
=JsX4
-----END PGP SIGNATURE-----

--LcSh5X4TdHiaSEzi--

