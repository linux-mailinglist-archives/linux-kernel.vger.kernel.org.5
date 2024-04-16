Return-Path: <linux-kernel+bounces-147379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA718A7329
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F32829A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0D137934;
	Tue, 16 Apr 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aFQ59IGf"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E12134425
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291837; cv=none; b=pyxFV4Ndr0/Y+RTbYXlfFQ1zXTcsKItHCBmh6vuisUI0ruewy4WcYle9mk+2sRXyQ5uJWOw/10VTLjOM5bVJdQDV8zbfqjsY4PrWHykWu1fouDw2/WRp3sTL0kbcrKG7tBQ4X+4oPhVi7mF1dS0bbnl1x9Khu0wkar9Ab8kSxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291837; c=relaxed/simple;
	bh=G3hwBSPREDo1kUX1NvwSjbHJxRpBR0zp1/Cs/lyumZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNLc+khljFdaWap10lNwkh7WXRsC6IEi9ZYjAsYMg6hhXkRr5QT0LfhOJ4jlcGPUBh0IgZB1Kfrv8mT49fxQuIOyIfy7ipb+UVYdkQIUf0JK0aeEH4anUCrwLW7xyosTl2V8QdTJ30Jgq5lpQSihRUbVq3o/Eg7VNb4PPbFdWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aFQ59IGf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GINTB23343591
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 11:23:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GINTB23343591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713291813;
	bh=W4zvx7KlJcNjgEeJ4qhYH/Ok2a905os4IWOS5dkfsR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aFQ59IGfsOoUJqhudYmuVtmKxw2vY63EL3Dcwb5vzAtNy8xCL11qRqbBMkYSx3rqX
	 cpi95Sso2XYyu1rBYa9O9fgHgf0f1CSsIrnXD4KjWUSStWLxZrJUD4AnLt4ivx0jII
	 yHbUK1edmYsELLb3SVX0OFidQCVmr1k2mH7ejN7oj6zCLmuUYHwG4qanFHJ74R+qMo
	 L+3t6bh3w+bZJb6mPqBOjxsieDXCuU2TSW3lGIIBvi/r+VdJuisVFJmyrhTdGwBt1v
	 cxcvkL8zvI6j4+CsNL9/7P6uwkIJSiXikBm9aD9/BeH+rRi8kcWjhQDd8kpI23AoNc
	 nXrcYl2TNNQ/Q==
Message-ID: <ece31eca-37bc-4b39-9fc9-7e6fda741729@zytor.com>
Date: Tue, 16 Apr 2024 11:23:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240416175804.3328999-1-xin@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240416175804.3328999-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 10:58, Xin Li (Intel) wrote:
> Add a FRED-specific INT80 handler fred_int80_emulation().
> 
> Commit
>    55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
> added a bunch of checks to the int $0x80 path, however they are
> unnecessary and event wrong in fact under FRED.


I think the following points should be added to the head comment, and 
not just the commit log:

> 1) FRED distinguishes external interrupts from software interrupts,
>     thus int80_emulation() should NEVER be called for handling an
>     external interrupt, and then int80_is_external() is meaningless
>     when FRED is enabled.

1a) As INT instructions and hardware interrupts are separate event 
types, FRED does not preclude the use of vector 0x80 for external 
interrupts. As a result the FRED setup code does *NOT* reserve vector 
0x80 and calling int80_is_external() is not merely suboptimal but 
actively incorrect: it could could cause a system call to be incorrectly 
ignored.

> 2) The FRED kernel entry handler NEVER dispatches INTx, which is
>     of event type EVENT_TYPE_SWINT, so the user mode checking in
>     do_int80_emulation() is redundant.
> 
> 3) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likly
s/likly/likely/
>     an overkill for new x86 CPU implementations that support FRED.
s/an //

4) int $0x80 is the FAST path for 32-bit system calls under FRED.

[...]

> A dedicated FRED INT80 handler duplicates most of the code in
s/most/quite a bit/

(I think there is actually less than half the code left. This could be 
further cleaned up by inlining the common code, but if I were still 
maintainer I would not want that for x86/urgent. This patch has the very 
nice property for x86/urgent purposes that it doesn't touch non-FRED 
code at all.)

> do_int80_emulation(), but it avoids sprinkling moar tests and
s/moar/more/
> seems more readable.
> 
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

So, as Borislav pointed out:

Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")

My fault.


