Return-Path: <linux-kernel+bounces-136307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D4C89D27F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD9F1C224FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1538DED;
	Tue,  9 Apr 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gv5flgFr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA21DFD1;
	Tue,  9 Apr 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644363; cv=none; b=B4NfoN1AnJxgW56x7ZBd/gblqg8+o3WisJ3Kjn5B9r46m9P/T3EQvfS9yz8Ni+rOhD50pv1LmkdMfFtWLyD4+oPsKma0de7mTc17bOB/xJ2NXOi5erF/2axz9ErEaNjDTZ0nj+9nbij6Pd/QzitJqGqhWAkl953bheiblXxKKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644363; c=relaxed/simple;
	bh=uwimiWdg0T9d2TTNTlk3OaxzP7fmBzP+QfEQK1fM1vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABot22hgcM9Vr095Pdudbfg7D2UIHyCk+MtIAZHcx1sJvoKHG5Hf3dLaymb4I8zOkOrNC0eAoOBAGQqbOFVlQ+RMqn7LSxCASaNyFMgmOZq8P8+TjzzNkAwu7fTaRexjE/I1lm4A4G1okBQuqKdWSyS4SKI/aqB76pjBVbwV+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gv5flgFr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712644362; x=1744180362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uwimiWdg0T9d2TTNTlk3OaxzP7fmBzP+QfEQK1fM1vw=;
  b=gv5flgFrQVePnhDVHq1TiVtXz6HuloPcJJzOwL3qoSFQOSRUzlT218+Y
   E2S/50srvIaOt6gkGJk1odjnxGiQnvNL5ItYG8azMKbTNZvUIEpb1p3AL
   5/HUp23/aNay9cmo0LK5Y2wZb2uRYHKzr6r9MgU1j0ye2VK+SPuPzH5Rr
   b611x3ornYT2dGunyjFU/7G/jz77Kgam4MnRrZNN1P7tfkB1tFWTlTI2u
   LG5kplDCpYjGMkMO1CNqr5XjzobKwOQfpW1kn5iUpIVMzsi2LpFHcypph
   oYpmcDUdL4GGBNrMT07wHsG1WaM1DTzeCJhQ1ZppK7JoIdjXBaN5WTIiM
   w==;
X-CSE-ConnectionGUID: XO0Qy8cnQTSRhT36s5JUyg==
X-CSE-MsgGUID: Qi786KYYQtikqD+eMdf6NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7791210"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7791210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:32:40 -0700
X-CSE-ConnectionGUID: BxVBfudqTs2J/koKcvN+rQ==
X-CSE-MsgGUID: U6oEIpf+Skm8uD09xe2lQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51316237"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:32:38 -0700
Message-ID: <52c9b314-9770-4bec-ae53-2840709b41d4@intel.com>
Date: Tue, 9 Apr 2024 09:32:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the tip tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240409124905.6816db37@canb.auug.org.au>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240409124905.6816db37@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/04/24 05:49, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from <command-line>:
> lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
> lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared (first use in this function); did you mean 'U64_C'?
>    11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
>       |                                 ^~~~~~~
> lib/vdso/gettimeofday.c:41:49: note: in expansion of macro 'VDSO_DELTA_MASK'
>    41 |         u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
>       |                                                 ^~~~~~~~~~~~~~~
> lib/vdso/gettimeofday.c:11:33: note: each undeclared identifier is reported only once for each function it appears in
>    11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
>       |                                 ^~~~~~~
> lib/vdso/gettimeofday.c:41:49: note: in expansion of macro 'VDSO_DELTA_MASK'
>    41 |         u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
>       |                                                 ^~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")
> 
> I have used the tip tree from next-20240408 for today.

Thanks you!  Please consider the fix cc'ed you and linked below:

    https://lore.kernel.org/all/20240409062639.3393-1-adrian.hunter@intel.com/


