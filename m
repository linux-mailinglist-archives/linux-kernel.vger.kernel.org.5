Return-Path: <linux-kernel+bounces-147830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA88A7A35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224A31C215F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6991C02;
	Wed, 17 Apr 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNTmMxnF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5C1860
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318028; cv=none; b=H0CwXrJKMwD0jedy/mW8EjDm0PgWo7EI0dFSDQtfpEfyNYbwlD7cBlocJ/Zs8tmuDSIYPts/ue4vYyu+gDD58IJs97nqKxMxcSaA6m+wAgHdD966xB6DHq3T4WeelxpJImzSfjGX5syN3mKFZiuPbh6n9OEE5iF1AHp5dnhgBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318028; c=relaxed/simple;
	bh=IeBGe3MQxZXvfL2tvMUmEd6ECEsTggUCdjsGjqXHtTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSGS/Hh3lPfKTm7//5PNZpIVPj5MifBsYTWbPk1lo896FrNzZDIhQIXedJdGCCgaM338AI3P9PO3vAVAhneCz8DJNrksFoOCWeLPtmWFIlB3jkB0LCZt6aDSZUVcL3AoNDwp8VRWGEs3JOXnuIGMhhO4DikimTBHFRXoCB4B3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNTmMxnF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713318026; x=1744854026;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=IeBGe3MQxZXvfL2tvMUmEd6ECEsTggUCdjsGjqXHtTc=;
  b=jNTmMxnFs++HOsdmEW35JxGtAt7t+kYwmpWxnyAwTuEpXdXcdSvYfDj3
   2igxO73y/bZBn6KEiDsKN7bu0KUCFzZiaPsK1Ivet4BUtsM/J1CFI3iED
   lgxpz8bwWJp7WIFn+DyY19e8EGI95aB56MpcBLDbf15eSaBJb2o2Efa53
   3JaygpXdFFZ+1fg5becPbdqDU/A4j/hrsTZGpCyHW7bqufNMA4z72QcD/
   TJmes8WYp/+K2BKKRNtyFESQDYvzkOFoNqNU5fjkhSDUxWsfBzWq6uqvL
   DEgO7DdyPq95RQk5gzY9voOeMRvJIYolXHzFLqmLSxoyYw2PyUK+T3qFF
   Q==;
X-CSE-ConnectionGUID: a5cyzbNNSXGyVu6PZL53Xw==
X-CSE-MsgGUID: EUpIf1DwSVShkz75ee02rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9011215"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="9011215"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 18:40:20 -0700
X-CSE-ConnectionGUID: J5h0IzEuSx634XtdGIUREw==
X-CSE-MsgGUID: eaFEIr0XRHmCki3nsnUJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22932664"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 18:40:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
In-Reply-To: <CAGsJ_4yoz=UH+=Z+ZmRy_9=vu_JWuOXnNO0gFtkBZ-rKJppMPA@mail.gmail.com>
	(Barry Song's message of "Wed, 17 Apr 2024 09:16:01 +0800")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-6-21cnbao@gmail.com>
	<87frvk24x8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yoz=UH+=Z+ZmRy_9=vu_JWuOXnNO0gFtkBZ-rKJppMPA@mail.gmail.com>
Date: Wed, 17 Apr 2024 09:38:22 +0800
Message-ID: <87bk6822gh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Wed, Apr 17, 2024 at 8:47=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > Currently, we are handling the scenario where we've hit a
>> > large folio in the swapcache, and the reclaiming process
>> > for this large folio is still ongoing.
>> >
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > ---
>> >  include/linux/huge_mm.h | 1 +
>> >  mm/huge_memory.c        | 2 ++
>> >  mm/memory.c             | 1 +
>> >  3 files changed, 4 insertions(+)
>> >
>> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> > index c8256af83e33..b67294d5814f 100644
>> > --- a/include/linux/huge_mm.h
>> > +++ b/include/linux/huge_mm.h
>> > @@ -269,6 +269,7 @@ enum mthp_stat_item {
>> >       MTHP_STAT_ANON_ALLOC_FALLBACK,
>> >       MTHP_STAT_ANON_SWPOUT,
>> >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
>> > +     MTHP_STAT_ANON_SWPIN_REFAULT,
>>
>> This is different from the refault concept used in other place in mm
>> subystem.  Please check the following code
>>
>>         if (shadow)
>>                 workingset_refault(folio, shadow);
>>
>> in __read_swap_cache_async().
>
> right. it is slightly different as refault can also cover the case folios
> have been entirely released and a new page fault happens soon
> after it.
> Do you have a better name for this?
> MTHP_STAT_ANON_SWPIN_UNDER_RECLAIM
> or
> MTHP_STAT_ANON_SWPIN_RECLAIMING ?

TBH, I don't think we need this counter.  It's important for you during
implementation.  But I don't think it's important for end users.

--
Best Regards,
Huang, Ying

>>
>> >       __MTHP_STAT_COUNT
>> >  };
>>
>> --
>> Best Regards,
>> Huang, Ying
>>
>> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > index d8d2ed80b0bf..fb95345b0bde 100644
>> > --- a/mm/huge_memory.c
>> > +++ b/mm/huge_memory.c
>> > @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON=
_ALLOC);
>> >  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLB=
ACK);
>> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FAL=
LBACK);
>> > +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAUL=
T);
>> >
>> >  static struct attribute *stats_attrs[] =3D {
>> >       &anon_alloc_attr.attr,
>> >       &anon_alloc_fallback_attr.attr,
>> >       &anon_swpout_attr.attr,
>> >       &anon_swpout_fallback_attr.attr,
>> > +     &anon_swpin_refault_attr.attr,
>> >       NULL,
>> >  };
>> >
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index 9818dc1893c8..acc023795a4d 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >               nr_pages =3D nr;
>> >               entry =3D folio->swap;
>> >               page =3D &folio->page;
>> > +             count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN=
_REFAULT);
>> >       }
>> >
>> >  check_pte:

