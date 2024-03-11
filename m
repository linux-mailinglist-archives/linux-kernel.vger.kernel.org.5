Return-Path: <linux-kernel+bounces-99145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E687840A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA621C217C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201C43ACA;
	Mon, 11 Mar 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz3Ck0Su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32211712;
	Mon, 11 Mar 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171800; cv=none; b=MAIy+TUPF70JSLodgtBxkKnE4ehDkc3gE/oMWUVP4GfuZsUiheSR9W+VqFLO4ekYkgh3Pohez/POUMyOPwzb2OU/j6emw80qY0oxT1TuFcr3BSB5qmMwVEudNoDVuseDB8bBw64Iv5faj8hbRAOQb/zdAXQVSsgvlGUTlvE3rQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171800; c=relaxed/simple;
	bh=lFB6D1ybjtwvF52wxjULzotqF66REtbOySTpO2Nhi4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8k+0VqSt7NWqnMS99mNCaYBG1/BDgzS42zLuIIRpQfJHvvEhL3PX7BAqocxXPBTEc0Ay33oWbq4NcX8d6q8QNiy+Qx9bHA5DQVqm8md/f7vhDx3QiTYzXQCnskJhmYU59ThEn9s3yA1zUMUSA1vSO9q9AeO1W43H+MW044azLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz3Ck0Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13E3C433C7;
	Mon, 11 Mar 2024 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710171800;
	bh=lFB6D1ybjtwvF52wxjULzotqF66REtbOySTpO2Nhi4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz3Ck0SuguY+kSEPjTUnV2+1S03yHm6+fRf/V52eAmISHaKIKjLdYmM4qSv013XRl
	 NRvP1sV8Ydz+8sGD6uez9fv4JlOk4yEqiFm+ybSzbOvb8S6GflbeTcQAhbFXBcTPYk
	 +sqUEQSZWV2q3ySk5C5c86UvmZFVZ4RxKGioHKlmZbuXZtMzq0NWlXiy8vsrhIojMt
	 CEttNCy2GzQwbijGy7aMzXdFzVxJVZT43iOEGOZAP5GopX66D213aMjJIc9EFFWQic
	 8fL4A4Os6MNbrjIxvsUQF4cTjKvSnSVP2I9SFkgQSH6zC+XWLBUpyaCrRpeo+1bSVm
	 Hx8sRR8CiQjiQ==
Date: Mon, 11 Mar 2024 15:43:14 +0000
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jiawei Wang <me@jwang.link>,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Subject: Re: [PATCH AUTOSEL 6.7 18/23] ASoC: amd: yc: add new YC platform
 variant (0x63) support
Message-ID: <9c4517bb-2e8c-4d60-a6cc-8ce4b2c3ed2e@sirena.org.uk>
References: <20240311151217.317068-1-sashal@kernel.org>
 <20240311151217.317068-18-sashal@kernel.org>
 <023092e1-689c-4b00-b93f-4092c3724fb6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F45uuwfApqKDqO5C"
Content-Disposition: inline
In-Reply-To: <023092e1-689c-4b00-b93f-4092c3724fb6@amd.com>
X-Cookie: Sorry.  Nice try.


--F45uuwfApqKDqO5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2024 at 09:09:26PM +0530, Mukunda,Vijendar wrote:
> On 11/03/24 20:41, Sasha Levin wrote:

> > The Lenovo 21J2 (ThinkBook 16 G5+ APO) has this new variant,
> > as detected with lspci:

> > 64:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
> >         ACP/ACP3X/ACP6x Audio Coprocessor (rev 63)

> This patch has to be reverted.
> Pci revision id 0x63 corresponds to Pink Sardine (PS) platform.
> Its not yellow corp platform.
> Already PS platform ACP driver with PDM controller support available in mainline
> kernel.

Is this already corrected upstream?  If there's a patch upstream that
needs reverting please send a patch to do that.

--F45uuwfApqKDqO5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXvJpIACgkQJNaLcl1U
h9B0mAf/SJSwtMNLidnuem7U87oVxnvrioP0vC5b6AWg5b1HchU7YFwH8SlOcUqD
KlStIMOj9wy4nKAxvUqVw1dAwY4xIFjnuFBSgISKa+tIrbn2jpwK9PMjupbyoL35
Ota7ds83N0HNlNJxeno/A6GyHLSUO9E0vXq/Ks5ObNmURI2KE8nuBKcw3UrGDa54
sJE4rsi1tMJ+LnjWC2M9cVFGAaIjfNJ2i6tAmZutycMUq7tXvyd4Pb1M5nDoovx8
SUf4xhMOM9ya70VoEjEJdOw9WCPN6In82IM5N7yNaVBLAZxlirBdyMwIQEpfg0N+
IAGQWuH1gfsRir4e9LXcNXS3aHR2UA==
=J0Cy
-----END PGP SIGNATURE-----

--F45uuwfApqKDqO5C--

