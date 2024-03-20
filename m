Return-Path: <linux-kernel+bounces-109250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294D8816CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DC01C2380A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AE6A33C;
	Wed, 20 Mar 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/m0XY6I"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688951E516
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956818; cv=none; b=j0ZDLSNEgvMi1ZhnxFYdpBIin+HtkcP+lRmnMvDhyLVq8u9ssHzaM32bTWc1VDO+cPSToSr7ks+l+nq1yhALsZHrJGBHtuLOjKDNmKHEJsokM7t9c5OK8oQRjpVZ8Pr0fnHT60s0IvaQJofIj+afowAQQwTns/kEilPE+Wb+ALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956818; c=relaxed/simple;
	bh=B368G/aSuup6KMLAq/ltvruGfUzolEoBXSk9TLIMxRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMTPC0BFFaOy9O5n81uZ+Qk5gykuLf6YcIopVWhxL8/u50ZhxqWqL9ViEAiOJDBcZaNwZit0FFVHzhxh1Z0GNP9VozhKk03T3k2xbMRBe4MOTxWi6cEZnE11rlOjduJmJdIF5HeHQjgc7/N5tqGng9EL0t+U8Qkm4ehBzcxxXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/m0XY6I; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so37986276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956816; x=1711561616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32FiX/03woyx1MQPLt98zuuoGWjttuDbK7QooonETTg=;
        b=N/m0XY6I1wc4aYh9QUKA6RbyJM0DVWtieaulK6yy5h87cA4sebUD1m8149SRp0IEyB
         O+mcIxtV3EaXx5cErw8LeOtzs4JzpGfyCiydPhWSA6cVE0xEM33beU3KKtgxlU+zoWf0
         eLlcAPLU6AzR1TdUs+w38Wy0jYl+L1myHjgwg5WGM7jqQVGG2H/gz1njRjTqBKk516is
         mAhNJjrfSTWATRGvngZ50FCI5Q2sTM4Gq7dRaT3skcKIYoYB9bTZG6lBqArFppVxFLA3
         hZ3gsyQZH9YBoHnjH+9+4kp9eyUxKENXXxHA6WJxSDE37+/3nAwN6JWlHYdRTQieHY8b
         UvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956816; x=1711561616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32FiX/03woyx1MQPLt98zuuoGWjttuDbK7QooonETTg=;
        b=PL7S+aQbtwcOsStRKvWge+zpv/2UOycfoXFwzz9pPSoWQJqaSPo7ccu2ThanRpdVAN
         Kyd3g4yceOC9yQWZZ2e2KMnIPcmkIACsl43VyQPHNDXiPRlOW9QIly2TEXmVEc0c19Gq
         O6xwONo5zZ/rlaOMe6Cd1AetWLfrgeYqpJ331SLAPy5fxW9JjyFjZjFF4PXv719navOA
         KxHoLJsiTvGZSn2F5Zmxbbhs+VYSzbUgT3H6O5Hr9AV0yHFtaC23kUZdzOQWz5pNjn4d
         ACbPGyzGFK1NNnLaSpBuZJ/U/dzCX97WbZKEQPYYLBx9IJQkvYK4+9d+gUhGtA/SCIU8
         E7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWa4reiFcFtn75ELnyZhXECpi18tbOPPyBqq8Mae+o13q5mx5vO+NrteKwpYYNiby2JxPARdq0KduZdbDrdv6ELZZj/obheeeWB59kr
X-Gm-Message-State: AOJu0YyWgKilNcXb02AplfkjV/JJtV65Lkdo6N9hQLAJ32lGcKKYHWAc
	0KG/Q71t9GH7OdXSti8OAQozFH8Z52PAtH0a0dxdxkf1nwJWX9t2
X-Google-Smtp-Source: AGHT+IGRLxk/UosGsO9ECz2fz4qrLawBVwi5tDcNLfKn6EFRGCfu1HKk/TcEqeAI9780rkObJJX4+w==
X-Received: by 2002:a25:c78b:0:b0:dcf:c299:2467 with SMTP id w133-20020a25c78b000000b00dcfc2992467mr15358037ybe.5.1710956816247;
        Wed, 20 Mar 2024 10:46:56 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a6a6:49c0:6a02:df54])
        by smtp.gmail.com with ESMTPSA id c15-20020a5b0bcf000000b00dc254858399sm2632978ybr.2.2024.03.20.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:46:55 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:46:54 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Dawei Li <dawei.li@shingroup.cn>, andriy.shevchenko@linux.intel.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: Create dedicated kmem cache for cpumask var
Message-ID: <ZfshDg9Vyfl6hqVG@yury-ThinkPad>
References: <20240319122400.399516-1-dawei.li@shingroup.cn>
 <5a6f58c5-40f3-4c89-8988-a9fee932e3ca@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6f58c5-40f3-4c89-8988-a9fee932e3ca@rasmusvillemoes.dk>

On Wed, Mar 20, 2024 at 10:03:02AM +0100, Rasmus Villemoes wrote:
> On 19/03/2024 13.24, Dawei Li wrote:
> > alloc_cpumask_var_node() and friends allocate cpumask var dynamically
> > for CONFIG_CPUMASK_OFFSTACK=y kernel. The allocated size of cpumask var
> > is cpumask_size(), which is runtime constant after nr_cpu_ids is
> > freezed.
> > 
> > Create a dedicated kmem cache for dynamic allocation of cpumask var.
> 
> Why?

Hi Dawei,

Agree with Rasmus. CPUMASK_OFFSTACK=y is quite a rare configuration,
normally disabled. Can you show the architecture that you're working
with and how the cache you're adding affects performance.
 
> > The window for creation of cache is somewhat narrow:
> > - After last update of nr_cpu_ids(via set_nr_cpu_ids())
> > - After kmem cache is available.
> > - Before any alloc_cpumask_var_node() invocations(sched_init() e.g).

Not only narrow but also not uniform across platforms. For example,
on XEN xen_smp_count_cpus() may adjust nr_cpu_ids. I don't think that
people runn XEN with CPUMASK_OFFSTACK=y, but you have to make sure
that your cache is always created before the 1st allocation.
 
> OK, so this sounds somewhat fragile. It's maybe correct, but I fail to
> see what is gained by this, and the commit message does not provide any
> hints.

Agree. To make it less vulnerable, you have to enforce something like:

  bool cpumask_cache_used = false;

  static inline void set_nr_cpu_ids(unsigned int nr)
  {
          if (WARN_ON(cpumask_cache_used))
                  return;
  
          nr_cpu_ids = nr;
          cpumask_cache_destroy();
          cpumask_cache_init()
  }

  bool alloc_cpumask_var_node()
  {
         cpumask_cache_used = true;
         *mask = kmalloc_node(cpumask_size(), flags, node);
         ...
  }

But at the very first, we need to understand under which scenarios the
new cache would benefit performance?

Thnaks,
Yury
benefits performance 

