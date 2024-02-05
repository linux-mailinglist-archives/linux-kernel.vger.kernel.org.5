Return-Path: <linux-kernel+bounces-52332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D458496D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B11928AB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904514012;
	Mon,  5 Feb 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGjcGlZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C4813FF5;
	Mon,  5 Feb 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125982; cv=none; b=myQOnl8NbmxciQfBO6+VEep7dIeH1ATMqvDkjDIxjmjmSjKfk7eMIkt8X0mTkJhDOROJM7/TRzWLO+kUEs2cGFOxWgQzs5gipEzj1JeRJ7PHzNYqbOdC/9C0Vn+jnpMkZbcz+7Nph8Rx7Hzhn9ReQ/Zwr/MAEyqHOHL/fG5YuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125982; c=relaxed/simple;
	bh=QSsaMz2aa4Ow1e/E+8+zBv0RXCM/l1/3uCQIFHDC8Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH1DGC6mXiXK7in7CkFymcWTIndxO7VHifpjyim0hg3Z5r/NKyJl6QcZiu+4lM4clQD2wybYaB5FsmwirfFuugVBXWKmChQZUSjw1y1SuNEJef8pXKpe4e/M8WgtTIUX7ex2WJfXoOs/uAKtAddmPzQtqITjYLS4Oc+1ijgsLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGjcGlZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A85C433C7;
	Mon,  5 Feb 2024 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707125981;
	bh=QSsaMz2aa4Ow1e/E+8+zBv0RXCM/l1/3uCQIFHDC8Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGjcGlZS0fBCh8Pj91FOCfGeLuBLH2IJXsvlSDNMJNYXbieL6OYjONC2i8L3eyk2A
	 gDjW66Kot7LNXs+KGyl9mTfxQHJYFLZ3t0L1RLIN1Dm1Wck0ZHUJPEScRyxhMkJDmj
	 OXKlIi1RFgz/w6HuL5qsHb2rRJ71FEHpXG+35Ca18O49av3Z/EfEhdmPtI+kXJX0OP
	 ty/ICYtQbhjVujqeERH5pvK1Lj5IcwybfB49b1ssuH53OFwd8+WGgdjXHg0/GmHiR5
	 6HgFPBmIm+TpGHkQdx/8FL7eeEjve5s0Czv4tmwkki21i0l2PqfomTZ58KFKCHSM9S
	 99nBqUaN/35Jw==
Date: Mon, 5 Feb 2024 10:39:38 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Sebastian Wick <sebastian.wick@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Hans Verkuil <hverkuil@xs4all.nl>, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast
 RGB property
Message-ID: <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6rjjatuyp65otli"
Content-Disposition: inline
In-Reply-To: <Zb0aYAapkxQ2kopt@intel.com>


--i6rjjatuyp65otli
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrj=E4l=E4 wrote:
> On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrj=E4l=E4 wrote:
> > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > >  /**
> > > > > > >   * DOC: HDMI connector properties
> > > > > > >   *
> > > > > > > + * Broadcast RGB
> > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limite=
d) used.
> > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > + *
> > > > > > > + *      The value of this property can be one of the followi=
ng:
> > > > > > > + *
> > > > > > > + *      Automatic:
> > > > > > > + *              RGB Range is selected automatically based on=
 the mode
> > > > > > > + *              according to the HDMI specifications.
> > > > > > > + *
> > > > > > > + *      Full:
> > > > > > > + *              Full RGB Range is forced.
> > > > > > > + *
> > > > > > > + *      Limited 16:235:
> > > > > > > + *              Limited RGB Range is forced. Unlike the name=
 suggests,
> > > > > > > + *              this works for any number of bits-per-compon=
ent.
> > > > > > > + *
> > > > > > > + *      Drivers can set up this property by calling
> > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > + *
> > > > > >=20
> > > > > > This is a good time to document this in more detail. There migh=
t be two
> > > > > > different things being affected:
> > > > > >=20
> > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > 2. The color pipeline processing
> > > > > >=20
> > > > > > All values of Broadcast RGB always affect the color pipeline pr=
ocessing
> > > > > > such that a full-range input to the CRTC is converted to either=
 full- or
> > > > > > limited-range, depending on what the monitor is supposed to acc=
ept.
> > > > > >=20
> > > > > > When automatic is selected, does that mean that there is no sig=
nalling,
> > > > > > or that the signalling matches what the monitor is supposed to =
accept
> > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > >=20
> > > > > > When full or limited is selected and the monitor doesn't suppor=
t the
> > > > > > signalling, what happens?
> > > > >=20
> > > > > Forgot to mention: user-space still has no control over RGB vs YC=
bCr on
> > > > > the cable, so is this only affecting RGB? If not, how does it aff=
ect
> > > > > YCbCr?
> > > >=20
> > > > So I dug a bit into both the i915 and vc4 drivers, and it looks lik=
e if
> > > > we're using a YCbCr format, i915 will always use a limited range wh=
ile
> > > > vc4 will follow the value of the property.
> > >=20
> > > The property is literally called "Broadcast *RGB*".
> > > That should explain why it's only affecting RGB.
> >=20
> > Right. And the limited range option is called "Limited 16:235" despite
> > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > to make names inconsistent too, that's fine and not an argument in
> > itself.
> >=20
> > > Full range YCbCr is a much rarer beast so we've never bothered
> > > to enable it.
> >=20
> > vc4 supports it.
>=20
> Someone implemented it incorrectly then.

Incorrectly according to what documentation / specification? I'm sorry,
but I find it super ironic that i915 gets to do its own thing, not
document any of it, and when people try to clean things up they get told
that we got it all wrong.

> > > Eg. with DP it only became possible with the introduction of the VSC
> > > SDP (and I don't recall if there's additional capability checks that
> > > are also required). With DP MSA signalling full range YCbCr is not
> > > possible at all.
> >=20
> > This is for HDMI only.
> >=20
> > > I don't recall right now what the HDMI requirements are.
> >=20
> > HDMI has supported it for a while, and it's defined (for example) in the
> > HDMI 1.4 spec in Section 6.6 - Video Quantization Ranges. It supports
> > limited and full range on both RGB and YCbCr, as long as the EDIDs state
> > so and the Infoframes signal it.
>=20
> I think a good reason for not using a simple boolean like this=20
> YCbCr is that it doesn't cover the color encoding part at all,
> which is probably more important than the quantization range.
> So we need a new property anyway.

This isn't what is being discussed here, and as I've shown you, is
completely orthogonal as far as HDMI is concerned.

Maxime

--i6rjjatuyp65otli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcCs2gAKCRDj7w1vZxhR
xfaBAQD78t262ocyxX6HKmtZFJU24L6e/wHmLbEAi1D59Gs+tAEApB/D8z2XtVcT
HS9PH5mQL0RDg4t5JjTmJFk1zuBxygo=
=6BSH
-----END PGP SIGNATURE-----

--i6rjjatuyp65otli--

