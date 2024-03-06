Return-Path: <linux-kernel+bounces-94284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F9873C78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A1288EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66F135418;
	Wed,  6 Mar 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="P9mQfS6C"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61560882
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743376; cv=none; b=gAqMlP/UI8Rqi3slkyi/FOxhEV3qi0kXDpPiA8t/vjCGuLQxaNuklJNR6vCUFaHqW6Sw2AIwR8WHAd3LBbPkhsQsFXJ2bHGw9NP0GDDCYCKqc8KOUE7qVUHcKaF/M6flgI3MOup4YX4LUT1Y3qHGZss3hnkSnnS39HrTFCbBFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743376; c=relaxed/simple;
	bh=9R9Uql4dpTfR5UzkP02I39c1Wae43SMY2i4QRqQ2E04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1fWnPzID98Y3IYAyMKJrTQy+lgDEpDR8+/bbEVITla5Cx3lAWU/7KvEqe1UigYRVx3L5uONUjrpsKJwqrY6IXRU8fAyoRkRNAmsCO1FJGPUoIiFn8EcyQrhsWeOOfseAu4I8slfGVQHgtsP50r0MtgrMovJArl28KVN7aD0p+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=P9mQfS6C; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so6977148276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1709743373; x=1710348173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yzW7+P93llx+4bGlKmeM0ss5L9EqxXJA6GAV234pxq4=;
        b=P9mQfS6Cm7gD052Fhc4IkDpAg2Mz690/n9h3QqkhPI2iXomb8U3sAFNPjt4TgRVJpk
         fYPC4jNjJmKC2ngB1+ORw13jDfRLWvvQavGIye0g6B7v5EUvOCSVuaI6GTP59lNZGHdU
         FjHLOhflbVQzDkiqFWpqpPE14H8il3ocQ/DjL3YnCAdbU3FryO9Al3E6rD2ZfgBvqRdZ
         H7EcykgL+LW+kXR+pqJs5p2niIVvSqdPyXnl7HUF/L+0tpagJjA42W+ajV9oeSVM3nbU
         xeQN4Kf3pn+4u7zjPWvcEIx8RsX0FaeyPA8E7zKfbNKHXOX+jgq+PP5eJL8G2qySHRqm
         pP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743373; x=1710348173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzW7+P93llx+4bGlKmeM0ss5L9EqxXJA6GAV234pxq4=;
        b=nsJzYtKWm2xgUdUNUnrib1MNHEEb99cUU0FqsAdEa4F/L7P5Qg8fn3eird2zPkgIR1
         phtzxZqslzdjJisUxA7OoeWmD+5OqKYYw5FNNrxfPl80WiKTmj2YbqYjBYZezYPPm+s7
         d9iOf22B4kpGRBsLXhC11AuGEzJJ1z8P85w8ElrEI6elRu4pf937Q4Ttbre/2Zs8s7go
         h9sSU8qltsKUQNgjOavbpHZ0Xc1U2D7TFL5hc2P+qiOGpjODUoQ0p7hkDjGC67cUYi61
         odO1NsReNYaTRlkyzcASL/acWSO0MzDMnYHCAlkax1b35qY3fMgBtQlFagrflN+RWQF6
         ji7g==
X-Forwarded-Encrypted: i=1; AJvYcCUEzmdfIjXOdwU5AMwrCCRCLg3G6DD39+HibZFnlI4bG5iG4yc7f1r2b6YqcOEqtbIpcMIoMTOtiY+AgVENa2NZCEGsLyiItLhye702
X-Gm-Message-State: AOJu0YzRPdQpSo6/CrnLWSs02g8rpUZPY5Wygh03/TH2nmAPm/KyH7uw
	Z5qqPJCWGUR04P4cjGNszvUr15cZgUUsaqFJa3eeFFipCzpB0fGCddg9PcomYUGwueJaQSQTTQQ
	eyGol8f750TQBx/e1Fw3X9Ie+ddKc93ZMyWpkSQ==
X-Google-Smtp-Source: AGHT+IGFvljXxaw12g2V5h9H1EpK5MQBF/YE9XuxVDI14Hwlf+10umhfNZ3LtAFSz8CGLOBPqpBbj9paScPYt1XdPQo=
X-Received: by 2002:a05:6902:2503:b0:dcb:b0f0:23fc with SMTP id
 dt3-20020a056902250300b00dcbb0f023fcmr14726647ybb.22.1709743373120; Wed, 06
 Mar 2024 08:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306081038.212412-1-umang.jain@ideasonboard.com> <20240306081038.212412-2-umang.jain@ideasonboard.com>
In-Reply-To: <20240306081038.212412-2-umang.jain@ideasonboard.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 6 Mar 2024 16:42:36 +0000
Message-ID: <CAPY8ntAv2XCgMoA7N6Wj72jOX4rRt4b-HRUr1WXR1diH1bHx8A@mail.gmail.com>
Subject: Re: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, 
	Alexander Shiyan <eagle.alexander923@gmail.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Umang and Kieran

