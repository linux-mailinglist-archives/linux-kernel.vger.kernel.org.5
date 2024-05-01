Return-Path: <linux-kernel+bounces-165578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6B8B8E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10457B20FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930413048F;
	Wed,  1 May 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzT9TCCV"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213854FB8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580987; cv=none; b=axaW53qY53V9rcih47ud1qRFjNpb1hd23bePyJ0y6Bdgv3/6gJLYG25BW1o5qgrCM0SW6J0aumNjTMSqTaXJzjv9mjWQnaQu8YxpZDzCwhCTqv4qmfq70jriXNuDtlTurZGdFC/VXZwco24j97upg2RSbX3EOh6F0mjzincVSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580987; c=relaxed/simple;
	bh=fO0a+oEeNqiYC72c6HVz6VJiZMcPjwMi22qouPgD1T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOYSi9t9qtN7fCr1WFRZIYvFHdeMKla55GYgBi79btScSFpIUjJFvR+S9eKtxd+7Z6dKAML8GxOSMR528ikV0nQpc3/cTm3kLMMqQIeyBT/BwBQ4zuPeESfb2LBMPth0JHwQbB4qVhM/tUYwQd1OAU+C9PMLCjVg3jJf7YUmvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzT9TCCV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6153d85053aso56500597b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580985; x=1715185785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JhUFoDuTe/RQlJB0MwNXH98/7xR5MEc4zbU3I5zlyw=;
        b=bzT9TCCV45rnNCXyVlwtSv3k2pEBItwR5BMWVMSKOXLcB8FG4tQm4VsAnpTVxIJ/AH
         NzscocbsWpD/c+1g720U0vhH5UaChHCHaAB6TZoO46rqrf5BLgwu4ENijrzbWbshxyW6
         7MbIwFDAN4jZopv9OH/fw/2pvV1031DEyWmlJ3BwUe3u55Snkz8h5hMfc5KtNkdyyXaT
         5zUFlU5bZ5AIJyrZsRUJiwSMD0apDx9TpZB4+IdOFACtkd4gy0OnOeyfLWfpB521YkPS
         tR4USq94EnULYjcH5sgyslLumBmoKEGXO7d0kBLkN4LKZOMRD8QSfCtxPX4rfLPnaTIo
         /fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580985; x=1715185785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JhUFoDuTe/RQlJB0MwNXH98/7xR5MEc4zbU3I5zlyw=;
        b=L8MRowhr34/Hp7PjmlJz6MRjOFDOFB6wZ6QPy6LqnkfDlNhtEs/9iXSM4JLnyqYpkc
         +5wtoFwHkSK8xCsz5py9ZzCgTmwp+CStfi2jtWxbynWHmAVyfyyHbvV19PZ7PovETseU
         drTk4qHQFh8ZhGfOrFGGh24Bo81YUewUVjkD31xMUwRxWPWIzVTY8+KQ0dumrfxijUfd
         PmfnU8gLYXfSp2Pvs36beWEDEbX8S0GdfOLRou2/oupfrYORKmsSPG5jSAqNb6Sy4IGB
         QdPimh4mApzHXXSSp3XHsVtA/nLqZOYFXHlb22QUxOUKYw69ZYdXA+OP3kfRue9IQIlu
         nr6A==
X-Forwarded-Encrypted: i=1; AJvYcCUb6d3JQqS+f1aVh+K+QeUe2UBrCnrLhpVZGTkrBdRPQK5JkFhPz6197FKilBORSIvq01SJZh1qauAWiQDQAyFOvo7qKlLQsjslfgqW
X-Gm-Message-State: AOJu0YycZLNk9CzEc+YEIJAYmYFpB6ZZd/64jjNEMsNKAIg5ap62rApu
	iHhAjnu3/EgNb45SK0yEb5TBVPb5/bGubvUEI0N4C1wpqktY52mU
X-Google-Smtp-Source: AGHT+IG27y2zQWrGAZ7qm7rjKC5KjbYj2HHspK3M7ldH5NqvuVm9gNVPVyPOF1FwdYlvp+vSrDzCfQ==
X-Received: by 2002:a05:690c:6688:b0:61b:2b7:27d8 with SMTP id hz8-20020a05690c668800b0061b02b727d8mr3067484ywb.23.1714580985149;
        Wed, 01 May 2024 09:29:45 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id j6-20020a819206000000b0061880ec01d6sm959158ywg.93.2024.05.01.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:29:44 -0700 (PDT)
Date: Wed, 1 May 2024 09:29:43 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
References: <20240501132047.14536-1-visitorckw@gmail.com>
 <20240501132047.14536-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501132047.14536-2-visitorckw@gmail.com>

On Wed, May 01, 2024 at 09:20:46PM +0800, Kuan-Wei Chiu wrote:
> Introduce a benchmark test for the fns(). It measures the total time
> taken by fns() to process 1,000,000 test data generated using
> get_random_bytes() for each n in the range [0, BITS_PER_LONG).
> 
> example:
> test_bitops: fns:          5876762553 ns, 64000000 iterations

So... 5 seconds for a test sounds too much. I see the following patch
improves it dramatically, but in general let's stay in a range of
milliseconds. On other machines it may run much slower and trigger
a stall watchdog.

> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Suggested-by: Yury Norov <yury.norov@gmail.com>

> ---
> 
> Changes in v4:
> - Correct get_random_long() -> get_random_bytes() in the commit
>   message.
> 
>  lib/test_bitops.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> index 3b7bcbee84db..ed939f124417 100644
> --- a/lib/test_bitops.c
> +++ b/lib/test_bitops.c
> @@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] = {
>  };
>  #endif
>  
> +static unsigned long buf[1000000];

Can you make it __init, or allocate with kmalloc_array(), so that 64M
of memory will not last forever in the kernel?

> +static int __init test_fns(void)
> +{
> +	unsigned int i, n;
> +	ktime_t time;
> +
> +	get_random_bytes(buf, sizeof(buf));
> +	time = ktime_get();
> +
> +	for (n = 0; n < BITS_PER_LONG; n++)
> +		for (i = 0; i < 1000000; i++)
> +			fns(buf[i], n);

What concerns me here is that fns() is a in fact a const function, and
the whole loop may be eliminated. Can you make sure it's not your case
because 450x performance boost sounds a bit too much to me.

You can declare a "static volatile __used __init" variable to assign
the result of fns(), and ensure that the code is not eliminated

> +	time = ktime_get() - time;
> +	pr_err("fns:  %18llu ns, %6d iterations\n", time, BITS_PER_LONG * 1000000);

Here the number of iterations is always the same. What's the point to
print it?

Thanks,
Yury

