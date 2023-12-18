Return-Path: <linux-kernel+bounces-3711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2781701E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038A8285AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD2129ECC;
	Mon, 18 Dec 2023 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhWBueRn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E95A876;
	Mon, 18 Dec 2023 13:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB46C433C8;
	Mon, 18 Dec 2023 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905189;
	bh=udY2ZVYbIZd5ZCe58uJ//Cte5cbMyGl062PfD6ipia8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhWBueRnhK0JsdbnxH4+BY37nfhJ46YbxaBGKzscfg+bDukJ0xtuuKQhqZ90N+xrd
	 DnWZvroui0d1TjJ3YU7pR+v4T3FBVzMWB+XjOUgOT2f6xSgwV9VUgs0WUphcGe1Auo
	 Sz9vu2+Xthx4C7T3ckCWDWHLHKcLoUyC78mYi/WXmlF3yL9dvZL//Tp8WHE+VSmPlc
	 ZEiEvtV8thrqjPDo/6Br+rEmCItsTeVv0IU+WHQg5AafCOaVg1mxLwz5px90CYrVOo
	 H8Y8aGW7qZA6r/QldRxslG1Tc1BzajLkpTWXKZm4DxEpcv1fal+P4xDiNa3yYlheZr
	 oOYIxgBZw6OPA==
Date: Mon, 18 Dec 2023 14:13:06 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/27] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Message-ID: <tceu6ks2twjowohui3tpik7fhgplua6zv22je4ikihugccqb7w@whq7zgvbh3tl>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-21-knaerzche@gmail.com>
 <rrtknir3vizvcyamp3kfy47r6uppn3wwevb6a5gln2k533t52z@otm6vum6pg43>
 <c58b97ca-3faa-4bf2-8d7c-7ff34e0428ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jgxrix7gwqmw7nf2"
Content-Disposition: inline
In-Reply-To: <c58b97ca-3faa-4bf2-8d7c-7ff34e0428ca@gmail.com>


--jgxrix7gwqmw7nf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 01:37:47PM +0100, Alex Bee wrote:
>=20
> Am 18.12.23 um 10:05 schrieb Maxime Ripard:
> > On Sat, Dec 16, 2023 at 05:26:31PM +0100, Alex Bee wrote:
> > > @@ -431,6 +452,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
> > >   	else
> > >   		inno_conn_state->colorimetry =3D HDMI_COLORIMETRY_ITU_709;
> > > +	inno_conn_state->rgb_limited_range =3D
> > > +		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_RANGE_L=
IMITED;
> > > +
> > >   	/* Mute video and audio output */
> > >   	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
> > >   		  v_AUDIO_MUTE(1) | v_VIDEO_MUTE(1));
> > This needs to be done at atomic_check time: the expectation is that by
> > the time you commit the state, everything is prepared for it.
> OK. I guess that also applies to the other members of
> inno_hdmi_connector_state (former hdmi_data) and was wrong all the time.

Yeah, this will apply to all the members of inno_hdmi_connector_state indeed

Maxime

--jgxrix7gwqmw7nf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYBFYgAKCRDj7w1vZxhR
xY2XAQCR6tCncnAWA8MdEVEaMfWfdUgSjMlsog4s3k0fwAsIlAD/cfsVKMaQvv/v
EP9lwRSub/nFdJFP70GUiOmW3sWmZgM=
=BBqm
-----END PGP SIGNATURE-----

--jgxrix7gwqmw7nf2--

