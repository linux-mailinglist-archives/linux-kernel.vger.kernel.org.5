Return-Path: <linux-kernel+bounces-117765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2F88AF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C163E1C61737
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794F7125C9;
	Mon, 25 Mar 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyIa5T5B"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4560101D5;
	Mon, 25 Mar 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393506; cv=none; b=Lmdm3WaFYT3eC7A4YQJJ3qLBF0QjPx61V6UCXx7CsDmm8iwjLnG2AUptO2pK9hRSxO9UBb7FpoOzVhYF2/NU+Wnp55GMhXlT6i4aZWR9vWnqk5IpUKPp0JxmaNw0mf1y1VCkAkfPw7BZJYrZDFxEx8czbVENsW44kjzfhNn2rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393506; c=relaxed/simple;
	bh=0M6UER/Be3AgeHG2qaIeMusA4U0meGPDWlvX5Xh2Rsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9rpygZbg0+kCV9vrcbNIFgdG69Y4gjNzmBtMwetXzIz10S6WSGMlHdF+q4Ohoa6YgNoG68vAbXurCWaKq9zYvCDg5u5WjhIuMhA0r10smC9lhjYH10Y41LZdhe1b126PuSEIGg6uex+D6OHIE5shkq4nv+CMU7/nA1Y6CfdCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyIa5T5B; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4734ae95b3so423666066b.0;
        Mon, 25 Mar 2024 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393503; x=1711998303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6irC93lHsifgJBZFI2gmlUjMj2fb3xGPj1DjSZMPSd8=;
        b=YyIa5T5B3ag5Sz/qT4IwsgFsesD7Sg3EX5sm3tyd3wUb+8nO/1sS1kNjUe7neYd0Uq
         hUTE/MQyEM+DR9SHURJ4cjUmwA9ohAsKrO+KXYf7XZA/xW80FBtIbKAXWUxWxz6hmMKJ
         xsT8AGQINeGJJbn1b1IF/BEw8neqIJckBaCpBhIYe9nuvLM6t0ZDS/JXeIibt9leGLiL
         IPSZMfDSYbKgNgh6ZGvqzYU0zz19oOBuY3bztCmZPdUj1O2k8NfNb+ZxVB3Suy3Tc1fW
         R2aTgn6KgGMgH2ejsJI7IhMglYpq4C0Qc4Af/bv3mlibzxZZS+m51Hkc199Z4xihxWoe
         x2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393503; x=1711998303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6irC93lHsifgJBZFI2gmlUjMj2fb3xGPj1DjSZMPSd8=;
        b=Lq6PzOA4i54QOBnA+QIxHLYmN68Ij6L7HV0slL6yNS/6m35jXFEEZVhy54JMtlUzS1
         HNmf2U9vS/y2bkQQlzJjQ4Ei1cUzz2WIqB1jwZtsXYZGmZ86pTEgrc1JT593E6fRD7Ca
         aDLtc84QlAIPtnVZri/XCrJ1URkWUTUXSespk8cIiwdiISmyIdn0dfvH1aTiIY8mVBiI
         Hegd3KuxzABlBSEpooOfzXYGxAR4cY104zltjEu3XkJDAOUdWOIL5gzmBB4hgJsjFu0m
         /lJ+vok0D8HonIobIgIl0tT64k0wgsoSUV0DKP6GAc/jqktVP8aMY/2Bp7fx+OFY5gWR
         j7gw==
X-Forwarded-Encrypted: i=1; AJvYcCVIeAfiTR3/3r5zzXi8OOQfTIfWUa7eh+ULP3C3Psc0V/VjX91zKhc7px/2OV0A8xU2uCRAzc2HOLF/ikyMI1U/NREsxNUBlsHu/4qPYTv5FzGXwnzgEnvJ9saAhAmEXpS1Fko2PMRbnAmjiyCUVoG9wWYLIRMEakJsoJF3KBgcsqneGw==
X-Gm-Message-State: AOJu0YxOKhA0DT+0vawDElz8kz8CvD7ee89v1AhtRBVgOVX+5oXY2Hon
	frIs3vPefgpAVJjdyFtoQvrLZSIztRhbUQokV/rWdXWmxw8ukeZKO5GzQwrSZ/Y=
