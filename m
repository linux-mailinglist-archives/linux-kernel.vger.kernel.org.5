Return-Path: <linux-kernel+bounces-78246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBE8610A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A77B254DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC347A718;
	Fri, 23 Feb 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N9svXHzD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE45DF25;
	Fri, 23 Feb 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688643; cv=none; b=M33XiPn2zgoQOgYim9vTOLRwM2AqrZR72b0ekzxiqyHRuKgP670Uarbk8UQbhoffCRWxT34mgArChohP7Dm6bMkl2voTUee58/UQ319VmGRBhSw3a3sw+slJdoXc9pDQ0Ams7jgq6kDeZ9JDAZY9JOJUPNB0f6DPTMhlSqbkxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688643; c=relaxed/simple;
	bh=8enU/4whM7qWXDf6HDcQ5bdACTmgEDeZXMb0Cy4Jang=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0LG32/aYZD/4N0K6npHbUU+cf9Sim9i+Tm8TNCux3QAAaOXvlLwMl+C0xmb6QZORMFONc1+0S8nGBTgPgr7ra8DGljSpXcxNrx4Ji4JFky4FVP6Tnx3twmuLkjJI1OjqoWT6QQgFCtKbGUATQwA3CQxKaWRqWjqg0C/or/BY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=N9svXHzD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D68422E7;
	Fri, 23 Feb 2024 12:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708688631;
	bh=8enU/4whM7qWXDf6HDcQ5bdACTmgEDeZXMb0Cy4Jang=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9svXHzDdy4U1QZl4uRPDfSAVUPOLmq2tXSbTV0gbvr4gWhdGcGldrmfRajFXHFE/
	 AUT7XwCs71H6cruk3I0T3wFHEBUn0+jlOwnmZijy7G5+FzMf++opxKbW5MAXOqssOZ
	 OKLFgNNdQvCIgcyV7QbPZF61neUn4BaZL6ncT//8=
Date: Fri, 23 Feb 2024 13:44:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 16/20] media: i2c: ov4689: Set timing registers
 programmatically
