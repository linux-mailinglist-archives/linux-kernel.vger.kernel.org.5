Return-Path: <linux-kernel+bounces-153813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771098AD3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E171C20DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE9154428;
	Mon, 22 Apr 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLFFJzKC"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A8153BFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808904; cv=none; b=CZpcUD9aIJaDXWuCSn36KaaXq9WGCPvAFiN3hOyatSfkzRzrc136do6Bq/d3SQFHybSJrE499xLl9rM7NfZQyZv0zAky3twFxqPl7WzXEEDxx0kmzd1Z2A8ZT+mUcmw0MJv1LVGvDcq6CNfNcorUp623OoXtAdB2pgJabAQUII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808904; c=relaxed/simple;
	bh=YSfN8ueuyYYuzCX4lRljyWkmazGxEEUK3JL99PpNfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A74Yr+D5BeiuCTBtpcGoaT/3+sKjaHvrbi6MpsZMcW98+0oCDxO/0PCss/gNuFcofW/tnEiRW3puiZ9muD0VcEgmaJtBFLyPOxog0gFTfNtcdvnzwMDakfbEjxP3y1Y/y419SXCjeZ0fpUZXLVLVMPzc8M4GaLASTUewj+o4nVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLFFJzKC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346b146199eso3611531f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713808901; x=1714413701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shgVcXlk+FVX+bp2BEEUZI/jQ7HfqPQxw3MBWT1z4eE=;
        b=eLFFJzKCJrQ+suKulS+eGKgZIzzUZmA4Bg79y4H7cF8wS8qN9fny9QikCEpVr0c8MT
         OJ6kw4bu/PYUZUD1EsyaV+LKU1oOkvzG3bBDq5V7GMBhn7s5ykZtAoFiwKw4Rg/JROQf
         Cf2RIo+vvPmbeItX5/cE4kuMWuYVnYjttZwnYqiCZMEX7dUXCK3NzdEW+ccbkeEXa8vZ
         +7bNVOKrVTZyhaY1ViHRBdaj1hmJiAU40xwaqwG7ngzVDtVMqtpGlFUb3YhLYLBhNPF2
         x68P3P9BcQnHeqG6hMfh/Y6br4hk7zZFcR9WgXLSNNLs/mCvqB5/7XpON1/2XlLxK9Lo
         YGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808901; x=1714413701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shgVcXlk+FVX+bp2BEEUZI/jQ7HfqPQxw3MBWT1z4eE=;
        b=W9SMXWECrdHFLstUwn9m8cFm9MjXi0kaE9i0byR1rnjyy4QMoVGuMT5syO5uWXVpnB
         99Qh8UOQrd7zIdfslMYme4oEVa0Q3hCgxi7vbBWdRY1gS7hhESlSJAvh410lPo6io37L
         xMU+LgtgU9jQ+jNK9E86RMPhdyIsQH1PCwPTBprWNCKNVSDIkucYTLBARBEuTv6Xwshm
         BHyRJDZkMSUIo3lJAZq5Zg0wD8uXzHrGOHU+9vFbsM4LyQwKliM1OVrwC03BNtzkST02
         0NcH+gVgjHzaEcPM5WHYAfrgLKS+StLrj574T5usDOP2QFysGpzE76QLSrcexvaBCR4J
         khsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVucvjJPZBBbPhkOQmPD8Rw5g/6qz8NbbVefUixzCmKVOPOSn5hX2k2cecIy2HojSunZ4KvpdPCqlWLnh5amPrTNxM6qJa/wPzIz4K
X-Gm-Message-State: AOJu0Yx/Hqc6lF9hePka3vg+9gVFB0SxaT8IYEpqk4yjoXvG5KAdXjWD
	HmhePmXneWbhTJjhOH1Hi+CZ/b5roopD3spQQ12WAT0VEkYJWfaWeyK6nR7zSLOm0QRt1JxwWYZ
	rbliM
X-Google-Smtp-Source: AGHT+IE1x5f0XDD/zKcEj2pcGFDgnFjkg4FljkbTL4ZetbAyg3XH2QZFW68srkdrdsyfH3ihUuN/4w==
X-Received: by 2002:adf:e392:0:b0:34a:7066:d2c6 with SMTP id e18-20020adfe392000000b0034a7066d2c6mr5764355wrm.50.1713808900564;
        Mon, 22 Apr 2024 11:01:40 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003456c693fa4sm12540223wrz.93.2024.04.22.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:01:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:01:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZiamAPliL82FU-hC@google.com>
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
 <ZiDD-wdGIjOBcQ2U@kernel.org>
 <20240418234346.4b4cb4dc@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418234346.4b4cb4dc@rorschach.local.home>

