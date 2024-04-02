Return-Path: <linux-kernel+bounces-128098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F1895614
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272DD1F232DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337986244;
	Tue,  2 Apr 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuEGNtIK"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961D8615E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066618; cv=none; b=sfJSEKfCtIRS0PTZiSWUusSrild9/uEqZcUns7YGsbcVbx9k6vRa5r46dIH0ew5pNPr8anM/YH2O7wKouOTBLmKQusypmafvqd8N73GvDCbDJTSeV1wy8iGgWunoxyNY4jVlo/QFALEyGnrrq5e12LmfFcBbwQ8UYiKOMk24tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066618; c=relaxed/simple;
	bh=ES2zyndTm02Rr8qhRqIMTPcyZsNXG9YPNIXJXiQEBUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX5VHuqElGWKhENMb7owzHgrXI4L55/rIBHkoU5aSPi5llHAQ55BYLFik52+GgP4fIA/xr/7ORbP7nVGnmnIj5SI3P3mzmgcC3EKYZ7H/wYiAbcnl8nIJfabEvYP3XdpIgxWR+h1JbN2WQXuUvKFA1Vhn1wErdAeu7eFu/UJrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuEGNtIK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a128e202b6so1704525eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712066615; x=1712671415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQP/i69BJPS39ZPWBxQRIRcwK/gMEdt97TrqqlasKoI=;
        b=UuEGNtIK6CB00kmWemaNCRMufUInzPaYg1HuAE911L8F6SfRvQKgcnczFpIOvZy2y6
         yzXIrKrOcka0mqLrh20ThfuLewmTH6k+44GdK5aT47kR7FL08kl08UUv97P1KqIYbFxh
         m4HT3Mul8XJNvGi2033x6WH+jlm+Bw/kJNX68QhMY6jWjGg3rXEqOvf1+rQVRS+pd3B9
         B5AFKOoyHr0GTUUsW0fnyMPSaZPVqy2R8SbN5POJ0+2zcWpYyrRdl9snjioXG3+14s8J
         9lLzxHx7tmPq7Qp3DbhPjgFGRa49kmyGoMqoKMpf4XuYPRRmo+Hnq2tkk4PgCmH7VksJ
         wOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066615; x=1712671415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQP/i69BJPS39ZPWBxQRIRcwK/gMEdt97TrqqlasKoI=;
        b=X8/WvyuYFCiEDFXeqMd1+8uIRZOx4ZRHNPr+6cRmsR/hZw9v1yaCJ1MkCuyWSyDm3/
         yOX1ohYm7QkIqHQaZPdLl6zbnvvKBU3Pk+h/MS0D5WqTQJ85UoHt1JsZ9eLQaJZejLTf
         lPLA14LBsbyjUsr0dOeD7mUQTilhFgImR104KJlwg9Be16XV/pmX8QHhOS5gKALECKTJ
         8L0qwGt7MbxWkyVKMjk6cZZ0JRjlPJQ/Lw2JdtPCYe/GwlWdZw/ARGPRuxTulPheVP6W
         gAP6ddNjwKQt/HUIPFH5SR1QgehlAJE1zA+JwC7XqpGJjXS2ZM68GsvGxM1KNlgTbTAR
         mIoA==
X-Gm-Message-State: AOJu0YxFuy9Kvb5wIiAAbl/Uqo0IYjYM8DdUoT/oz94XYPNWckWq27Ha
	SsJAj2zpG5cUwUDfMBFL0wepNZI3rLlln6typin1vjLq2u0ZbKUSQSdY4ERx
X-Google-Smtp-Source: AGHT+IFl58KfT9rmGtvTAHWQC1L0It4Oq1XaHKc0PF7doXcJ4AVxxO+Wi8pxKeIXOeSDQA2kiceyOg==
X-Received: by 2002:a05:6358:7215:b0:17e:a9b7:2636 with SMTP id h21-20020a056358721500b0017ea9b72636mr16920262rwa.22.1712066615556;
        Tue, 02 Apr 2024 07:03:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1-20020a6544c1000000b005f034b4d123sm8504837pgs.24.2024.04.02.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:03:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Apr 2024 07:03:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Daniel B . Hill" <daniel@gluo.nz>
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mean_and_variance: Drop always failing tests
Message-ID: <57dee893-6ee5-4444-a706-2adec83e9356@roeck-us.net>
References: <20240225162925.1708462-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225162925.1708462-1-linux@roeck-us.net>

