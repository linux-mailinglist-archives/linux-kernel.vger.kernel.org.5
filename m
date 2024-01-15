Return-Path: <linux-kernel+bounces-26428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589482E078
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB81C21357
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5E18ED4;
	Mon, 15 Jan 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqDGp8n5"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970718EBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso12183616e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705345772; x=1705950572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1a7253dNU4a2MSBXxXCeQK7ThZfa8a5dh+VEk56Y+0=;
        b=DqDGp8n5c539xBNQYEhbeLvq+uxDNQrrSaIhroUpgtfAibuUmIlWPO+LWnaAHCJT35
         1UVQCLkcLsk9qRnCpM0ypTmeXykzFXtOc301UHWjaJg2GxSeEJS0dDyQavczJdAfRUvI
         VNz6RaBEtF2NTnVFJ0Zv7lrAir4XYBGAWdrUq1A7mdNmbgS6TdtlQNhGXZevaGN3DYfq
         oRbDagTb0xaB+3F4sjO1gLqokbgWehC/Mn59K3iFKFYz3RCoJ7Teo5cT1Cp+rrK/XG4q
         ulMo38/560zON0f9qOfUSCt3tXKt0YoC6EJ1m4v9nSFNe424EggN7ICrc4VcMKJnw3ZJ
         NgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705345772; x=1705950572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1a7253dNU4a2MSBXxXCeQK7ThZfa8a5dh+VEk56Y+0=;
        b=VxIKXtigDTTgbG2pbKYcjx+hLald55b/KcSYjqwp0g3/CZvwRvIQ9D8sPsiTXtji+N
         Hbq+1qDPZU9AXgehQKw7aEvUyDQ3Qxtizy7V7niuYqqEoTxJTvuViwe1naNfNmykJWE7
         7vIMLEp3nT9bWOSNHptVmj0C7zm00S2MktNQraVQUyUS8u4fHXCLKOxQ/pY7Ux+UkFxR
         DZi1W/hyezUld9ylRtAQmsbhFy/L7KdipxJwHgDlqVNd5HHYsYvYQi2eksvHGnmK23v7
         aTc8ZGQZCbXf51LKBsCMj3E48it6k7gwC7ttIVnm/wbxwilpjSkr0JjGJAV01lNKdsB8
         PpCg==
X-Gm-Message-State: AOJu0YztANrLWqKycsZN3eHI2GArhJ3gzxhY337p54i+oCMQdPsbAgbE
	Wohi78XrXANNIhhED6ytdS0=
X-Google-Smtp-Source: AGHT+IHr3cFy9mv+SiGi6cqh5ydwfEFrWo8HMNEimL88GvtST76NarrqSXvtGV6Qd1FEkIFCzsZn9A==
X-Received: by 2002:a05:6512:159f:b0:50e:d5e2:92cc with SMTP id bp31-20020a056512159f00b0050ed5e292ccmr3845250lfb.81.1705345771992;
        Mon, 15 Jan 2024 11:09:31 -0800 (PST)
Received: from pc636 (host-90-233-221-202.mobileonline.telia.com. [90.233.221.202])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25628000000b0050eac86fc74sm1541332lff.87.2024.01.15.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 11:09:31 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 15 Jan 2024 20:09:29 +0100
To: Dave Chinner <david@fromorbit.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <ZaWC6TRs4P1vq9TQ@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-11-urezki@gmail.com>
 <ZZ+z8vBl645FvxPq@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ+z8vBl645FvxPq@dread.disaster.area>

> On Tue, Jan 02, 2024 at 07:46:32PM +0100, Uladzislau Rezki (Sony) wrote:
> > A number of nodes which are used in the alloc/free paths is
> > set based on num_possible_cpus() in a system. Please note a
> > high limit threshold though is fixed and corresponds to 128
> > nodes.
> 
> Large CPU count machines are NUMA machines. ALl of the allocation
> and reclaim is NUMA node based i.e. a pgdat per NUMA node.
> 
> Shrinkers are also able to be run in a NUMA aware mode so that
> per-node structures can be reclaimed similar to how per-node LRU
> lists are scanned for reclaim.
> 
> Hence I'm left to wonder if it would be better to have a vmalloc
> area per pgdat (or sub-node cluster) rather than just base the
> number on CPU count and then have an arbitrary maximum number when
> we get to 128 CPU cores. We can have 128 CPU cores in a
> single socket these days, so not being able to scale the vmalloc
> areas beyond a single socket seems like a bit of a limitation.
> 
>
> Hence I'm left to wonder if it would be better to have a vmalloc
> area per pgdat (or sub-node cluster) rather than just base the
>
> Scaling out the vmalloc areas in a NUMA aware fashion allows the
> shrinker to be run in numa aware mode, which gets rid of the need
> for the global shrinker to loop over every single vmap area in every
> shrinker invocation. Only the vm areas on the node that has a memory
> shortage need to be scanned and reclaimed, it doesn't need reclaim
> everything globally when a single node runs out of memory.
> 
> Yes, this may not give quite as good microbenchmark scalability
> results, but being able to locate each vm area in node local memory
> and have operation on them largely isolated to node-local tasks and
> vmalloc area reclaim will work much better on large multi-socket
> NUMA machines.
> 
Currently i fix the max nodes number to 128. This is because i do not
have an access to such big NUMA systems whereas i do have an access to
around ~128 ones. That is why i have decided to stop on that number as
of now.

We can easily set nr_nodes to num_possible_cpus() and let it scale for
anyone. But before doing this, i would like to give it a try as a first
step because i have not tested it well on really big NUMA systems.

Thanks for you NUMA-aware input.

--
Uladzislau Rezki

