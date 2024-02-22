Return-Path: <linux-kernel+bounces-75933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BD85F0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F1D285024
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185EDF41;
	Thu, 22 Feb 2024 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRSL7TEE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1D5244;
	Thu, 22 Feb 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579260; cv=none; b=duudSQe4RONhMw0k3TSLlDTE4SewZy2tIO8KfHq5ehXEq0mQAIj9vonIHuI6tO3DUWN2VE8fwZXyN5GtPLMoSfTXokj1+3vZMAX0YJbS51H471ze5lnC0YFaMT3KfUucyCiDYPXyYvN2egCxXoInq+PJc5bbWbOra2U+grf4URc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579260; c=relaxed/simple;
	bh=g+xx/zj+2br9BDde8+30/oiYrFuCk00e9lGzpVPAZUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n121toA0HpmDONFojge8T3TdlzbqHFzxxGPbFWGFRkuu64WMYWCpjHnXgi+MUfFpbbJLx0aPCN7jCUg38Lu1zggjiYP6FldBUYLCFU3xbmyknWSdxlvi3pvMMGc3EVIoxekvf7HIIciM7Yo8xX2PM9vzaTzpHkLXvRsyuejp3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRSL7TEE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512b13bf764so5200910e87.0;
        Wed, 21 Feb 2024 21:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708579257; x=1709184057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1IgVF5skWIyujttVkQJHEL92mFwiPJ1+coNrRfMm9Y=;
        b=ZRSL7TEE3xRc6X8nKSOfhaTI63k5YMYhGtSmVB9bI7hJz6c2ffaFIRHLqBZrWRVmyT
         9erpK1355Cx9tOwArEk9Qi9WMMfAz/ZsnevaOXfhlBs476C8lu+Nc7pnsU14VfVWZ/c2
         XG5lvOcM/A6YzOZGOkqFsRBNFHBlQwQvPFRfeMJSBbwBXbQkugRHwH6Ha/wOrp2Nf1GV
         bW4brRCghyX7bbNr3ocCcBVze0pt8WmT6Fm9YBPKaB6EXAFUJiqeCeoZismMlusDgBRR
         V3qMYThkh6esyu/bsPNUoaKfkKMoIV6/YZeUJIu2DP/RK+/h7OO3TS3ZX0Aq4dQF2pk2
         8VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708579257; x=1709184057;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1IgVF5skWIyujttVkQJHEL92mFwiPJ1+coNrRfMm9Y=;
        b=NRsICvhaOZUKkhN6/dALz6FSKZL962wrOrnve7HtkawroLWsTT00IJ1fAb8nLP8PRU
         e8xiVvzZZK6H7A1RwyGpVUrvitEowg0dIFjVtpxaLtKOoU8n9yjdIorSKu6ZPXrMyWfR
         n3QeKcIbWl3zeM8AIpc2EpbJ9aSMG5WEBv5Bur4ZSRu80Y/6pNy/7VksHtLYdLaJYfza
         PKdulVf7ZYKQgIDqyCRiYgNWyGAETduJiM2YgUAndKfu8xsjz6VY8ACLcyJ7D3252FpQ
         M3vywie7GdbgQ+MzM0znOkJlsYD7EItZXLeOi+/uheDIaybzkSuxVCmKZVQIjG8sbZ4H
         9kCA==
X-Forwarded-Encrypted: i=1; AJvYcCUt+ZmTaOwq4vsXzqNAl//Zl4loxX6T7dFO4WQ+iCOxKPlzbLdEb4uqKSsIySPfeunVOhjhfWY6H/96n1G67QbnIGZ8tPIZwjlZrlM5R/jwSVEtzTm6Rv2STPWkTgG3VhwZu2E2zANLR4wDrD3tVeNf1g50cNNBMZYc7AnZLqHtrZMTtA3Q
X-Gm-Message-State: AOJu0YyU8utPPLTE1h2FQ3e61taLTFli4a9DM5BgTWsbRmCEeAXTlTQx
	QdPl9hUSRTyE7RLREg33Ju8B7bdRFoyp7kxUxMPlGOeaUx8ornV3
X-Google-Smtp-Source: AGHT+IFrakLqyJ6PYef53Y/DlK3T4t27nkFtJ2Uc5xBeTTD99qHfWRNXXFtR1QRF2ujurL66ohwxIA==
X-Received: by 2002:a05:6512:5c4:b0:512:d721:f0f5 with SMTP id o4-20020a05651205c400b00512d721f0f5mr1789690lfo.60.1708579256369;
        Wed, 21 Feb 2024 21:20:56 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id y10-20020ac2420a000000b00512c56ecd7asm855134lfh.61.2024.02.21.21.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:20:41 -0800 (PST)
