Return-Path: <linux-kernel+bounces-30578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003A8320E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AB328A00D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED2321A9;
	Thu, 18 Jan 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="h5rfm+hm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBD3218C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613290; cv=none; b=oUchSSsCTedwNzKr3wTdZ/y2a/yPEZAtuZ8D7OSFfgmd6yqZLiu0tSvTyjKzQ+Yon9HvTBksQJLPpk/T3y58pT71QJq7gwz0Ykshq2JWA2BFGReu3mVxu6PIIUvzR8SSN5sNbZo3xHsHiO7z3jnyuiZYGDz4HXvz20N/9FkHvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613290; c=relaxed/simple;
	bh=qEGyvV7cTPkrg03PHZEkL1PsEULKDENH28do95HphSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG6v1mqyBLFHHYdYo4p59DN8uzII4lgopEjWSEH5H6HFvzTnmz6x2xYlL3dOmV0ig7uQRkXCA6xXW2mqMSpM1BChqYblVlo1rkFl8J4K0Lz7B2vDZXmhXS405MXlh9KnBKpoSxSivuIXxxdrgQGqsxk4QmUes/fflFCm7CvFzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=h5rfm+hm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d714e224e0so527885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705613288; x=1706218088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfXI7DlSW6ALh9PfIlcP8DqohnuHMAHGyRd4yKfEq38=;
        b=h5rfm+hmX6rFBNgdqvccW1ERzsvTLUQtB7EP5WVNDqArz7LSEZV7cC6aqY8tF/SYI+
         Sh08UxAPU7PM/X4Topo6GqevFa+3F5s3uL0e9gtE5UULvJAIgew5uxFNawxSBMwkfW3C
         HdgXqNIuNOrtqqh0LVq9apkaxCeQHctLjBTK6xDNZOcog/U3MUS+1Qq0z0gFhPghBtp5
         FOrfbbICWZtkLEBXSeImFTu+aSYuUmGUaA7KsFrBlFpEa+D6UJGpXavf/Y3zHsapBTA+
         T/8cF/yiI8ijxezLfERKg2YCgftUJ87CROACN/x0duqDBRpZkD0ZuT1gaWCYEM6fp9KE
         cYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705613288; x=1706218088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfXI7DlSW6ALh9PfIlcP8DqohnuHMAHGyRd4yKfEq38=;
        b=fb+m3/GfR+i5GB6Fua7rRqNgiVjXvpzUkjHXWg+oKbun4YQiM485PXEI6d5GXy6ik0
         5ip9ozfIHiyWhiFgUmAlKs/v4Y46NrHAl1rTDqTGEVx/1SeEVeDM+7ovFt6yGgrZY0pB
         F7WekftlYrS8Z+BsUbAHHt0EhWFEnpygjHBCnTZ4NhGWNkxGJsrs2ll7JrvlPsr01O93
         IJDXpRndBPthgGb0HT0busCwXVNbFI9vscEwP1tllv/gtQwj0exsaGXRVcfRtf9KYUex
         faiwXuKWVuEhuozPU67ODvHbxqv7ETI0OXDiNpaDbmxzcfk+DuOwzVYHKguSGV/dEeQB
         rqeA==
X-Gm-Message-State: AOJu0Yx3RPQUKziTkZQ0Muwsx0wiChE2dmlMQDJjW2o/k4C/bY8kNaeg
	09gN0KMwbkeraf3NG6C62YdppfEpTqp4/LggwygCFh6YIfytq+GH9/7RLSR7UhE=
X-Google-Smtp-Source: AGHT+IEWphQifugTG5YpeZETo0xSFCI4jAza+OoIp4jZGWuGSdeybTelL15MNkAXe88QcyIPFXB/JA==
X-Received: by 2002:a17:902:db03:b0:1d4:e308:d70b with SMTP id m3-20020a170902db0300b001d4e308d70bmr1649884plx.92.1705613288623;
        Thu, 18 Jan 2024 13:28:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001d70953f166sm1448711plw.155.2024.01.18.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:28:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rQZvh-00CBNk-1c;
	Fri, 19 Jan 2024 08:28:05 +1100
Date: Fri, 19 Jan 2024 08:28:05 +1100
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
Message-ID: <ZamX5QFjCTGJf52x@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
 <ZZ+z8vBl645FvxPq@dread.disaster.area>
 <ZaWC6TRs4P1vq9TQ@pc636>
 <Zab9yuUiz8OCMOHw@dread.disaster.area>
 <ZalssyzC8_HsFZON@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZalssyzC8_HsFZON@pc636>

On Thu, Jan 18, 2024 at 07:23:47PM +0100, Uladzislau Rezki wrote:
> On Wed, Jan 17, 2024 at 09:06:02AM +1100, Dave Chinner wrote:
> > On Mon, Jan 15, 2024 at 08:09:29PM +0100, Uladzislau Rezki wrote:
> > > We can easily set nr_nodes to num_possible_cpus() and let it scale for
> > > anyone. But before doing this, i would like to give it a try as a first
> > > step because i have not tested it well on really big NUMA systems.
> > 
> > I don't think you need to have large NUMA systems to test it. We
> > have the "fakenuma" feature for a reason.  Essentially, once you
> > have enough CPU cores that catastrophic lock contention can be
> > generated in a fast path (can take as few as 4-5 CPU cores), then
> > you can effectively test NUMA scalability with fakenuma by creating
> > nodes with >=8 CPUs each.
> > 
> > This is how I've done testing of numa aware algorithms (like
> > shrinkers!) for the past decade - I haven't had direct access to a
> > big NUMA machine since 2008, yet it's relatively trivial to test
> > NUMA based scalability algorithms without them these days.
> > 
> I see your point. NUMA-aware scalability require reworking adding extra
> layer that allows such scaling.
> 
> If the socket has 256 CPUs, how do scale VAs inside that node among
> those CPUs?

It's called "sub-numa clustering" and is a bios option that presents
large core count CPU packages as multiple NUMA nodes. See:

https://www.intel.com/content/www/us/en/developer/articles/technical/fourth-generation-xeon-scalable-family-overview.html

Essentially, large core count CPUs are a cluster of smaller core
groups with their own resources and memory controllers. This is how
they are laid out either on a single die (intel) or as a collection
of smaller dies (AMD compute complexes) that are tied together by
the interconnect between the LLCs and memory controllers. They only
appear as a "unified" CPU because they are configured that way by
the bios, but can also be configured to actually expose their inner
non-uniform memory access topology for operating systems and
application stacks that are NUMA aware (like Linux).

This means a "256 core" CPU would probably present as 16 smaller 16
core CPUs each with their own L1/2/3 caches and memory controllers.
IOWs, a single socket appears to the kernel as a 16 node NUMA system
with 16 cores per node. Most NUMA aware scalability algorithms will
work just fine with this sort setup - it's just another set of
numbers in the NUMA distance table...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

