Return-Path: <linux-kernel+bounces-142412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C88A2B34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A964328DAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531451033;
	Fri, 12 Apr 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTXnQP1T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AE5029B;
	Fri, 12 Apr 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914173; cv=none; b=advsZrV1n3/45tTAEHPqIOYxztXhwdFEryBVyOJGbn957IahxjUho0ZbvzSGx24ckUDfCIXhehseDQZb6HV3cE953QE0FZaAbWqgp/QkzrmP69KOT3WnZFPTDjXpgSo48ASe3Xa126jzmMGwlhrlEI/xaLbRJAYqHZoctYpz6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914173; c=relaxed/simple;
	bh=/sjvyrSm7S4Xp8PqDAqn9dtnDgY764wTIuC53kgyd/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk0wqx8ptjTTc2PUxpi4PmG1vcgYgWvgtMsLca2s3KQ0Wt8Oq7jHr8kiathdLxL8IMbyhcUZ3Tsts3tduXw2X0JsvHsR2vsLleAbi/gkFodt/USMbU7qtIAhT+yk4hAIJ93PLJSoz/Xk0wx6gXlk2fkUYTRh6c3RUosVFN23h2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTXnQP1T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712914172; x=1744450172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/sjvyrSm7S4Xp8PqDAqn9dtnDgY764wTIuC53kgyd/Q=;
  b=aTXnQP1TTHJC5CmtYiWNy/IooMPpyIW+5/akY0qiWElrZ9wj2nX32BeW
   e98+zxVlcjHAGU2n75gPZWiY8T3J5L5iZpGBvVH4FrOkOAQQ24Bln7tU5
   ImgeEvmGtV0sYtAYou7l5RbZxW/XxIUblUljh/V/J0qRxkiGX7Hj9t1dq
   H/P3H94VTXoHaGa6iGKvp9qIuaUs6Z3jRY8/u64uyvhVFi3M8LZuWeuX4
   fnMS04RBlgapKdTXNfsR7tgoLOXGNowCtzZY8wDLZE4CdMhJ4d87h4yA9
   5Gj+t6SxRHHMCa9zbZk9bIHn6AZG6RAByVAV2uvO2AjUMuexE6epGkrG+
   w==;
X-CSE-ConnectionGUID: zwJXQZpsRvOi09rAP4s02Q==
X-CSE-MsgGUID: iNClxgVwTrCgVJmPHYvz0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12147592"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="12147592"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:29:31 -0700
X-CSE-ConnectionGUID: p2Te1THcR+aMzCOnjjCYPA==
X-CSE-MsgGUID: jcYHBli3TPqHQtKTb5McTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21167117"
Received: from dev-qz.sh.intel.com (HELO localhost) ([10.239.147.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:29:29 -0700
Date: Fri, 12 Apr 2024 17:29:43 +0800
From: Qiang Zhang <qiang4.zhang@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qiang Zhang <qiang4.zhang@intel.com>, Stable@vger.kernel.org
Subject: Re: [PATCH RESEND] bootconfig: use memblock_free_late to free xbc
 memory to buddy
Message-ID: <Zhj/B4w5rCpZKm1K@dev-qz>
References: <20240412024103.3078378-1-qiang4.zhang@linux.intel.com>
 <20240412163448.98950acccc3baea1a3f07fed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412163448.98950acccc3baea1a3f07fed@kernel.org>

On Fri, Apr 12, 2024 at 04:34:48PM +0900, Masami Hiramatsu wrote:
>On Fri, 12 Apr 2024 10:41:04 +0800
>qiang4.zhang@linux.intel.com wrote:
>
>> From: Qiang Zhang <qiang4.zhang@intel.com>
>> 
>> On the time to free xbc memory, memblock has handed over memory to buddy
>> allocator. So it doesn't make sense to free memory back to memblock.
>> memblock_free() called by xbc_exit() even causes UAF bugs on architectures
>> with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86. Following KASAN logs
>> shows this case.
>> 
>> [    9.410890] ==================================================================
>> [    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
>> [    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1
>> 
>> [    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
>> [    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
>> [    9.460789] Call Trace:
>> [    9.463518]  <TASK>
>> [    9.465859]  dump_stack_lvl+0x53/0x70
>> [    9.469949]  print_report+0xce/0x610
>> [    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
>> [    9.478619]  ? memblock_isolate_range+0x12d/0x260
>> [    9.483877]  kasan_report+0xc6/0x100
>> [    9.487870]  ? memblock_isolate_range+0x12d/0x260
>> [    9.493125]  memblock_isolate_range+0x12d/0x260
>> [    9.498187]  memblock_phys_free+0xb4/0x160
>> [    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
>> [    9.508021]  ? mutex_unlock+0x7e/0xd0
>> [    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
>> [    9.516786]  ? kernel_init_freeable+0x2d4/0x430
>> [    9.521850]  ? __pfx_kernel_init+0x10/0x10
>> [    9.526426]  xbc_exit+0x17/0x70
>> [    9.529935]  kernel_init+0x38/0x1e0
>> [    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
>> [    9.538601]  ret_from_fork+0x2c/0x50
>> [    9.542596]  ? __pfx_kernel_init+0x10/0x10
>> [    9.547170]  ret_from_fork_asm+0x1a/0x30
>> [    9.551552]  </TASK>
>> 
>> [    9.555649] The buggy address belongs to the physical page:
>> [    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
>> [    9.570821] flags: 0x200000000000000(node=0|zone=2)
>> [    9.576271] page_type: 0xffffffff()
>> [    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
>> [    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>> [    9.597476] page dumped because: kasan: bad access detected
>> 
>> [    9.605362] Memory state around the buggy address:
>> [    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [    9.634930]                    ^
>> [    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [    9.654675] ==================================================================
>> 
>
>Oops, good catch! Indeed, it is too late to use memblock_free().
>
>BTW, is it safe to call memblock_free_late() in early boot stage,
>because xbc_free_mem() will be called also from xbc_init().
>If not, we need a custom internal __xbc_exit() or xbc_cleanup()
>which is called from xbc_init() and uses memblock_free().

No, memblock_free_late() can't be used early.
Exit and Cleanup seem alike and are confusing. Maybe adding a early flag to
_xbc_exit(bool early) is more clear. I will push a V2 for this.

>
>Thank you,
>
>
>> Cc: Stable@vger.kernel.org
>> Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
>> ---
>>  lib/bootconfig.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
>> index c59d26068a64..4524ee944df0 100644
>> --- a/lib/bootconfig.c
>> +++ b/lib/bootconfig.c
>> @@ -63,7 +63,7 @@ static inline void * __init xbc_alloc_mem(size_t size)
>>  
>>  static inline void __init xbc_free_mem(void *addr, size_t size)
>>  {
>> -	memblock_free(addr, size);
>> +	memblock_free_late(__pa(addr), size);
>>  }
>>  
>>  #else /* !__KERNEL__ */
>> -- 
>> 2.39.2
>> 
>> 
>
>
>-- 
>Masami Hiramatsu (Google) <mhiramat@kernel.org>

