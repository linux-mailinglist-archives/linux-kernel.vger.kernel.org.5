Return-Path: <linux-kernel+bounces-1308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC04814D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88535B232BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170803EA71;
	Fri, 15 Dec 2023 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAwCxPT4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE63EA64
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so692966276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702658143; x=1703262943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPYTzxprRPq6a6Oexpdp5sY7hxU8CR4LHFMOMzNgC9E=;
        b=EAwCxPT4UNTCCulU0fQpdO3mAhxdf7ujbNN4+9Jqp/9Tp5pCv8n3IEnwggNvRQ6Km+
         Y0RLQTutOHh3HtsSOHOlyrB622AhoMghGgmthRhhPjPFE+hjrB3F6OzR1FwgLptpOBIr
         3tZmzUagQmRshfDg+UQD64eUXsORDFbFW76ZPHLlpVi0hsi60CvHVoopeCB4sc/Czkyq
         27Mgos3GtTEvYz0jRomgq86fSLTP9ZLOifEZXdRB13uTYTAc58zmhji6ZQbanpOKqPdY
         K4akDhnH/3B1ZAd8NYkeleXRmpmmqa14dXqB3Kh4/aYYbQk2lFLjv25dFxCJG8iuqx9G
         OrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658143; x=1703262943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPYTzxprRPq6a6Oexpdp5sY7hxU8CR4LHFMOMzNgC9E=;
        b=muTaSFpYJ5wgun8LMH8SKyNX09Dm3W+YLrJ4ZFz58vGvQv3fQI6BZPX5fGj41As9qS
         fbSzu6oFwu2q802uEDF6aF7pQoyLAwoSWGcAHdeH5hsCnT2FMBDudnyQ5hVFZDixDSUO
         P1DBz+9EMp7Li7IfeN4vADMzehi1QOwIg7mVbTl+hXR1lISVmuEGZXVMMtWypZTxgsLh
         P+RtSElEOHJFaqlzkD00nUpD8PE9H1OBwvmYEQpR6DCe68KNsZDY8IR9PPKBd6Nf0uz5
         WPO/0YGdebQ7499TIVzfBFMGvsIKmYPsepb00R0wEEn9AvmAm99Z2c7o0UXqdTmfcnKb
         b1WA==
X-Gm-Message-State: AOJu0YyE5ZQdbKPNidE5RGsiNz6h6f3D3hIRoEasmeqWUBD713QiQHJM
	GHH7jIHjIcB6rhqrskLtkW8=
X-Google-Smtp-Source: AGHT+IHk5kjZ6JiXVmBStFA0vpOtGbFwSGvlFJvE5y1XqTuVq3b2uH9McH3sARZDy5b+1LXYshpCdw==
X-Received: by 2002:a25:ef4c:0:b0:dbc:d4c0:82ef with SMTP id w12-20020a25ef4c000000b00dbcd4c082efmr2815528ybm.92.1702658142904;
        Fri, 15 Dec 2023 08:35:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id k15-20020a5b0a0f000000b00db54cf1383esm5504422ybq.10.2023.12.15.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:35:41 -0800 (PST)
Date: Fri, 15 Dec 2023 08:35:40 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v10-mte 4/7] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZXyAXPxlmq11rp2Y@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-5-glider@google.com>
 <ZXtircr4TllpqyeS@yury-ThinkPad>
 <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>

On Fri, Dec 15, 2023 at 04:19:27PM +0100, Alexander Potapenko wrote:
> >
> > That looks weird... You're casting address of a 'data' to a bitmap
> > instead of 'data'. At the 1st glance it makes little sense because
> > 'data' is passed as parameter. Moreover, in mte_is_compressed()
> > you pass 'data', not '&data'. Can you please comment on your
> > intention?
> 
> Although `data` is a void*, it actually contains 64 bits of compressed
> data, so we pass &data to mte_bitmap_read() to read its contents.
> Perhaps I'd better make `data` an unsigned long to avoid confusion.
 
Still don't understand. Let's consider this example:

yury:linux$ cat tst.c
#include <stdio.h>

unsigned long data[1] = {0xabc};

void foo(unsigned long *data)
{
	printf("foo:  *data\t%lx\n", (unsigned long)*data);
	printf("foo:   data\t%lx\n",  (unsigned long)data);
	printf("foo:  &data\t%lx\n", (unsigned long)&data);
}

void bar(unsigned long *data)
{
	volatile unsigned long x[100];

	printf("bar:  *data\t%lx\n", (unsigned long)*data);
	printf("bar:   data\t%lx\n",  (unsigned long)data);
	printf("bar:  &data\t%lx\n", (unsigned long)&data);
}

int main(int argc, char *argv[])
{

	foo(data);
	bar(data);

	printf("main: *data\t%lx\n", (unsigned long)*data);
	printf("main:  data\t%lx\n",  (unsigned long)data);
	printf("main: &data\t%lx\n", (unsigned long)&data);

	return 0;
}
yury:linux$ gcc tst.c -O0
yury:linux$ ./a.out
foo:  *data	abc
foo:   data	555b2cef9010
foo:  &data	7fff39d6e5f8
bar:  *data	abc
bar:   data	555b2cef9010
bar:  &data	7fff39d6e2c8
main: *data	abc
main:  data	555b2cef9010
main: &data	555b2cef9010

Data and *data have their meaning across scope boundary: a pointer and
a content. The &data is pretty much a random number - a pointer to
somewhere on a function's stack. Isn't?

> > > +     max_ranges = MTE_MAX_RANGES;
> > > +     /* Skip the leading bit indicating the inline case. */
> > > +     mte_bitmap_read(bitmap, &bit_pos, 1);
> > > +     largest_idx =
> > > +             mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_LARGEST_IDX);
> >
> > Nit: really no need to split the line - we're OK with 100-chars per
> > line now.
> 
> That's true, but I am relying on clang-format here (maybe we should
> extend the limit in .clang-format?)

If clang-format hurts readability, don't use it.

Thanks,
Yury

