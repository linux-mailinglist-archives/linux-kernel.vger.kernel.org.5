Return-Path: <linux-kernel+bounces-24450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2882BCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81760B24549
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBEF55C32;
	Fri, 12 Jan 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDUWT0PU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD556B64
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e5f746ac4so18700825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705050787; x=1705655587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1EgXaRaTUet4TEXGVTFAunKXdsXPqv3B+ZztFe87RQ=;
        b=bDUWT0PUubl7IXlxAdtKF3qx7UDYNhmM9ngSGTI4oC5FjLp9K1XRSMU09GUoCBhEKC
         gyxWSOT86xZpZQtnkuNIqPhbOv84UFvtATfBfBYZq9Rgzhwjrn+4Z0Yg6tyGxNEzW/wh
         1U/gZKGDQJY9MZfvV4nuXYCkRZZ4VQglmF+YJStr9uohI8lRS1l2RXonDWwS+fZMNKoW
         HQTva2zDtsLwVs1dxbvs1/IHP8hz5jAkuyfbLgkqSVgFkGEWoUnrc66YLNioFY0xwRwl
         XzqTCpSla/Fac2ob7oM27qptDQt/r/IZVSj3SwuudQrzb73HP0LDG2c1tjI6LjB0QOu+
         3+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050787; x=1705655587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1EgXaRaTUet4TEXGVTFAunKXdsXPqv3B+ZztFe87RQ=;
        b=AxTORA4J7I+5wOyuekcfqgoxYarsm9lGbS2mWEnzCGrdm0WUTbFGFIT9E04qKZszUK
         V4seeLXdpNMCeIYuh/7aPtR5WFcxg0HqLU9EmctgWD2R/UdAfxeITkLU+34h7V+mm7RE
         RGRWGzQ5la5gx0ZKgn82tey2l08SXi3U80havWD4ZBrn5bBYB+sKheD6mM0sdy91QUSk
         PQMQKvnjWlDPWjBriN2A7x0Yq/WXeUYiRNHevRFnzJb6RvXtugB8NX18xHOM+ikl9Ns4
         KxSYhs61pyB2GwPtcof7xW/lg1fHwEvSt9BuljHQF0hs2wS8M0Nrg+Fyjg5iXq2ccCxy
         H0Qg==
X-Gm-Message-State: AOJu0Yx/FfGJ9S7wLoq4wUcit6FClQvyHJU59ppmorkpD6fAJRUGPO7D
	jVMWhrr2vNTy0j3kP6rBCgW4rpzds9DScz1m9MhBEOnTTXpT
X-Google-Smtp-Source: AGHT+IFdVEbldrn6GQS2XfH/1UYqKPpyHh+bndsCodBDUSD8g0kbmLd8FP3JUwTXDMwF9sy7py/nGw==
X-Received: by 2002:a05:600c:4589:b0:40e:43ab:4a1d with SMTP id r9-20020a05600c458900b0040e43ab4a1dmr612027wmo.163.1705050786878;
        Fri, 12 Jan 2024 01:13:06 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id az8-20020a05600c600800b0040e49045e0asm4991094wmb.48.2024.01.12.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:13:06 -0800 (PST)
Date: Fri, 12 Jan 2024 09:13:02 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZaECnv7EJHo6sqcT@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
 <20240111161712.1480333-3-vdonnefort@google.com>
 <c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
 <20240111181814.362c42cf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111181814.362c42cf@gandalf.local.home>

On Thu, Jan 11, 2024 at 06:23:20PM -0500, Steven Rostedt wrote:
> On Thu, 11 Jan 2024 11:34:58 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
> > The LTTng kernel tracer has supported mmap'd buffers for nearly 15 years [1],
> > and has a lot of similarities with this patch series.
> > 
> > LTTng has the notion of "subbuffer id" to allow atomically exchanging a
> > "reader" extra subbuffer with the subbuffer to be read. It implements
> > "get subbuffer" / "put subbuffer" ioctls to allow the consumer (reader)
> > to move the currently read subbuffer position. [2]
> > 
> > It would not hurt to compare your approach to LTTng and highlight
> > similarities/differences, and the rationale for the differences.
> > 
> > Especially when it comes to designing kernel ABIs, it's good to make sure
> > that all bases are covered, because those choices will have lasting impacts.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > [1] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_mmap.c
> > [2] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_vfs.c
> > 
> 
> Hi Mathieu,
> 
> Thanks for sharing!
> 
> As we discussed a little bit in the tracing meeting we do somethings
> differently but very similar too ;-)
> 
> The similarities as that all the sub-buffers are mapped. You have a
> reader-sub-buffer as well.
> 
> The main difference is that you use an ioctl() that returns where to find
> the reader-sub-buffer, where our ioctl() is just "I'm done, get me a new
> reader-sub-buffer". Ours will update the meta page.
> 
> Our meta page looks like this:
> 
> > +struct trace_buffer_meta {
> > +	unsigned long	entries;
> > +	unsigned long	overrun;
> > +	unsigned long	read;
> 
> If start tracing: trace-cmd start -e sched_switch and do:
> 
>  ~ cat /sys/kernel/tracing/per_cpu/cpu0/stats 
> entries: 14
> overrun: 0
> commit overrun: 0
> bytes: 992
> oldest event ts: 84844.825372
> now ts: 84847.102075
> dropped events: 0
> read events: 0
> 
> You'll see similar to the above.
> 
>  entries = entries
>  overrun = overrun
>  read = read
> 
> The above "read" is total number of events read.
> 
> Pretty staight forward ;-)
> 
> 
> > +
> > +	unsigned long	subbufs_touched;
> > +	unsigned long	subbufs_lost;
> > +	unsigned long	subbufs_read;
> 
> Now I'm thinking we may not want this exported, as I'm not sure it's useful.

touched and lost are not useful now, but it'll be for my support of the
hypervisor tracing, that's why I added them already.

subbufs_read could probably go away though as even in that case I can track that
in the reader.

> 
> Vincent, talking with Mathieu, he was suggesting that we only export what
> we really need, and I don't think we need the above. Especially since they
> are not exposed in the stats file.
> 
> 
> > +
> > +	struct {
> > +		unsigned long	lost_events;
> > +		__u32		id;
> > +		__u32		read;
> > +	} reader;
> 
> The above is definitely needed, as all of it is used to read the
> reader-page of the sub-buffer.
> 
> lost_events is the number of lost events that happened before this
> sub-buffer was swapped out.
> 
> Hmm, Vincent, I just notice that you update the lost_events as:
> 
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
> 
> The lost_events may need to be handled differently, as it doesn't always
> get cleared. So it may be stale data.

My idea was to check this value after the ioctl(). If > 0 then events were lost
between the that ioctl() and the previous swap.

But now if with "[PATCH] ring-buffer: Have mmapped ring buffer keep track of
missed events" we put this information in the page itself, we can get rid of
this field.

> 
> 
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> 
> This gets is the information needed to read the mapped ring buffer.
> 
> > +
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> 
> The ring buffer gets mapped after "meta_page_size" and this structure is
> "meta_struct_len" which will change if we add new data to it.
> 
> > +};
> 
> -- Steve

