Return-Path: <linux-kernel+bounces-31024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77E8327B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67F91F21B25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670048CC7;
	Fri, 19 Jan 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUUyhBH8"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D703487A7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660329; cv=none; b=uXV659FfWMG9WCXRQAfm7+qNaZShzZeq2Hq9OcV0XmCAC5GN6r4TtIL0g7zjsNYKLvdlwZNWsPzGMkowo0bcJMtVH2+WiYB+He0whuABJUL7i8ce+BV4dQ9DNBLOrkHGlN6PcHqh9ikVFFl7LgtFfiibLJOIqX2ydijL/m4kWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660329; c=relaxed/simple;
	bh=hhcYECyV7+bFKK60KbTVv4cu4ec7RFr4zwLArDmgkyw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjyMJ8iEsKOJ9+KW6Tuvqldm8mvcfkTIIyHfFTgqn7bBahJEn81KvItXMNlq/LrMWr1H4fC7x4LqQOHca44T/d0Exp08Q2izUM4F8Pvd7WV8bGukJTHxE95nmPx8lMjr9KqfQdqyG4G5IJLVxl7UN+G3ZN1Bu/7nC4YO/+Dwe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUUyhBH8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea98440a7so627517e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705660326; x=1706265126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY3pcmZeAfFwTUA8BZh2m7xC5Kmh5ZWYNrlewU2WALI=;
        b=CUUyhBH8aaKAnt8VVdA3IAc3pPx66vRgtaT9GXvSL5uLHv7iZq7Qzz1rhM1ZGKHPyI
         C8vVC9nBDqB/VmQuh8H71PtuJzbI+VhzpcOfC59Adm+lfSLGlgX7cUym3jmU9JuR46OR
         qBhLlhdvf8Pt51jxF2BCfNIG8VDRkMzFzy6CmNmte/eL7dX7muVp0fE3TH3VXnit7Fmu
         pxZBDyEAqfP72BbLfIquV3JKLOobKdFLw7KE8ANcN81B0fzvwe6NXTPTS8rcs1oX6Vcy
         wzbohiv6abdxFSFCfn1ZlMyNQjlEmPrTRIZTPORd3JjK/iXTrFSADJYrVzOw/w8P8q3+
         XpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705660326; x=1706265126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY3pcmZeAfFwTUA8BZh2m7xC5Kmh5ZWYNrlewU2WALI=;
        b=FoFXawgTe08iTPXOZb20wbNiGpGBiKH7L5AWrz00uD64AwBXmA0bjgQMtcGXtGJaGA
         Wp7RWw3s8TzUPCUbDZfPetbspKKvaysQ9/eqdS5KhG5G7Wq9jxXxsiNdoJBT3Ncn4TLN
         /BsLRW2CCCAab5u/pLSB0cEMgkNpV7v92PKIu1E668RYUv8QonLozKy8VacrItYwU/Im
         MbkNJMiNY6/a1xOtNeIGc2BT9HzxB6qK/WbGGCmtv/wZaC7wkBwlcsnMgd9sKc0mQOF7
         MhMu4DdrUfo44Gpgy5+46DhtOoh7Y/rgeaBj6L8wEZJUI/nLVPI6zDJNSKZf/2Q6tnYu
         DMyQ==
X-Gm-Message-State: AOJu0YzUcckqCJReDrBnUXPEvHOhVXPbtvm34p7QU3z84+uIWZRPzSPN
	YzjKUx7FzlkAuWtdyJSvQ2s4uNu2pVotNmdv2rajoI6vglOspk/T
X-Google-Smtp-Source: AGHT+IFPAWddW55WuSTgI91pRgJ/BAP4LB6YI8g8pVbvW/S8MdHtqX+ruMKIzRy/sVrNZr0QjZXFEg==
X-Received: by 2002:a05:6512:79:b0:50e:9367:f0ad with SMTP id i25-20020a056512007900b0050e9367f0admr359447lfo.58.1705660325771;
        Fri, 19 Jan 2024 02:32:05 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id u27-20020ac24c3b000000b0050e788fc8dasm917429lfq.272.2024.01.19.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:32:05 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 19 Jan 2024 11:32:02 +0100
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
Message-ID: <ZapPoj1vOOS9prT8@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
 <ZZ+z8vBl645FvxPq@dread.disaster.area>
 <ZaWC6TRs4P1vq9TQ@pc636>
 <Zab9yuUiz8OCMOHw@dread.disaster.area>
 <ZalssyzC8_HsFZON@pc636>
 <ZamX5QFjCTGJf52x@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZamX5QFjCTGJf52x@dread.disaster.area>

On Fri, Jan 19, 2024 at 08:28:05AM +1100, Dave Chinner wrote:
> On Thu, Jan 18, 2024 at 07:23:47PM +0100, Uladzislau Rezki wrote:
> > On Wed, Jan 17, 2024 at 09:06:02AM +1100, Dave Chinner wrote:
> > > On Mon, Jan 15, 2024 at 08:09:29PM +0100, Uladzislau Rezki wrote:
> > > > We can easily set nr_nodes to num_possible_cpus() and let it scale for
> > > > anyone. But before doing this, i would like to give it a try as a first
> > > > step because i have not tested it well on really big NUMA systems.
> > > 
> > > I don't think you need to have large NUMA systems to test it. We
> > > have the "fakenuma" feature for a reason.  Essentially, once you
> > > have enough CPU cores that catastrophic lock contention can be
> > > generated in a fast path (can take as few as 4-5 CPU cores), then
> > > you can effectively test NUMA scalability with fakenuma by creating
> > > nodes with >=8 CPUs each.
> > > 
> > > This is how I've done testing of numa aware algorithms (like
> > > shrinkers!) for the past decade - I haven't had direct access to a
> > > big NUMA machine since 2008, yet it's relatively trivial to test
> > > NUMA based scalability algorithms without them these days.
> > > 
> > I see your point. NUMA-aware scalability require reworking adding extra
> > layer that allows such scaling.
> > 
> > If the socket has 256 CPUs, how do scale VAs inside that node among
> > those CPUs?
> 
> It's called "sub-numa clustering" and is a bios option that presents
> large core count CPU packages as multiple NUMA nodes. See:
> 
> https://www.intel.com/content/www/us/en/developer/articles/technical/fourth-generation-xeon-scalable-family-overview.html
> 
> Essentially, large core count CPUs are a cluster of smaller core
> groups with their own resources and memory controllers. This is how
> they are laid out either on a single die (intel) or as a collection
> of smaller dies (AMD compute complexes) that are tied together by
> the interconnect between the LLCs and memory controllers. They only
> appear as a "unified" CPU because they are configured that way by
> the bios, but can also be configured to actually expose their inner
> non-uniform memory access topology for operating systems and
> application stacks that are NUMA aware (like Linux).
> 
> This means a "256 core" CPU would probably present as 16 smaller 16
> core CPUs each with their own L1/2/3 caches and memory controllers.
> IOWs, a single socket appears to the kernel as a 16 node NUMA system
> with 16 cores per node. Most NUMA aware scalability algorithms will
> work just fine with this sort setup - it's just another set of
> numbers in the NUMA distance table...
> 
Thank you for your input. I will go through it to see what we can
do in terms of NUMA-aware with thousands of CPUs in total.

Thanks!

--
Uladzislau Rezki


