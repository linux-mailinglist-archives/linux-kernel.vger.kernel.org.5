Return-Path: <linux-kernel+bounces-133189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92289A020
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A684287672
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6E16F82A;
	Fri,  5 Apr 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwol0GCP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D116F280;
	Fri,  5 Apr 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328491; cv=none; b=LUFsDxlIPRpMyJylD3fmQLddTD+uCdz94Vpv1Z2lMUoeV3zHV0WBNh4cQx59G4MWbCZ9ttVj72o4dJvJW6A77hVXdflkdmObv+ModvsH82kAor28cz5Mu28ODBBs7OU2ZmYm6r/PzvxJh6V897dhwLJSBEwyaH5vZ3B4jNZC9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328491; c=relaxed/simple;
	bh=LreOfBm3nT3gJWEyzyhSzgs3L/UNn7htcugC08IxS+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhgyibBrjJJerqiN/xeELx8ulCCrttsO0ifuLkAQRilvHTt8dc17/78NwwTJnSXQEqrJQ8DisuzIHcFqbHjvPn01zf4LD/EJBHgwdOEMyr7Gr7BsIfFsUNcHoR6ig7bid8SbbcBFr9WiRyN282kf8SRPz1aT+thhXGL6mPaITkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwol0GCP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328490; x=1743864490;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LreOfBm3nT3gJWEyzyhSzgs3L/UNn7htcugC08IxS+o=;
  b=Dwol0GCPWx+Us9Nc1oDUYLAbXkYQJcB5drZ+e/z/NKeBnRPKlHflWqwg
   Yw4hfY96xZ99qi69FRx5ApTzn4s2dFblzbbBBZNmELoBZmGrLsyqtM1Tt
   7XjrCxjQMHslh/maB2ZlqYKL/yOQMjvgJRfWGYWnGNV7Vntchhy9rR8TZ
   Bb2dQ7D0gvEJ7yATUvatm8poVjm9GIXwUZIigfZX2E2sxkH557mmMjsO5
   rZ7L7bNjJUz2yHE8sx+31QYnqvC2LiTeEdXaUSgSRysjyX39H+VV/136X
   wLuzAh2SxZvbL9cXjjV9ut1CJiMFoQgDWGkSykGgExg565dSBn0UcBDyS
   g==;
X-CSE-ConnectionGUID: pNjzk4eXTSSVd+EE9ISQhg==
X-CSE-MsgGUID: xKDuxmsPSK60Uth0ervh2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11478923"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11478923"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:48:09 -0700
X-CSE-ConnectionGUID: H55LyW5ASaqr4vhL9J0MYQ==
X-CSE-MsgGUID: +963A5O0TASYUpMZv+tuJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23821308"
Received: from dtorrice-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.41.202])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:47:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, linux-xtensa@linux-xtensa.org, Arnd
 Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 loongarch@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Intel-gfx] [PATCH v5 0/7] Introduce __xchg, non-atomic xchg
In-Reply-To: <Y/y0/VoPAVCXGKp3@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <Y/ZLH5F8LA3H10aL@hirez.programming.kicks-ass.net>
 <17f40b7c-f98d-789d-fa19-12ec077b756a@intel.com>
 <Y/y0/VoPAVCXGKp3@hirez.programming.kicks-ass.net>
Date: Fri, 05 Apr 2024 17:47:56 +0300
Message-ID: <87r0fjc1cz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 27 Feb 2023, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 23, 2023 at 10:24:19PM +0100, Andrzej Hajda wrote:
>> On 22.02.2023 18:04, Peter Zijlstra wrote:
>> > On Wed, Jan 18, 2023 at 04:35:22PM +0100, Andrzej Hajda wrote:
>> > 
>> > > Andrzej Hajda (7):
>> > >    arch: rename all internal names __xchg to __arch_xchg
>> > >    linux/include: add non-atomic version of xchg
>> > >    arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
>> > >    llist: simplify __llist_del_all
>> > >    io_uring: use __xchg if possible
>> > >    qed: use __xchg if possible
>> > >    drm/i915/gt: use __xchg instead of internal helper
>> > 
>> > Nothing crazy in here I suppose, I somewhat wonder why you went through
>> > the trouble, but meh.
>> 
>> If you are asking why I have proposed this patchset, then the answer is
>> simple, 1st I've tried to find a way to move internal i915 helper to core
>> (see patch 7).
>> Then I was looking for possible other users of this helper. And apparently
>> there are many of them, patches 3-7 shows some.
>> 
>> 
>> > 
>> > You want me to take this through te locking tree (for the next cycle,
>> > not this one) where I normally take atomic things or does someone else
>> > want this?
>> 
>> If you could take it I will be happy.
>
> OK, I'll go queue it in tip/locking/core after -rc1. Thanks!

Is this where the series fell between the cracks, or was there some
follow-up that I missed?

I think this would still be useful. Andrzej, would you mind rebasing and
resending if there are no objections?

BR,
Jani.


-- 
Jani Nikula, Intel