On Thu, Apr 18, 2024 at 11:43:46PM -0400, Steven Rostedt wrote:
> On Thu, 18 Apr 2024 09:55:55 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> Hi Mike,
> 
> Thanks for doing this review!
> 
> > > +/**
> > > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > > + * @meta_page_size:	Size of this meta-page.
> > > + * @meta_struct_len:	Size of this structure.
> > > + * @subbuf_size:	Size of each sub-buffer.
> > > + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
> > > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > > + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
> > > + * @reader.read:	Number of bytes read on the reader subbuf.
> > > + * @flags:		Placeholder for now, 0 until new features are supported.
> > > + * @entries:		Number of entries in the ring-buffer.
> > > + * @overrun:		Number of entries lost in the ring-buffer.
> > > + * @read:		Number of entries that have been read.
> > > + * @Reserved1:		Reserved for future use.
> > > + * @Reserved2:		Reserved for future use.
> > > + */
> > > +struct trace_buffer_meta {
> > > +	__u32		meta_page_size;
> > > +	__u32		meta_struct_len;
> > > +
> > > +	__u32		subbuf_size;
> > > +	__u32		nr_subbufs;
> > > +
> > > +	struct {
> > > +		__u64	lost_events;
> > > +		__u32	id;
> > > +		__u32	read;
> > > +	} reader;
> > > +
> > > +	__u64	flags;
> > > +
> > > +	__u64	entries;
> > > +	__u64	overrun;
> > > +	__u64	read;
> > > +
> > > +	__u64	Reserved1;
> > > +	__u64	Reserved2;  
> > 
> > Why do you need reserved fields? This structure always resides in the
> > beginning of a page and the rest of the page is essentially "reserved".
> 
> So this code is also going to be used in arm's pkvm hypervisor code,
> where it will be using these fields, but since we are looking at
> keeping the same interface between the two, we don't want these used by
> this interface.
> 
> We probably should add a comment about that.
> 
> > 
> > > +};
> > > +
> > > +#endif /* _TRACE_MMAP_H_ */
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index cc9ebe593571..793ecc454039 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c  
> > 
> > ... 
> > 
> > > +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> > > +				   unsigned long *subbuf_ids)
> > > +{
> > > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > > +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> > > +	struct buffer_page *first_subbuf, *subbuf;
> > > +	int id = 0;
> > > +
> > > +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> > > +	cpu_buffer->reader_page->id = id++;
> > > +
> > > +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> > > +	do {
> > > +		if (WARN_ON(id >= nr_subbufs))
> > > +			break;
> > > +
> > > +		subbuf_ids[id] = (unsigned long)subbuf->page;
> > > +		subbuf->id = id;
> > > +
> > > +		rb_inc_page(&subbuf);
> > > +		id++;
> > > +	} while (subbuf != first_subbuf);
> > > +
> > > +	/* install subbuf ID to kern VA translation */
> > > +	cpu_buffer->subbuf_ids = subbuf_ids;
> > > +
> > > +	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
> > > +	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;  
> > 
> > Isn't this a single page?
> 
> One thing we are doing is to make sure that the subbuffers are aligned
> by their size. If a subbuffer is 3 pages, it should be aligned on 3
> page boundaries. This was something that Linus suggested.
> 
> > 
> > > +	meta->meta_struct_len = sizeof(*meta);
> > > +	meta->nr_subbufs = nr_subbufs;
> > > +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> > > +
> > > +	rb_update_meta_page(cpu_buffer);
> > > +}  
> > 
> > ...
> > 
> > > +#define subbuf_page(off, start) \
> > > +	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
> > > +
> > > +#define foreach_subbuf_page(sub_order, start, page)		\  
> > 
> > Nit: usually iterators in kernel use for_each
> 
> Ah, good catch. Yeah, that should be changed. But then ...
> 
> > 
> > > +	page = subbuf_page(0, (start));				\
> > > +	for (int __off = 0; __off < (1 << (sub_order));		\
> > > +	     __off++, page = subbuf_page(__off, (start)))  
> > 
> > The pages are allocated with alloc_pages_node(.. subbuf_order) are
> > physically contiguous and struct pages for them are also contiguous, so
> > inside a subbuf_order allocation you can just do page++.
> > 
> 
> I'm wondering if we should just nuke the macro. It was there because of
> the previous implementation did things twice. But now it's just done
> once here:
> 
> +	while (s < nr_subbufs && p < nr_pages) {
> +		struct page *page;
> +
> +		foreach_subbuf_page(subbuf_order, cpu_buffer->subbuf_ids[s], page) {
> +			if (p >= nr_pages)
> +				break;
> +
> +			pages[p++] = page;
> +		}
> +		s++;
> +	}
> 
> Perhaps that should just be:
> 
> 	while (s < nr_subbufs && p < nr_pages) {
> 		struct page *page;
> 		int off;
> 
> 		page = subbuf_page(0, cpu_buffer->subbuf_ids[s]);
> 		for (off = 0; off < (1 << subbuf_order); off++, page++, p++) {
> 			if (p >= nr_pages)
> 				break;
> 
> 			pages[p] = page;
> 		}
> 		s++;
> 	}
> 
>  ?

Yeah, was hesitating to kill it with the last version. Happy to do it for the
next one.

> 
> -- Steve

