Return-Path: <linux-kernel+bounces-126688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFA893B78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B481F21AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD73F9DA;
	Mon,  1 Apr 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="Hg/qS9OT"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED643F9C3;
	Mon,  1 Apr 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978272; cv=none; b=PSIII9XXh8wHQ36IYcsiaTStJSx4sxH8pLgsvr6Dn++/Hf9DpyHw9j9nwrBfBgyezdFOsB5vy2fnsdz7cqhVyL/OKKtLz7aXwbhVB07rVFXpBJ7fGGm/AuV3PjobzVDn1eswTUxxqqJoVV0BS/qN6HKNlTQuMhIRnW6fHdsy4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978272; c=relaxed/simple;
	bh=yBHlFOlUa+x+vznWCR5gLKY9ALfcjMiqjMiLEzniUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2tdC3gD/3e/gF8UCpbs63h7TSoabjlyn/jiyBTBWf0H5/VwsL+ON76ydirifBHsfYD7DjXVW4v7FCNWFTpss9/CBE/NfTUqrm9f77XpvGjSLJT+cU+Nw3ZerwoMQw952qZc7jB62WsxKazErSTb/JHbUVml8ExwrfvHt2820J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=Hg/qS9OT; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id F2B14260DE;
	Mon,  1 Apr 2024 13:31:02 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 3D7013E874;
	Mon,  1 Apr 2024 13:30:55 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 44DED40076;
	Mon,  1 Apr 2024 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1711978253;
	bh=yBHlFOlUa+x+vznWCR5gLKY9ALfcjMiqjMiLEzniUn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hg/qS9OTKsQ9pFnkdv7I00oaFdGhqGhxASUK9RBocdlMSQAgtYR44FVGVcJgWxjaI
	 DvzDMU9+tYnl0/7r987tRtL+tvKqvL5fJgmxmx67SPAHjLezoBVjfJhZiKLzMeG0Cc
	 VqMkrRPVDqrk27tp2BWhXf/1FEKptwDQITUeFrwo=
Received: from [10.66.66.7] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id AF33641139;
	Mon,  1 Apr 2024 13:30:46 +0000 (UTC)
