Return-Path: <linux-kernel+bounces-138645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC689F89C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953B91F31AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108615FA80;
	Wed, 10 Apr 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+wgZR98"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0A15B14C;
	Wed, 10 Apr 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756408; cv=none; b=CfKA1OoapHNMKTl2mFb4c1eJQqzZNr/53BjkMCPJETAA6zId9AJZOISM9/ks2KLk/d6jGAKeFsL0fW33Qq5l9TIxHJH1k/D8RvR+6r8pK3wG/x5eQf3T4WcMEK3hq7G5ORkrPaD2E3JOaFylgSmyGfusswH4rjKqESRJm8OjdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756408; c=relaxed/simple;
	bh=g5GZtmMc/oxPQ/MUhPM0fv4b39WzxMIrkEvxhBmKbec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEvkBvfDA9kHIvIG6X5wQgkEqeUW/pl8LR85SCGYkLdlBn2f9IBkbpr2K57t5EXCghcTq085VPGiHTZsFUUdXCFcxLpU5Jv63svLahHedLElh1R48+sHeq/Fmzw5WNLyViK2O877h39OrqOxmpn1NpMqx++N+54qMdNdbZnVZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+wgZR98; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756406; x=1744292406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5GZtmMc/oxPQ/MUhPM0fv4b39WzxMIrkEvxhBmKbec=;
  b=C+wgZR98yGi3CI1s7YyPwutahdUQ4v5fYHQoXY86DZKtkyf5hvHRcvNm
   GvRlTPjybKEEDZB4accCdVpqFBqtObcSLDt/eHln8otdvqjOp6joD+2WG
   0c6Unu02/uypKOq0WQpH2qvoCpfndkDP8TAQUqeGoNWDNXmy2+vUmruED
   9i5PEgj2OW83n+ioW6wSVrCXzeqEb7UMKfX8wjPbkEsZWXZfnK2RYHWnl
   TgYTKDMvku/elmwYUbDkS5yZNcEa546J2Pr8HpdD2Vy1zTpxSTlaLugB0
   wX+2Yo8bjV/EvTINu2cxYRpjIY3RrVwotwrpKDZ86gefHHZS4k9CqB2PS
   A==;
X-CSE-ConnectionGUID: 9K8VR/JlRWyLEB200Ab+aA==
X-CSE-MsgGUID: 8KEsxZ36SZq/im7+aibTxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11894475"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11894475"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:40:06 -0700
X-CSE-ConnectionGUID: lTKryyL+QPazrXmhATpbOg==
X-CSE-MsgGUID: ph2/+d14RHCfHJrgZeR6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43796591"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:40:05 -0700
Received: from [10.212.84.148] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E533820B573A;
	Wed, 10 Apr 2024 06:40:03 -0700 (PDT)
Message-ID: <014e70fb-e49a-4d5c-9daf-a080e0f12b11@linux.intel.com>
Date: Wed, 10 Apr 2024 09:40:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf report: Add weight[123] output fields
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Andi Kleen <ak@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20240409000659.1727785-1-namhyung@kernel.org>
 <20240409000659.1727785-3-namhyung@kernel.org>
 <0ec1328a-0731-42a6-b953-163ac5a56deb@linux.intel.com>
 <CAM9d7cizZLMNa82VxuuvEWEY3vwdbs_iTG9jsogJQBoWMLP7Fw@mail.gmail.com>
 <16587efd-ab12-463a-bd87-7721adfc731d@linux.intel.com>
 <CAM9d7cg65=Hr2Utuuh=8EC7v80y-n1iZ-dyCfDU=kreuovLjfQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cg65=Hr2Utuuh=8EC7v80y-n1iZ-dyCfDU=kreuovLjfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-09 3:27 p.m., Namhyung Kim wrote:
>>>>> weight value and use the default 'comm,dso,sym' sort keys).
>>>>>
>>>>>   $ perf report -n -F +weight | grep -e Weight -e noploop
>>>>>   # Overhead  Samples  Weight1  Command  Shared Object  Symbol
>>>>>        1.23%        7     42.4  perf     perf           [.] noploop
>>>> I think the current +weight shows the sum of weight1 of all samples,
>>>> (global weight). With this patch, it becomes an average (local_weight).
>>>> The definition change may break the existing user script.
>>>>
>>>> Ideally, I think we should keep the meaning of the weight and
>>>> local_weight as is.
>>> Hmm.. then we may add 'avg_weight' or something.
>>>
>>> But note that there's a subtle difference in the usage.  If you use
>>> 'weight' as a sort key (-s weight) it'd keep the existing behavior
>>> that shows the sum (global_weight).  It'd show average only if
>>> you use it as an output field (-F weight).
>>>
>> As my understanding, the -F weight is implicitly replaced by the -F
>> weight1 with this patch. There is no way to get the sum of weight with
>> -F anymore.
> Right.
> 
>> I think that's a user visible behavior change. At least, we have to warn
>> the end user with a message, e.g., "weight is not supported with -F
>> anymore. Using weight1 to instead". Only updating the doc may not be enough.
> I understand your concern.  I can add the warning.
> 
>>> The issue of the sort key is that it cannot have the total sum
>>> of weights for a function.  It'll have separate entries for each
>>> weight for each function like in the above example.
>>>
>> That seems to be a different issue. If the total sum of weights for a
>> function is required, we should fix the existing "weight".
> Yeah, I guess that's more reasonable behavior.  But I'm not sure
> how we can fix it without breaking the existing behavior.
>

I did some experiments and found that with the -F weight option, the
hist_entry__cmp() compares the newly added field, weight, as well.
That may not the behavior we want.

I think the expected behavior is that all the samples still be sorted by
symbol, but just add a new field to show the sum of the weight.
So perf probably should not cmp any newly added field.

Another issue is that the current code will only use the weight from the
first sample. If perf can avoid the cmp of the weight, it still needs to
save all the weights and add them up.

I'm not sure how hard the fix is or maybe it's too ugly. Just for your
reference.

> Actually this is my approach to keep the behavior for the "sort" key.
> I think users are more familiar with -s (--sort) rather than the -F
> (--fields) option.  That's why I'd like to "break" that part only.
> 

Yes, if we have to "break" something, it should be -F.
I'm OK with it as long as there are proper warnings that can tell users
that it's broken.

Thanks,
Kan

