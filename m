Return-Path: <linux-kernel+bounces-78021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7FC860E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291962869FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C85C8F8;
	Fri, 23 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4MyNQ/f"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313917BAC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680885; cv=none; b=qflOgRAELNRbUQuatoVlOJmom21dVvaxjBEU0Fa9dUJPPcaDfCF4EBXuz+cyoUkSRRPt0T2NgLCsdxxbDnM5p7fiy8X/4wxVJhGCJOIZUcWNuyiUGpJD4yQRaIkLdYvVV7GWDyjtaTJrE6b5MEwKHzW+vEnow6XyNBeRNcGdqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680885; c=relaxed/simple;
	bh=NE67qrc8lWeV8ja1PT5ALpzS30uNGFJaTG0AIqAtbew=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfRXTnarch5cID/E7KqWKhln3bqoL7qn+ibWIxtSr4tfLksMR3HgQavNWd9PJAmKdzYJ4ovzYvIxg0/xf4oDZFCRz+s+MwLAUL9DbjYfxAOs4RAL61fmLh5mnr0KR69fgH28wjQVafBjMs5Nb0Q6D6PHR5Cw10WnL36GYaCKkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4MyNQ/f; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512dfa097b1so890247e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708680881; x=1709285681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URjY1d9IzlvjqbTTQXHELWVs3EPiLz70xCmc8FLhHfE=;
        b=I4MyNQ/fMdV9XWLXjAJfqS2RrAG78VersUM0Szno7ZokB2Xb9SbjuDISYWzsKBxq1u
         eGrKHqiHAZUhg9ZmCnOpNQFXeDdxJGmzSeKGry/de9TvnPJeMYcm/PVLGPbxsbxyj6fH
         MzisGgtYjpYX1N60TpRPhykp9VshXjfkDLOoZvsSD5rqwgXrhPvxONbXm1qdCOCyc8cd
         OgA6weyqvMdWNSh6UUdjj77ZrD6lStCXuy3MEgLfuMJVLy+eJLZfRmQydO+8I55nnHyH
         NflPWRLd/690WGoDVrkg/4q5IdtuiPFqSHgtLKmtuouXnDZrBYHJMt1HlRsX60zOfpEn
         vvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680881; x=1709285681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URjY1d9IzlvjqbTTQXHELWVs3EPiLz70xCmc8FLhHfE=;
        b=k2rmz8U2pLmzNg54r7+KuF+XnXTTjqcQT+K6TZ0GL3z8n9ZUp5XGfDiaiOf/U7aZIQ
         pww6lfTtrPaTKFaEXu0g5iDUSE3huXJJA0YZJvzRusJp4maZAGvDnnLsmE3stiCvYL3y
         K1SKf5nF6Yf0n7O9oNLhOoOatfSW7LGVncYxIhBv3g2x15adRJxcFdfQi/e2WSO6JQSv
         1A55ZoXUeIstLDWhZtc47Y48JBPtQK9h9NPtH18rGlvtCVdBX6ERIX+cezTmd6fED8t8
         hCytAW3RuDZiKjnK4kyvfQ16MP0S163prdw9RSyLigw5qiBVq7tV5I7hSHqa9Y/zbChK
         FqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWtKjd78TSPckUoScpJ/ADD5DkNM4x8mtMNAE3BPbyzMFMVQdXXYICwdvUVvDkSvXuZcCbuw4zJvb7y2N17L1u1E0dAYgnf/AZ98x
X-Gm-Message-State: AOJu0YzUfapFenLiOtsRm+/HzP3lrvrFD2htE3HpK8Y9yS9BcG5pjysI
	/Q1gFyYNJeeklpbntD/xOS1Jdm6zMZ+mGEqM/nXRsvXjo7rghIjC
X-Google-Smtp-Source: AGHT+IGJd3oti1UYMtI8P32WOSvRQ26F7V5U1YuI/6f+U1Kr/lA344defddV3yuQs83g91ExLQHN7A==
X-Received: by 2002:a05:6512:1308:b0:512:b915:606a with SMTP id x8-20020a056512130800b00512b915606amr1363676lfu.12.1708680881156;
        Fri, 23 Feb 2024 01:34:41 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id z6-20020ac25de6000000b005119498ba1dsm2389717lfq.198.2024.02.23.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:34:40 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 23 Feb 2024 10:34:36 +0100
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <ZdhmrEmA8wOuVcQT@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>

On Thu, Feb 22, 2024 at 11:15:59PM +0000, Pedro Falcato wrote:
> Hi,
> 
> On Thu, Feb 22, 2024 at 8:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > Hello, Folk!
> >
> >[...]
> > pagetable_alloc - gets increased as soon as a higher pressure is applied by
> > increasing number of workers. Running same number of jobs on a next run
> > does not increase it and stays on same level as on previous.
> >
> > /**
> >  * pagetable_alloc - Allocate pagetables
> >  * @gfp:    GFP flags
> >  * @order:  desired pagetable order
> >  *
> >  * pagetable_alloc allocates memory for page tables as well as a page table
> >  * descriptor to describe that memory.
> >  *
> >  * Return: The ptdesc describing the allocated page tables.
> >  */
> > static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> > {
> >         struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> >
> >         return page_ptdesc(page);
> > }
> >
> > Could you please comment on it? Or do you have any thought? Is it expected?
> > Is a page-table ever shrink?
> 
> It's my understanding that the vunmap_range helpers don't actively
> free page tables, they just clear PTEs. munmap does free them in
> mmap.c:free_pgtables, maybe something could be worked up for vmalloc
> too.
>
Right. I see that for a user space, pgtables are removed. There was a
work on it.

>
> I would not be surprised if the memory increase you're seeing is more
> or less correlated to the maximum vmalloc footprint throughout the
> whole test.
> 
Yes, the vmalloc footprint follows the memory usage. Some uses cases
map lot of memory.

Thanks for the input!

--
Uladzislau Rezki

