Return-Path: <linux-kernel+bounces-109164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A352A881598
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0161CB23BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0254FAA;
	Wed, 20 Mar 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="w/9nXy0I"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D854F91
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951998; cv=none; b=SweALANrgLv/Rlz8DGnO/3K5uh5I0O4SUQ3/9cwAw3WH71xOFMv0/ZSP/U1JgwE4WhfU7d8a1z47VIm5YlGwCLv8UApU0PBFMzXFGY2fQZa+D8GxhB4PnbSNx0oCf/zP6GPCnHwTOriZp8xaLvtNP2PyWj9TzU3TQm7P0URLcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951998; c=relaxed/simple;
	bh=FfQXqQTqxprasFQA5/334WseHrA55WQtEW3YznheWUI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=JB/aqNjyHKUnF6PFlHFgzyJzboNW/p40Byu8rZNq8wUzoKHV4HZnbtavRAn7i08bmQEUqXe7dHjabtLf5imeFQ7WePfjk5dDd4fW4tYM0G1Da5p9epn6lDsvD+pykzAnJs/toAR3F2lwJ6bwWKR/bqUVdY2Pd4Jsq+HO9Oy3KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=w/9nXy0I; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710951988;
	bh=FfQXqQTqxprasFQA5/334WseHrA55WQtEW3YznheWUI=;
	h=Date:From:To:Cc:Subject:From;
	b=w/9nXy0IGUf9pVQPcvRVZOLdrt53zmoG0+uXJLi1hY32TQU9I8wIBUm2PBbjdstVS
	 0aACOB5YcpOuvrhjTdfdJSusQswbJI9G2ZcjSujk5h3/63N98KfmzMY6FqpMPikhOD
	 NfKYaxUeQ6wvqk8ft3H7n6nuisqjLjORCEBiHOAoDAh1v/nFveuW4D9nGilxO6o6q6
	 cx16Y2By/qFIchJ5ijgwEmnwRKI4il/d4lTXj9MbUF44HaOaqOJPk/M3w1m92cCMVS
	 4w0pmVeS4xQUQouK6QlFBPAdwgifskZZWZ0mAW+89U5Dhijkupg/gAADVDlHITpB/+
	 yHaho5bVXjTeg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V0DVq6FgCzkh1;
	Wed, 20 Mar 2024 12:26:27 -0400 (EDT)
Message-ID: <218bd8f1-d382-4024-a90f-59b5fef5184a@efficios.com>
Date: Wed, 20 Mar 2024 12:26:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "carlos@redhat.com" <carlos@redhat.com>, DJ Delorie <dj@redhat.com>,
 Florian Weimer <fw@deneb.enyo.de>
Cc: Olivier Dion <odion@efficios.com>, Michael Jeanson
 <mjeanson@efficios.com>, libc-alpha <libc-alpha@sourceware.org>,
 paulmck <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, linux-mm <linux-mm@kvack.org>
Subject: [RFC] A new per-cpu memory allocator for userspace in librseq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

When looking at what is missing make librseq a generally usable
project to support per-cpu data structures in user-space, I noticed
that what we miss is a per-cpu memory allocator conceptually similar
to what the Linux kernel internally provides [1].

The per-CPU memory allocator is analogous to TLS (Thread-Local
Storage) memory: TLS is Thread-Local Storage, whereas the per-CPU
memory allocator provides CPU-Local Storage.

My goal is to improve locality and remove the need to waste precious
cache lines with padding when indexing per-cpu data as an array of
items.

So we decided to go ahead and implement a per-cpu allocator for
userspace in the librseq project [2,3] with the following
characteristics:

* Allocations are performed in memory pools (mempool). Allocations
   are power of 2, fixed sized, configured at pool creation.

* Memory pools can be added to a pool set to allow allocation of
   variable size records.

* Allocating "items" from a memory pool allocates memory for all
   CPUs.

* The "stride" to index per-cpu data is user-configurable. Indexing
   per-cpu data from an allocated pointer is as simple as:

     (uintptr_t) ptr + (cpu * stride)

   Where the multiplication is actually a shift because stride is
   a power of 2 constant.

* Pools consist of a linked list of "ranges" (a stride worth of
   item allocation), thus making the pool extensible when running
   out of space, up to a user-configurable limit.

* Freeing a pointer only requires the pointer to free as input
   (and the pool stride constant). Finding the range and pool
   associated with the pointer is done by applying a mask to
   the pointer. The memory mappings of the ranges are aligned
   to make this mask find the range base, and thus allow accessing
   the range structure placed in a header page immediately before.

One interesting problem we faced is what should be done to prevent
wasting memory due to allocation of useless pages in a system where
there are lots of configured CPUs, but very few are actually used
by the application due to a combination of cpu affinity, cpusets,
and cpu hotplug. Minimizing the amount of page allocation while
offering the ability to allocate zeroed (or pre-initialized)
items is the crux of this issue.

We thus came up with two approaches based on copy-on-write (COW)
to tackle this, which we call the "pool populate policy":

* RSEQ_MEMPOOL_POPULATE_COW_INIT (default):

Rely on copy-on-write (COW) of per-cpu pages to populate per-cpu pages
from the initial values pages on first write.

The COW_INIT approach maps an extra "initial values" stride with each
pool range as MAP_SHARED from a memfd. All per-cpu strides map these
initial values as MAP_PRIVATE, so the first write access from an active
CPU will trigger a COW page allocation. The downside of this scheme
is that its use of MAP_SHARED is not compatible with using the pool
from children processes after fork, and its use of COW is not
compatible with shared memory use-cases.

* RSEQ_MEMPOOL_POPULATE_COW_ZERO:

Rely on copy-on-write (COW) of per-cpu pages to populate per-cpu pages
from the zero page on first write. As long as the user only uses malloc,
zmalloc, or malloc_init with zeroed content to allocate items, it does
not trigger COW of all per-cpu pages, leaving in place the zero page
until an active CPU writes to its per-cpu item.

The COW_ZERO approach maps the per-cpu strides as private anonymous
memory, and therefore only triggers COW page allocation when a CPU
writes over those zero pages. As a downside, this scheme will trigger
COW page allocation for all possible CPUs when using zmalloc_init()
to populate non-zeroed initial values for an item. Its upsides are
that this scheme can be used across fork and eventually can be used
over shared memory.

Other noteworthy features are that this mempool allocator can be
used as a global allocator as well. It has an optional "robust"
attribute which enables checks for memory corruption and
double-free.

Users with more custom use-cases can register an "init" callback
to be called for after each new range/cpu are allocated.

Feedback is welcome !

Thanks,

Mathieu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/percpu.h
[2] https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/include/rseq/mempool.h
[3] https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/src/rseq-mempool.c

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

