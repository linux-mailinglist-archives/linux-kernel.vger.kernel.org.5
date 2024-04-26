Return-Path: <linux-kernel+bounces-160394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F538B3D01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24A4282203
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0E156C6A;
	Fri, 26 Apr 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JQV67AGr"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95A6BFB1;
	Fri, 26 Apr 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149593; cv=none; b=fgzGrOeF7Fq20L3EoxrBim/LFknTnFZSz4Mr8W8TvjMonGNcPawAkzD26s4EE2yeGNJE0hXAEIJt1fJXmZcCZ9n7KEarPZlHoEF7bfgiBxcX1mHKpisNxa13wbprc61POMmL/1NuyZ0+IDvgCr1n32sMIzWCjdJfQJ+lZLUa+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149593; c=relaxed/simple;
	bh=j5iLYzPpblHQYBHiQVcgSxQL9XIu3cN5kW0xxQXz4V4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWI51dNFC37LT5CxJOZFs4kjE+UbWlONjfLINL1McPM6KOPM5znL8IXrtDIUCsrqzC/iDTOO41d5aunaHzwyk1ZSJKAep4EXYJEENaHTxWAVRGXCE5XFPmQpLZ/LPf0Ip1YIXJLWBdiV7UuaLufVOzPg1h9biC33x7RuKOYn+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JQV67AGr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QECS8S021490;
	Fri, 26 Apr 2024 18:39:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=selector1; bh=jrxiO6XkXlEF0JiHZSjDF
	DkaD4ANPxJ0J6wMuzX1sQA=; b=JQV67AGrn4CzciZ7QZKXjy4ibcvoKobk50SEC
	HmXR4PKnQ0QoAHUyfRXSBAJYGFRX3kifeI64spOHEkzClvEE1gO4PxPARGrVFNFL
	Cxm2ZLYMTopjGSwuPkgbsHBIuAyNAUTc6FMK3syWqlQfVM7AR8vJjfLK/SZOuBDd
	QbNuSEJrP4I9ZRRVRbCqnI/EJ/UzveU6gzLRiKUyl9S6yplLiXsNo5q2E3ZwhPi+
	XcyLFzDUpo7mamC0wtEUrSsM4uhdnEHjqauaklrWWcfJ7p0pPLiFGMS9gzBUI964
	tBOx5ybztZqYu1uy/8kOvwsUFsS6Ckj/mlkejVKJkJckiLS3A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51wk36j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 18:39:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 153D34002D;
	Fri, 26 Apr 2024 18:39:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10B6E22A6E0;
	Fri, 26 Apr 2024 18:38:34 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 18:38:33 +0200
Date: Fri, 26 Apr 2024 18:38:26 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Pavel Machek <pavel@ucw.cz>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 2/2] media: gc2145: implement basic dvp bus support
Message-ID: <20240426163826.GA3095395@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
 <20240222062214.2627810-3-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222062214.2627810-3-andrej.skvortzov@gmail.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02

Hi Andrey,

sorry for the very long delay in reviewing / testing that patch.

I don't have an GC2145 parallel setup however I can confirm that
GC2145 CSI behaves properly with this patch applied on stm32mp13.

See below few comment

On Thu, Feb 22, 2024 at 09:22:14AM +0300, Andrey Skvortsov wrote:

> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Maybe you could write a bit more within the commit log.

> ---
>  drivers/media/i2c/gc2145.c | 122 +++++++++++++++++++++++++++++--------
>  1 file changed, 96 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/i2c/gc2145.c b/drivers/media/i2c/gc2145.c
> index bef7b0e056a8..2c5c9f3de5ff 100644
> --- a/drivers/media/i2c/gc2145.c
> +++ b/drivers/media/i2c/gc2145.c
> @@ -39,6 +39,10 @@
>  #define GC2145_REG_ANALOG_MODE1	CCI_REG8(0x17)
>  #define GC2145_REG_OUTPUT_FMT	CCI_REG8(0x84)
>  #define GC2145_REG_SYNC_MODE	CCI_REG8(0x86)
> +#define GC2145_SYNC_MODE_VSYNC_POL	BIT(0)
> +#define GC2145_SYNC_MODE_HSYNC_POL	BIT(1)
> +#define GC2145_SYNC_MODE_OPCLK_POL	BIT(2)
> +#define GC2145_SYNC_MODE_OPCLK_GATE	BIT(3)

