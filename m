Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDE76651C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjG1HSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjG1HSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:18:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58DF7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c8dd2ce79so10911385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690528723; x=1691133523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHP8me6VokRySX8+Juk9IP6BLwxcpF71AvYOtabkpks=;
        b=IYboWiAEFe886XfnbBoINJlGIViY5LsibrMRZccuD+JhX41Y36pGjpl4nLjaj8e+Zs
         DhGEY2WEZpKWQSU0NEwf+5l7uwrLRxb2YKRvLYyvkDANZEI0IUG9f+KhOTOISFUSaM0x
         vcBsFNJLEQxDIWjm2X7Datl+tvMfXxpLGZ7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528723; x=1691133523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHP8me6VokRySX8+Juk9IP6BLwxcpF71AvYOtabkpks=;
        b=Uscrflanb9l6mWF370pOBEkB7p1BfZPciy41H2Dc5VJUKmgxjZSnLd4v4/TZGeFR8o
         +08+Y2MANEQxjrK8pflUGMgh/2b1EMa9Lcugz4mMPsADUwYlwBScroc+f0YwNCw+Tfc4
         4YRb3Rc0gh1okwf+IXZUAXEmDeu/EpazktMbdAuLVsJHrKdJoK89z1smrax2rco7tBh+
         uRH0PUGuLNJMPiA2ffITUWm5e+N1zBcOP7wr/ymCIZS978B8N3PqyJDPnb+bEfXtJkGj
         jZnx4oQWvfl48ac0jv7AEgT37IABDiqhimkNe3khIHpx+lqFimlxD6R+FTYvl7KGrz6+
         Axzg==
X-Gm-Message-State: ABy/qLYEQpmFpk3Ef7s48nU0zLUYMvC+eI2+nxmFYyXDyWJqsZEFFvCG
        uuHn8iSdAOi3QD+cWE3+B0ha64ZJZAC6wYx4SQbKCR0n
X-Google-Smtp-Source: APBJJlFq1qtZbH+EbLsrw7g+EoZl90oFQeBk5t7X+Uh5hqNGu49ALIOkWpj41nCuRmUdNvIB4l1Edg==
X-Received: by 2002:a05:620a:b83:b0:766:fa53:35b3 with SMTP id k3-20020a05620a0b8300b00766fa5335b3mr1613979qkh.33.1690528722741;
        Fri, 28 Jul 2023 00:18:42 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a13d200b007681fc2999bsm932293qkl.54.2023.07.28.00.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:18:41 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so11562766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:41 -0700 (PDT)
X-Received: by 2002:a0c:b246:0:b0:63c:ed11:7bf0 with SMTP id
 k6-20020a0cb246000000b0063ced117bf0mr1593631qve.6.1690528721048; Fri, 28 Jul
 2023 00:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230206043308.28365-1-ayaka@soulik.info> <20230206043308.28365-3-ayaka@soulik.info>
 <20230713103912.favcnhqwjkzvsa6b@chromium.org> <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
In-Reply-To: <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 28 Jul 2023 16:18:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DwEnKznBcJCiC06dU5xJO0Lw6fJSudEfntgLt8fmc+aQ@mail.gmail.com>
Message-ID: <CAAFQd5DwEnKznBcJCiC06dU5xJO0Lw6fJSudEfntgLt8fmc+aQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] media: vivid: Convert to v4l2_ext_pix_format
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-media@vger.kernel.org, randy.li@synaptics.com,
        Brian.Starkey@arm.com, boris.brezillon@collabora.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, kernel@collabora.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 1:00=E2=80=AFAM Randy Li <ayaka@soulik.info> wrote:
>
>
> On 2023/7/13 18:39, Tomasz Figa wrote:
> > On Mon, Feb 06, 2023 at 12:33:01PM +0800, ayaka wrote:
> >> From: Helen Koike <helen.koike@collabora.com>
> >>
> >> Simplify Multi/Single planer API handling by converting to v4l2_ext_pi=
x_format.
> >>
> >> Duplicate v4l2_ioctl_ops for touch devices. This is done to force the
> >> framework to use the ext hooks when the classic Api is used from
> >> userspace in Vid devices, and to keep touch devices with classic hook.
> >>
> >> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >> ---
> >> Changes in v7:
> >> - Force the userspace using the new APIs to operate non-touch drivers.
> > The primary objective of Linux development is not to break the
> > userspace. We can't just remove the old API, especially not from
> > existing drivers.
> Maybe I should create a new virtual driver here? It is impossible to
> support the new fourcc modifier with the old APIs.