Date: Thu, 22 Feb 2024 08:20:32 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 2/2] media: gc2145: implement basic dvp bus support
Message-ID: <ZdbZoF_uUPga3uek@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-3-andrej.skvortzov@gmail.com>
 <ZdSFGaJ9qnayYI5C@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdSFGaJ9qnayYI5C@kekkonen.localdomain>

Hi Sakari,

On 24-02-20 10:55, Sakari Ailus wrote:
> Hi Andrey,
> 
> On Sun, Feb 18, 2024 at 01:03:08AM +0300, Andrey Skvortsov wrote:
> > Tested on PinePhone with libcamera-based GNOME screenshot.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  drivers/media/i2c/gc2145.c | 117 ++++++++++++++++++++++++++++---------
> >  1 file changed, 90 insertions(+), 27 deletions(-)
> > 
> >  
> > @@ -612,6 +623,11 @@ struct gc2145 {
> >  	const struct gc2145_mode *mode;
> >  };
> >  
> > +static inline bool gc2145_is_csi2(const struct gc2145 *gc2145)
> > +{
> > +	return gc2145->ep.bus_type == V4L2_MBUS_CSI2_DPHY;
> 
> This is used in a single place. Could you move this comparison there?
Yes, I'll do.

> 
> > +}
> > +

> >  	}
> > @@ -924,6 +975,9 @@ static void gc2145_stop_streaming(struct gc2145 *gc2145)
> >  			GC2145_CSI2_MODE_EN | GC2145_CSI2_MODE_MIPI_EN, 0,
> >  			&ret);
> >  	cci_write(gc2145->regmap, GC2145_REG_PAGE_SELECT, 0x00, &ret);
> > +
> > +	/* Disable dvp streaming */
> > +	cci_write(gc2145->regmap, GC2145_REG_PAD_IO, 0x00, &ret);
> >  	if (ret)
> >  		dev_err(&client->dev, "%s failed to write regs\n", __func__);
> >  
> > @@ -1233,9 +1287,8 @@ static int gc2145_init_controls(struct gc2145 *gc2145)
> >  static int gc2145_check_hwcfg(struct device *dev)
> >  {
> >  	struct fwnode_handle *endpoint;
> > -	struct v4l2_fwnode_endpoint ep_cfg = {
> > -		.bus_type = V4L2_MBUS_CSI2_DPHY
> > -	};
> 
> First try D-PHY and if that fails, then try PARALLEL.
> 
> > +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +	struct gc2145 *gc2145 = to_gc2145(sd);
> >  	int ret;
> >  
> >  	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> > @@ -1244,36 +1297,46 @@ static int gc2145_check_hwcfg(struct device *dev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg);
> > +	ret = v4l2_fwnode_endpoint_parse(endpoint, &gc2145->ep);
> 
> You won't have any link frequencies available with this change.
Thanks for catching this up. I'll fix that.

> 
> >  	fwnode_handle_put(endpoint);
> >  	if (ret)
> >  		return ret;
> >  
> > -	/* Check the number of MIPI CSI2 data lanes */
> > -	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> > -		dev_err(dev, "only 2 data lanes are currently supported\n");
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > +	switch (gc2145->ep.bus_type) {
> > +	case V4L2_MBUS_CSI2_DPHY:
> > +		/* Check the link frequency set in device tree */
> > +		if (!gc2145->ep.nr_of_link_frequencies) {
> > +			dev_err(dev, "link-frequencies property not found in DT\n");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		/* Check the number of MIPI CSI2 data lanes */
> > +		if (gc2145->ep.bus.mipi_csi2.num_data_lanes != 2) {
> > +			dev_err(dev, "only 2 data lanes are currently supported\n");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (gc2145->ep.nr_of_link_frequencies != 3 ||
> > +			gc2145->ep.link_frequencies[0] != GC2145_640_480_LINKFREQ ||
> > +			gc2145->ep.link_frequencies[1] != GC2145_1280_720_LINKFREQ ||
> > +			gc2145->ep.link_frequencies[2] != GC2145_1600_1200_LINKFREQ) {
> > +			dev_err(dev, "Invalid link-frequencies provided\n");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +		break;
> >  
> > -	/* Check the link frequency set in device tree */
> > -	if (!ep_cfg.nr_of_link_frequencies) {
> > -		dev_err(dev, "link-frequency property not found in DT\n");
> > +	case V4L2_MBUS_PARALLEL:
> > +		break;
> > +	default:
> > +		dev_err(dev, "unsupported bus type %u\n",
> > +			gc2145->ep.bus_type);
> 
> Fits on the previous line.
I'll change this in v2.


-- 
Best regards,
Andrey Skvortsov

