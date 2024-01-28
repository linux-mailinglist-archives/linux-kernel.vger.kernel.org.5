Return-Path: <linux-kernel+bounces-41907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DF83F971
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9161F22192
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151233CFC;
	Sun, 28 Jan 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GxElQOIg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDF33CD3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470459; cv=none; b=s50vWDK3nCfycBpYzOCiCEruPXCC4D9PNS9gYt8TPIF2F9XN3OUtEELvp9XShDFJTkXDOgm9qQjx/wEABWyqr9m4M1uiY/qnQy+XbnRKrXkDYCnpdIUiCobbTH5/1tn67QGMtjj+Bue9YbqwTA1PvrVilj4upNWVQXmOi5eTmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470459; c=relaxed/simple;
	bh=zAyr8u6NAVcez0p7NSlziYI9cWPcjuKrqp86JKbpV0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWH/XMb9fzmzwL8xUiBuuuJ0fdR9wdWSC7NHwLVL4c+N4fFYlfxfnwo6xYH/irqX3Dv52NpOWbYK4LFXoovG0o5zrtKy41Xtn+MeB7Lof/AJgzx3njyHXtDRqwQQ6cJP2AGOrBw8JHaqq0WSZXQyNO5/DODVvFl8EnRYh6aUsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=GxElQOIg reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40SJXPkw1789355
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 28 Jan 2024 11:33:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40SJXPkw1789355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706470406;
	bh=96vGipOx59lTT3wlSdaxzIA8bgY6RlhghuOy110T7sA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GxElQOIg00h+OinI2TjStUbTe8pHUW9FBVErhCsvEUHcfV332f7n1MvQi4VNTO9LD
	 HHkeNubnVL/z+FoUeWCJSkMw5bjym1vTScRHo6R+z9EQw7jDGS+Bf95CobbSLWdStB
	 DQXjYiiiZuRoxoA/MCIC5GRtdMJIJBBR/KX8JCPMjcybil6aJzKj2mKc5BlwXhqrdM
	 FKfHLigmYPVOQa2MlxwfXE0uObucmN7x1DVLLCl5TA2PHEwtSTxv3fA2ax7sRpLABb
	 wgTfVcI4eFsftj4CY09G/kIUXRM0fJEjGlabPs3QazmUjTxxBc8YwwMTBYB7GtB6OZ
	 gtx/Jbw8NFZPg==
Message-ID: <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
Date: Sun, 28 Jan 2024 11:33:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/fred: Fix build with clang
Content-Language: en-US
To: "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-2-xin3.li@intel.com>
 <49BA730F-E9A0-44AA-AB62-D2F40C5C11DD@zytor.com>
 <SA1PR11MB6734916F2BB7E296A6FEE52EA8782@SA1PR11MB6734.namprd11.prod.outlook.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <SA1PR11MB6734916F2BB7E296A6FEE52EA8782@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/24 11:46, Li, Xin3 wrote:
>>> diff --git a/arch/x86/entry/entry_64_fred.S
>>> b/arch/x86/entry/entry_64_fred.S index eedf98de7538..5427e0da190d
>>> 100644
>>> --- a/arch/x86/entry/entry_64_fred.S
>>> +++ b/arch/x86/entry/entry_64_fred.S
>>> @@ -43,13 +43,12 @@ SYM_INNER_LABEL(asm_fred_exit_user,
>> SYM_L_GLOBAL)
>>> 	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
>>> SYM_CODE_END(asm_fred_entrypoint_user)
>>>
>>> -.fill asm_fred_entrypoint_kernel - ., 1, 0xcc
>>> -
>>> /*
>>>   * The new RIP value that FRED event delivery establishes is
>>>   * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
>>>   * ring 0, i.e., asm_fred_entrypoint_user + 256.
>>>   */
>>> +	.fill asm_fred_entrypoint_user + 256 - ., 1, 0xcc
>>> 	.org asm_fred_entrypoint_user + 256
>>> SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
>>> 	FRED_ENTER
>>
>> .fill and .org here are redundant; in fact, there two directives mean exactly the
>> same thing except that .org implicitly subtracts the current offset.
> 
> Ah, right, .fill already does the job!
> 
> I will remove .org.
> 

Incidentally, was there a problem with .org ..., 0xcc?

Not a criticism, I just want to know to better understand current 
binutils limitations.

	-hpa

