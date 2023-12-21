Return-Path: <linux-kernel+bounces-8091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DE81B20F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6582821FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218C47A6C;
	Thu, 21 Dec 2023 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b856BG6L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A8446A2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BAAC433C8;
	Thu, 21 Dec 2023 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703149626;
	bh=e4HwI+rYcJHOJPcuJl4AqF12SZkaucHI/9Vovq6T6p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b856BG6L9vLS0sdCXBgb52Gt/Pt4sqc+2n2ncutFNWVGpa3KsxOb01pBpalzXQ/1m
	 jPzxgTVD8CtRJTrcunmi7c3f0smXiR2+O2+uEx8e4M6iLXfvbb5PeHncqjArNYmclK
	 lEKUemErrE0JOuQv5OQ9xNHh+Qy3T9Gsy0yT1Jg3SJOZ66xqjYMUJOzWqXk8hjsdE4
	 p746EmlkTIaqEN54KIp2WjlFuCYvhi3LJ4ShAFuL+Qu8Jwa9OttanUZhwjCe8pY5pf
	 Zbv4lpw8PgS2QweswLZ4Dn+i5+7Ads+HdObObzi9QCITFtlG5AZMKFw4Cv/AOaZ31I
	 YuhgD45wOJ1Yw==
Date: Thu, 21 Dec 2023 10:07:03 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/rockchip: rk3066_hdmi: drop custom fill_modes
 hook
Message-ID: <j2cpes3kyssj6cw34v5z6clef4buzb2j6srvmrniumbn2kptqx@ovf2yvhxlslr>
References: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
 <410b116b-cb63-7ba7-3689-4f0832ab5796@gmail.com>
 <evaq3yfbqf4gchsps2qoojemtii7tmcss24aruiuze5kkzlnhy@mih7rky7viqz>
 <4aeef6df-2616-0741-00a3-6e45ec63f920@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6x4c6jydyzhxy4vm"
Content-Disposition: inline
In-Reply-To: <4aeef6df-2616-0741-00a3-6e45ec63f920@gmail.com>


--6x4c6jydyzhxy4vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:40:12PM +0100, Johan Jonker wrote:
>=20
>=20
> On 12/19/23 13:55, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Mon, Dec 18, 2023 at 04:49:06PM +0100, Johan Jonker wrote:
> >> CRTC size validation for the display controller has been added with
> >> Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
> >> hardware capabilities"), so we can drop the custom fill_modes hook.
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >=20
>=20
> > I'm not sure those two are equivalent. CRTC and connectors usually have
> > different requirements and capabilities, and thus different,
> > supplementary, mode_valid/atomic_check implementations.
>=20
> Rockchip RK3066 CRTC and connector resolution max_output are equivalent.
>=20
> From Rockchip PX2 TRM V1.0.pdf page 17:
> - Video Encoder
>   Maximum frame rate is up to 30fps@1920x1080
>=20
> - Display Interface
>   Support LCD or TFT interfaces up to 1920x1080
>=20
> - HDMI TX Interface
>    HDMI version 1.4a, HDCP revision 1.4 and DVI version 1.0 compliant tra=
nsmitter
>    Supports DTV from 480i to 1080i/p HD resolution, and PC from VGA to UX=
GA by LCDC0 or LCDC1 in RK PX2

My point is that there's two limits: the CRTC and HDMI controller ones.
You should put the CRTC ones in the CRTC driver, and the HDMI controller
ones in the HDMI controller driver.

If they are equivalent, great, it's going to filter out the same things, bu=
t...

> Compared to the drm_helper_probe_single_connector_modes() this function a=
dded an extra max_output
>=20
> Checked in rockchip_drm_vop.c is:
> https://lore.kernel.org/linux-rockchip/20230216102447.582905-2-s.hauer@pe=
ngutronix.de/
>=20
> +	if (vop->data->max_output.width && mode->hdisplay > vop->data->max_outp=
ut.width)
> +		return MODE_BAD_HVALUE;
> +
> +	if (vop->data->max_output.height && mode->vdisplay > vop->data->max_out=
put.height)
> +		return MODE_BAD_VVALUE;
>=20
> For RK3066 VOP max_output:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/gpu/drm/rockchip/rockchip_vop_reg.c#n506
>=20
> This patch was made with HDMI in mind.
>=20
> 	.max_output =3D { 1920, 1080 },
>=20
> This first part was added by Heiko, but not was not part my patch that I =
submitted:
> -	if (maxX > 1920)
> -		maxX =3D 1920;
> -	if (maxY > 1080)
> -		maxY =3D 1080;
> -
> -	return drm_helper_probe_single_connector_modes(connector, maxX, maxY);
> -}
>=20
> Original patch:
> https://patchwork.freedesktop.org/patch/msgid/20190330095639.14626-2-jbx6=
244@gmail.com
>=20
> +static int
> +rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
> +					 uint32_t maxX, uint32_t maxY)
> +{
> +	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +}
>=20
> Rockchip RK3066 CRTC and connector resolution max_output are equivalent.

=2E.. a user / dev unfamiliar with the SoC won't have to go through that
to figure out how it's handled, it will be obvious.

Maxime

--6x4c6jydyzhxy4vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYQANwAKCRDj7w1vZxhR
xSAjAQC/cny6EDPS6Yo2LIqQuLPlGA1yohiqkZolkGVOCEB3rgEA+W93tTlZ5lV2
ZZIvJUVxNMzYtlqJpZ9Tk7HKVNiPegk=
=tcho
-----END PGP SIGNATURE-----

--6x4c6jydyzhxy4vm--

