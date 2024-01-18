Return-Path: <linux-kernel+bounces-30467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46747831F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B061F2343A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22DB2D619;
	Thu, 18 Jan 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/LMAZcf"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0B2D603
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602234; cv=none; b=OUXyNmeZ1IoErR1I45oKhtm3wWwcb+DBlKyAQ0VcP/XwDlpsJrfNEtg419KmCdrstw4jLVz4QAoXMbRVRB7UAA7yMa/A8irXCJZOvPCV6bRLkWMhfbFHugSA1sf2pQI5qYCLOpheYggHdgHIR5n6DKwzy4tiFq/wGADh3CGjnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602234; c=relaxed/simple;
	bh=Kd6hsF3oy3VFEvg9nh5CRhzvMSgXVZ8lHpmCd833QVk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV7TuGl2Jq/onKTixNXECe8vg5YzWNHaEH3mOX0Qj9oQYU+vzXwvXPWf+jC6JlU7T0c+h2pjUb+/lld/bPP2uBe/EDLtuWqbhfgUrqZKwdnQDe3uR0EGoXPRd7E2ciRNJtU1viSEohBvvIiW843pm23zgJ/hZqIOlWBzPXg9v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/LMAZcf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso14383732e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705602230; x=1706207030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDTT+aimkuCwG90BFZdDCB6BRMUsuDiU7TMC5OX3Mbc=;
        b=I/LMAZcfXUp4Vw1K7tFdeN++yzl+iiBkIr11ettjtwOnnLuJkMNnDUuj01V+pvp4Kv
         Q8G9mxsPO3946xWZV4PG7hA0kmV8+J8zHCfgy3z39dck2xk0jLnfb7qS+LkaG4LY2mpE
         ju1puw5SSXovE7LQaMy9DMvZKV0oqkPtK96UwASPi0NApArGsKr5qwbdgSd5P8H3Dn3g
         Y+08yi0BA4rbVrj55FcUeEtvHZtQXpbsxo0EiOjPUP9M8xk+/yVkcGnKLWBTJxCY4eDG
         vOLRbGGi10Pty0z0KPR4KT09T1fqZ6ytVGE/wwiR+qvFOkU/Z3MTfc73l883jc6dNb6m
         oOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602230; x=1706207030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDTT+aimkuCwG90BFZdDCB6BRMUsuDiU7TMC5OX3Mbc=;
        b=pIZeFrcoRx0GazzgKHevePSqkPm6XuZkZ8ZInL91V7ecOPuoA0m/MZznbuIbeIg8vo
         c7L4b/p1k2r/pDw22hwXL1goTgSAch/ZlbeQtUHwDzIBzyA8fmoBJ86L+EgkaQRiHIxC
         FFQ4pJVIn1xhH1Z2YReBswcIqF1YBUizACB1LwJZLDZC+ffSnFSKhwDwZjfOFfwCnVRs
         7EcgvooHlvsauYO6W5HjstBp4KHxwqDeLK+1PVjJ/KKDZvgPgMKQgbgTUg+cqH0XQeop
         Jdk6qoMA6RfqurmSo5+4ekDBMgaTGzkpRwn802v8OPXpJ6BoaIOTUXpwvRHc5fqhVMe9
         kE0Q==
X-Gm-Message-State: AOJu0YwHOnIxsDpeY2J3oKyc2KO+wBWjkDOTm4w+2cMb7N5Ab6OyDvHs
	YPLAnrPUQy9Oy7lPYXOfcn0kDpD2LdZIhIcTvu8YLiTSzcZLhD1/aRze1aLW
X-Google-Smtp-Source: AGHT+IH7CWktjjnW+TrI3W6yXBXD4/G2Z1zcyUitoT5/jCsvlhBbgwy2a8Ye/B1IGEfDnQ+W/a/DIw==
X-Received: by 2002:a19:690d:0:b0:50e:b8d3:143e with SMTP id e13-20020a19690d000000b0050eb8d3143emr31028lfc.51.1705602230225;
        Thu, 18 Jan 2024 10:23:50 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id fc5-20020a056512138500b0050f072ef3b0sm711259lfb.175.2024.01.18.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:23:49 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 18 Jan 2024 19:23:47 +0100
