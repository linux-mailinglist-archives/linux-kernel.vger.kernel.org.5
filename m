Return-Path: <linux-kernel+bounces-61349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF52851159
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F341C223D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F53A1CB;
	Mon, 12 Feb 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpJJTyYc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452323A1AE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734678; cv=none; b=jF9hLZj9FFd5Fbno5x73ZwkgRLfoE81qyMqQQfHanZRYaUeeu7J8+YEWk8GouRpOy4ZEhB7T9DXbz07h4Mfk97jt3dAprL2wJaa1WPk6EWW2eMhWZU7FX2dbuoN4Z0lOPz3D6WBh3+h2LgebkoUmK0A0wmK/M+frfSUKFdCwPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734678; c=relaxed/simple;
	bh=wpbRiMI6NAMuncX9fLMTsZd5Gm9ZakHAkP2CSO0EoZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2RwDivO2aT7a+XKymdPJUfwMPSWtdM+hJymDS1WQswS57JkqhoKMT6o3YzCYbg3/OwX94fyp8Jb+6e6Mo+YwKXTAHJs5HqXf5VaGN5yGjp9pwotrCw8FBbjnzmNd2XaHtFPpoRNPSveQFEjfm2h0Tcp/klDMlGyJUwGHbRWeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpJJTyYc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a17f3217aso388981566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707734674; x=1708339474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDJcRx4776rwIg7Cp6jkKLHIjuAeaTwhHWx6DnEvb0Q=;
        b=IpJJTyYc+lGY2NUhYzV2RTYPnRab7RcDu6t/bvWi2DgrUvoZmwyWBUBVHZPltCOZOj
         wam8RSK8emSEiL5iMH0mTfMCAr50q7l6jfVxvgSD5ruhSBoHNaoKTyeme1LP4f4Zmurv
         XTbkEiLWuuMdpwqYbkrecKI5xX3eWG5CN6fbVwg6lpOnQKmGSRvnM0+7cu20XmYARPd+
         bsjR+iKYUtJQkFLofAuj/JdvJFiQKO2daESHtt47fhOrj2kiSskoVj7PzOnxRkn+nWkF
         KE4hSK2TywUvhXhYzuBDf5eQfmKHvxybnU5ithXNlZcsN78TV40bX5i+/RfrrEn3Y8CN
         FNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734674; x=1708339474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDJcRx4776rwIg7Cp6jkKLHIjuAeaTwhHWx6DnEvb0Q=;
        b=UeeP/7RZpFvX7FJORcQXIhux1Vtybp4DO1sbxI6CQwruBabWwuAA4oDQag/1EQJ0L5
         cegrWWUuANpJIYnp1liDYtu8Ea261oUucMeTglWwLCuEqJPGysMJykZtEI5I7LdqD/0U
         ircN7ChEDplmc8xMf4HqpNQHHI49cWM6O+J3+dnVN8po5PsjBV0iWeVwK2PMp2oq47CX
         wTnjIG51UGW1gVaOyLel7SzL3kw6wRIVNrEq28iRgFN3BZTOuunm/2uE6NGOyjxEzAwc
         TXTLAFGhlrZT5r5K6R3mPIzW9I9OF+8gBKiE1KEJOEoASNZVUviyAfuPgeYLdiTabrex
         WmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1crCPDre9lVQo4vwDqfJUtD0Pwanx153mWO/HIyqoVIKGLGboQuh2j7y2oJ1Tgb7oZ4iz/BtWOP6DlOJh0FQEcLLA2k8HWZ5I4WAM
X-Gm-Message-State: AOJu0YzajV0GnO42toV3vcpkmD3BYqaXrvT+YU++haOPQfQ32I9kLgkH
	hH/euv1vGZVhlImiBcNN+zUSbGAdJA3LvuHEZK1LqsXSO4/S+y7OE6Vz1QlJqw==