Message-ID: <0d9ce519-7b87-48e4-a374-33ae0df8f730@pavinjoseph.com>
Date: Mon, 1 Apr 2024 19:00:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, Eric Hagberg <ehagberg@gmail.com>,
 Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>,
 Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
 Dimitri Sivanich <sivanich@hpe.com>,
 Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
 <ZgZqhWoRZoq5tJoU@gmail.com>
 <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
 <ZgZ4qlbncvxhboQ0@gmail.com>
 <be5982f8-3928-455e-969c-1e4c419d80a2@pavinjoseph.com>
 <ZgbCfVPvWroCnGE4@gmail.com> <871q7r12d2.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <871q7r12d2.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.11 / 10.00];
	BAYES_SPAM(0.20)[66.67%];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[hpe.com,linux.intel.com,kernel.org,infradead.org,linutronix.de,redhat.com,alien8.de,zytor.com,vger.kernel.org,lists.linux.dev,gmail.com,verge.net.au,dbc.dk,antgroup.com,linux-foundation.org,google.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 44DED40076

Hi Eric,

Here's the output of /proc/iomem:

suse-laptop:~ # cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009221f : System RAM
00092220-0009229f : System RAM
000922a0-0009828f : System RAM
00098290-0009829f : System RAM
000982a0-0009efff : System RAM
0009f000-0009ffff : Reserved
000e0000-000fffff : Reserved
   000a0000-000effff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-09bfffff : System RAM
   06200000-071fffff : Kernel code
   07200000-07e6dfff : Kernel rodata
   08000000-082e3eff : Kernel data
   08ba8000-08ffffff : Kernel bss
09c00000-09d90fff : Reserved
09d91000-09efffff : System RAM
09f00000-09f0efff : ACPI Non-volatile Storage
09f0f000-bf5a2017 : System RAM
   ba000000-be7fffff : Crash kernel
bf5a2018-bf5af857 : System RAM
bf5af858-c3a60fff : System RAM
c3a61000-c3b54fff : Reserved
c3b55000-c443dfff : System RAM
c443e000-c443efff : Reserved
c443f000-c51adfff : System RAM
c51ae000-c51aefff : Reserved
c51af000-c747dfff : System RAM
c747e000-cb67dfff : Reserved
   cb669000-cb66cfff : MSFT0101:00
     cb669000-cb66cfff : MSFT0101:00
   cb66d000-cb670fff : MSFT0101:00
     cb66d000-cb670fff : MSFT0101:00
cb67e000-cd77dfff : ACPI Non-volatile Storage
cd77e000-cd7fdfff : ACPI Tables
cd7fe000-ce7fffff : System RAM
ce800000-cfffffff : Reserved
d0000000-f7ffffff : PCI Bus 0000:00
f8000000-fbffffff : PCI ECAM 0000 [bus 00-3f]
   f8000000-fbffffff : Reserved
     f8000000-fbffffff : pnp 00:00
fc000000-fdffffff : PCI Bus 0000:00
   fd000000-fd0fffff : PCI Bus 0000:05
     fd000000-fd0007ff : 0000:05:00.1
       fd000000-fd0007ff : ahci
     fd001000-fd0017ff : 0000:05:00.0
       fd001000-fd0017ff : ahci
   fd100000-fd4fffff : PCI Bus 0000:04
     fd100000-fd1fffff : 0000:04:00.3
       fd100000-fd1fffff : xhci-hcd
     fd200000-fd2fffff : 0000:04:00.4
       fd200000-fd2fffff : xhci-hcd
     fd300000-fd3fffff : 0000:04:00.2
       fd300000-fd3fffff : ccp
     fd400000-fd47ffff : 0000:04:00.0
     fd480000-fd4bffff : 0000:04:00.5
     fd4c0000-fd4c7fff : 0000:04:00.6
       fd4c0000-fd4c7fff : ICH HD audio
     fd4c8000-fd4cbfff : 0000:04:00.1
       fd4c8000-fd4cbfff : ICH HD audio
     fd4cc000-fd4cdfff : 0000:04:00.2
       fd4cc000-fd4cdfff : ccp
   fd500000-fd5fffff : PCI Bus 0000:03
     fd500000-fd503fff : 0000:03:00.0
       fd500000-fd503fff : nvme
   fd600000-fd6fffff : PCI Bus 0000:02
     fd600000-fd60ffff : 0000:02:00.0
       fd600000-fd60ffff : rtw88_pci
   fd700000-fd7fffff : PCI Bus 0000:01
     fd700000-fd703fff : 0000:01:00.0
     fd704000-fd704fff : 0000:01:00.0
       fd704000-fd704fff : r8169
   fde10510-fde1053f : MSFT0101:00
   fdf00000-fdf7ffff : amd_iommu
feb00000-feb00007 : SB800 TCO
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec1001f : pnp 00:04
fed00000-fed003ff : HPET 2
   fed00000-fed003ff : PNP0103:00
     fed00000-fed003ff : pnp 00:04
fed61000-fed613ff : pnp 00:04
fed80000-fed80fff : Reserved
   fed80000-fed80fff : pnp 00:04
fed81200-fed812ff : AMDI0030:00
fed81500-fed818ff : AMDI0030:00
   fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc2000-fedc2fff : AMDI0010:00
   fedc2000-fedc2fff : AMDI0010:00 AMDI0010:00
fedc3000-fedc3fff : AMDI0010:01
   fedc3000-fedc3fff : AMDI0010:01 AMDI0010:01
fedc4000-fedc4fff : AMDI0010:02
   fedc4000-fedc4fff : AMDI0010:02 AMDI0010:02
fee00000-fee00fff : pnp 00:00
ff000000-ffffffff : pnp 00:04
100000000-3af37ffff : System RAM
   399000000-3ae4fffff : Crash kernel
3af380000-42fffffff : Reserved
430000000-ffffffffff : PCI Bus 0000:00
   460000000-4701fffff : PCI Bus 0000:04
     460000000-46fffffff : 0000:04:00.0
     470000000-4701fffff : 0000:04:00.0
3fff80000000-3fffffffffff : 0000:04:00.0


Thanks for creating kexec btw, it's invaluable for systems with slow 
firmware and loader 🚀

Pavin.

On 3/31/24 09:25, Eric W. Biederman wrote:
> Ingo Molnar <mingo@kernel.org> writes:
> 
>> * Pavin Joseph <me@pavinjoseph.com> wrote:
>>
>>> On 3/29/24 13:45, Ingo Molnar wrote:
>>>> Just to clarify, we have the following 3 upstream (and soon to be upstream) versions:
>>>>
>>>>    v1: pre-d794734c9bbf kernels
>>>>    v2: d794734c9bbf x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>>>>    v3: c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
>>>>
>>>> Where v1 and v3 ought to be the same in behavior.
>>>>
>>>> So how does the failure matrix look like on your systems? Is my
>>>> understanding accurate:
>>
>>> Slight correction:
>>>
>>>     regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
>>> -----------------|---------------|----------------|------------------
>>> v1:       OK     | OK            | OK             | FAIL
>>> v2:       OK     | FAIL          | OK             | FAIL
>>
>> Thanks!
>>
>> So the question is now: does anyone have a theory about in what fashion
>> the kexec nogbpages bootup differs from the regular nogbpages bootup to
>> break on your system?
>>
>> I'd have expected the described root cause of the firmware not properly
>> enumerating all memory areas that need to be mapped to cause trouble on
>> regular, non-kexec nogbpages bootups too. What makes the kexec bootup
>> special to trigger this crash?
> 
> My blind hunch would be something in the first 1MiB being different.
> The first 1MiB is where all of the historical stuff is and where
> I have seen historical memory maps be less than perfectly accurate.
> 
> Changing what is mapped being the difference between success and failure
> sounds like some place that is dark and hard to debug a page fault is
> being triggered and that in turn becoming a triple fault.
> 
> Paving Joseph is there any chance you can provide your memory map?
> Perhaps just cat /proc/iomem?
> 
> If I have something to go one other than works/doesn't work I can
> probably say something intelligent.
> 
> Eric

