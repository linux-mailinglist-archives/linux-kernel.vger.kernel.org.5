Return-Path: <linux-kernel+bounces-26181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014582DC71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E27282769
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4D1774E;
	Mon, 15 Jan 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXguycoA"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890217981
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368ae75082so5350544f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705333056; x=1705937856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6tUsZcr4kUqrqkGGAs5Qidv+T6ANjTW6bBOWgu5cXs=;
        b=OXguycoABcFUruT1lmYR3az25/ZV927/1ABk8AiCV1QIqCdXy86sXLYauaLZ7F88+J
         PRVyY7jJV49QLNTJPRFd4Eo9oeHnCP/tx6qvwovXt17szyFHUPt9NqZ08GKcv2zFXfK5
         +XgzrnNSLV7IhRMDjQg2rG7R4rrygpHdH1HV+/YxdEAYZNBG58uLuRrGnwCvY6EW8Alt
         GI5Oj7HE8aD2jqz1OBlbLTMN9cuG94DH6Aq0WKS46ibawuARIE4l3pjJTHxHBRPVt4Z7
         +uxmf4DEsmuXqGBOqlpgXDj+L/7JD1oGnVLnOL8QgJhMWP7b2DSVgJJXryGDW8gVME68
         SA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333056; x=1705937856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6tUsZcr4kUqrqkGGAs5Qidv+T6ANjTW6bBOWgu5cXs=;
        b=l+jdHFJIovhf6g7Zbvou+9nl4KK1orZnPx3xEqWiikNgqBCA42N1B7boEIVfZtaqIG
         xv6G5FPisnOx8F90EEwGEZFV3/edCHvfxTLlkTNrx6TQyS6QXbvIgqt4suKGbZUPBg2+
         ltyCx4DrJzv1zpdRqlys76Rba+jgvOHRakLY4Q+JyeoTK/o26VScd78yHdpxswsNilPE
         HIXCkOyLleYLMNhCDzho+IkdafRvtdc1IpKit0S9DGYJZoMt42tq3UKOfbBFs0//Z/cn
         Xx169xMh2D55cNLaKDR7AfdSQDrz2RtYQ1i7n4UTiRd4oIpWMoyOmdQ2HJHF0+RA1RJj
         Ft0g==
X-Gm-Message-State: AOJu0Yy31fmV2vSmgP52unV7EQvHSrrSMpbzYDp30YuDERReuWmf8Cwm
	2QpifRocfuECPU1Z+HoGDkmwQaeDG00H
X-Google-Smtp-Source: AGHT+IH2hqghuuV8f+KFdguqRT/76+9TAI2EgxG7KJ3bMSY9Wht54psKYi1Q7fpTOdarLKbns2nHNQ==
X-Received: by 2002:a05:600c:4f92:b0:40e:5435:bba4 with SMTP id n18-20020a05600c4f9200b0040e5435bba4mr3434481wmq.127.1705333055884;
        Mon, 15 Jan 2024 07:37:35 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d67c6000000b003377bbc2fb3sm12147506wrw.17.2024.01.15.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:37:35 -0800 (PST)
Date: Mon, 15 Jan 2024 15:37:31 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZaVRO76JxaHjPwCi@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
 <20240111161712.1480333-3-vdonnefort@google.com>
 <20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>

