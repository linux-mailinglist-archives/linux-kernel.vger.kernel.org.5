Return-Path: <linux-kernel+bounces-161139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6F8B4785
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8961C20D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159273D55D;
	Sat, 27 Apr 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pt7R7So4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6E28F4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245447; cv=none; b=aR513YFk5Tsk7zpMxYHWASukYNr8nbVvrvdI078uGdH96bWALfZ+X7OfSLmG283OteMxubazzrdWEhRp8U56SejBK6JK9qBlTZDFHTcF2l/AHgXkhXZ7Ay1ISvo6pntf8U95p4gHpOl9lREQvgB+JBECARUaArh6B5PZwmUpTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245447; c=relaxed/simple;
	bh=BJ/U+v98aqesD4chb0v6lrPdRUKWgL4Xj//RQ17Wqwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1sQOkhReEASvSLjq742rm620WbrAV6fFW74hw1VCvDXm2Q6f3HHsRBc1dv3S7vcPOBCZ4ALpB8pXY5/sjTsVV5vh6wt/TBRumNoVgd/6dzsgEA7W6jTEpxxuVelfBahYctxhc4sSuh848ivHboP+YCr4KAemQc48zU535DXNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pt7R7So4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ca95db667so2398001e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714245443; x=1714850243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z4JVoTMGiLzVampw4rx9c82f2mlZ2d+hOB5M1MhVt0=;
        b=pt7R7So46vsSN/30J1Vr8j/68eWm0QMvU84r9Kv+Tv73B5VNanN4XU5K1Tjtd2b3S/
         2+QGR6eMEOSd8oIusvELUcTwI0IFKpTqS+Pj7Yxi3G3XEkyvVERz+75mqOBfj9EBX5Oq
         JstvO6MMgkj2+XsrawuU8a5E1nSW9l8y0KRrr9lY7FBc7VyZuZCWUAK/JftPVinhty0r
         h71GbD2Gmv97KdkaDF231oCNelXqtdykiW5wxR0+sxWcMOABxzGZr4wt+VOP0nxyEPnz
         3v9aZM36d/L7BS0QHzDv0kOxx1zf4fML+OpoavURiEeyRpTIWQS+AX15I3AqYMpVgoZk
         Uneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714245443; x=1714850243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z4JVoTMGiLzVampw4rx9c82f2mlZ2d+hOB5M1MhVt0=;
        b=OR1u8shgH5/FdmLiBefg4U3ewk/eN7IFFGDSSkv4daOYGFSlODA1DNAkwZ+wgq+FBV
         fZUvExLo10YmF5JL6wmxCYmWs97M42biPkaOINiWPHdVjFUjIna6SIUKaxBUJQUjc5RG
         YV7hx484g2Ry6/x0MXV87TUkSkYglWS1Gf4Yjb/kw86XDWoO6EUAlsEszMGRF71pvHBI
         oO9R9P7KP1crT1s1FrJ8CrqZqfr4N4auxcPFTVF7xetOB5FkVlIXhwS7jwyEUgzuIUgK
         ChI32npjkjgu8qHUb/iomTymuCXyESA5dCkPUJfHR2Lk0rrSDTCRaOZp1B2y0haSIMFf
         wHOA==
X-Forwarded-Encrypted: i=1; AJvYcCXOoObx6+QZLqbH7q/IJP37bOkWUIdxAVXHT1rQUm6pu52Se+OHB4Utlg2DWB2HH/IlpWC44FyyfdV4+1KdBQ4YSfXB+IC+IE1bvkl+
X-Gm-Message-State: AOJu0YxouCGr8C1bfSNf6Jo06gb2FipLZdOWxYIB165O6jck+zQuiA8v
	1urAmyMwhVfEg40q+Ubj1fQ3X9QLXahfam02HXFClxUNvbCpWvLPhcPlfnf1lkY=