OPCLK_GATE added but never used.

>  #define GC2145_SYNC_MODE_COL_SWITCH	BIT(4)
>  #define GC2145_SYNC_MODE_ROW_SWITCH	BIT(5)
>  #define GC2145_REG_BYPASS_MODE	CCI_REG8(0x89)
> @@ -53,6 +57,12 @@
>  #define GC2145_REG_GLOBAL_GAIN	CCI_REG8(0xb0)
>  #define GC2145_REG_CHIP_ID	CCI_REG16(0xf0)
>  #define GC2145_REG_PAD_IO	CCI_REG8(0xf2)
> +#define GC2145_REG_PLL_MODE1	CCI_REG8(0xf7)
> +#define GC2145_REG_PLL_MODE2	CCI_REG8(0xf8)
> +#define GC2145_REG_CM_MODE	CCI_REG8(0xf9)
> +#define GC2145_REG_CLK_DIV_MODE	CCI_REG8(0xfa)
> +#define GC2145_REG_ANALOG_PWC	CCI_REG8(0xfc)

All 5 define added but never used, those settings are part of the cci_sequences
table. Maybe either keep the define and update the tables or drop the
new define ?

> +#define GC2145_REG_PAD_IO	CCI_REG8(0xf2)

Was already defined in the existing code, see above.

>  #define GC2145_REG_PAGE_SELECT	CCI_REG8(0xfe)
>  /* Page 3 */
>  #define GC2145_REG_DPHY_ANALOG_MODE1	CCI_REG8(0x01)
> @@ -598,6 +608,7 @@ struct gc2145 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
>  
> +	struct v4l2_fwnode_endpoint ep; /* the parsed DT endpoint info */
>  	struct regmap *regmap;
>  	struct clk *xclk;
>  
> @@ -773,6 +784,38 @@ static int gc2145_set_pad_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> +static int gc2145_config_dvp_mode(struct gc2145 *gc2145,
> +				   const struct gc2145_format *gc2145_format)

alignment ?

