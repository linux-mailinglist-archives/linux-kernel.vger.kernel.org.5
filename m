Return-Path: <linux-kernel+bounces-23308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6F82AAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23901F21F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260A10A0C;
	Thu, 11 Jan 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Ly0FBnKb"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3010940
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd2a584fbcso2655739b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704965110; x=1705569910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPRsV3mpGhgl4tIUNnxd2xjVM8/07Y43tjO1bvwG0Q8=;
        b=Ly0FBnKbsSQSQiG2JMCeWs4K3EyGkdwPEaBfNaOnxmgTX/11qpwDbf2c8WRn4u/WYL
         AVgS0N4ipmlRI2+XE0gw8IkW7ChI8Guhke/r3pRAwFWB8+nyVg1nE8P8ccqquoK7/Gm1
         vQxGS4tgtgDXcU7YPPNfenJLFDqvsMzDUzY+t25gr4CZCQuhPrs/OWlZKvUQfSxyNKq8
         PgKME1RPv7ufMJ6aEpTWNsAHjhOk5QT8CWsI8CkROYd59gP0+MSRQjGnfRaShzZfNepe
         uiSiTj8dKypxT0sfKmT8GbiT74GU5rFLR9NM0RKhkBFK8CSrDKW+8Ez1wwfSd0Pb75QW
         +0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965110; x=1705569910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPRsV3mpGhgl4tIUNnxd2xjVM8/07Y43tjO1bvwG0Q8=;
        b=QeCmu1r1O3+zKEL+rVtB9i7cUze4UZUoCs1Z6m9S3dLBAu/FR5S4lHpHi+3yEdcco9
         dHRMMcUb5/3QQqWgKjdzMfYobSlSBLr8TvNGlIjmUEdSMQDZgkzmkuy7mD6TmTPVT8lp
         nYTYLNQYbv61qXAIHEwCq9ew5qbB1or/7029t7W81jZUxRHIygracfM3tIDpLJORGujZ
         btqf53e4/NAgzKqxePXgvNGgHXlfFqbvBzGq6nyd1Sd478/9uJMUGpBsYxjHa0Bm+IkO
         Z3hKW1Uyd4BCP1SlWG8b1XACNvcpI41HG4XFxoL87ab4C0FG/eM5uUY5MQX8q7PNsfHr
         ZfxA==
X-Gm-Message-State: AOJu0YwON82xGSQh4i68Sm57qbO9ZkihjmGxMQoohAyw+008PkoX6/ue
	JiZYDmTv7RoVxoiFwTQvmJHNxZfZ06i3Dg==
X-Google-Smtp-Source: AGHT+IEZJkHdKjVYcCRHPRa0m7EgOIyHW6Fngfug8G8Oi8WGZmvzxa4qkvyzCbfiIZPptwktvdeUhw==
X-Received: by 2002:a05:6808:1782:b0:3bd:3db7:402d with SMTP id bg2-20020a056808178200b003bd3db7402dmr1032846oib.89.1704965109927;
        Thu, 11 Jan 2024 01:25:09 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id fa2-20020a056a002d0200b006d9af8c25easm708198pfb.84.2024.01.11.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:25:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNrJD-008tBh-02;
	Thu, 11 Jan 2024 20:25:07 +1100
Date: Thu, 11 Jan 2024 20:25:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
Message-ID: <ZZ+z8vBl645FvxPq@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-11-urezki@gmail.com>

On Tue, Jan 02, 2024 at 07:46:32PM +0100, Uladzislau Rezki (Sony) wrote:
> A number of nodes which are used in the alloc/free paths is
> set based on num_possible_cpus() in a system. Please note a
> high limit threshold though is fixed and corresponds to 128
> nodes.

Large CPU count machines are NUMA machines. ALl of the allocation
and reclaim is NUMA node based i.e. a pgdat per NUMA node.

Shrinkers are also able to be run in a NUMA aware mode so that
per-node structures can be reclaimed similar to how per-node LRU
lists are scanned for reclaim.

Hence I'm left to wonder if it would be better to have a vmalloc
area per pgdat (or sub-node cluster) rather than just base the
number on CPU count and then have an arbitrary maximum number when
we get to 128 CPU cores. We can have 128 CPU cores in a
single socket these days, so not being able to scale the vmalloc
areas beyond a single socket seems like a bit of a limitation.

Scaling out the vmalloc areas in a NUMA aware fashion allows the
shrinker to be run in numa aware mode, which gets rid of the need
for the global shrinker to loop over every single vmap area in every
shrinker invocation. Only the vm areas on the node that has a memory
shortage need to be scanned and reclaimed, it doesn't need reclaim
everything globally when a single node runs out of memory.

Yes, this may not give quite as good microbenchmark scalability
results, but being able to locate each vm area in node local memory
and have operation on them largely isolated to node-local tasks and
vmalloc area reclaim will work much better on large multi-socket
NUMA machines.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

