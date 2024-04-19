Return-Path: <linux-kernel+bounces-151040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FFE8AA83D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5191F21E80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88900C15D;
	Fri, 19 Apr 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgcAgaqZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7158883D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506909; cv=none; b=FR9S4NJlMl0keu0z0Llhkrw7HNG1/wwXWw5uzMjatjlRB10/nQBXNsUhehtLHqMHUbTMssAqo7rupGYgQCGg9h1OHkQJDG1BI06licbx3QNKfEVAg5bWDIQsyxPVyAj68TgvYWEtPYxCqm5ucaBI/uSrQHdCJ3M/AkIs87t4f4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506909; c=relaxed/simple;
	bh=IGgBgBEQSVCduTNe5O0kJ/Q4QAhHDWDQ/BCjoNwvD94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxyqS11JLRzcrEyJhOTZhxNKPz93MhvrApiVS9m/KDb5/KDeKFtrGIyIjaX4oH9Y92SwKcbGthntX+rS6jd7m/p5rw3RosU/8IeT7PGlasCrfKU6Pv+actM8HV2rW4JLYv40KI8uCNhB+bgpxtvLdRO8PaC5DUX8IFY/6P2oUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgcAgaqZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713506908; x=1745042908;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IGgBgBEQSVCduTNe5O0kJ/Q4QAhHDWDQ/BCjoNwvD94=;
  b=bgcAgaqZ0Y3u1Tzs5R/xz4NKm5ffb9+7K1bXNE+sG+wU3yw8Z6TONUen
   Cyx/ntZCCxGJYmFXjZ07992widvjyUKfwL4X07XCYXwM5P7uy7i48Qr8G
   hpQPuxpg9hITDPGw7TH6xMpbU5qSragEoyoe+gNh8nNXpUtSfV9A1HQYK
   NAIdjwLF4IWnjwUsY0icw26CR+4vWESQ/GJE0aPxlhQiFQEbuolHAd5iN
   usHanV/4yEPH0m+pFJVedM2pKePWTciCgRWebKulwTG9z1MsKrKgOivb1
   LcpDgI9nPqR0jOMDLk5fsSWdGvyBhCX9a/PQka9L0bVQlfOQY9Af0jnWZ
   w==;
X-CSE-ConnectionGUID: 0c9TwF87QkiU2/BrEFZoYA==
X-CSE-MsgGUID: bVOhgLFQSuyCQ6SN8oTWeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="34488721"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34488721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 23:08:27 -0700
X-CSE-ConnectionGUID: oSQ2sxIETgOqx4gKNvbBZQ==
X-CSE-MsgGUID: /mLe0RBqSluD0+4HvwAzUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27886071"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 23:08:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <akpm@linux-foundation.org>,
  <vernhao@tencent.com>,  <mgorman@techsingularity.net>,
  <hughd@google.com>,  <willy@infradead.org>,  <david@redhat.com>,
  <peterz@infradead.org>,  <luto@kernel.org>,  <tglx@linutronix.de>,
  <mingo@redhat.com>,  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,
  <rjgolo@gmail.com>
Subject: Re: [PATCH v9 rebase on mm-unstable 0/8] Reduce tlb and interrupt
 numbers over 90% by improving folio migration
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com> (Byungchul Park's
	message of "Thu, 18 Apr 2024 15:15:28 +0900")
