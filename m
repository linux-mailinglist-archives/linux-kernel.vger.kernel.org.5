Return-Path: <linux-kernel+bounces-62029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EC851A83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89311F25D07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92E040C03;
	Mon, 12 Feb 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAfT1NMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11243D566;
	Mon, 12 Feb 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757225; cv=none; b=ZgVympTXr1DHOvRxOFF718i1V57FQxbuA8EtYGcw1SzbmCcSbut/qa7Mmy6qt5p/7eXPADtBYWUJXpxFpR2IjYByEO+33YMyi0Icj5nFtV4Qt0lLzVJAICLyqd00OYwM/DDkxAA7TEjmbpdSLOvgs3J+BLFshDq5EF2BHCVCvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757225; c=relaxed/simple;
	bh=23GlKxi6SKbpymZhKOpPvd4nx5AbJXoryqiHUnQ4NF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6Lfdrbpu3SIDIAf8B1buwrX3UG9WAmU4ygQ36yPODyMNcti4bupV5KhWD3iMOotvF4ACC0WRr+EeCh+RU8/BIfVEMngLXJhW5lkrMzOgzHobxAaTDpxt1bwFpyHOzpOA/W5IDSard2ssuTyBYGdiG8IRpzcjb84NocU/TQBvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAfT1NMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CECCC433C7;
	Mon, 12 Feb 2024 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757224;
	bh=23GlKxi6SKbpymZhKOpPvd4nx5AbJXoryqiHUnQ4NF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAfT1NMF+9MYK69hpLPvnDCPl9nEvJg85QJOzhzex5/YilIHgA2eKwGh6mJOae6qx
	 0eOYGUXEVM9jNZG+Za9BoqHaQG357dUXfo1y0DfcGq/ywouu+DppEThV8M6I0iBV3B
	 YHPTJiUvBY6RBi6bQkDiyAp/tKT4wPj6bd67HuY/cvi9GRt8uNujpqm02lBztqyphW
	 oOGdyohruG0O3gwqjUKl7iztdlh7JMc9W8ORxu/2Y6u+qYQHhQIT3rwNqlBM1hVG/L
	 o8mE1+5v0tjxqZYpecpv+jaPxRmRuunEom3+Y5tOTsGSBfQKBo44Ln26d3RFMGjMAE
	 ARn9QETaWYJig==
Date: Mon, 12 Feb 2024 18:00:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Sebastian Wick <sebastian.wick@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <tb6yqictmlpwokeihyyh4wxabrp6xs3zgvfpxjeulkmoxloysa@caqtn5fyc7cs>
References: <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
 <Zco-DQaXqae7B1jt@intel.com>
 <0b3e31e6-34ae-46e3-a43d-bc4895542d8a@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgxaisih3zxhrtkb"
Content-Disposition: inline
In-Reply-To: <0b3e31e6-34ae-46e3-a43d-bc4895542d8a@xs4all.nl>


