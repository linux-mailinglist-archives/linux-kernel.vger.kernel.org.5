Return-Path: <linux-kernel+bounces-138808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5189FA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28741C20908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03A178CE9;
	Wed, 10 Apr 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSFIF/sV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1C178CDC;
	Wed, 10 Apr 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760487; cv=none; b=QRafj0hzBHk0Xr0Fqu7vmWS/KhSUP5WS3EAJ7BHlt6kxTxBrmhmFsaaOVaP/yJjAbDV52tto/UrgqvWgwCZ041pbYCwT8ePUK5wF0lJAVEM5CYikxq3ryQS4Bowqo950IT6riCz34k5lw0LBYVf/FftpKdvzTmRs/IXH4h2IfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760487; c=relaxed/simple;
	bh=83IlgsIBGdPvvy7KkGpKf6FCNdqnXmoF3sXAeFZbVzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHcs1A2eTC4KSjAgwy04wWhiOsPrS4I1ivkutUp8FrYB82HqRj3eR/4yHPkhVhGTPW5ufeTm5pGVJlNYqZu02D4lwMMpSxeCjL7cpEmyzyFTYMN5/vAh1BFierr4iaNsgFXx41/POsGLaVRAGNrgTRlG44noww+r+5I8IUN4iLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSFIF/sV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e40042c13eso24381135ad.2;
        Wed, 10 Apr 2024 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712760485; x=1713365285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJsjVxj31Zb9TXNhUKJteq2QrNcPPYlblcldkHbg4vw=;
        b=kSFIF/sVSh6sH9YAm+o2S3wb5Hrsj5gVKH3UoWvifLfL7Fj6gfE+60QjAhAApyOVuw
         WvtWijrsKRii9TAU63n0rJ6ChDIOsHAlilUE4KIhccl1HRyAgVP56yQB9pPC/TLCms0m
         PM/xf4lJ+dYwq2bl1ui26hMjOhXi6aLHc3IjXRCYjpJUYZpTl3irK9s5/Iw0y9TfTmkC
         QzijDZsi9y+2+aYZf4n2QIfoguK0zh4tkXd6LySeZZRQIIAkvURnPcJP4swekC8+jd91
         vWGn8Bx1YnVJ0jarYe8cICbs0K27EglMh3kkxMano36JUtPIwf/5n4TSEtBGYuUNIIOS
         r9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760485; x=1713365285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJsjVxj31Zb9TXNhUKJteq2QrNcPPYlblcldkHbg4vw=;
        b=i6Kz45bfSnrlcA6gD0oJbZQVZW8u5l4jUrkUSz62/cdTSOrikB2m+j33Zz08iEbEi/
         +W8KKz+C5wf0rbV1cjWzOp7Etv05XdKHaI4L6d4sNfLN9hHLUdpqEA8bJSc5CF+IeA3W
         uww0Gurryl9KePnb1XThicEui1BneojNos8d3SadTc24Pq2C9hu69YjA2e3/rueYjej2
         7YklX+vuLTa0xfUn6yelt4dS3w/9+1VaicIkUmtbvY/uhmgt5IyS5zipE81EkIxgFCsT
         QSUe8hW4S4O7R8mXouuLNT3vgIjZZzGyFbzfWtWjCovHGDE/NPqY16DAHQDfF5blcO6W
         t/hw==
X-Forwarded-Encrypted: i=1; AJvYcCX6iiU5r4kCoVPabJH/pGimCMD1SAWutXSz9czRWFq5toIM6v9pT7BDToY5Ku6qaUW0I7QnEhdlOy6oIqhfR/11TqBGLYuy4czcyZyUWxLbFnjPkTwBQm6kMNa9sTvTRZCe/wAlj8kwGrO7sU8=
X-Gm-Message-State: AOJu0YwYihjMyIYDwoJJplVCe2bcp38fu4it8sUHRorX798Exm3XB8I5
	IhobYPnMnSGIc9ErFUuDaAZzDEqGsNKU8PxEqZp14n/JYEEzXZGuwOIGjl4q
X-Google-Smtp-Source: AGHT+IHgUs6DSJo0qANFWn7VNXEYT+7xHCJ+Qx2wGWRLICPDNOrJeaLSkQUdnEu6IEZYPeu6Xe5hCw==
X-Received: by 2002:a17:902:7c8e:b0:1e0:a4c9:84cd with SMTP id y14-20020a1709027c8e00b001e0a4c984cdmr2450375pll.60.1712760484583;
        Wed, 10 Apr 2024 07:48:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ky13-20020a170902f98d00b001e0f5034e95sm10875689plb.288.2024.04.10.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:48:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 07:48:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dawei Li <set_pte_at@outlook.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/wdt-main: Use cpumask_of() to avoid cpumask var
 on stack
Message-ID: <8be5a179-df13-4441-8276-504dcb925026@roeck-us.net>
References: <TYTP286MB3564B037A81DAAE1AC3A16F3CA062@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYTP286MB3564B037A81DAAE1AC3A16F3CA062@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>

On Wed, Apr 10, 2024 at 09:13:59PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_of() to avoid the need for a temporary cpumask on the stack
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 0fe71f7e66d5..52d49e4e35a0 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -381,11 +381,7 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
>  
>  	/* Must set the irq affinity here */
>  	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> -		cpumask_t mask;
> -
> -		cpumask_clear(&mask);
> -		cpumask_set_cpu(cpu, &mask);
> -		irq_set_affinity(irq, &mask);
> +		irq_set_affinity(irq, cpumask_of(cpu));
>  	}
>  
>  	cpumask_set_cpu(cpu, &irq_enabled_cpus);
> -- 
> 2.25.1
> 

