Return-Path: <linux-kernel+bounces-110455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD26885F25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7043A1C23D65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE664134CEF;
	Thu, 21 Mar 2024 16:57:11 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936702BB0A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040231; cv=none; b=PlAsqzBN9KZO+97ox30PwELq2+jgefovMwA2T+92hZoRAhT6cJ38lU85T9oOIadTLqw5Yf8XonOj2fX4a35kFcYJ0cDyzyyOY5qHK8fhj/LJboA8A+kQBDa58x0Gmn0se/d3Tf+xPHMTXcb4e8MuGhIYSDrxuAg8smd/9TRf9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040231; c=relaxed/simple;
	bh=Q4Vo7dY5LPdXaK2TNIIIt1Y10h8Od3JzFqfVFaPcOCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUqNGZxsTZPtmDB7jY5T6fYj82gLktn1Q5ElFjHrlqLgh4NRJGxYQjJx/gZ9IH9H5I1wrMTjQF+6AbpL4spxEt+Kr7Hwm7xsXQ1zuuqW6N0LJK4UU274j7Os1vr0qc0MeDJ0Xo9lhfOg0IX7kOEIXDYMpkbZnhymx/8yAQLtn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a104601dcso12695007b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040228; x=1711645028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKTbYwQ5gcXN3TRRJ5BC/ttApNw9m6DYa4ZEIkNEXPQ=;
        b=pEzTqe9+ULU7uB6qxcXVJk7aPXjfGYm/lQlUF4q+blEJ4yFwQaR7CB9cGm/kFW7lB/
         4xnrSPfzT+uJOp+sRhfZZDytOYf5v4bxyWCXkAkCbV2MSREezjkjpR8iH030fwhemwKe
         uzl4a/hi6pJ2f2ZX9FnnJ7nHKVuuXPl5FgPm/+wghKnTjmBZo4Gqf0N5brPhH2orbMV3
         /bzmNs+pj9gL34yP9XNBLRh+EL0SskJqW3t7oMWvY8noyQHUB0nMFQ1vNg7S64AkmZEA
         6zpTA+b6/4WnS+lNB4olxVqSmto2sa+jxuM7z0XTJSctPlfjb/JVo6hCn6VWHgF85nBI
         ZzQg==
X-Forwarded-Encrypted: i=1; AJvYcCXI6qchwjOXi4B19MTjRY1xnAMF4z+pozbX+M/Ze56rPQYj7Zi8zdrvlZLQkM/P6GZehVhVSbzPYwhIF8gSW+aOTKOFVdRTEBg7r8l2
X-Gm-Message-State: AOJu0YzUmexDsCdhbN+mIkAW8WRd4U5f76RdzoraRNxf4b9R8mmTADTF
	yHUf8DKI/GGp5m7n4AttcsB5YI39qSOjqpRrh24YehfBf5DeoO56
X-Google-Smtp-Source: AGHT+IE07hS1rv0Ld5GU41nHwA0qGGdhPzZKRg/h5j1OAB2Q9YTWqw8kONtdL3LlAT5Ov2WRcnAGeg==
X-Received: by 2002:a0d:cdc5:0:b0:610:f906:d6c2 with SMTP id p188-20020a0dcdc5000000b00610f906d6c2mr4628198ywd.5.1711040228515;
        Thu, 21 Mar 2024 09:57:08 -0700 (PDT)
Received: from V92F7Y9K0C (fixed-187-190-174-151.totalplay.net. [187.190.174.151])
        by smtp.gmail.com with ESMTPSA id w125-20020a818683000000b0060cccc8a7b9sm7004ywf.69.2024.03.21.09.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:57:08 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:57:05 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] percpu: clean up all mappings when pcpu_map_pages() fails
Message-ID: <Zfxm4e42VaAH2eMJ@V92F7Y9K0C>
References: <20240311194346.2291333-1-yosryahmed@google.com>
 <CAJD7tkYy=e_qkpu64y57o1cWs7RN7PwWgPoFamJu1YDjj_s=kw@mail.gmail.com>
 <Zfn2Uql1Jg92CQeP@snowbird>
 <CAJD7tkYRnCkP39gOHtfpxTpz_ntx47dz48pFes9dHunnmy7Xtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYRnCkP39gOHtfpxTpz_ntx47dz48pFes9dHunnmy7Xtw@mail.gmail.com>

