Return-Path: <linux-kernel+bounces-1346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135EA814DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD02B285F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6E3FB36;
	Fri, 15 Dec 2023 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsUsLrAB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592143EA9B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbce7338330so687917276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659697; x=1703264497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nfn9bvVvuLHxdnWDcg+9EWXTr0TX8gO/J71FKN83mM=;
        b=OsUsLrABexB9iP83Yc1/PcXElrYIDPjpE4JTNZbxFO/9huiUorYNUpicpuPs3zeTIT
         p+U6s/HXIhFElceIJMg3nLXdIslq7KIZ6cF2abGGlQVyz19T1WtLDrcEKNbeIy+9OvPT
         Z7Hyptr/NsU9hqM8L1Fb392NBNRj6sxXajH3RJobsTUeYhrYbWmfjvgaqF718j1iqsnz
         nGCWnM+6iqHdSvOBBqlbgLAA1z7Ip39jaOQ7PQ7LHth4SL0O4UzaBlUg0phhsBHyVdXu
         QQB3U1OHl9toNZ4VvVViimdgWTv4iB8n1U35RySG3HWV7VZj38aFh0Ld4Syu1IcXwYSh
         sqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659697; x=1703264497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nfn9bvVvuLHxdnWDcg+9EWXTr0TX8gO/J71FKN83mM=;
        b=gZAK7QnWH85WfbWeG7wl4o7+dWbOiUq1cH+V73tl+7Pep8cNUCaNnGNGhLMtxajTtC
         HCgx6/ggr3ueoAqIYP4MvKfsoFYTnvoXsWTHWRbjonO1E9XBBIAXUNU3z9UsTwmKZO9l
         9caEeGadkcpU1ztyzzFG630RT39EpBYf1B875PGGFrgmLzxA29e2Uu9oUX2scA0/0nv+
         5e4cByDVUXvAD4amnsnm1QlErD5ug47FrTjjpWuQOhdXjpt2TShL6cQ0CCGIyxAWIBKV
         z+iJLgVT48/oGgE85uTtxoUP8RHQ8dk85V9X3JaQHDF/Ufzk3HzXCtEVjfkw8eNcuuJ5
         xO7A==
X-Gm-Message-State: AOJu0YzO/bDSP5D9gDhiSTZDjTHO/XOHyf+zJVCvmQKDOWSMply/ms25
	ox73kThfb1dIkS2MrPPlRNk=
X-Google-Smtp-Source: AGHT+IFK38IskUKhPTS6SBpMM4pgyoPjKBgP/iNpKZiqeBw+ns39FwPwr7lqj7g5IHTTuZ+aALnSGg==
X-Received: by 2002:a25:d68f:0:b0:db4:5cdd:f6b4 with SMTP id n137-20020a25d68f000000b00db45cddf6b4mr8546969ybg.14.1702659697087;
        Fri, 15 Dec 2023 09:01:37 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id c81-20020a25c054000000b00dbd043e4fb8sm150464ybf.31.2023.12.15.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:01:36 -0800 (PST)
Date: Fri, 15 Dec 2023 09:01:34 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v10-mte 4/7] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZXyGbhJqzNxbd3ay@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-5-glider@google.com>
 <ZXtircr4TllpqyeS@yury-ThinkPad>
 <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>
 <ZXyAXPxlmq11rp2Y@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyAXPxlmq11rp2Y@yury-ThinkPad>

On Fri, Dec 15, 2023 at 08:35:43AM -0800, Yury Norov wrote:
> On Fri, Dec 15, 2023 at 04:19:27PM +0100, Alexander Potapenko wrote:
> > >
> > > That looks weird... You're casting address of a 'data' to a bitmap
> > > instead of 'data'. At the 1st glance it makes little sense because
> > > 'data' is passed as parameter. Moreover, in mte_is_compressed()
> > > you pass 'data', not '&data'. Can you please comment on your
> > > intention?
> > 
> > Although `data` is a void*, it actually contains 64 bits of compressed
> > data, so we pass &data to mte_bitmap_read() to read its contents.
> > Perhaps I'd better make `data` an unsigned long to avoid confusion.
>  
> Still don't understand. Let's consider this example:
> 
> yury:linux$ cat tst.c
> #include <stdio.h>
> 
> unsigned long data[1] = {0xabc};
> 
> void foo(unsigned long *data)
> {
> 	printf("foo:  *data\t%lx\n", (unsigned long)*data);
> 	printf("foo:   data\t%lx\n",  (unsigned long)data);
> 	printf("foo:  &data\t%lx\n", (unsigned long)&data);
> }
> 
> void bar(unsigned long *data)
> {
> 	volatile unsigned long x[100];
> 
> 	printf("bar:  *data\t%lx\n", (unsigned long)*data);
> 	printf("bar:   data\t%lx\n",  (unsigned long)data);
> 	printf("bar:  &data\t%lx\n", (unsigned long)&data);
> }
> 
> int main(int argc, char *argv[])
> {
> 
> 	foo(data);
> 	bar(data);
> 
> 	printf("main: *data\t%lx\n", (unsigned long)*data);
> 	printf("main:  data\t%lx\n",  (unsigned long)data);
> 	printf("main: &data\t%lx\n", (unsigned long)&data);
> 
> 	return 0;
> }
> yury:linux$ gcc tst.c -O0
> yury:linux$ ./a.out
> foo:  *data	abc
> foo:   data	555b2cef9010
> foo:  &data	7fff39d6e5f8
> bar:  *data	abc
> bar:   data	555b2cef9010
> bar:  &data	7fff39d6e2c8
> main: *data	abc
> main:  data	555b2cef9010
> main: &data	555b2cef9010
> 
> Data and *data have their meaning across scope boundary: a pointer and
> a content. The &data is pretty much a random number - a pointer to
> somewhere on a function's stack. Isn't?

OK, I read now. Your 'void *data' is not a pointer, but an actual data.
Very confusing indeed... Maybe add a comment for that cast?
 

