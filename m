Return-Path: <linux-kernel+bounces-103452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B150687BF84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C6285707
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E371740;
	Thu, 14 Mar 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW3gfuAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1F71720;
	Thu, 14 Mar 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428672; cv=none; b=BpwuRSirfLZDco4whBKJmjt0ZF76i+S7OcF+JPJzfGoyDnZ7GH8NHyv2x1AWtbG6CAI9VPgD+V7Zgt70H2s9Y1YqSJDgtZkrbOmBAZ1y8b8GTipnYMgtZ+38KRSke5Bm5Ge8vM3HaX3NIyj/rgxKzoVQKxN0CeqaGhR1hTnYi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428672; c=relaxed/simple;
	bh=6P2LfVI5ti9AMF7ok98eGXZ4p8eeBn7+IOGZj+oGtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlYjRdvOYHlBrGy7cp1e00j7aF9+UruHlGgts+xh64uud8WknesS+tfAPw5FcOGKzvVe/jcfML2GsBwdOh+s51/TCr8Z90CnXvIbEVOo1ZsJQ/Xj97ZR5qL26MEWLp0QuU1nIDb205KnyDvvrphlDMhplF4/CWlV9gtygS3kDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW3gfuAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71EC43390;
	Thu, 14 Mar 2024 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710428672;
	bh=6P2LfVI5ti9AMF7ok98eGXZ4p8eeBn7+IOGZj+oGtQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CW3gfuAuCwxjr9HzOCCsYaD4IGJFlf+7m3r5gtdj73datUqZH5K4bZBIlzoHEp4EG
	 s7b+oApWzWyv4SHNmiaRZPpLN9IE6ZASCQY8YpSbpCwuuQuJqir+CbpE0/DvaPl+No
	 hHoGYga0Cow/amTVofqHKl2rhr8c2yfyjskaRYFZWysBegJCkyBMkZZF4Etdk6q/U8
	 ioB3t+kvr34JNxjQPUGBRVpen66UVVAzXCuutuaHTTSKaEY2wsTSiQyc+DjoOYdlND
	 19ABvjYS5nYdBnBRbP3g79ZIY12W006rpoU7xqqyQcEournDhY3rIKvfp1YUnGibD8
	 PT8IYkHIv4iKg==
Date: Thu, 14 Mar 2024 16:04:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@aculab.com>, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>, 
	Dave Airlie <airlied@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Message-ID: <20240314-thundering-steadfast-goat-a685cc@houat>
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
 <20240304-brawny-goshawk-of-sorcery-860cef@houat>
 <85b807289ff2400ea5887ced63655862@AcuMS.aculab.com>
 <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myyknztutswewlxd"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUuOnXVpocYU02Mx3_KrPow-=+WgLJqy_ku=AN52SvQiA@mail.gmail.com>


--myyknztutswewlxd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:27:23AM +0100, Geert Uytterhoeven wrote:
> On Sat, Mar 9, 2024 at 3:34=E2=80=AFPM David Laight <David.Laight@aculab.=
com> wrote:
> > From: Maxime Ripard
> > > Sent: 04 March 2024 11:46
> > >
> > > On Mon, Mar 04, 2024 at 12:11:36PM +0100, Arnd Bergmann wrote:
> > > > On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > > > > The arm defconfig builds failed on today's Linux next tag next-20=
240304.
> > > > >
> > > > > Build log:
> > > > > ---------
> > > > > ERROR: modpost: "__aeabi_uldivmod"
> > > > > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> > > > >
> > > >
> > > > Apparently caused by the 64-bit division in 358e76fd613a
> > > > ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
> > > >
> > > >
> > > > +static enum drm_mode_status
> > > > +sun4i_hdmi_connector_clock_valid(const struct drm_connector *conne=
ctor,
> > > > +                                const struct drm_display_mode *mod=
e,
> > > > +                                unsigned long long clock)
> > > >  {
> > > > -       struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encod=
er);
> > > > -       unsigned long rate =3D mode->clock * 1000;
> > > > -       unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDM=
I spec */
> > > > +       const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hd=
mi(connector);
> > > > +       unsigned long diff =3D clock / 200; /* +-0.5% allowed by HD=
MI spec */
> > > >         long rounded_rate;
> > > >
> > > > This used to be a 32-bit division. If the rate is never more than
> > > > 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> > > > the expensive div_u64().
> > >
> > > I sent a fix for it this morning:
> > > https://lore.kernel.org/r/20240304091225.366325-1-mripard@kernel.org
> > >
> > > The framework will pass an unsigned long long because HDMI character
> > > rates can go up to 5.9GHz.
> >
> > You could do:
> >         /* The max clock is 5.9GHz, split the divide */
> >         u32 diff =3D (u32)(clock / 8) / (200/8);
>=20
> +1, as the issue is still present in current next, as per the recent
> nagging from the build bots.

A patch to fix it has been merged today and will show up tomorrow in next.

Maxime

--myyknztutswewlxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfMR/QAKCRDj7w1vZxhR
xeThAP9hu9uZyhsosg4xaXjQSqrklVzWAccxuvVo+wD/BvBe5AD7BfMoiWAkmZWD
we529wvyNXrp/62iho4i01acFGaHUgA=
=x+QF
-----END PGP SIGNATURE-----

--myyknztutswewlxd--

