Return-Path: <linux-kernel+bounces-82713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FC868882
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1813B1C21D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324B52F7E;
	Tue, 27 Feb 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LH9oTEp0"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8229524BB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010764; cv=none; b=RGR6Mnce1fimq6x4BjaBlG/6HTjxb1r1bGcQTcESeMgRrntQihH4iikVc16168e90CVQ9owMNT2qdgMNIkxpETn1kduvEEAU7ZTkw/vEF+ufIydxIyXWK9AJ2VBVo/K+/y87c6udVH6JKAP8NyTEUgraJLkBlSOb7pJsHLQA0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010764; c=relaxed/simple;
	bh=hD+1erHDD0d+qn8eQRrLe1jV8E3tcFZSQN29WUyNEwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW2qb/bm+UOqm5fCj//lTGf9/FGcjaQAl2QAc93zDXtPaWq30isfH4/1GB/M0y4iNw0b9QrlOGrkxNT2t3fqazaua8P+pWg67Jg7Raml6qUFkn6O6mYEOUTD/4UsMWPK0HktzXPghz+N2ureapI3yq3chJaswYyAPqnOEhqGq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LH9oTEp0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e508725b64so700112b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709010762; x=1709615562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=om7VjZgz57k46padP27CCq6xGxWmJL9MnSyfraSemmA=;
        b=LH9oTEp0SnKvYZNT0Q8o9zWM5Hk3mSKwCmoqFhQIxQaAkL8BPSGZW05z+noByqGt5T
         z5Kzhx/aI4Bq6m4yFTX5IcAn9cP1iV+zxbKnTFAq8wevBTUqKsaioqLnqIyeVntuFhfo
         JS/a5jdEWFYNMZmqsWnR6/dvYbTs8wiMN6RbA4yubqt1ohFmwjfs+NmL2BP232K8y2Ws
         9HsEWY1tHXh28UYZFTWYVyewP8DUQcdYplYFVAm4bKUl6yf/8rIkZmOs+20rgJfSY/Db
         5PxgShAAL7z6oxNIqbwtiYLm+nATyLiXIahEqQTd59mCknDvXOx2eFq4jSY8/L2yG5Nc
         UZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010762; x=1709615562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=om7VjZgz57k46padP27CCq6xGxWmJL9MnSyfraSemmA=;
        b=gFuPa1zCYSSxj8gcn/hly5rT8VAKmlY7PfzP2oD0F8PRjfz5zo9Ekx4FrHS0Qr1JAb
         NXEXl+ZeAwCq1w3ops5u5I89+IFTNPCSrZpQSsAYnRjCBtTYoGkH1tvIZ/cmFSmyci0W
         oTuxzsy5ko1jR+bcsLe7eQvXZaKCZ/OmIn3l9IXFbarB7cMqFKzLT0zM+bV4tDmGLEiP
         k/Nks+GPI4EDY38BejuQs+/5ejMU9xHlIuGFga+j8cxyIpSflN9MZnMoaQAnRB8okUK2
         QpvqxqsK7QwbDCHcHV5ec9IaSVWlHcYMj5GhGUOzgvEx3wkbZgxdyu8NGI8nwyr+VScJ
         tKlg==
X-Forwarded-Encrypted: i=1; AJvYcCW6e2HdS2yYlJJYeIimHjpf5QVJgL+W6H+uq9otXeHUO5MoPSZsBiFUx/zkBsPeGYPMtM9fHb7Q5pzUEHOW9tSzpRjXPfZpa7Xj9lVt
X-Gm-Message-State: AOJu0Ywk/RkuK6WohB689Oa/skIaF563UHGddNw07MIEAD3WbByZuwX0
	AEKyXDa7nxu0pYsLgSVcHSqzlHR9r1cDFe1lVONwpo7SWYQ1HG+y7bir9xIyAw==
X-Google-Smtp-Source: AGHT+IF9E+Pe6ObLGEz1Rd/QEiuM5drfmC7FqhljGuWpXIu+Zcn2nXK7XarpiosRDl2ku9C55mgLEw==
X-Received: by 2002:aa7:868d:0:b0:6de:1b57:ca8c with SMTP id d13-20020aa7868d000000b006de1b57ca8cmr8804747pfo.23.1709010761738;
        Mon, 26 Feb 2024 21:12:41 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b006e4de94c112sm4951846pfn.66.2024.02.26.21.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 21:12:41 -0800 (PST)
Date: Tue, 27 Feb 2024 10:42:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Simplify the allocation of slab caches in
 mhi_ep_register_controller
Message-ID: <20240227051236.GA2587@thinkpad>
References: <20240221085937.167200-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221085937.167200-1-chentao@kylinos.cn>

On Wed, Feb 21, 2024 at 04:59:37PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 

There are multiple instances of kmem_cache_create() in this driver. Could you
change them also?

- Mani

> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/bus/mhi/ep/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 65fc1d738bec..7b61d384b2b6 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1493,9 +1493,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_destroy_ev_ring_el_cache;
>  	}
>  
> -	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
> -							sizeof(struct mhi_ep_ring_item), 0,
> -							0, NULL);
> +	mhi_cntrl->ring_item_cache = KMEM_CACHE(mhi_ep_ring_item, 0);
>  	if (!mhi_cntrl->ev_ring_el_cache) {
>  		ret = -ENOMEM;
>  		goto err_destroy_tre_buf_cache;
> -- 
> 2.39.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

