Return-Path: <linux-kernel+bounces-153953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0278AD546
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F6D2820EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB341553BB;
	Mon, 22 Apr 2024 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zd9rBI9F"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152B15535A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815507; cv=none; b=mUw5p+LEfUuOWu1LKZumt7OcBUcoZN/DqLKwKinkQrdNQqyDutOqFcsJvfjiTOe1NPw36SZeMH/caKniwYFl6HuTtwnWiBkvxLtBdAXlNFYj5elmxAJfY2UHA3HjFp+ItHx575IyUGos/5peNvHRXCc1vlexB8Xf+0OWCBetjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815507; c=relaxed/simple;
	bh=mSEfp8z6eofbu2/o66Cv2ZH7gIEi/qWNZLXM7oA1hYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5tPSB8HIDn55HHEs9UwNqUjU7mvlHptNtCcHEHA+78XBhjKF9jY7YE21DsLz7LxEkjZ8Kxgnzg5gbCcJ85Buc9QwG5xCj+yyQAFF1TVr50nbdRCWw22XGePmYfJ6rF5420e10+RQn61TUQBzkPG8QR5pvNGcVZuB7qwSBhTLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zd9rBI9F; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so68546881fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815504; x=1714420304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geu7O3+m3HJ/3o9N5bHvMzVI9k+cw0GEArJbMvVCgjk=;
        b=zd9rBI9FlIK4x5TWg2nVD5GdPP3T9ZdGGjWgccRAw9S+ye2NMccfuLMZbAoxkUqTLh
         cypXFVGhHN3q2YIbOAxHWj3CdEEsLovPS1A/hhZnlCuWO23lulrViv8CWvmSbSfGLYPf
         Hw7PpwG/zTPn9PL3Q/MVDcpU2EpBPJNNntqmYrp2NO01tqWNxDw4F0X6XS8IgxX7BMQS
         VFQpIspYLU5unMcMBRCy/w4qwdzq7y9wmDsVyGrRqWtrPbNAtohHwd7n4cxrHejLL/xt
         RPE/rd4qpxHXMVWiP63a6appKL2hLauAZiOrFtkfbdZlwKxVloBciJxLJ+LMz2jzgZtC
         UC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815504; x=1714420304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geu7O3+m3HJ/3o9N5bHvMzVI9k+cw0GEArJbMvVCgjk=;
        b=AHInhpODMAXewRpr3YNGzdVvGlmR4A7zHADP0ipCpT5cU2p8nXPEgz3oKybxGcP54N
         d/YITUaeyA9W46Ygd8MUGHKncQac+i4oAmN8+tg7otqb6jExZ9TsiWYD8iUoGDz/6IXs
         qZH7ng14DYs3MYFlL60K/S7XXEviQ/JMOLO6S4+KL1ZzSPbN75llDmcse5aLiXz+mJNv
         3i2POVGCI5EJCpIT1rJKBWCgFYGLp6JJsLKzYekZn4Jhm8+cBqGNMAVcFkeXtq0vZXW1
         scgjTg21oQE8FeVwumx1cpGP41ehDPucFVjVG5Lk0oQP/iYnFC1GwXLRHARMae/ZSauN
         ni6A==
X-Forwarded-Encrypted: i=1; AJvYcCWE09DGRnCqq7mfDulJoWR7vWKUKPLoTuT2E9BHnj4i5+KPV/cPSvBxIalwFuRU1aG68ZupC3FJljxMPWC0BDJ96rStaxNut1wEexgt
X-Gm-Message-State: AOJu0YxDdX/KsBr2vLYnSG8tv5F8pjBycbyZQdByWfM9u1HGECN6/Jt/
	ud5N2lDX+gGhw8372GqUrg+tGGJK8/sfSRnPFg1gxiU/j/lrtgbp1y5oNOfgmB0=
X-Google-Smtp-Source: AGHT+IFBToLOpSsjPI8pjqEB5XqsvUzOWG8mujF7Bwog8+VxvvQHLSw7DikZG1Z+rLu3IV4Obwe7Jw==
X-Received: by 2002:a2e:9ccb:0:b0:2d6:d351:78ae with SMTP id g11-20020a2e9ccb000000b002d6d35178aemr7467468ljj.29.1713815503853;
        Mon, 22 Apr 2024 12:51:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id t3-20020a2e9c43000000b002dcb831d958sm1317363ljj.56.2024.04.22.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:51:43 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:51:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] drm/bridge: Allow using fwnode API to get the
 next bridge
Message-ID: <xsfrnucued63q2amv7betkvgks6bhssubhjcryghkcloytixj4@ukmak4xwyjtg>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-2-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-2-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:18:55AM +0800, Sui Jingfeng wrote:
> Currently, the various display bridge drivers rely on OF infrastructures
> to works very well, yet there are platforms and/or devices absence of 'OF'
> support. Such as virtual display drivers, USB display apapters and ACPI
> based systems etc.
> 
> Add fwnode based helpers to fill the niche, this allows part of the display
> bridge drivers to work across systems. As the fwnode API has wider coverage
> than DT counterpart and the fwnode graphs are compatible with the OF graph,
> so the provided helpers can be used on all systems in theory. Assumed that
> the system has valid fwnode graphs established before drm bridge drivers
> are probed, and there has fwnode assigned to involved drm bridge instance.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/drm_bridge.c | 74 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     | 16 ++++++++
>  2 files changed, 90 insertions(+)
> 

[skipped]

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4baca0d9107b..a3f5d12a308c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -26,6 +26,7 @@
>  #include <linux/ctype.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_encoder.h>
> @@ -721,6 +722,8 @@ struct drm_bridge {
>  	struct list_head chain_node;
>  	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
> +	/** @fwnode: fwnode pointer to the bridge */
> +	struct fwnode_handle *fwnode;

My comment is still the same: plese replace of_node with fwnode. It is
more intrusive, however it will lower the possible confusion if the
driver sets both of_node and fwnode. Also it will remove the necessity
for helpers like drm_bridge_set_node().

>  	/** @list: to keep track of all added bridges */
>  	struct list_head list;
>  	/**
> @@ -788,6 +791,13 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous,
>  		      enum drm_bridge_attach_flags flags);
>  
> +static inline void
> +drm_bridge_set_node(struct drm_bridge *bridge, struct fwnode_handle *fwnode)
> +{
> +	bridge->fwnode = fwnode;
> +	bridge->of_node = to_of_node(fwnode);
> +}
> +
>  #ifdef CONFIG_OF
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  #else
> @@ -797,6 +807,12 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  }
>  #endif
>  
> +struct drm_bridge *
> +drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
> +
> +struct drm_bridge *
> +drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port);
> +
>  /**
>   * drm_bridge_get_next_bridge() - Get the next bridge in the chain
>   * @bridge: bridge object
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

