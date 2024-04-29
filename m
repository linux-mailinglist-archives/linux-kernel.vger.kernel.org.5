Return-Path: <linux-kernel+bounces-161697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5588B4FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6CF1C212B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFB8F6A;
	Mon, 29 Apr 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZGPlgXD"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9E8479
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360912; cv=none; b=mhhXAesE+YdF8nrMH1vtj5KtEb9lYeN6EJ9cFnEycpP/iWezehZAJVMtMNGp00rrgmjJfwlWwUgX8SaFKlBkkrx7e596EkhNkCDqH6OC49FP+Rv8LNLhahq9al7wIdYt9UXqrbEPpVQ71WKiubcCNLSnaEItF02YrOivoFXKgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360912; c=relaxed/simple;
	bh=mzgFeMU8F+zgH9LxSpS30JFVQnrhwv+AnpzLTW+z/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxSMDT+syewCMgOr0Kpza9gvTWaLhXqG44HpV8/Bqjwt14qBxDeN5Ku9suExn7AwqsXXTGa/v/fPFnXcgtX55yfzbNpy45MDaS5JdiRU7vahELIU0tz6WwDnRSosZ0cAuWM9R73zX5lvbZ0D5iREPnpUud6VS16VMixwdULXvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZGPlgXD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso2728149a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714360910; x=1714965710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCot42VsvRRrZ8rZvywQc/mH+41vwIP+jklLONki5ME=;
        b=IZGPlgXDZ7vHLiX5V+CUtNCEysf1xBoB42F9IZEvBGrigNQhD4VX9hTsDwWZxqPN5s
         Bmx9WGhohN1JLF9U4XQhHB+6l722JTRWUOR671PpndvCDc2dQvo2a7EPX/H2NItOzWvK
         rfbtVvfaY3UcnLwjgK6XDrUztulfNw3lJM/BHb6J+m2rzPnSsSmMdeMYzRP9fiM2RymZ
         cNbwlg+rrakJU1BL5DWAmig1TPTbMevX3cW3oY9poZG/mdNNneZWMGNt9YWH0n5Ku31C
         VPSRIALTkSpLpO86Mi96B9TffeheHj2QGs/oxhi1IyfOFx2O4wNJRzKNk7Iyi4pXUpg3
         Pz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714360910; x=1714965710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCot42VsvRRrZ8rZvywQc/mH+41vwIP+jklLONki5ME=;
        b=MwPubEd4LLdfrhyVt6NsE6kK25C1BX0ChzAKr5sD3NalP0lGHtQLrlFX/JlTvQcPqz
         wQRscc8ZYGD2L0DVvsrKhjoPvQC3CgZopzhn4fzgANbej6KCTFUw59mBnn9pMrRjKxlk
         wSRJib4vGFhoI9AmS0fmk+qYKLHo8VWpJr3eqUNGs3fWJDWZ/cMREqq3epUoJyEwx0Q8
         PmZoEt1hieVRF4NOaKaV2eQRYdugTSnFEdek9jwIOLf4ts6WmUsqsU7xU5KGc2Xex/jR
         meru1L9e8RCPbGYXBr4QuVjQyq+4wWMJX/n3++FzJ11Ov89MxvDc3CMqhsJRBQq85fx6
         4Ehw==
X-Forwarded-Encrypted: i=1; AJvYcCVKD2yA7g5y+wGZJNFJXkDeqiitcKqm/bcmvbrzUcjZSMGLyhKVfjNPwnsS4GBI4On2QqRJ2OJPxDq+Y2Q5vaejcxBA0LdvBsuV4KjR
X-Gm-Message-State: AOJu0YwN68dClHoFb7u8ZFs3N1HNRz1Y2ean+nk1ubUf3K3ejz1g/QOj
	yW7V6ikpYDbBsN/OC79j4q3uEwOvAuzyySirDnfpsn4TuthGX9ebUzxPDT4DTdg=
X-Google-Smtp-Source: AGHT+IG94vLhyTf1NuBwZOKSnOTBXveVZi26Fog5LIXDfM3FHT6JxQCS+k7Xz82jlXOogqL2R+qcvQ==
X-Received: by 2002:a05:6a21:4995:b0:1a7:64dd:ebe8 with SMTP id ax21-20020a056a21499500b001a764ddebe8mr9462455pzc.49.1714360909789;
        Sun, 28 Apr 2024 20:21:49 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id kx17-20020a17090b229100b002b05e390c59sm4861563pjb.27.2024.04.28.20.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 20:21:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:51:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: cpufreq: Fix printing large cpu and cpufreq number
Message-ID: <20240429032146.2d3t7bai7k6cotqt@vireshk-i7>
References: <20240425110017.75238-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425110017.75238-1-joshua.yeong@starfivetech.com>

On 25-04-24, 19:00, Joshua Yeong wrote:
> Fix printing negative number when CPU frequency
> with large number.
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  drivers/cpufreq/freq_table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index c17dc51a5a02..9b9568023f3c 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -194,7 +194,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
>  	}
>  	if (optimal.driver_data > i) {
>  		if (suboptimal.driver_data > i) {
> -			WARN(1, "Invalid frequency table: %d\n", policy->cpu);
> +			WARN(1, "Invalid frequency table: %u\n", policy->cpu);
>  			return 0;
>  		}
> 
> @@ -254,7 +254,7 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
>  		if (show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
>  			continue;
> 
> -		count += sprintf(&buf[count], "%d ", pos->frequency);
> +		count += sprintf(&buf[count], "%u ", pos->frequency);
>  	}
>  	count += sprintf(&buf[count], "\n");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

