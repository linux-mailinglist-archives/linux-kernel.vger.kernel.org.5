Return-Path: <linux-kernel+bounces-153978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721C8AD595
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E3F28147C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4029155399;
	Mon, 22 Apr 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr16WMNX"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FC153837
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816391; cv=none; b=STpJzG0HuyFkX/omDAyiawN01r8migIFg+4wzIm77fR0aVlSqNHxrE1LClbCKld7yL+NkkkkolLI6HrDmWZU23Ndf40/f5hBwncPVOmX8cjbDDeItYdNhSkX0y1FmAq/T8fZ7Q3+PFOcpXow+2MltMMpu8sMgagr1MaqZ/Ap4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816391; c=relaxed/simple;
	bh=SP5KZGIELHpwCMjC7ZHrdbZjZqPQKAEg2qTG93os1Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMkZ8nKFmI7NTbpMOTkB4o6mgCg+Rboo0L4dd8TEHBnjxv0JNy/H/coSOAGnY/OgYc39fUjoebsE1WSCM9BzZS7u/mPZYLg39w7H81yzF6/0Xm/+erJ07xdBc0RurE83LI2M5VrSStNLaasr2NXkUW3TZq7TwaA0Vkfd5KLJDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr16WMNX; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51abd580902so3153589e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713816387; x=1714421187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxag7ElmBq2J0SNGaZ2Jsj7zD9XRYmia0SkaU81ZBXo=;
        b=tr16WMNXHwXr3AFt2hRbwIsEFPnGiTtr8PjzNIA8nS55RtRirbzLKoa43KsX3QQ4So
         ZqFgc3EViW+JicBh6ND3m4epJualebVji9nMB9BUlSgW+euDqUECeETJQj1Or5+ujS6I
         ZCAfqw1g+U56NIII8FovZ8rWdwQ0CbC4QrSasvLUVcysT1+COtzckxaHKuYZxDwSjov5
         TY61+/pHfLwUYOTgQp+mRt/Rm6jEDUZ7+NQFbbyPsHEZ4wjiOKmi8rAN+8MVbWN4te+Q
         8rd6BIInjTk7JX5y9fQxcTVUorMq2zNw7JvdR7hCVHMB4CgJeenV3/LQ4b+wLl3Qqqgy
         Dnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816387; x=1714421187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxag7ElmBq2J0SNGaZ2Jsj7zD9XRYmia0SkaU81ZBXo=;
        b=a2bQn0c2qiGy2ka8I9cL6TZ8Uq5jIJ541i2Mhv+KTGNawAfF6H2jUg8hOwcvWeIKPI
         rcNk+uR2FIF06t7OK7huE5frlnS8EfpGHAb7+4yJpzg86NKWlbjfHagYkZUNztRHikFy
         8zcKA//RvDHRtxqdNDmnD6XS70DpmBRKgOnZ/JgrRWVJcwZeplJy8nvUXtqrMraaWOzN
         mRahwitmJBuLwpU1CxZ2CPsqtwhltGu1OWrC92B3O13+Otr8MI1Q8Ona4jeF7wqUvq/J
         0WN0p4f5lztbIsTqwb5w+dpAikHP4u5+KXCv5FJfPUC42uGWdNziEd9p80G6PLUlS5FV
         v2mg==
X-Forwarded-Encrypted: i=1; AJvYcCVU4KckXa7uqjUAT7wugs0rNNPYry3+kuXdNqRKNyP2kmwo6DkXBU6Kr5OrFf8T1CR7C99Crh3aahLCdhY54/mXH8mepJJ0x6kkSYID
X-Gm-Message-State: AOJu0YxRWcWbrUN6AT/tSfRUrmsDwrDB468wGAHtj4u9MJ5T8d6XtPU2
	FYJJjTCaXiirTuk8z33zYK8e3cje0Ox0PUcOQvh1dvg88r9KnzYrcK6RCFX7qow=
