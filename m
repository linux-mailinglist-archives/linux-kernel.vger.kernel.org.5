Return-Path: <linux-kernel+bounces-50307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A86847740
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27838B23301
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5C14D44A;
	Fri,  2 Feb 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIBkdGpa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701214D42C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898116; cv=none; b=qHYk773OFmrXDqkxjI8msF7Ppmhovm4uK8sUMVGfU8TEwfaF8r/zdWtKXVdis1RmxhESQth9EmeV6ow8Dj1mGwMw5Z8E5spd2+E6bDsXA7GICJj7TJ2WvtwnTLbtCDVpw1XzPJyoTi8B2kFE3jr1oHoWJLuXDiSyXmqmkFUP1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898116; c=relaxed/simple;
	bh=KauE0yNsqB8Dy0riawt2xZBThlcOFeau2LrxHcy+bPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itd9qKJyiBWxzHSlvs1/8jpEIyvGUNN0Jf/K2NO3+gfWWPzs3UMvkTnlHjuYBUYokv50DHtfp0B8R2pMPOl1tzvWIPVT083pZgDW7FAQDqG1HEtCHyCedZacgiWQefhl+MVsd/oBGpJwBN+Kg4Sq1CuS3iZGywmB2/2/p1/SPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JIBkdGpa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d958e0d73dso9230265ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898114; x=1707502914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=be5Y06uVEMH7YzxhUgHqiMLHz3FrNAcO1kc+RLOrw+A=;
        b=JIBkdGpaND6t3A4F7UZwLBhICO1HK6m7b98IqyjDz4zvSMhaIqD+ZYI0r5XBjGB+LW
         NInmI0Q+f4757kn9dYR16iBECusBszQ0WpXkLgqqG5nY3db+kC2/0BC4I80O5ADhFMNc
         LsXuAvtpgAhGAZVBc/FC6ObWiOwZVFxpbu4jJ/a8WmGsTkmpxgqCOKmTkMADk6olX2y0
         HdS505E5hSqHNmxDDlG1ys1pfyeZNggeRHuc4xzFlGEiC0GsJjHPO++nZFsTdZjoXm+L
         UTM0YrteOHGBYuMLdeFhsgIJ/6Y1kc6fZxvI5ldKTOJCOJCbDciGBuQ4nWWunUTFoMzI
         S+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898114; x=1707502914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be5Y06uVEMH7YzxhUgHqiMLHz3FrNAcO1kc+RLOrw+A=;
        b=lgmS3ckCJs3avEBsUeHHgKb/cQIT/RBtwJUY5kgD8xNuKVJPtYyjuw49Y06d8nHX48
         hYoLuQOArxp9jzVBQDGvwYYaPoRGY0wktymJHLfXGu/n9IfXcy9iLAcWmOkLUlXGjhqv
         6WlxLTplsYOzoHq06uBxlF4Utn/VSkcmZHwX1tJJzMWjMBZzUMB8oc7x6okt2gsI+FTR
         s1id6L0E4GOXSXdqDPaBlqkjyVHswSCjS3AKsmiEIW/f469GHSONXeXYswVhXeDs3zVF
         LiVJH3lYN1Y3W0sy6ziBJcfaxW2/YHDYRU0qH68/jZbCoX1qnC7rqRJwzAR3gSgr8Mml
         1fIQ==
X-Gm-Message-State: AOJu0YzpMPPRmk5v9VL6UaZnbCC//5H1je0RjmyFNogktmdFuhS/JIvE
	RRk9ay4c23L8iGOh8xsTsWBptqqH49xAiZN+DBwYGZHTt00WEwaDzRtArk+SBr4=
