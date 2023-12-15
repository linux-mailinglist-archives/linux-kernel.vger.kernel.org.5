Return-Path: <linux-kernel+bounces-921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0C814813
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CDB2858A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F952CCB2;
	Fri, 15 Dec 2023 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdEjYihf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFE24A07;
	Fri, 15 Dec 2023 12:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A90C433C7;
	Fri, 15 Dec 2023 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702643343;
	bh=4pl0/DwzqKssjxDsTX5F3HvTIeLO8dLjyqqjnoZWaog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdEjYihfa/fLoUJuG1yWmInrzDFFGwGuk886auFaEOPSTicPX2wrYv64D3z/TFLic
	 PflG679aTjI+UlUkZRSVhfHYCBvNgRXogjmaBwf9erEcuVccfTCIV11VWBskGgtNhn
	 m1hlKxjDWJPC1x1uMq/EYa+nxrdCLOWi2jIjIBZmbg4pxvBGsoCHQI0wbOrs5lhiiG
	 jQeOPTygD5yQdJ7vs88/xKPjj5iJPJejuJvFYXbbV4fHBiYNm/Lf1eNjKbvz+r3lWS
	 y0FT+Z+bP9sUnCrvLMk9QIFbCpX9BcigoGZ7Id7k9AT7eX91P9pjyY3mPvrRuRn56T
	 oAQGEh+KXYRuA==
Date: Fri, 15 Dec 2023 13:29:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Message-ID: <33rkqgeqduzvxr24dlc4qqvhwh4fscia5v2g5kzkt3hrwdfzei@cz772d33txmh>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
 <3053311.k3LOHGUjKi@diego>
 <qr7if2k76wdqgevdcwqxj2dkcbga72owjqlk3qaazujhejjloo@cnvmuq27qqns>
 <3f970571-f454-4615-8234-64ea68a3d63c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tmemrq2r5dyiivbh"
Content-Disposition: inline
In-Reply-To: <3f970571-f454-4615-8234-64ea68a3d63c@gmail.com>


--tmemrq2r5dyiivbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 05:34:59PM +0100, Alex Bee wrote:
> Hi Heiko, Hi Maxime,
>=20
> Am 14.12.23 um 12:36 schrieb Maxime Ripard:
> > On Thu, Dec 14, 2023 at 12:17:34PM +0100, Heiko St=FCbner wrote:
> > > Am Donnerstag, 14. Dezember 2023, 12:12:08 CET schrieb Alex Bee:
> > > > Hi Maxime
> > > >=20
> > > > Am 14.12.23 um 08:56 schrieb Maxime Ripard:
> > > > > Hi Alex,
> > > > >=20
> > > > > Thanks for working on this!
> > > > >=20
> > > > > On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
> > > > > > The display controller will always give full range RGB regardle=
ss of the
> > > > > > mode set, but HDMI requires certain modes to be transmitted in =
limited
> > > > > > range RGB. This is especially required for HDMI sinks which do =
not support
> > > > > > non-standard quantization ranges.
> > > > > >=20
> > > > > > This enables color space conversion for those modes and sets the
> > > > > > quantization range accordingly in the AVI infoframe.
> > > > > >=20
> > > > > > Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI =
support")
> > > > > > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > > > > > ---
> > > > > >    drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++=
++++------
> > > > > >    1 file changed, 32 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu=
/drm/rockchip/inno_hdmi.c
> > > > > > index 345253e033c5..32626a75723c 100644
> > > > > > --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> > > > > > +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> > > > > > @@ -33,6 +33,7 @@ struct hdmi_data_info {
> > > > > >    	unsigned int enc_in_format;
> > > > > >    	unsigned int enc_out_format;
> > > > > >    	unsigned int colorimetry;
> > > > > > +	bool rgb_limited_range;
> > > > > >    };
> > > > > >    struct inno_hdmi_i2c {
> > > > > > @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(stru=
ct inno_hdmi *hdmi,
> > > > > >    	else
> > > > > >    		frame.avi.colorspace =3D HDMI_COLORSPACE_RGB;
> > > > > > +	if (hdmi->hdmi_data.enc_out_format =3D=3D HDMI_COLORSPACE_RGB=
) {
> > > > > > +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
> > > > > > +						   &hdmi->connector, mode,
> > > > > > +						   hdmi->hdmi_data.rgb_limited_range ?
> > > > > > +						   HDMI_QUANTIZATION_RANGE_LIMITED :
> > > > > > +						   HDMI_QUANTIZATION_RANGE_FULL);
> > > > > > +	} else {
> > > > > > +		frame.avi.quantization_range =3D HDMI_QUANTIZATION_RANGE_DEF=
AULT;
> > > > > > +		frame.avi.ycc_quantization_range =3D
> > > > > > +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> > > > > > +	}
> > > > > > +
> > > > > >    	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_A=
VI, 0, 0, 0);
> > > > > >    }
> > > > > > @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(str=
uct inno_hdmi *hdmi)
> > > > > >    	if (data->enc_in_format =3D=3D data->enc_out_format) {
> > > > > >    		if ((data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB) ||
> > > > > >    		    (data->enc_in_format >=3D HDMI_COLORSPACE_YUV444)) {
> > > > > > -			value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> > > > > > -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> > > > > > -
> > > > > > -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> > > > > > -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> > > > > > -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> > > > > > -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> > > > > > -			return 0;
> > > > > > +			if (data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB &&
> > > > > > +			    data->enc_out_format =3D=3D HDMI_COLORSPACE_RGB &&
> > > > > > +			    hdmi->hdmi_data.rgb_limited_range) {
> > > > > > +				csc_mode =3D CSC_RGB_0_255_TO_RGB_16_235_8BIT;
> > > > > > +				auto_csc =3D AUTO_CSC_DISABLE;
> > > > > > +				c0_c2_change =3D C0_C2_CHANGE_DISABLE;
> > > > > > +				csc_enable =3D v_CSC_ENABLE;
> > > > > > +			} else {
> > > > > > +				value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> > > > > > +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> > > > > > +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> > > > > > +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> > > > > > +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> > > > > > +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> > > > > > +				return 0;
> > > > > > +			}
> > > > > >    		}
> > > > > >    	}
> > > > > > @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi=
 *hdmi,
