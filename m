Return-Path: <linux-kernel+bounces-148863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AF8A8848
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8032F281676
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D41487E4;
	Wed, 17 Apr 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ln0oW5qe"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEB13F42C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369377; cv=none; b=ahc6s0FlicrX3t+ReXCMDWWJq8GEk+Ul2OuiAI5VyE5GGAADoJE4YNuYD2rpMsvvPQGCKZOIMtJx5ayRKUxFvQ2x3T2JAOHbl5lAY1YjIIOXmoThYm6AS8e3UAu3zD1XEz75HultaQM+XWfJlqLaBvRIRR/Ji7J/gh2lg6uDaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369377; c=relaxed/simple;
	bh=MPK99SsBce6j62tVF0oHLjCbjiCnP7a4vsEqtMYYkVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGxA7nNvfeDewtyfgJN6FZNjNQUAm/wjtEZooFImcrlf10pfCI5cR9sgcqu23s3bX7sTDdtOiKCgznDLgFaiBa0LqF0RDDfuhwSFtrykSP1/oFLOC4ATNZ3mP+308kS1IHoITJQisovUOQdBmtsS1r7zzMYePzacPSQLu3NW0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Ln0oW5qe; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HFtmfv4097146
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 08:55:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HFtmfv4097146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713369349;
	bh=+fMU2l5Qou0wqC8gUqLaWi6h9YOjdUUx29qf3uYZ3w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ln0oW5qey22/25HToNAaUSsnAxcwT8Y1SRYPy5Ec9ERdrr92bXTZ7Tza2JsxtGbjh
	 lCS8DP3o5kBCw0+0fNjZBxpdo08MoPdfRFYL3TR2uUf9z+9KBa53ug7H/NGImznhTX
	 G1AkXExJgBWGB2nLd5elbZ2UruPXg5qGqQ6KRvMr6ZDLfGlGNYLl3rQWyc8O43rZYX
	 b2dxlIb45Z27USbcTk0YKs6SUIa6MWysI5mAdEnncJRxOwuZOhrk8X7gV35o1SL1U+
	 ilYwpobiDc3F3dL4W7dNGeYNL7qud4jT+WGm/CCF5Gl/6S65+sf0vvuzrR0VMNZmyf
	 UgDb8Tz4CGHcQ==
Message-ID: <58272a50-fa74-4ae8-8ce2-aeb92a0f6ece@zytor.com>
Date: Wed, 17 Apr 2024 08:55:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
To: "H. Peter Anvin" <hpa@zytor.com>, Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <d0979bd9-fd12-4672-b451-23f23fc2353c@suse.com>
 <2d0e67dd-c3e3-4701-839a-68d73c61c170@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <2d0e67dd-c3e3-4701-839a-68d73c61c170@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/2024 8:07 AM, H. Peter Anvin wrote:
> On 4/17/24 04:02, Nikolay Borisov wrote:
>>
>> On 17.04.24 г. 9:30 ч., Xin Li (Intel) wrote:
>>> 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely 
>>> >     overkill for new x86 CPU implementations that support FRED.
>>
>> Well, that's a bit of an overstatement/speculation, because 
>> clear_branch_history will only be effective if the machine is 
>> susceptible to the given bug and there isn't a better options (i.e 
>> using a hardware bit controlling the respective aspect of the CPU).
>>>
> 
> It would seem like a huge stretch to expect that a FRED-capable CPU 
> would not have such a facility. This is a matter of establishing a 
> baseline for FRED-capable hardware.
> 
> It would make more sense to me to add it if we turn out to need it; note 
> that FRED code is currently only enabled on demand, in order to defend 
> against bit rot until we have physical hardware.
> 
> Now, if this is still desired, it *probably* belongs better in either 
> fred_intx()/fred_other() or asm_fred_entrypoint_user, depending on if 
> this ought to be done for all entries from userspace or only system calls.

My bad that I didn't make this a good comment, even neglected that 
clear_branch_history is just a nop on machines w/o such security issues.


So how about?

int80_emulation() does a CLEAR_BRANCH_HISTORY, which is IDT-specific.
While FRED will likely take a different approach when it is needed:
it *probably* belongs in either fred_intx()/fred_other() or
asm_fred_entrypoint_user(), depending on if this ought to be done for 
all entries from userspace or only system calls.

