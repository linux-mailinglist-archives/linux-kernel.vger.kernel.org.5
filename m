Return-Path: <linux-kernel+bounces-145954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8C8A5D37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD7B2836B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31315A4AC;
	Mon, 15 Apr 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKqSmNoR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDB15A49C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217821; cv=none; b=GRkKFQD54INi0bQ/01LtlmY9VI1IeJs/gfJJbnmraatAbbyZQKsMNSeihCGwRn1Zs1Tm3WZ4CiKyQ390920yguveSWW366vgLsl8Id9PegHdXptTjWQPEtrirje1acVHWtL6BLgBOqxSgxC3opNSN8S2c9nF+fjcDpngRAIIigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217821; c=relaxed/simple;
	bh=Z0FynSgBzopwyO8X0ElsM9/n+YXv1XIMpnCuN7gKjYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nuy0qALidK0FXFzNcnP3cXqfdCt6S4SWrpcf6fFohPEVEJxRxrn7lcape+7a1hCH6q/Z8t7eGhVNuJzM+aVMKduQDT1uceKEN2HZ1NuzqSghKKUYIlmFCIwnQCMtDoTN4SnCDVjmW1OKI/3rK+V4Sj54HrHeULvwp3dHvM3nl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKqSmNoR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713217820; x=1744753820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z0FynSgBzopwyO8X0ElsM9/n+YXv1XIMpnCuN7gKjYg=;
  b=gKqSmNoRg6tLlmAtltz9EbmAqbPG0p903jkSq8CaI9oYHDKcXelqJgQE
   katqGqZ+FvBoFHdHGxxYuMR2zJYh8Eca5ytkWdZhtAthT9aqwkkZmTwd1
   ZWrghhoXsFt3yHVR6+on5dP25Qb9fsoQ0GrLrSI40rSO70TkEexVjMW8b
   aIxt/j4sw49SO5RUNDgcf8vuXCiukTYaaPke2AXIkGbB3x8nEVFq4OLMg
   3rZAk9ZMEMQCAVAU1ucud0yyDJcVnTti5tI9tXXmMvl5soT/ZIf8V0UxP
   bh+vht2MGgeSKtDocZwt/Cl73GyoCU4OnaBoMXAYPmODp3UQYAJq5wXvc
   g==;
X-CSE-ConnectionGUID: Wv14UPDZQc+s309tU4cjBA==
X-CSE-MsgGUID: nPGlVcAfQ8ynz9ZdZ2mtUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8491832"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8491832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:50:19 -0700
X-CSE-ConnectionGUID: ZnuBGbWJRmurMVTsPmFBbA==
X-CSE-MsgGUID: Ah6dHlfBRTSJ6L2YSp6mdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26710469"
Received: from garumuga-mobl1.amr.corp.intel.com (HELO [10.209.93.175]) ([10.209.93.175])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:50:18 -0700
Message-ID: <7e138229-24bf-447b-b8dd-5340eaa939fe@linux.intel.com>
Date: Mon, 15 Apr 2024 14:50:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
 <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
 <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/24 1:13 PM, Tom Lendacky wrote:
> On 4/15/24 14:48, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 4/15/24 12:16 PM, Tom Lendacky wrote:
>>> On 4/12/24 10:52, Tom Lendacky wrote:
>>>> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
>>>>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
>>>>>> Config-fs provides support to hide individual attribute entries. Using
>>>>>> this support, base the display of the SVSM related entries on the presence
>>>>>> of an SVSM.
>>>>>>
>>>>>> Cc: Joel Becker <jlbec@evilplan.org>
>>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>>> ---
>>>>>>    arch/x86/coco/core.c        |  4 ++++
>>>>>>    drivers/virt/coco/tsm.c     | 14 ++++++++++----
>>>>>>    include/linux/cc_platform.h |  8 ++++++++
>>>>>>    3 files changed, 22 insertions(+), 4 deletions(-)
>>>>>>
>>>
>>>>>
>>>>> Any comment about the following query? I think introducing a CC flag for this use
>>>>> case is over kill.
>>>>>
>>>>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
>>>>
>>>> If you don't think TDX will be able to make use of the SVSM attribute I can look at adding a callback. But I was waiting to see if anyone else had comments, for or against, before re-doing it all.
>>>>
>>>
>>> What about something like this (applied on top of patch 13):
>>>
>
>>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>>> index 27cc97fe8dcd..5aaf626d178d 100644
>>> --- a/include/linux/tsm.h
>>> +++ b/include/linux/tsm.h
>>> @@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
>>>   /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
>>>   extern const struct config_item_type tsm_report_extra_type;
>>>   +/*
>>> + * Used to indicate the attribute group type to the visibility callback to
>>> + * avoid the callback having to examine the attribute name.
>>
>> Checking the attribute name will give more flexibility, right? Since it is one time
>> check, it should not be costly, right?
>
> I thought about checking the name(s), but what if in the future another attribute is added, then you have to remember to update multiple places. This way you have an enum that represents the related attributes. Is there a 

I think it depends on how you implement the visibility function. If the vendor driver allows all attributes by default and denies few selected ones, you don't have to update the vendor driver for all new attributes. Letting the vendor driver decide whether to support any new attributes makes sense to me.

> scenario where you would want to not hide all attributes that are related? String comparisons just seem awkward to me.
>
> I suppose the config_item and configfs_attr could also be supplied on the callback if that's a requirement.


I am ok with enum based checks. But lets see what others think. Personally I think checking config attr name is more flexible.


>
>>
>>> +enum tsm_type {
>>> +    TSM_TYPE_SERVICE_PROVIDER,
>>> +
>>> +    TSM_TYPE_MAX
>>> +};
>>> +
>>> +typedef bool (*tsm_visibility_t)(enum tsm_type type);
>>> +
>>>   int tsm_register(const struct tsm_ops *ops, void *priv,
>>> -         const struct config_item_type *type);
>>> +         const struct config_item_type *type,
>>> +         tsm_visibility_t visibility);
>>>   int tsm_unregister(const struct tsm_ops *ops);
>>>   #endif /* __TSM_H */
>>>
>>
>> Why not add a callback in tsm_ops?
>
> That's an option, too. Either way works for me.
>
> Thanks,
> Tom
>
>>
>>>> Thanks,
>>>> Tom
>>>>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