> > > > > >    	else
> > > > > >    		hdmi->hdmi_data.colorimetry =3D HDMI_COLORIMETRY_ITU_709;
> > > > > > +	hdmi->hdmi_data.rgb_limited_range =3D
> > > > > > +		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_R=
ANGE_LIMITED;
> > > > > > +
> > > > > This patch conflicts heavily with my inno_hdmi patches here (patc=
hes 22 to 38):
> > > > > https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-sta=
te-v5-0-6538e19d634d@kernel.org/
> > > > I'm aware of that and I mentioned it in the cover letter. Your seri=
es is
> > > > not merged yet and it didn't get much feedback so far. What is the
> > > > status there? Especially because you are removing things from inno-=
hdmi
> > > > driver (which aren't really required to remove there) which will I =
have
> > > > to reintroduce.
> > > Sadly I haven't found the time to look closer at Maxime's series so f=
ar,
> > > but I got the impression that it separates into multiple cleanup steps
> > > for a number of controllers.
> > Yeah, one of the previous version comment was to support more
> > controllers than vc4, which is fair. So I ended up reworking and
> > converting multiple controllers, but most of the clean up changes can be
> > applied outside of that series just fine.
> >=20
> > I just didn't find someone to test / review them yet :)
>=20
> I'm not exactly sure how to proceed here. Do you want me to:
>=20
> - base my patches on top of Maxime's series and reintroduce csc things (of
> course only those which touch inno-hdmi w/o the framwork changes)
>=20
> - only apply the patches that do not touch csc things and base my series=
=A0 on
> top of that
>=20
> - adapt Maxime's patches so that RGB full to RGB limited stays in there
>=20
> - wait with resend until Maxime's series is merged and reintroduce csc af=
ter
> that
>=20
> - something else
>=20
> ?

2 or 3, at your discretion

Maxime

--tmemrq2r5dyiivbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXxGjAAKCRDj7w1vZxhR
xZEkAP9OXjRoP4RlI2fw3hcQunCUmtBq+Jyb50pU6ryvs7DVZgEAthtVXetksXVH
4QBRhBhqWUYzI6/kbRSUx52qWVAO3Qg=
=9VXV
-----END PGP SIGNATURE-----

--tmemrq2r5dyiivbh--

