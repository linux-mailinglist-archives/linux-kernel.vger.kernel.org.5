Return-Path: <linux-kernel+bounces-163493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868078B6C16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87B21C22063
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353403EA83;
	Tue, 30 Apr 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3j4NGN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB593BB21
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463288; cv=none; b=QOKendVrIEbUfF9FpvKBAfttrB0aFK1GuQlyd/BFWUx26y+ZEIcpL0zl3vqVrxHcMsvdOpzMmAUVlpZSQVeXAoboscDRI15dfvfTmBkZCQPZVi9P1HlUYzWWb1S6AKpnxaM6e6OjF6ktH7RdeSIfXtcqjjOvwavparrvvjG2PlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463288; c=relaxed/simple;
	bh=9IhoDrLW5nla3PkdfiFXqy+CBqAGV0puxz21Q1cMMhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxBJt1kAq/h8UqNBZw+48hK5qd5srDhNunN7D2kJ6PikbsOS9Dx4uqtC4BMDpQ6M1tNYZAL3fkR3O8CJ5J4U/4YyFUX0Puz75VQVga7xpFb0wsMF4hYD9y39l/Z6yRFN6e5cPmyL9jBvwzjra41nvORFT7KJWzzp0LLOu9yvhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3j4NGN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01D8C2BBFC;
	Tue, 30 Apr 2024 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714463288;
	bh=9IhoDrLW5nla3PkdfiFXqy+CBqAGV0puxz21Q1cMMhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3j4NGN90P1GmyQQZcPK/CCn5HXBpRxqpfpBMjPyL6V+WuLs+vRwa9bhCkFvf2Ypk
	 CzCK8BwSeEyDG9CfSTutylcTBbnnjDCw7jayRL3BEadM690pBlnxcWNQhadXREO1aE
	 zZpOSJPJXmSPNPYodAUpTnSOSlha4iWzZ0v95ipKKTh6HmWO6jfvRVo/AteUos0gyM
	 pmTPyaOSoJIlZX7sGBY8NkLvjZ4tsnbk9zPVvNzoah5m0mZl66RKHgPosxZw7oYPNJ
	 ODdcC8hGQWGlb/xKfwCZCaFGey6QzbRahjO0nE2fP6aahKt3yMu1HSE3M4TXw0NWkQ
	 boFt3JByVTJBw==
Date: Tue, 30 Apr 2024 09:48:05 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Robert Foss <rfoss@kernel.org>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
Message-ID: <20240430-exuberant-ludicrous-caiman-bc7dac@houat>
References: <20240322104732.2327060-1-sean@geanix.com>
 <20240424-famous-fascinating-hyena-8fb3a7@houat>
 <cvzecixldubeq7pwn77cggs7tcwc5on3arlnboj4fbpqgdygtu@hat3r6afzu7y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3ku2wna3thhbsakw"
Content-Disposition: inline
In-Reply-To: <cvzecixldubeq7pwn77cggs7tcwc5on3arlnboj4fbpqgdygtu@hat3r6afzu7y>


--3ku2wna3thhbsakw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 10:17:45AM +0200, Sean Nyekjaer wrote:
> On Wed, Apr 24, 2024 at 09:21:17AM UTC, Maxime Ripard wrote:
> > Hi,
> >=20
> > Sorry, my previous review didn't go through.
> >=20
> > On Fri, Mar 22, 2024 at 11:47:31AM +0100, Sean Nyekjaer wrote:
> > > When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
> > > to reguire the requested and the actual px clock to be within
> > > 50Hz. A typical LVDS display requires the px clock to be within +-10%.
> > >=20
> > > In case for HDMI .5% tolerance is required.
> > >=20
> > > Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mod=
e_valid()")
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/=
stm/dw_mipi_dsi-stm.c
> > > index d5f8c923d7bc..97936b0ef702 100644
> > > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > > @@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsig=
ned int lane_mbps,
> > >  	return 0;
> > >  }
> > > =20
> > > -#define CLK_TOLERANCE_HZ 50
> > > -
> > >  static enum drm_mode_status
> > >  dw_mipi_dsi_stm_mode_valid(void *priv_data,
> > >  			   const struct drm_display_mode *mode,
> > > @@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
> > >  		/*
> > >  		 * Filter modes according to the clock value, particularly useful =
for
> > >  		 * hdmi modes that require precise pixel clocks.
> > > +		 * Check that px_clock is within .5% tolerance.
> > >  		 */
> > > -		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
> > > -		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
> > > +		if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000) ||
> > > +		    px_clock_hz > mult_frac(target_px_clock_hz, 1005, 1000))
> > >  			return MODE_CLOCK_RANGE;
> >=20
> > I wonder if it's not something that should be made into a helper. We
> > have a couple of drivers doing it already, so it might be worth creating
> > a function that checks for a given struct clk pointer and pixel clock if
> > it's within parameters.
> >=20
> > Maxime
>=20
> Yes agree, if the same calculation is happening other places.
> I can't identify where it happens though.

sun4i has one:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_=
rgb.c#L123

> Would that helper function exist in drivers/gpu/drm/drm_hdmi_helper.c ?

There's nothing related to HDMI per se, so in drm_modes is probably
better.

Maxime


--3ku2wna3thhbsakw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZjCiLQAKCRAnX84Zoj2+
ds5wAYDHGuIdIPY8LGE5jCxGK/zlexyRCxqHgMO/chCJQKe8587hAVvgA6kCEjOG
8wElsZsBgOUQR5Rq+np631HT2l10Ql64rLGh4vOK+pluY8lwaT5XM5UI5MXsn+dH
OEGAeKFVbw==
=xyGn
-----END PGP SIGNATURE-----

--3ku2wna3thhbsakw--

