Return-Path: <linux-kernel+bounces-97644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B07876D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329A91C2128C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6436604B1;
	Fri,  8 Mar 2024 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeOOR+Ni"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D22604B0;
	Fri,  8 Mar 2024 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936874; cv=none; b=AjdAXxZuus4cZTvEcUAjF0zLaABj7GiSLW9GGzmBj0vbrcNyfrC18IpTxHU9c2+eUPeSPIKjFY3t5umG3QpQMOtWkKgpGPo9hpAL1XERN3QNidb7V9YZ4NLB0+FY754JsjTvVng0/yFtcdLsDEhcEUtLVamnqXTRH1dlqcFmwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936874; c=relaxed/simple;
	bh=NPnRFZ5W/JRhURogsF+Y0uGFxMzLl4XSlbzwLW6Yauc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZC2LrwbszxkZVfLtmutwGA5m+JPWf+FeXxMkRTmwYtxeIJqjcOG6TDpORygWv4qsW8R6Qr+50r784xXrjviK/PW9xeu2lAELvFIH6aoaP4tZ9Tfg5lCvvbXodJpAgOFv+Yb1Gt+5hOarh1+DAtzEVFE1dS66dDNe+I2wwQPoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeOOR+Ni; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d26227d508so34370051fa.2;
        Fri, 08 Mar 2024 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709936870; x=1710541670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9Cm+sjEP7eeQzRpM/dyVnRkWK0R2O4wf+q730ac8Fc=;
        b=KeOOR+Ni8AFbh9uNKNSKl0CrXCdfAFKhoykA3tQNe1jyEcCQGO+JHJl4IHNvw1djYQ
         5g1fvVZZMroqX5DpIrW2dJIVOYBRLXe38LrHNEIgeLuyIA/warD0EF1dsaitYSKIXSss
         uFqN8C+1PGeLcisbInzSW4bqZuTzDARYZJ3G0sB6fodP35XIhOaqCWUElgXLUKoBWywC
         k5dtWQmKKovE68Fys6oJcgaqHpss8MfNTCnzQroLnAtz7Yra/A25DxyYHGHokY806pdq
         8yyPZC/7hGxhhduip2kSC9gYmkVzuzRKmmcoGokfaOvPepoUP8kqSmk0nhscxR5LTVF5
         P7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709936870; x=1710541670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Cm+sjEP7eeQzRpM/dyVnRkWK0R2O4wf+q730ac8Fc=;
        b=EoFBkXIcjpCN5tmtYBV+OgCB9BzB1lJZHYcbY4yHsU5KRYak4WRzz7nWCCzzHBNhk+
         awjAsN28kjJ3/urZb7nHP9sR6LfASQWNmY6vB5F0PdfZ7U0cAmDqw9s3KGNGfEISpbrZ
         +HXiUGcaPDMyAud/gUdxxbX4ItSM9LR849CTlKntK8UISzx+Ja6qmEt2NVrMB2KTjyIl
         khjvloUiBlVAMiVp1220J+cBbQs6KQRIEwV2Nd8kNssa5PDGnKM0AhQuNEH+Dt+yxApM
         I9qHnIAYWI46WFWany5qtsQ6XqIgSnJ9/wrIinS/U0Ghv/yZPBeQyruaOzYe5Dvd75RN
         NcUg==
X-Forwarded-Encrypted: i=1; AJvYcCUe30VbQOrVGRygIpONXjL2OBz7oDD8pyZbB9XGoKR1G9cw0rkEzNds1O5B6L7SUJWfCsgAHj7PQvbaxgkAxbM5hzdfx18Zlh4BTZa3hW7Mh8l1ZdIyOhS6auE1dpCgeHnX3H6U/BH+7ZERBgpHkfZCufa2odMocgqS8pOJNsEt3s+cbfhhtp+vv07zLNevnepGtEaKoLh9NVODPe7bb8DAiLw=
X-Gm-Message-State: AOJu0YwM0fTLFRqgoOz3BOBcYnbZLV34CKuJYlSshyb06Cv79TrArQuP
	c9PvT2V4PXEcRCZUW1KsvdX8f/wdByj2palW1ubKdzYiE41ZSKh/
X-Google-Smtp-Source: AGHT+IEefucnzeVaDrDXp7nL1ogp1q8ajUc4eKNA2EnYRvSPiplLYVDd8jWuXxI04LK1BlfLqEEo6A==
X-Received: by 2002:ac2:44c7:0:b0:513:202b:9001 with SMTP id d7-20020ac244c7000000b00513202b9001mr214641lfm.6.1709936869789;
        Fri, 08 Mar 2024 14:27:49 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0033e2b9f647asm437822wrr.31.2024.03.08.14.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:27:48 -0800 (PST)
Date: Fri, 8 Mar 2024 22:27:48 +0000
From: Stafford Horne <shorne@gmail.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: chenhuacai@kernel.org, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, ysato@users.sourceforge.jp,
	dalias@libc.org, glaubitz@physik.fu-berlin.de, robh+dt@kernel.org,
	frowand.list@gmail.com, linux-openrisc@vger.kernel.org,
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH 2/3] openrisc: Call setup_memory() earlier in the init
 sequence
Message-ID: <ZeuQ5EFFCw3O8qkS@antec>
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
 <1707524971-146908-3-git-send-email-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707524971-146908-3-git-send-email-quic_obabatun@quicinc.com>

On Fri, Feb 09, 2024 at 04:29:30PM -0800, Oreoluwa Babatunde wrote:
> The unflatten_and_copy_device_tree() function contains a call to
> memblock_alloc(). This means that memblock is allocating memory before
> any of the reserved memory regions are set aside in the setup_memory()
> function which calls early_init_fdt_scan_reserved_mem(). Therefore,
> there is a possibility for memblock to allocate from any of the
> reserved memory regions.
> 
> Hence, move the call to setup_memory() to be earlier in the init
> sequence so that the reserved memory regions are set aside before any
> allocations are done using memblock.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/openrisc/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 9cf7fb6..be56eaa 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -255,6 +255,9 @@ void calibrate_delay(void)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> +	/* setup memblock allocator */
> +	setup_memory();
> +
>  	unflatten_and_copy_device_tree();
>  
>  	setup_cpuinfo();
> @@ -278,9 +281,6 @@ void __init setup_arch(char **cmdline_p)
>  	}
>  #endif
>  
> -	/* setup memblock allocator */
> -	setup_memory();
> -
>  	/* paging_init() sets up the MMU and marks all pages as reserved */
>  	paging_init();

This looks good.  I will merge it via the openrisc queue as you requested.

-Stafford

