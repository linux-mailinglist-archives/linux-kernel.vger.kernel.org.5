Return-Path: <linux-kernel+bounces-3295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC321816A86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F992B218A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A112B97;
	Mon, 18 Dec 2023 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIjgKonP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9D14A99;
	Mon, 18 Dec 2023 10:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9E9C433C7;
	Mon, 18 Dec 2023 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702894003;
	bh=AwkgUvmIIlJRw6wjNIJtQ8AvdNLkhMFC6d/fk8gMjrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIjgKonPzMclEyKuNHco7lMvBubuPnpljdHzARGSMzyAU/Y3QrM9WAK6UHc0beTod
	 XAItiK9jQmcXA/kxrT6nfsofZkyxVqsBfvjD1bsHKkj8kkUdavPyfuXdSajnszuI9y
	 emEqal23SmNKd8XvZlsNLHsOSH/8gf55GZptxKODZvyiHpOi8FnFI+FqLKiSu298Od
	 V57+fD7DlS8SqRxHQM2ZevCl76nw5gsgOu38Ov6oCThXEMvOSdz4ybt/nyBwBIG9I6
	 Lu/eI/HB0pj/JlXOkRoTG+1McuQ9KHDefdAnBBByckN8pqE2U/pWGCXZeKToYCqmHY
	 EW4wEutjQYSXw==
Date: Mon, 18 Dec 2023 11:06:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/27] drm/rockchip: inno_hdmi: Move tmds rate to
 connector state subclass
Message-ID: <xte5vjc3o77wnlozz6sy5yysiezdxbzvbwdblhbqb5s2nwnnv5@xxknftdeo6uk>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-20-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktn4oocwkdhkmjca"
Content-Disposition: inline
In-Reply-To: <20231216162639.125215-20-knaerzche@gmail.com>


--ktn4oocwkdhkmjca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 16, 2023 at 05:26:30PM +0100, Alex Bee wrote:
> Similar to the othter members of inno_hdmi_connector_state the tmds_rate =
is
> not a property of the device, but of the connector state. Move it to
> inno_hdmi_connector_state and make it a long to comply with the clock
> framework. To get arround the issue of not having the connector state when
> inno_hdmi_i2c_init is called in the bind path, getting the tmds rate is
> wrapped in function which returns the fallback rate if the connector
> doesn't have a state yet.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> changes in v2:
>  - new patch
>=20
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 36 +++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockc=
hip/inno_hdmi.c
> index f9bfae1e97a2..6799d24501b8 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -47,14 +47,13 @@ struct inno_hdmi {
> =20
>  	struct inno_hdmi_i2c *i2c;
>  	struct i2c_adapter *ddc;
> -
> -	unsigned int tmds_rate;
>  };
> =20
>  struct inno_hdmi_connector_state {
>  	struct drm_connector_state	base;
>  	unsigned int			enc_out_format;
>  	unsigned int			colorimetry;
> +	unsigned long			tmds_rate;
>  };
> =20
>  static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encode=
r)
> @@ -133,11 +132,33 @@ static inline void hdmi_modb(struct inno_hdmi *hdmi=
, u16 offset,
>  	hdmi_writeb(hdmi, offset, temp);
>  }
> =20
> +static unsigned long inno_hdmi_tmds_rate(struct inno_hdmi *hdmi)
> +{
> +	struct drm_connector *connector =3D &hdmi->connector;
> +	struct drm_connector_state *conn_state =3D  connector->state;
> +	struct inno_hdmi_connector_state *inno_conn_state;
> +
> +	if (conn_state) {
> +		inno_conn_state =3D to_inno_hdmi_conn_state(conn_state);
> +		return inno_conn_state->tmds_rate;
> +	}
> +
> +	/*
> +	 * When IP controller haven't configured to an accurate video
> +	 * timing, then the TMDS clock source would be switched to
> +	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
> +	 * and reconfigure the DDC clock.
> +	 */
> +
> +	return clk_get_rate(hdmi->pclk);
> +}
> +
>  static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
>  {
>  	int ddc_bus_freq;
> +	unsigned long tmds_rate =3D inno_hdmi_tmds_rate(hdmi);
> =20
> -	ddc_bus_freq =3D (hdmi->tmds_rate >> 2) / HDMI_SCL_RATE;
> +	ddc_bus_freq =3D (tmds_rate >> 2) / HDMI_SCL_RATE;
> =20
>  	hdmi_writeb(hdmi, DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
>  	hdmi_writeb(hdmi, DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
> @@ -431,7 +452,7 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
>  	 * clock rate, and reconfigure the DDC clock.
>  	 */
> -	hdmi->tmds_rate =3D mode->clock * 1000;
> +	inno_conn_state->tmds_rate =3D mode->clock * 1000;
>  	inno_hdmi_i2c_init(hdmi);
> =20
>  	/* Unmute video and audio output */
> @@ -823,13 +844,6 @@ static int inno_hdmi_bind(struct device *dev, struct=
 device *master,
>  		goto err_disable_clk;
>  	}
> =20
> -	/*
> -	 * When IP controller haven't configured to an accurate video
> -	 * timing, then the TMDS clock source would be switched to
> -	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
> -	 * and reconfigure the DDC clock.
> -	 */
> -	hdmi->tmds_rate =3D clk_get_rate(hdmi->pclk);
>  	inno_hdmi_i2c_init(hdmi);

I still think my patch is better there.

There's two places that use the inno_hdmi.tmds_rate field: the two
callers of inno_hdmi_i2c_init(). One is at bind time and needs to
initialise it with a sane default since we don't have a mode set yet,
the other is to update the internal clock rate while we have a mode set.

Since there's a single "modeset" user, there's no need to store it in
the state structure at all: it can be a local variable.

And in the bind function, you're not going to use the state structure
either since there's no state, and it's just a default that has no
relation to the modeset code at all.

Your function on the other end tries to reconcile and handle the two.
But there's no reason to, it just makes the code harder to follow. Just
pass the parent rate you want to init with as an argument and it's easy
to read and maintain.

Maxime

--ktn4oocwkdhkmjca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYAZsAAKCRDj7w1vZxhR
xeeqAP9jWaSu4gtrIA1SHbjksa/UTSfOXdNX566r/ULPL2MxMgD/Sy+flPKM3KE5
PyZ9MW6Ch2GTdiZgVVTIWW2RsnmW9wA=
=+y1P
-----END PGP SIGNATURE-----

--ktn4oocwkdhkmjca--

