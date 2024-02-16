Return-Path: <linux-kernel+bounces-69144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7227C858507
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D7B283B90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6F1350D2;
	Fri, 16 Feb 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="yNvVkpsP"
Received: from cmx-torrgo002.bell.net (mta-tor-001.bell.net [209.71.212.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3F131722;
	Fri, 16 Feb 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.212.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107801; cv=none; b=t12bJOI1OI7gcBFSQ0j7gYV+4obl5drEkPQ2n2V7vnsakHP0gXb9cNo1RZueL/Afpf8wgGBf54AdjtdrcQfkEEtkTU5HiwnT6KcitmbTgmwncjx+lQgfQoK2NRqkEdtQ7WGySLBjTcDqtly6DljRop6yK3NCjqcSW9zY9JjjRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107801; c=relaxed/simple;
	bh=FvUe8W9Hmcl8gFW1bXYWCYgPQaFVKK6OT99R+CKanLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+CYE57uncqnE3LNkpna8tgpyBTzMANJf0FBySYFP3++T61PYMRejEs4HeZxoNamoM+YZ/xk+/uG6FlEuZ2FGtqT/Go3FBcsfhIv/06qLqI0iI5PSI55dX3Q9Vk/pDda8ClxrF7vdj5TC9Qrx/Jy2YhFhRhioaGQ/mB/JCsKElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=yNvVkpsP; arc=none smtp.client-ip=209.71.212.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1708107799; 
        bh=qGYo16pq9XIquYk04XBX8gfc5aubMMwpC4D03dv1faQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=yNvVkpsPDSmVCP3w8ObuwqBgIZ9XE/+q0SaVG/McRRPmxvYaYfF1GG5ZacjAwPEkAY9YO7TyUvYmWGQGUkHQfWu0Nx+VZdmTtEtnYfm7vizapRECbQp6kwtN7WmGnlpHu7bUGzMVH4uLOWaGFqqMnz1NHeQTqIhr8xDtObtNQQ2dhf96mYwzYPkJ1YLJTwSRfRi0RuxtHhqfPuQTBQsqmkWCNr2HdMZqnaTdicVV0s7fQbBT1yuXW6OKpw5Ez1JZUW+LtiMBreCH1/tOotukKMqCtwQPFJKFGq6NO+ZslvHcbhgoBVr1ShzxfnhGLo6uvl8f+fq0vRDfcB+C4Aaclw==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 65CD7507002C3F44
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuefgnffnpdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhohhhnucffrghvihguucetnhhglhhinhcuoegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeelffffjeehgffgueehleegfeegueeigedtkeffgeduueetffegffejudekgfeunecukfhppedugedvrdduvdeirdduuddvrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedrudduvddrvdeffedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepffgrvhhiugdrnfgrihhghhhtsegrtghulhgrsgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepuggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghr
	nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.112.233) by cmx-torrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 65CD7507002C3F44; Fri, 16 Feb 2024 13:22:52 -0500
Message-ID: <3aa75d93-724b-4c87-906a-a58fa0a9f832@bell.net>
Date: Fri, 16 Feb 2024 13:22:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
To: Helge Deller <deller@gmx.de>, Guenter Roeck <linux@roeck-us.net>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
Content-Language: en-US
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-16 12:54 a.m., Helge Deller wrote:
> On 2/15/24 02:58, Guenter Roeck wrote:
>> Hi Charlie,
>>
>> On 2/14/24 17:30, Charlie Jenkins wrote:
>>> On Wed, Feb 14, 2024 at 03:03:07PM -0800, Guenter Roeck wrote:
>>>> On 2/14/24 13:41, Charlie Jenkins wrote:
>>>>> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
>>>>> variety of architectures that are big endian or do not support
>>>>> misalgined accesses. Both of these test cases are changed to support big
>>>>> and little endian architectures.
>>>>>
>>>>> The test for ip_fast_csum is changed to align the data along (14 +
>>>>> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
>>>>> csum_ipv6_magic aligns the data using a struct. An extra padding field
>>>>> is added to the struct to ensure that the size of the struct is the same
>>>>> on all architectures (44 bytes).
>>>>>
>>>>> The test for csum_ipv6_magic somewhat arbitrarily aligned saddr and
>>>>> daddr. This would fail on parisc64 due to the following code snippet in
>>>>> arch/parisc/include/asm/checksum.h:
>>>>>
>>>>> add        %4, %0, %0\n"
>>>>> ldd,ma        8(%1), %6\n"
>>>>> ldd,ma        8(%2), %7\n"
>>>>> add,dc        %5, %0, %0\n"
>>>>>
>>>>> The second add is expecting carry flags from the first add. Normally,
>>>>> a double word load (ldd) does not modify the carry flags. However,
>>>>> because saddr and daddr may be misaligned, ldd triggers a misalignment
>>>>> trap that gets handled in arch/parisc/kernel/unaligned.c. This causes
>>>>> many additional instructions to be executed between the two adds. This
>>>>> can be easily solved by adding the carry into %0 before executing the
>>>>> ldd.
>>>>>
>>>>
>>>> I really think this is a bug either in the trap handler or in the hppa64
>>>> qemu emulation. Only unaligned ldd instructions affect (actually,
>>>> unconditionally set) the carry flag. That doesn't happen with unaligned
>>>> ldw instructions. It would be worthwhile tracking this down since there are
>>>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
>>>> when running the kernel in 64-bit mode. On the other side, I guess this
>>>> is a different problem. Not sure though if that should even be mentioned
>>>> here since that makes it sound as if it would be expected that such
>>>> accesses impact the carry flag.
>>>
>>> I wasn't confident it was a bug somewhere so that's why I sent this patch.
>>>
>>> However, I have just found the section of the processor manual [1] I was
>>> looking for (Section Privileged Software-Accessible Registers subsection
>>> Processor Status Word (PSW)):
>>>
>>> "Processor state is encoded in a 64-bit register called the Processor
>>> Status Word (PSW). When an interruption occurs, the current value of the
>>> PSW is saved in the Interruption Processor Status Word (IPSW) and
>>> usually all defined PSW bits are set to 0.
>>>
>>> "The PSW is set to the contents of the IPSW by the RETURN FROM
>>> INTERRUPTION instruction. The interruption handler may restore the
>>> original PSW, modify selected bits, or may change the PSW to an entirely
>>> new value."
>>>
>>> Stored in the PSW register are the "Carry/borrow bits". This confirms
>>> that the carry/borrow bits should be restored. The save is supposed to
>>> automatically happen upon an interrupt and restored by the RETURN FROM
>>> INTERRUPTION, thus this is a QEMU bug and not a Linux bug (please
>>> correct me if I am wrong).
>>>
>>
>> I know that much (I looked into the manual as well), I just really don't
>> know if this is a Linux bug or a QEMU bug, and I have not been able to
>> nail it down. I think someone with access to hardware will need to confirm.
>>
>> Specifically: Yes, the carry/borrow bits should be restored. Question is
>> if the Linux kernel's interrupt handler doesn't restore the carry bits
>> or if the problem is on the qemu side.
>>
>>> This v8 was not needed after-all it seems. It would be best to stick
>>> with the v7.
>>>
>> I tend to agree; after all, v7 exposes the problem, making it easier to
>> determine if the problem can be reproduced on real hardware.
>>
>> FWIW,I wrote some test code which exposes the problem.
>
> Can you please give a pointer to this test code?
> I'm happy to try it on real hardware.
>
>> It is quite easy to show that carry is always set after executing ldd
>> on an unaligned address. That is also why I know for sure that the
>> problem is not seen with ldw on unaligned addresses.
> Interesting.
> In general I think it's quite important to differentiate between
> running on qemu or running on physical hardware.
> Qemu just recently got 64-bit support, and it's not yet behaving
> like real hardware. One thing I noticed is, that read hardware
> does not seem to jump into the exception handler twice, while
> qemu does. So, if you run into an exception (e.g. unaligned ldd)
See page 2-13 of arch.  An interruption sets the PSW Q bit to 0 freezing the IIA
queues.  If an interruption occurs with Q=0, the interruption parameter registers
are left unchanged, so I don't think there's a way to handle double exceptions
on real hardware (Q would have to be set back to 1 after the IPRs are read).

Dave

-- 
John David Anglin  dave.anglin@bell.net


