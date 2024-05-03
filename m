Return-Path: <linux-kernel+bounces-167886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793838BB0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BA428146D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50B155333;
	Fri,  3 May 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O01tr/VK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8684D9FD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752817; cv=none; b=CuXvEIJFTvogchLjd/p++wX2nOajIWdTWvsreY3uJi1NhmAydcW4fucPdk0Vex7koz3HK5Mth09BzXmLv+6hH5XhQpHyqW2E3RcjvQ0pWKGiYfe7eAXuvmR8nLsaL2sa7+ncIyjJR4p7aLURHqQAmhAFjL1a9RnoNwbKKdt92RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752817; c=relaxed/simple;
	bh=5IVgtL4aJ0me57a7kCn7lZDPhbdpoi/QPMWzYsmskhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtEHkiPVcnuUWHBEYqmP3EV/vHGI47adv+bBPsuyh9xcXFh29cPUtFosmlZpP1vGX5m3cxi28Bv06NX7S78lPPuWsQIy0e1QzRsiqlJSTlYQS5j4/NPsFxM6fVI13tDkyYMj+ckJHvXXsElwPdmhIeiLT7cTAEIAJ2gxBXilXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O01tr/VK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso910419b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714752815; x=1715357615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcAsW/k7mWuKla+1EN1qYHJjgpQ4btbFUwJh8NbV4Jo=;
        b=O01tr/VKj+tUsJXWjt42/F4QBoA3CupXp+PTxp8ydrwaTKS2UiAs0hs0zo1Wldhd9s
         35DeL+1Zk6xPcXMKoMbsqNsTs98unPdiWh+09sXSgFgFqv6iMnIXcR1dyieeJgt2kpSn
         Lvf+Bol3Q/Xdr6QyhGcG9kiMgWhfiXPrXqumylu0kwPqhNKebjEIeGsjnqYorSNnbT7Z
         ixIrje6eON1rt6JXnQjPnWoquHGUEbHu/p/gNKd66Bi58z/5XhGTIaXT4qtnc8PbqQmZ
         AmsE5PmhLb5wVn8vkVzHHDvt0CZyw+jFHh5MsOguAjQfP6oVziBz6s5EfJUTQW/C5l2+
         tQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752815; x=1715357615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcAsW/k7mWuKla+1EN1qYHJjgpQ4btbFUwJh8NbV4Jo=;
        b=upnyppD6N0LCKvwWZtdFJkRjr3b2HYPCsPIV1qNYZCzhlp+g/XZ3pQSwqVQ1mn+wkw
         LZR7eSiI2T8pzP/f4z9pI9zXI/Zqj2Q8hRDbfaJJBOfZYrNfwc8qLZQBRwl5GYoypCxA
         aJdGY8lpMKx6jYEiKKSwFbnUtF1VL1PdkbLAP2JNkcbuTWrQHugeEY9CSiFTGVJTboZy
         OJOld24LmTLMXUym7Qv50cCP8Wi19/OOnf4ROA7qK/4yKUtFch0qiySdHFZ/Rtx73wvg
         Ac81S/lPr2rVLZlKsdAFpTkWeE6uThnKuKhBurB1MjW9aaeFwHKRHNxttozkvJWghCYO
         9xtw==
X-Gm-Message-State: AOJu0YzBiym4pbJwV/g/d0IN0yYF6/LCHiwX73N4S31xgQIhfB6s/rKg
	e1XQkaJGJOUy/L05+7N38any7B5K/CRrbxesA1BWgCcxe0rDF26BMkFnng==
X-Google-Smtp-Source: AGHT+IH1ol6VP1JntVLyeRzj3gSrgzbS7+bfWPmz+60oSjQ15zGThqMkZ+N+lXtOtYPZtAQGdxpvtw==
X-Received: by 2002:a05:6a21:71cb:b0:1ab:b369:7bd3 with SMTP id ay11-20020a056a2171cb00b001abb3697bd3mr3632450pzc.38.1714752815041;
        Fri, 03 May 2024 09:13:35 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id u40-20020a056a0009a800b006ed98adec98sm3232754pfg.76.2024.05.03.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:13:34 -0700 (PDT)
Date: Fri, 3 May 2024 09:13:32 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chin-Chun Chen <n26122115@gs.ncku.edu.tw>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH 3/4] bitops: squeeze even more out of fns()
Message-ID: <ZjUNLAhS2F/Qxt/t@yury-ThinkPad>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-4-yury.norov@gmail.com>
 <ZjRJnvig6EDAaJ5K@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRJnvig6EDAaJ5K@visitorckw-System-Product-Name>

On Fri, May 03, 2024 at 10:19:10AM +0800, Kuan-Wei Chiu wrote:
> +Cc Chin-Chun Chen & Ching-Chun (Jim) Huang
> 
> On Thu, May 02, 2024 at 04:32:03PM -0700, Yury Norov wrote:
> > The function clears N-1 first set bits to find the N'th one with:
> > 
> > 	while (word && n--)
> > 		word &= word - 1;
> > 
> > In the worst case, it would take 63 iterations.
> > 
> > Instead of linear walk through the set bits, we can do a binary search
> > by using hweight(). This would work even better on platforms supporting
> > hardware-assisted hweight() - pretty much every modern arch.
> > 
> Chin-Chun once proposed a method similar to binary search combined with
> hamming weight and discussed it privately with me and Jim. However,
> Chin-Chun found that binary search would actually impair performance
> when n is small. Since we are unsure about the typical range of n in
> our actual workload, we have not yet proposed any relevant patches. If
> considering only the overall benchmark results, this patch looks good
> to me.

fns() is used only as a helper to find_nth_bit(). 

In the kernel the find_nth_bit() is used in
 - bitmap_bitremap((),
 - bitmap_remap(), and
 - cpumask_local_spread() via sched_numa_find_nth_cpu()

with the bit to search calculated as n = n % cpumask_weigth(). This
virtually implies random uniformly distributed n and word, just like
in the test_fns().

In rebalance_wq_table() in drivers/crypto/intel/iaa/iaa_crypto_main.c
it's used like:
        
         for (cpu = 0; cpu < nr_cpus_per_node; cpu++) {
                   int node_cpu = cpumask_nth(cpu, node_cpus);
                   ...
         }

This is an API abuse, and should be rewritten with for_each_cpu()

In cpumask_any_housekeeping() at arch/x86/kernel/cpu/resctrl/internal.h
it's used like:

 90         hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
 91         if (hk_cpu == exclude_cpu)
 92                 hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
 93 
 94         if (hk_cpu < nr_cpu_ids)
 95                 cpu = hk_cpu;

And this is another example of the API abuse. We need to introduce a new
helper cpumask_andnot_any_but() and use it like:

        hk_cpu = cpumask_andnot_any_but(exclude_cpu, mask, tick_nohz_full_mask).
        if (hk_cpu < nr_cpu_ids)
                 cpu = hk_cpu;

So, where the use of find_nth_bit() is legitimate, the parameters are
distributed like in the test, and I would expect the real-life
performance impact to be similar to the test.

Optimizing the helper for non-legitimate cases doesn't worth the
effort.

Thanks,
Yury

