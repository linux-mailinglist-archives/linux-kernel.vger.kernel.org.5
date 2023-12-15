Return-Path: <linux-kernel+bounces-957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD981487D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C391C23010
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8E2C6BA;
	Fri, 15 Dec 2023 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHfGgJ+h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC82D78C;
	Fri, 15 Dec 2023 12:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CF4C433C7;
	Fri, 15 Dec 2023 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702644826;
	bh=WicRJtYXQ4anL3ujwDKWzbyTnghq8o4oWMHXRJues48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHfGgJ+h+14yYU2HGmYDuZBbk8153FTrb5FAM+4AU1qHGRGFGWuGdVH4fzC8GyUnX
	 ryQdukhfXRjYsULLDhYo8EcYYssTwJEjpxk3JIU3hhKv+6zfTPdSlZQdRXnYB99GUB
	 rncLAOxG4PVTRwCRDtG4iTRAhjcLEN80l67Aqd1HBx+IBzVKIrCVqFRa86dDfvexGe
	 xU0rMtGrfQ/fWyl/yf6MasH2nJvvABx+B7eMbvJ6GnNmXsJTQTvzYY46TAmQmS40uT
	 9M4Uo9/hqFJ87aioB8KZlptQE5Yvmpti4bPCIjoJ9E2Nl2nzXGOSh7B+kBwtetWTWN
	 5/XFh3iWCWPlQ==
Date: Fri, 15 Dec 2023 12:53:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Marian Postevca <posteuca@mutex.one>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Message-ID: <9fc36923-8387-4c86-bb04-8c71a826adb1@sirena.org.uk>
References: <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
 <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
 <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
 <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
 <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
 <0de8f81b-e7d4-43f6-b011-eb6ee09cc7fe@amd.com>
 <913257d4-75dc-4887-97d6-0f206c401057@collabora.com>
 <188ee32a-a201-4210-a8bc-bf3ba04e2f2b@amd.com>
 <f3d98291-0bf6-45b2-bf4f-b0268d13af63@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wOoBNp3OA4Lx2IbG"
Content-Disposition: inline
In-Reply-To: <f3d98291-0bf6-45b2-bf4f-b0268d13af63@collabora.com>
X-Cookie: PARDON me, am I speaking ENGLISH?


--wOoBNp3OA4Lx2IbG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 12:57:34PM +0200, Cristian Ciocaltea wrote:

> If the SOF workflow is unable to integrate fixes submitted upstream, I
> would perceive that as a significant drawback of adhering to that
> process.  It is hard to believe, though, that this is really the case.

As far as I'm aware they can cope fine with that, though it does help if
people try to avoid needless collisions.  It *does* cause trouble to use
both github and upstream flows simultaneously and there's a preference
for pushing anything substantial through github but picking one or the
other works as far as I know.

--wOoBNp3OA4Lx2IbG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8TFIACgkQJNaLcl1U
h9DQawf/S+P4Cksj4wJ9I03ATBoSC5S6Ghx1J63Sn4JzF+f/Q5AlgJAShLxYwk57
dZGWnKSqRFVLYnszaEyQB3k1961or6AwYOAfshSuWZsU6Zb+XaEqyIw9cxYJygKc
SpV/BZeOPXlTmrW5a+D64pWUtcNUkOVyZojwVQrFsMHbWLn8gG+61ulgcovCOlFy
pTSnnHhUj6m8q4fXzpRLPEO++w89Sbti1oSVSlKhrL2wm6OPqSm/wI0iEDk+b4Iz
Zk0301vD6Fq4JQnBeOLQq3df/tz7lspnL0AZdjAOYYpMycxIrDBDDYQcxrOz/6ta
T6xkGxWtnb6g2ypLKAGmp3k9kGeVaA==
=O7cF
-----END PGP SIGNATURE-----

--wOoBNp3OA4Lx2IbG--

