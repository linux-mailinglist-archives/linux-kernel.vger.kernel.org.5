Return-Path: <linux-kernel+bounces-104119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D0C87C934
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13CC28308D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7CB14A8E;
	Fri, 15 Mar 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZycXqO4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189012E63;
	Fri, 15 Mar 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487796; cv=none; b=g6QqKqardfPufTLnQyDbKDCsj2CDzSpMtn7wwmoIm0dbXFgNa5VDyBJ8Q5CkmlBv876LCKzWkCyGtuuAvmx4S+imGkoqxeEc/VkWbpSHh8OTOhsdp4imW1d5a1Evqa/IEnqpbpBb0hLO42t8wnhjd567AaCfa9qIZ83lGNwMZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487796; c=relaxed/simple;
	bh=IRm5n95xEFQDT7vgK1VdLnXSKwBq0y2erx84Ft6GYXM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9FdPgdw8CwBVUaPCdQExXLnVitdB+7keVocR2SGAqHNZm1lqRt/2O7t3D6lmmUO4Ach3ob5uqq1dE33KbMdmu17mxZ5UoXEQbZV6tlxDrpTVYtmLmDnxm8SLoG4MJvJILYtTD/XzEb4tFMLSVPt2h8e4jD7k9A8P+L6PgR6/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZycXqO4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso2043727a12.2;
        Fri, 15 Mar 2024 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710487793; x=1711092593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILoelfoifI7jxVJmz5B8PtvwaNYpiquvncdr9oWkqc0=;
        b=HZycXqO4DgS7mPFbuN8CvjZIZ4/GsdgQ6z6VwEenucb/lm5yqNg4mgSwQO8FU0B6fx
         5+MgC4qKcSWZL3DgJ3IjMk1cB+8BG7d75Idg3LIiQ5/ujFzOE9A2ALZY0Iml/DdT7ybk
         1Wuo1DwJP/V/XSC1UisO73ZZq7qCpddrZExWMIWMbRspt4fsxjDXFw/Esh5wUkzkrxQl
         Op5JXIvC90hYMg50+B9RIHMJfitXiPdDHg8rbBuNwUXr575Sq6KUaZSUT6EBeIIvqlVa
         80pzSoNI1LpoqrT2xeygJv2BBKaY/dA7lcRnzsL/9HVjTS6sVwbEnK/IqRSH+GPCsKI7
         sY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710487793; x=1711092593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILoelfoifI7jxVJmz5B8PtvwaNYpiquvncdr9oWkqc0=;
        b=bNsysmimFdb3icQXDCWXfTe5/BHIbrJpFGC9+6APgMD62kNOUxHwto5q5twLhli/HQ
         aBghHJBwTj/5YHQxd6/KNRqU2qbw3rCY24P5mARHHtE2MnLdOEKEi6eod1YdXKofQQ2z
         72aqY/5YZriZonqxqy7x5cVBKpI/MmdN4Ow+akeo2u0A8vW2vWzQzAFzWaOioXFilivq
         EheSGPP9jAYAB3f47xpPb8MjVe9j2C2V5T3jiTHFfCOvnGkDK/cT7UWkmIQJ2pCvXUUq
         zrNLuS0ZXs8jkL4lGBj8WK2u9aIgYtB06U3StKmXDTvrCflZPNGLJ/SLy9nr5rpv9j8G
         5v6g==
X-Forwarded-Encrypted: i=1; AJvYcCWkOt7Pt7r0ql/G7GK+WzK6wweYxkxw+ZfitvYKgGZbXkvaI38acJn+lPbWUb8m6kXRwN/P0dbdFMBCrU3+uPNLhYBDmLX2g9kXOsYIFFgpbcdWg/vB9YArLvpNlr4RWNXFhLutGfmyKzkQm5ISXcpOTd5rmnMcGQQjN6jiIihH16LDkW/CzOqLFMxnT3dUmirAGgfNow==
X-Gm-Message-State: AOJu0YyZDNWuysath4BwQA+bI/lFemKycbENWlbJFrcHrUrqkDEzjLSt
	KX/DlwRWmVVKgHqPP5qOrxcghpqnaSiNXC0k1/lr34LDFSrx4YdP
