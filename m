Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAC75B88A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGTUKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTUKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:10:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5C2118
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:10:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-768138c59c1so108603285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689883800; x=1690488600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X6oWLkz6x5qYmjU2JhBWktWGTfXJ8rQEV/60IeqqLVA=;
        b=vo6kORkz/2I2jOtgIHATmtuOo6e3DA+IzMz4hil4GX1fh8Ec+/wfzvo+70TbP6saPO
         kjbN2NIRF7veOewuZkHiBIbGlvjogEk0yh2vlUq73EjFTlgCs7Z0zDysgX3jp0lt3+eQ
         SkhvLw3ZLAEJxB16yRnmDPRNqJT4PWfpscNrrAWmiz8LN4cXGWHkWJtocktZwOnzoSds
         IZA+DFaGSzSwnQpSEZpttc9XSR+dggKJizrVVqrtCM/+hwNDkS4WEx6MHHOMOGSGWhv6
         WWzqogkzh2Dauxjp6sOyup2GTAzDPo1cij1OXspycKklONg0zbow156lwuGNckEwwv9t
         eM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883800; x=1690488600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6oWLkz6x5qYmjU2JhBWktWGTfXJ8rQEV/60IeqqLVA=;
        b=htldblOJUnnvXFfe3dA4XHK2bG/Aki+BxuQmA3HtQ4LIzhGYaaXmjdQx21qpN5h1+R
         p1achdgBxQm1PdEanQeIiTYukq0N/6b5tm2k6N84fXmtKPNk5Ed2qlMb2oEjGmnaeEsN
         HMqDkMJfd8cUBxi2yJs8VASpptqlQUKpe5XhT/nznxV8cYCGwlcp6FgNWqQQgkxPDk3M
         AK3IF/mbddpyXF5N03vPWuILgAHHNMRWlgXn8LZFKyZOd76ScYia+pLb16pxmmdbxKFN
         N9rk6thmxQzM9cpQ4WInLbknBystC1zA2y7Fhkkv7NfFYmZ6xcT7fnbE9uBDLsEHZnEp
         01hA==
X-Gm-Message-State: ABy/qLY7W0LAwCYCCZjDVXTIhNq23uorJqee48F6KtNjD88IarwbEIJu
        vyilX1o8Hb6fR14VP3v+CTbhtQ==
X-Google-Smtp-Source: APBJJlHQ5Xb9t19f2pNRk1xu40E1jXT0Vq7glHZjAXEg+udNqCJuq/iNTIp/0aO5H/YuD9KsCT7yuw==
X-Received: by 2002:a05:620a:2aec:b0:768:3f41:5843 with SMTP id bn44-20020a05620a2aec00b007683f415843mr5481309qkb.50.1689883799854;
        Thu, 20 Jul 2023 13:09:59 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:83d4::7a9])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm602968qkm.34.2023.07.20.13.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:09:59 -0700 (PDT)
Message-ID: <bbb6660439bb66bd9d81bb8031d9062d3c03fdf0.camel@ndufresne.ca>
Subject: Re: [PATCH v7 2/9] media: vivid: Convert to v4l2_ext_pix_format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Randy Li <ayaka@soulik.info>, Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, randy.li@synaptics.com,
        Brian.Starkey@arm.com, boris.brezillon@collabora.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, kernel@collabora.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
Date:   Thu, 20 Jul 2023 16:09:58 -0400
In-Reply-To: <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
References: <20230206043308.28365-1-ayaka@soulik.info>
         <20230206043308.28365-3-ayaka@soulik.info>
         <20230713103912.favcnhqwjkzvsa6b@chromium.org>
         <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 juillet 2023 =C3=A0 00:00 +0800, Randy Li a =C3=A9crit=C2=A0:
> On 2023/7/13 18:39, Tomasz Figa wrote:
> > On Mon, Feb 06, 2023 at 12:33:01PM +0800, ayaka wrote:
> > > From: Helen Koike <helen.koike@collabora.com>
> > >=20
> > > Simplify Multi/Single planer API handling by converting to v4l2_ext_p=
ix_format.
> > >=20
> > > Duplicate v4l2_ioctl_ops for touch devices. This is done to force the
> > > framework to use the ext hooks when the classic Api is used from
> > > userspace in Vid devices, and to keep touch devices with classic hook=
.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > > ---
> > > Changes in v7:
> > > - Force the userspace using the new APIs to operate non-touch drivers=
.
> > The primary objective of Linux development is not to break the
> > userspace. We can't just remove the old API, especially not from
> > existing drivers.
> Maybe I should create a new virtual driver here? It is impossible to=20
> support the new fourcc modifier with the old APIs.