> +{
> +	int ret = 0;
> +	u64 sync_mode;
> +	int flags;
> +
> +	flags = gc2145->ep.bus.parallel.flags;

int flags = gc2145->ep.bus.parallel.flags;
?

> +
> +	ret = cci_read(gc2145->regmap, GC2145_REG_SYNC_MODE, &sync_mode, NULL);
> +	if (ret)
> +		return ret;
> +
> +	sync_mode &= ~(GC2145_SYNC_MODE_VSYNC_POL |
> +		       GC2145_SYNC_MODE_HSYNC_POL |
> +		       GC2145_SYNC_MODE_OPCLK_POL);
> +
> +	if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
> +		sync_mode |= GC2145_SYNC_MODE_VSYNC_POL;
> +
> +	if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
> +		sync_mode |= GC2145_SYNC_MODE_HSYNC_POL;
> +
> +	if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
> +		sync_mode |= GC2145_SYNC_MODE_OPCLK_POL;
> +
> +	cci_write(gc2145->regmap, GC2145_REG_SYNC_MODE, sync_mode, &ret);
> +	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x0f, &ret);
> +
> +	return ret;
> +}
> +
>  static const struct cci_reg_sequence gc2145_common_mipi_regs[] = {
>  	{GC2145_REG_PAGE_SELECT, 0x03},
>  	{GC2145_REG_DPHY_ANALOG_MODE1, GC2145_DPHY_MODE_PHY_CLK_EN |
> @@ -895,10 +938,13 @@ static int gc2145_start_streaming(struct gc2145 *gc2145,
>  		goto err_rpm_put;
>  	}
>  
> -	/* Perform MIPI specific configuration */
> -	ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
> +	/* Perform interface specific configuration */
> +	if (gc2145->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
> +		ret = gc2145_config_mipi_mode(gc2145, gc2145_format);
> +	else
> +		ret = gc2145_config_dvp_mode(gc2145, gc2145_format);
>  	if (ret) {
> -		dev_err(&client->dev, "%s failed to write mipi conf\n",
> +		dev_err(&client->dev, "%s failed to write interface conf\n",
>  			__func__);
>  		goto err_rpm_put;
>  	}
> @@ -924,6 +970,9 @@ static void gc2145_stop_streaming(struct gc2145 *gc2145)
>  			GC2145_CSI2_MODE_EN | GC2145_CSI2_MODE_MIPI_EN, 0,
>  			&ret);
>  	cci_write(gc2145->regmap, GC2145_REG_PAGE_SELECT, 0x00, &ret);
> +
> +	/* Disable dvp streaming */
> +	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x00, &ret);
>  	if (ret)
>  		dev_err(&client->dev, "%s failed to write regs\n", __func__);
>  
> @@ -1233,9 +1282,8 @@ static int gc2145_init_controls(struct gc2145 *gc2145)
>  static int gc2145_check_hwcfg(struct device *dev)
>  {
>  	struct fwnode_handle *endpoint;
> -	struct v4l2_fwnode_endpoint ep_cfg = {
> -		.bus_type = V4L2_MBUS_CSI2_DPHY
> -	};
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct gc2145 *gc2145 = to_gc2145(sd);
>  	int ret;
>  
>  	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> @@ -1244,36 +1292,57 @@ static int gc2145_check_hwcfg(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> -	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg);
> +

no new line here.

> +	gc2145->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
> +	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &gc2145->ep);
> +	if (ret) {
> +		gc2145->ep.bus_type = V4L2_MBUS_PARALLEL;
> +		ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &gc2145->ep);
> +	}
>  	fwnode_handle_put(endpoint);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "could not parse endpoint\n");
>  		return ret;
> -
> -	/* Check the number of MIPI CSI2 data lanes */
> -	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> -		dev_err(dev, "only 2 data lanes are currently supported\n");
> -		ret = -EINVAL;
> -		goto out;
>  	}
>  
> -	/* Check the link frequency set in device tree */
> -	if (!ep_cfg.nr_of_link_frequencies) {
> -		dev_err(dev, "link-frequency property not found in DT\n");
> +	switch (gc2145->ep.bus_type) {
> +	case V4L2_MBUS_CSI2_DPHY:
> +		/* Check the link frequency set in device tree */
> +		if (!gc2145->ep.nr_of_link_frequencies) {
> +			dev_err(dev, "link-frequencies property not found in DT\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}

any reason for change of the if order ? before num_data_lanes was
checked first, then nr_of_link_frequencies, then 3 link_frequencies.

> +
> +		/* Check the number of MIPI CSI2 data lanes */
> +		if (gc2145->ep.bus.mipi_csi2.num_data_lanes != 2) {
> +			dev_err(dev, "only 2 data lanes are currently supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (gc2145->ep.nr_of_link_frequencies != 3 ||
> +			gc2145->ep.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
> +			gc2145->ep.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
> +			gc2145->ep.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {

alignment

> +			dev_err(dev, "Invalid link-frequencies provided\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +

no newline here

> +	case V4L2_MBUS_PARALLEL:
> +		break;
> +	default:
> +		dev_err(dev, "unsupported bus type %u\n", gc2145->ep.bus_type);
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (ep_cfg.nr_of_link_frequencies != 3 ||
> -	    ep_cfg.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
> -	    ep_cfg.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
> -	    ep_cfg.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
> -		dev_err(dev, "Invalid link-frequencies provided\n");
> -		ret = -EINVAL;
> -	}
> +	return 0;
>  
>  out:
> -	v4l2_fwnode_endpoint_free(&ep_cfg);
> -
> +	v4l2_fwnode_endpoint_free(&gc2145->ep);
>  	return ret;
>  }
>  
> @@ -1421,6 +1490,7 @@ static void gc2145_remove(struct i2c_client *client)
>  	if (!pm_runtime_status_suspended(&client->dev))
>  		gc2145_power_off(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> +	v4l2_fwnode_endpoint_free(&gc2145->ep);
>  }
>  
>  static const struct of_device_id gc2145_dt_ids[] = {
> -- 
> 2.43.0
> 

Alain

