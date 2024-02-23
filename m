Return-Path: <linux-kernel+bounces-78200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D490861020
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B92891F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEEC6312D;
	Fri, 23 Feb 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF7PUfVr"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653D5D48A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686386; cv=none; b=sDU4b7tJqk1gDA1osVxOTQbHhfXJRZsy+0Q3Xf8Us2bTgbmmf1m+LCZNhnl1pjHJhDUopwuQ1DjoEFuewwmS4uHS8ue3K6Xi2z4PL0cxHpVEXN2eCOUSC7wUyKg1INqpILi/kOYwgZmIchdLeVmXMQxjZzu9sJIbcGcevKBGQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686386; c=relaxed/simple;
	bh=WOa2B/adfohPnjhm2DxwiU5JKTplsQ4FAPI6663AvTA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1y7r7mOb/hkqcAWWypsGB3o1SMhxQ/VMNQGN+6e659lrVPU660k0GeHL9w9B2+SaDHXjwtV6DhVWwn8TthCPY4IHEPVf/DDixnxb7pmG3UaItINJSjVK+m67aCS48dTpsTsABPnFzld/aoG3RLvXca9R1QesHKJqhIXIR51rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF7PUfVr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512ab55fde6so235876e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708686382; x=1709291182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jI1VvqgC35LAf15S3x3Yl5nucZ+rRIUoziAzKnZ3XY8=;
        b=SF7PUfVrMhaUDhTNNQfbsyPI4lCQhT4yzXuroCsnQ8mPeukPHjnKQ2PVxk8rD13M0w
         HITbKQafkYW/aLTcn1I5riKVY+JDHgWRpCai0xgCf23iY2lt8i/N4vD/BYURTplfNQXv
         o1Hm/qNR2gGU/AoZIsH5b48VATIa2bSFUqhNPKP8FLCikW4hwY+5EN6hU4JzqKJS71GR
         PRyXVjCn/BxXljomynjsqvrrNXAGaTUnyIeKaUCBDJEMx9XkR48E4NtveYMFez0ag8LY
         MQVEngym1jbmM0ZnEe5P6PGipEqBwKmD8q6QiYRKmSJAVPmI3ETl/FDOTEbuM8s3+ccG
         Pgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686382; x=1709291182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jI1VvqgC35LAf15S3x3Yl5nucZ+rRIUoziAzKnZ3XY8=;
        b=J417zyXQWKdOnhsFryULrzQMIL7qhEdyBRb187UEmOj94E0ARrqVy+1728yefnWx4E
         YXBR40sNw0qLnuWEdPwWQgpeEbSj7IdKGfNBaAI5yRJ9J5IApsgx0Q1/FZ/l7/W4N1WL
         ZQtAAaiD5/aSS5CBi6D+6e1xyFOBZ12gBfLNyKp/byXAdNpF4YyAUluTMCNtceEQlbQu
         DwCzUbETm1XCOj2KLrNqrEKjduqcEUllBp2mhG5wihDwWQrDBeTPIoVhIx2aV05Gqrox
         FjrlvD5ehRlk1u4jbvUyB1f2XISpNP9SsOgMoa0hh3tlh5rlE+i4JNFOrRzwy9+CbQPA
         0BZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFM8YquangB7ucrrHPYGlvggoXkZeqTPjBA03pYq1gIEpcQ+0zCPcSb3x5KjKF4GAJlHW+ybinD7HwskDS1Ul6ubwQZdSJfh8qkVTD
X-Gm-Message-State: AOJu0Yz+hBDxP+EjrBJJIsoW5pl9D+DVM3QowNXS/LSv3xRyIDHocea8
	dsMc+877c/D4rZrUT6VXct3Uo237LR0zE/B6yIDCnWF748bEPoJE
X-Google-Smtp-Source: AGHT+IEMAkg4Bat8ffHRPoKV22DBGZujIXXjCBbz4rfjX1ukK3lmgzCg1l6NUcCe/BJGgwqYJKUdog==
X-Received: by 2002:a05:6512:69:b0:512:9af5:d083 with SMTP id i9-20020a056512006900b005129af5d083mr1091322lfo.60.1708686381379;
        Fri, 23 Feb 2024 03:06:21 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id b22-20020ac247f6000000b005118e37462asm2390083lfp.89.2024.02.23.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:06:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 23 Feb 2024 12:06:18 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <Zdh8KmZtoQym7Syz@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
 <ZdhmrEmA8wOuVcQT@pc636>
 <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>

> On 02/23/24 at 10:34am, Uladzislau Rezki wrote:
> > On Thu, Feb 22, 2024 at 11:15:59PM +0000, Pedro Falcato wrote:
> > > Hi,
> > > 
> > > On Thu, Feb 22, 2024 at 8:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > Hello, Folk!
> > > >
> > > >[...]
> > > > pagetable_alloc - gets increased as soon as a higher pressure is applied by
> > > > increasing number of workers. Running same number of jobs on a next run
> > > > does not increase it and stays on same level as on previous.
> > > >
> > > > /**
> > > >  * pagetable_alloc - Allocate pagetables
> > > >  * @gfp:    GFP flags
> > > >  * @order:  desired pagetable order
> > > >  *
> > > >  * pagetable_alloc allocates memory for page tables as well as a page table
> > > >  * descriptor to describe that memory.
> > > >  *
> > > >  * Return: The ptdesc describing the allocated page tables.
> > > >  */
> > > > static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> > > > {
> > > >         struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > > >
> > > >         return page_ptdesc(page);
> > > > }
> > > >
> > > > Could you please comment on it? Or do you have any thought? Is it expected?
> > > > Is a page-table ever shrink?
> > > 
> > > It's my understanding that the vunmap_range helpers don't actively
> > > free page tables, they just clear PTEs. munmap does free them in
> > > mmap.c:free_pgtables, maybe something could be worked up for vmalloc
> > > too.
> > >
> > Right. I see that for a user space, pgtables are removed. There was a
> > work on it.
> > 
> > >
> > > I would not be surprised if the memory increase you're seeing is more
> > > or less correlated to the maximum vmalloc footprint throughout the
> > > whole test.
> > > 
> > Yes, the vmalloc footprint follows the memory usage. Some uses cases
> > map lot of memory.
> 
> The 'nr_threads=256' testing may be too radical. I took the test on
> a bare metal machine as below, it's still running and hang there after
> 30 minutes. I did this after system boot. I am looking for other
> machines with more processors.
> 
> [root@dell-r640-068 ~]# nproc 
> 64
> [root@dell-r640-068 ~]# free -h
>                total        used        free      shared  buff/cache   available
> Mem:           187Gi        18Gi       169Gi        12Mi       262Mi       168Gi
> Swap:          4.0Gi          0B       4.0Gi
> [root@dell-r640-068 ~]# 
> 
> [root@dell-r640-068 linux]# tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> Run the test with following parameters: run_test_mask=127 nr_threads=256
> 
Agree, nr_threads=256 is a way radical :) Mine took 50 minutes to
complete. So wait more :)


--
Uladzislau Rezki

