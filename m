Return-Path: <linux-kernel+bounces-28502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169282FF52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0076A28676F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E52522E;
	Wed, 17 Jan 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQBW66vV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4E4687
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462626; cv=none; b=HNDGISNRWY2a9oYof6qMdUUq0MwDuurmv8Z+Ddzoq8WfCl4s5pe0PU8JByZdnSrxPCGIYCazJRCcm7m5Rt3JXLcCTkBcNFSiNJFpigDzokRMxZzhaAgL/wHtBG996zNmvyyxsV4DEBfmnAzdyX5NEZ5sRNZjzf74ZbFh4bNCkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462626; c=relaxed/simple;
	bh=3QLxoAEagSbufHZcGFphgeKGLu/6hRsA/e+7GgiIdz4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=oo2oumnDYOGtc58G+w0P9gCfzx9U17QyKS3pAteBkjPSZdj6+SPn4ekHMfetW49MfkRjWPuTu34jQqH0MOrOLiPgYQen7MtfxfGKtI/scsfnUJ3H3arvLuU86RPFVvvu/pMKwREIu21j5znqQu1zLczmw7vaAxlHlAba1w647W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQBW66vV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705462624; x=1736998624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3QLxoAEagSbufHZcGFphgeKGLu/6hRsA/e+7GgiIdz4=;
  b=OQBW66vVe3fvaVNfy9NqWW/P3HammvY2ZTBPowWSVMzHQ3L+M8GTi0rK
   wcryiWEi18Ub53cmS53TVVC6ScHf7qhdft5gGoVnBviLmAdSyZNr8Tgfb
   Z4CJFUrNL935DSngFWuoJ+UULUlrVupV4ZCxVcICTTpUYy200asg0iy5/
   6zjv738jHdKIIV5jDzpDLc65xOYRq+HnBPBaN0+JxSF+WiAeKgJJMq59e
   i7ynErsrQ3pC7kbYu3n/VLg7aqP/0ulJhw5zfrdDLj3EqLToY2uXrb5Gk
   hyiWKp/k3sN0zrn+GZKu4oMZKCBzHEPyiVm7TgQkUjZTOcQ+05EGN7BEa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13415833"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13415833"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957412143"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957412143"
Received: from xshen14-mobl1.ccr.corp.intel.com (HELO [10.93.3.71]) ([10.93.3.71])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:37:00 -0800
Message-ID: <c1d9c4dc-b698-46da-949a-6d294dee210e@intel.com>
Date: Wed, 17 Jan 2024 11:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Implement new MBA_mbps throttling heuristic
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Newman <peternewman@google.com>, x86@kernel.org
Cc: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, xiaochen.shen@intel.com
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240109220003.29225-1-tony.luck@intel.com>
 <60a1eed0-7956-4f4b-8113-d5f2d44f3595@intel.com>
From: Xiaochen Shen <xiaochen.shen@intel.com>
In-Reply-To: <60a1eed0-7956-4f4b-8113-d5f2d44f3595@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Reinette and Tony,

On 1/17/2024 3:55, Reinette Chatre wrote:
> Hi Xiaochen,
>
> On 1/9/2024 2:00 PM, Tony Luck wrote:
>> The MBA_mbps feedback loop increases throttling when a group is using
>> more bandwidth than the target set by the user in the schemata file, and
>> decreases throttling when below target.
>>
>> To avoid possibly stepping throttling up and down on every poll a
>> flag "delta_comp" is set whenever throttling is changed to indicate
>> that the actual change in bandwidth should be recorded on the next
>> poll in "delta_bw". Throttling is only reduced if the current bandwidth
>> plus delta_bw is below the user target.
>>
>> This algorithm works well if the workload has steady bandwidth needs.
>> But it can go badly wrong if the workload moves to a different phase
>> just as the throttling level changed. E.g. if the workload becomes
>> essentially idle right as throttling level is increased, the value
>> calculated for delta_bw will be more or less the old bandwidth level.
>> If the workload then resumes, Linux may never reduce throttling because
>> current bandwidth plu delta_bw is above the target set by the user.
>>
>> Implement a simpler heuristic by assuming that in the worst case the
>> currently measured bandwidth is being controlled by the current level of
>> throttling. Compute how much it may increase if throttling is relaxed to
>> the next higher level. If that is still below the user target, then it
>> is ok to reduce the amount of throttling.
>>
>> Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
>> Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>>
>> This patch was previously posted in:
>>
>>    https://lore.kernel.org/lkml/ZVU+L92LRBbJXgXn@agluck-desk3/#t
>>
>> as part of a proposal to allow the mba_MBps mount option to base its
>> feedback loop input on total bandwidth instead of local bandwidth.
>> Sending it now as a standalone patch because Xiaochen reported that
>> real systems have experienced problems when delta_bw is incorrectly
>> calculated.
>>
> Does this new heuristic fix the problems you observe? If so, would you be
> willing to provide a "Tested-by" tag?

Yes. The patch fixed the problem. I will reply to the original thread to 
add "Tested-by" tag.
Thank you very much for help!

>
> Thank you.
>
> Reinette

Best regards,
Xiaochen