X-Google-Smtp-Source: AGHT+IFKRzJn5Y3fbci6M+062EmnXK4HLaS55hTHZT1r8HiXQ0ASlDALlzJt1N9v8o3vICMLlO6Cow==
X-Received: by 2002:a19:ca08:0:b0:519:2470:b1c5 with SMTP id a8-20020a19ca08000000b005192470b1c5mr204233lfg.10.1713816387326;
        Mon, 22 Apr 2024 13:06:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651239c800b00517746176ebsm1811680lfu.49.2024.04.22.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:06:26 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:06:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] drm-bridge: it66121: Use fwnode API to acquire
 device properties
Message-ID: <ugo62mcrvo5csp7umzvn3jhffh625agnjr3rtujnbgm7gxvgtr@re4q2xg46iqn>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-8-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-8-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:19:01AM +0800, Sui Jingfeng wrote:
> Make this driver DT-independent by calling the freshly created helpers,
> which reduce boilerplate and open the door for otherwise use cases. No
> functional changes for DT based systems.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 57 +++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 925e42f46cd8..688dc1830654 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -15,7 +15,6 @@
>  #include <linux/bitfield.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -#include <linux/of_graph.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
> @@ -1480,7 +1479,7 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> -	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
> +	if (!fwnode_property_present(dev_fwnode(dev), "#sound-dai-cells")) {
>  		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
>  		return 0;
>  	}
> @@ -1503,13 +1502,36 @@ static const char * const it66121_supplies[] = {
>  	"vcn33", "vcn18", "vrf12"
>  };
>  
> +static int it66121_read_bus_width(struct fwnode_handle *fwnode, u32 *bus_width)
> +{
> +	struct fwnode_handle *endpoint;
> +	u32 val;
> +	int ret;
> +
> +	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> +	if (!endpoint)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32(endpoint, "bus-width", &val);
> +	fwnode_handle_put(endpoint);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 12 && val != 24)
> +		return -EINVAL;
> +
> +	*bus_width = val;
> +
> +	return 0;
> +}

Ideally this should come as two patches. First patch extracts the
function, second patch changes the driver to use fwnode / property API.

> +
>  static int it66121_probe(struct i2c_client *client)
>  {
>  	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> -	struct device_node *ep;
>  	int ret;
>  	struct it66121_ctx *ctx;
>  	struct device *dev = &client->dev;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		dev_err(dev, "I2C check functionality failed.\n");
> @@ -1520,29 +1542,20 @@ static int it66121_probe(struct i2c_client *client)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
> -	if (!ep)
> -		return -EINVAL;
> -
>  	ctx->dev = dev;
>  	ctx->client = client;
>  	ctx->info = i2c_get_match_data(client);
>  
> -	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
> -	of_node_put(ep);
> -
> -	if (ctx->bus_width != 12 && ctx->bus_width != 24)
> -		return -EINVAL;
> -
> -	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
> -	if (!ep) {
> -		dev_err(ctx->dev, "The endpoint is unconnected\n");
> -		return -EINVAL;
> -	}
> +	ret = it66121_read_bus_width(fwnode, &ctx->bus_width);
> +	if (ret)
> +		return ret;
>  
> -	ctx->next_bridge = of_drm_find_bridge(ep);
> -	of_node_put(ep);
> -	if (!ctx->next_bridge) {
> +	ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
> +	if (IS_ERR(ctx->next_bridge)) {
> +		ret = PTR_ERR(ctx->next_bridge);
> +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
> +		return ret;

return dev_err_probe(dev, ret, "msg"), if your function doesn't do this.
If it does, just return ret.

> +	} else if (!ctx->next_bridge) {
>  		dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
>  		return -EPROBE_DEFER;
>  	}
> @@ -1577,8 +1590,8 @@ static int it66121_probe(struct i2c_client *client)
>  		return -ENODEV;
>  	}
>  
> +	drm_bridge_set_node(&ctx->bridge, fwnode);
>  	ctx->bridge.funcs = &it66121_bridge_funcs;
> -	ctx->bridge.of_node = dev->of_node;
>  	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>  	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
>  	if (client->irq > 0) {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

