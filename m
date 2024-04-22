Return-Path: <linux-kernel+bounces-153962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4C8AD559
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B7F1F2206E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C23155399;
	Mon, 22 Apr 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdEEskgI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92676153BE4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815943; cv=none; b=HogDKgpQ5M5jyWNERaz4Kx8UrYkbriLZKNrqFeAFRzI9yP/1evAUgkg1lUZdXzvDC+iyHsRkmKedRK7yA6qWVKBD1ByNQ3TZSHbAFKSap3ij/xqAOJZWX4XF1fhf8E0DkNc121O0cqmotP7ZSOMJgLkj3yzjY4Kr2i0YcR7+I40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815943; c=relaxed/simple;
	bh=36Y3QA4aHZBhCSYkiMlcRNGpu4CUXVEuLgNp3TgzB3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9Crvitp5Q0PHhI+/Otz5UkD79aPVDEVvnSysFgLtTmEINBkoh6DDkujKVZkAjjhFf0lxYE3i66KKcuFVJOMW/stqt054phCpZnk8hoN1a2ogsLvlQLvO9FlUNKUB6Ab2TdQYVNANDTQ5VM154xC9EEq9InuiHstGKpSiHxKFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdEEskgI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51ae315bb20so3041665e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815940; x=1714420740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCaWoKLrALkIbA4A/YaIT+eUoN1vxXvgvkVTJTvpm9w=;
        b=SdEEskgISQNdFmLkvZ4lRBnvPPhwDxqHvtudEl4YzOqr4H7l/kha/Kf6NFYo02Ha2f
         iDSgp7oy4Kbwoaflfwnwo35equxcMuJKy1XaFBmmT92a+vbV7Vvo+yE6briNO6QPbW24
         JhDW44a1TC/gshsz5FE5pmlUUupnWZGyPhwf1/xgWola+bjfBRtuut0rCMn4tF3iF8fH
         ShOPT7SrMjpMF3EhPoorhhwu3UQfV2t85pHfiIEsRd5HezZYSorySWoM7A0wyihcrgSj
         P1SgP5IFPDESk45fTkLBb/gd6o7wmHq2X69D/uLYUHXrY4vgKmq9R19UCLsDGhkfvC0s
         4xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815940; x=1714420740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCaWoKLrALkIbA4A/YaIT+eUoN1vxXvgvkVTJTvpm9w=;
        b=NWexqgfTqAfrOWmjTBjJgPrGLFYkD/jK6bpBjJ7b8K9BnkUB7rAVKZabbltBkQuJss
         /TStbb4JXt5J/Q70YPncJA5zOT0ku/7RjQA4XWPu7/jUpzZo2wmNPPpguzHrzLSF8+b6
         xYiAJmnJaG/xHZNqUaYaLpG2daHdRvi2eueXIiRZF/O7K9Ug7CRXGXsugmNN3YHxjFb2
         n2R21J8xMUVeK4YErWilrw+9cPB7y2saBvNEhYUwauzcR9aIquNQptqYQPku8lnNGeij
         Zaj/vlthJX1TSvVnVkt/iKep1sx4XZGRe2ztPfC7fAoFaAii0FP4wZp7d/0En7e3KfD0
         Nxzw==
X-Forwarded-Encrypted: i=1; AJvYcCXl2w4cPn/bY0RZ67tk5ILM5uCt3Lp+OLkKJWakMeg1i6P3SlpPmqO7Cexw+smC6fjjGkf5EbwzM7fyBTOYOoKNOXJcnEncaOViH00q
X-Gm-Message-State: AOJu0Yx4ccwUCPCD736GRmR+3q4pjLuaAaejJr6i+4NydDOYDUFB4dOJ
	S+zrv/u1p69OTA1JnXJakKNUNPmbxkLqo4Tnx+XVSeXW2QOYNdn4NAnVi57N+mg=
X-Google-Smtp-Source: AGHT+IFUb73EfVZYDKKz5Mp4KXCiEORIldm2g3t08iybjPl3d+C9b5pMwoTT+328QacufrKQEVzKOg==
X-Received: by 2002:a05:6512:2016:b0:51b:180a:7b7c with SMTP id a22-20020a056512201600b0051b180a7b7cmr3000623lfb.3.1713815939653;
        Mon, 22 Apr 2024 12:58:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b005195b745303sm1812574lfk.116.2024.04.22.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:58:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:58:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] drm/bridge: simple-bridge: Add platform module
 alias
Message-ID: <rkmyhgdfyowtec3yfoyubtkb4v55qc5vn3kltc2mapml6qsbed@qdilwjw2hqgf>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-4-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-4-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:18:57AM +0800, Sui Jingfeng wrote:
> Otherwise when compiled as module, this driver will not be probed on
> non-DT environment. This is a fundamential step to make this driver
> truely OF-independent.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3b09bdd5ad4d..6be271d1394b 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -308,3 +308,4 @@ module_platform_driver(simple_bridge_driver);
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
>  MODULE_DESCRIPTION("Simple DRM bridge driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:simple-bridge");

I think it would be better to use MODULE_DEVICE_TABLE(platform,
simple_bridge_platform)id_table). Note, there is no such thing as
generic 'simple_bridge'. I'd expect platform device to have a
device-specific name which can be matched by the driver. This requires a
platform_device_id table.

> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

