Return-Path: <linux-kernel+bounces-137485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996C89E2C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1281C2314E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A05156F46;
	Tue,  9 Apr 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWldweP9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252113E3E8;
	Tue,  9 Apr 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688947; cv=none; b=cehb2mpDq0VpN6ZvQaT1qdLU6sY3GxKvEBPIvklNOn1UNhLsU7ZWjJnCnu+BTe0q0S5PWLqvzseEtwAk0WAGRsdlndlCUODYooHBgdxksHjxXC7H1qD8XbqX1R3eCKAt7ADjfQAiTuCzPOd3pHBnpPj8kbTSqeEK4laD+HS5kqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688947; c=relaxed/simple;
	bh=Jo9vvIH5U/HV9EfsCBETk8fcu/gk0vAuBO3iGYCYU6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hebpCfaW3b10jxHJ0ixFpceiRPBEvoonU8XCvnOSxvhvJvopvZHYcQFaUdcCPADTSzpBbRY7L+AvPtS21DyN5tnaC/UEHE4MRJPWRWv1THNjuy1bvaSUy5pWPcuB3n2A4p/aF3+xHGVF+vSSjTZbLUxTVkLjALBUH9r+Il+LkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWldweP9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712688946; x=1744224946;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jo9vvIH5U/HV9EfsCBETk8fcu/gk0vAuBO3iGYCYU6A=;
  b=KWldweP9sDe1+1/lTO7cvkRjQKqXzk4s4lehv/zAQe/UPn2RYF72tCr6
   YK8SCOL7jH4uSykNhOHTlxOZbJQ7hGw2dmGfj7Dd4h1kJWpT8qpVVOlBL
   NiCdm0ensyspFgtFJMSPbo29XMElr5XiJOd6A7pB01YxhXF1g44OqTWBj
   zjthuBA+efMkokFX3wTWKF12wEN23zSLAvue3lAhfVFNwYO7ciVC6aEBh
   TQKzlXo0cRetZbe1LauRCSV+BbMWXRnv0SNG62XZWfeZ4ihc/B0VsbZ6f
   6d4v72kWIevEBLgnRFxG66cgSRCTxgPGgG2YwGi7LCr67WSOzN9vR0tW9
   g==;
X-CSE-ConnectionGUID: N/u6NRxISOG0Pf8mWpPX5g==
X-CSE-MsgGUID: rLFh+pNEREeTY5d5k7tFjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7878068"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7878068"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:55:46 -0700
X-CSE-ConnectionGUID: y7jAz1TPTWaqFLR0JYYEuQ==
X-CSE-MsgGUID: T2R9OcVAQYiMHo998YUXxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20755797"
Received: from mljaencu-mobl.amr.corp.intel.com (HELO [10.125.80.154]) ([10.125.80.154])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:55:44 -0700
Message-ID: <976c385e-2174-464e-9afd-de4cb46f63b8@linux.intel.com>
Date: Tue, 9 Apr 2024 11:55:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86/cpu: Fix SPECULATIVE_MITIGATION=n kernels
To: Sean Christopherson <seanjc@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20240409175108.1512861-1-seanjc@google.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240409175108.1512861-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 10:51, Sean Christopherson wrote:
> Fix the handling of SPECULATION_MITIGATIONS=n so that it actually does
> what it says it does: disable any and all mitigations.
> 
> And because I don't see a way to provide sane behavior for overriding
> SPECULATION_MITIGATIONS=n at runtime, explicitly disallow doing so via
> the "mitigations" kernel parameter, e.g. so that the user at least knows
> that their system is still likely vulnerable to a variety of issues.
> 
> Sean Christopherson (3):
>   x86/cpu: Actually turn off mitigations by default for
>     SPECULATION_MITIGATIONS=n
>   x86/cpu: Disable BHI mitigation by default when
>     SPECULATION_MITIGATIONS=n
>   x86/cpu: Ignore "mitigations" kernel parameter if
>     SPECULATION_MITIGATIONS=n
> 
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  arch/x86/Kconfig                                | 10 +++++++---
>  arch/x86/kernel/cpu/bugs.c                      |  6 +++---
>  kernel/cpu.c                                    |  5 ++++-
>  4 files changed, 17 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702

Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>

