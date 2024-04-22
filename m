Return-Path: <linux-kernel+bounces-153982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C408AD5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FD61F214D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF11553A8;
	Mon, 22 Apr 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RML+IIew"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62919154C01
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816487; cv=none; b=o3mV59+8LXcOa4N8wC8Brq1DVkG3pFJoZehmS+SCexJSz/513BNPyRn021Ft8/+DM2KkJYJkmBSBhdXOv3NfQlWSBMHqTCXh96WSOatPoJ3951hxBMAef8zACGbCS+P5Tu6oqp8Fp+ACVxX4uDu8PB8OaPcLceRh4QEEoRKRg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816487; c=relaxed/simple;
	bh=ymGl05pd9SJFSpdQs1n/X3T5MlvZB+xMKpQGVBwxKkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt4hYgwdSsbZtgoBxnL4pYz690vGNnTPvb2+1f/ZLfvMKrYmQQ+iJS6psEIa7FvgCM2AI+Zig+5lWSJjiajDr4w/W+c1ork9eJiIVArOHsVr4M4sqLjRLksVAINmpm9xkkHSgft1IV5EXk5N7r6/S0pkWQ4ILXAG25DO/aLO5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RML+IIew; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51b09c3a111so2488514e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713816483; x=1714421283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVxew0E36HKPg7AKuhliQt/Kpg8mBmNBvlWMdBa5HCE=;
        b=RML+IIewQbseUfhC662Z0xvwswxXLqd1kV+aEKsii/Rcec0n6vk+gdlpS5YoofVUtn
         drZLaJdOw1rctbXROLUOlEeJrxtYyueXC0mQpJrV8akv9y9WtjRnyNqfKi1jMiNQdtlc
         lwlgtESVoUZRKUqVbaid4PvJSEvyAx8eKQHK6GTv+3CK8EidKY6i48xxdfYkcmwyT+LD
         3P8nwOnG2mDbaUj3UY0PeJ78qstrFFmHXjKPPCXRdhUx8t55RPX09+1hBgqZM0/gHfbJ
         6FQMhGAQ+4rfzlfmYMkNichVqPcfQQ+qPlMhZqTjG37/fR656HGwnjTDI+me91N7OPdY
         bnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816483; x=1714421283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVxew0E36HKPg7AKuhliQt/Kpg8mBmNBvlWMdBa5HCE=;
        b=gCcgQza8PVFm6s+++CzG+XnRyBSowLG7sj1RTFwQT28lPu24OoSBN3Mri484M3sTgH
         4ZFSH4zLoPcrmU97pY20p1WHzQm7pUTxVqNCtfdzfz6IZJwuhzN6SQ8/d9KeMShX3xwW
         rVXLlBvBhGVoEo7LXKe9R8hwklXRjldDSNKxKObj9TUbDpzI5cKDVht6NdxiBn8Myw4b
         hTCEFdn/HR6/t09tLpY0nQv4AOPVxa/YxtNTUT2rr0nKs7F3kchHNg7OJ65r5w9O0Qcy
         pqw/sW3L6AwCXHcISHYy4AusO8ZwlKZKXd/WZI/5Gml6+hCkiWPwyV/iM9gV/Hr69810
         N2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe2AomeO2RkvvcFgVi1+VyZOe9YqR7sJIr9Ztwppb6Yr0A8pA6DJ55lF1lVq9EngDU6jCjpg4HicKLsSgZCZOyMgtFCyu2m9/z4D2z
X-Gm-Message-State: AOJu0Yzww5PU0pvRP0qTj7eUf2xA6QoNDI9aERknglALL6DKDLes+/93
	pnnOK0c0FFSSmlhB9lqTUm21KvY0/7Uctt87sZSuRf3HVM7L1L+NXSikxEQD1Rs=
X-Google-Smtp-Source: AGHT+IFPGYLrnfC3K/xb3EGS4ldKQPJdw5ZGmVAcLa4hP1Zp5GAI5xifZBtuZ2/Dsg9KJmM0cwpD/g==
X-Received: by 2002:a19:7516:0:b0:51a:c21b:73fb with SMTP id y22-20020a197516000000b0051ac21b73fbmr6120268lfe.44.1713816483582;
        Mon, 22 Apr 2024 13:08:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b005188ea5d2b5sm1855484lfc.303.2024.04.22.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:08:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:08:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] drm/bridge: tfp410: Use fwnode API to acquire
 device properties