X-Google-Smtp-Source: AGHT+IE1mvcBn0onlKXCRL3qsI7ANWcNjzII0Rg2/q7n4hUvUMmWwuSyXJX+NL3UR+MOzcNaXhTedQ==
X-Received: by 2002:a17:906:cb10:b0:a37:7f72:574c with SMTP id lk16-20020a170906cb1000b00a377f72574cmr3860590ejb.68.1707734674324;
        Mon, 12 Feb 2024 02:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxGJ8WqgL94+y/AvFtUXyeVhyk+Dyxcc8hx/OWGr0WY4ionbq7KMQ55zUb82v/R/VzicKNmjYXWqI1Y83GuaFCWr1diM9932XCSooDPJ/dB2QP5xCUVI17Ofc5srsXl+NfhjyhCnNYcgUN5hvu01DQOD5IoF4yR3Wv4TphkxdY75aY10wYJL/bmu+Mx1/J8DF29+m53e5GuTp21oPAu8LBblo8Qukclbnt
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id tj2-20020a170907c24200b00a3cc29e4b89sm72837ejc.131.2024.02.12.02.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:44:33 -0800 (PST)
Date: Mon, 12 Feb 2024 10:44:26 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v16 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Zcn2iotAnIWT4F_O@google.com>
References: <20240209163448.944970-1-vdonnefort@google.com>
 <20240209163448.944970-3-vdonnefort@google.com>
 <20240211171837.6a4ea1a5@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211171837.6a4ea1a5@rorschach.local.home>

[...]

> > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > +
> > +	meta->reader.read = cpu_buffer->reader_page->read;
> > +	meta->reader.id = cpu_buffer->reader_page->id;
> > +	meta->reader.lost_events = cpu_buffer->lost_events;
> > +
> > +	meta->entries = local_read(&cpu_buffer->entries);
> > +	meta->overrun = local_read(&cpu_buffer->overrun);
> > +	meta->read = cpu_buffer->read;
> > +
> > +	/* Some archs do not have data cache coherency between kernel and user-space */
> > +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> > +}
> > +
> >  static void
> >  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> > @@ -5204,6 +5227,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> >  	cpu_buffer->lost_events = 0;
> >  	cpu_buffer->last_overrun = 0;
> >  
> > +	if (READ_ONCE(cpu_buffer->mapped))
> 
> Isn't the buffer_mutex held when we modify mapped? I believe it's held
> here. I don't think we need a READ_ONCE() here. Is there a reason for it?
> 
> Hmm, looking down, it looks like you take the buffer->mutex after
> setting mapped, is that necessary? If we take the buffer->mutex we can
> sync the reset with mapping.

The idea was to not take any of the buffer mutex, reader lock if the refcount is
simply inc/dec. Locks are only used if the meta-page is
installed/uninstalled.

The WRITE_ONCE/READ_ONCE is there only to make sure no compiler optimisation
could lead a reader to wrongly interpret that refcount while it is inc/dec. That
is probably not necessary and I'm happy to either drop it completely or replace
it by taking buffer mutex and reader lock whenever the refcount is inc/dec.

> 
> > +		rb_update_meta_page(cpu_buffer);
> > +
> >  	rb_head_page_activate(cpu_buffer);
> >  	cpu_buffer->pages_removed = 0;
> >  }
> > @@ -5418,6 +5444,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
> >  	cpu_buffer_a = buffer_a->buffers[cpu];
> >  	cpu_buffer_b = buffer_b->buffers[cpu];
> >  
> > +	/* It's up to the callers to not try to swap mapped buffers */
> > +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> >  	/* At least make sure the two buffers are somewhat the same */
> >  	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
> >  		goto out;
> > @@ -5682,7 +5714,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  	 * Otherwise, we can simply swap the page with the one passed in.
> >  	 */
> >  	if (read || (len < (commit - read)) ||
> > -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> > +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> > +	    READ_ONCE(cpu_buffer->mapped)) {
> 
> Here the buffer_mutex isn't held, but still, what's the purpose of the READ_ONCE?
> 
> I wonder if we just grab the reader_lock when setting the mapped
> variable if that would be better than using READ/WRITE_ONCE, which I'm
> not sure is helpful.

ditto above.
> 
> 
> >  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
> >  		unsigned int rpos = read;
> >  		unsigned int pos = 0;
> > @@ -5901,6 +5934,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  
> >  		cpu_buffer = buffer->buffers[cpu];
> >  
> > +		if (READ_ONCE(cpu_buffer->mapped)) {
> > +			err = -EBUSY;
> > +			goto error;
> > +		}
> > +
> >  		/* Update the number of pages to match the new size */
> >  		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
> >  		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> > @@ -6002,6 +6040,304 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  }
> >  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
> >  
> > +#define subbuf_page(off, start) \
> > +	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
> > +
> > +#define foreach_subbuf_page(sub_order, start, page)		\
> > +	page = subbuf_page(0, (start));				\
> > +	for (int __off = 0; __off < (1 << (sub_order));		\
> > +	     __off++, page = subbuf_page(__off, (start)))
> > +
> > +static inline void subbuf_map_prepare(unsigned long subbuf_start, int order)
> > +{
> > +	struct page *page;
> > +
> > +	/*
> > +	 * When allocating order > 0 pages, only the first struct page has a
> > +	 * refcount > 1. Increasing the refcount here ensures none of the struct
> > +	 * page composing the sub-buffer is freeed when the mapping is closed.
> > +	 */
> > +	foreach_subbuf_page(order, subbuf_start, page)
> > +		page_ref_inc(page);
> > +}
> > +
> > +static inline void subbuf_unmap(unsigned long subbuf_start, int order)
> > +{
> > +	struct page *page;
> > +
> > +	foreach_subbuf_page(order, subbuf_start, page) {
> > +		page_ref_dec(page);
> > +		page->mapping = NULL;
> > +	}
> > +}
> > +
> > +static void rb_free_subbuf_ids(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	int sub_id;
> > +
> > +	for (sub_id = 0; sub_id < cpu_buffer->nr_pages + 1; sub_id++)
> > +		subbuf_unmap(cpu_buffer->subbuf_ids[sub_id],
> > +			     cpu_buffer->buffer->subbuf_order);
> > +
> > +	kfree(cpu_buffer->subbuf_ids);
> > +	cpu_buffer->subbuf_ids = NULL;
> > +}
> > +
> > +static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	if (cpu_buffer->meta_page)
> > +		return 0;
> > +
> > +	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER | __GFP_ZERO));
> 
> The above is the main reason I'm looking for a v17. If that
> alloc_page() fails, what exactly is going to be returned here? 
> 
> #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
> #define __va(x)                     ((void *)((unsigned long)(x)+PAGE_OFFSET))
> 
> I don't think that will be the result you expect. We need to do the
> alloc_page(), test the result of that, and then call page_to_virt() on a
> page that is not NULL.

