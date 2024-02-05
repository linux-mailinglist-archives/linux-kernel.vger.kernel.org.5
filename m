Return-Path: <linux-kernel+bounces-52337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3A8496DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CAC286F44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF86134BF;
	Mon,  5 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3IMwIOO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E4134B7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126245; cv=none; b=aVlh09P5Hv37QTmk8o8qaZVqZ7ctvUAd0HIiLSqpuoiuvuiCZWbR9xe/q+Bo4TVWl0kKSKto6ltEfsVhogCPrNrRPWGApWn0AM/V0mVFPv/nWSPWR2BIawHX0AeEywu4l9kv2XEnbstp4Ya4OHHZXkwrigD63IoJgQ9WQJIN7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126245; c=relaxed/simple;
	bh=+yO2XqpyNgbvfc/TzbsFxkAniaErxMeuh58ZQ25HP88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljzcmzXWptVqtX8rMf8eYUNdI67WUPMasdctbfhHlGThKZM6i15urF3ugv2a278L5/FtJNo0o+yFAx77vPppaqFngNjMg+y6uloGkEKuqdGvjQQzPD3ZYJc4BBmnvE4xA6LXXZ+Oil8w3cWZiVIgBfd9weHtbZDBINtUZ/w6ndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3IMwIOO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fd72f71f8so5581245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707126241; x=1707731041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10BvlSMBOf9L9WLyXGyppPxhsknZ/PTNIDqct2oe/RY=;
        b=M3IMwIOOVPqpCCWejLCdKt5h98OTXYRo4MeCUy2pLfHODx6Nl+3Q95OzXpD4Jabc9p
         cXU7haPM3x8BdIOLYqFp4SBP55x4QIddjAxgcCZO6apYcc0XMQMJk5ijIdj0CFIfxJmT
         7TG//tUARSfF9VlweFrEktdieKN2C3kQAw3HHUTeiU8frekHBgd/rXGPkRhpfM4JlUcd
         bxWLCb8muebcJBTqTr0rbr/o4PEGkY7IeRd4acZY+f8FNCbWZcwZvxdo8fks130pgHJv
         ZpYtmgpfMjfYsUR3RzuRjajLq6HIuL35pICljMtww6dG2bmP0+LKQjH0jEgtYgfOADVe
         n1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126241; x=1707731041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10BvlSMBOf9L9WLyXGyppPxhsknZ/PTNIDqct2oe/RY=;
        b=Xgc7UnKHtF1jLhKjI3cixewU4b5ZEqk1m5cWWC2BXDHE1t3Vy8JwGYyLN+SmfeBGoK
         E7vHQJyKlJKS+9/4B/hxVWb+zCq8Em/bGixbYmD0h2tMP2JGNIT50EB+ZWKG6Cimml/x
         /zDzI7PepWOmSnSxh9w5IGGeEDLnCjS6PfEFMsDZzHA5ZV/NonsginRL6h17h6n1I78J
         J2hVkUvgiYhVXcAwaR/kdZQ9rbxAZI4M1K9E8rx7ngsXk7dGOuYX1k+REJKKfKHQQhnb
         8zZ+jHD+vP0aJKHkcohaQ/hAbONLyk4hvpcR29SqGUVHMeVR9vb8OIVcgLV7gbMnwchm
         L15g==
X-Gm-Message-State: AOJu0YwsBjWzYyIIiuT72eSHEfZuKogqkvsptqEwowTp/qSBh+utm2Qp
	ansLRYJqFlPCO930D4fAYVJr/cz7pXMVMKIk7wQF7uC506M638FSfcliWsyhvQ==
X-Google-Smtp-Source: AGHT+IG57hSnEtL5HNUd+F6pM2/xUxxBNY/XxQni86ftTiBIdaM4ODjwVxglQWvQnbVa7YOfRVj/WQ==
X-Received: by 2002:a05:600c:4ec9:b0:40e:fb74:c514 with SMTP id g9-20020a05600c4ec900b0040efb74c514mr3697897wmq.7.1707126241361;
        Mon, 05 Feb 2024 01:44:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPAZ+NrGCEUjPrlYnpnZfjMPyCmuW+1SJ8CuE4hbzCoPzygRgIDUwn5QLPZrdL7x2V2csRUuveuvmXScAVdblgH9ZIracKB5oQryZSw/ZL0mtZBSFa5sEGMxHBpjaeet5f1YH0iUe15Hy/65c+iHaLvEr5BxVmCIqSfFdOVHxM7Z/SPb+HZ02aF2hv18x9G+44SlkxZFpxLMKDhfIvuauZaFTnun9UlMWI
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b00337d6f0013esm7622180wru.107.2024.02.05.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:44:01 -0800 (PST)
Date: Mon, 5 Feb 2024 09:43:57 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v13 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZcCt3U11JeiZOyPn@google.com>
References: <20240129142802.2145305-1-vdonnefort@google.com>
 <20240129142802.2145305-3-vdonnefort@google.com>
 <20240203193351.76bbdda9@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203193351.76bbdda9@rorschach.local.home>

On Sat, Feb 03, 2024 at 07:33:51PM -0500, Steven Rostedt wrote:
> On Mon, 29 Jan 2024 14:27:58 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > --- /dev/null
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _TRACE_MMAP_H_
> > +#define _TRACE_MMAP_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > + * @meta_page_size:	Size of this meta-page.
> > + * @meta_struct_len:	Size of this structure.
> > + * @subbuf_size:	Size of each subbuf, including the header.
> 
> That is "the header"?

I mean the header of the "bpage". But that is confusing. I'll either remove that
mention or just say it is aligned with the order of a system page size.

> 
> > + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> > + * @reader.read:	Number of bytes read on the reader subbuf.
> 
> Note, flags needs a comment.
> 
> > + * @entries:		Number of entries in the ring-buffer.
> > + * @overrun:		Number of entries lost in the ring-buffer.
> > + * @read:		Number of entries that have been read.
> 
> So does the two Reserved words, otherwise I'm going to start getting
> error reports about sparse warnings that check kerneldoc comments
> against their content. Every field needs to be represented in the
> kerneldoc comment.

Ack, wasn't sure it was needed.

> 
> -- Steve
> 
> 
> > + */
> > +struct trace_buffer_meta {
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> > +
> > +	struct {
> > +		__u64	lost_events;
> > +		__u32	id;
> > +		__u32	read;
> > +	} reader;
> > +
> > +	__u64	flags;
> > +
> > +	__u64	entries;
> > +	__u64	overrun;
> > +	__u64	read;
> > +
> > +	__u64	Reserved1;
> > +	__u64	Reserved2;
> > +};
> > +
> > +#endif /* _TRACE_MMAP_H_ */