X-Google-Smtp-Source: AGHT+IELSShyHRflAZMAwGgqsjOq1hX5TbFT2GibhtIONp9QfTRTT0QY/xMDCFIwHxGvj6Hp/asKmg==
X-Received: by 2002:a17:902:e88a:b0:1d9:39b4:2039 with SMTP id w10-20020a170902e88a00b001d939b42039mr4335725plg.30.1706898113949;
        Fri, 02 Feb 2024 10:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWJ+6mK1Q4TV0Xetx3hJJ8enlGf+KnQ7a/24cfh1OdcYSw1N9rY9Wj04NcDz8fruiMMTz6b5G5F0kVx7Ev6mgzb0U9ZfYd1j22WntHZ+vizCrzLzs2JhOnqMMij5yNhLg7w5S5PWHtZCGYyqzncQ6kJ+IWchKaXMEb5MJpBZfIoPLrMI2cMlfuWhxxZnhrGOz/SBXIeg==
Received: from p14s ([2604:3d09:148c:c800:9462:f236:7267:e14e])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001d8aadaa7easm1924462pla.96.2024.02.02.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:21:53 -0800 (PST)
Date: Fri, 2 Feb 2024 11:21:51 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] remoteproc: k3-dsp: Use devm_ti_sci_get_by_phandle()
 helper
Message-ID: <Zb0yv9Zr8DQfAqXs@p14s>
References: <20240123184913.725435-1-afd@ti.com>
 <20240123184913.725435-4-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123184913.725435-4-afd@ti.com>

Hi Andrew,

On Tue, Jan 23, 2024 at 12:49:09PM -0600, Andrew Davis wrote:
> Use the device lifecycle managed TI-SCI get() function. This helps prevent
> mistakes like not put()'ing in the wrong order in cleanup functions and
> forgetting to put() on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 33 +++++++----------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index a13552c71f440..0240340a83e90 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -682,7 +682,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>  	const char *fw_name;
>  	bool p_state = false;
>  	int ret = 0;
> -	int ret1;
> 

This patch is giving me a compilation error because @ret1 is still used in
"release_tsp:".  The 3rd hunk in the next patch is showing the problem.  The
goto statement is removed in the 6th patch.

I have applied the first 3 patches of this set so no need to resend them with
the next revision.  And please add a cover letter next time.

Thanks,
Mathieu

>  	data = of_device_get_match_data(dev);
>  	if (!data)
> @@ -708,30 +707,24 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>  	kproc->dev = dev;
>  	kproc->data = data;
>  
> -	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
> +	kproc->ti_sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
>  	if (IS_ERR(kproc->ti_sci))
>  		return dev_err_probe(dev, PTR_ERR(kproc->ti_sci),
>  				     "failed to get ti-sci handle\n");
>  
>  	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "missing 'ti,sci-dev-id' property\n");
> -		goto put_sci;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing 'ti,sci-dev-id' property\n");
>  
>  	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
> -	if (IS_ERR(kproc->reset)) {
> -		ret = dev_err_probe(dev, PTR_ERR(kproc->reset),
> -				    "failed to get reset\n");
> -		goto put_sci;
> -	}
> +	if (IS_ERR(kproc->reset))
> +		return dev_err_probe(dev, PTR_ERR(kproc->reset),
> +				     "failed to get reset\n");
>  
>  	kproc->tsp = k3_dsp_rproc_of_get_tsp(dev, kproc->ti_sci);
> -	if (IS_ERR(kproc->tsp)) {
> -		ret = dev_err_probe(dev, PTR_ERR(kproc->tsp),
> -				    "failed to construct ti-sci proc control\n");
> -		goto put_sci;
> -	}
> +	if (IS_ERR(kproc->tsp))
> +		return dev_err_probe(dev, PTR_ERR(kproc->tsp),
> +				     "failed to construct ti-sci proc control\n");
>  
>  	ret = ti_sci_proc_request(kproc->tsp);
>  	if (ret < 0) {
> @@ -805,10 +798,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>  		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
>  free_tsp:
>  	kfree(kproc->tsp);
> -put_sci:
> -	ret1 = ti_sci_put_handle(kproc->ti_sci);
> -	if (ret1)
> -		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret1));
>  	return ret;
>  }
>  
> @@ -836,10 +825,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
>  
>  	kfree(kproc->tsp);
>  
> -	ret = ti_sci_put_handle(kproc->ti_sci);
> -	if (ret)
> -		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret));
> -
>  	k3_dsp_reserved_mem_exit(kproc);
>  }
>  
> -- 
> 2.39.2
> 