For MPLANE, where backward compatibility was built into libv4l2 LD_PRELOAD
wrapper, it simply failed the cases that could not be supported (non contig=
uous
planes).

regards,
Nicolas

> >=20
> > [snip]
> > >   int vivid_try_fmt_vid_cap(struct file *file, void *priv,
> > > -			struct v4l2_format *f)
> > > +			  struct v4l2_ext_pix_format *f)
> > >   {
> > > -	struct v4l2_pix_format_mplane *mp =3D &f->fmt.pix_mp;
> > > -	struct v4l2_plane_pix_format *pfmt =3D mp->plane_fmt;
> > >   	struct vivid_dev *dev =3D video_drvdata(file);
> > > +	struct v4l2_plane_pix_format *pfmt =3D f->plane_fmt;
> > >   	const struct vivid_fmt *fmt;
> > >   	unsigned bytesperline, max_bpl;
> > >   	unsigned factor =3D 1;
> > >   	unsigned w, h;
> > >   	unsigned p;
> > > -	bool user_set_csc =3D !!(mp->flags & V4L2_PIX_FMT_FLAG_SET_CSC);
> > Why is this condition being removed?
>=20
> Because the v4l2_ext_pix has a struct for the colorspace?
>=20
> Would you like the idea that driver exports a buffer contains all the=20
> info for an enumeration ?
>=20
> >=20
> > Best regards,
> > Tomasz
> >=20
> > >  =20
> > > -	fmt =3D vivid_get_format(dev, mp->pixelformat);
> > > +	fmt =3D vivid_get_format(dev, f->pixelformat);
> > >   	if (!fmt) {
> > >   		dprintk(dev, 1, "Fourcc format (0x%08x) unknown.\n",
> > > -			mp->pixelformat);
> > > -		mp->pixelformat =3D V4L2_PIX_FMT_YUYV;
> > > -		fmt =3D vivid_get_format(dev, mp->pixelformat);
> > > +			f->pixelformat);
> > > +		f->pixelformat =3D V4L2_PIX_FMT_YUYV;
> > > +		fmt =3D vivid_get_format(dev, f->pixelformat);
> > >   	}
> > >  =20
> > > -	mp->field =3D vivid_field_cap(dev, mp->field);
> > > +	f->field =3D vivid_field_cap(dev, f->field);
> > >   	if (vivid_is_webcam(dev)) {
> > >   		const struct v4l2_frmsize_discrete *sz =3D
> > >   			v4l2_find_nearest_size(webcam_sizes,
> > >   					       VIVID_WEBCAM_SIZES, width,
> > > -					       height, mp->width, mp->height);
> > > +					       height, f->width, f->height);
> > >  =20
> > >   		w =3D sz->width;
> > >   		h =3D sz->height;
> > > @@ -604,14 +603,14 @@ int vivid_try_fmt_vid_cap(struct file *file, vo=
id *priv,
> > >   		w =3D dev->src_rect.width;
> > >   		h =3D dev->src_rect.height;
> > >   	}
> > > -	if (V4L2_FIELD_HAS_T_OR_B(mp->field))
> > > +	if (V4L2_FIELD_HAS_T_OR_B(f->field))
> > >   		factor =3D 2;
> > >   	if (vivid_is_webcam(dev) ||
> > >   	    (!dev->has_scaler_cap && !dev->has_crop_cap && !dev->has_compo=
se_cap)) {
> > > -		mp->width =3D w;
> > > -		mp->height =3D h / factor;
> > > +		f->width =3D w;
> > > +		f->height =3D h / factor;
> > >   	} else {
> > > -		struct v4l2_rect r =3D { 0, 0, mp->width, mp->height * factor };
> > > +		struct v4l2_rect r =3D { 0, 0, f->width, f->height * factor };
> > >  =20
> > >   		v4l2_rect_set_min_size(&r, &vivid_min_rect);
> > >   		v4l2_rect_set_max_size(&r, &vivid_max_rect);
> > > @@ -624,16 +623,15 @@ int vivid_try_fmt_vid_cap(struct file *file, vo=
id *priv,
> > >   		} else if (!dev->has_scaler_cap && !dev->has_crop_cap) {
> > >   			v4l2_rect_set_min_size(&r, &dev->src_rect);
> > >   		}
> > > -		mp->width =3D r.width;
> > > -		mp->height =3D r.height / factor;
> > > +		f->width =3D r.width;
> > > +		f->height =3D r.height / factor;
> > >   	}
> > >  =20
> > >   	/* This driver supports custom bytesperline values */
> > >  =20
> > > -	mp->num_planes =3D fmt->buffers;
> > >   	for (p =3D 0; p < fmt->buffers; p++) {
> > >   		/* Calculate the minimum supported bytesperline value */
> > > -		bytesperline =3D (mp->width * fmt->bit_depth[p]) >> 3;
> > > +		bytesperline =3D (f->width * fmt->bit_depth[p]) >> 3;
> > >   		/* Calculate the maximum supported bytesperline value */
> > >   		max_bpl =3D (MAX_ZOOM * MAX_WIDTH * fmt->bit_depth[p]) >> 3;
> > >  =20
> > > @@ -642,48 +640,49 @@ int vivid_try_fmt_vid_cap(struct file *file, vo=
id *priv,
> > >   		if (pfmt[p].bytesperline < bytesperline)
> > >   			pfmt[p].bytesperline =3D bytesperline;
> > >  =20
> > > -		pfmt[p].sizeimage =3D (pfmt[p].bytesperline * mp->height) /
> > > +		pfmt[p].sizeimage =3D (pfmt[p].bytesperline * f->height) /
> > >   				fmt->vdownsampling[p] + fmt->data_offset[p];
> > > -
> > > -		memset(pfmt[p].reserved, 0, sizeof(pfmt[p].reserved));
> > >   	}
> > > +
> > > +	if (p < VIDEO_MAX_PLANES)
> > > +		pfmt[p].sizeimage =3D 0;
> > > +
> > >   	for (p =3D fmt->buffers; p < fmt->planes; p++)
> > > -		pfmt[0].sizeimage +=3D (pfmt[0].bytesperline * mp->height *
> > > +		pfmt[0].sizeimage +=3D (pfmt[0].bytesperline * f->height *
> > >   			(fmt->bit_depth[p] / fmt->vdownsampling[p])) /
> > >   			(fmt->bit_depth[0] / fmt->vdownsampling[0]);
> > >  =20
> > > -	if (!user_set_csc || !v4l2_is_colorspace_valid(mp->colorspace))
> > > -		mp->colorspace =3D vivid_colorspace_cap(dev);
> > > +	if (!v4l2_is_colorspace_valid(f->colorspace))
> > > +		f->colorspace =3D vivid_colorspace_cap(dev);
> > >  =20
> > > -	if (!user_set_csc || !v4l2_is_xfer_func_valid(mp->xfer_func))
> > > -		mp->xfer_func =3D vivid_xfer_func_cap(dev);
> > > +	if (!v4l2_is_xfer_func_valid(f->xfer_func))
> > > +		f->xfer_func =3D vivid_xfer_func_cap(dev);
> > >  =20
> > >   	if (fmt->color_enc =3D=3D TGP_COLOR_ENC_HSV) {
> > > -		if (!user_set_csc || !v4l2_is_hsv_enc_valid(mp->hsv_enc))
> > > -			mp->hsv_enc =3D vivid_hsv_enc_cap(dev);
> > > +		if (!v4l2_is_hsv_enc_valid(f->hsv_enc))
> > > +			f->hsv_enc =3D vivid_hsv_enc_cap(dev);
> > >   	} else if (fmt->color_enc =3D=3D TGP_COLOR_ENC_YCBCR) {
> > > -		if (!user_set_csc || !v4l2_is_ycbcr_enc_valid(mp->ycbcr_enc))
> > > -			mp->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> > > +		if (!v4l2_is_ycbcr_enc_valid(f->ycbcr_enc))
> > > +			f->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> > >   	} else {
> > > -		mp->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> > > +		f->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> > >   	}
> > >  =20
> > >   	if (fmt->color_enc =3D=3D TGP_COLOR_ENC_YCBCR ||
> > >   	    fmt->color_enc =3D=3D TGP_COLOR_ENC_RGB) {
> > > -		if (!user_set_csc || !v4l2_is_quant_valid(mp->quantization))
> > > -			mp->quantization =3D vivid_quantization_cap(dev);
> > > +		if (!v4l2_is_quant_valid(f->quantization))
> > > +			f->quantization =3D vivid_quantization_cap(dev);
> > >   	} else {
> > > -		mp->quantization =3D vivid_quantization_cap(dev);
> > > +		f->quantization =3D vivid_quantization_cap(dev);
> > >   	}
> > >  =20
> > > -	memset(mp->reserved, 0, sizeof(mp->reserved));
> > > +	memset(f->reserved, 0, sizeof(f->reserved));
> > >   	return 0;
> > >   }
> > [snip]
>=20