On Sun, Feb 25, 2024 at 08:29:25AM -0800, Guenter Roeck wrote:
> mean_and_variance_test_2 and mean_and_variance_test_4 always fail.
> The input parameters to those tests are identical to the input parameters
> to tests 1 and 3, yet the expected result for tests 2 and 4 is different
> for the mean and stddev tests. That will always fail.
> 
>      Expected mean_and_variance_get_mean(mv) == mean[i], but
>         mean_and_variance_get_mean(mv) == 22 (0x16)
>         mean[i] == 10 (0xa)
> 
> Drop the bad tests.
> 

I did not get any response ...  ping ....

Guenter

> Fixes: 65bc41090720 ("mean and variance: More tests")
> Closes: https://lore.kernel.org/lkml/065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net/
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Based on next-20240223. Sorry for the noise if this has already been
> addressed.
> 
> Tested on top of mainline kernel (v6.8-rc5-329-gab0a97cffa0b)
> to avoid other problems seen in next-20240223.
> 
>  lib/math/mean_and_variance_test.c | 28 +---------------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/lib/math/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
> index 0d8c2451a858..fe8309f456a3 100644
> --- a/lib/math/mean_and_variance_test.c
> +++ b/lib/math/mean_and_variance_test.c
> @@ -135,20 +135,8 @@ static void mean_and_variance_test_1(struct kunit *test)
>  			d, mean, stddev, weighted_mean, weighted_stddev);
>  }
>  
> -static void mean_and_variance_test_2(struct kunit *test)
> -{
> -	s64 d[]			= { 100, 10, 10, 10, 10, 10, 10 };
> -	s64 mean[]		= {  10, 10, 10, 10, 10, 10, 10 };
> -	s64 stddev[]		= {   9,  9,  9,  9,  9,  9,  9 };
> -	s64 weighted_mean[]	= {  32, 27, 22, 19, 17, 15, 14 };
> -	s64 weighted_stddev[]	= {  38, 35, 31, 27, 24, 21, 18 };
> -
> -	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> -			d, mean, stddev, weighted_mean, weighted_stddev);
> -}
> -
>  /* Test behaviour where we switch from one steady state to another: */
> -static void mean_and_variance_test_3(struct kunit *test)
> +static void mean_and_variance_test_2(struct kunit *test)
>  {
>  	s64 d[]			= { 100, 100, 100, 100, 100 };
>  	s64 mean[]		= {  22,  32,  40,  46,  50 };
> @@ -160,18 +148,6 @@ static void mean_and_variance_test_3(struct kunit *test)
>  			d, mean, stddev, weighted_mean, weighted_stddev);
>  }
>  
> -static void mean_and_variance_test_4(struct kunit *test)
> -{
> -	s64 d[]			= { 100, 100, 100, 100, 100 };
> -	s64 mean[]		= {  10,  11,  12,  13,  14 };
> -	s64 stddev[]		= {   9,  13,  15,  17,  19 };
> -	s64 weighted_mean[]	= {  32,  49,  61,  71,  78 };
> -	s64 weighted_stddev[]	= {  38,  44,  44,  41,  38 };
> -
> -	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> -			d, mean, stddev, weighted_mean, weighted_stddev);
> -}
> -
>  static void mean_and_variance_fast_divpow2(struct kunit *test)
>  {
>  	s64 i;
> @@ -229,8 +205,6 @@ static struct kunit_case mean_and_variance_test_cases[] = {
>  	KUNIT_CASE(mean_and_variance_weighted_advanced_test),
>  	KUNIT_CASE(mean_and_variance_test_1),
>  	KUNIT_CASE(mean_and_variance_test_2),
> -	KUNIT_CASE(mean_and_variance_test_3),
> -	KUNIT_CASE(mean_and_variance_test_4),
>  	{}
>  };
>  
> -- 
> 2.39.2
> 