--rgxaisih3zxhrtkb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:39:03PM +0100, Hans Verkuil wrote:
> On 12/02/2024 16:49, Ville Syrj=E4l=E4 wrote:
> > On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> >> On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> >>> On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> >>>> On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrj=E4l=E4 wrote:
> >>>>> On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> >>>>>> On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrj=E4l=E4 wrote:
> >>>>>>> On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> >>>>>>>>>>>  /**
> >>>>>>>>>>>   * DOC: HDMI connector properties
> >>>>>>>>>>>   *
> >>>>>>>>>>> + * Broadcast RGB
> >>>>>>>>>>> + *      Indicates the RGB Quantization Range (Full vs Limite=
d) used.
> >>>>>>>>>>> + *      Infoframes will be generated according to that value.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + *      The value of this property can be one of the followi=
ng:
> >>>>>>>>>>> + *
> >>>>>>>>>>> + *      Automatic:
> >>>>>>>>>>> + *              RGB Range is selected automatically based on=
 the mode
> >>>>>>>>>>> + *              according to the HDMI specifications.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + *      Full:
> >>>>>>>>>>> + *              Full RGB Range is forced.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + *      Limited 16:235:
> >>>>>>>>>>> + *              Limited RGB Range is forced. Unlike the name=
 suggests,
> >>>>>>>>>>> + *              this works for any number of bits-per-compon=
ent.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + *      Drivers can set up this property by calling
> >>>>>>>>>>> + *      drm_connector_attach_broadcast_rgb_property().
> >>>>>>>>>>> + *
> >>>>>>>>>>
> >>>>>>>>>> This is a good time to document this in more detail. There mig=
ht be two
> >>>>>>>>>> different things being affected:
> >>>>>>>>>>
> >>>>>>>>>> 1. The signalling (InfoFrame/SDP/...)
> >>>>>>>>>> 2. The color pipeline processing
> >>>>>>>>>>
> >>>>>>>>>> All values of Broadcast RGB always affect the color pipeline p=
rocessing
> >>>>>>>>>> such that a full-range input to the CRTC is converted to eithe=
r full- or
> >>>>>>>>>> limited-range, depending on what the monitor is supposed to ac=
cept.
> >>>>>>>>>>
> >>>>>>>>>> When automatic is selected, does that mean that there is no si=
gnalling,
> >>>>>>>>>> or that the signalling matches what the monitor is supposed to=
 accept
> >>>>>>>>>> according to the spec? Also, is this really HDMI specific?
> >>>>>>>>>>
> >>>>>>>>>> When full or limited is selected and the monitor doesn't suppo=
rt the
> >>>>>>>>>> signalling, what happens?
> >>>>>>>>>
> >>>>>>>>> Forgot to mention: user-space still has no control over RGB vs =
YCbCr on
> >>>>>>>>> the cable, so is this only affecting RGB? If not, how does it a=
ffect
> >>>>>>>>> YCbCr?
> >>>>>>>>
> >>>>>>>> So I dug a bit into both the i915 and vc4 drivers, and it looks =
like if
> >>>>>>>> we're using a YCbCr format, i915 will always use a limited range=
 while
> >>>>>>>> vc4 will follow the value of the property.
> >>>>>>>
> >>>>>>> The property is literally called "Broadcast *RGB*".
> >>>>>>> That should explain why it's only affecting RGB.
> >>>>>>
> >>>>>> Right. And the limited range option is called "Limited 16:235" des=
pite
> >>>>>> being usable on bpc > 8 bits. Naming errors occurs, and history ha=
ppens
> >>>>>> to make names inconsistent too, that's fine and not an argument in
> >>>>>> itself.
> >>>>>>
> >>>>>>> Full range YCbCr is a much rarer beast so we've never bothered
> >>>>>>> to enable it.
> >>>>>>
> >>>>>> vc4 supports it.
> >>>>>
> >>>>> Someone implemented it incorrectly then.
> >>>>
> >>>> Incorrectly according to what documentation / specification? I'm sor=
ry,
> >>>> but I find it super ironic that i915 gets to do its own thing, not
> >>>> document any of it, and when people try to clean things up they get =
told
> >>>> that we got it all wrong.
> >>>
> >>> FWIW, this was an i915 property and if another driver uses the same
> >>> property name it must have the same behavior. Yes, it isn't standardi=
zed
> >>> and yes, it's not documented (hence this effort here) but it's still =
on
> >>> vc4 to make the property compatible.
> >>
> >> How is it not compatible? It's a superset of what i915 provides, but
> >> it's strictly compatible with it.
> >=20
> > No it is not. Eg. what happens if you set the thing to full range for
> > RGB (which you must on many broken monitors), and then the kernel
> > automagically switches to YCbCr (for whatever reason) but the monitor
> > doesn't support full range YCbCr? Answer: you get crap output.
>=20
> The Broadcast RGB setting is really specific to RGB output. That's where
> you need it, since due to messed up standards in the past it is common to
> have to override this.
>=20
> For YCbCr it is not needed since it is always limited range in practice.
> If there is ever a need to support full range YCbCr, then a new "Broadcas=
t YCbCr"
> setting should be created.

We can't implement that, really. The userspace has no way to tell if RGB
or YUV is going to be used, so it wouldn't have an idea of what property
it needs to set.

Maxime

--rgxaisih3zxhrtkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcpOpQAKCRDj7w1vZxhR
xZRhAQDgzOvjHtEk87wVFNGYJRmh3AbgAKmVCVK3kTQhu5goyQEA0NrHid0moGG/
UQF/sR6UvF75IRKOMVufzYXvhc19ow8=
=0KDO
-----END PGP SIGNATURE-----

--rgxaisih3zxhrtkb--

