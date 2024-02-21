Return-Path: <linux-kernel+bounces-74202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F685D110
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E750C284753
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D063A8E3;
	Wed, 21 Feb 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLjog0TK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC023A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499773; cv=none; b=NUF5WVbgVjYD6YU+uoyEUGQVaj9kX+w7LrF4KhxaHEl6ZHW5rmUoLp1V14B0ybOajZWTFEZAFiqTy319pK5UBQH8ja8yCo31vlCoFflXA50KuFumVsRKxzMsl+wc1XtCvlbm5aNM3zTJEyFP+iPd2e2rhgBzo6dICFXoKNadS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499773; c=relaxed/simple;
	bh=wkLAEBQr8OqY63bSzLHVJZpa0DZYKA/19CYDFKRQsv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXDE/Kt47e79+iFbjprAYsA44y9osPSNAAvxLuYAaxJ30gok+bquo8qIzZyc85/chr615TytLsytXzJDAgTUHZKOIoGk3+1sgZrMwT6eQc0VVMgXZ35Jn/exhTaTHWbWQG5FCdkNvViYFii7gtjv1UvBHt2ZJCwxwXlpnwJXK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qLjog0TK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso25628795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499771; x=1709104571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVkY57PGrXF7HDeyEq0gu14Rt9F9yCgxKA8JQPS+gCQ=;
        b=qLjog0TK4W2ByJEu4T3+C7BAXqLgytEJYZBPP2bs2erkuaehPPIarAEgP+EY5gOSoS
         icIfBf9OvA4G++8RCKnhX3Q/zCj0KRFjni27DrSyRtuJRaXrez7EjZKZy5qJRmrm5jAx
         o91qjLBzrx7/A/jnNbQRoUhlA+1a3YO8bpid7tNRZzU0uEo1PaeNyDNoVlB6H5oKeOyv
         Y+67FOB+yxCrgl0jkTNbxFDFwI00cHPk2894RencpluP0I1xyASJZ7tdxa38zpqHxZ93
         sHZNPvFm60ZC0h1JZRY2iIh1OUxpa2+kOUGtL3XnoVSpTeMxeNhtwYgFMFx3EYNhsFYC
         i16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499771; x=1709104571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVkY57PGrXF7HDeyEq0gu14Rt9F9yCgxKA8JQPS+gCQ=;
        b=olLlHsktRzNSP5c24gqUaR/PiK4QI4OkqdmXYhysZdz31rohSnlu4MsrzoOLLKbsoo
         VF8VfX98cqW/4F6fdVujNNZ80nHcHwvvmKq/fmREm1oIvUhXKKpUEGIuJGYhiga8Ps9W
         aA566qzInAXs9RJoOLCh8AbaMYp/0e9DddQuiRUQU7EJTVK9J2ReEW9LTJiwK/2pGFwA
         XJDDT9e5aVMI6gfJI9O67zBxVbn5owQBqHshoEhfofO57SrgENYzn7RBeJKF7AR5PY/0
         vhtFSDkZ7TnOJOdY+xnkMbLQLcFIgLJVuAQq/FXralj9Z7eKPgZCywhcZuoVdPdBZl0S
         NedQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbADS8X9aj+WBOTGDV5TluUmQ97nTHqHYy2H6YMvsDYSwbjdSgabr7PChpGKYeWZ7j8w0tBNGHBZUcA14MhH0lwhScz/ULFMtzC7Yh
X-Gm-Message-State: AOJu0Yw5UdaW6JMezKJA5HDwMzoGbc4W7q25FKmIYZqVqM8FOnHMRC/3
	nWm5ELaOSdu+BjFvIL3PeNxmxAq29omlmE7QDPLDVlYlhn/M17jxGtYcLLgxvA==
X-Google-Smtp-Source: AGHT+IFJseXOB8SzQJOx52KJSNABZWO93XSLQ3J8TgYtz3c9BhFtZivo9ic5RjdmOMgrSHlSH6V6vQ==
X-Received: by 2002:a17:902:d4c3:b0:1dc:10a5:8be7 with SMTP id o3-20020a170902d4c300b001dc10a58be7mr6016047plg.50.1708499771002;
        Tue, 20 Feb 2024 23:16:11 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d9a91af8a4sm7379488plb.28.2024.02.20.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:16:10 -0800 (PST)
Date: Wed, 21 Feb 2024 12:46:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Elder <elder@linaro.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Erick Archer <erick.archer@gmx.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: check the correct variable in
 mhi_ep_register_controller()
Message-ID: <20240221071604.GH11693@thinkpad>
References: <bebcd822-d465-45da-adae-5435ec93e6d4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bebcd822-d465-45da-adae-5435ec93e6d4@moroto.mountain>

On Wed, Feb 21, 2024 at 09:20:19AM +0300, Dan Carpenter wrote:
> There is a copy and paste bug here so it checks "ev_ring_el_cache" instead
> of "ring_item_cache".
> 
> Fixes: 62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/ep/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 8d7a4102bdb7..f8f674adf1d4 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1497,7 +1497,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
>  							sizeof(struct mhi_ep_ring_item), 0,
>  							0, NULL);
> -	if (!mhi_cntrl->ev_ring_el_cache) {
> +	if (!mhi_cntrl->ring_item_cache) {
>  		ret = -ENOMEM;
>  		goto err_destroy_tre_buf_cache;
>  	}
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