Ouch, you're right!

> 
> > +	if (!cpu_buffer->meta_page)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
> > +
> 
> I'm thinking for extra safety we could add:
> 
> 	if (!addr)
> 		return;
> 
> So this function could be called twice without issue.

Ack.

> 
> > +	virt_to_page((void *)addr)->mapping = NULL;
> > +	free_page(addr);
> > +	cpu_buffer->meta_page = NULL;
> > +}
> > +
> > +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> > +				   unsigned long *subbuf_ids)
> > +{
> > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> > +	struct buffer_page *first_subbuf, *subbuf;
> > +	int id = 0;
> > +
> > +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> > +	subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
> > +	cpu_buffer->reader_page->id = id++;
> > +
> > +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> > +	do {
> > +		if (id >= nr_subbufs) {
> > +			WARN_ON(1);
> > +			break;
> > +		}
> 
> 		if (WARN_ON(id >= nr_subbufs))
> 			break;
> 
> > +
> > +		subbuf_ids[id] = (unsigned long)subbuf->page;
> > +		subbuf->id = id;
> > +		subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
> > +
> > +		rb_inc_page(&subbuf);
> > +		id++;
> > +	} while (subbuf != first_subbuf);
> > +
> > +	/* install subbuf ID to kern VA translation */
> > +	cpu_buffer->subbuf_ids = subbuf_ids;
> > +
> > +	meta->meta_page_size = PAGE_SIZE;
> > +	meta->meta_struct_len = sizeof(*meta);
> > +	meta->nr_subbufs = nr_subbufs;
> > +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> > +
> > +	rb_update_meta_page(cpu_buffer);
> > +}
> > +
> > +static inline struct ring_buffer_per_cpu *
> > +rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	mutex_lock(&cpu_buffer->mapping_lock);
> > +
> > +	if (!cpu_buffer->mapped) {
> > +		mutex_unlock(&cpu_buffer->mapping_lock);
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	return cpu_buffer;
> > +}
> > +
> > +static inline void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> > +{
> > +	mutex_unlock(&cpu_buffer->mapping_lock);
> > +}
> > +
> > +int ring_buffer_map(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	unsigned long flags, *subbuf_ids;
> > +	int err = 0;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return -EINVAL;
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	mutex_lock(&cpu_buffer->mapping_lock);
> 
> Is there a reason not to take the buffer->mutex before setting mapped?
> 
> > +
> > +	if (cpu_buffer->mapped) {
> > +		if (cpu_buffer->mapped == UINT_MAX)
> > +			err = -EBUSY;
> > +		else
> > +			WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
> 
> As mentioned before, it may be better to take the reader_lock when
> setting mapped and that should add the protection we want with mapped
> set and other readers.
> 
> > +		mutex_unlock(&cpu_buffer->mapping_lock);
> > +		return err;
> > +	}
> > +
> > +	/* prevent another thread from changing buffer/sub-buffer sizes */
> > +	mutex_lock(&buffer->mutex);
> > +
> > +	err = rb_alloc_meta_page(cpu_buffer);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/* subbuf_ids include the reader while nr_pages does not */
> > +	subbuf_ids = kzalloc(sizeof(*subbuf_ids) * (cpu_buffer->nr_pages + 1),
> > +			   GFP_KERNEL);
> 
> Instead use:
> 
> 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
> 
> > +	if (!subbuf_ids) {
> > +		rb_free_meta_page(cpu_buffer);
> > +		err = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	atomic_inc(&cpu_buffer->resize_disabled);
> > +
> > +	/*
> > +	 * Lock all readers to block any subbuf swap until the subbuf IDs are
> > +	 * assigned.
> > +	 */
> > +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +
> > +	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> > +	cpu_buffer->mapped = 1;
> > +
> > +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > +unlock:
> > +	mutex_unlock(&buffer->mutex);
> > +	mutex_unlock(&cpu_buffer->mapping_lock);
> > +
> > +	return err;
> > +}
> > +
> > +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	unsigned long flags;
> > +	int err = 0;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return -EINVAL;
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	mutex_lock(&cpu_buffer->mapping_lock);
> > +
> > +	if (!cpu_buffer->mapped) {
> > +		err = -ENODEV;
> > +		goto out;
> > +	} else if (cpu_buffer->mapped > 1) {
> > +		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&buffer->mutex);
> > +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +
> > +	cpu_buffer->mapped = 0;
> > +
> > +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > +
> > +	rb_free_subbuf_ids(cpu_buffer);
> > +	rb_free_meta_page(cpu_buffer);
> > +	atomic_dec(&cpu_buffer->resize_disabled);
> > +
> > +	mutex_unlock(&buffer->mutex);
> > +out:
> > +	mutex_unlock(&cpu_buffer->mapping_lock);
> > +
> > +	return err;
> > +}
> > +
> > +/*
> > + *   +--------------+  pgoff == 0
> > + *   |   meta page  |
> > + *   +--------------+  pgoff == 1
> > + *   | subbuffer 0  |
> > + *   +--------------+  pgoff == 1 + (1 << subbuf_order)
> > + *   | subbuffer 1  |
> > + *         ...
> > + */
> > +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> > +				   unsigned long pgoff)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> > +	unsigned long subbuf_id, subbuf_offset, addr;
> > +	struct page *page;
> > +
> > +	if (!pgoff)
> > +		return virt_to_page((void *)cpu_buffer->meta_page);
> > +
> > +	pgoff--;
> > +
> > +	subbuf_id = pgoff >> buffer->subbuf_order;
> > +	if (subbuf_id > cpu_buffer->nr_pages)
> > +		return NULL;
> > +
> > +	subbuf_offset = pgoff & ((1UL << buffer->subbuf_order) - 1);
> > +	addr = cpu_buffer->subbuf_ids[subbuf_id] + (subbuf_offset * PAGE_SIZE);
> > +	page = virt_to_page((void *)addr);
> > +
> > +	return page;
> > +}
> > +
> > +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	unsigned long reader_size;
> > +	unsigned long flags;
> > +
> > +	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
> > +	if (IS_ERR(cpu_buffer))
> > +		return (int)PTR_ERR(cpu_buffer);
> > +
> > +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +consume:
> > +	if (rb_per_cpu_empty(cpu_buffer))
> > +		goto out;
> > +
> > +	reader_size = rb_page_size(cpu_buffer->reader_page);
> > +
> > +	/*
> > +	 * There are data to be read on the current reader page, we can
> > +	 * return to the caller. But before that, we assume the latter will read
> > +	 * everything. Let's update the kernel reader accordingly.
> > +	 */
> > +	if (cpu_buffer->reader_page->read < reader_size) {
> > +		while (cpu_buffer->reader_page->read < reader_size)
> > +			rb_advance_reader(cpu_buffer);
> > +		goto out;
> > +	}
> > +
> > +	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
> > +		goto out;
> > +
> > +	goto consume;
> > +out:
> > +	rb_update_meta_page(cpu_buffer);
> > +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > +	rb_put_mapped_buffer(cpu_buffer);
> > +
> 
> Hmm, there's no protection here. If this task gets preempted for a long
> time, it is possible that the cpu_buffer->reader_page can become NULL,
> causing a NULL kernel dereference.

Right, this should be behind the reader lock as well :-\

> 
> -- Steve
> 
> 
> > +	/* Some archs do not have data cache coherency between kernel and user-space */
> > +	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * We only allocate new buffers, never free them if the CPU goes down.
> >   * If we were to free the buffer, then the user would lose any trace that was in
> 