To: Dave Chinner <david@fromorbit.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZalssyzC8_HsFZON@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
 <ZZ+z8vBl645FvxPq@dread.disaster.area>
 <ZaWC6TRs4P1vq9TQ@pc636>
 <Zab9yuUiz8OCMOHw@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zab9yuUiz8OCMOHw@dread.disaster.area>

On Wed, Jan 17, 2024 at 09:06:02AM +1100, Dave Chinner wrote:
> On Mon, Jan 15, 2024 at 08:09:29PM +0100, Uladzislau Rezki wrote:
> > > On Tue, Jan 02, 2024 at 07:46:32PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > A number of nodes which are used in the alloc/free paths is
> > > > set based on num_possible_cpus() in a system. Please note a
> > > > high limit threshold though is fixed and corresponds to 128
> > > > nodes.
> > > 
> > > Large CPU count machines are NUMA machines. ALl of the allocation
> > > and reclaim is NUMA node based i.e. a pgdat per NUMA node.
> > > 
> > > Shrinkers are also able to be run in a NUMA aware mode so that
> > > per-node structures can be reclaimed similar to how per-node LRU
> > > lists are scanned for reclaim.
> > > 
> > > Hence I'm left to wonder if it would be better to have a vmalloc
> > > area per pgdat (or sub-node cluster) rather than just base the
> > > number on CPU count and then have an arbitrary maximum number when
> > > we get to 128 CPU cores. We can have 128 CPU cores in a
> > > single socket these days, so not being able to scale the vmalloc
> > > areas beyond a single socket seems like a bit of a limitation.
> > > 
> > >
> > > Hence I'm left to wonder if it would be better to have a vmalloc
> > > area per pgdat (or sub-node cluster) rather than just base the
> > >
> > > Scaling out the vmalloc areas in a NUMA aware fashion allows the
> > > shrinker to be run in numa aware mode, which gets rid of the need
> > > for the global shrinker to loop over every single vmap area in every
> > > shrinker invocation. Only the vm areas on the node that has a memory
> > > shortage need to be scanned and reclaimed, it doesn't need reclaim
> > > everything globally when a single node runs out of memory.
> > > 
> > > Yes, this may not give quite as good microbenchmark scalability
> > > results, but being able to locate each vm area in node local memory
> > > and have operation on them largely isolated to node-local tasks and
> > > vmalloc area reclaim will work much better on large multi-socket
> > > NUMA machines.
> > > 
> > Currently i fix the max nodes number to 128. This is because i do not
> > have an access to such big NUMA systems whereas i do have an access to
> > around ~128 ones. That is why i have decided to stop on that number as
> > of now.
> 
> I suspect you are confusing number of CPUs with number of NUMA nodes.
> 
I do not think so :)

>
> A NUMA system with 128 nodes is a large NUMA system that will have
> thousands of CPU cores, whilst above you talk about basing the
> count on CPU cores and that a single socket can have 128 cores?
> 
> > We can easily set nr_nodes to num_possible_cpus() and let it scale for
> > anyone. But before doing this, i would like to give it a try as a first
> > step because i have not tested it well on really big NUMA systems.
> 
> I don't think you need to have large NUMA systems to test it. We
> have the "fakenuma" feature for a reason.  Essentially, once you
> have enough CPU cores that catastrophic lock contention can be
> generated in a fast path (can take as few as 4-5 CPU cores), then
> you can effectively test NUMA scalability with fakenuma by creating
> nodes with >=8 CPUs each.
> 
> This is how I've done testing of numa aware algorithms (like
> shrinkers!) for the past decade - I haven't had direct access to a
> big NUMA machine since 2008, yet it's relatively trivial to test
> NUMA based scalability algorithms without them these days.
> 
I see your point. NUMA-aware scalability require reworking adding extra
layer that allows such scaling.

If the socket has 256 CPUs, how do scale VAs inside that node among
those CPUs?

--
Uladzislau Rezki

