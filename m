Return-Path: <linux-kernel+bounces-30462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD51831EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B5328432C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766252D619;
	Thu, 18 Jan 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvY8dZLr"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA72D603
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601720; cv=none; b=Ss8jHL4o4avSzRIVYVQIKIIHGL/CVPo35UCzN/B0eMlgbPW7na6gyfwTMTzOfgR3NF3bdrelcnkoy4Obve2cASYb1WqdRGuzT2rZeM8zDizripdQBaV994NWVNgvgyDthrL+kMF1z2niSIsnksV/QQjc/4KqRgK1TU9UgB42CpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601720; c=relaxed/simple;
	bh=BXzEsfU3bdCn6RVagAfXqRcII9hYYPLnd6qaZAq2AOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGeYkH+ntjI7Ue26JtKzSXLToGD2VW9idmHq7PKUKJ3LSia5SYtkT4dlwVI6umu+uoMNij/rbXYzf6l9Mnebe4KVx+maz8gXTxiKedHBfBQ74UUDV4Kz8auZB35ldB3IU9Mgs3H+DT7vtc8zBGXvqNd+lJ3TSyNRLqPU1/zUlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvY8dZLr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso14386267e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601717; x=1706206517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OboWUpBalDVf1FYx0j2uJTiF97MBbBNmetCopQ/pijc=;
        b=PvY8dZLrPSpTVD2QR8xKzbzP9LmYVqsl8fiQLNki8QohOc7S+/Xm2LuzyGzw4axSCi
         UVBHtm21D1cYYRkBti3T5XQKaGRoocsF5Fm9F9W6jKaudbJnqYuGScTQrVirluwBLzxv
         yBLOE4pCUzstny2UDCdlkx4pugjVdwTBgYn+5blY3+e6FFaTTB+W+leWPc80KkxDSjAu
         EiWDNBzlI5SoCVUIjgtWUyZ13zoPMdjibzuH7xuilKgRRexCRj8riMbDWsFIv52NE9q2
         M2gmWp3F3oP0a9iiW7DekMX2LIk9vmwxMVBJ4uFjy14prPxNgD3LnC7r69yAs8GHky12
         /ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601717; x=1706206517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OboWUpBalDVf1FYx0j2uJTiF97MBbBNmetCopQ/pijc=;
        b=hPIr8fxlVu7TwMbbb71QXxFx/zAqS1nQcN/9ijW4aan+o6ZXH7p+yxPAyYpmPq/lLr
         u/xTtO/DBARbcOqfP/yQXOilqWVu3U8vMopPv4fGcLOhmR3VO1UXVP9E8lRfL0TQX9MZ
         B1qO+a1wfvNX4+fPeKtjHvVh7RmGhw4l4IyHLmBwIQM682a+QCFjv5kV2Ckg7bkPZ/5j
         vCctgUGhHy61cZ7qI+zPKk2J7G2r7ykMgXJvwP/kMCeowzsYQaY1oxAQhpM/eZApu7eQ
         KXMU5xa4MbqDmCht4gIf5rjTRntYaSVmuE+U6RNwCtQqrH/LJOFwoax3DkJciff7oijM
         xCqA==
X-Gm-Message-State: AOJu0YxHEbJG8k+6UFLsMvNmqwVVI21ovdPbelVFJj+4G4IfOrEcwyke
	I9LlUoREKs7lib4FlJIb3iH65tz+S1JS2l8JtQnXlk5qrRxdm1vV
