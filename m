Return-Path: <linux-kernel+bounces-137455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC089E264
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12C71C22104
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA007156C48;
	Tue,  9 Apr 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+Rxupzf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA613B284;
	Tue,  9 Apr 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686704; cv=none; b=EPPfR9BBfTzwbzGKpRjhZKlXzjLAOqDjXq/ZaMqTkSwM4Ps4Jzprt3oZYliJM+ypFwrTAfsqakK4bR4dhjYZ7HI0Sr7vOGbG6LezfGkKV9QwcDIg2JAq77dpTftiA90djBtKf+fqDUdaw1+62LlZNMGe2z+RRctF4pCbS9rki0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686704; c=relaxed/simple;
	bh=jikeKFV5YTyaoHcnI26N71nbgtzbSdGLSnHmNo5O4hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPdUOBPgWrzlODcSDaYqjQIAUPvhPF9PgFmTOD4YpeHxs4pUCU4P7cK2nW2VOVQ2WwY6v0u0tsowlGAriYlx7P8eRb5a5jvdaIGr1RPNXnUonRoIInbA/kBigaR8Q/s3HLoZOgPxEI28gxC+0k1F8XWu48XUiP87dBOnoclaHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+Rxupzf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712686704; x=1744222704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jikeKFV5YTyaoHcnI26N71nbgtzbSdGLSnHmNo5O4hw=;
  b=B+RxupzfUBWcVkh9BoQnWTPkHJ2DFSKOFCl74RxtUCuAgEGqTWbklxJN
   Uzs828rqIqMPccTAtXSNBsJrHXiZvkJ3jNoOtU5fU8ZdLkWDz6vPbLtTD
   XNMzU1Wd7ay90pYxHFTvGtmXhYFzrG70Ugt6jbjL1SXWd6kWv/GikmKH8
   OSpRIqeWfFY8fqD+G7reKiuzub4v3AjCAkQ/AbQ3zUc60j19BtLTtj2n7
   kbBrIwhzBU7MIjOq7vuQ6x9cZUBvDQ4g/ktqRIuviOTnfUGv2UPcj0zOV
   nuZUx1dPoVQyPbyINGRPDwTX+eI2kXXLLGCowEXSgSbv7DcO3mvnu7o30
   A==;
X-CSE-ConnectionGUID: 131NvEhhTbWrlgqCxWXDTg==
X-CSE-MsgGUID: tUfA1JwiR/amGxpvahdTgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8246490"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8246490"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:18:23 -0700
X-CSE-ConnectionGUID: 9y6xtvftRcq/It0oniJviw==
X-CSE-MsgGUID: HirWmNQDRlC3NlpKa6n0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20254944"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:18:23 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D3DE520B573A;
	Tue,  9 Apr 2024 11:18:20 -0700 (PDT)
Message-ID: <16587efd-ab12-463a-bd87-7721adfc731d@linux.intel.com>
Date: Tue, 9 Apr 2024 14:18:19 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cizZLMNa82VxuuvEWEY3vwdbs_iTG9jsogJQBoWMLP7Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-09 12:53 p.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Tue, Apr 9, 2024 at 9:37 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-08 8:06 p.m., Namhyung Kim wrote:
>>> Add weight1, weight2 and weight3 fields to -F/--fields and their aliases
>>> like 'ins_lat', 'p_stage_cyc' and 'retire_lat'.  Note that they are in
>>> the sort keys too but the difference is that output fields will sum up
>>> the weight values and display the average.
>>>
>>> In the sort key, users can see the distribution of weight value and I
>>> think it's confusing we have local vs. global weight for the same weight.
>>>
>>> For example, I experiment with mem-loads events to get the weights.  On
>>> my laptop, it seems only weight1 field is supported.
>>>
>>>   $ perf mem record -- perf test -w noploop
>>>
>>> Let's look at the noploop function only.  It has 7 samples.
>>>
>>>   $ perf script -F event,ip,sym,weight | grep noploop
>>>   # event                         weight     ip           sym
>>>   cpu/mem-loads,ldlat=30/P:           43     55b3c122bffc noploop
>>>   cpu/mem-loads,ldlat=30/P:           48     55b3c122bffc noploop
>>>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
>>>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
>>>   cpu/mem-loads,ldlat=30/P:           59     55b3c122bffc noploop
>>>   cpu/mem-loads,ldlat=30/P:           33     55b3c122bffc noploop
>>>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
>>>
>>> When you use the 'weight' sort key, it'd show entries with a separate
>>> weight value separately.  Also note that the first entry has 3 samples
>>> with weight value 38, so they are displayed together and the weight
>>> value is the sum of 3 samples (114 = 38 * 3).
>>>
>>>   $ perf report -n -s +weight | grep -e Weight -e noploop
>>>   # Overhead  Samples  Command   Shared Object   Symbol         Weight
>>>        0.53%        3     perf   perf            [.] noploop    114
>>>        0.18%        1     perf   perf            [.] noploop    59
>>>        0.18%        1     perf   perf            [.] noploop    48
>>>        0.18%        1     perf   perf            [.] noploop    43
>>>        0.18%        1     perf   perf            [.] noploop    33
>>>
>>> If you use 'local_weight' sort key, you can see the actualy weight.
>>>
>>>   $ perf report -n -s +local_weight | grep -e Weight -e noploop
>>>   # Overhead  Samples  Command   Shared Object   Symbol         Local Weight
>>>        0.53%        3     perf   perf            [.] noploop    38
>>>        0.18%        1     perf   perf            [.] noploop    59
>>>        0.18%        1     perf   perf            [.] noploop    48
>>>        0.18%        1     perf   perf            [.] noploop    43
>>>        0.18%        1     perf   perf            [.] noploop    33
>>>
>>> But when you use the -F/--field option instead, you can see the average
>>> weight for the while noploop funciton (as it won't group samples by
>>
>> %s/funciton/function/
>>
>>> weight value and use the default 'comm,dso,sym' sort keys).
>>>
>>>   $ perf report -n -F +weight | grep -e Weight -e noploop
>>>   # Overhead  Samples  Weight1  Command  Shared Object  Symbol
>>>        1.23%        7     42.4  perf     perf           [.] noploop
>>
>> I think the current +weight shows the sum of weight1 of all samples,
>> (global weight). With this patch, it becomes an average (local_weight).
>> The definition change may break the existing user script.
>>
>> Ideally, I think we should keep the meaning of the weight and
>> local_weight as is.
> 
> Hmm.. then we may add 'avg_weight' or something.
> 
> But note that there's a subtle difference in the usage.  If you use
> 'weight' as a sort key (-s weight) it'd keep the existing behavior
> that shows the sum (global_weight).  It'd show average only if
> you use it as an output field (-F weight).
>

As my understanding, the -F weight is implicitly replaced by the -F
weight1 with this patch. There is no way to get the sum of weight with
-F anymore.

I think that's a user visible behavior change. At least, we have to warn
the end user with a message, e.g., "weight is not supported with -F
anymore. Using weight1 to instead". Only updating the doc may not be enough.

> The issue of the sort key is that it cannot have the total sum
> of weights for a function.  It'll have separate entries for each
> weight for each function like in the above example.
> 

That seems to be a different issue. If the total sum of weights for a
function is required, we should fix the existing "weight".

Thanks,
Kan

