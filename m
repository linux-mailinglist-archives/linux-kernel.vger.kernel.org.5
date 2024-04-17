Return-Path: <linux-kernel+bounces-148742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576728A86D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F901F2249B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7106146A73;
	Wed, 17 Apr 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QvijAM6O"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04013D53B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366000; cv=none; b=cYvDet+00TXA/ANJLOwTW7mdoHWYEBOKHTEqWu4X30WS2eVOFgapvaJsWfm9mSO44bFj2zQxPEkh1wkT37aVuHnzKdqLdMk2XDwAhPX5M0iivAdlOP2WWHob8LnqrUesNt+F+VR5zxkEGlJpdGiJhVLv5LgHxEznmyS8+ZcJwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366000; c=relaxed/simple;
	bh=ZgrrbaCSJMRtonK7p9OX8MB48F0JI8/7kBVr9BuIrG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTSMW+9dIot6RqNWonV9FkfDLERBq5ipw4Hb2FoYcspbNJx7QYJ868uKt3UdMikrGzrBD72dhgczO89mJiCZR87NFkd3ar2rl/RkCRg6qwdzh6UBsPfCPAqtEay7ugfMEet7nzkGFCXvGn4YWNjLdIGoP8AJUFpFborS1Rq/nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QvijAM6O; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HExUMB4064032
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 07:59:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HExUMB4064032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713365971;
	bh=VSJmFsr3EBbN1183B4LxpqSIbjOkuFTUUCyoRaRiqHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QvijAM6OkDa1B0fd+ovvzDYTcAl/YS0j9Ff9btBrPwoVn3+WSbXqS/PxFEPYQFif7
	 aeLNzePK6ihThdXJgiUGry6PNUqx7oTBRp3auf/sG05wAq6BZs7up8bILrmXNBMfen
	 hk7F4Jk4duyFZDvTS36yQJL97ELhSIk/gJtkoDzn23Q4drJdcRiTMJzs0kxd2/1Ohm
	 ye7cPqm0Ulc0B/EYpBY9RNcJ8V2jhqgi4dR4SwSP1gp23+eghIh7LgVlrUlpf3y0lP
	 gbCeZsDwF/i+TIJMC93Qilq2pLHcBnIkAmp7cZ6dApNOY4pLvJUf3Aq7foLeA6iGxl
	 8fQRJ3oyDf0zA==
Message-ID: <5dd74948-a951-4a7a-84ac-7e75cc26bb46@zytor.com>
Date: Wed, 17 Apr 2024 07:59:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 02:38, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 11:30:01PM -0700, Xin Li (Intel) wrote:
>> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>>     which is of event type EVENT_TYPE_SWINT, so compared with
>>     do_int80_emulation(), there is no need to do any user mode check.
> 
> What does that mean?
> 
> An event handler doesn't dispatch INT insns?
> 
> /me is confused.

FRED has separate entry flows depending on if the event came from user 
space or kernel space:

asm_fred_entrypoint_user -> fred_entry_from_user

asm_fred_entrypoint_kernel -> fred_entry_from_kernel

fred_entry_from_kernel does not invoke fred_intx() if the event type is 
EVENT_TYPE_SWINT, instead it falls through to fred_bad_type(). Perhaps 
fred_intx() should be renamed fred_intx_user() for additional clarity.

(It might also we worth noting in that function that the reason int 
$0x03 and int $0x04 are dispatched as INT3 and INTO is to be fully user 
space compatible with legacy IDT, which behaves similarly.)

Thus, the int $0x80 code is simply not reachable from kernel space; if 
kernel code were to invoke int $0x80 or any other INT instruction it 
will error out before getting to this code.

>> +#ifdef CONFIG_X86_FRED
>> +/*
>> + * A FRED-specific INT80 handler fred_int80_emulation() is required:
>> + *
>> + * 1) As INT instructions and hardware interrupts are separate event
>> + *    types, FRED does not preclude the use of vector 0x80 for external
>> + *    interrupts. As a result the FRED setup code does *NOT* reserve
>> + *    vector 0x80 and calling int80_is_external() is not merely
>> + *    suboptimal but actively incorrect: it could cause a system call
>> + *    to be incorrectly ignored.
>> + *
>> + * 2) fred_int80_emulation(), only called for handling vector 0x80 of
>> + *    event type EVENT_TYPE_SWINT, will NEVER be called to handle any
>> + *    external interrupt (event type EVENT_TYPE_EXTINT).
>> + *
>> + * 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>> + *    which is of event type EVENT_TYPE_SWINT, so compared with
>> + *    do_int80_emulation(), there is no need to do any user mode check.
>> + *
>> + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
>> + *    overkill for new x86 CPU implementations that support FRED.
>> + *
>> + * 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
>> + *
>> + * A dedicated FRED INT80 handler duplicates quite a bit of the code in
>> + * do_int80_emulation(), but it avoids sprinkling more tests and seems
>> + * more readable. Just remember that we can always unify common stuff
>> + * later if it turns out that it won't diverge anymore, i.e., after the
>> + * FRED code settles.
>> + */
> 
> And this is talking about duplication above and that text is duplicated
> from the commit message. :)
> 
> I'll zap it when applying.
> 

I suggested putting it into a comment for future reference. Obviously no 
need to duplicate it in the commit message :)

	-hpa


