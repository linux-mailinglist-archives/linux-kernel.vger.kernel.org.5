Return-Path: <linux-kernel+bounces-108108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7673880610
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916A0283D17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557D3BBDE;
	Tue, 19 Mar 2024 20:32:24 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A23BBC3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880343; cv=none; b=aY/M5YmcQe9U06LOD/nj0jO/fBYbfXhuq+jHSQ7gP3ca7qUk+/wddqwgwVSRMLhNr/NcfapMSaQgLQ8B33f7UyCuQHSDMigjWHJnD6Ia5Hbo380LFkmwt+Y87dirQnoyQu2UXe1ilH6D+c3ZK5GBJyqV0DogQISv3paOsMCrlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880343; c=relaxed/simple;
	bh=EMLp1+AZYFKwkONSx51D5aDWX8IbSkVTn2ghSPtZlFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpPeVb7TOYi2AlgNlfW+D1npchNKE2v8KZGxcjzxDnb2OoVReD9125ZlogkHXBeXxnkeE2NjJq39dSEYsIxmp8WP4zLizOQFni3JPPppPDBVPD+EVBPVva0f4BzvoGoqkgi7MlrN4wzWGKvh7LhTjtNoVx+fJsbDcIwuZ7E/AQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso1751261a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880341; x=1711485141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KpQzMjXI0Yv3/BNRBtGRI4E8RSFpkxd6SwFqIqcab8=;
        b=dwlbSWdk4ZYi+5KbhyMChWT8Oo75GPK7bHRX/t/yu0KfiqFcut0PLQNpCECXOBEzcp
         +WCS7lUWKlEoFEDd5OYvvEpteye81I8oBuwjhkiofxjoSk70EGkRWaV51bD+zipqpxV2
         dhuKeW2+j2ZME660sDAf/UO8Mn2fmDp9qMW5SJwFSDYKWJ+5rmDT1ry+hwmHtITv0NXd
         p1WShFNSjinWrfaIQczw2j9SCuqrTP2rz3SHFWsXp3zcaFurjzggxwFJR6LIR1yPDwFA
         xM0txklG2Iwr8703iP1VRbeAKb5RPI4vGE13QL6GsD3nKphcAylW6p8ZWfscL7MG5xj0
         C3bw==
X-Forwarded-Encrypted: i=1; AJvYcCXYh7hYPd2xr5h8W0wjtL0vmFKiNOKcciVvBQU6nGn8VyCKpB7hQU3mPC3Zrt5DEQHOg5HG2SVET+Vv4y+2cruP3VATkrj3sXWCqKY+
X-Gm-Message-State: AOJu0YzNN0k6HkJNHG9gk8eJYCO/4m1zV+94hhfZs2Or3wbMts0/EvdL
	eFJkTqbtTJUysZ0XMxZvh5anFr0eYjF/pfxR6RphV27ZMkRCgAjR
X-Google-Smtp-Source: AGHT+IHtpJkCQ4y2PoN+9HUP/W7tuddf1QEQuFGhgli3smn15s99C3eX7yz5exBhgBcW8pcIySraWA==
X-Received: by 2002:a17:90a:1f4b:b0:29c:74a4:72b3 with SMTP id y11-20020a17090a1f4b00b0029c74a472b3mr11798121pjy.8.1710880341295;
        Tue, 19 Mar 2024 13:32:21 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id rs12-20020a17090b2b8c00b00299101c1341sm9955900pjb.18.2024.03.19.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:32:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:32:18 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: clean up all mappings when pcpu_map_pages() fails
Message-ID: <Zfn2Uql1Jg92CQeP@snowbird>
References: <20240311194346.2291333-1-yosryahmed@google.com>
 <CAJD7tkYy=e_qkpu64y57o1cWs7RN7PwWgPoFamJu1YDjj_s=kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYy=e_qkpu64y57o1cWs7RN7PwWgPoFamJu1YDjj_s=kw@mail.gmail.com>

Hi Yosry,

On Tue, Mar 19, 2024 at 01:08:26PM -0700, Yosry Ahmed wrote:
> On Mon, Mar 11, 2024 at 12:43 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
> > __pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
> > were created, but not on the CPU where __pcpu_map_pages() fails.
> >
> > __pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
> > vmap_pages_range_noflush() and vunmap_range_noflush(). All other callers
> > of vmap_pages_range_noflush() call vunmap_range_noflush() when mapping
> > fails, except pcpu_map_pages(). The reason could be that partial
> > mappings may be left behind from a failed mapping attempt.
> >
> > Call __pcpu_unmap_pages() for the failed CPU as well in
> > pcpu_map_pages().
> >
> > This was found by code inspection, no failures or bugs were observed.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Any thoughts about this change? Should I resend next week after the
> merge window?
> 

Sorry for the delay.

I'm looking at the code from mm/kmsan/hooks.c kmsan_ioremap_page_range().
It seems like __vunmap_range_noflush() is called on error for
successfully mapped pages similar to how it's being done in percpu-vm.c.

I haven't read in depth the expectations of vmap_pages_range_noflush()
but on first glance it doesn't seem like percpu is operating out of the
ordinary?

Thanks,
Dennis

> > ---
> >
> > Perhaps the reason __pcpu_unmap_pages() is not currently being called
> > for the failed CPU is that the size and alignment requirements make sure
> > we never leave any partial mappings behind? I have no idea. Nonetheless,
> > I think we want this change as that could be fragile, and is
> > inconsistent with other callers.
> >
> > ---
> >  mm/percpu-vm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index 2054c9213c433..cd69caf6aa8d8 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
> >         return 0;
> >  err:
> >         for_each_possible_cpu(tcpu) {
> > -               if (tcpu == cpu)
> > -                       break;
> >                 __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
> >                                    page_end - page_start);
> > +               if (tcpu == cpu)
> > +                       break;
> >         }
> >         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
> >         return err;
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >

