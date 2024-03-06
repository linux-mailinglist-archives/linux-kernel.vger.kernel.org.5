Return-Path: <linux-kernel+bounces-94707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A28743D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4958282C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AE1CA96;
	Wed,  6 Mar 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEiIuR6A"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5E1BDD8;
	Wed,  6 Mar 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767408; cv=none; b=O4SL5d+pGoJyXgotw3ULYTzniEO/VEEkuz3bBrAUvV8ggFwmBZjYHd+6MD7Tsm2qNEGOEy8iTbeLPz3zdLXt8L+nUjP5sETtbYlcRullEXvp5tS7ZzjZm+5yZlECrWg1clHjsphmTez+7jTZZ516CaJXYpRAeENMB+12SS+GZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767408; c=relaxed/simple;
	bh=1WRbX+TI/TIz5mPHKL1eqQRCErrvtvoQDz6CoaHCImM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnW96kQhx9Ghf7PTX2Yrff/8xb4LFghxp2QVfaMnQf3YJYt8qn82/kG3J71LJMXHh84tGtI8Tid3gOfmJ3xsocmUPQlZDKzXxx95OdvZApCDrYBWnbDdgMHkcgSgcasRMTzKZvWBZdDD7bbWZZcuCLJFL2KIuTUS2FipA1lq2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEiIuR6A; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e5027608a9so138380a34.1;
        Wed, 06 Mar 2024 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709767406; x=1710372206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dMMYy1C3aupt6USp5Zxp+kTQYXfep2asyPktWS87fY=;
        b=KEiIuR6A6TIQ7CdHI12HdWir1DYb8Z/UgwQdgys3ifQFmURliOlSjweYCDT/vQwAnC
         ZtFl3Ohc49jmV4zYVipwISs6DP3BQ+a/iEdScRTo5EG+TdroJx4HzO6se/C2+B5h9+pd
         2D4Ll4l86PbT4CQkpED8DVHGe/tDx/JG2vmiNvJMtriiSCCXXCU9BaJDeHbA0AFmmQ6i
         /Otv8gbXo+OU7K7+gdyVhmPpkQRpoH+Gk3pcZELEh5i+LgGDJPncpITku3vrNrytXJF5
         Ak9wxV4b0VDMK/CXgZDODil5NYEC6u/WL70++3lwQX2Yxgm/bhmE8SePkQ4kdk1Xbyq1
         ebhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767406; x=1710372206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dMMYy1C3aupt6USp5Zxp+kTQYXfep2asyPktWS87fY=;
        b=badUUkGP4DOISL/cyh4jpMR5WWHNA0jHZN7VjJ8N3+he55KUqS3ehrYcAvu4B1AQrJ
         uMTFTnms+Aq9p347Ge13DhQf0VLaFvBH/3oSAvrb/AVT/uXE+HChjkhqjH+qI5vh574m
         BTNfPLydqu64PDbB8B2eRVrQ3ixzRusrWW0lYRaWs/jKVVg68+7dpTpNxAcLECOYEI49
         pgjK7Cq0ZqkFr9n1N3Q4erCjJ0G263G+GBvNieBeWnBW5kEQpO482KPzAlHWhUTKuyq2
         iNtbuO+oTZTAX1mkTCD7k15Z8mLrPdgWq6LuX4GkLNxcWg2zeAQku6u27nDCZYMmQXUN
         Gb7A==
X-Forwarded-Encrypted: i=1; AJvYcCU7j8CZVP5Si85rhRznoyevr1R9JSFZl0d7esfxGhlD99Z3UdQtO1+uMFK/ozQh0vX+dvHpC5CWabixaujbon78iKohNEQOuw6+BMsPPlMzCDwAObPv4RS6Z6YQhNA5w4HsEWgnpO80hy9tWVp57RTBV+cYaM6qa+08UsWTIxSHXg==
X-Gm-Message-State: AOJu0YxAtbs3Tu8wID9I6B6aO2toalrVI5rw/gDJgTuJthBUD4IIHAyd
	Kh+iELlNqn31bvrB11sQy5sJtvSXMfbkMhaDBLQiUTIP4qF9Xq5N
X-Google-Smtp-Source: AGHT+IGHWliYgSSKC0WXGN0v2gdDTPrrnao+wDe6wCKEm4bKb2ryvCmXGErELzFgwPS6w+NW5PWvxA==
X-Received: by 2002:a9d:6958:0:b0:6e4:e900:bb8e with SMTP id p24-20020a9d6958000000b006e4e900bb8emr7282981oto.3.1709767405730;
        Wed, 06 Mar 2024 15:23:25 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id j36-20020a63fc24000000b0059b2316be86sm11415952pgi.46.2024.03.06.15.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:23:25 -0800 (PST)
Date: Wed, 6 Mar 2024 15:23:22 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Song Liu <song@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-ID: <Zej66vQInnDYgpNy@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZejhcP_r5QJZcS6j@bombadil.infradead.org>

On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > Hello all,
> > 
> > This patchset makes it possible to use bpftrace with kprobes on kernels
> > built without loadable module support.
> 
> This is a step in the right direction for another reason: clearly the
> module_alloc() is not about modules, and we have special reasons for it
> now beyond modules. The effort to share a generalize a huge page for
> these things is also another reason for some of this but that is more
> long term.
> 
> I'm all for minor changes here so to avoid regressions but it seems a
> rename is in order -- if we're going to all this might as well do it
> now. And for that I'd just like to ask you paint the bikeshed with
> Song Liu as he's been the one slowly making way to help us get there
> with the "module: replace module_layout with module_memory",
> and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> the EXECMEM stuff would be what we use instead then. Mike kept the
> module_alloc() and the execmem was just a wrapper but your move of the
> arch stuff makes sense as well and I think would complement his series
> nicely.

I apologize for missing that. I think these are the four most recent
versions of the different series referenced from that LWN link:

  a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org/
  b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org/
  c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
  d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgecombe@intel.com/

Song and Mike, please correct me if I'm wrong, but I think what I've
done here (see [1], sorry for not adding you initially) is compatible
with everything both of you have recently proposed above. How do you
feel about this as a first step?

For naming, execmem_alloc() seems reasonable to me? I have no strong
feelings at all, I'll just use that going forward unless somebody else
expresses an opinion.

[1] https://lore.kernel.org/lkml/cover.1709676663.git.jcalvinowens@gmail.com/T/#m337096e158a5f771d0c7c2fb15a3b80a4443226a

> If you're gonna split code up to move to another place, it'd be nice
> if you can add copyright headers as was done with the kernel/module.c
> split into kernel/module/*.c

Silly question: should it be the same copyright header as the original
corresponding module.c, or a new one? I tried to preserve the license
header because I wasn't sure what to do about it.

Thanks,
Calvin

> Can we start with some small basic stuff we can all agree on?
> 
> [0] https://lwn.net/Articles/944857/
> 
>   Luis

