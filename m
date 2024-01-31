Return-Path: <linux-kernel+bounces-46283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA27843D73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548201F21B32
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF63768FC;
	Wed, 31 Jan 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzkgeu3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1445E768FA;
	Wed, 31 Jan 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698636; cv=none; b=b2PjD2OPopPU/cHYpGNAsUcp2fGxq7gtSJODQur2f2CfDe+t5iuBDuytEg4uq+Dqr9KUjWAFpsojDYR/VtyeuBagKRO/Z2uBZim2bqDc6+9tVUxl2S9gW0m3SdhS/0l+of9LaZ1v7JMPbAWocypT/leVLxYvmqM0ZRj4xvYhrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698636; c=relaxed/simple;
	bh=HjxXQQTvclGKG5R5BVCKvlblWKeDppBCdGL0/w/TsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQpXHe3wS9Awwe3LlzTIExySXhK6K/5IhVAt2LdrGNosh3stCNKxko1TrhGE1NDZe4NlNqXG9kYFUcPiWJAL59xQR4Q0+KmksEyB8Ct0xBn3yyvbe962TCLeK7A/g3dn3llDXl+TCYSs314zg+uPxYTkd54SxZVncbDTz7yMa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzkgeu3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D9C433F1;
	Wed, 31 Jan 2024 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698635;
	bh=HjxXQQTvclGKG5R5BVCKvlblWKeDppBCdGL0/w/TsH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pzkgeu3+p2MwLnWBo/i2Hgnqw/ZmlOWIqzaaR7eedKbxIAzKq5mXhLYKJTCXxLm+Y
	 cgep8bB7Bzl7TaHLHcoqkNlKfAV+ZWTOYCotGp54EMnO/qLB+27hBCTMMPP3CYWiWx
	 Fs8Ny/9DWl+gSo0c7kbWJ/Ounmmrdn+R8xid6thwW7YJsyskwVfa55AAKEU1x6xn+7
	 ClWqPGH90dSSNpqDTYY32RT4CHWaYgiRyb3Q91LtZfmq2SoRsRAGTn/BdRcAAFwgcq
	 8vcTU2+Idk+/eD87gBkVtXdM4BsoM0DfN8QN+jdZGuY8xEfWLFR0R4tWw0Ftk/rof/
	 RPCaGEcDmLPKw==
Date: Wed, 31 Jan 2024 11:57:12 +0100
From: "mripard@kernel.org" <mripard@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "michel@daenzer.net" <michel@daenzer.net>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>, "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, 
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, 
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>, "sean@poorly.run" <sean@poorly.run>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>, 
	"fshao@chromium.org" <fshao@chromium.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jani.nikula@intel.com" <jani.nikula@intel.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Subject: Re: Re: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update
 hacks
Message-ID: <fnhpycf6yf4jmoaaryjjhrjp3mnb442t3zpyqsfuze3x3scy7w@hpgz432aswar>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
 <20230307145613.xvhru3fpcudlpazt@houat>
 <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
 <vyh5wg2ltmrtqw2mhtyj2lii6i4eccrjjlynzpfg7x63tkrav6@cxbz3sasvjjm>
 <afa82f2028296dbf586a5e61949179831d69af06.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hcnxgxxlxzr7qg7"
Content-Disposition: inline
In-Reply-To: <afa82f2028296dbf586a5e61949179831d69af06.camel@mediatek.com>


--5hcnxgxxlxzr7qg7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 31, 2024 at 05:27:14AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
>=20
> On Sun, 2024-01-28 at 10:24 +0100, Maxime Ripard wrote:
> > On Thu, Jan 25, 2024 at 07:17:21PM +0100, Daniel Vetter wrote:
> > > On Tue, Jan 23, 2024 at 06:09:05AM +0000, Jason-JH Lin (=E6=9E=97=E7=
=9D=BF=E7=A5=A5) wrote:
> > > > Hi Maxime, Daniel,
> > > >=20
> > > > We encountered similar issue with mediatek SoCs.
> > > >=20
> > > > We have found that in drm_atomic_helper_commit_rpm(), when
> > > > disabling
> > > > the cursor plane, the old_state->legacy_cursor_update in
> > > > drm_atomic_wait_for_vblank() is set to true.
> > > > As the result, we are not actually waiting for a vlbank to wait
> > > > for our
> > > > hardware to close the cursor plane. Subsequently, the execution
> > > > proceeds to drm_atomic_helper_cleanup_planes() to  free the
> > > > cursor
> > > > buffer. This can lead to use-after-free issues with our hardware.
> > > >=20
> > > > Could you please apply this patch to fix our problem?
> > > > Or are there any considerations for not applying this patch?
> > >=20
> > > Mostly it needs someone to collect a pile of acks/tested-by and
> > > then land
> > > it.
> > >=20
> > > I'd be _very_ happy if someone else can take care of that ...
> > >=20
> > > There's also the potential issue that it might slow down some of
> > > the
> > > legacy X11 use-cases that really needed a non-blocking cursor, but
> > > I think
> > > all the drivers where this matters have switched over to the async
> > > plane
> > > update stuff meanwhile. So hopefully that's good.
> >=20
> > I think there was also a regression with msm no one really figured
> > out?
>=20
> OK...
> But I am only available on MediaTek platform.

I think most of us are in that situation, and which is part of the
reason it kind of stalled :)

> Does it also causes a regression with msn if I re-send a patch for
> drm_atomic_helper.c only?

Yes, that's my recollection at least.

Fortunately, Dmitry might be able to clear that up.

Maxime

--5hcnxgxxlxzr7qg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZboniAAKCRDj7w1vZxhR
xYCCAP0csImA/YjD7JSlWCeV9u6MhNi6I3Xxd+iiSif3+wOZNAEAxvXjP7nLFw0A
7p53QCY/Y9Y7o9UlXM3Ql3BtsLQwnwU=
=jjPN
-----END PGP SIGNATURE-----

--5hcnxgxxlxzr7qg7--

