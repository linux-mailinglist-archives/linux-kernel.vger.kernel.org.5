Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA198027DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjLCVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 16:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 16:32:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5933C2;
        Sun,  3 Dec 2023 13:33:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28655c04da3so1932667a91.0;
        Sun, 03 Dec 2023 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701639184; x=1702243984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uUY1W5jCT30owrQ3sG0UVyxY52rhXE7pduVYPg+ahQ=;
        b=UzHR5xJZnGO464U1Le00F2cg42NM95OzLpJu4Pvg1yvCFG2aBy2M0aCHfEWkquOZN/
         2zMf6DUzEyKdKoiRbRQCsOzg/hlySHtVU5buo2Uf9HZ6fuK33rKF6z8WqPjG/hQE/QV/
         /XLdfqJzG3F+/IbOgNg3kNJiktP4+vn0w9NTOefzEDVCCFbYz+Tzbpz25k4bePjWgZUP
         yt/uTRd2qKh2iMxwSAe6NAwzagNTjr1cTop9CnSW68Tou0/vpFxD0yAq9HGZAhTE0T4Y
         eOXwv+iSE19GVRTCOLzLqRGmh3+qLsKQJQx71RRbSPR207pD1TVEepdW1tzPgzGK+nqf
         CL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701639184; x=1702243984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUY1W5jCT30owrQ3sG0UVyxY52rhXE7pduVYPg+ahQ=;
        b=nqbtjn4RcgcclDuI7tjQo0SHhINXdOzzJSjxt1MqhS1OJkb43ICfacLa2uzm8hYSjq
         VhC72gYQUco7lmj8b8EZa7norZIbFt4EvGlJthWLNTLSNIuIuxqx5/x0RujMcwIVPkMM
         cGrgAqFCvlVJMdN3tHm5D1aRUWoSHpLCL+XpUDHFVv325gyc0kWWtdfzlfI78tTr35kv
         MugtWahlKEfrX1T1snjGTZhfAroCpTZpThFSRrWa21qNizmovPHfIfMr965TuXGD2f8A
         eaSDAW8G0+Tu8BxXmiNhVuszdXOnZdeLJsQivIuZkHXLv8dpc5b5gX1l4eT44BgjQZGF
         oGYw==
X-Gm-Message-State: AOJu0YxaEKEtzGnY4C/9hVWChNP6RWT414W7QBrR442GKzzRxR3p+y5O
        ADy8zxcg63ByNWnZbGaYqj0x3tjLId0j2MKW4IQ=
X-Google-Smtp-Source: AGHT+IGPWxeHkfwcW6s5frHbR04baTe/Cp+skA++exMPU/AmVPvdrLFK7lu4L+64Z6AB2cWvsAJbNDtD219dx28KB1E=
X-Received: by 2002:a17:90a:b005:b0:286:6cc0:62a3 with SMTP id
 x5-20020a17090ab00500b002866cc062a3mr3345815pjq.34.1701639183857; Sun, 03 Dec
 2023 13:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20231129092759.242641-1-paul.elder@ideasonboard.com> <20231129092759.242641-12-paul.elder@ideasonboard.com>
In-Reply-To: <20231129092759.242641-12-paul.elder@ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 3 Dec 2023 15:32:52 -0600
Message-ID: <CAHCN7xLihh_r=zn+2EsqZvsOumeJY52DHmrkVv0+A7Grib8AhQ@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 3:29=E2=80=AFAM Paul Elder <paul.elder@ideasonboard=
.com> wrote:
>
> Add support for UYVY as an output format. The uv_swap bit in the
> MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
> work for packed YUV formats. Thus, UYVY support is implemented via
> byte-swapping. This method clearly does not work for implementing
> support for YVYU and VYUY.
>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)


Paul,

I tested this patch series from one of the older submissions and I was
able to get it working, but I could not get the video to capture to
work no matter what resolution or video format I tried.  Each time, I
get the same error message:  rkisp1 32e10000.isp: start pipeline
failed -32

Do you have an example of how you configured the pipeline and how you
invoked the video capture?

thanks

adam

>
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/dr=
ivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index a352893308b6..b50b044d22af 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_f=
mts[] =3D {
>                 .uv_swap =3D 0,
>                 .write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
>                 .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> +       }, {
> +               .fourcc =3D V4L2_PIX_FMT_UYVY,
> +               .uv_swap =3D 0,
> +               .yc_swap =3D 1,
> +               .write_format =3D RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +               .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_YUV422P,
>                 .uv_swap =3D 0,
> @@ -231,6 +237,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp=
_fmts[] =3D {
>                 .write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
>                 .output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>                 .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
> +       }, {
> +               .fourcc =3D V4L2_PIX_FMT_UYVY,
> +               .uv_swap =3D 0,
> +               .yc_swap =3D 1,
> +               .write_format =3D RKISP1_MI_CTRL_SP_WRITE_INT,
> +               .output_format =3D RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +               .mbus =3D MEDIA_BUS_FMT_YUYV8_2X8,
>         }, {
>                 .fourcc =3D V4L2_PIX_FMT_YUV422P,
>                 .uv_swap =3D 0,
> @@ -464,6 +477,20 @@ static void rkisp1_mp_config(struct rkisp1_capture *=
cap)
>                 rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
>         }
>
> +       /*
> +        * U/V swapping with the MI_XTD_FORMAT_CTRL register only works f=
or
> +        * NV12/NV21 and NV16/NV61, so instead use byte swap to support U=
YVY.
> +        * YVYU and VYUY cannot be supported with this method.
> +        */
> +       if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> +               reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FO=
RMAT);
> +               if (cap->pix.cfg->yc_swap)
> +                       reg |=3D RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_S=
WAP_BYTES;
> +               else
> +                       reg &=3D ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_=
SWAP_BYTES;
> +               rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, r=
eg);
> +       }
> +
>         rkisp1_mi_config_ctrl(cap);
>
>         reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> @@ -507,6 +534,20 @@ static void rkisp1_sp_config(struct rkisp1_capture *=
cap)
>                 rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
>         }
>
> +       /*
> +        * U/V swapping with the MI_XTD_FORMAT_CTRL register only works f=
or
> +        * NV12/NV21 and NV16/NV61, so instead use byte swap to support U=
YVY.
> +        * YVYU and VYUY cannot be supported with this method.
> +        */
> +       if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> +               reg =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FO=
RMAT);
> +               if (cap->pix.cfg->yc_swap)
> +                       reg |=3D RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_S=
WAP_BYTES;
> +               else
> +                       reg &=3D ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_=
SWAP_BYTES;
> +               rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, r=
eg);
> +       }
> +
>         rkisp1_mi_config_ctrl(cap);
>
>         mi_ctrl =3D rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> --
> 2.39.2
>
