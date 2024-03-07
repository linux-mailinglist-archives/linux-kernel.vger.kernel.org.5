Return-Path: <linux-kernel+bounces-96026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334F875640
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390E3281481
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D681332AA;
	Thu,  7 Mar 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRAndipX"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA11E4A2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837009; cv=none; b=OvcFvrPEb3tvVPsDXnrPR9BJDrEa1mOLUhH5XqAwF3u4U3OAbXiGxCIioA/eInq0WpNhFWLWkDqLSI1jQSj2Jl4UyYjVSWj6DfFpekKJNLd9aRxmjmIwVKs1MRZvNfo7RYh31e7eGZed31lE5VMJlk0sSZlQbiwJgAU2Jx5H5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837009; c=relaxed/simple;
	bh=8FUkih+eauSNhab/4lNBFm6jEWze9jImoE3fe9o4jOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3kXVLwB6Tcyj6xog0F7T4UIfebX0Y81nO/LiGIBTZZi7lqQYmRp3+qivd3QESFoojSFJHrdwIbZ994YFIvplFdkWa9ieNITPg8fCbEfIEBy2q4ElkK6KxtHs2P2ofanT6hRgWxl1T+BhK3BnWJAzg9m6yxAMPgU3Kp73DXOkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRAndipX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1330030276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709837007; x=1710441807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9LXUyShlkZ7roaprFymWdneF69b+LAWxfFA/794s5U=;
        b=KRAndipXfv981NzT0xftKAIQJeby9IIgoeZHcZ/wKZQpoB8mjZX6H5RQZZHrmg951g
         XNlKsPTqQ/n87/4Zqhm15oEwCS8mf8ZuTSfY+zi/ApRvsaZDXVd2d89QhFfy+685iBPn
         oOlo4zGy5ylcjDlVEvKPjJzJGIZRcOc/jOLSMwf5lgI3ieuur/1/Tnw7/mVb4rtZlQTv
         8ecWUqmRgEzgORxw09PH2kId97zqBAtc1dT1a/7S6gQDLJDB2DAZhs8ZoB5m7zIOTJXg
         OUqn1AttLYZmZMslCgcoigZh5tUuQHU6PSuU/uz7id92UuXlbRapXwQ5jolPdS7BPHNT
         A8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837007; x=1710441807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9LXUyShlkZ7roaprFymWdneF69b+LAWxfFA/794s5U=;
        b=u5pMHGgbVyVmiFZ0jXZaUU8yyrv10G4dpScgSJJg0XhpcCcCKp2aOSoHt92eQkKCZU
         rUjaiOnCNdd+zwSAWspaQ6uLRQa1pX9J1izxvRk67Rn6HRUSuJNFs1Uhg8gZntWRBBTb
         5FZHSUlFu+uyAx+vL3GB7vwIWHSZt7eoAm1gn4eOtws7uVyvA3S9IUIWpL7tTZuEruIT
         0GBk7v1NfxAgNiPIZ57A8S+HVp9+y7byKkRQl4RUlPsAaB5Jnyi3BamQlGQ8ZJcnKaFQ
         SJ9XksinXN/efjKyk9PuIyNnwBv4XLMaut97JpaujNVgG/bmEmT7n8LgR1Icp+rqGNYQ
         LteA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2yDrfWK5YTn5DMUmXGCsomkvyzE66nNa/XYPr0jTqKhR+/nP0zsCVKU/ybsLHvNA/HTMn39MepsAD64Bo900Rpq2dKQWxmEapU9q
X-Gm-Message-State: AOJu0Ywzi7bmQUsL6pXBqSeylbJ4FiSnhoEFbW8NBZPPmYIiDFtZq+O8
	0ncGUbSF4lUd3qyTy/whCV84iNSqSuiSXYUxU2FYgqiIIBxNkqyYom9TtXWzrjO51aEpRvDRz9x
	n7PVOUjAM4MzctUz0BUko7reYzV1Oi4QQkp6b4w==
X-Google-Smtp-Source: AGHT+IHla4pMRGQJ6X+PZKNW1ZUlATLZh7Z9JkCfgsqQjy7N83+BwMiNotl2Lwnw43Tw/TrfNMgzJdXHnO/QyjQ6JEY=
X-Received: by 2002:a05:6902:1347:b0:dcc:2bc:652 with SMTP id
 g7-20020a056902134700b00dcc02bc0652mr14839603ybu.60.1709837006977; Thu, 07
 Mar 2024 10:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev> <20240307172334.1753343-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240307172334.1753343-2-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 20:43:15 +0200