References: <20240418061536.11645-1-byungchul@sk.com>
Date: Fri, 19 Apr 2024 14:06:30 +0800
Message-ID: <87cyqlyjh5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> Hi everyone,
>
> While I'm working with a tiered memory system e.g. CXL memory, I have
> been facing migration overhead esp. tlb shootdown on promotion or
> demotion between different tiers.  Yeah..  most tlb shootdowns on
> migration through hinting fault can be avoided thanks to Huang Ying's
> work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> is inaccessible").  See the following link for more information:
>
> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
>
> However, it's only for ones using hinting fault.  I thought it'd be much
> better if we have a general mechanism to reduce all tlb numbers that we
> can ultimately apply to any type of migration.
>
> I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
> Copy', to reduce tlb numbers by deferring tlb flush until the source
> folios at migration actually become used, of course, only if the target
> PTE don't have write permission.
>
> To achieve that:
>
>    1. For the folios that map only to non-writable tlb entries, prevent
>       tlb flush during migration but perform it just before the source
>       folios actually become used out of buddy or pcp.
>
>    2. When any non-writable tlb entry changes to writable e.g. through
>       fault handler, give up migrc mechanism and perform tlb flush
>       required right away.
>
> No matter what type of workload is used for performance evaluation, the
> result would be positive thanks to the unconditional reduction of tlb
> flushes, tlb misses and interrupts.  For the test, I picked up XSBench
> that is widely used for performance analysis on high performance
> computing architectures - https://github.com/ANL-CESAR/XSBench.
>
> The result would depend on memory latency and how often reclaim runs,
> which implies tlb miss overhead and how many times migration happens.
> The slower the memory is and the more reclaim runs, the better migrc
> works so as to obtain the better result.  In my system, the result
> shows:
>
>    1. itlb flushes are reduced over 90%.
>    2. itlb misses are reduced over 30%.
>    3. All the other tlb numbers also get enhanced.
>    4. tlb shootdown interrupts are reduced over 90%.
>    5. The test program runtime is reduced over 5%.
>
> The test envitonment:
>
>    Architecture - x86_64
>    QEMU - kvm enabled, host cpu

The test is run in VM?  Do you have test results in bare metal
environment?

>    Numa - 2 nodes (16 CPUs 1GB, no CPUs 99GB)

The configuration looks quite abnormal.  Have you tested with other
configuration, such 1:4 or 1:8?

>    Linux Kernel - v6.9-rc4, numa balancing tiering on, demotion enabled
>
> < measurement: raw data - tlb and interrupt numbers >
>
>    $ perf stat -a \
>            -e itlb.itlb_flush \
>            -e tlb_flush.dtlb_thread \
>            -e tlb_flush.stlb_any \
>            -e dtlb-load-misses \
>            -e dtlb-store-misses \
>            -e itlb-load-misses \
>            XSBench -t 16 -p 50000000
>
>    $ grep "TLB shootdowns" /proc/interrupts
>
>    BEFORE
>    ------
>    40417078     itlb.itlb_flush
>    234852566    tlb_flush.dtlb_thread
>    153192357    tlb_flush.stlb_any
>    119001107892 dTLB-load-misses
>    307921167    dTLB-store-misses
>    1355272118   iTLB-load-misses
>
>    TLB: 1364803    1303670    1333921    1349607
>         1356934    1354216    1332972    1342842
>         1350265    1316443    1355928    1360793
>         1298239    1326358    1343006    1340971
>         TLB shootdowns
>
>    AFTER
>    -----
>    3316495      itlb.itlb_flush
>    138912511    tlb_flush.dtlb_thread
>    115199341    tlb_flush.stlb_any
>    117610390021 dTLB-load-misses
>    198042233    dTLB-store-misses
>    840066984    iTLB-load-misses
>
>    TLB: 117257     119219     117178     115737
>         117967     118948     117508     116079
>         116962     117266     117320     117215
>         105808     103934     115672     117610
>         TLB shootdowns
>
> < measurement: user experience - runtime >
>
>    $ time XSBench -t 16 -p 50000000
>
>    BEFORE
>    ------
>    Threads:     16
>    Runtime:     968.783 seconds
>    Lookups:     1,700,000,000
>    Lookups/s:   1,754,778
>
>    15208.91s user 141.44s system 1564% cpu 16:20.98 total
>
>    AFTER
>    -----
>    Threads:     16
>    Runtime:     913.210 seconds
>    Lookups:     1,700,000,000
>    Lookups/s:   1,861,565
>
>    14351.69s user 138.23s system 1565% cpu 15:25.47 total

IIUC, the memory footprint will be larger with the patchset.  Do you
have data?

--
Best Regards,
Huang, Ying