X-Google-Smtp-Source: AGHT+IH1dl8jzJ2Xn42wXNlKGfwKO7wFKYaTY9es9z2dJTN8R+/MkyJ2Hkbls78VZ0LhdfYZgCZBWQ==
X-Received: by 2002:ac2:4c42:0:b0:50e:bb33:840b with SMTP id o2-20020ac24c42000000b0050ebb33840bmr19210lfk.99.1705601716671;
        Thu, 18 Jan 2024 10:15:16 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id p15-20020a056512234f00b0050e7ec49881sm714234lfu.21.2024.01.18.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:15:16 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 18 Jan 2024 19:15:13 +0100
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
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <Zalqsf5MiU7Q7ewN@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
 <ZaAPSJHGsmG_oHAU@pc638.lan>
 <ZaBRkCtkMoTdiN+3@dread.disaster.area>
 <ZaEuE37TIM1s3OXF@pc636>
 <Zab/Sm0FXjnNvseR@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zab/Sm0FXjnNvseR@dread.disaster.area>

On Wed, Jan 17, 2024 at 09:12:26AM +1100, Dave Chinner wrote:
> On Fri, Jan 12, 2024 at 01:18:27PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 12, 2024 at 07:37:36AM +1100, Dave Chinner wrote:
> > > On Thu, Jan 11, 2024 at 04:54:48PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Jan 11, 2024 at 08:02:16PM +1100, Dave Chinner wrote:
> > > > > On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > Concurrent access to a global vmap space is a bottle-neck.
> > > > > > We can simulate a high contention by running a vmalloc test
> > > > > > suite.
> > > > > > 
> > > > > > To address it, introduce an effective vmap node logic. Each
> > > > > > node behaves as independent entity. When a node is accessed
> > > > > > it serves a request directly(if possible) from its pool.
> > > > > > 
> > > > > > This model has a size based pool for requests, i.e. pools are
> > > > > > serialized and populated based on object size and real demand.
> > > > > > A maximum object size that pool can handle is set to 256 pages.
> > > > > > 
> > > > > > This technique reduces a pressure on the global vmap lock.
> > > > > > 
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > 
> > > > > Why not use a llist for this? That gets rid of the need for a
> > > > > new pool_lock altogether...
> > > > > 
> > > > Initially i used the llist. I have changed it because i keep track
> > > > of objects per a pool to decay it later. I do not find these locks
> > > > as contented one therefore i did not think much.
> > > 
> > > Ok. I've used llist and an atomic counter to track the list length
> > > in the past.
> > > 
> > > But is the list length even necessary? It seems to me that it is
> > > only used by the shrinker to determine how many objects are on the
> > > lists for scanning, and I'm not sure that's entirely necessary given
> > > the way the current global shrinker works (i.e. completely unfair to
> > > low numbered nodes due to scan loop start bias).
> > > 
> > I use the length to decay pools by certain percentage, currently it is
> > 25%, so i need to know number of objects. It is done in the purge path.
> > As for shrinker, once it hits us we drain pools entirely.
> 
> Why does purge need to be different to shrinking?
> 
> But, regardless, you can still use llist with an atomic counter to
> do this - there is no need for a spin lock at all.
> 
As i pointed earlier, i will have a look at it.

> > > > Anyway, i will have a look at this to see if llist is easy to go with
> > > > or not. If so i will send out a separate patch.
> > > 
> > > Sounds good, it was just something that crossed my mind given the
> > > pattern of "producer adds single items, consumer detaches entire
> > > list, processes it and reattaches remainder" is a perfect match for
> > > the llist structure.
> > > 
> > The llist_del_first() has to be serialized. For this purpose a per-cpu
> > pool would work or kind of "in_use" atomic that protects concurrent
> > removing.
> 
> So don't use llist_del_first().
> 
> > If we detach entire llist, then we need to keep track of last node
> > to add it later as a "batch" to already existing/populated list.
> 
> Why? I haven't see any need for ordering these lists which would
> requiring strict tail-add ordered semantics.
> 
I mean the following:

1. first = llist_del_all(&example);
2. last = llist_reverse_order(first);

4. va = __llist_del_first(first);

/*
 * "example" might not be empty, use the batch. Otherwise
 * we loose the entries "example" pointed to.
 */
3. llist_add_batch(first, last, &example);

--
Uladzislau Rezki

