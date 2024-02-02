Return-Path: <linux-kernel+bounces-50406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E28847892
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1385028A2A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0014F16A;
	Fri,  2 Feb 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5XK9qvy"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFA14E9B1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899286; cv=none; b=RdCBcuRrK43sKbf3gIWObNFGd2Jsn3EkJJ/HL25i//70xIdcL3rtzpwRn5gwqS6ObZRSQqcGc8yRRvi+ZsFf/rxItuXMvpy6HfZXzNOYmQxqk+teiFAXp52HnvEFElynP3+Diw6DVl6FMVPbAr+pjP0Mv0TohJQYFCQgBi7dP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899286; c=relaxed/simple;
	bh=HnwgYANLMXSW1DzPAZPPhrW8OspT0pU7wCK0oKbbwlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQgfr9C+EVR/yFSpdflKxol/Cv2NwUXwkbtvixxSMDng79O6J7540XN6kNZk9/5UL/4LclLkBDsGysDR4DN3XE9pgEZCtlj9gsP+41DxT6X5TgFQ5UlLzis14x8da6DBVaSx79izzyM5DN8My32sJoyIp4I5sENwEbUwwCmp+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5XK9qvy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d751bc0c15so20868705ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706899284; x=1707504084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN5ILJgfYC5Krqk3IcaE4UZm9MGXLWaA34ihsM5Im/Q=;
        b=s5XK9qvynqyaxDGma7tlhIQGYcqr+UifRNhsXSLW5j5tg5rG7wv9096OJaj0G16XSY
         shsh6M/nEL5pRKBz7X5HSXNYdPyt5K0ZYtgnhM4c+FZQ8g0vtc+9YH0maWPit3xVzc9i
         bhq6TkAT7EstkG553LeB271fwdcQfaN2ml7wH2tDwoSLR6f9NBLw5YbTNI110f5dsOwD
         UXiLrSICgxUxe8dOAiuQ+CzBnX/RlPLDT684bVCWv9Jt+0GEs/DUvJvy3dsNKCMimc9u
         RHYOdcrmlDwLzqjYRJA2hJp4cJxhTqdZZtWpnezklx2ABfhCUSKlgWeJOiLLsVb+vN3J
         hFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899284; x=1707504084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN5ILJgfYC5Krqk3IcaE4UZm9MGXLWaA34ihsM5Im/Q=;
        b=t/vvVOhdr1zCIGX5QsmEg1d1povs9QsvLFWuP1IKKE1DfYvUqZTGusj+2b2AHmMoaL
         nkFjrACONHZ9DKNcyteU6Jb+4jhgNaZn2K2V3wGMfkAdnwsohEu0SO86XJ2dYpSh5iUa
         z9FP6k9LQ3mWPIVMFy29Cvpud/qO+sT4r3SaEtrXIHVP/qG3l9AJEPgRA4vIqJn0oZPc
         TerDk/oxjtzRUCRJj5UuMb5UdnR1tt63Wz+tsey1mHvY1vod6sT35b74rIbW4Oopz8vP
         dE4LVpBNISCmlS49LPtg0WPzkTNeHJGuQIS3FLIZg1PbTvjTFj8wqXPAL6+TOGCjbf2s
         EEoA==
X-Gm-Message-State: AOJu0Yx1Fqhk2ykB1y3V/wy5wfKxkaqU0zFiC5ir+2p3F9hj2FjwTHPi
	WGCB1NsiNiujS0KO8yHfzejwoVz5SNnEMANh4zHs0TrCKy21mQ9zJY4w0v/pz8cdg/eBcKoy4Kr
	i
X-Google-Smtp-Source: AGHT+IHI5+6GlfKqM/eae+kgC9KkWpCXw9/h0VW61qBwkA94b7R7Eqhzy6DQXTdDMRIc6K3dL9c31Q==
X-Received: by 2002:a17:902:f68a:b0:1d8:fb17:a1f2 with SMTP id l10-20020a170902f68a00b001d8fb17a1f2mr12586111plg.34.1706899283798;
        Fri, 02 Feb 2024 10:41:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVnzEB2v7TbbKqpsgt/c7PICyiD/6Uwyu7EeUzAU9R5HwoFu9fPYvE5IW2uIB8M0v0SEuFwksh87A25N1krBxkWlT9zzLQD7tiLE0ZE976/bkLAUbFdl/0tprp4Pt2UF1lR+H9syCgOmtkFUNw2iF4AHjeles10LJMnFQnAkbAa8xbpQ/Q1BTzOC/Bnx35JHOiNS+liqYwF2w3FLEHpUZbDK4j1RbQJeiSIVIS/QRZUFBnOz3Wv+GP4OcI1byvNM8y5R1Ck3BpP1uBs8ElGgi6bCjlWfuXMAoDdxzgKECoGJ/jv2mFd6JmoQHRuiwEyyFeo7NjhjGzjJOH+4tkUPhBS4tNgHODfZ2s7SDlRiyMtrTCFm/mj0ROAa19sKf1DOLtW/zuiCGrwXXBqhQneTNyY7W6fd7n9qW84P9T2vngmuXvkGFTep469o0zyWuwBPrMJI7dU+cJ25JTGKBc59q/ohjeqayAzp3n+t+Xci91MT0mCIDrVDX1GFOf9/z/w7cf+zecrUq+b8IkqBhoFg==
Received: from p14s ([2604:3d09:148c:c800:9462:f236:7267:e14e])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001d936a7bd46sm1902639plb.271.2024.02.02.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:41:22 -0800 (PST)
Date: Fri, 2 Feb 2024 11:41:19 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 9/9] remoteproc: stm32: Use devm_rproc_alloc() helper
Message-ID: <Zb03T2Ti2v70NUMu@p14s>
References: <20240123184632.725054-1-afd@ti.com>
 <20240123184632.725054-9-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123184632.725054-9-afd@ti.com>

On Tue, Jan 23, 2024 at 12:46:32PM -0600, Andrew Davis wrote:
> Use the device lifecycle managed allocation function. This helps prevent
> mistakes like freeing out of order in cleanup functions and forgetting to
> free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 4f469f0bcf8b2..fed0866de1819 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -843,7 +843,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
> +	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>  	if (!rproc)
>  		return -ENOMEM;
>  
> @@ -897,7 +897,6 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> -	rproc_free(rproc);
>  	return ret;
>  }
>  
> @@ -918,7 +917,6 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> -	rproc_free(rproc);
>  }

I have applied patches 1, 2, 8 and 9 of this set.  Bjorn handles the QCOM
peripherals and will take care of the remaining ones.

Thanks,
Mathieu

>  
>  static int stm32_rproc_suspend(struct device *dev)
> -- 
> 2.39.2
> 

