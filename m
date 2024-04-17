Return-Path: <linux-kernel+bounces-148814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F98A87BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC771C21F47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F91487CE;
	Wed, 17 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L7WN8uZC"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EE13C3EF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368097; cv=none; b=Ev9j2M6EvuCp7dgjFFYcDWS7ZaVFImbZ3SwpyTrEGOY9/rVrLSXq6Efc2iDt8B4L47xmNPn1VRUAbn5fPcmj5RXh9/GFweGPnw8B+drnHWZKuk2k6Vlj0zDoi2EeoUqxsnr76O5LaisLJpEDAsdpaXz707lu6G3lVS/xbHTDCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368097; c=relaxed/simple;
	bh=2vOagO6jE6DjFNxsKLI07Zz2kYkLwAdFXJ85u5L5jAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1rlp2WzIn4j/fdUSq/99lHd0P09XgMMI2rElyPABbWNYe0UytUfZDjBpPLpLH/1rtwS8+VCLyk/dwSpbHnzhVpmNQa1We1ZXO44vJDSbTmhYjnZA/o8o2xCds9Wa7KtQbIG/xgw4XeXh236ddmn66Pb/xoeios6eoCI8k5RJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=L7WN8uZC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HFYUrF4085034
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 08:34:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HFYUrF4085034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713368071;
	bh=CbbSoysc8+kTfQsSO7LDFZAr17fUxi8U9MPc4mSBtDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L7WN8uZChGnO3ZUaSpEquwJTpQZxvHyfEIKSNgGsG2XTF/RENU2ULfdYg7F7NbW2h
	 e54BbaLZie4OR/uKdZHrWxHgVriB6XR9u7zsPcrfRpQRwWOEU0ul/RcypDSNuFXqOd
	 VcJTcLhk7y5g9nKvnXd4oRjM3ObbOsKRD/q/vBpcW+uP3QiQEb2tB4n5HqlT8Kf6Wl
	 zlW/GnuCuV29RGWqqdoM4dywZpXSZiAXvisgHObJ2LZyT4qcAZRgAIg2vUrlP/XCjY
	 tyQdQvDtzNSEIdOHyw/91Vi2AX6YJ829s/6PJvX/7iMYMJyJpeMeuW5SOf1utF49qj
	 HZD2e+INDrHjQ==
Message-ID: <1eaf08d5-2dd9-4517-b340-47cc7aa4cf05@zytor.com>
Date: Wed, 17 Apr 2024 08:34:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
 <5dd74948-a951-4a7a-84ac-7e75cc26bb46@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <5dd74948-a951-4a7a-84ac-7e75cc26bb46@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/2024 7:59 AM, H. Peter Anvin wrote:
> On 4/17/24 02:38, Borislav Petkov wrote:
>> On Tue, Apr 16, 2024 at 11:30:01PM -0700, Xin Li (Intel) wrote:
>>> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>>>     which is of event type EVENT_TYPE_SWINT, so compared with
>>>     do_int80_emulation(), there is no need to do any user mode check.
>>
>> What does that mean?
>>
>> An event handler doesn't dispatch INT insns?
>>
>> /me is confused.
> 
> FRED has separate entry flows depending on if the event came from user 
> space or kernel space:
> 
> asm_fred_entrypoint_user -> fred_entry_from_user
> 
> asm_fred_entrypoint_kernel -> fred_entry_from_kernel
> 
> fred_entry_from_kernel does not invoke fred_intx() if the event type is 
> EVENT_TYPE_SWINT, instead it falls through to fred_bad_type(). Perhaps 
> fred_intx() should be renamed fred_intx_user() for additional clarity.

This is a good idea, and again naming is so important.

> 
> (It might also we worth noting in that function that the reason int 
> $0x03 and int $0x04 are dispatched as INT3 and INTO is to be fully user 
> space compatible with legacy IDT, which behaves similarly.)

Yeah, this is subtle, and we'd better make it explicit with comments.

FRED distinguishes int $0x03/$0x04 from INT3/INTO with event type 
EVENT_TYPE_SWINT and EVENT_TYPE_SWEXC, and the Linux kernel itself can 
still use INT3/INTO, however int $0x03/$0x04 is NOT allowed from kernel 
context.

> 
> Thus, the int $0x80 code is simply not reachable from kernel space; if 
> kernel code were to invoke int $0x80 or any other INT instruction it 
> will error out before getting to this code.
> 
>>> +#ifdef CONFIG_X86_FRED
>>> +/*
>>> + * A FRED-specific INT80 handler fred_int80_emulation() is required:
>>> + *
>>> + * 1) As INT instructions and hardware interrupts are separate event
>>> + *    types, FRED does not preclude the use of vector 0x80 for external
>>> + *    interrupts. As a result the FRED setup code does *NOT* reserve
>>> + *    vector 0x80 and calling int80_is_external() is not merely
>>> + *    suboptimal but actively incorrect: it could cause a system call
>>> + *    to be incorrectly ignored.
>>> + *
>>> + * 2) fred_int80_emulation(), only called for handling vector 0x80 of
>>> + *    event type EVENT_TYPE_SWINT, will NEVER be called to handle any
>>> + *    external interrupt (event type EVENT_TYPE_EXTINT).
>>> + *
>>> + * 3) The FRED kernel entry handler does *NOT* dispatch INT 
>>> instructions,
>>> + *    which is of event type EVENT_TYPE_SWINT, so compared with
>>> + *    do_int80_emulation(), there is no need to do any user mode check.
>>> + *
>>> + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
>>> + *    overkill for new x86 CPU implementations that support FRED.
>>> + *
>>> + * 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
>>> + *
>>> + * A dedicated FRED INT80 handler duplicates quite a bit of the code in
>>> + * do_int80_emulation(), but it avoids sprinkling more tests and seems
>>> + * more readable. Just remember that we can always unify common stuff
>>> + * later if it turns out that it won't diverge anymore, i.e., after the
>>> + * FRED code settles.
>>> + */
>>
>> And this is talking about duplication above and that text is duplicated
>> from the commit message. :)
>>
>> I'll zap it when applying.
>>
> 
> I suggested putting it into a comment for future reference. Obviously no 
> need to duplicate it in the commit message :)
> 

yes!