Message-ID: <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 19:23, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Currently, the various drm bridge drivers relay on OF infrastructures to
> works very well. Yet there are platforms and/or don not has OF support.
> Such as virtual display drivers, USB display apapters and ACPI based
> systems etc. Add fwnode based helpers to fill the niche, this may allows
> part of the drm display bridge drivers to work across systems. As the
> fwnode based API has wider coverage than DT, it can be used on all systems
> in theory. Assumed that the system has valid fwnode graphs established
> before drm bridge driver is probed, the fwnode graphs are compatible with
> the OF graph.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/drm_bridge.c | 68 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     | 16 +++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 521a71c61b16..1b2d3b89a61d 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1348,6 +1348,74 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  EXPORT_SYMBOL(of_drm_find_bridge);
>  #endif
>
> +/**
> + * drm_bridge_find_by_fwnode - Find the bridge corresponding to the associated fwnode
> + *
> + * @fwnode: fwnode for which to find the matching drm_bridge
> + *
> + * This function looks up a drm_bridge based on its associated fwnode.
> + *
> + * RETURNS:
> + * A reference to the drm_bridge if found, otherwise return NULL.
> + */

Please take a look at Documentation/doc-guide/kernel-doc.rst.

> +struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode)
> +{
> +       struct drm_bridge *ret = NULL;
> +       struct drm_bridge *bridge;
> +
> +       if (!fwnode)
> +               return NULL;
> +
> +       mutex_lock(&bridge_lock);
> +
> +       list_for_each_entry(bridge, &bridge_list, list) {
> +               if (bridge->fwnode == fwnode) {
> +                       ret = bridge;
> +                       break;
> +               }
> +       }
> +
> +       mutex_unlock(&bridge_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(drm_bridge_find_by_fwnode);

EXPORT_SYMBOL_GPL

> +
> +/**
> + * drm_bridge_find_next_bridge_by_fwnode - get the next bridge by fwnode
> + * @fwnode: fwnode pointer to the current bridge.
> + * @port: identifier of the port node of the next bridge is connected.
> + *
> + * This function find the next bridge at the current bridge node, assumed
> + * that there has valid fwnode graph established.
> + *
> + * RETURNS:
> + * A reference to the drm_bridge if found, %NULL if not found.
> + * Otherwise return a negative error code.
> + */
> +struct drm_bridge *
> +drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port)
> +{
> +       struct drm_bridge *bridge;
> +       struct fwnode_handle *ep;
> +       struct fwnode_handle *remote;
> +
> +       ep = fwnode_graph_get_endpoint_by_id(fwnode, port, 0, 0);
> +       if (!ep)
> +               return ERR_PTR(-EINVAL);
> +
> +       remote = fwnode_graph_get_remote_port_parent(ep);
> +       fwnode_handle_put(ep);
> +       if (!remote)
> +               return ERR_PTR(-ENODEV);
> +
> +       bridge = drm_bridge_find_by_fwnode(remote);
> +       fwnode_handle_put(remote);
> +
> +       return bridge;
> +}
> +EXPORT_SYMBOL(drm_bridge_find_next_bridge_by_fwnode);

EXPORT_SYMBOL_GPL

> +
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>  MODULE_DESCRIPTION("DRM bridge infrastructure");
>  MODULE_LICENSE("GPL and additional rights");
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3606e1a7f965..d4c95afdd662 100644
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
>         struct list_head chain_node;
>         /** @of_node: device node pointer to the bridge */
>         struct device_node *of_node;

In my opinion, if you are adding fwnode, we can drop of_node
completely. There is no need to keep both of them.

> +       /** @fwnode: fwnode pointer to the bridge */
> +       struct fwnode_handle *fwnode;
>         /** @list: to keep track of all added bridges */
>         struct list_head list;
>         /**
> @@ -788,6 +791,13 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>                       struct drm_bridge *previous,
>                       enum drm_bridge_attach_flags flags);
>
> +static inline void
> +drm_bridge_set_node(struct drm_bridge *bridge, struct fwnode_handle *fwnode)
> +{
> +       bridge->fwnode = fwnode;
> +       bridge->of_node = to_of_node(fwnode);
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

