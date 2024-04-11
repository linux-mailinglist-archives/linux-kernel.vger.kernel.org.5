Return-Path: <linux-kernel+bounces-140706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA978A1801
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6345A285028
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9F13FFC;
	Thu, 11 Apr 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnLLIQ9+"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE4101DA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847633; cv=none; b=pIeA+QKvXTQPqOjYfg2ujA5pYnMN7nMaTGjxjwPmr8mfE7GlVoRsJw0twTFad/GHYBl+ZayQ7X/OcmpfET9HIOVYPmCDBUIIveaqDDFM3PRIM3RizVmLPgotmPkvhFpyBh6sfC73qG5Fd/AL6bx4VgolrubzMBaBPEwO6z7tFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847633; c=relaxed/simple;
	bh=dvM6yc+Dk+cKTgmEM4dCnyBu8WZu/Jpf3J4qPjeVWEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmaFTT8UZotnWbmB78X5n+YDVuXspX8T5QWCr5IQBmYXkv2w0q7oJMQEaF8aZHWgKmrE/5N9dHU7ETmxJDZsdFLbIIVBLFFOSKYWiSFGwJDnp997+8mse3rUjZ4Cut2S+/QKULqDkIq3SzEwfX6NNtAqhVAxXOHkAk7lzgXy4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnLLIQ9+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56fead80bacso885665a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712847630; x=1713452430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AAP2GSXMI8XPS99qq0u7uGwu5bsp52Ho72AkcY7Vto=;
        b=NnLLIQ9+zRf/raXKvF6SgJHLYkre9/4mJQ0dA8Rh7AgDZSFQIGmxyt9TxROtoDFiGK
         OU+lXqmYikk59EnJemOarSJVCzFY1TpyVUenQz3/+eaBIFQvAwFQIRkatb9GtlaQQu3Y
         7UMIiyL3kXKz7z6MAimwm51hH/IVO14BlptMxEY8J373BXdvhVRaMwSZP29lzCnkw7qb
         6SgjHYfPmB6Kg1ZoumJphBLgaCfB9rpTc9e1pgzpgIV+iDhDzpX2TLwMm29qlQc5kPqC
         yzhUnXskoLl5xfz9+SLaX5bjVyQ8hhQ76t3UiJC2qVuRwM+2FC4qcoNMBdC6rAbZ6LfG
         Yh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847630; x=1713452430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AAP2GSXMI8XPS99qq0u7uGwu5bsp52Ho72AkcY7Vto=;
        b=SK2vUdadMujg7j32woP5bBf32FuHn/jrVbzKadi3G3/EUNskO43LkgyeI/5iEYfv9D
         vOYPyeUKdpd1eixJZKJBsez9aNU8Op2WI8sDBy0cYA2DDplocgCwjkx4LK00OfWhkch5
         +KjeTash6y07oWT7EwhXPZ/UcI/FIF8KLldwBYCFo5UFjMcUzLImiaGxZu4q1VVU4+3v
         KMggbIpZRABrlptdTvdGzaJsm+qxF0VMZmmeQjVh2YIORXi3pFwVgZKUKDl1WnalMXYu
         jpsXWAPua5HIPcSiG2GevD5WhrzerMvZSw2DqtTdGJYVjtGtZ8sXpTHeGA6GXxvAQxsz
         rVXg==
X-Forwarded-Encrypted: i=1; AJvYcCXj5kN8OnNvWi5JV/fWpKBusrwvR6cTaGUtmws/5UvNhsbwW+0xJWcClItPAWetPjp4/OehaWZ8giPKxRt+7DKG7SCdxccY25hO+uxL
X-Gm-Message-State: AOJu0Yzbzgno9U4kjX5hPCu2gz5A0iy2MvBq49JcXBTdSPbVo84bZ0a9
	FKDoU/5cLdURXvF4DoNSWgOtjy15wSJNg59pzXCo0M8rNUoBZmiNiE2IXKNF0pk=
X-Google-Smtp-Source: AGHT+IHKuxw3VXAdRk5CGOofjhK2As1WNciZ/SxTO3eBCva4YM3a3X0Ku7wGIQlM2F3nXzy4iTRQag==
X-Received: by 2002:a17:906:b24a:b0:a52:129d:ca66 with SMTP id ce10-20020a170906b24a00b00a52129dca66mr3090939ejb.21.1712847629683;
        Thu, 11 Apr 2024 08:00:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090634d800b00a51b3d4bb39sm829976ejb.59.2024.04.11.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:00:29 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:00:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: David Gow <davidgow@google.com>, Will Deacon <will@kernel.org>,
	mic@digikod.net, keescook@chromium.org, rmoar@google.com,
	lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
	anders.roxell@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
Message-ID: <f2d02e35-185e-44d1-9b58-1034336e2e0d@moroto.mountain>
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck>
 <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
 <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
 <CA+G9fYt6U4YzYGvYWxDVvUVKNc0pgVYiGafZ5_OSEf=5r1=YYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt6U4YzYGvYWxDVvUVKNc0pgVYiGafZ5_OSEf=5r1=YYA@mail.gmail.com>

On Thu, Apr 11, 2024 at 08:20:55PM +0530, Naresh Kamboju wrote:
> 
> I use to notice kernel panic while running kunit tests
> now I have noticed this
> 
> Unable to handle kernel paging request at virtual address
> KASAN: null-ptr-deref in range
> pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
> lr : kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31)
> 
> The kunit tests run to completion and the system is stable.
> Kernel did not panic.
> 

[ Snip ]

> <0>[   76.808597] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> <4>[   76.809876] Modules linked in:
> <4>[   76.812055] CPU: 1 PID: 567 Comm: kunit_try_catch Tainted: G
> B            N 6.9.0-rc3-next-20240410 #1
> <4>[   76.812987] Hardware name: linux,dummy-virt (DT)
> <4>[   76.814123] pstate: 12400009 (nzcV daif +PAN -UAO +TCO -DIT
> -SSBS BTYPE=--)
> <4>[ 76.814947] pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a new intentional NULL dereferencer that was added yesterday.

Maybe these should have a big printk, "Intentional NULL dereference
coming up!\n".

regards,
dan carpenter


