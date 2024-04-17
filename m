Return-Path: <linux-kernel+bounces-148757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E88A8707
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF311C219F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6A146A80;
	Wed, 17 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dgYN7RW0"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4713C3EF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366462; cv=none; b=PZSmVw28Z4qOaG3fet8uHBkztM7OCIkzev5hkhxwgJPBf3JvaPctN1u5S/rRoFfJAyi+jSeJraP/Q40Jcxa3DBwzmi616LWCEGk2vIPsW0p6+bCjgVHyuX2iA+p0vAAAarA5ppRp68ghoPquGod6Acc4p+eL8xTQ8BTGXFEnYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366462; c=relaxed/simple;
	bh=GJjCHKH2dsSjH1IMoMJgT+gbrbyzNcXL6q46u4gzC3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvrWVy4+dlNWcmlSqVxPFvBibP6cmucVxNavt/g0pa7G2tLKSLmPqA8smOt+aTv74cZaPjLDLQHEhEcmKqurHloi6o2ZbyqpZnq4LpgQdJ4kZ16xlreZDpLNTdKN7sbcacMjYvI2QXzgcNFz/rGBAvmS9GGJn5kOQgFjRnfAt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dgYN7RW0; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HF7MGM4069601
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 08:07:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HF7MGM4069601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713366443;
	bh=bzaSc0LgdgSrjspfvctBl8dHDYhVXNZrN62zA+MGLIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dgYN7RW0lRY301XtdtT2SislSlceJ3oGEasNzgz6E+iUyOjqJ6EVeo+r8ui8V5RI9
	 qYq2kOzgAC9CHqb5VdJKqY6Omhk1LDqFxDLr1astDQZDbBnRJ2wl5Ciztnip6pKQHA
	 3tJulyTDa3F8dJ7YjoEknT7EGcdBKkQG1HnMGCqN9Yfm6JDpS2ReSZlpJITZmzVJhV
	 otTtiEdTs9A+FNi6Pjc2jDtqZAQdqCCCTov3fBqlCgFBNwvRLbq2PJv5nmm1WJ9q6K
	 meoOMVyGGgU100B6Cg4rxucmMc7BbKQBSf6MaUYyFu6qR3CoZGS3F/Q/hHb4eqVQ62
	 MyQ7R6Q4lpbAw==
Message-ID: <2d0e67dd-c3e3-4701-839a-68d73c61c170@zytor.com>
Date: Wed, 17 Apr 2024 08:07:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: Nikolay Borisov <nik.borisov@suse.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <d0979bd9-fd12-4672-b451-23f23fc2353c@suse.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d0979bd9-fd12-4672-b451-23f23fc2353c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/24 04:02, Nikolay Borisov wrote:
> 
> On 17.04.24 г. 9:30 ч., Xin Li (Intel) wrote:
>> Add a FRED-specific INT80 handler fred_int80_emulation():
>>
>> 1) As INT instructions and hardware interrupts are separate event
>>     types, FRED does not preclude the use of vector 0x80 for external
>>     interrupts. As a result the FRED setup code does *NOT* reserve
>>     vector 0x80 and calling int80_is_external() is not merely
>>     suboptimal but actively incorrect: it could cause a system call
>>     to be incorrectly ignored.
>>
>> 2) fred_int80_emulation(), only called for handling vector 0x80 of
>>     event type EVENT_TYPE_SWINT, will NEVER be called to handle any
>>     external interrupt (event type EVENT_TYPE_EXTINT).
>>
>> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>>     which is of event type EVENT_TYPE_SWINT, so compared with
>>     do_int80_emulation(), there is no need to do any user mode check.
>>
>> 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely 
>> >     overkill for new x86 CPU implementations that support FRED.
> 
> Well, that's a bit of an overstatement/speculation, because 
> clear_branch_history will only be effective if the machine is 
> susceptible to the given bug and there isn't a better options (i.e using 
> a hardware bit controlling the respective aspect of the CPU).
>>

It would seem like a huge stretch to expect that a FRED-capable CPU 
would not have such a facility. This is a matter of establishing a 
baseline for FRED-capable hardware.

It would make more sense to me to add it if we turn out to need it; note 
that FRED code is currently only enabled on demand, in order to defend 
against bit rot until we have physical hardware.

Now, if this is still desired, it *probably* belongs better in either 
fred_intx()/fred_other() or asm_fred_entrypoint_user, depending on if 
this ought to be done for all entries from userspace or only system calls.

	-hpa