X-Google-Smtp-Source: AGHT+IGJ86mFXDqoUu/TpHBtqwtLd+iQ7QPcqhWQfhyfq03s+kI5hJeXzUZlFLQBjFXYzYWC2VWzrA==
X-Received: by 2002:a05:6402:28c9:b0:568:9e92:2847 with SMTP id ef9-20020a05640228c900b005689e922847mr2106432edb.40.1710487793271;
        Fri, 15 Mar 2024 00:29:53 -0700 (PDT)
Received: from pc636 (host-87-9-234-71.retail.telecomitalia.it. [87.9.234.71])
        by smtp.gmail.com with ESMTPSA id i19-20020a1709061cd300b00a466b2aab55sm1440416ejh.79.2024.03.15.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:29:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 15 Mar 2024 08:29:49 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Networking <netdev@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm-stable
 tree
Message-ID: <ZfP47QjBzHwuJOMe@pc636>
References: <20240307123619.159f1c4c@canb.auug.org.au>
 <20240313105117.699dc720@canb.auug.org.au>
 <20240314093012.3dba692a@canb.auug.org.au>
 <ZfLElrAT3RMLuWdB@pc636>
 <CAADnVQJpoBCL6r9BM09-kcMeB4Cm0H0y+UD-i8NX5YtvcCpffw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJpoBCL6r9BM09-kcMeB4Cm0H0y+UD-i8NX5YtvcCpffw@mail.gmail.com>

> > > > This is now a conflict between the net-next tree and the mm-stable tree.
> > >
> > >  ... and now a conflict between te mm-stable tree and Linus' tree.
> > >
> > If you need some help with resolving conflicts i can help. The problem
> > to me looks like:
> >
> > <snip>
> > commit d7bca9199a27b8690ae1c71dc11f825154af7234
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   Fri Mar 8 09:12:54 2024 -0800
> >
> >     mm: Introduce vmap_page_range() to map pages in PCI address space
> >
> > commit e6f798225a31485e47a6e4f6aa07ee9fdf80c2cb
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   Mon Mar 4 19:05:16 2024 -0800
> >
> >     mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
> >
> > commit 3e49a866c9dcbd8173e4f3e491293619a9e81fa4
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   Mon Mar 4 19:05:15 2024 -0800
> >
> >     mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
> > <snip>
> >
> > those three patches were not based on linux-next and are currently
> > in the Linus tree(bypassing mm-tree?). Whereas below work:
> >
> > mm: vmalloc: refactor vmalloc_dump_obj() function
> > mm: vmalloc: improve description of vmap node layer
> > mm: vmalloc: add a shrinker to drain vmap pools
> > mm: vmalloc: set nr_nodes based on CPUs in a system
> > mm: vmalloc: support multiple nodes in vmallocinfo
> > mm: vmalloc: support multiple nodes in vread_iter
> > mm: vmalloc: add a scan area of VA only once
> > mm: vmalloc: offload free_vmap_area_lock lock
> > mm: vmalloc: remove global purge_vmap_area_root rb-tree
> > mm/vmalloc: remove vmap_area_list
> > mm: vmalloc: remove global vmap_area_root rb-tree
> > mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
> > mm: vmalloc: rename adjust_va_to_fit_type() function
> > mm: vmalloc: add va_alloc() helper
> >
> > now should be based on Alexei Starovoitov base in order to resolve
> > a small conflict.
> 
> Pls don't rebase anything.
> 
> > But you better know how to proceed. Just in case, if you need some
> > support please let me know i can help with conflict resolving.
> 
> As Stephen said these two conflict:
> 
> > > >   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
> > > >
> > > >   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().")
> 
> and conflict is trivial. It just looks big due to the indent change.
>
It is solved in the Linus's tree what is good. 

--
Uladzislau Rezki

