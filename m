Return-Path: <linux-kernel+bounces-96860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE687624E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5BAB22170
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E35576D;
	Fri,  8 Mar 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCuKD/a7"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A242061;
	Fri,  8 Mar 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894581; cv=none; b=G/e87pai25nt82558PU5qs+O4C4cwvHsaEK2j3YW5+n/vLrFxUP61T8GqI8aUzRsnwF6U4PjLSrj6GdVSag27s3yjapCSI/EXdGxfeSA9mubAFY43uT6sgsfqcMGw1mAbFVzcROJ3n0cPGNqIKpMMxjQwAt99sB6gQwEPhVKn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894581; c=relaxed/simple;
	bh=Hskuh0jcTrLaj35GMhuvTS9BPTLaCsiZ/Ramp31XeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKLb8QxN6u3IpJz0ZPokDiQt/8sT5/u5VJ6y2RGZdNNO7DsH1UpR2KYSRDOyUvHn+7XNM2EnGmQQ1CDhsMwXE+Z45HCTopLCwDD/AJ57QNpDRA+hTY2D8ziZ0/ybonuuwThQRQ6Kyg5p/z2XU+2fNW17petdxheCwXK6Z/Hw36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCuKD/a7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so246512966b.0;
        Fri, 08 Mar 2024 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709894578; x=1710499378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnXeKNe3Pth18IqLBpLGUfhGrY47izo6nmAUIr2+va0=;
        b=UCuKD/a7Gz0QlR2l7xXHAtWsRAo00atLD3GGYIancPJeWMjwU3T4/LKdoqztxSe6pp
         pfKWUg1aNy8MP1hh/hc5MfoD0ZxL9FevQCBMkt+2Y/sWY5ZUKsahAuelQ5/r6GybcBNE
         RuhSR+tTdQeUdLXfFAyZGC52NSbw4OC+7qxt8TIOsR+VTRNeUHAmcigtfcYNsVC7ELXT
         IoODx3rWu7iuqmREjMX+XrK2yqCVcGWT1uVuLY7+/382hqvPI3+Eeu/dA7a+lsKlcnu7
         4ToIh5Xt/V6ZEsGXk0l5PFBnpL4EA48Rjzeqp/yfeeYOu4Kf93MKYFSjY7w2Hb35pb7v
         0T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894578; x=1710499378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnXeKNe3Pth18IqLBpLGUfhGrY47izo6nmAUIr2+va0=;
        b=NL30iFdx1TIPsTaDPPGousZY5ftV+GA9pgORzMXO4E+lpNfMyykFDO5QvDpTDY4gpw
         aKSnEcpSE8/ntB/G3ovxukT4HDipvsY3dxpLwq8+QoEc8xZAmZZSFyWvzBBTEALkupAc
         8ltQATfV7mY9dHFPZ2BtwlzO7T23XoTN0b4csMIzfighPxqXX1ZPh9hQaTCI9LJ9QxGk
         eKU3tB7P8gHwJDCYeDuQRB5aZsughxwc4O8SnmsApj33xr1rsH+KKKaCTucAIP1YgoEg
         sbU8LNlf+HOVb6oTJlTZcWOQbrfm6+Xl6lpt0Tahr4aDoQqPO4z58rTRX+Ce3e1P365a
         QLlw==
X-Forwarded-Encrypted: i=1; AJvYcCX9e1PFZd4AtJZsatnX3cgWNUOHp5EvEUk5XLE3TMDw+B30YembHJITniIPASxikn0szZs/6jg5/VMagnCj0X71BXP9suZ8UZGYW0Q7
X-Gm-Message-State: AOJu0YyGH0/znOyR2tKyzJD0fqJgzRx6yi9BzmGlbohjq5mOsxwSbMef
	McqYD7gisC5pON3WWlsT6iRF0RVLFHb5CJUEVq4DEkoVrUFxI1Jk
X-Google-Smtp-Source: AGHT+IESCUTGqASumIRxK7U41TDylsD3apKm0+G3vyNHYy9bMp467afRiz4QVnpfuoQd7c5oZbjJNw==
X-Received: by 2002:a17:906:3bd5:b0:a3f:ac54:5aa1 with SMTP id v21-20020a1709063bd500b00a3fac545aa1mr15553263ejf.21.1709894577966;
        Fri, 08 Mar 2024 02:42:57 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm6208907ejb.14.2024.03.08.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:42:57 -0800 (PST)
Date: Fri, 8 Mar 2024 11:42:55 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 1/6] media: imx335: Support 2 or 4 lane operation modes
Message-ID: <Zerrr01BhCxIQq1d@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
 <20240308083312.90279-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308083312.90279-2-umang.jain@ideasonboard.com>

Hi Umang,

On Fri, Mar 08, 2024 at 02:03:07PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> The IMX335 can support both 2 and 4 lane configurations.
> Extend the driver to configure the lane mode accordingly.
> Update the pixel rate depending on the number of lanes in use.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index b47ec71054c3..7162b0a3cef3 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -21,6 +21,11 @@
>  #define IMX335_MODE_STANDBY	0x01
>  #define IMX335_MODE_STREAMING	0x00
>  
> +/* Data Lanes */
> +#define IMX335_LANEMODE		0x3a01
> +#define IMX335_2LANE		1
> +#define IMX335_4LANE		3
> +
>  /* Lines per frame */
>  #define IMX335_REG_LPFR		0x3030
>  
> @@ -145,6 +150,7 @@ struct imx335_mode {
>   * @exp_ctrl: Pointer to exposure control
>   * @again_ctrl: Pointer to analog gain control
>   * @vblank: Vertical blanking in lines
> + * @lane_mode Mode for number of connected data lanes
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
>   * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
> @@ -169,6 +175,7 @@ struct imx335 {
>  		struct v4l2_ctrl *again_ctrl;
>  	};
>  	u32 vblank;
> +	u32 lane_mode;
>  	const struct imx335_mode *cur_mode;
>  	struct mutex mutex;
>  	unsigned long link_freq_bitmap;
> @@ -934,6 +941,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
>  		return ret;
>  	}
>  
> +	/* Configure lanes */
> +	ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
> +	if (ret)
> +		return ret;
> +
>  	/* Setup handler will write actual exposure and gain */
>  	ret =  __v4l2_ctrl_handler_setup(imx335->sd.ctrl_handler);
>  	if (ret) {
> @@ -1094,7 +1106,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  	if (ret)
>  		return ret;
>  
> -	if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX335_NUM_DATA_LANES) {
> +	switch (bus_cfg.bus.mipi_csi2.num_data_lanes) {
> +	case 2:
> +		imx335->lane_mode = IMX335_2LANE;
> +		break;
> +	case 4:
> +		imx335->lane_mode = IMX335_4LANE;
> +		break;
> +	default:
>  		dev_err(imx335->dev,
>  			"number of CSI2 data lanes %d is not supported\n",
>  			bus_cfg.bus.mipi_csi2.num_data_lanes);


Looks good to me.

Similar on what we have on imx219 drv:
ret = imx219_configure_lanes(imx219);

Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso

> -- 
> 2.43.0
> 
> 

