Return-Path: <linux-kernel+bounces-90966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7138707B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319821F2203F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF25D738;
	Mon,  4 Mar 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SlltTY1l"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1A45BF6;
	Mon,  4 Mar 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571252; cv=none; b=HpX2qtYc2PPHD6ywqR5ZoG/XpXHOcSDCerexRaq8Qo2F263YhRamr4BsGWbky+jIsadEELfeTWhrdFqkSiLIW7ITsl5W9lWjESVolE6x4e/o1l5SEAX+eMN2lr6QGIi7EYT3DBqzwWbANpd52wpxFf3xwDRsggYL2DLNNKjDbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571252; c=relaxed/simple;
	bh=+R7oTg+kxjTKyaKYxZHYT42wyBy1AiS9hgSVvfLNDyo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=dFz8L7TumJBUWy8iuShfrqNE6kbB7yeJQ8kwhzSY2xWtmQLttLBZZupIQ4ZKSPUcaKFlx/SkpjCYIoNiNhsl6tgjjlYJKwPv+BbDR/xKLCL3jF7/BLqJt+nAAWgPh95lbuyTvPFaJWOjZAriSoGxclDODpZbAFyJKPkl30x99rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SlltTY1l; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 517FD3871;
	Mon,  4 Mar 2024 17:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709571232;
	bh=+R7oTg+kxjTKyaKYxZHYT42wyBy1AiS9hgSVvfLNDyo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SlltTY1lkILhpK1EXZ/YXpEMFb8cbBxwNoZkuDArAucNSaR1T/TRKkkC92Kt2ZMgM
	 Y9fxl+n17THj3Pv8pwvbX3yoB+szb//puxlu6GjtAsvNrf6+c56BJO2j67/ocUT5jc
	 2SIB5iJK5KtgHlVJZOySFlhlKvaBUO1R8f26jyrw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229165333.227484-13-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com> <20240229165333.227484-13-mike.rudenko@gmail.com>
Subject: Re: [PATCH v3 12/20] media: i2c: ov4689: Implement vflip/hflip controls
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Mikhail Rudenko <mike.rudenko@gmail.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Mon, 04 Mar 2024 16:54:05 +0000
Message-ID: <170957124561.566498.576610873794356352@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Mikhail Rudenko (2024-02-29 16:53:25)
> The OV4689 sensor supports horizontal and vertical flipping. Add
> appropriate controls to the driver. Toggling both array flip and
> digital flip bits allows to achieve flipping while maintaining output
> Bayer order. Note that the default value of hflip control corresponds
> to both bits set, as it was before this patch.
>=20
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 8283a9ac86c9..01ee8cadb7c9 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -42,6 +42,14 @@
>  #define OV4689_REG_VTS                 CCI_REG16(0x380e)
>  #define OV4689_VTS_MAX                 0x7fff
> =20
> +#define OV4689_REG_TIMING_FORMAT1      CCI_REG8(0x3820)
> +#define OV4689_REG_TIMING_FORMAT2      CCI_REG8(0x3821)

I assume these registerse are called TIMING_FORMAT1 and TIMING_FORMAT2,
and they don't have any named reference to H/V?

It's a shame, but I might add /* Horizontal */ and /* Vertical */
accordingly to these definitions, though not specifically required.


Looks like a good breakdown of the control though.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> +#define OV4689_TIMING_FLIP_MASK                GENMASK(2, 1)
> +#define OV4689_TIMING_FLIP_ARRAY       BIT(1)
> +#define OV4689_TIMING_FLIP_DIGITAL     BIT(2)
> +#define OV4689_TIMING_FLIP_BOTH                (OV4689_TIMING_FLIP_ARRAY=
 |\
> +                                        OV4689_TIMING_FLIP_DIGITAL)
> +
>  #define OV4689_REG_TEST_PATTERN                CCI_REG8(0x5040)
>  #define OV4689_TEST_PATTERN_ENABLE     0x80
>  #define OV4689_TEST_PATTERN_DISABLE    0x0
> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520=
_regs[] =3D {
>         {CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] =3D 0x08*/
>         {CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] =3D 0x04 =
*/
>         {CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] =3D=
 0x01 */
> -       {CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror =3D 1,=
 digital_h_mirror =3D 1 */
> =20
>         /* OTP control */
>         {CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_=
enable =3D 1,
> @@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>                           (ctrl->val + ov4689->cur_mode->width) /
>                           OV4689_HTS_DIVIDER, &ret);
>                 break;
> +       case V4L2_CID_VFLIP:
> +               cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
> +                               OV4689_TIMING_FLIP_MASK,
> +                               ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, =
&ret);
> +               break;
> +       case V4L2_CID_HFLIP:
> +               cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
> +                               OV4689_TIMING_FLIP_MASK,
> +                               ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, =
&ret);
> +               break;
>         default:
>                 dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>                          __func__, ctrl->id, ctrl->val);
> @@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *=
ov4689)
> =20
>         handler =3D &ov4689->ctrl_handler;
>         mode =3D ov4689->cur_mode;
> -       ret =3D v4l2_ctrl_handler_init(handler, 10);
> +       ret =3D v4l2_ctrl_handler_init(handler, 12);
>         if (ret)
>                 return ret;
> =20
> @@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *=
ov4689)
>                                      ARRAY_SIZE(ov4689_test_pattern_menu)=
 - 1,
>                                      0, 0, ov4689_test_pattern_menu);
> =20
> +       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1=
, 1, 0);
> +       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1=
, 1, 0);
> +
>         if (handler->error) {
>                 ret =3D handler->error;
>                 dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret=
);
> --=20
> 2.43.0
>

