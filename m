Return-Path: <linux-kernel+bounces-28331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B682FCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B81F2B2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47044CDF8;
	Tue, 16 Jan 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WRgivf8+"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70B482C5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442768; cv=none; b=Ms0d8ov1OQf6cQrcR7orhbQtdJjzw4qyOTCHC+qAWHBGy05RPXWtkTtkmK/0xFccJcetXwidGTNqfy+znAVLBJHJH/vbUrjNjzxyDPRgy6gYexiShkzEUJSPHExMoIT0IijN+raORqoEm0RBTsRlB97YuPR0CDU7PCmZvObuQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442768; c=relaxed/simple;
	bh=2Gl5diehiFBTxg7KkELtcD67vuxojzzoczyvqtyAwCI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=femu8ZQL8s3HWgF1G3lBbzi0q87/P3/l4gQq5k1x3PNY6lmsd0O+zmPqhTloJL5Dxpt6cX3n4LgBdkZqiof5UBj9Dt9u1tx3i6l76bdKybStedbhCRND/bFcYk6YrKjKkul0A7aJbcgLGcn+9cKPxkB0pzsTyqb5VlrNGqy9MpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WRgivf8+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so9126401b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705442766; x=1706047566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HM9DN0iEeF1TIiq3KDFYboZdxDVFyQNi4kQI4ruCO88=;
        b=WRgivf8+T9eUrQFHp+feSWHqx6/L+88WYgvk7d+Pi7tkK6s3QH/9kpqycnypwtgY0/
         mPJhZKYUbx2h/Q8IYMlmXXofdjuUJQhbhq9YaZIiyeB3y/SdLNjqOGl3Nod1eTTUoVr/
         5WhYuDyYXan3b3tgiFBkPJEFy8rcTelYnfpBlsfCBe64gnXVCvrfse8AYzKI/o7upclU
         ARJFoKvofVwplvIZqvLrHwPzST3FZcOcxWmOGQAKYrsG0sCrKF4XN/oGYHGzFSFNEkM9
         N6tPgCW3TX3JtRPzusD94mhGsowTY5PrVH/zAQNLDuUd0e7wq3hryQgPOAdIjMpc/JeB
         934w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442766; x=1706047566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM9DN0iEeF1TIiq3KDFYboZdxDVFyQNi4kQI4ruCO88=;
        b=ur4qwUe5Azi6j/CdO9Kwkuhk3X+j8a3nzAaA7jc5WkjOTmDFYGm3f95n37ljVD75z4
         9W773E6UrqmW3hG2Z3Cjx/sglCbyfw2W6BIDj1Ic77wknDFlMj8VDl2RbV7tM8UL2xY4
         VilrZu829kqoDMELTX9TLY10cGNFgB00k3ya1dXkp6PgJ81zaBft+YNHCa0fV3Elnpbu
         fsJ3o8WIDrHBXBZyEkQlxJEX1YGA8S07jtDUL5j5MSlqRVoWCsp1uex6nSITmZanUk7a
         +QWz8ngp3+AiclZ53sy8TU1ynKm+efF8FNIYtZQ3aMkyBGIHIpQUC8uZ230moXO3ThJQ
         3GJA==
X-Gm-Message-State: AOJu0Yxb9BHWa+kSY2XcZyMGUDiGt5RxElXU+x97C7WU0zKXwhuyEjGo
	+XXmMn3MhR8GLQFKydZreWuYbrWH6rRGUQ==
X-Google-Smtp-Source: AGHT+IGpX+0wd5fWUk01jiCT/KzgUu3LKlSR05n71p9NaZigcaGX7cAODLNuIXDEb5hUGoKwWjhk9A==
X-Received: by 2002:a05:6a00:398b:b0:6db:79f6:777b with SMTP id fi11-20020a056a00398b00b006db79f6777bmr5422457pfb.33.1705442765753;
        Tue, 16 Jan 2024 14:06:05 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id p26-20020aa79e9a000000b006d96d753ca0sm73346pfq.38.2024.01.16.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:06:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPrZK-00BJZX-1V;
	Wed, 17 Jan 2024 09:06:02 +1100
Date: Wed, 17 Jan 2024 09:06:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 10/11] mm: vmalloc: Set nr_nodes based on CPUs in a
 system
Message-ID: <Zab9yuUiz8OCMOHw@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
 <ZZ+z8vBl645FvxPq@dread.disaster.area>
 <ZaWC6TRs4P1vq9TQ@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaWC6TRs4P1vq9TQ@pc636>

On Mon, Jan 15, 2024 at 08:09:29PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 02, 2024 at 07:46:32PM +0100, Uladzislau Rezki (Sony) wrote:
> > > A number of nodes which are used in the alloc/free paths is
> > > set based on num_possible_cpus() in a system. Please note a
> > > high limit threshold though is fixed and corresponds to 128
> > > nodes.
> > 
> > Large CPU count machines are NUMA machines. ALl of the allocation
> > and reclaim is NUMA node based i.e. a pgdat per NUMA node.
> > 
> > Shrinkers are also able to be run in a NUMA aware mode so that
> > per-node structures can be reclaimed similar to how per-node LRU
> > lists are scanned for reclaim.
> > 
> > Hence I'm left to wonder if it would be better to have a vmalloc
> > area per pgdat (or sub-node cluster) rather than just base the
> > number on CPU count and then have an arbitrary maximum number when
> > we get to 128 CPU cores. We can have 128 CPU cores in a
> > single socket these days, so not being able to scale the vmalloc
> > areas beyond a single socket seems like a bit of a limitation.
> > 
> >
> > Hence I'm left to wonder if it would be better to have a vmalloc
> > area per pgdat (or sub-node cluster) rather than just base the
> >
> > Scaling out the vmalloc areas in a NUMA aware fashion allows the
> > shrinker to be run in numa aware mode, which gets rid of the need
> > for the global shrinker to loop over every single vmap area in every
> > shrinker invocation. Only the vm areas on the node that has a memory
> > shortage need to be scanned and reclaimed, it doesn't need reclaim
> > everything globally when a single node runs out of memory.
> > 
> > Yes, this may not give quite as good microbenchmark scalability
> > results, but being able to locate each vm area in node local memory
> > and have operation on them largely isolated to node-local tasks and
> > vmalloc area reclaim will work much better on large multi-socket
> > NUMA machines.
> > 
> Currently i fix the max nodes number to 128. This is because i do not
> have an access to such big NUMA systems whereas i do have an access to
> around ~128 ones. That is why i have decided to stop on that number as
> of now.

I suspect you are confusing number of CPUs with number of NUMA nodes.

A NUMA system with 128 nodes is a large NUMA system that will have
thousands of CPU cores, whilst above you talk about basing the
count on CPU cores and that a single socket can have 128 cores?

> We can easily set nr_nodes to num_possible_cpus() and let it scale for
> anyone. But before doing this, i would like to give it a try as a first
> step because i have not tested it well on really big NUMA systems.

I don't think you need to have large NUMA systems to test it. We
have the "fakenuma" feature for a reason.  Essentially, once you
have enough CPU cores that catastrophic lock contention can be
generated in a fast path (can take as few as 4-5 CPU cores), then
you can effectively test NUMA scalability with fakenuma by creating
nodes with >=8 CPUs each.

This is how I've done testing of numa aware algorithms (like
shrinkers!) for the past decade - I haven't had direct access to a
big NUMA machine since 2008, yet it's relatively trivial to test
NUMA based scalability algorithms without them these days.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

