Return-Path: <linux-kernel+bounces-111329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9F886AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1BC2864F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1A3E487;
	Fri, 22 Mar 2024 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpA6X1Lo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402933A8C3;
	Fri, 22 Mar 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105077; cv=none; b=kiYAeBajcl0+COacI37SCfAzJuSO/sExnr6/NS0TIzOR7x4lWjLZF3DgRqeAxMI13s+nketMQEAjsBww3evZ11gK5r8PR4Ql0B0nbNyl5x5TTng4DUE5LPDUP/9jf7QFFd8NEzUprFGOXp7qA97WA7iXUygnOUOIwI5tdBrvcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105077; c=relaxed/simple;
	bh=nlaETEiIGQ2eTWX7oKqL74fXDifhnhPwROBUgVdqU3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR09vVzUWbZdfHI8b67Ac3vvGYH4rAnv/jDQ9gNosnczA+1C6vI1aEAfXaU07HXugamapBzSYwhEm9f+M4lAOfXxEv7IK6cYkY0QKXx/lArV9J8eIMIYVvND2k9qODH+LoYmoGx9jNKpbdT0+2PqZCcGnefjYD3EpHiqCj2AmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpA6X1Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45857C433F1;
	Fri, 22 Mar 2024 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711105076;
	bh=nlaETEiIGQ2eTWX7oKqL74fXDifhnhPwROBUgVdqU3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpA6X1LoXT1snLrEBUrv47M4O+WPR1M1LSXUKZTKa7BviiI5MfgnUuEJ6uLymJngV
	 SvMs2KzBEf1XJrTAdpCwLwLzsvO6rZP4C/Mup2j5bb50a7peYF5b9rigdIigmfJTCw
	 x22flsf8LNzqlu2TPnGKoHlzRXcnvy7/kbFaAzWZj1PY2xlXBDWtIiKQ5LpjhGFWGb
	 zDPPY1CKcX0T1MKMmwwyc+j6Oy/g+LisuATN6Lqd7NeaeWrYlv6xV9DLxeC+JMwXwj
	 F9oaSkOyNOe5SCtc35wwS5an8ku2gHo6udRMm55JpxeArLi6VkFSW/wVgqvm4BFlVs
	 5spXkcfvxXDNQ==
Date: Fri, 22 Mar 2024 11:57:53 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [v10,20/27] drm/connector: hdmi: Add Infoframes generation
Message-ID: <20240322-petite-fabulous-bustard-b168ec@houat>
References: <20240321-kms-hdmi-connector-state-v10-20-e6c178361898@kernel.org>
 <07125064-2a78-4515-bb48-655f2aec140f@linux.dev>
 <87sf0iliyh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jkqjvw553wk4yfqo"
Content-Disposition: inline
In-Reply-To: <87sf0iliyh.fsf@intel.com>


--jkqjvw553wk4yfqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:22:14AM +0200, Jani Nikula wrote:
> On Fri, 22 Mar 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> > Hi,
> >
> >
> > On 2024/3/21 23:29, Maxime Ripard wrote:
> >> Infoframes in KMS is usually handled by a bunch of low-level helpers
> >> that require quite some boilerplate for drivers. This leads to
> >> discrepancies with how drivers generate them, and which are actually
> >> sent.
> >>
> >> Now that we have everything needed to generate them in the HDMI
> >> connector state, we can generate them in our common logic so that
> >> drivers can simply reuse what we precomputed.
> >>
> >> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >> ---
> >>   drivers/gpu/drm/Kconfig                            |   1 +
> >>   drivers/gpu/drm/drm_atomic_state_helper.c          | 338 +++++++++++=
++++++++++
> >>   drivers/gpu/drm/drm_connector.c                    |  14 +
> >>   .../gpu/drm/tests/drm_atomic_state_helper_test.c   |   1 +
> >>   drivers/gpu/drm/tests/drm_connector_test.c         |  12 +
> >>   include/drm/drm_atomic_state_helper.h              |   8 +
> >>   include/drm/drm_connector.h                        | 109 +++++++
> >>   7 files changed, 483 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> >> index 16029435b750..3d3193c7aa5f 100644
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -97,10 +97,11 @@ config DRM_KUNIT_TEST
> >>   	  If in doubt, say "N".
> >>  =20
> >>   config DRM_KMS_HELPER
> >>   	tristate
> >>   	depends on DRM
> >> +	select DRM_DISPLAY_HDMI_HELPER
> >
> > Should we select DRM_DISPLAY_HELPER here? Otherwise there will have som=
e compile error
> > emerged with default config.
>=20
> Can we stop abusing select instead of adding more selects to paper over
> the issues?
>=20
> Use select only for non-visible symbols (no prompts anywhere) and for
> symbols with no dependencies.

I don't really have an opinion there, but it looks like all the other
helpers Kconfig symbols are using select everywhere, and I don't really
see how we could turn them into visible symbols with depends on without
breaking a number of defconfig.

Could you expand a bit what you have in mind here?

Maxime

--jkqjvw553wk4yfqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZf1kMQAKCRDj7w1vZxhR
xc/HAQDR4BAgJekMdSngCGLSGAIwvYKEqlQRiRUN6fMwNgtn8AD/ZP+T1gMMLHE4
j3QwJraA/yFE8keMCRsPbgZVFnq1UQk=
=gyOa
-----END PGP SIGNATURE-----

--jkqjvw553wk4yfqo--