On Mon, Jan 15, 2024 at 01:43:03PM +0900, Masami Hiramatsu wrote:
> On Thu, 11 Jan 2024 16:17:09 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > In preparation for allowing the user-space to map a ring-buffer, add
> > a set of mapping functions:
> > 
> >   ring_buffer_{map,unmap}()
> >   ring_buffer_map_fault()
> > 
> > And controls on the ring-buffer:
> > 
> >   ring_buffer_map_get_reader()  /* swap reader and head */
> > 
> > Mapping the ring-buffer also involves:
> > 
> >   A unique ID for each subbuf of the ring-buffer, currently they are
> >   only identified through their in-kernel VA.
> > 
> >   A meta-page, where are stored ring-buffer statistics and a
> >   description for the current reader
> > 
> > The linear mapping exposes the meta-page, and each subbuf of the
> > ring-buffer, ordered following their unique ID, assigned during the
> > first mapping.
> > 
> > Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> > size will remain unmodified and the splice enabling functions will in
> > reality simply memcpy the data instead of swapping subbufs.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index fa802db216f9..0841ba8bab14 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -6,6 +6,8 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/poll.h>
> >  
> > +#include <uapi/linux/trace_mmap.h>
> > +
> >  struct trace_buffer;
> >  struct ring_buffer_iter;
> >  
> > @@ -221,4 +223,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
> >  #define trace_rb_cpu_prepare	NULL
> >  #endif
> >  
> > +int ring_buffer_map(struct trace_buffer *buffer, int cpu);
> > +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> > +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> > +				   unsigned long pgoff);
> > +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
> >  #endif /* _LINUX_RING_BUFFER_H */
> > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > new file mode 100644
> > index 000000000000..bde39a73ce65
> > --- /dev/null
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _TRACE_MMAP_H_
> > +#define _TRACE_MMAP_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > + * @entries:		Number of entries in the ring-buffer.
> > + * @overrun:		Number of entries lost in the ring-buffer.
> > + * @read:		Number of entries that have been read.
> > + * @subbufs_touched:	Number of subbufs that have been filled.
> > + * @subbufs_lost:	Number of subbufs lost to overrun.
> > + * @subbufs_read:	Number of subbufs that have been read.
> > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> > + * @reader.read:	Number of bytes read on the reader subbuf.
> > + * @subbuf_size:	Size of each subbuf, including the header.
> > + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> > + * @meta_page_size:	Size of this meta-page.
> > + * @meta_struct_len:	Size of this structure.
> > + */
> > +struct trace_buffer_meta {
> > +	unsigned long	entries;
> > +	unsigned long	overrun;
> > +	unsigned long	read;
> > +
> > +	unsigned long	subbufs_touched;
> > +	unsigned long	subbufs_lost;
> > +	unsigned long	subbufs_read;
> > +
> > +	struct {
> > +		unsigned long	lost_events;
> > +		__u32		id;
> > +		__u32		read;
> > +	} reader;
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> > +
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> > +};
> > +
> > +#endif /* _TRACE_MMAP_H_ */
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index db73e326fa04..e9ff1c95e896 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -338,6 +338,7 @@ struct buffer_page {
> >  	local_t		 entries;	/* entries on this page */
> >  	unsigned long	 real_end;	/* real end of data */
> >  	unsigned	 order;		/* order of the page */
> > +	u32		 id;		/* ID for external mapping */
> >  	struct buffer_data_page *page;	/* Actual data page */
> >  };
> >  
> > @@ -484,6 +485,12 @@ struct ring_buffer_per_cpu {
> >  	u64				read_stamp;
> >  	/* pages removed since last reset */
> >  	unsigned long			pages_removed;
> > +
> > +	int				mapped;
> > +	struct mutex			mapping_lock;
> > +	unsigned long			*subbuf_ids;	/* ID to addr */
> > +	struct trace_buffer_meta	*meta_page;
> > +
> >  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
> >  	long				nr_pages_to_update;
> >  	struct list_head		new_pages; /* new pages to add */
> > @@ -1542,6 +1549,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> >  	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
> >  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
> >  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> > +	mutex_init(&cpu_buffer->mapping_lock);
> >  
> >  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> >  			    GFP_KERNEL, cpu_to_node(cpu));
> > @@ -5160,6 +5168,23 @@ static void rb_clear_buffer_page(struct buffer_page *page)
> >  	page->read = 0;
> >  }
> >  
> > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > +
> > +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> > +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> > +	WRITE_ONCE(meta->read, cpu_buffer->read);
> > +
> > +	WRITE_ONCE(meta->subbufs_touched, local_read(&cpu_buffer->pages_touched));
> > +	WRITE_ONCE(meta->subbufs_lost, local_read(&cpu_buffer->pages_lost));
> > +	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
> > +
> > +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> > +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> > +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> > +}
> > +
> >  static void
> >  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> > @@ -5204,6 +5229,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> >  	cpu_buffer->lost_events = 0;
> >  	cpu_buffer->last_overrun = 0;
> >  
> > +	if (cpu_buffer->mapped)
> > +		rb_update_meta_page(cpu_buffer);
> > +
> >  	rb_head_page_activate(cpu_buffer);
> >  	cpu_buffer->pages_removed = 0;
> >  }
> > @@ -5418,6 +5446,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
> >  	cpu_buffer_a = buffer_a->buffers[cpu];
> >  	cpu_buffer_b = buffer_b->buffers[cpu];
> >  
> > +	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> 
> Ah, this is not enough to stop snapshot. update_max_tr()@kernel/trace/trace.c
> is used for swapping all CPU buffer and it does not use this function.
> (but that should use this instead of accessing buffer directly...)
> 
> Maybe we need ring_buffer_swap() and it checks all cpu_buffer does not set
> mapping bits.
> 
> Thank you,

How about instead of having ring_buffer_swap_cpu() returning -EBUSY when mapped
we have two functions to block any mapping that trace.c could call?

 int rb_swap_prepare(struct ring_buffer *cpu_buffer)
 {
    mutex_lock(&cpu_buffer->mapping_lock);

    if (!cpu_buffer->mapped)
    	return 0;

    mutex_unlock(&cpu_buffer->mapping_lock);
 }

 int rb_swap_done(struct ring_buffer *cpu_buffer)
 {
    mutex_unlock(&cpu_buffer->mapping_lock);
 }

 int ring_buffer_swap_prepare(struct trace_buffer *buffer, int cpu)
 {
 ...
     
     if (cpu == RING_BUFFER_ALL_CPUS) {
    	 int cpu_i;

         for_each_buffer_cpu(buffer, cpu_i) {
	 	err = rb_swap_prepare(buffer->buffers[cpu_i]);
		if (err)
			break;
	 }

	 if (err)
	    /* Rollback ... */

	 return err;

     } 

     return rb_swap_prepare(buffer->buffers[cpu]);
 }

 void ring_buffer_swap_done(struct trace_buffer *buffer, int cpu)
 {
     if (cpu == RING_BUFFER_ALL_CPUS) {
    	 int cpu_i;

         for_each_buffer_cpu(buffer, cpu_i)
	 	rb_swap_done(buffer->buffers[cpu_i]);
	 return;
     }

     return rb_swap_done(buffer->buffers[cpu]);
 }

[...]

