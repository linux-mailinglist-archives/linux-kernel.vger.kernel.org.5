Return-Path: <linux-kernel+bounces-120517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9DA88D89B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8C7B237B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EE2D047;
	Wed, 27 Mar 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6/fSfD7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F93DAC19
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527509; cv=none; b=f4tg3uFeY582oREUUMG857ZeuyhtobbafZjYn86RJe0oMmLwTf1ruFTYmHtC6YVOK2Lihcs5OTvqCEpPwUFhfBpaOEN+9lZ+dfWf4fIP76jpbjCa7Cj2CYEaYa5ux72lzd7tY6gPGGqh6hLwwSsHuLWrQkHaMhB/t3ztoaL3IyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527509; c=relaxed/simple;
	bh=4wWd4i/vKGYQmj3wwF8rqhpT36RPM/HAKao0l4UPWdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fw1Kqa5QIOD2jxKRoaKgNbVWFb94rOVcnpv5dO0mnZLv8y/ptJ5bmLlmpQhHxBithg/rKFIhPh06rCWARmNmnDiXqKZIdaIaox0n+1t4T8dn0H3IpeCKa2Dr4LSERcc/fP5sgC5WmSZHpl7mOZ0RE4jjc5d1Am3YApNUpU2Bhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6/fSfD7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711527508; x=1743063508;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4wWd4i/vKGYQmj3wwF8rqhpT36RPM/HAKao0l4UPWdo=;
  b=R6/fSfD7XOGtz5HZ5bSK35OWPsVWTtIcGxRo1/GuySS02XIZ8T7nlgZo
   jsuh4ktB5VvMEomgqa7eDgx5OQwepkqDN62yVNddw+MXOAlJjxBHZiOVU
   INXvXP9HhQPRDhMUSgYH+VnUxQb3gcMe3otGpUUNLrQeVR6G8I+Wm5KsL
   VNyKIKbvDwIj+yOEOE/CUpw17Y2itLCmBWMhbtXSv11Rw9lG/wKBWmr1p
   3mA+/BnMv5hjuHX2ae1U+er4ItuXjT+gvBweoMgx9fGYhe3Ed+WVWGhkX
   L6Lbm5GjhxDShECRrBtL4Twcw9HXBP3XEFL2jdl75HhbJXTzbnDeKLVVV
   Q==;
X-CSE-ConnectionGUID: nS42qyC0TkKnkhwAo5Iu2A==
X-CSE-MsgGUID: KicvrPliTQWhxKCe5pi+sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="32055610"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="32055610"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16156089"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:18:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Yu Zhao <yuzhao@google.com>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Nhat Pham <nphamcs@gmail.com>,  Chengming
 Zhou <zhouchengming@bytedance.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
In-Reply-To: <CAMgjq7D9-6JXOzpd18t8MSBAotHgEG2YZbi4efNkJiwiSJyJmw@mail.gmail.com>
	(Kairui Song's message of "Wed, 27 Mar 2024 15:14:03 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<20240326185032.72159-11-ryncsn@gmail.com>
	<87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7A-TxWkNKz0wwjaf0C-KZgps-VdPG+QcpY9tMmBY04TNA@mail.gmail.com>
	<87r0fwmar4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7D9-6JXOzpd18t8MSBAotHgEG2YZbi4efNkJiwiSJyJmw@mail.gmail.com>
Date: Wed, 27 Mar 2024 16:16:30 +0800
Message-ID: <87il18m6n5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Mar 27, 2024 at 2:49=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > On Wed, Mar 27, 2024 at 2:24=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Kairui Song <ryncsn@gmail.com> writes:
>> >>
>> >> > From: Kairui Song <kasong@tencent.com>
>> >> >
>> >> > Interestingly the major performance overhead of synchronous is actu=
ally
>> >> > from the workingset nodes update, that's because synchronous swap in
>> >>
>> >> If it's the major overhead, why not make it the first optimization?
>> >
>> > This performance issue became much more obvious after doing other
>> > optimizations, and other optimizations are for general swapin not only
>> > for synchronous swapin, that's also how I optimized things step by
>> > step, so I kept my patch order...
>> >
>> > And it is easier to do this after Patch 8/10 which introduces the new
>> > interface for swap cache.
>> >
>> >>
>> >> > keeps adding single folios into a xa_node, making the node no longer
>> >> > a shadow node and have to be removed from shadow_nodes, then remove
>> >> > the folio very shortly and making the node a shadow node again,
>> >> > so it has to add back to the shadow_nodes.
>> >>
>> >> The folio is removed only if should_try_to_free_swap() returns true?
>> >>
>> >> > Mark synchronous swapin folio with a special bit in swap entry embe=
dded
>> >> > in folio->swap, as we still have some usable bits there. Skip worki=
ngset
>> >> > node update on insertion of such folio because it will be removed v=
ery
>> >> > quickly, and will trigger the update ensuring the workingset info is
>> >> > eventual consensus.
>> >>
>> >> Is this safe?  Is it possible for the shadow node to be reclaimed aft=
er
>> >> the folio are added into node and before being removed?
>> >
>> > If a xa node contains any non-shadow entry, it can't be reclaimed,
>> > shadow_lru_isolate will check and skip such nodes in case of race.
>>
>> In shadow_lru_isolate(),
>>
>>         /*
>>          * The nodes should only contain one or more shadow entries,
>>          * no pages, so we expect to be able to remove them all and
>>          * delete and free the empty node afterwards.
>>          */
>>         if (WARN_ON_ONCE(!node->nr_values))
>>                 goto out_invalid;
>>         if (WARN_ON_ONCE(node->count !=3D node->nr_values))
>>                 goto out_invalid;
>>
>> So, this isn't considered normal and will cause warning now.
>
> Yes, I added an exception in this patch:
> -       if (WARN_ON_ONCE(node->count !=3D node->nr_values))
> +       if (WARN_ON_ONCE(node->count !=3D node->nr_values &&
> mapping->host !=3D NULL))
>
> The code is not a good final solution, but the idea might not be that
> bad, list_lru provides many operations like LRU_ROTATE, we can even
> lazy remove all the nodes as a general optimization, or add a
> threshold for adding/removing a node from LRU.

We can compare different solutions.  For this one, we still need to deal
with the cases where the folio isn't removed from the swap cache, that
is, should_try_to_free_swap() returns false.

>>
>> >>
>> >> If so, we may consider some other methods.  Make shadow_nodes per-cpu?
>> >
>> > That's also an alternative solution if there are other risks.
>>
>> This appears a general optimization and more clean.
>
> I'm not sure if synchronization between CPUs will make more burden,
> because shadow nodes are globally shared, one node can be referenced
> by multiple CPUs, I can have a try to see if this is doable. Maybe a
> per-cpu batch is better but synchronization might still be an issue.

Yes.  Per-CPU shadow_nodes needs to find list from shadow node.  That
has some overhead.

If lock contention on list_lru lock is the root cause, we can use hashed
shadow node lists.  That can reduce lock contention effectively.

--
Best Regards,
Huang, Ying

