Return-Path: <linux-kernel+bounces-37327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043D83AE49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098A61F27088
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB67CF30;
	Wed, 24 Jan 2024 16:24:27 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2E7CF22
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113466; cv=none; b=TRjzJZYyuFZSfNHs7kSruOj+VVtkYeRIUtfY7XejEUC3nVSHKl/x8Oa5bVAdSHPbQDNFWRZV8/iQ6ALjH8joBv1Tko08RcyBf/9T2SCH8+0R6BUXwotBdVfk79M/KP9PAps+d64RBGDHktzb8vrfPMjUJ3ywgRnaU+cYW2Br6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113466; c=relaxed/simple;
	bh=cmh2v342drxF1dTH1nf4cchjsqCYIhUmT0Augauvd1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQfhqFJ1cGgb7XCNzr8wT6vPxcDIuy6Dp9DewBfYq1wUcjWtPpfbOzKBw+Vv8yGIDYwOEcCsefLdLVlVfsbuQvK+q87YFfsXgUAYPRd8sCI1Ftm8ggSrLjI7ILf+uySebXRotMK0lHSUtiB2uirfzezQAps1XqSW4fXntHK9F6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso6196097e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113463; x=1706718263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMrT5P2w10tw7eLH7q5F2CQ18PCwIDF5TrbVadGlCl4=;
        b=ozf7WMEjNDwBUwxoT9KEtt3OrEREL6cwQ/uDhYWO/gG6dJCUgwgZChm0eJOsez7bs+
         lc6tfujwptyth+UK0A14l7/0h4JFF44xm1ueBjilJFlifuCWXOPk+40GED80fBwwt3Qt
         7GXWhWtzg3IVNYjqXHRa6kdH0KHJ42FC06Sb1XJY5w1yhMjxeVBCpicl1kM+5p7GKIF9
         KvXr6o67ILFXl3jg7Qf6q7WyZGybG25nIXLQTzaKZ7Hv64l/ZLKHOCAXPfVYv6gp4wPj
         WOEKzpSSXaywnkAb6Fk010r/UsA/NwVENDDwvofpc6F/CtMXGAnNK3aMlAURfH9iAZS0
         tQ9w==
X-Gm-Message-State: AOJu0YyHA/p5nFVY5GftLA/4edQ9C1BkMBBc7UC2lEdil5slpb1IC6aM
	2VGevCAghKvcZYySyjtOkh7mDr/H5Mp26IQpMfkGsYSh3OKsKzS5
X-Google-Smtp-Source: AGHT+IGIchG2ph+UVbTIfE1JqfL/7GUBYTcpp4ft1R1HeRtkJS7ZJGt2zEDRghte6NPJ5RWquqRInQ==
X-Received: by 2002:a19:ee10:0:b0:510:17b6:69e with SMTP id g16-20020a19ee10000000b0051017b6069emr68370lfb.89.1706113462769;
        Wed, 24 Jan 2024 08:24:22 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id wh11-20020a1709078f8b00b00a26f6b8be1csm47026ejc.75.2024.01.24.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:24:22 -0800 (PST)
Date: Wed, 24 Jan 2024 08:24:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZbE5tBBjlhz3JN5+@gmail.com>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZbEbmyszaK9tYobe@gmail.com>
 <CANpmjNNnrKYKkV74rcBUkpA09KqwHOjse9J9aCHPRFuYKCQM2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNnrKYKkV74rcBUkpA09KqwHOjse9J9aCHPRFuYKCQM2w@mail.gmail.com>

On Wed, Jan 24, 2024 at 03:21:26PM +0100, Marco Elver wrote:
> On Wed, 24 Jan 2024 at 15:16, Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Andrey,
> >
> > On Mon, Nov 20, 2023 at 06:47:10PM +0100, andrey.konovalov@linux.dev wrote:
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Currently, stack depot uses the following locking scheme:
> > >
> > > 1. Lock-free accesses when looking up a stack record, which allows to
> > >    have multiple users to look up records in parallel;
> > > 2. Spinlock for protecting the stack depot pools and the hash table
> > >    when adding a new record.
> > >
> > > For implementing the eviction of stack traces from stack depot, the
> > > lock-free approach is not going to work anymore, as we will need to be
> > > able to also remove records from the hash table.
> > >
> > > Convert the spinlock into a read/write lock, and drop the atomic accesses,
> > > as they are no longer required.
> > >
> > > Looking up stack traces is now protected by the read lock and adding new
> > > records - by the write lock. One of the following patches will add a new
> > > function for evicting stack records, which will be protected by the write
> > > lock as well.
> > >
> > > With this change, multiple users can still look up records in parallel.
> > >
> > > This is preparatory patch for implementing the eviction of stack records
> > > from the stack depot.
> >
> > I am testing quite recent "debug" kernel (with KASAN, Lockdep, etc
> > enabled). This kernel is based on
> > 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e, and I found the following
> 
> This version predates this series, as far as I can tell. Can you try linux-next?

That is true. I will retest and let you know if it is still
reproducible.

Thanks.