X-Google-Smtp-Source: AGHT+IEEy/dEs5oqn+r0GYD3ASZc92DTK/82biHH4kuJKEa0hsRRUtUYMXPPOsoiEKYcxafB7990Vg==
X-Received: by 2002:a05:6512:1592:b0:51d:5ffd:efe4 with SMTP id bp18-20020a056512159200b0051d5ffdefe4mr464125lfb.1.1714245442999;
        Sat, 27 Apr 2024 12:17:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id w18-20020ac254b2000000b0051723af85casm120303lfk.238.2024.04.27.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:17:22 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:17:20 +0300
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
Message-ID: <a2c4a2bwkesbp72bqoc6p2kdzhxaeb4hdohxae5othyvb6didw@asguw3ywktt6>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-9-sui.jingfeng@linux.dev>
 <gwpgunhe3frumjtxjapdw3nxlavrhseleddqqn6qpqeqg2ku56@ec6log4zl6ds>
 <da04552a-9466-4df9-8754-399b47dcbd5c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da04552a-9466-4df9-8754-399b47dcbd5c@linux.dev>

On Sun, Apr 28, 2024 at 02:43:20AM +0800, Sui Jingfeng wrote:
> Hi,
> 
> 
> On 2024/4/23 04:08, Dmitry Baryshkov wrote:
> > On Tue, Apr 23, 2024 at 03:19:02AM +0800, Sui Jingfeng wrote:
> > > Make this driver DT-independent by calling the freshly created helpers,
> > > which reduce boilerplate and open the door for otherwise use cases. No
> > > functional changes for DT based systems.
> > > 
> > > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> > > ---
> > >   drivers/gpu/drm/bridge/ti-tfp410.c | 41 +++++++++++++++---------------
> > >   1 file changed, 21 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> > > index c7bef5c23927..58dc7492844f 100644
> > > --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> > > +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> > > @@ -266,8 +266,9 @@ static const struct drm_bridge_timings tfp410_default_timings = {
> > >   static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
> > >   {
> > > +	struct fwnode_handle *fwnode = dev_fwnode(dvi->dev);
> > >   	struct drm_bridge_timings *timings = &dvi->timings;
> > > -	struct device_node *ep;
> > > +	struct fwnode_handle *ep;
> > >   	u32 pclk_sample = 0;
> > >   	u32 bus_width = 24;
> > >   	u32 deskew = 0;
> > > @@ -288,14 +289,14 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
> > >   	 * and EDGE pins. They are specified in DT through endpoint properties
> > >   	 * and vendor-specific properties.
> > >   	 */
> > > -	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
> > > +	ep = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> > >   	if (!ep)
> > >   		return -EINVAL;
> > >   	/* Get the sampling edge from the endpoint. */
> > > -	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
> > > -	of_property_read_u32(ep, "bus-width", &bus_width);
> > > -	of_node_put(ep);
> > > +	fwnode_property_read_u32(ep, "pclk-sample", &pclk_sample);
> > > +	fwnode_property_read_u32(ep, "bus-width", &bus_width);
> > > +	fwnode_handle_put(ep);
> > >   	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
> > > @@ -324,7 +325,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
> > >   	}
> > >   	/* Get the setup and hold time from vendor-specific properties. */
> > > -	of_property_read_u32(dvi->dev->of_node, "ti,deskew", &deskew);
> > > +	fwnode_property_read_u32(fwnode, "ti,deskew", &deskew);
> > >   	if (deskew > 7)
> > >   		return -EINVAL;
> > > @@ -336,12 +337,12 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
> > >   static int tfp410_init(struct device *dev, bool i2c)
> > >   {
> > > -	struct device_node *node;
> > > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > >   	struct tfp410 *dvi;
> > >   	int ret;
> > > -	if (!dev->of_node) {
> > > -		dev_err(dev, "device-tree data is missing\n");
> > > +	if (!fwnode) {
> > > +		dev_err(dev, "firmware data is missing\n");
> > >   		return -ENXIO;
> > >   	}
> > > @@ -352,8 +353,8 @@ static int tfp410_init(struct device *dev, bool i2c)
> > >   	dvi->dev = dev;
> > >   	dev_set_drvdata(dev, dvi);
> > > +	drm_bridge_set_node(&dvi->bridge, fwnode);
> > >   	dvi->bridge.funcs = &tfp410_bridge_funcs;
> > > -	dvi->bridge.of_node = dev->of_node;
> > >   	dvi->bridge.timings = &dvi->timings;
> > >   	dvi->bridge.type = DRM_MODE_CONNECTOR_DVID;
> > > @@ -362,15 +363,15 @@ static int tfp410_init(struct device *dev, bool i2c)
> > >   		return ret;
> > >   	/* Get the next bridge, connected to port@1. */
> > > -	node = of_graph_get_remote_node(dev->of_node, 1, -1);
> > > -	if (!node)
> > > -		return -ENODEV;
> > > -
> > > -	dvi->next_bridge = of_drm_find_bridge(node);
> > > -	of_node_put(node);
> > > -
> > > -	if (!dvi->next_bridge)
> > > +	dvi->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
> > > +	if (IS_ERR(dvi->next_bridge)) {
> > > +		ret = PTR_ERR(dvi->next_bridge);
> > > +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
> > > +		return ret;
> > Same comment regarding dev_err_probe().
> > 
> > LGTM otherwise.
> 
> 
> My drm_bridge_find_next_bridge_by_fwnode() function won't return -EPROBE_DEFER,
> this is known for sure. this can be used as a prior(priori) knowledge. This is
> intentionally by design.
> 
> 
> Calling the dev_err_probe() just introduce extra overhead on non EPROBE_DEFER
> cases. Hence, It is useless to use dev_err_probe() at here.
> 
> 
> > > +	} else if (!dvi->next_bridge) {
> > > +		dev_dbg(dev, "Next bridge not found, deferring probe\n");
> > >   		return -EPROBE_DEFER;
> > Looking at the bolerplate code, I think it would be better to make
> > drm_bridge_find_next_bridge_by_fwnode() reutrn -EPROBE_DEFER on its own.
> > 
> The drm_bridge_find_next_bridge_by_fwnode() function itself can not
> reliable detect if the driver(the remote bridge) already probed or not.
> 
> Hence, as a core helper function, we can not guarantee that return
> -EPROBE_DEFER is always correct.
> 
> While, return NULL is always correct. The NULL can stand for two meanings.
> One is that the next bridge is really don't exist, may happen when the
> caller provided a wrong fwnode argument.

Please take a look at drm_of_find_panel_or_bridge(). Returning specific
error code is always better than returning just NULL. As you have
pointed yourself, there are (at least) two cases when your function
returns NULL. Caller can not identify them unless the function returns
proper error code.

> Another case is that the next bridge exists but not probed yet, and
> drm_bridge_find_next_bridge_by_fwnode() can return NULL when it gets called
> too early.
> 
> Therefore, it is better to left to the users of this function to process
> the NULL return value. As driver instances has some extra prior knowledge.
> And can be controlled by drm bridge driver author.

he driver has no prior knowledge if there is a remote fwnode/ofnode or
if there is none.

> 
> > > +	}
> > >   	/* Get the powerdown GPIO. */
> > >   	dvi->powerdown = devm_gpiod_get_optional(dev, "powerdown",
> > > @@ -422,10 +423,10 @@ static struct platform_driver tfp410_platform_driver = {
> > >   /* There is currently no i2c functionality. */
> > >   static int tfp410_i2c_probe(struct i2c_client *client)
> > >   {
> > > +	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
> > >   	int reg;
> > > -	if (!client->dev.of_node ||
> > > -	    of_property_read_u32(client->dev.of_node, "reg", &reg)) {
> > > +	if (!fwnode || fwnode_property_read_u32(fwnode, "reg", &reg)) {
> > >   		dev_err(&client->dev,
> > >   			"Can't get i2c reg property from device-tree\n");
> > >   		return -ENXIO;
> > > -- 
> > > 2.34.1
> > > 
> -- 
> Best regards,
> Sui
> 

-- 
With best wishes
Dmitry

