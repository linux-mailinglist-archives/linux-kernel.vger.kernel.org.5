Return-Path: <linux-kernel+bounces-138890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323489FBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9A282A45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868016F0FB;
	Wed, 10 Apr 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8d6LHLL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6716EC18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763312; cv=none; b=eIUEKr9bjtbY8mv6A3WDiaHvFEmFZPDDg+951MpxbJqZuuWOiItox0qKQFJu6SvsWO60Al3EIRlCt7340DZHjkSVzvugiOc031Zi1Kld82loOjJ+7kTPHlC7M6z00bJzds+v578E0JbuMGp4TAr6/sbN2EeTBLmEK+0y5Lmd1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763312; c=relaxed/simple;
	bh=knF+LOBW9J8frgy2CbQjVxBB6xMQ9R7nAYy8AbUmRK0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W3Jz2ptUk14pU06QbVx2YEc86URgvXZj4gBAa7rhFDbmMMN5vVyhsWz/D/VFCSG23AToV314D4wIN0O6EZG7+QyENVaHMbgYZgketPy8cgxFfpkAOC+1qXtTI78L3LeOJNrqDNNJq7gHfCs1U8+eYMXlI5XoSfM7KEroK2lgjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8d6LHLL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712763310; x=1744299310;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=knF+LOBW9J8frgy2CbQjVxBB6xMQ9R7nAYy8AbUmRK0=;
  b=U8d6LHLLodNOln3Ok7huYaVbqK1m4yb0CTM/UNgqtp3abmYepcyco1oY
   wpCBABZBJUGu9acbxsudoMelTHUPVx+INLf1KOSQr79/HmrrlTCsmcwSD
   2Wc0/vKhEZ+Yo51ugMXctxddPckSlwD0rz/t1FlzYrOH+1+oJh+8OXhdQ
   2oZEwBe7NxoUc/HEzCSk6m9HTEGXqNRdISF9qQ72mp4V7RM7gxcOnthKA
   FwkdD9SsHbKBVaQeGEWQ+4zu194u8OcGg/Ce1CLkCkHi6B2XVV2d6mDRc
   usxZcPrT9U8C4IEWZzwWcnaaqBCpfpxFEq7nUcacN9QnP51eVvHHDz1qL
   g==;
X-CSE-ConnectionGUID: OKTEkqYCQ9a1Unz8Ojhm7w==
X-CSE-MsgGUID: WKhwt5e6QDqd+V7tmfh0mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7987503"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7987503"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 08:35:10 -0700
X-CSE-ConnectionGUID: pX1/nI07QWGvh/Uqi6DMLw==
X-CSE-MsgGUID: 448c7hfOTSCX7W6p/l95+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43856038"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.214.234])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 08:35:06 -0700
Message-ID: <b9d3138b-000a-49ca-bc82-6517231eca91@intel.com>
Date: Wed, 10 Apr 2024 18:35:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tinyconfig: kernel/time/timekeeping.c:286:1: error: no return
 statement in function returning non-void [-Werror=return-type]
From: Adrian Hunter <adrian.hunter@intel.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvjdZCW=7ZGxS6A_3bysjQ56YF7S-+PNLQ_8a4DKh1Bhg@mail.gmail.com>
 <52cf2d1a-76ec-48cb-96c3-211fa1eb721a@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <52cf2d1a-76ec-48cb-96c3-211fa1eb721a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/24 16:03, Adrian Hunter wrote:
> On 10/04/24 13:56, Naresh Kamboju wrote:
>> The powerpc,s390, superSh and sparc tinyconfig builds failed due to
>> following build
>> warnings / errors on the Linux next-20240410 with gcc-13 and gcc-11.
>>
>> List build failures:
>> ---
>> * s390, build
>>   - gcc-13-tinyconfig - failed
>>   - gcc-8-tinyconfig - failed
>>
>> * sh, build
>>   - gcc-11-tinyconfig - failed
>>
>> * sparc, build
>>   - gcc-11-tinyconfig - failed
>>
>> * mips, build
>>   - gcc-12-tinyconfig - failed
>>   - gcc-8-tinyconfig - failed
>>
>> * powerpc, build
>>   - gcc-13-tinyconfig - failed
>>   - gcc-8-tinyconfig - failed
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Build log:
>> --------
>> kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
>> kernel/time/timekeeping.c:286:1: error: no return statement in
>> function returning non-void [-Werror=return-type]
>>   286 | }
>>       | ^
>> cc1: some warnings being treated as errors
> 
> Using unreachable() in the default BUG() seems to make this go
> away.
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 6e794420bd39..891bd9b0be70 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -156,7 +156,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  
>  #else /* !CONFIG_BUG */
>  #ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while (1)
> +#define BUG() do { do {} while (1) ; unreachable(); } while (0)
>  #endif
>  
>  #ifndef HAVE_ARCH_BUG_ON
> 

Patch here:

	https://lore.kernel.org/all/20240410153212.127477-1-adrian.hunter@intel.com/



