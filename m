Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A09812E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443977AbjLNLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443866AbjLNLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:33:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A5A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:33:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B9C433C8;
        Thu, 14 Dec 2023 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702553622;
        bh=gvNH64NxomfOFGlH+emgYSF+W6VhepTxD6UYJ5KLgXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzqX9W7yiWjn7zM2BnH5ih+0E1kGtH2VGTQRZaigB+FEiKc7ViLfuMJhBjJ7ajSNZ
         cLyqCp4+Z8xbAoRgnNpYW0BEveMRiO+NCoKAAUEqoHjKxMVLCAqUa/w1N40tA7zonR
         QkKolIMbLVtOV6/1m38ixgm1JuvxOpT6XAu/rDaulacl5dwFP6AmCzds2LO21yZXId
         FDimK/N5uK9vHjvHivnQN15qH4fjiRG1PK7UsY2etYKtp4eIoMb1fABMtl6KTNI5r4
         JMmxMaIMRXtHapQfuh/ZLSX30kd5TqZGTKh7tkSH3cdPEq+Q70rDwWZparNsfI+u9R
         3JExbhdkDWxWQ==
Date:   Thu, 14 Dec 2023 12:33:40 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Message-ID: <db3kdzy4ogf3o2fd6apr36s44qitcsxksfkfa2oc77s5y6dv2w@kfji4iszthxa>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-5-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iok2sy75wk4esltb"
Content-Disposition: inline
In-Reply-To: <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iok2sy75wk4esltb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:12:08PM +0100, Alex Bee wrote:
> Hi Maxime
>=20
> Am 14.12.23 um 08:56 schrieb Maxime Ripard:
> > Hi Alex,
> >=20
> > Thanks for working on this!
> >=20
> > On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
> > > The display controller will always give full range RGB regardless of =
the
> > > mode set, but HDMI requires certain modes to be transmitted in limited
> > > range RGB. This is especially required for HDMI sinks which do not su=
pport
> > > non-standard quantization ranges.
> > >=20
> > > This enables color space conversion for those modes and sets the
> > > quantization range accordingly in the AVI infoframe.
> > >=20
> > > Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI suppor=
t")
> > > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > > ---
> > >   drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++---=
---
> > >   1 file changed, 32 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/r=
ockchip/inno_hdmi.c
> > > index 345253e033c5..32626a75723c 100644
> > > --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> > > +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> > > @@ -33,6 +33,7 @@ struct hdmi_data_info {
> > >   	unsigned int enc_in_format;
> > >   	unsigned int enc_out_format;
> > >   	unsigned int colorimetry;
> > > +	bool rgb_limited_range;
> > >   };
> > >   struct inno_hdmi_i2c {
> > > @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inn=
o_hdmi *hdmi,
> > >   	else
> > >   		frame.avi.colorspace =3D HDMI_COLORSPACE_RGB;
> > > +	if (hdmi->hdmi_data.enc_out_format =3D=3D HDMI_COLORSPACE_RGB) {
> > > +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
> > > +						   &hdmi->connector, mode,
> > > +						   hdmi->hdmi_data.rgb_limited_range ?
> > > +						   HDMI_QUANTIZATION_RANGE_LIMITED :
> > > +						   HDMI_QUANTIZATION_RANGE_FULL);
> > > +	} else {
> > > +		frame.avi.quantization_range =3D HDMI_QUANTIZATION_RANGE_DEFAULT;
> > > +		frame.avi.ycc_quantization_range =3D
> > > +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> > > +	}
> > > +
> > >   	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, =
0, 0);
> > >   }
> > > @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct in=
no_hdmi *hdmi)
> > >   	if (data->enc_in_format =3D=3D data->enc_out_format) {
> > >   		if ((data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB) ||
> > >   		    (data->enc_in_format >=3D HDMI_COLORSPACE_YUV444)) {
> > > -			value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> > > -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> > > -
> > > -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> > > -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> > > -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> > > -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> > > -			return 0;
> > > +			if (data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB &&
> > > +			    data->enc_out_format =3D=3D HDMI_COLORSPACE_RGB &&
> > > +			    hdmi->hdmi_data.rgb_limited_range) {
> > > +				csc_mode =3D CSC_RGB_0_255_TO_RGB_16_235_8BIT;
> > > +				auto_csc =3D AUTO_CSC_DISABLE;
> > > +				c0_c2_change =3D C0_C2_CHANGE_DISABLE;
> > > +				csc_enable =3D v_CSC_ENABLE;
> > > +			} else {
> > > +				value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> > > +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> > > +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> > > +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> > > +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> > > +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> > > +				return 0;
> > > +			}
> > >   		}
> > >   	}
> > > @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
> > >   	else
> > >   		hdmi->hdmi_data.colorimetry =3D HDMI_COLORIMETRY_ITU_709;
> > > +	hdmi->hdmi_data.rgb_limited_range =3D
> > > +		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_RANGE_L=
IMITED;
> > > +
> > This patch conflicts heavily with my inno_hdmi patches here (patches 22=
 to 38):
> > https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-=
0-6538e19d634d@kernel.org/
>
> I'm aware of that and I mentioned it in the cover letter.

Sorry, I missed that part.

> Your series is not merged yet and it didn't get much feedback so far.
> What is the status there?

It didn't have much reviews, but I'll hope to change that. For the
patches 22 to 38 though, it doesn't really matter. Those changes are
self-contained and can be applied as is outside of the series.

> Especially because you are removing things from inno-hdmi driver (which
> aren't really required to remove there) which will I have to reintroduce.

I'm not entirely sure which part I remove that are actually going to be
used here.

> > I would appreciate if you could test and merge them into your series.
> >=20
> > In particular, there's no need to store the range here: enc_out_format
>
> rgb_limited_range is currently not only used for csc, but also for for
> infoframe creation. So it makes sense to have this stored=A0 to avoid cal=
ling
> drm_default_rgb_quant_range twice.

You're right, I missed one. Still, it shouldn't be stored in the
hdmi_data_info structure, it's tied to the mode, and the mode is part of
the state, so it's not a property to a given device, but it's tied to
the connector state.

So if you want to do so, you should really create a custom state
structure and store the range there, just like vc4 is doing for example.

Maxime

--iok2sy75wk4esltb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXroFAAKCRDj7w1vZxhR
xQ1lAP9XuPfZZjOQo82zeI0Bi/qXJJf2rfQSNBVhR9I2Dd8YFQD/b2/cMAjoTS5/
I1wh88yK8K64fdUZJ9jc5pKj0PRAaQA=
=T8J3
-----END PGP SIGNATURE-----

--iok2sy75wk4esltb--
