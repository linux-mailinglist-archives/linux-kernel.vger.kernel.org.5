Return-Path: <linux-kernel+bounces-147122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851A8A6FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9443C1F229FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A662130ACC;
	Tue, 16 Apr 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPd8+MbL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBC12B154
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281056; cv=none; b=N1Qei4SeFZZBYzHPBX4VbxfjBJVzpKAWiplaZFfmQzbT3TItc4Iy6g6gMgx0VqlkVDHTGxMFt1j9RYX0vC/bKNNFsLm+M41WNs+OSm4R0eu04xMACX/uHQKy9TWMLrX6bFR2o76nUiL8HWlyO+Q+G02Qlhh1X3C/MO2Au5SKgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281056; c=relaxed/simple;
	bh=iwZ9j+J2NtMy51XLX96h7pza+K/HjuoW+wL9HE+8m9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjX6RR7MZZaoXYF0YTLZUoa/yNnltpSOumev1w2l4Uqe7bTWEiTDG6dEgCZxUNdYQmB3wRc6tEx1WE85zcS9iy84TDpTWzllsF5hqUDJQAwPOxaHWKOsB7D+gCUJMxr1y6sDmSDdsNmliOJGw8dMo/sw/yug+mEQz0iKuErT0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPd8+MbL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713281055; x=1744817055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iwZ9j+J2NtMy51XLX96h7pza+K/HjuoW+wL9HE+8m9k=;
  b=TPd8+MbLg2vt8duvcEeiA2gTzoGGhMkOjpSmBcBdQSsB+YMrmlzIW2TJ
   ud6rcEEmjL/r+Popz+obJYF6Vjo7+X0YmqWMl/DVw3hYW332IfNljDvZ2
   bd/SV+XYo5TSO8t/C/ODWB0h1sR2Zqyf2vC0EeTIFmi0DVFg0AYb7Xq+r
   J7K+/izSMVkZ/EfIHe5iBilYi94Oqn3m18F2xgBHN3QFfgNHfEEWo2bgn
   3RHTtiYJXpDya/0Qzdkju/VhCpyX+CtpVWRLS6jURCGWtYnrzx26oN1H8
   NVUVvuQaN7vwK513OfvxPaDUWsjx0NY4rSkxZwAhl5OmYrFwqZXWhfxwO
   w==;
X-CSE-ConnectionGUID: Rok1uaUSRWW+xu/y/7U/5Q==
X-CSE-MsgGUID: X4bduCURR2CCB8L7yKWDyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26187209"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26187209"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:24:01 -0700
X-CSE-ConnectionGUID: P5hPbeiMS+WRsioIUW79Rw==
X-CSE-MsgGUID: q97K/htUT96f4eZeYEZylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="27088947"
Received: from jadean1-mobl1.amr.corp.intel.com (HELO [10.212.122.189]) ([10.212.122.189])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:24:00 -0700
Message-ID: <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
Date: Tue, 16 Apr 2024 08:23:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
To: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Robert Richter <rric@kernel.org>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
 x86@kernel.org
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 08:12, Borislav Petkov wrote:
>>  	if (!boot_cpu_has(X86_FEATURE_IBS))
>>  		return 0;
>>  
>> -	/* check IBS cpuid feature flags */
>> -	max_level = cpuid_eax(0x80000000);
>> -	if (max_level < IBS_CPUID_FEATURES)
>> -		return IBS_CAPS_DEFAULT;
>> +	get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps);
> I wanna say all this checking of max level is worthless because if you
> have X86_FEATURE_IBS, then it is a given that you also have that
> 0x8000001b CPUID leaf.
> 
> Right, Bob?
> 
> Unless there was some weird thing back then with the CPUID leafs...

When I was looking at it, I (maybe wrongly) assumed that 0x8000001b and
X86_FEATURE_IBS were independent for a reason.  Because, oddly enough:

	#define IBS_CAPS_DEFAULT         (IBS_CAPS_AVAIL         \
                                         | IBS_CAPS_FETCHSAM    \
                                         | IBS_CAPS_OPSAM)

So, if the CPU enumerates X86_FEATURE_IBS but has a
max_level<IBS_CPUID_FEATURES then it assumes there's a working IBS
because the software-inserted IBS_CAPS_DEFAULT has IBS_CAPS_AVAIL set.

Actually, that even means that the new code should probably be:

	u32 caps = IBS_CAPS_DEFAULT;
	
 	if (!boot_cpu_has(X86_FEATURE_IBS))
 		return 0;	

	get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps);

to match the old.

