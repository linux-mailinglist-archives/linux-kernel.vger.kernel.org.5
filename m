Return-Path: <linux-kernel+bounces-148925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDE8A8910
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5651F21FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0516FF59;
	Wed, 17 Apr 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S29DOr7g"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08816FF48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371991; cv=none; b=d5M6hBeHUaS4l9YB8M9rkMKwCnpTdWStNyyfD9aeLPWivzqj8IWB8GUMR8oKgoqKsYJmO7bpFQQqFCgFskD+NvkY6HWas+hXUdRqN3gHbzj7he5om/myx4+dQ9MP1G+wmlK7LYakgt/6IsZhO4pzeJc58yKVolNnU8X0ZW/cmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371991; c=relaxed/simple;
	bh=SryDiuSYcrpNErNPy68el8FzF+t+Vez0QoP2+9L+xCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifT3Tu+BBZvWl1kGUIOFLLUU3WxGUyQbU9I1vOhq1iVbvntMi5sIUxkKyNa5H8O1OBIZkyTpW+3IyRctGIsk5KrtjU2KQ/62QgUao9wUyNtgq3YGSDcTlA92//Q3VJYgHsBqWtBsfFfAgxZjSuEAteyHusEG9SOPU3ZOZJDk8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S29DOr7g; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HGdIHU4121136
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 09:39:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HGdIHU4121136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713371959;
	bh=aFOyjgeeVC1KAS9+YY5P8pEQ4weaaw/qGPlvhbW2uLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S29DOr7g42La7v70TTZ2C8olOL81LbNUMtoeBxN7wgKkOq+R0ggdE3Rc69EFGfbQ6
	 WXQbS5LlvFkgUIDf4X0hyXCLxlZ7TGadomFDo9qwBp7NuF2slS+Sf0R730CnBWDOb+
	 YEY2rP1hyO54Ku+lABoJMJOZryp9GO5jqnjmT1G+N+h5lC16ji9xhHAc2pau0V1KD3
	 vw0w8JjFjrjXiUyhxmjzohV1NwypbomLgFU5AnfYR06gVR09/rqSH8HIcOzvhAagaf
	 lA6j4RVUOwO9lrqSFoMDBK7LldEauVkATb8xajKXAKUMIUUByxDr0FZQrXPhLRg/EB
	 bL29leA7UFi1g==
Message-ID: <908d65db-6926-449e-8aca-5f9968f7fcd6@zytor.com>
Date: Wed, 17 Apr 2024 09:39:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: Xin Li <xin@zytor.com>, Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <d0979bd9-fd12-4672-b451-23f23fc2353c@suse.com>
 <2d0e67dd-c3e3-4701-839a-68d73c61c170@zytor.com>
 <58272a50-fa74-4ae8-8ce2-aeb92a0f6ece@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <58272a50-fa74-4ae8-8ce2-aeb92a0f6ece@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/24 08:55, Xin Li wrote:
> On 4/17/2024 8:07 AM, H. Peter Anvin wrote:
>> On 4/17/24 04:02, Nikolay Borisov wrote:
>>>
>>> On 17.04.24 г. 9:30 ч., Xin Li (Intel) wrote:
>>>> 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely 
>>>> >     overkill for new x86 CPU implementations that support FRED.
>>>
>>> Well, that's a bit of an overstatement/speculation, because 
>>> clear_branch_history will only be effective if the machine is 
>>> susceptible to the given bug and there isn't a better options (i.e 
>>> using a hardware bit controlling the respective aspect of the CPU).
>>>>
>>
>> It would seem like a huge stretch to expect that a FRED-capable CPU 
>> would not have such a facility. This is a matter of establishing a 
>> baseline for FRED-capable hardware.
>>
>> It would make more sense to me to add it if we turn out to need it; 
>> note that FRED code is currently only enabled on demand, in order to 
>> defend against bit rot until we have physical hardware.
>>
>> Now, if this is still desired, it *probably* belongs better in either 
>> fred_intx()/fred_other() or asm_fred_entrypoint_user, depending on if 
>> this ought to be done for all entries from userspace or only system 
>> calls.
> 
> My bad that I didn't make this a good comment, even neglected that 
> clear_branch_history is just a nop on machines w/o such security issues.
> 
> 
> So how about?
> 
> int80_emulation() does a CLEAR_BRANCH_HISTORY, which is IDT-specific.
> While FRED will likely take a different approach when it is needed:

s/when/if it is ever needed/

> it *probably* belongs in either fred_intx()/fred_other() or
> asm_fred_entrypoint_user(), depending on if this ought to be done for 
> all entries from userspace or only system calls.

