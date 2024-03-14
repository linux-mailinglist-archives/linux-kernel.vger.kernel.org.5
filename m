Return-Path: <linux-kernel+bounces-103324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C587BE13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED2D1C211F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B26EB4B;
	Thu, 14 Mar 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="s+8dfp8o"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB5C5F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424388; cv=none; b=TZ5Qw2BOciZpZe7DIPTGVkhUWenmZSq4ReP7VjUM3O7DQ3i5P4rYnTNqccBrOT8/VfestmRnfA+s4YLGZSEFoYW8uxx/xEKlgg6hxd6+0m0fs9F6zLg7kCJnr01oM8Viude/rTmkf3zVNY0idC4mrQQTdOH5yNYiDnLKAZxR3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424388; c=relaxed/simple;
	bh=JLVebvTemgm2DMTBFylq41rCSroLoQJOOk4UqmDML2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZquqjQfWRpbsWYNiqX3GIzX4/+2mERRK5IqKqhZ9zN6qXFKHNhK6eEw/VNFwsy3+FiBGMJB4sgf5OQhDfJ8drDchqecifOu02+L+t73fugSkIuenW7A+HLTaeMt1k3pB7nmnEetWhVDM/taEOAldY2QaLlPUmfMhiFde9LASBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=s+8dfp8o; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609fc742044so10968777b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710424385; x=1711029185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0LZ9JPaPO9MvJ92RSmTjppyGkKV74icycuPX6dPtYM=;
        b=s+8dfp8oxd+tQ/fG2/d6F8Nc9en3gM0RFYApm3kHxfoz/+r4UxNS/C4GmNf1aQYZo0
         wv3uqs7h2rdaUMul23DwcxL3gnTBbORfUlI5RdefGFabFn/yRVPGHEml0pAtGOfEBdpg
         wkqHkZKFRF0h8Q7lsc8EUMmgTPd6dX4rfIup6J2ICGAbdZPHXcow5kVVC08D0YYmG/um
         o56avz5kCZorRv1M1o5PGEPBbhw1fUjWY7j8Gibob5Ah4GqswKuwBmdH+yzdtpUwxFpZ
         Qc4gc2pIYLmh9xZxqjpaL1zoMfvnX/UKGEMGNGn4i/+RLJmySDEu4W1iHs/QlbJVZGdZ
         s6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424385; x=1711029185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0LZ9JPaPO9MvJ92RSmTjppyGkKV74icycuPX6dPtYM=;
        b=Uz3wGfPwBHBQknszOeFLPbQDWVZLU/57QjvYlMriIKdR4IkSm5Ltrx2jwp6ezR7t4C
         twBOKOocxPIKd72gYNvdhZMQpvQTGwpYMFUj+iaOMDQkVHiXhx9JtyEqZxlqTb/l1CPR
         tGI1J6g2h4UcHmJlovpX3gaLHYrYUnFf3ctPskZ2wcL5clqjMgDvwu5J/hOhz/JbqTPz
         fNwmkM491+6ERlMVluX3DXaf4Fsvp6jM+2gyzAa04MVPG45VWHfKE0Qw9HQAuoD+nXzC
         CEDVjI2Ke8BCQfRBr6s24fe9kNpDu7VvPs1jfuJptp5cmziwSkZkEZUgWz5cV9EBMStn
         x3lg==
X-Forwarded-Encrypted: i=1; AJvYcCXKNpbbDi8Ngc9aTfq9AHPg4LQ/00g0BIossbn0Pz7Eum9zFPJG/toIowM9j/pZRCRUEUBgccud1oljaE8ZGca2Bc6xiKfno4ysFbGT
X-Gm-Message-State: AOJu0YzEZYswOfsaot28Mevsufsww1dXBBx0M17gFmUs0rK3AFKEiydY
	t6OGsibDtCf+5V81u4Pdd9BVtN2GFGWDvrZ6bJ770miyk31XO/fPKKrQJogokb11vSU5X2BIUTR
	AxzWtEYhLbp7aP9H90QMPlElqxeb06q5wRJWXuA==
X-Google-Smtp-Source: AGHT+IE8FrfuS9Wh8W8HqQpkZWATt/l2PywIiLHJSDvG8y5Wb8/Xq75KW08PYGCynXNtvQpY5TzVN3kJU7yqPeErXOo=
X-Received: by 2002:a81:5208:0:b0:609:f7cc:4bb7 with SMTP id
 g8-20020a815208000000b00609f7cc4bb7mr788909ywb.46.1710424385457; Thu, 14 Mar
 2024 06:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com> <f5105c5d-59fb-4bca-af70-353e480f2b12@suse.com>
 <CA+CK2bD0ShasU0U5gzp_m99V=NAg1o8wAKH3_+1ghZHmsWhL9w@mail.gmail.com> <6f351959-4711-4a21-8c46-94e536d2eff8@csgroup.eu>
In-Reply-To: <6f351959-4711-4a21-8c46-94e536d2eff8@csgroup.eu>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 09:52:29 -0400
Message-ID: <CA+CK2bAXBMsHfeZERKhmMmQGadZFFTUH__AggY4U9vOHJhaGGQ@mail.gmail.com>
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of memset()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nikolay Borisov <nik.borisov@suse.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> But the pages were already physically discontiguous before your change,
> what's the difference ?

Pages were not physically contiguous before my change. They were
allocated with __vmalloc_node_range() which allocates sparse pages and
maps them to a virtually contiguous span of memory within
[VMALLOC_START, VMALLOC_END) range.

> It doesn't matter that the pages are physically discontiguous as far as
> they are virtually contiguous, which should still be the case here for a
> stack.

This patch is a preparation patch for the "dynamic kernel stack"
feature, in the description it says:
This is because with dynamic stacks we might have only partially
populated stacks.

We could compute the populated part of the stack, and determine its
start and end mapped VA range by using vm_area->pages[] and
vm_area->nr_pages, but that would make code a little uglier especially
becuase we would need to take into the account if stack is growing up
or down.. Therefore, using clear_page()  is simpler and should be fast
enough.

Thanks,
Pasha

