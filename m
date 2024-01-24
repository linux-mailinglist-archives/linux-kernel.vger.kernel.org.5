Return-Path: <linux-kernel+bounces-36490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A513083A19C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E771F23622
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D110795;
	Wed, 24 Jan 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQUPI0Gy"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B05F9F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075784; cv=none; b=pgc5uM5EadHPkapGy2t+ih3h+QWa6mVXg+frz1rG+TSfn4E0tlCg81qxhr/6QmlT+d2OMiKJGLh+ZRiueivedx+AAeoqibRnCwL4VF170qCp6FuWtqKoLlmwfj1ij3ofuWfBKpd6cZSxlbXelh6jmE8vP/qEmtRjep3zIdSKe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075784; c=relaxed/simple;
	bh=3n6qbepBC/quy189WMpUt5s0sJ7FlfcHVamtdO7egM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIRqxsizWD53iyFtGtqVW6fDNzikhhbERWwNhNKpTbJrTw0vA8JQRj0MfYI8rzJ4nGokPZW9Uphju3vOI+Wi2xj1yC+Rfn8cGCO7bgABQPlPQ4DB3YzaVsVXuxgEcBxVNZ7YkNN2chyT3XziXeKL8fvnqzC3sBZxwUIjnSnlSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQUPI0Gy; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd562d17dcso4074503b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706075782; x=1706680582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7SahGLtspE/3Wi9Cd+JOw7KlfpX4OF2RIxiyIP7SV0=;
        b=CQUPI0Gyf7iMVcA10t0J6r04j6YDF4Q6PiMRKcRAEg+WVj6KxdR5iSjMSH9izVJw1I
         eWEctJIUL9aPKNRO8yJ0lyN7bSV/jDY1WG9r8EcyShbbGJe/c5xN79ViXN+JORHMajDY
         3lVFKRVel0lAAFxssdot+ARQPurXeBX6M9tre1yECT9ZrE3S4aN4izbkIobsxqrD+gB2
         PqqDggyVIjCgWAll2xtReuBmYA/XAr4VvzisMbLenDYR0AcUbxsn+W6KD51fBPCjDLml
         IzviHy1wIPcxQkBILW8Wy4+qLFo6TwfpiR4yy3p0elIznif5BQuoB2TOGUB6aIO6pp1h
         gYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706075782; x=1706680582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7SahGLtspE/3Wi9Cd+JOw7KlfpX4OF2RIxiyIP7SV0=;
        b=LReo4Ez8c58EMtqe4ag0sJdsl+84i92cZeuFMPfidWfiBHpAk3Tul52V1mPrcx9mzZ
         NtxCoEY1cZijdMKF3Xfo5/R7Lk62qbmu3Cc6rBUWGl50r/SGaHzfp1StEwneqk1xgpvH
         Y3ifQ0woZXFojChXXwz4G8onQf8+EfcbMv/29+qjroRlBmytBrj4PBIfVFXiKFd0DKID
         oPE5pBNQQ3FJYh5uicdt9ffUlAJnSOoQx3Lhi5VbGBKgqMIkjfpfB9sdfCyt2Fwub0li
         mizP3Mpi3hPr7Yjs8HpiYNBR3EzAuwXxkYk8MFXDR/AQnEuLH91XU5JgnMjjKlA0aHc+
         guCQ==
X-Gm-Message-State: AOJu0YygpVsXBT0GNoTpxTqR32YKpunnFTmEZDsA+Ur86NUw7PEXCMd4
	8Fbdf46Vc/XSFIlgkoSHVkUMmShZo4DvsPXNKP0TrQ1mlmi4af8AiNx4GknVhj0=
X-Google-Smtp-Source: AGHT+IGiCI/sj/mAtB23fTMLULvqgI87+dSZUJXZCXN7hV/stz02CWQa7d9iE2R5I1NHRIlUItj1Gw==
X-Received: by 2002:a05:6808:10c2:b0:3bd:a6ea:1c6c with SMTP id s2-20020a05680810c200b003bda6ea1c6cmr1180274ois.116.1706075782222;
        Tue, 23 Jan 2024 21:56:22 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm12721062pfb.214.2024.01.23.21.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:56:20 -0800 (PST)
Date: Wed, 24 Jan 2024 11:26:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] cpufreq: do not open-code of_phandle_args_equal()
Message-ID: <20240124055618.5xppexdpvwnv6zng@vireshk-i7>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
 <20240123141311.220505-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123141311.220505-3-krzysztof.kozlowski@linaro.org>

On 23-01-24, 15:13, Krzysztof Kozlowski wrote:
> Use newly added of_phandle_args_equal() helper to compare two
> of_phandle_args.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on previous of change.
> ---
>  include/linux/cpufreq.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..3cd06dafb04b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1149,8 +1149,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  		if (ret < 0)
>  			continue;
>  
> -		if (pargs->np == args.np && pargs->args_count == args.args_count &&
> -		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
> +		if (of_phandle_args_equal(pargs, &args))
>  			cpumask_set_cpu(cpu, cpumask);
>  
>  		of_node_put(args.np);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

