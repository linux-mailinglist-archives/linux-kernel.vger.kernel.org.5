Return-Path: <linux-kernel+bounces-140145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850D8A0BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA52DB25B66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67143142E94;
	Thu, 11 Apr 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AsdzxpZk"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155713FD68
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826773; cv=none; b=hVQev/T3eTzuPh2ZKi1vnsUBjeFuaUoKYPv3V5zqzyxIL1ACWGi5L2TFA6yk9Fq6G9F3jYcJ4brk+9u/qEEGxoII1tn9Da8C0TAGT9Kh7SyalnA3v6wnpuqhxtcHBOW34X0+wFtt0RdB9ETFNvlpSnGrTNISZMyIjvBCSXoF4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826773; c=relaxed/simple;
	bh=E5KHIQZZU0rzeBrHyjg0655at+txunPpF+rRvnVl86U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mmLCbQzJcTv1GNTv2EAKHahC4nXoyh6ptszvWN1/zSYMo9YN1cnczHnK/k6mOjWBVuoN0k87C+u/O/3yooTS9wHBazJqqQ9u6U81C5lQId93bmGoNQpuTUrX+dwpGapuabt2xka7rmk+aFS14WgJePhvqrYRnxN55skSpcfLYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AsdzxpZk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d874b89081so8387421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712826770; x=1713431570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGLZ4Bj9Hdxr3MjSAXtF+JGNelZvm/tPlncMYTe7qhA=;
        b=AsdzxpZkSvBu8sX/Rlcdr3UE4tP/dTRPqa419RUwlELv/3a39p+QFfEildjBPh+iOb
         +cz1KamX9yoTI4z1ZCspLJNxE/HIv0Xgqxqv58Z6AFWAoBNSpt0zgQjMSKiyUc0bX6Eh
         HQ9SKcoqLtqHSAgKvcnSNS1d9QffKWyumpTdMBS2C+8GtuLUCkghMVffAFldiTRh161K
         5sBXmfT6ziLizUdXDw9lRKHirGYE0jybGIBseqLW7rXUmv+5H5voqsqCqaaKYQ7Oxwm2
         /Q6E4kQSFQGNf5FE2XTG18RJo7sMZ09+/MNm6WF5WGB2RdhlZQpweXkqxD+vomIcfprk
         hVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826770; x=1713431570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGLZ4Bj9Hdxr3MjSAXtF+JGNelZvm/tPlncMYTe7qhA=;
        b=kAll/540ZEjbej1piSvwgGDtLvOOTF0vve6EyWXwN1dE76W0tLXIKjGN+hHJ7gozx3
         Hv4qkEcqcDMMxJxMHQOvsZwWjaywjpdbPOvfDtFGjOCdyjCZlP1DjBLaouvTMtXwgDV4
         NYnyxoWisqeWuNmIa2v5HU5O2sNxeYd+00K9J6Gf67Lvfm4SmstsoPXVw/39TXT+qvrQ
         m+k8oPQ7KX/LG53zxungagNMi/cGHWPIPeOgONI4JT8K73LYr6riOR/TpC64u4cCr714
         AAg1iNl1tzYoJHxuBDx6sVCFFIIG+fo2Olm7fYbDELit0wt14YZR9/u1NWYLeLHvQslH
         jZRA==
X-Forwarded-Encrypted: i=1; AJvYcCWyMcfJ/Z64XfeNXNQhJF6h7+XkpVwFPh1Y47whixV0G2im4+lZC9jIC7OzkmsmEpxRtNgFU/Xe7m5Ebq2fZUB6hquZub0eH1tawVaG
X-Gm-Message-State: AOJu0YwNb3Y0oJf9W23tcYqUuc0Z1j0H1qiIwEieDOChLR9t7BDpXsza
	hwz0sXu8Y0iUH4BwwwBpjtFPhtO251w+SnhMNzP5SvzIBLncRUE5MG590NnnipA=
X-Google-Smtp-Source: AGHT+IEejUVVKUSclkIJJf38XaVm57OwSwAqaAT/Myu/iR8Juzns6W5PNf9Zq1VKdarRzOgAiPzh5w==
X-Received: by 2002:a05:651c:2121:b0:2d8:d41f:931c with SMTP id a33-20020a05651c212100b002d8d41f931cmr2981577ljq.0.1712826770072;
        Thu, 11 Apr 2024 02:12:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3624:d9b3:4998:d76b? ([2a01:e0a:999:a3a0:3624:d9b3:4998:d76b])
        by smtp.gmail.com with ESMTPSA id jg25-20020a05600ca01900b004169836bf9asm4821377wmb.23.2024.04.11.02.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 02:12:49 -0700 (PDT)
Message-ID: <5a285147-4bf8-4634-8f9e-fe78c033b7cb@rivosinc.com>
Date: Thu, 11 Apr 2024 11:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] riscv: nommu: remove PAGE_OFFSET hardcoding
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240410142347.964-1-jszhang@kernel.org>
 <20240410142347.964-2-jszhang@kernel.org>
 <ce7b7413-31ac-4c93-8970-e7cf0d6902cc@rivosinc.com>
Content-Language: en-US
In-Reply-To: <ce7b7413-31ac-4c93-8970-e7cf0d6902cc@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/04/2024 17:30, Clément Léger wrote:
> 
> 
> On 10/04/2024 16:23, Jisheng Zhang wrote:
>> Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
>> there's only one nommu platform in the mainline. However, there are
>> many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
>> the hardcoding value, and introduce DRAM_BASE which will be set by
> 
> Hi Jisheng,
> 
> Typo: s/harcoding/hardcoded
> 
>> users during configuring. DRAM_BASE is 0x8000_0000 by default.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>  arch/riscv/Kconfig | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 7895c77545f1..b4af1df86352 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -247,10 +247,16 @@ config MMU
>>  	  Select if you want MMU-based virtualised addressing space
>>  	  support by paged memory management. If unsure, say 'Y'.
>>  
>> +if !MMU
>> +config DRAM_BASE
>> +	hex '(S)DRAM Base Address'
>> +	default 0x80000000
>> +endif
> 
> I'm not sure but it feels odd to have this at top level config menu.
> Maybe it would make more sense for this to be located under the
> "Platform Type" section ?
> 
> Thanks,
> 
> Clément
> 
>> +
>>  config PAGE_OFFSET
>>  	hex
>>  	default 0xC0000000 if 32BIT && MMU
>> -	default 0x80000000 if !MMU
>> +	default DRAM_BASE if !MMU
>>  	default 0xff60000000000000 if 64BIT

By the way, you should probably rebase that on top of Samuel's work [1]
in order to support !MMU is S-mode.

Thanks,

Clément

Link:
https://lore.kernel.org/lkml/20240227003630.3634533-5-samuel.holland@sifive.com/
[1]

>>  
>>  config KASAN_SHADOW_OFFSET

