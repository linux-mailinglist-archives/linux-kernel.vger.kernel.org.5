Return-Path: <linux-kernel+bounces-90973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A98707D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E61C23300
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED395FF0E;
	Mon,  4 Mar 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pXvtHXTd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9A5CDC8;
	Mon,  4 Mar 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571670; cv=none; b=p7ruElG6fxszs8C0R561lSK6vMMO1lldXMSi3ov4zOY8jtSu4/RHUozGWw/XGZ48MB+mcboy9b4HbDXzqrvNUzjcUbdrBE5u5LWFj5qKV1Ym+5Hgwt5Hh2WpzFzuyZPlbk8bhqxbf990o86TQTJ5i9OKLD0apl5eBWPvkd+pnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571670; c=relaxed/simple;
	bh=YIorEZgZ3oGb/vzKCLKNk60LiCpWqfOM0YBnH4BtxMA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=QGEGc3OCnku3BjqBsKcQ9GW5VcsgcXkzyvMr9Yd9I4WOudzHcAKF3+gj1jj6Cg5GtE6AHSAR0fxuj1EfkLBnZcEoe/UmBVQIQxd3kePfwEu1vJXtIv8aHpsSPtOHyGNSeWHxtFNYfV+4JUJx8u+6YU9qp6A028IAtkdgaRS0p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pXvtHXTd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B66DC3871;
	Mon,  4 Mar 2024 18:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709571650;
	bh=YIorEZgZ3oGb/vzKCLKNk60LiCpWqfOM0YBnH4BtxMA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pXvtHXTdPpvHnkCmRsMboe7vEl69AKv7bnOeRk36NgDF4PafK9ejuA2kHr/zSmVGM
	 BLHcWgjoY9Z2ROjTiN0T2wfyz2vWdqPnHPygsBA9Dsjpqx3cZeqWeOWYnj1goedBse
	 DpBV4uFxed/GJ9DHT2TNSFKbD22yUkV3DX6epKwA=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229165333.227484-16-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com> <20240229165333.227484-16-mike.rudenko@gmail.com>
Subject: Re: [PATCH v3 15/20] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Mikhail Rudenko <mike.rudenko@gmail.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Mon, 04 Mar 2024 17:01:03 +0000
Message-ID: <170957166393.566498.15793679548329156107@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Mikhail Rudenko (2024-02-29 16:53:28)
> Pixel array dimensions and default crop size do not belong to the
> ov4689_mode structure, since they are mode independent. Make them
> defines instead.
>=20
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 6c36fe5f3b44..cc8d9fa369e7 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -70,6 +70,11 @@
>  #define OV4689_LANES                   4
>  #define OV4689_XVCLK_FREQ              24000000
> =20
> +#define OV4689_PIXEL_ARRAY_WIDTH       2720
> +#define OV4689_PIXEL_ARRAY_HEIGHT      1536
> +#define OV4689_DUMMY_ROWS              8       /* 8 dummy rows on each s=
ide */
> +#define OV4689_DUMMY_COLUMNS           16      /* 16 dummy columns on ea=
ch side */
> +
>  static const char *const ov4689_supply_names[] =3D {
>         "avdd", /* Analog power */
>         "dovdd", /* Digital I/O power */
> @@ -90,10 +95,6 @@ struct ov4689_mode {
>         u32 vts_def;
>         u32 exp_def;
>         u32 pixel_rate;
> -       u32 sensor_width;
> -       u32 sensor_height;
> -       u32 crop_top;
> -       u32 crop_left;
>         const struct cci_reg_sequence *reg_list;
>         unsigned int num_regs;
>  };
> @@ -254,10 +255,6 @@ static const struct ov4689_mode supported_modes[] =
=3D {
>                 .id =3D OV4689_MODE_2688_1520,
>                 .width =3D 2688,
>                 .height =3D 1520,
> -               .sensor_width =3D 2720,
> -               .sensor_height =3D 1536,
> -               .crop_top =3D 8,
> -               .crop_left =3D 16,
>                 .exp_def =3D 1536,
>                 .hts_def =3D 10296,
>                 .hts_min =3D 3432,
> @@ -385,8 +382,6 @@ static int ov4689_get_selection(struct v4l2_subdev *s=
d,
>                                 struct v4l2_subdev_state *state,
>                                 struct v4l2_subdev_selection *sel)
>  {
> -       const struct ov4689_mode *mode =3D to_ov4689(sd)->cur_mode;
> -
>         if (sel->which !=3D V4L2_SUBDEV_FORMAT_ACTIVE)
>                 return -EINVAL;
> =20
> @@ -394,15 +389,17 @@ static int ov4689_get_selection(struct v4l2_subdev =
*sd,
>         case V4L2_SEL_TGT_CROP_BOUNDS:
>                 sel->r.top =3D 0;
>                 sel->r.left =3D 0;
> -               sel->r.width =3D mode->sensor_width;
> -               sel->r.height =3D mode->sensor_height;
> +               sel->r.width =3D OV4689_PIXEL_ARRAY_WIDTH;
> +               sel->r.height =3D OV4689_PIXEL_ARRAY_HEIGHT;
>                 return 0;
>         case V4L2_SEL_TGT_CROP:
>         case V4L2_SEL_TGT_CROP_DEFAULT:
> -               sel->r.top =3D mode->crop_top;
> -               sel->r.left =3D mode->crop_left;
> -               sel->r.width =3D mode->width;
> -               sel->r.height =3D mode->height;
> +               sel->r.top =3D OV4689_DUMMY_ROWS;
> +               sel->r.left =3D OV4689_DUMMY_COLUMNS;
> +               sel->r.width =3D
> +                       OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUM=
NS;
> +               sel->r.height =3D
> +                       OV4689_PIXEL_ARRAY_HEIGHT - 2 * OV4689_DUMMY_ROWS;
>                 return 0;
>         }
> =20
> --=20
> 2.43.0
>

