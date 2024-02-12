Return-Path: <linux-kernel+bounces-62023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE3851A40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D44D1C21D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2046C3D568;
	Mon, 12 Feb 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uit7UK19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047C48781;
	Mon, 12 Feb 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756831; cv=none; b=ZgfcaJsyM9z2B1AH/EbXEh/AiRVAmpRUWv9rztUYk5YM1fF+EEgbcqr885k7aM/YUuWo/7APBjoykT7Mm0lxSQf61J8+f0Y91F1Ws3QtSmAFPKh0LEP+J6u2bhS+jcSiwlGKgOYj+Ra7YN1EqUG0afMv60FQb3CYGgGUSzlhemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756831; c=relaxed/simple;
	bh=YAw/HGS+6u4ljzekvMwi8YRyGpsKjAUvgKgNZYuRvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3jGCFYlvWNP56C9O45aJqi9gUh0hOaz6bRzPoDMuDdxacL8BFAHd1x1pswI8CBDIWpAk0CXLy07+HyD4wkZSldog0TFuSxM1wUMw8m1PHdhWQHdKErPvLqlOwSlvfjIN/9y31GSqRRUTuf9kTJmP0GMuAIcHEh9PCR6PH8TQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uit7UK19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD97C433C7;
	Mon, 12 Feb 2024 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756830;
	bh=YAw/HGS+6u4ljzekvMwi8YRyGpsKjAUvgKgNZYuRvSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uit7UK198EkZTPvb+3U02T6xybm5VOV43HIFuxsM2PEuVqkaqqlrN088Z5JxoUIOb
	 YPYvUWe3WP5SoozSgOXWjbp7riutRlykWkelrVM9pw1cr3A4I6oSANRnD+iw1DK+Xd
	 XfT29slnGEDRvr6k2LK6rhspEZ1CFlg8p5XMsrWoFOastw2sbk2S5cIcl1W05gUWeM
	 uVdOJC5Ckz65xWaLAfcWPaQ2Ep29orO0i+SeH4H3Yd6P6a7EmUpsH/Nv52Mr3EcuUh
	 Rb4VlfAfi7TuK3IHvBLSsdUQBUCuqWKNMe5N/SSQfariofifVFsQaaiUZTRMfYUSJy
	 NHhsrmEe0AIIg==
Date: Mon, 12 Feb 2024 17:53:48 +0100
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
Subject: Re: Re: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add
 Broadcast RGB property
Message-ID: <yx2t7xltxxgsngdsxamsfq6y7dze3wzegxcqwmsb5yrxen73x6@u3vilqhpci4w>
References: <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
 <Zco-DQaXqae7B1jt@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5bjhx7cwjpixgbt"
Content-Disposition: inline
In-Reply-To: <Zco-DQaXqae7B1jt@intel.com>


--k5bjhx7cwjpixgbt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:49:33PM +0200, Ville Syrj=E4l=E4 wrote:
> On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> > On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> > > On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > > > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrj=E4l=E4 wro=
te:
> > > > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wr=
ote:
> > > > > > > > > > >  /**
> > > > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > > > >   *
> > > > > > > > > > > + * Broadcast RGB
> > > > > > > > > > > + *      Indicates the RGB Quantization Range (Full v=
s Limited) used.
> > > > > > > > > > > + *      Infoframes will be generated according to th=
at value.
> > > > > > > > > > > + *
> > > > > > > > > > > + *      The value of this property can be one of the=
 following:
> > > > > > > > > > > + *
> > > > > > > > > > > + *      Automatic:
> > > > > > > > > > > + *              RGB Range is selected automatically =
based on the mode
> > > > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > > > + *
> > > > > > > > > > > + *      Full:
> > > > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > > > + *
> > > > > > > > > > > + *      Limited 16:235:
> > > > > > > > > > > + *              Limited RGB Range is forced. Unlike =
the name suggests,
> > > > > > > > > > > + *              this works for any number of bits-pe=
r-component.
> > > > > > > > > > > + *
> > > > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property(=
).
> > > > > > > > > > > + *
> > > > > > > > > >=20
> > > > > > > > > > This is a good time to document this in more detail. Th=
ere might be two
> > > > > > > > > > different things being affected:
> > > > > > > > > >=20
> > > > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > > > 2. The color pipeline processing
> > > > > > > > > >=20
> > > > > > > > > > All values of Broadcast RGB always affect the color pip=
eline processing
> > > > > > > > > > such that a full-range input to the CRTC is converted t=
o either full- or
> > > > > > > > > > limited-range, depending on what the monitor is suppose=
d to accept.
> > > > > > > > > >=20
> > > > > > > > > > When automatic is selected, does that mean that there i=
s no signalling,
> > > > > > > > > > or that the signalling matches what the monitor is supp=
osed to accept
> > > > > > > > > > according to the spec? Also, is this really HDMI specif=
ic?
> > > > > > > > > >=20
> > > > > > > > > > When full or limited is selected and the monitor doesn'=
t support the
> > > > > > > > > > signalling, what happens?
> > > > > > > > >=20
> > > > > > > > > Forgot to mention: user-space still has no control over R=
GB vs YCbCr on
> > > > > > > > > the cable, so is this only affecting RGB? If not, how doe=
s it affect
> > > > > > > > > YCbCr?
> > > > > > > >=20
> > > > > > > > So I dug a bit into both the i915 and vc4 drivers, and it l=
ooks like if
> > > > > > > > we're using a YCbCr format, i915 will always use a limited =
range while
> > > > > > > > vc4 will follow the value of the property.
> > > > > > >=20
> > > > > > > The property is literally called "Broadcast *RGB*".
> > > > > > > That should explain why it's only affecting RGB.
> > > > > >=20
> > > > > > Right. And the limited range option is called "Limited 16:235" =
despite
> > > > > > being usable on bpc > 8 bits. Naming errors occurs, and history=
 happens
> > > > > > to make names inconsistent too, that's fine and not an argument=
 in
> > > > > > itself.
> > > > > >=20
> > > > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > > > to enable it.
> > > > > >=20
> > > > > > vc4 supports it.
> > > > >=20
> > > > > Someone implemented it incorrectly then.
> > > >=20
> > > > Incorrectly according to what documentation / specification? I'm so=
rry,
> > > > but I find it super ironic that i915 gets to do its own thing, not
> > > > document any of it, and when people try to clean things up they get=
 told
> > > > that we got it all wrong.
> > >=20
> > > FWIW, this was an i915 property and if another driver uses the same
> > > property name it must have the same behavior. Yes, it isn't standardi=
zed
> > > and yes, it's not documented (hence this effort here) but it's still =
on
> > > vc4 to make the property compatible.
> >=20
> > How is it not compatible? It's a superset of what i915 provides, but
> > it's strictly compatible with it.
>=20
> No it is not.

The property is compatible with i915 interpretation of it, whether you
like it or not. And that's what Sebastian was referring to.

> Eg. what happens if you set the thing to full range for RGB (which you
> must on many broken monitors), and then the kernel automagically
> switches to YCbCr (for whatever reason) but the monitor doesn't
> support full range YCbCr? Answer: you get crap output.

And that part is just moving goalposts.

Maxime

--k5bjhx7cwjpixgbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcpNGgAKCRDj7w1vZxhR
xfarAQD/MUJVYddtEHcYiH30WG61KUe9uuF7BBzhV9p90mi/1wEAzvvBB5NnbxJG
soV3IKAH1pMyF7MGBPFUrFyn5MdJIg8=
=tvUE
-----END PGP SIGNATURE-----

--k5bjhx7cwjpixgbt--