We need to find a way to make an existing driver support both the old
and new API. Obviously any new functionality of the new API doesn't
have to be retrofitted to the old API.

> >
> > [snip]
> >>   int vivid_try_fmt_vid_cap(struct file *file, void *priv,
> >> -                    struct v4l2_format *f)
> >> +                      struct v4l2_ext_pix_format *f)
> >>   {
> >> -    struct v4l2_pix_format_mplane *mp =3D &f->fmt.pix_mp;
> >> -    struct v4l2_plane_pix_format *pfmt =3D mp->plane_fmt;
> >>      struct vivid_dev *dev =3D video_drvdata(file);
> >> +    struct v4l2_plane_pix_format *pfmt =3D f->plane_fmt;
> >>      const struct vivid_fmt *fmt;
> >>      unsigned bytesperline, max_bpl;
> >>      unsigned factor =3D 1;
> >>      unsigned w, h;
> >>      unsigned p;
> >> -    bool user_set_csc =3D !!(mp->flags & V4L2_PIX_FMT_FLAG_SET_CSC);
> > Why is this condition being removed?
>
> Because the v4l2_ext_pix has a struct for the colorspace?

What do you mean? I see it has the same enum field for colorspace as
the original v4l2_pix_format_mplane.

The flag was needed for CAPTURE format to tell the driver whether it
should perform a conversion to the requested colorspace or just fill
in the color space as inferred from the current configuration (e.g.
OUTPUT format).
How was that addressed in the new API?

>
> Would you like the idea that driver exports a buffer contains all the
> info for an enumeration ?
>
> >
> > Best regards,
> > Tomasz
> >
> >>
> >> -    fmt =3D vivid_get_format(dev, mp->pixelformat);
> >> +    fmt =3D vivid_get_format(dev, f->pixelformat);
> >>      if (!fmt) {
> >>              dprintk(dev, 1, "Fourcc format (0x%08x) unknown.\n",
> >> -                    mp->pixelformat);
> >> -            mp->pixelformat =3D V4L2_PIX_FMT_YUYV;
> >> -            fmt =3D vivid_get_format(dev, mp->pixelformat);
> >> +                    f->pixelformat);
> >> +            f->pixelformat =3D V4L2_PIX_FMT_YUYV;
> >> +            fmt =3D vivid_get_format(dev, f->pixelformat);
> >>      }
> >>
> >> -    mp->field =3D vivid_field_cap(dev, mp->field);
> >> +    f->field =3D vivid_field_cap(dev, f->field);
> >>      if (vivid_is_webcam(dev)) {
> >>              const struct v4l2_frmsize_discrete *sz =3D
> >>                      v4l2_find_nearest_size(webcam_sizes,
> >>                                             VIVID_WEBCAM_SIZES, width,
> >> -                                           height, mp->width, mp->hei=
ght);
> >> +                                           height, f->width, f->heigh=
t);
> >>
> >>              w =3D sz->width;
> >>              h =3D sz->height;
> >> @@ -604,14 +603,14 @@ int vivid_try_fmt_vid_cap(struct file *file, voi=
d *priv,
> >>              w =3D dev->src_rect.width;
> >>              h =3D dev->src_rect.height;
> >>      }
> >> -    if (V4L2_FIELD_HAS_T_OR_B(mp->field))
> >> +    if (V4L2_FIELD_HAS_T_OR_B(f->field))
> >>              factor =3D 2;
> >>      if (vivid_is_webcam(dev) ||
> >>          (!dev->has_scaler_cap && !dev->has_crop_cap && !dev->has_comp=
ose_cap)) {
> >> -            mp->width =3D w;
> >> -            mp->height =3D h / factor;
> >> +            f->width =3D w;
> >> +            f->height =3D h / factor;
> >>      } else {
> >> -            struct v4l2_rect r =3D { 0, 0, mp->width, mp->height * fa=
ctor };
> >> +            struct v4l2_rect r =3D { 0, 0, f->width, f->height * fact=
or };
> >>
> >>              v4l2_rect_set_min_size(&r, &vivid_min_rect);
> >>              v4l2_rect_set_max_size(&r, &vivid_max_rect);
> >> @@ -624,16 +623,15 @@ int vivid_try_fmt_vid_cap(struct file *file, voi=
d *priv,
> >>              } else if (!dev->has_scaler_cap && !dev->has_crop_cap) {
> >>                      v4l2_rect_set_min_size(&r, &dev->src_rect);
> >>              }
> >> -            mp->width =3D r.width;
> >> -            mp->height =3D r.height / factor;
> >> +            f->width =3D r.width;
> >> +            f->height =3D r.height / factor;
> >>      }
> >>
> >>      /* This driver supports custom bytesperline values */
> >>
> >> -    mp->num_planes =3D fmt->buffers;
> >>      for (p =3D 0; p < fmt->buffers; p++) {
> >>              /* Calculate the minimum supported bytesperline value */
> >> -            bytesperline =3D (mp->width * fmt->bit_depth[p]) >> 3;
> >> +            bytesperline =3D (f->width * fmt->bit_depth[p]) >> 3;
> >>              /* Calculate the maximum supported bytesperline value */
> >>              max_bpl =3D (MAX_ZOOM * MAX_WIDTH * fmt->bit_depth[p]) >>=
 3;
> >>
> >> @@ -642,48 +640,49 @@ int vivid_try_fmt_vid_cap(struct file *file, voi=
d *priv,
> >>              if (pfmt[p].bytesperline < bytesperline)
> >>                      pfmt[p].bytesperline =3D bytesperline;
> >>
> >> -            pfmt[p].sizeimage =3D (pfmt[p].bytesperline * mp->height)=
 /
> >> +            pfmt[p].sizeimage =3D (pfmt[p].bytesperline * f->height) =
/
> >>                              fmt->vdownsampling[p] + fmt->data_offset[=
p];
> >> -
> >> -            memset(pfmt[p].reserved, 0, sizeof(pfmt[p].reserved));
> >>      }
> >> +
> >> +    if (p < VIDEO_MAX_PLANES)
> >> +            pfmt[p].sizeimage =3D 0;
> >> +
> >>      for (p =3D fmt->buffers; p < fmt->planes; p++)
> >> -            pfmt[0].sizeimage +=3D (pfmt[0].bytesperline * mp->height=
 *
> >> +            pfmt[0].sizeimage +=3D (pfmt[0].bytesperline * f->height =
*
> >>                      (fmt->bit_depth[p] / fmt->vdownsampling[p])) /
> >>                      (fmt->bit_depth[0] / fmt->vdownsampling[0]);
> >>
> >> -    if (!user_set_csc || !v4l2_is_colorspace_valid(mp->colorspace))
> >> -            mp->colorspace =3D vivid_colorspace_cap(dev);
> >> +    if (!v4l2_is_colorspace_valid(f->colorspace))
> >> +            f->colorspace =3D vivid_colorspace_cap(dev);
> >>
> >> -    if (!user_set_csc || !v4l2_is_xfer_func_valid(mp->xfer_func))
> >> -            mp->xfer_func =3D vivid_xfer_func_cap(dev);
> >> +    if (!v4l2_is_xfer_func_valid(f->xfer_func))
> >> +            f->xfer_func =3D vivid_xfer_func_cap(dev);
> >>
> >>      if (fmt->color_enc =3D=3D TGP_COLOR_ENC_HSV) {
> >> -            if (!user_set_csc || !v4l2_is_hsv_enc_valid(mp->hsv_enc))
> >> -                    mp->hsv_enc =3D vivid_hsv_enc_cap(dev);
> >> +            if (!v4l2_is_hsv_enc_valid(f->hsv_enc))
> >> +                    f->hsv_enc =3D vivid_hsv_enc_cap(dev);
> >>      } else if (fmt->color_enc =3D=3D TGP_COLOR_ENC_YCBCR) {
> >> -            if (!user_set_csc || !v4l2_is_ycbcr_enc_valid(mp->ycbcr_e=
nc))
> >> -                    mp->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> >> +            if (!v4l2_is_ycbcr_enc_valid(f->ycbcr_enc))
> >> +                    f->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> >>      } else {
> >> -            mp->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> >> +            f->ycbcr_enc =3D vivid_ycbcr_enc_cap(dev);
> >>      }
> >>
> >>      if (fmt->color_enc =3D=3D TGP_COLOR_ENC_YCBCR ||
> >>          fmt->color_enc =3D=3D TGP_COLOR_ENC_RGB) {
> >> -            if (!user_set_csc || !v4l2_is_quant_valid(mp->quantizatio=
n))
> >> -                    mp->quantization =3D vivid_quantization_cap(dev);
> >> +            if (!v4l2_is_quant_valid(f->quantization))
> >> +                    f->quantization =3D vivid_quantization_cap(dev);
> >>      } else {
> >> -            mp->quantization =3D vivid_quantization_cap(dev);
> >> +            f->quantization =3D vivid_quantization_cap(dev);
> >>      }
> >>
> >> -    memset(mp->reserved, 0, sizeof(mp->reserved));
> >> +    memset(f->reserved, 0, sizeof(f->reserved));
> >>      return 0;
> >>   }
> > [snip]
