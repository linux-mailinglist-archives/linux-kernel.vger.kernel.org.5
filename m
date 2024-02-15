Return-Path: <linux-kernel+bounces-66431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD533855C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7762A283A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F9134CE;
	Thu, 15 Feb 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri0f8YUb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6811713
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986324; cv=none; b=JQrSdm3FNpBb57MsvTlgARR6RypsZ0K1EqV2MHCh8Zx0LQFmXQnTwN//EwJJQlxlWYoKjODq7PhYmt30PRLH/iITU4KyLqW9/9yr+IPf8U7qUFA5MK4UMVr55dbNE8c9AnxeRKb5b0FCP7quZtsryT2C7rMsQsZTpF1vUpsS31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986324; c=relaxed/simple;
	bh=Q56x3ZcX1nF9Sgm6TFM0JZIi1GbTTjB5Fn2nyTorVbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsX0/47khjdGNd95Pc6neXtg2ntz5YPz8iMLAYKoG0VX3QICCdrcUPN7RlJTAf4wGZX9nt5LEl1QyXRTCn18xa89LOb4BwTwYV83GZXH7/5cs/FPMp+g6xqTS9kN5FtoaR0Eug2cvnQuV8RtYHVm5qH4vMjDoynkN9c6cumlm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ri0f8YUb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71cb97937so5854485ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707986322; x=1708591122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unp5IYDIJwzJBKtXHzFZAv0ys3C/nXvo3MpOLEbWD+0=;
        b=ri0f8YUbwHLi89vFn1RQc5cGGsP/GBhKQpDneR3fZY3aIICVbo7qV+hUxr+YC7pqpO
         peP4HRrD+K6RadLWJ5g2sAx/EgTP9C4PsdqoPp/gR4llwmQJqf1DjY4K2Jepqcladlzi
         yFCgYXDvBpnp3bYhNG1DuVMc8vbK+2p9Vi38owZOt6K28bkQAA7i4UDc4hr28i/NqlWL
         NNE4pXeyc1IF0OOYSpdG1CWf3EMvXFw/i6hZyGDkhle+jg1mmVVm3S/XUljCmr0zlkNB
         lwVqc12UyF8vGtTA5XrvBqdyvGkTJpRzX13/KQh4wlRX+HGdqRbKpmirE0wTRgXi41ve
         G6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986322; x=1708591122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unp5IYDIJwzJBKtXHzFZAv0ys3C/nXvo3MpOLEbWD+0=;
        b=B+keeC+mmXJmDXMoCxu61Kg/oSDP0qIyUBmUqk6AX/a4bxDoRpjuO80HOA4OeSwByk
         t0atzrkGpv2qf2iq4H9m7G/TdGn8oKwtbEhU1r2AS6O2jeZJgnyN09s5FE8JmLlSKIBb
         B+5RT5Tvy190IcaLHamKpouG4gsB57gIoUOYf2rSPvOF0lKu44UqXhdgqNDWE/pjbKet
         OxdvYRczckpioc5kBJWwcafnLc6aOozpGcsIfuayc9H6c0RdVuijyWDfDwwSNfdn243+
         gu+uqD1aexlxXeCppY9JwLyRjoTBrrhG8QxpKkCAQWfl5qIeFo6KwJHG+1xlkcnxJtVR
         nGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWWIP13VZR8bW6LgIAuGCNLhUjKUHbVz8Bz2e9hK49galx5y6rYY+l2GsZWjiSOfuKSLS95XrbNElsAO+OTTDwPPFKVM65PmN3ZLMok
X-Gm-Message-State: AOJu0YxYA/1ND6Wkw5WGkxeKZoU9QxIfUlZifWbXTS5e/ZmtP7W9uDV4
	FKtHNy61wtoBT+axO//KPkrgV0il0qUQ2Wx5cdlQ3/3+Se6hP1h1wyElXS6UW8yHOD3/48fsIA/
	H
X-Google-Smtp-Source: AGHT+IHcsfElY98Ie802okXFW0Fa7ycIX8s8eDqg3GY+f9qMqasiqHgWuI5mLHezozWl+ozksSlrZw==
X-Received: by 2002:a17:903:32c3:b0:1d8:f071:5067 with SMTP id i3-20020a17090332c300b001d8f0715067mr1329330plr.35.1707986322106;
        Thu, 15 Feb 2024 00:38:42 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902bf4500b001db45855530sm729704pls.290.2024.02.15.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:38:41 -0800 (PST)
Date: Thu, 15 Feb 2024 14:08:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Jingyu Wang <jingyuwang_vip@163.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
Message-ID: <20240215083839.rq7655uhmrlnkh3w@vireshk-i7>
References: <20240215083322.4002782-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215083322.4002782-1-arnd@kernel.org>

On 15-02-24, 09:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is still possible to compile-test a kernel without CONFIG_COMMON_CLK
> for some ancient ARM boards or other architectures, but this causes a
> link failure in the qcom-cpufreq-hw driver:
> 
> ERROR: modpost: "devm_clk_hw_register" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> ERROR: modpost: "of_clk_hw_onecell_get" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> Add a Kconfig dependency here to make sure this always work. Apparently
> this bug has been in the kernel for a while without me running into it
> on randconfig builds as COMMON_CLK is almost always enabled.
> 
> I have cross-checked by building an allmodconfig kernel with COMMON_CLK
> disabled, which showed no other driver having this problem.
> 
> Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index f911606897b8..a0ebad77666e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -173,6 +173,7 @@ config ARM_QCOM_CPUFREQ_NVMEM
>  config ARM_QCOM_CPUFREQ_HW
>  	tristate "QCOM CPUFreq HW driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on COMMON_CLK
>  	help
>  	  Support for the CPUFreq HW driver.
>  	  Some QCOM chipsets have a HW engine to offload the steps

Applied. Thanks.

-- 
viresh