On Tue, Mar 19, 2024 at 01:49:17PM -0700, Yosry Ahmed wrote:
> On Tue, Mar 19, 2024 at 1:32 PM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Hi Yosry,
> >
> > On Tue, Mar 19, 2024 at 01:08:26PM -0700, Yosry Ahmed wrote:
> > > On Mon, Mar 11, 2024 at 12:43 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
> > > > __pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
> > > > were created, but not on the CPU where __pcpu_map_pages() fails.
> > > >
> > > > __pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
> > > > vmap_pages_range_noflush() and vunmap_range_noflush(). All other callers
> > > > of vmap_pages_range_noflush() call vunmap_range_noflush() when mapping
> > > > fails, except pcpu_map_pages(). The reason could be that partial
> > > > mappings may be left behind from a failed mapping attempt.
> > > >
> > > > Call __pcpu_unmap_pages() for the failed CPU as well in
> > > > pcpu_map_pages().
> > > >
> > > > This was found by code inspection, no failures or bugs were observed.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > Any thoughts about this change? Should I resend next week after the
> > > merge window?
> > >
> >
> > Sorry for the delay.
> >
> > I'm looking at the code from mm/kmsan/hooks.c kmsan_ioremap_page_range().
> > It seems like __vunmap_range_noflush() is called on error for
> > successfully mapped pages similar to how it's being done in percpu-vm.c.
> 
> You  picked an unconventional example to compare against :)
> 
> >
> > I haven't read in depth the expectations of vmap_pages_range_noflush()
> > but on first glance it doesn't seem like percpu is operating out of the
> > ordinary?
> 
> I was looking at vm_map_ram(), vmap(), and __vmalloc_area_node(). They
> all call vmap_pages_range()-> vmap_pages_range_noflush().
> 
> When vmap_pages_range() fails:
> - vm_map_ram() calls
> vm_unmap_ram()->free_unmap_vmap_area()->vunmap_range_noflush().
> - vmap() calls vunmap()->remove_vm_area()->free_unmap_vmap_area()->
> vunmap_range_noflush().
> - __vmalloc_area_node() calls
> vfree()->remove_vm_area()->free_unmap_vmap_area()->
> vunmap_range_noflush().
> 

Okay so I had a moment to read it more closely. If we're mapping > 1
pages, and one of the latter pages fails. Then we could leave some
mappings installed.

@Andrew, I think this makes sense. Would you please be able to pick this
up? I'm not running a tree this window. I will try to send out the percpu
hotplug changes I've been forward porting for a while now and try to get
that in a branch for-6.10.

Acked-by: Dennis Zhou <dennis@kernel.org>

> I think it is needed to clean up any leftover partial mappings. I am
> not sure about the kmsan example though.
> 

Yeah the kmsan example seems like it could be wrong for the same reason,
but I haven't inspected that more closely.

Thanks,
Dennis

> Adding vmalloc reviewers here as well here.
> >
> >
> > > > ---
> > > >
> > > > Perhaps the reason __pcpu_unmap_pages() is not currently being called
> > > > for the failed CPU is that the size and alignment requirements make sure
> > > > we never leave any partial mappings behind? I have no idea. Nonetheless,
> > > > I think we want this change as that could be fragile, and is
> > > > inconsistent with other callers.
> > > >
> > > > ---
> > > >  mm/percpu-vm.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > > > index 2054c9213c433..cd69caf6aa8d8 100644
> > > > --- a/mm/percpu-vm.c
> > > > +++ b/mm/percpu-vm.c
> > > > @@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
> > > >         return 0;
> > > >  err:
> > > >         for_each_possible_cpu(tcpu) {
> > > > -               if (tcpu == cpu)
> > > > -                       break;
> > > >                 __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
> > > >                                    page_end - page_start);
> > > > +               if (tcpu == cpu)
> > > > +                       break;
> > > >         }
> > > >         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
> > > >         return err;
> > > > --
> > > > 2.44.0.278.ge034bb2e1d-goog
> > > >