Message-ID: <gwpgunhe3frumjtxjapdw3nxlavrhseleddqqn6qpqeqg2ku56@ec6log4zl6ds>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-9-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-9-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:19:02AM +0800, Sui Jingfeng wrote:
> Make this driver DT-independent by calling the freshly created helpers,
> which reduce boilerplate and open the door for otherwise use cases. No
> functional changes for DT based systems.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/ti-tfp410.c | 41 +++++++++++++++---------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> index c7bef5c23927..58dc7492844f 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -266,8 +266,9 @@ static const struct drm_bridge_timings tfp410_default_timings = {
>  
>  static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>  {
> +	struct fwnode_handle *fwnode = dev_fwnode(dvi->dev);
>  	struct drm_bridge_timings *timings = &dvi->timings;
> -	struct device_node *ep;
> +	struct fwnode_handle *ep;
>  	u32 pclk_sample = 0;
>  	u32 bus_width = 24;
>  	u32 deskew = 0;
> @@ -288,14 +289,14 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>  	 * and EDGE pins. They are specified in DT through endpoint properties
>  	 * and vendor-specific properties.
>  	 */
> -	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
> +	ep = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
>  	if (!ep)
>  		return -EINVAL;
>  
>  	/* Get the sampling edge from the endpoint. */
> -	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
> -	of_property_read_u32(ep, "bus-width", &bus_width);
> -	of_node_put(ep);
> +	fwnode_property_read_u32(ep, "pclk-sample", &pclk_sample);
> +	fwnode_property_read_u32(ep, "bus-width", &bus_width);
> +	fwnode_handle_put(ep);
>  
>  	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
>  
> @@ -324,7 +325,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>  	}
>  
>  	/* Get the setup and hold time from vendor-specific properties. */
> -	of_property_read_u32(dvi->dev->of_node, "ti,deskew", &deskew);
> +	fwnode_property_read_u32(fwnode, "ti,deskew", &deskew);
>  	if (deskew > 7)
>  		return -EINVAL;
>  
> @@ -336,12 +337,12 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>  
>  static int tfp410_init(struct device *dev, bool i2c)
>  {
> -	struct device_node *node;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct tfp410 *dvi;
>  	int ret;
>  
> -	if (!dev->of_node) {
> -		dev_err(dev, "device-tree data is missing\n");
> +	if (!fwnode) {
> +		dev_err(dev, "firmware data is missing\n");
>  		return -ENXIO;
>  	}
>  
> @@ -352,8 +353,8 @@ static int tfp410_init(struct device *dev, bool i2c)
>  	dvi->dev = dev;
>  	dev_set_drvdata(dev, dvi);
>  
> +	drm_bridge_set_node(&dvi->bridge, fwnode);
>  	dvi->bridge.funcs = &tfp410_bridge_funcs;
> -	dvi->bridge.of_node = dev->of_node;
>  	dvi->bridge.timings = &dvi->timings;
>  	dvi->bridge.type = DRM_MODE_CONNECTOR_DVID;
>  
> @@ -362,15 +363,15 @@ static int tfp410_init(struct device *dev, bool i2c)
>  		return ret;
>  
>  	/* Get the next bridge, connected to port@1. */
> -	node = of_graph_get_remote_node(dev->of_node, 1, -1);
> -	if (!node)
> -		return -ENODEV;
> -
> -	dvi->next_bridge = of_drm_find_bridge(node);
> -	of_node_put(node);
> -
> -	if (!dvi->next_bridge)
> +	dvi->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
> +	if (IS_ERR(dvi->next_bridge)) {
> +		ret = PTR_ERR(dvi->next_bridge);
> +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
> +		return ret;

Same comment regarding dev_err_probe().

LGTM otherwise.

> +	} else if (!dvi->next_bridge) {
> +		dev_dbg(dev, "Next bridge not found, deferring probe\n");
>  		return -EPROBE_DEFER;

Looking at the bolerplate code, I think it would be better to make
drm_bridge_find_next_bridge_by_fwnode() reutrn -EPROBE_DEFER on its own.


> +	}
>  
>  	/* Get the powerdown GPIO. */
>  	dvi->powerdown = devm_gpiod_get_optional(dev, "powerdown",
> @@ -422,10 +423,10 @@ static struct platform_driver tfp410_platform_driver = {
>  /* There is currently no i2c functionality. */
>  static int tfp410_i2c_probe(struct i2c_client *client)
>  {
> +	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
>  	int reg;
>  
> -	if (!client->dev.of_node ||
> -	    of_property_read_u32(client->dev.of_node, "reg", &reg)) {
> +	if (!fwnode || fwnode_property_read_u32(fwnode, "reg", &reg)) {
>  		dev_err(&client->dev,
>  			"Can't get i2c reg property from device-tree\n");
>  		return -ENXIO;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

