Return-Path: <linux-kernel+bounces-92797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95231872617
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD23B2A6A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D317BCD;
	Tue,  5 Mar 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVSUjqmt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC817BAA;
	Tue,  5 Mar 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661466; cv=none; b=FU2MPp5tpH21THSyPj9sIqAmA+bz2Ja/fSk/yZlhuX0rVGRgPeuReCw8Era8s0qQG/bzRtonPMPVnnn7nBIlZiCoE/uS48c1YAJ0FIErs8TFL5N14DJJ4RtBYoXFRTLBvtoF96Ll6/O7q78XByFfTCZaXLmSY2GTb2a122s7f6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661466; c=relaxed/simple;
	bh=VEcXA+Hkd7aAdPoYFblDeKTFLE/HfWUJ5wdzlkK3xrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ5g/pGQ/Gv5Yu6IMjkKi2w3I+7vgNdvRC/MJODRBHRQIGvseB2GNvrriWJGaugTFIOsuaxYrsPr4XGU5I1Kmn1mnH2VWlIMrAsFEZMHBHAsWhMpBrQsnm8RFxNmRzMI3lNsHsjcu75tcm6aZsOb1MYSBD5FTFpK5MZD/cORYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVSUjqmt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso4066486b3a.3;
        Tue, 05 Mar 2024 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709661464; x=1710266264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzyoyKTGuNCPrSsPdt0ZKOh/RAgUaTRrGSTgK1o1fRk=;
        b=mVSUjqmtV16/sCnRxeTuOuRdwSq22TnNzGmbLkksHMrHmCV1xm053atHtv7AzaMslr
         zYEbm26kDgOERhIndJQhYMWA9/yHgLZOXa+rmv4md3QeuidU/isjRab59jM75OaTwnmb
         AsPxnCHaD9AjhUJ2HBnzQLCyjVtJ1wxj+o6eL6jCpNYGonWqfEibUtyP80YYbJdI/x2B
         PHRbdqf5M7TLtHVWyeW97QNRklpLKlsm5K+HAOwQaaqs71vg6extW6v1cDgeQJjV8E/O
         fTXAe1ShJ37UbZ6LsPgSY8/lAZw5pHh1OXVhXqC6G/aPz/wV1tTZ4sFyy+/9BFsceALr
         zmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661464; x=1710266264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzyoyKTGuNCPrSsPdt0ZKOh/RAgUaTRrGSTgK1o1fRk=;
        b=Wb2BxcSPi+XllYdyxC8S//TM0fhKKqIHjms/u1S57K5KI5ngJb2kIpsScd1mefbKVY
         C4mPMbfPXF7w7u8w24zACObdsXKpZUYKoT2JMN9DFBEpbaE7HdwUzvmr7YjB0itvXmb0
         tI3wSS0kMauMOFxPwjXFjmozOvhdDPfo4sNjd1axt+LpYBC6Izx5NMIRsKYDq+7rrkc3
         7sRcmcsbEj9HvGraIfW6Y6Rn7HZ5X1S72nA3blOUTiAr+c2Z2yIdNNJc92wg6qdRkheg
         FXUZTDL1VQso6mKupfti7m8gOjw4o6aimq3uFnzHbhlzkToL7XLimGRLv7w6zH0g1c9A
         5pGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5EYvMm4lcewZc58C3mDxQHLNrdzXCqrMYtVcgjNyXOsJ8ZPYeDkqDJGEYozugywoNHCcrftC7A0oc7Dch7rlbKjR/iREetTsEYeOf
X-Gm-Message-State: AOJu0Yxik0igtq4tnkc4YE+MXJHEdsxrcW0s2TaTKwwayncpJopzAyhS
	E50cIpCQAeJO1sEoPMGJo4bf5res/vx3wj1CY54VNpweaRV9b93q
X-Google-Smtp-Source: AGHT+IEmMavf8VVr2Mlv1y1G4q+rltJNpYRi+SiqQ7eLGMd9IOCULRJeu9DJTlC33KBzCpFq5xsK9g==
X-Received: by 2002:a05:6a00:1492:b0:6e6:2df4:198b with SMTP id v18-20020a056a00149200b006e62df4198bmr5606395pfu.4.1709661464040;
        Tue, 05 Mar 2024 09:57:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b006e5ed7c0b35sm5760866pfk.67.2024.03.05.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:57:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Mar 2024 09:57:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v1 3/3] watchdog: intel-mid_wdt: Get platform data via
 dev_get_platdata()
Message-ID: <47e6a7a9-e98f-43a5-a7f8-816f2277d7da@roeck-us.net>
References: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
 <20240305165306.1366823-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305165306.1366823-4-andriy.shevchenko@linux.intel.com>

On Tue, Mar 05, 2024 at 06:52:20PM +0200, Andy Shevchenko wrote:
> Access to platform data via dev_get_platdata() getter to make code cleaner.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 06d5d207a065..8d71f6a2236b 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -127,7 +127,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct watchdog_device *wdt_dev;
> -	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
> +	struct intel_mid_wdt_pdata *pdata = dev_get_platdata(dev);
>  	struct mid_wdt *mid;
>  	int ret;
>  
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