On Wed, 6 Mar 2024 at 08:11, Umang Jain <umang.jain@ideasonboard.com> wrote:
>
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
> The IMX335 can support both 2 and 4 lane configurations.
> Extend the driver to configure the lane mode accordingly.
> Update the pixel rate depending on the number of lanes in use.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 46 +++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index dab6d080bc4c..a42f48823515 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -21,6 +21,11 @@
>  #define IMX335_MODE_STANDBY    0x01
>  #define IMX335_MODE_STREAMING  0x00
>
> +/* Data Lanes */
> +#define IMX335_LANEMODE                0x3a01
> +#define IMX335_2LANE           1
> +#define IMX335_4LANE           3
> +
>  /* Lines per frame */
>  #define IMX335_REG_LPFR                0x3030
>
> @@ -67,8 +72,6 @@
>  #define IMX335_LINK_FREQ_594MHz                594000000LL
>  #define IMX335_LINK_FREQ_445MHz                445500000LL
>
> -#define IMX335_NUM_DATA_LANES  4
> -
>  #define IMX335_REG_MIN         0x00
>  #define IMX335_REG_MAX         0xfffff
>
> @@ -115,7 +118,6 @@ static const char * const imx335_supply_name[] = {
>   * @vblank: Vertical blanking in lines
>   * @vblank_min: Minimum vertical blanking in lines
>   * @vblank_max: Maximum vertical blanking in lines
> - * @pclk: Sensor pixel clock
>   * @reg_list: Register list for sensor mode
>   */
>  struct imx335_mode {
> @@ -126,7 +128,6 @@ struct imx335_mode {
>         u32 vblank;
>         u32 vblank_min;
>         u32 vblank_max;
> -       u64 pclk;
>         struct imx335_reg_list reg_list;
>  };
>
> @@ -147,6 +148,7 @@ struct imx335_mode {
>   * @exp_ctrl: Pointer to exposure control
>   * @again_ctrl: Pointer to analog gain control
>   * @vblank: Vertical blanking in lines
> + * @lane_mode Mode for number of connected data lanes
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
>   * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
> @@ -171,6 +173,7 @@ struct imx335 {
>                 struct v4l2_ctrl *again_ctrl;
>         };
>         u32 vblank;
> +       u32 lane_mode;
>         const struct imx335_mode *cur_mode;
>         struct mutex mutex;
>         unsigned long link_freq_bitmap;
> @@ -377,7 +380,6 @@ static const struct imx335_mode supported_mode = {
>         .vblank = 2560,
>         .vblank_min = 2560,
>         .vblank_max = 133060,
> -       .pclk = 396000000,
>         .reg_list = {
>                 .num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
>                 .regs = mode_2592x1940_regs,
> @@ -936,6 +938,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
>                 return ret;
>         }
>
> +       /* Configure lanes */
> +       ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
> +       if (ret)
> +               return ret;
> +
>         /* Setup handler will write actual exposure and gain */
>         ret =  __v4l2_ctrl_handler_setup(imx335->sd.ctrl_handler);
>         if (ret) {
> @@ -1096,7 +1103,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>         if (ret)
>                 return ret;
>
> -       if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX335_NUM_DATA_LANES) {
> +       switch (bus_cfg.bus.mipi_csi2.num_data_lanes) {
> +       case 2:
> +               imx335->lane_mode = IMX335_2LANE;
> +               break;
> +       case 4:
> +               imx335->lane_mode = IMX335_4LANE;
> +               break;
> +       default:
>                 dev_err(imx335->dev,
>                         "number of CSI2 data lanes %d is not supported\n",
>                         bus_cfg.bus.mipi_csi2.num_data_lanes);
> @@ -1209,6 +1223,9 @@ static int imx335_init_controls(struct imx335 *imx335)
>         struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>         const struct imx335_mode *mode = imx335->cur_mode;
>         u32 lpfr;
> +       u64 pclk;
> +       s64 link_freq_in_use;
> +       u8 bpp;
>         int ret;
>
>         ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
> @@ -1252,11 +1269,24 @@ static int imx335_init_controls(struct imx335 *imx335)
>                                      0, 0, imx335_tpg_menu);
>
>         /* Read only controls */
> +
> +       /* pixel rate = link frequency * lanes * 2 / bits_per_pixel */
> +       switch (imx335->cur_mbus_code) {
> +       case MEDIA_BUS_FMT_SRGGB10_1X10:
> +               bpp = 10;
> +               break;
> +       case MEDIA_BUS_FMT_SRGGB12_1X12:
> +               bpp = 12;
> +               break;
> +       }
> +
> +       link_freq_in_use = link_freq[__ffs(imx335->link_freq_bitmap)];
> +       pclk = link_freq_in_use * (imx335->lane_mode + 1) * 2 / bpp;
>         imx335->pclk_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>                                               &imx335_ctrl_ops,
>                                               V4L2_CID_PIXEL_RATE,
> -                                             mode->pclk, mode->pclk,
> -                                             1, mode->pclk);
> +                                             pclk, pclk,
> +                                             1, pclk);

Is this actually correct?
A fair number of the sensors I've encountered have 2 PLL paths - one
for the pixel array, and one for the CSI block. The bpp will generally
be fed into the CSI block PLL path, but not into the pixel array one.
The link frequency will therefore vary with bit depth, but
V4L2_CID_PIXEL_RATE doesn't change.

imx290 certainly has a disjoin between pixel rate and link freq
(cropping reduces link freq, but not pixel rate), and we run imx477 in
2 lane mode with the pixel array at full tilt (840MPix/s) but large
horizontal blanking to allow CSI2 enough time to send the data.

If you've validated that for a range of frame rates you get the
correct output from the sensor in both 10 and 12 bit modes, then I
don't object. I just have an instinctive tick whenever I see drivers
computing PIXEL_RATE from LINK_FREQ or vice versa :)
If you get the right frame rate it may also imply that the link
frequency isn't as configured, but that rarely has any negative
effects. You need a reasonably good oscilloscope to be able to measure
the link frequency.

  Dave

>
>         imx335->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>                                                         &imx335_ctrl_ops,
> --
> 2.43.0
>
>

