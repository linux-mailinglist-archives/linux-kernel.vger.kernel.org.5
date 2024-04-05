Return-Path: <linux-kernel+bounces-132349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6B89936C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC62FB23D32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BA171CC;
	Fri,  5 Apr 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ffWD3uZS"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F5134A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285652; cv=none; b=K2q/UFHb6dlc8fWk0Pwaw4OzZ0VfDdpVxsWjuztEMr69FnoRRocM1yUagJbowIZUH2TgYuEXJQcAR5RVWwqC5mQTie54dIoUwYn0HHb8pHb4kqAutB6+krQc7flPBFHTNigGxCucLd6urSzq/k22WaTJvLBfuWgwNKaA1bdW2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285652; c=relaxed/simple;
	bh=6fIOr6xwP89e85fVGuI+zgzRY7BLn0WGoP9hEmgJiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiA8LkvfDaAd2ldiuAUqH7RDN9sF7ysIG56CLYbaLC4lgl263SXano6OFZUxCpmiA+d1SUWEIx0Xr4PWnpH32acr4yD/tRVaRsjySKjJU+SIIfMnezELWH3GQKgEI1KOZrQpnyh6f/oTMioY0TzHQGwr6/tT2T6VUftecwEZ4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ffWD3uZS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78bd22f8257so102120485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712285648; x=1712890448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7aECXqPEviHQhu5pIAJUJtLLf+Cx7njO7rHYd72qcE=;
        b=ffWD3uZSnfBUwcqfJHh2/8VQmdPh9OPSFydepskKHohl4MNllcvihepiMzUMA6xbrg
         mXLXO3oWpPqceauawin0DQ8FMZEjN0Pfg/ITVYz7MPNm4ABxpuWQwQPRIiXyDnDbPouV
         +SUAVfy5lVidk4iHvDUdGubtlNow8JATcHiOp0f/0oN6s0BC3L6tJ805XY5XpcqkS+71
         6tDY/57Y1px6eWy2iftJAjWw3AGqKoqzJVUQeJ5bR1pJdiY8YUBGDG0zSkuNhkkh4qQ4
         seoIUUu1g5dBmgMfJ0vVs7DqcQhqqqeibYlDC1ItwQ5wpXX1uAbwhjZfoy4t4RCQDiQr
         bpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285648; x=1712890448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7aECXqPEviHQhu5pIAJUJtLLf+Cx7njO7rHYd72qcE=;
        b=NZ8aAHy2VEr7+B7H2qB4siiu8iHgbeUZIGFYTE/UF3ZNsHCFGKEu1+D1T4fWHY3ChE
         iNLNERjcWeydGsVMpoGkg2sxKwRMB2+JU8YrL3FAsf27/USVKXx9RtfRmP6I0cVFxcGW
         /mofoB+Olp2kUq8MFoexBVQ+si11iGlCDsN8LCSnvM3UWafN74tHm2E+7/weARMFnyK7
         5xgeP2JU9mQnkAHrZCz38KEe9+Od/o8seJ8dwqIjeTS5j/8pAiQKyLQcCwGkIL+stkz1
         dOn1wGsbzqIhG+1zVYfTPulPl0CRNa2uEB29kTxPl+aTpV+AoaGxJxbLeq0ILtyeJMsN
         /Opw==
X-Forwarded-Encrypted: i=1; AJvYcCXrG47qD8AO4kJnlYx8ulKSnYhftdlUhWvTBv1NrYV/p8EIOfDD3awn92/KOMylsKuDQ0I/egkFm98LD2Hckyquq75o8b65wKRdXK6T
X-Gm-Message-State: AOJu0Yzv+DANfnebHfXHNJHThRrC5ku9mKO4BKOEOCtYvOLpSkPoIzjp
	JhzeiVbk5RjIYi1khGx11hA+A9zDz1UHYru5pWOxfK6IU+iINLtHBpzuhPIVM/E=
X-Google-Smtp-Source: AGHT+IGMtv8HVwWRPEiqArgymNWPvBUwr6qurZzqfxu3Mj4nvVlxTkqhXoAHfh8+x8lAl+jBNKKXZw==
X-Received: by 2002:a05:620a:29c2:b0:78b:e6f6:737b with SMTP id s2-20020a05620a29c200b0078be6f6737bmr326656qkp.62.1712285648709;
        Thu, 04 Apr 2024 19:54:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id wv18-20020a05620a5a1200b0078be30219d3sm277560qkn.74.2024.04.04.19.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:54:08 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:54:07 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] mm: zswap: do not check the global limit for
 same-filled pages
Message-ID: <20240405025407.GF641486@cmpxchg.org>
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-6-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405013547.1859126-6-yosryahmed@google.com>

On Fri, Apr 05, 2024 at 01:35:47AM +0000, Yosry Ahmed wrote:
> When storing same-filled pages, there is no point of checking the global
> zswap limit as storing them does not contribute toward the limit Move
> the limit checking after same-filled pages are handled.
> 
> This avoids having same-filled pages skip zswap and go to disk swap if
> the limit is hit. It also avoids queueing the shrink worker, which may
> end up being unnecessary if the zswap usage goes down on its own before
> another store is attempted.
> 
> Ignoring the memcg limits as well for same-filled pages is more
> controversial. Those limits are more a matter of per-workload policy.
> Some workloads disable zswap completely by setting memory.zswap.max = 0,
> and those workloads could start observing some zswap activity even after
> disabling zswap. Although harmless, this could cause confusion to
> userspace. Remain conservative and keep respecting those limits.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

I'm not sure this buys us enough in practice to justify special-casing
those entries even further. Especially with the quirk of checking
cgroup limits but not the global ones; that would definitely need a
code comment similar to what you have in the changelog; and once you
add that, the real estate this special treatment takes up really
doesn't seem reasonable anymore.

In most cases we'd expect a mix of pages to hit swap. Waking up the
shrinker on a zero-filled entry is not strictly necessary of course,
but the zswap limit has been reached and the system is swapping - a
wakeup seems imminent anyway.

