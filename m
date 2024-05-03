Return-Path: <linux-kernel+bounces-167926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231C8BB12C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962511F22671
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B681156C57;
	Fri,  3 May 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWErinrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63B15687F;
	Fri,  3 May 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754751; cv=none; b=NE3ePSFUJlvA5XxCZbNOacoas/QUBOZMd7cHthUVY9QE2o/niDA0/pa6NGJPRBudzWAJFGR4WHHj5ugpo6G9cceZA2Biv+NdpFzovIEWLxTjLpXSDFUN/jF0vgy3tnTV3+A1fFGn8Jg/3teHTTMuS1t+9FtP8x1+nMLCXxBgbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754751; c=relaxed/simple;
	bh=vsZuJtE5RGT667IHPY/tz9/wy6NQgx5LKgSSROUkDps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXNpURQyIV3tWjicy1zlGiiuia/sy5WYj6uHArj/n7Ww9gsWamTYHvYqUf/xOlCg+2ncK+9R9CJA5ck3Q5a3Wqfog0zbQ8kMlzwh2yBffbvXYJBFFroYeQe+QHyEG3kyNMh1OoKYzoOJ5eVXG2bKjE041YjU3xqjUoVuiWH3SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWErinrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC64C4AF1B;
	Fri,  3 May 2024 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714754751;
	bh=vsZuJtE5RGT667IHPY/tz9/wy6NQgx5LKgSSROUkDps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWErinrARu9gq/beFo4aJATTpl6SurxgGw/4MRM7iH629nDeRtt8drkMJmAH+RDBa
	 Kkn1caeXiYr7BfU27hiui52fBBdUBvSez1mvpAVA9OnA+blZSfoJHrGqNaT2bvAHZV
	 iddS04wrO6neD6XOv2U6EHOnDnwbTgcYMj6aNRYNcLYOAi0WQj/JV7gJdpaUVUBhO7
	 xw35DmsopLc7pYjIg/MJtxu7/Y1l9G6Q77+F1iA/e1f6jkjDeDHJo/9vp1ZuONgvju
	 zwBwH8J+dn+c/Rmo03WQqWh4252rxtpY5iAaO/hSDVTU4UdzfhlNCzQHOJ58zejxwq
	 nn+LKZpGEKmsA==
Date: Fri, 3 May 2024 17:45:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add a perporty to
 change TDM setting
Message-ID: <20240503-footrest-gladly-c0ed7d92d816@spud>
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
 <20240502-anx-tdm-v1-1-894a9f634f44@chromium.org>
 <20240502-sheath-share-eac9afc24da9@spud>
 <CAHc4DN+mCbBuB3D9kB2x8HYj9iaX7t6Q4Qjj7hotH3u=eAHJSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OIMQ9YJ2fz4azP4P"
Content-Disposition: inline
In-Reply-To: <CAHc4DN+mCbBuB3D9kB2x8HYj9iaX7t6Q4Qjj7hotH3u=eAHJSg@mail.gmail.com>


--OIMQ9YJ2fz4azP4P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 02:58:16PM +0800, Hsin-Te Yuan wrote:
> On Thu, May 2, 2024 at 10:47=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 02, 2024 at 09:03:31AM +0000, Hsin-Te Yuan wrote:
> > > Add a perporty to indicate whether anx7625 should shift the first aud=
io
> > > data bit. The default TDM setting is to shift the first audio data bi=
t.
> > >
> > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > ---
> > >  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml        =
  | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogi=
x,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,=
anx7625.yaml
> > > index a1ed1004651b9..915d5d54a2160 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx76=
25.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx76=
25.yaml
> > > @@ -82,6 +82,10 @@ properties:
> > >      type: boolean
> > >      description: let the driver enable audio HDMI codec function or =
not.
> > >
> > > +  no-shift-audio-data:
> > > +    type: boolean
> > > +    description: Disable the first audio data bit shift in the TDM s=
ettings.
> >
> > This just looks like software policy, since there's no mention in the
> > commit message or description as to what property of the hardware causes
> > this to be required. Can you please explain why this property is needed?
> >
> > You're also missing a vendor prefix.
>=20
> Sorry, I found this feature in the datasheet originally, but after
> deeper investigation, it seems that this feature should be used to
> support i2s dsp mode b instead of being used this way. Note that the
> difference between i2s dsp mode a and b is whether or not to shift the
> audio data by 1 clock cycle.

Are you trying to say that this patch is not needed? I'm not really
sure.

--OIMQ9YJ2fz4azP4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUUuQAKCRB4tDGHoIJi
0s+mAP9xrZEuq+pdJoaqDYfIjbY9yCD7iBiC5GCSfYGFAvVblQEAmEnup6FVQQnj
FEOeiYDFL8Lbl43MM89934A9LqjnDww=
=MuBv
-----END PGP SIGNATURE-----

--OIMQ9YJ2fz4azP4P--