X-Google-Smtp-Source: AGHT+IH3m3cl0SVzbic6j51HofxH6Xl4GYsjrllILu98d7DU4nTVUt9gWXH0UFVwSZJsVyxL4KuJzw==
X-Received: by 2002:a17:907:6d04:b0:a47:4ae0:3bb9 with SMTP id sa4-20020a1709076d0400b00a474ae03bb9mr4650520ejc.23.1711393502898;
        Mon, 25 Mar 2024 12:05:02 -0700 (PDT)
Received: from jonhaslam-mbp ([2620:10d:c092:500::7:3fad])
        by smtp.gmail.com with ESMTPSA id um8-20020a170906cf8800b00a4dac3d3a05sm416082ejb.111.2024.03.25.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:05:02 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:04:59 +0000
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org, 
	bpf@vger.kernel.org, rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <dk3obkyavqgzr2xbpykbz3knwgyxl73acuunocoygbhtz5imhm@mdqdefp6kz3t>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120323.ec3248d330b2755e73a6571e@kernel.org>

Hi Masami,

> > This change has been tested against production workloads that exhibit
> > significant contention on the spinlock and an almost order of magnitude
> > reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, how did you measure the overhead? I think spinlock overhead
> will depend on how much lock contention happens.

Absolutely. I have the original production workload to test this with and
a derived one that mimics this test case. The production case has ~24
threads running on a 192 core system which access 14 USDTs around 1.5
million times per second in total (across all USDTs). My test case is
similar but can drive a higher rate of USDT access across more threads and
therefore generate higher contention.

All measurements are done using bpftrace scripts around relevant parts of
code in uprobes.c and application code.

Jon.

> 
> Thank you,
> 
> > 
> > [0] https://docs.kernel.org/locking/spinlocks.html
> > 
> > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > ---
> >  kernel/events/uprobes.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 929e98c62965..42bf9b6e8bc0 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> >   */
> >  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
> >  
> > -static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
> > +static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> >  
> >  #define UPROBES_HASH_SZ	13
> >  /* serialize uprobe->pending_list */
> > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> >  {
> >  	struct uprobe *uprobe;
> >  
> > -	spin_lock(&uprobes_treelock);
> > +	read_lock(&uprobes_treelock);
> >  	uprobe = __find_uprobe(inode, offset);
> > -	spin_unlock(&uprobes_treelock);
> > +	read_unlock(&uprobes_treelock);
> >  
> >  	return uprobe;
> >  }
> > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> >  {
> >  	struct uprobe *u;
> >  
> > -	spin_lock(&uprobes_treelock);
> > +	write_lock(&uprobes_treelock);
> >  	u = __insert_uprobe(uprobe);
> > -	spin_unlock(&uprobes_treelock);
> > +	write_unlock(&uprobes_treelock);
> >  
> >  	return u;
> >  }
> > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> >  	if (WARN_ON(!uprobe_is_active(uprobe)))
> >  		return;
> >  
> > -	spin_lock(&uprobes_treelock);
> > +	write_lock(&uprobes_treelock);
> >  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> > -	spin_unlock(&uprobes_treelock);
> > +	write_unlock(&uprobes_treelock);
> >  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> >  	put_uprobe(uprobe);
> >  }
> > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> >  	min = vaddr_to_offset(vma, start);
> >  	max = min + (end - start) - 1;
> >  
> > -	spin_lock(&uprobes_treelock);
> > +	read_lock(&uprobes_treelock);
> >  	n = find_node_in_range(inode, min, max);
> >  	if (n) {
> >  		for (t = n; t; t = rb_prev(t)) {
> > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> >  			get_uprobe(u);
> >  		}
> >  	}
> > -	spin_unlock(&uprobes_treelock);
> > +	read_unlock(&uprobes_treelock);
> >  }
> >  
> >  /* @vma contains reference counter, not the probed instruction. */
> > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> >  	min = vaddr_to_offset(vma, start);
> >  	max = min + (end - start) - 1;
> >  
> > -	spin_lock(&uprobes_treelock);
> > +	read_lock(&uprobes_treelock);
> >  	n = find_node_in_range(inode, min, max);
> > -	spin_unlock(&uprobes_treelock);
> > +	read_unlock(&uprobes_treelock);
> >  
> >  	return !!n;
> >  }
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

