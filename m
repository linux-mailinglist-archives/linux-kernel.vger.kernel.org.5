Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B577F802851
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjLCWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:15:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6436D7;
        Sun,  3 Dec 2023 14:15:44 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso2619716b3a.2;
        Sun, 03 Dec 2023 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701641744; x=1702246544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp4hrKRCxPQEfU5u2oM3FN+8Te5fEZUyhu2s23erNVg=;
        b=ScaX2Gk2moa4uz1OkmY2GyYQIhHris3i78cwsOarJqLHkIu+Q20irZmLnKt6vRCR09
         wfzirAGvikCPbWKqKf60D0wxLKBCd9c2mKKyZDoGpgiOcoj/E8i6JN0NAXPpRLWChC85
         asdo/pGMq10n0yInk9loBlYsmF7kunG0oblii71cX9wP5GcsE5y1qL9yIO1Tg/6/Ibit
         39FDSEgqcRshg0PiyugzFPJuQFUUqg1CzKuK6BSKqVbTIUKZw1SR4n5oRAXm8qKUHfLd
         NLEHmRBbeP0x/dJGUOaRz/klCldbz5d0pjsH/uv2ThlPL8as6M987taj5DClmtEEBXFi
         F2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641744; x=1702246544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp4hrKRCxPQEfU5u2oM3FN+8Te5fEZUyhu2s23erNVg=;
        b=Ifdt+fUKQChj8ChnxYHj3YI7aJgrUPWvCuxyJcIa02WVJlE19rnnXWb0VqjUX3R6Ge
         JrtT2rU/jAIcA74Uy7PavnOy5zGKF++eerabe8X/n1NU3HFZxxYZQ9xDwAPPXf55fyR0
         W0OL+63NVPExVzlb+UOgNKofOk8mfLc2CyK4HStiWIKuE9TKXTyWImr4iLDHHhwh10Xv
         L2OR4TYTkL9NsSzHAQ7n+KJe5/wXKNwsDFSBkgM2ok0NPC1ryB1MgB6ueuZCcFtAgEt0
         6ra7efVM6nErUWkcogJwb/QnB1yzWPxLQNbXLqyMwcIiRLkcsDK4mTWotf/9DsXPngOR
         4jCw==
X-Gm-Message-State: AOJu0YwYM8m++cjd90tvz6ILKbOQsk2puUDJbcEEzespTBWUFT5YlVuY
        +ML/5vk2Su+J3AfgsBz/xUshPVF7iZiYpweQDUc=
X-Google-Smtp-Source: AGHT+IG9fXsgYtF5Q83KAQ/ZHKML1h06g8JjnFlhn6kr4ka+AxbSdTBrabtFPHHC62d1QbOWDqvRyCFc6ayf+h5bOtc=
X-Received: by 2002:a17:90a:fa8e:b0:286:811c:c3b5 with SMTP id
 cu14-20020a17090afa8e00b00286811cc3b5mr930976pjb.2.1701641743977; Sun, 03 Dec
 2023 14:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20231129092759.242641-1-paul.elder@ideasonboard.com>
 <20231129092759.242641-12-paul.elder@ideasonboard.com> <CAHCN7xLihh_r=zn+2EsqZvsOumeJY52DHmrkVv0+A7Grib8AhQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLihh_r=zn+2EsqZvsOumeJY52DHmrkVv0+A7Grib8AhQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 3 Dec 2023 16:15:32 -0600
Message-ID: <CAHCN7xK8prNL8HGUCGpUW0-NLWvCphjGrUz_5D2CpyPFa0vG8Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] media: rkisp1: Add UYVY as an output format
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 3:32=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Wed, Nov 29, 2023 at 3:29=E2=80=AFAM Paul Elder <paul.elder@ideasonboa=
rd.com> wrote:
> >
> > Add support for UYVY as an output format. The uv_swap bit in the
> > MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
> > work for packed YUV formats. Thus, UYVY support is implemented via
> > byte-swapping. This method clearly does not work for implementing
> > support for YVYU and VYUY.
> >
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
>
>
> Paul,
>
> I tested this patch series from one of the older submissions and I was
> able to get it working, but I could not get the video to capture to
> work no matter what resolution or video format I tried.  Each time, I
> get the same error message:  rkisp1 32e10000.isp: start pipeline
> failed -32
>
> Do you have an example of how you configured the pipeline and how you
> invoked the video capture?

I have it working now but I had to apply the patch [1]  provided by
Tomi in order for it to work properly

Can you send another revision with his patch included in the series?

With that, you can add

Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit

Thank you.

adam
[1] - https://gitlab.com/ideasonboard/nxp/linux/-/commit/d6477fe673b1c0d05d=
12ae21d8db9a03b07e7fea

>
> thanks
>
> adam
>
> >
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/=
drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > index a352893308b6..b50b044d22af 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > @@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp=
_fmts[] =3D {
> >                 .uv_swap =3D 0,
> >                 .write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> >                 .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> > +       }, {
> > +               .fourcc =3D V4L2_PIX_FMT_UYVY,
> > +               .uv_swap =3D 0,
> > +               .yc_swap =3D 1,
> > +               .write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> > +               .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> >         }, {
> >                 .fourcc =3D V4L2_PIX_FMT_YUV422P,
> >                 .uv_swap =3D 0,
> > @@ -231,6 +237,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_=
sp_fmts[] =3D {
> >                 .write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
> >                 .output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> >                 .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> > +       }, {
> > +               .fourcc =3D V4L2_PIX_FMT_UYVY,
> > +               .uv_swap =3D 0,
> > +               .yc_swap =3D 1,
> > +               .write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
> > +               .output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> > +               .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> >         }, {
> >                 .fourcc =3D V4L2_PIX_FMT_YUV422P,
> >                 .uv_swap =3D 0,
> > @@ -464,6 +477,20 @@ static void rkisp1_mp_config(struct rkisp1_capture=
 *cap)
> >                 rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg=
);
> >         }
> >
> > +       /*
> > +        * U/V swapping with the MI_XTD_FORMAT_CTRL register only works=
 for
> > +        * NV12/NV21 and NV16/NV61, so instead use byte swap to support=
 UYVY.
> > +        * YVYU and VYUY cannot be supported with this method.
> > +        */
> > +       if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> > +               reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_=
FORMAT);
> > +               if (cap->pix.cfg->yc_swap)
> > +                       reg |=3D RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE=
_SWAP_BYTES;
> > +               else
> > +                       reg &=3D ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYT=
E_SWAP_BYTES;
> > +               rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT,=
 reg);
> > +       }
> > +
> >         rkisp1_mi_config_ctrl(cap);
> >
> >         reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> > @@ -507,6 +534,20 @@ static void rkisp1_sp_config(struct rkisp1_capture=
 *cap)
> >                 rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg=
);
> >         }
> >
> > +       /*
> > +        * U/V swapping with the MI_XTD_FORMAT_CTRL register only works=
 for
> > +        * NV12/NV21 and NV16/NV61, so instead use byte swap to support=
 UYVY.
> > +        * YVYU and VYUY cannot be supported with this method.
> > +        */
> > +       if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> > +               reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_=
FORMAT);
> > +               if (cap->pix.cfg->yc_swap)
> > +                       reg |=3D RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE=
_SWAP_BYTES;
> > +               else
> > +                       reg &=3D ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYT=
E_SWAP_BYTES;
> > +               rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT,=
 reg);
> > +       }
> > +
> >         rkisp1_mi_config_ctrl(cap);
> >
> >         mi_ctrl =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> > --
> > 2.39.2
> >
