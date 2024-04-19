Return-Path: <linux-kernel+bounces-151623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759A8AB139
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538D428644E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA112FB29;
	Fri, 19 Apr 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRIAHecZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46812F394
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538949; cv=none; b=Jo7BRLiTB7s9eUAAjA/BihxGVRMcPEPA1tj4m4JjXu7kCh6TH4ayyE2quIPcc8fbvwVmlFu8T6OaF/vLnPtAi7osdJBZPQyaFLU5RW17TLvHPHCK55BAwk6sD6uwKGsNn1Xos+rVPhwUx9iyqvXRKk+mb8KLMr7LmsJL4DcQGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538949; c=relaxed/simple;
	bh=vs8I0n1fwkO45SFsUzTWz0UgIPjHU3Owfx+JLcvKa/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mogTKYmy0LxNezSys4P6PnSmhitsFUCLvKgQ0wtWtfp/jLbtI8JzO18SV/Vx5xJDA7/YTEITxMPmHHrGIwk2MqazLZgrDBmznKxCABDFS4XILfTtHWELeluVF+9VwNE2R5NbZ2ZcfeaxJCNyMZwlSR9Bi2WLBqFllZ3wb2/7fS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tRIAHecZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so1436686e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538945; x=1714143745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5l3DrKtVmRlu1zHtwVyAGR5CrXZw06HBbbhzszuOCs=;
        b=tRIAHecZDcDzhBSVIf3j1Q/gB7N9uYKoW7MX9PCgwy7GG3/rKTBFpaNvSiF+zGs2rB
         l3dI+Wog7rAejrMxSJTDUubk4zHeChYNLuerBRvdkFmcFRXy+GIETeYXWegEDS2Fs1L/
         +HqgjrKEokdTCRTX0gIFaN7SW2rEjG8pdy4uYGn1fAwIa+F63MuSMLSmbp1GZdSotzmE
         9XtLDglnKANWi45FXJV/7YK54NI5Vooz0m83eiA6tiPkvREZfmoFBhIjAfa8OYafbzn2
         9Ozr8Nn/kYAF3XRZpUqpj++FiPnpa8eVwH6L+2njHXYChPcvI6wEUTET7yyIB1KqxZnt
         DYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538945; x=1714143745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5l3DrKtVmRlu1zHtwVyAGR5CrXZw06HBbbhzszuOCs=;
        b=Ti6u6O+wmRe2gvgMF+uQR4Txat7vsiz3xYSqZKqHjoyHaoN9caqlDnUjGVz3mggzkb
         PkOkWeimWWgmEDAkd2N+RRWJsJfj3T7gkL0ThNOgEjMTK6ASHqxuHuR/KzmsZBlF3Kqq
         KxExNDxzh+Fjmu84JUCmkRdL0KLywJX5wQVoPXcUJEisT5Ll8S4WWcpBUp2og25qGMH/
         iGEKgLdcTlh1Wz5wHXcjbrQJBFz8Yh6bgZuFxtDmw90B06OWC3s8MdWWFHSY+c7HqAkw
         i9VFVNpPAXGTJMQoGUg5kLHuVG4OhK7tbxNKuMzI7VeRat4VCRPMQu0BKlBfZbgG3mdb
         lpQg==
X-Forwarded-Encrypted: i=1; AJvYcCVnaAyACopK4EMXG39YQRqjqoU96z5D8rATRWAt0zvbuxYdgikvroUTGrE5HvcfX7gt3j7Q7Pk+BeDxFBZZPGuDQFqJANI2NuA+ahBr
X-Gm-Message-State: AOJu0YynhDhFUVRgYNwnEdXVeNp4bUDej+Hwr8YJQt+JjOEAHZXWrmcf
	6SCrNLd5HQeVSNFhuGoZBeJWHkpRFD6AohG2TfaLJ63g67jAWFexv3ax9Jizudo=
X-Google-Smtp-Source: AGHT+IFZjrcp1mUuV6AiLWBqjl9YPyYjAFAcHbb4bUs3L2gqHQFdPg1/mX9b9o6ObWKJe26tsbZinQ==
X-Received: by 2002:a2e:3209:0:b0:2d8:2714:38e6 with SMTP id y9-20020a2e3209000000b002d8271438e6mr1865865ljy.25.1713538945291;
        Fri, 19 Apr 2024 08:02:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id y18-20020a05651c021200b002d9f3bed88dsm636898ljn.77.2024.04.19.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:02:24 -0700 (PDT)
Date: Fri, 19 Apr 2024 18:02:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Robert Foss <rfoss@kernel.org>, Swapnil Jakhade <sjakhade@cadence.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nikhil Devshatwar <nikhil.nd@ti.com>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Jani Nikula <jani.nikula@intel.com>, 
	Rob Herring <robh@kernel.org>, Zhu Wang <wangzhu9@huawei.com>, 
	Yuti Amonkar <yamonkar@cadence.com>, Jyri Sarha <jsarha@ti.com>, 
	Quentin Schulz <quentin.schulz@free-electrons.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on
 error path
Message-ID: <4ytkvuigcxhs437rp46sawpzs6ewhgcldgvsy5c5ohpajt76vh@jg45sjwtwlgx>
References: <20240419113637.25745-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419113637.25745-1-amishin@t-argos.ru>

On Fri, Apr 19, 2024 at 02:36:37PM +0300, Aleksandr Mishin wrote:
> In cdns_mhdp_atomic_enable(), there is an error return on failure of
> drm_mode_duplicate() which leads to the mutex remaining locked.
> Add a mutex unlock call.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 935a92a1c400 ("drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> This patch is against drm-misc-next branch of drm-misc repo.
> 
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

