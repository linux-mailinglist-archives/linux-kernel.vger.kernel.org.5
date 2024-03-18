Return-Path: <linux-kernel+bounces-106414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24E87EE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C1F282C81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB254F8B;
	Mon, 18 Mar 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s/r9+wu5"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0754BF7;
	Mon, 18 Mar 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781319; cv=none; b=SV4jmqGD51wEAtPeuNtCFHLByYbvZDjqRyRw+f9oImUXNDpS+VsGUXSDiGGMar1gFLbxvrNtLUsHz4DgcJdY4Cr+Vtr/XUMFnyjn4rp3fwkEOKUO798M82u5lSS6j0nwQlO3y5Q6o75kIVXdpXJSsemg+eEUMi7QjmIxnyAVgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781319; c=relaxed/simple;
	bh=pkGaVYmo7q0PWUaqJ09mPLwdPz317raSXZUrdAr5kIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ie4EcRRxHoRZapacssUEyDf7uz/YT3FJ80UCmf76mBboND9fTt7y9gajLdGo++Np0IIW9hIi3wdJrgOj38fJsROry3F4AfRXWn0h+GI06Prwr41yAkauCX7jmPOiCdVeF/LdSNR/iF4AnnnMrjT1caZ0gTlgKocDMqxeuIfdaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=s/r9+wu5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42IH1Kb51160896
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 18 Mar 2024 10:01:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42IH1Kb51160896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1710781282;
	bh=XYkV5IBeqScHrMxfYfrnZl/XY+MuisFHguwDrrzC3ps=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=s/r9+wu5qDyydLhuwTBmgeFYiNtJ+mZLNKVtKvF+05dhtLT7Nl+4PnXtaEr38ouSi
	 UMsQGHQ6Q9lfRwteZuUKlm03V9mcJEZ88xhk30c43r2IrVZGnfVbzaxEB11vMdrmy2
	 UmWGG57//FaQVZVoF3QHzQIk1cTKx22BI0Xpl7RVp7pw2zmXGqnbdpBI0kuZzrx2eM
	 PEe6NnxvH8Hx69MKXyTmN3xcEpJPCzHzz31wsm0u4lwOuF3lnEOcioOZIm6ahdD6L0
	 nvcaP6UOUFTaxQc3Z5BIwVGKfxsPwQvjxKkeD4+d5JsOnccptOyKmMzgOBRuZk5A+z
	 d7cxiB+H2FQjw==
Message-ID: <642a5625-126d-40f8-b4fc-df88172f1127@zytor.com>
Date: Mon, 18 Mar 2024 10:01:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] x86/cpufeatures: Automatically generate required
 and disabled feature masks
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
References: <20240201054629.3816748-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240201054629.3816748-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/2024 9:46 PM, Xin Li (Intel) wrote:
> When a CPU feature is not configured, e.g., CONFIG_X86_FRED=n, in a
> build config, its feature disable flag, e.g. DISABLE_FRED, needs to
> be defined and added to a specific disabled CPU features mask in
> <asm/disabled-features.h>, as the following commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/fred&id=e554a8ca49d6d6d782f546ae4d7f036946e7dd87
> 
> This patch set adds an awk script to automatically generate a header
> with required and disabled CPU features masks based on build config.

A gentle ping.

This is an infrastructural improvement which has a lower priority,
however it would be nice to get some feedback first.

Thanks!
     Xin


> 
> 
> H. Peter Anvin (Intel) (2):
>    x86/cpufeatures: Add {required,disabled} feature configs
>    x86/cpufeatures: Generate a feature mask header based on build config
> 
> Xin Li (Intel) (1):
>    x86/cpufeatures: Remove {disabled,required}-features.h
> 
>   arch/x86/Kconfig                              |   4 +-
>   arch/x86/Kconfig.cpu                          |  16 +-
>   arch/x86/Kconfig.cpufeatures                  | 149 +++++++++++++++++
>   arch/x86/Makefile                             |  17 +-
>   arch/x86/boot/cpucheck.c                      |   3 +-
>   arch/x86/boot/cpuflags.c                      |   1 -
>   arch/x86/boot/mkcpustr.c                      |   3 +-
>   arch/x86/include/asm/Kbuild                   |   1 +
>   arch/x86/include/asm/asm-prototypes.h         |   2 +-
>   arch/x86/include/asm/atomic64_32.h            |   2 +-
>   arch/x86/include/asm/bitops.h                 |   4 +-
>   arch/x86/include/asm/cmpxchg_32.h             |   4 +-
>   arch/x86/include/asm/cpufeature.h             |   1 +
>   arch/x86/include/asm/cpufeatures.h            |   8 -
>   arch/x86/include/asm/disabled-features.h      | 154 ------------------
>   arch/x86/include/asm/required-features.h      | 104 ------------
>   arch/x86/kernel/verify_cpu.S                  |   1 +
>   arch/x86/lib/Makefile                         |   2 +-
>   arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
>   arch/x86/tools/featuremasks.awk               | 108 ++++++++++++
>   lib/atomic64_test.c                           |   2 +-
>   tools/arch/x86/include/asm/cpufeatures.h      |   8 -
>   .../arch/x86/include/asm/disabled-features.h  | 154 ------------------
>   .../arch/x86/include/asm/required-features.h  | 104 ------------
>   tools/perf/check-headers.sh                   |   2 -
>   25 files changed, 303 insertions(+), 553 deletions(-)
>   create mode 100644 arch/x86/Kconfig.cpufeatures
>   delete mode 100644 arch/x86/include/asm/disabled-features.h
>   delete mode 100644 arch/x86/include/asm/required-features.h
>   create mode 100755 arch/x86/tools/featuremasks.awk
>   delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
>   delete mode 100644 tools/arch/x86/include/asm/required-features.h
> 
> 
> base-commit: 078b7b997b47c7166c1240cf1d39db9f646a56be

-- 
Thanks!
     Xin


