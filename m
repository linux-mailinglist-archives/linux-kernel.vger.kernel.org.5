Return-Path: <linux-kernel+bounces-28335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFA82FD07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5800128BB43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576FF1D691;
	Tue, 16 Jan 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2ch3Cx3z"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE31D54A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443151; cv=none; b=ZOtlyyazGKM7OGOc9t3TWtH5sQI7k+3aljzw0Zn5Kq7zCLvHQRFjK27WkTntHpr+jHtX2YozUBLRyACJOG97oLQ/tMY/dgv8GuQB9WH4B04F4a8AbJXETVhHi4n0atzVVS+cDr7oCV3ZV94QS18rAydpkz6cshtCrtL0UWLQrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443151; c=relaxed/simple;
	bh=2oZS8PyhhT3dFlMjr+ts5/aSlrzpQ32w+ZgTKxP2Kig=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ZATEZlCZN0P/n5vPk2DItb/JWrilJJezEIZqh2Qo+y7Uns6TtalXJbeJzVMnwQ+R/FoCwHYVtQg43ask4AG8sRJYutR4bPWQwJ5aChY6Mipwtmv4wiWAlE0p2WPwOW03QbeO/xpjUMCtuLwOlawPl72v9g9iVN8AYrndQdI+2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2ch3Cx3z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so5491170b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705443149; x=1706047949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z31N7igtmEX2QoESZM8Ds3APvcIeb/dGLKwEtxypi1c=;
        b=2ch3Cx3zcLVQ2BSGkzD9HTmefd4DFTsQ9S5WZi1B8soMzCq2skD7x0vuNeP2q/lBqm
         T0u6Zo4ME1kNWv+/EqjYmW28s+Oc/zwrT+3e4z+5y/wCTEIxX8aBLiq9L1XtvEMcPh23
         0BkJLISqxbBrkOyu3ytNewFqS2X6hXbW1HrtTpUuvujing/jGYJyUlnm+Cjb9BVP6Qc8
         qlhIkhPeKvqgfr97GEKC7IHi8DhGagSz10J+KOKUrpIdCBAzpSRyv7ckkEY2cAzr36X1
         OpT9psMOqYvKR0yitYQ4NT9I0zKmBq6WtMNzyWq4uBeDGtTu6fVpuWjAXJEI36fxacs4
         klCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443149; x=1706047949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z31N7igtmEX2QoESZM8Ds3APvcIeb/dGLKwEtxypi1c=;
        b=eUVe5+jK34vv89KRxA9YBs+gaLRv8/2hq5VxL9Fpmx3y39AOHLdfk/8P8nVqFvnOLG
         ZTFoEc/nMVag0cwlk/mXLzxUeWqBMCM7YJWOMWR/PrOLYV/hA9E/8b5djLfk9wsa2xry
         29lcc7W2nlr9chUYRoeuJkrVBkpN4HLY3grjQPgQ5iU2gJaMdy4nPaWxiG3wofsp2NAU
         hdahVPxcznyL+Deat2oiXFx8Eo3su+2JyJEtvpt5hdziV5lAm8uD3eVJ0YDjWflLqhLF
         4IT4QcF34RYtrb94Y8aDAjDc4Y80LejRBQcZIZo7qvMlzwevE9M39yvDfRT5UgJy78l1
         2jKw==
X-Gm-Message-State: AOJu0YxyU6bkRwfDlBaNSiERQOSgDB4KEU8RS8SZqfwvx7TayXtqmqbE
	L/2I2jKoBJ7NDqPruiUyl2L4k8EiaOWN3g==
X-Google-Smtp-Source: AGHT+IFHH2qeXyHnecx/FBEzzK9UJHHFn2J6URo64iIU3pTkPlUE9TMKkBuNJaDzrjFtZ4+L1L9+Sw==
X-Received: by 2002:a05:6a00:93aa:b0:6db:c92:edc8 with SMTP id ka42-20020a056a0093aa00b006db0c92edc8mr5775089pfb.5.1705443149344;
        Tue, 16 Jan 2024 14:12:29 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id p42-20020a056a000a2a00b006d9b345092dsm71495pfh.156.2024.01.16.14.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:12:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPrfW-00BJds-1K;
	Wed, 17 Jan 2024 09:12:26 +1100
Date: Wed, 17 Jan 2024 09:12:26 +1100
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
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <Zab/Sm0FXjnNvseR@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
 <ZaAPSJHGsmG_oHAU@pc638.lan>
 <ZaBRkCtkMoTdiN+3@dread.disaster.area>
 <ZaEuE37TIM1s3OXF@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaEuE37TIM1s3OXF@pc636>

On Fri, Jan 12, 2024 at 01:18:27PM +0100, Uladzislau Rezki wrote:
> On Fri, Jan 12, 2024 at 07:37:36AM +1100, Dave Chinner wrote:
> > On Thu, Jan 11, 2024 at 04:54:48PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Jan 11, 2024 at 08:02:16PM +1100, Dave Chinner wrote:
> > > > On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > Concurrent access to a global vmap space is a bottle-neck.
> > > > > We can simulate a high contention by running a vmalloc test
> > > > > suite.
> > > > > 
> > > > > To address it, introduce an effective vmap node logic. Each
> > > > > node behaves as independent entity. When a node is accessed
> > > > > it serves a request directly(if possible) from its pool.
> > > > > 
> > > > > This model has a size based pool for requests, i.e. pools are
> > > > > serialized and populated based on object size and real demand.
> > > > > A maximum object size that pool can handle is set to 256 pages.
> > > > > 
> > > > > This technique reduces a pressure on the global vmap lock.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > Why not use a llist for this? That gets rid of the need for a
> > > > new pool_lock altogether...
> > > > 
> > > Initially i used the llist. I have changed it because i keep track
> > > of objects per a pool to decay it later. I do not find these locks
> > > as contented one therefore i did not think much.
> > 
> > Ok. I've used llist and an atomic counter to track the list length
> > in the past.
> > 
> > But is the list length even necessary? It seems to me that it is
> > only used by the shrinker to determine how many objects are on the
> > lists for scanning, and I'm not sure that's entirely necessary given
> > the way the current global shrinker works (i.e. completely unfair to
> > low numbered nodes due to scan loop start bias).
> > 
> I use the length to decay pools by certain percentage, currently it is
> 25%, so i need to know number of objects. It is done in the purge path.
> As for shrinker, once it hits us we drain pools entirely.

Why does purge need to be different to shrinking?

But, regardless, you can still use llist with an atomic counter to
do this - there is no need for a spin lock at all.

> > > Anyway, i will have a look at this to see if llist is easy to go with
> > > or not. If so i will send out a separate patch.
> > 
> > Sounds good, it was just something that crossed my mind given the
> > pattern of "producer adds single items, consumer detaches entire
> > list, processes it and reattaches remainder" is a perfect match for
> > the llist structure.
> > 
> The llist_del_first() has to be serialized. For this purpose a per-cpu
> pool would work or kind of "in_use" atomic that protects concurrent
> removing.

So don't use llist_del_first().

> If we detach entire llist, then we need to keep track of last node
> to add it later as a "batch" to already existing/populated list.

Why? I haven't see any need for ordering these lists which would
requiring strict tail-add ordered semantics.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