Message-ID: <20240223114403.GT31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-17-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-17-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:37PM +0300, Mikhail Rudenko wrote:
> Set timing-related and BLC anchor registers via cci calls instead of
> hardcoding them in the register table. This prepares the driver for
> implementation of configurable analogue crop and binning. No
> functional change intended.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 83 +++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 475508559e3e..3b73ee282761 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -41,6 +41,13 @@
>  #define OV4689_DIG_GAIN_STEP		1
>  #define OV4689_DIG_GAIN_DEFAULT		0x800
>  
> +#define OV4689_REG_H_CROP_START		CCI_REG16(0x3800)
> +#define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
> +#define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
> +#define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
> +#define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
> +#define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
> +
>  #define OV4689_REG_HTS			CCI_REG16(0x380c)
>  #define OV4689_HTS_DIVIDER		4
>  #define OV4689_HTS_MAX			0x7fff
> @@ -48,6 +55,9 @@
>  #define OV4689_REG_VTS			CCI_REG16(0x380e)
>  #define OV4689_VTS_MAX			0x7fff
>  
> +#define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
> +#define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
> +
>  #define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
>  #define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
>  #define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
> @@ -56,6 +66,17 @@
>  #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>  					 OV4689_TIMING_FLIP_DIGITAL)
>  
> +#define OV4689_REG_ANCHOR_LEFT_START	CCI_REG16(0x4020)
> +#define OV4689_ANCHOR_LEFT_START_DEF	576
> +#define OV4689_REG_ANCHOR_LEFT_END	CCI_REG16(0x4022)
> +#define OV4689_ANCHOR_LEFT_END_DEF	831
> +#define OV4689_REG_ANCHOR_RIGHT_START	CCI_REG16(0x4024)
> +#define OV4689_ANCHOR_RIGHT_START_DEF	1984
> +#define OV4689_REG_ANCHOR_RIGHT_END	CCI_REG16(0x4026)
> +#define OV4689_ANCHOR_RIGHT_END_DEF	2239
> +
> +#define OV4689_REG_VFIFO_CTRL_01	CCI_REG8(0x4601)
> +
>  #define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
>  #define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
>  #define OV4689_WB_GAIN_MIN		1
> @@ -199,10 +220,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>  	{CCI_REG8(0x3798), 0x1b},
>  
>  	/* Timing control */
> -	{CCI_REG8(0x3801), 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
> -	{CCI_REG8(0x3805), 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
> -	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
> -	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>  
>  	/* OTP control */
> @@ -218,22 +235,11 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>  	{CCI_REG8(0x401b), 0x00}, /* DEBUG_MODE */
>  	{CCI_REG8(0x401d), 0x00}, /* DEBUG_MODE */
>  	{CCI_REG8(0x401f), 0x00}, /* DEBUG_MODE */
> -	{CCI_REG8(0x4020), 0x00}, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
> -	{CCI_REG8(0x4021), 0x10}, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
> -	{CCI_REG8(0x4022), 0x07}, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
> -	{CCI_REG8(0x4023), 0xcf}, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
> -	{CCI_REG8(0x4024), 0x09}, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
> -	{CCI_REG8(0x4025), 0x60}, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
> -	{CCI_REG8(0x4026), 0x09}, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
> -	{CCI_REG8(0x4027), 0x6f}, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
>  
>  	/* ADC sync control */
>  	{CCI_REG8(0x4500), 0x6c}, /* ADC_SYNC_CTRL */
>  	{CCI_REG8(0x4503), 0x01}, /* ADC_SYNC_CTRL */
>  
> -	/* VFIFO */
> -	{CCI_REG8(0x4601), 0xa7}, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
> -
>  	/* Temperature monitor */
>  	{CCI_REG8(0x4d00), 0x04}, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
>  	{CCI_REG8(0x4d01), 0x42}, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
> @@ -406,6 +412,41 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  	return -EINVAL;
>  }
>  
> +static int ov4689_setup_timings(struct ov4689 *ov4689)
> +{
> +	const struct ov4689_mode *mode = ov4689->cur_mode;
> +	struct regmap *rm = ov4689->regmap;
> +	int ret = 0;
> +
> +	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
> +	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
> +	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
> +	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);

This is interesting. The previous patch defines

#define OV4689_PIXEL_ARRAY_WIDTH	2720
#define OV4689_PIXEL_ARRAY_HEIGHT	1536
#define OV4689_DUMMY_ROWS		8
#define OV4689_DUMMY_COLUMNS		16

and the (only) mode has

	.width = 2688,
	.height = 1520,

The above register values should result in an analog crop rectangle size
of 2704x1524. Then, the digital crop is configured below to
(8,4)/2688x1520. The combined crop rectangle, relative to the pixel
array, is thus (16,12)/2688x1520. This centers the crop rectangle
horizontally but not vertically. I wonder why, and I also wonder why
there's a need to apply both analog crop and digital crop, instead of
setting

	OV4689_REG_H_CROP_START = 16
	OV4689_REG_V_CROP_START = 8
	OV4689_REG_H_CROP_END = 2703
	OV4689_REG_V_CROP_END = 1527

	OV4689_REG_H_WIN_OFF = 0
	OV4689_REG_V_WIN_OFF = 0
	OV4689_REG_H_OUTPUT_SIZE = 2688
	OV4689_REG_V_OUTPUT_SIZE = 1520

Anyway, this is not an issue introduced by this patch, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
> +	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
> +
> +	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
> +	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
> +
> +	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
> +
> +	return ret;
> +}
> +
> +static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
> +{
> +	struct regmap *rm = ov4689->regmap;
> +	int ret = 0;
> +
> +	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
> +	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
> +	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
> +	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
> +
> +	return ret;
> +}
> +
>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  {
>  	struct ov4689 *ov4689 = to_ov4689(sd);
> @@ -429,6 +470,18 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  			goto unlock_and_return;
>  		}
>  
> +		ret = ov4689_setup_timings(ov4689);
> +		if (ret) {
> +			pm_runtime_put(dev);
> +			goto unlock_and_return;
> +		}
> +
> +		ret = ov4689_setup_blc_anchors(ov4689);
> +		if (ret) {
> +			pm_runtime_put(dev);
> +			goto unlock_and_return;
> +		}
> +
>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>  		if (ret) {
>  			pm_runtime_put_sync(dev);

-- 
Regards,

Laurent Pinchart

