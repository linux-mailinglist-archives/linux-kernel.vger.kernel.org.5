Return-Path: <linux-kernel+bounces-71569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD6385A72D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024B31F219A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F03B39850;
	Mon, 19 Feb 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="tLMeI8Mq"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48638F98
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355733; cv=none; b=O7vb+I18o6BSLqh8lR9hYKRPz7IDG/mGM2kWJQYIc/hsjSx99vZvfQPreoo1xdprAFUIVHqkNWaLgwMoYW/VZnwVYkEpqnGPXZ2jScauLhj1enb/Q35yy1M/XNp24DbEMRUxrfZa7TnM7sqexhtAwRVfLQfMGfFczyxmEzRXP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355733; c=relaxed/simple;
	bh=vlG3pthoQLIPwXJXiN7DgusyqFTJyLtnMlILJarUsY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ru31obcBsjesB/97d+W89Q3ehyuTNUmI0Z27bgM4iN+8NlVGJmi5eDM6F4v6qv2FI4RTVBV1UACt8+8IwHn5fUnSwEi+PpJ+sY+YzR5GUWq0uLUa1Ev/VfWHtv1EP36Zm+fQ3EXWwmX3F3iYt3lIxCzlzz89UDI9g4o981gUMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=tLMeI8Mq; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 41JExkqA064263
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:59:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1708354781; x=1710946781;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vlG3pthoQLIPwXJXiN7DgusyqFTJyLtnMlILJarUsY0=;
	b=tLMeI8MqCNN1SO9QLnyZQF80xhgWSHQ41KEqtVRa+Bd+dIvHdplqHDpZE82fMxwd
	uFYIkozSriiP8Zozup0Y7OmU9BH2zlb01bWfG0MHWuYLSEppelDp8sZxX1HEcxs5
	GLXRbCLUS3G4V9xDt53wrrjT/FFbObXJBefD8pGVgk2tuhSFX7aK6elXQnROPEHv
	5HUgeCTL9GEV/d185UOrLo8BLlB7UC42+l4iPLhioM1/EJ2UTURwwUzJoo+1/UHw
	1s0o6Jz1Hl5jgsFE7kQadKJeZMql++qDlCjWIu2/5G3nqkS1+gc0i79ZKkkQVV41
	M1f31Yw+SIOI9jBDMU6CeA==;
X-AuditID: 8b5b014d-a23ec70000002178-29-65d36cdce0ba
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id B1.1A.08568.CDC63D56; Mon, 19 Feb 2024 16:59:41 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: dvlachos at ics.forth.gr
Message-ID: <c1bfe028-e17d-4975-9ac2-72bc597f7182@ics.forth.gr>
Date: Mon, 19 Feb 2024 16:59:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:[PATCH] [RFC] sparsemem: warn on out-of-bounds initialization
Content-Language: en-US
To: alexghiti@rivosinc.com
References: <CAHVXubjanrxkDrNTZMrPtmewjqyf3L4_TTtqXhjGV+k+qkynmA@mail.gmail.com>
 <cc83e4a4-4d5a-4175-8c0f-c2a7baabdfe8@csd.uoc.gr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org,
        arnd@arndb.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
        mick@ics.forth.gr, csd4492@csd.uoc.gr
From: dvlachos <dvlachos@ics.forth.gr>
In-Reply-To: <cc83e4a4-4d5a-4175-8c0f-c2a7baabdfe8@csd.uoc.gr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42Lpjp6urHs353KqwexZrBZz1q9hs3jceJzR
	4u+kY+wW6xvXsVuseRpicXnXHDaLbZ9b2Cya351jt3h5uYfZom0Wv8WR9duZHLg9fv+axOjx
	6fIvFo83L1+yeDzcdInJY9OqTjaPEzN+s3hsXlLvcWNWhMfd6y+ZPC41X2f3+LxJLoA7issm
	JTUnsyy1SN8ugSvj5e8u1oJtFhVzr19hb2B8qNPFyMkhIWAicffKQsYuRi4OIYEjjBK3F81h
	h0jYSuxdcJwJxOYVsJc4dnMZG4jNIqAqse7IVHaIuKDEyZlPWEBsUQF5ifu3ZoDFhQU8Jbat
	OA/WyywgLnHryXwwW0RASmLq9OPsEMtaGCUWvtnBDOIwC/xjlLh4opERpIpNQE3iTucxMJtT
	wE6i48MadohJZhJdW7sYIWx5ieats5knMArMQnLILCQLZyFpmYWkZQEjyypGgcQyY73M5GK9
	tPyikgy99KJNjOCYYvTdwXh781u9Q4xMHIyHGCU4mJVEeN2bLqQK8aYkVlalFuXHF5XmpBYf
	YpTmYFES5z1huyBZSCA9sSQ1OzW1ILUIJsvEwSnVwKT76sAqrwtdF2Q+XYnqSJD5VMPeJ1Eb
	rrou8+7G3N2LBLKmB+b07HzaI+LB8sSf8cv/tF8n6i5fX2/dYDW7eBPXoz9JZ97NKvs+f7vh
	/RCmGJUrNzQ1wtfyM8z6f8l6Se/pjz8+2DhrfOppTFqf3Blw/trHJfd6VzEEaKz6NUPrsv09
	taOehpYqgjv/TpjGyOWwZ2+n7s4FmlyPGL4YVonF/p6juaT7wft9vR4WBoqHdouzq+fK1CyL
	MlHisW36wzvj8bYrlqHVyx78fp5514JPjuH2/9tP1lbcMJTgt9lT3JFs2WUaPYXj/vp98jOf
	tjwJS8krtH5847/3toWvH6+o13RfKfZJPVV0eXfzcT8lluKMREMt5qLiRADRC23CGAMAAA==

Alexandre,

Yes, you understood correctly, I indeed proposed to change 
pfn_to_page()/page_to_pfn() but your solution appears to solve the 
problem without risking any modifications to the conversion macros. In 
addition, your solution seems to be valid for any phys_ram_base/pfn 
value inside the limits of physical memory.

However, I wanted to note that if the pfn is large enough, vmemmap will 
not be a valid SV39/48 address unless a pfn offset is applied to it. I 
can't think of a possible scenario where vmemmap would be used without 
an offset. I would like to know your opinion on that, does it concern you?

Finally, do you want me to send a patch or will you do it?

Dimitris

On 2/18/2024 10:58 PM, Dimitris Vlachos wrote:
>
>
>
>
> -------- Forwarded Message --------
> Subject: 	Re: [PATCH] [RFC] sparsemem: warn on out-of-bounds 
> initialization
> Date: 	Tue, 6 Feb 2024 22:17:44 +0100
> From: 	Alexandre Ghiti <alexghiti@rivosinc.com>
> To: 	Dimitris Vlachos <csd4492@csd.uoc.gr>
> CC: 	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
> clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org, 
> arnd@arndb.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
> mick@ics.forth.gr
>
>
>
> Hi Dimitris,
>
> On Fri, Feb 2, 2024 at 2:59 PM Alexandre Ghiti 
> <alexghiti@rivosinc.com> wrote:
>> Hi Dimitris,
>>
>> On Fri, Feb 2, 2024 at 2:50 PM Dimitris Vlachos<csd4492@csd.uoc.gr>  wrote:
>>> From: Dimitris Vlachos<dvlachos@ics.forth.gr>
>>>
>>> Hello all
>>>
>>> I am sending this email with regards to a bug that I discovered in the Sparse Memory Model configuration and more specifically, the Virtual Memory Map optimization. Moreover, I would like to inquire about possible ways of fixing it.
>>>
>>> I work as a pre-graduate research assistant at ICS-FORTH in the Computer Architecture and VLSI Systems laboratory.
>>> We were running some tests in our prototype hardware (RISC-V), where we noticed that the Kernel crashes early in the boot process with the following setup:
>>>
>>> We are using the default Kconfig configurations (defconfig) that includes Sparse Memory + Virtual Memory Map.
>>> The DRAM base address of our system is : 0x800000000000
>>> A 3-level page table is used (Sv39).
>>>
>>> When the vmemmap optimization is enabled the macro pfn_to_page() is called, which offsets the vmemmap with the pfn argument to acquire a struct page pointer.
>>>
>>> As our DRAM starts at 0x800000000000, the initial pfn will be 0x800000000000 divided by PAGE_SIZE. The calculation result will be:
>>> 0xffffffcf00000000 (vmemmap start) +  (0x800000000 (pfn) * 64 (sizeof(struct page))
>>>
>>> This causes an overflow as the number is very large, the resulting address is 0x1c700000000 which is not a valid Sv39 address (all bits above bit 38 should be set) and does not belong to the kernel’s virtual address space.
>>>
>>> The same will happen with all valid pfns as the memory is being initialized. When the Kernel will try to access a page using pfn_to_page, a page fault will occur crashing the system.
>>> It should be noted that when the vmemmap is disabled the system boots normally.
>>>
>>> However, I would like to emphasize another important detail. When the DRAM base is small enough to avoid an overflow, the virtual memory map mappings will be initialized out of bounds with regard to the vmemmap address space which is 4GiB in Sv39.
>>> The system will not crash, but the address space used for this purpose will be outside of the designated range.
>>>
>>> Everything mentioned above holds true when Sv48 is used as well. Given a high enough DRAM base the system will either crash or perform false initializations. Given the fact that virtual memory map is not only used by RISC-V systems, this could be an issue for other architectures as well.
>>>
>>> The kernel already contains mminit_validate_memmodel_limits() that checks memory limits.
>>> However, it only checks physical memory ranges. I added a few checks, provided that virtual memory map is enabled, to determine whether offset start and offset end fall inside the range of virtual memory map. Otherwise, a warning will be printed.
>>>
>>> Finally, I would like to ask you for any information/advice that could help me fix/prevent the issues that I mentioned (if it’s possible) or recover from them at runtime by disabling the optimization and reverting back to the non-vmemmap mappings.
>>>
>>> Thank you in advance.
>>> Best regards,
>>> Dimitris Vlachos
>>> ---
>>>   mm/sparse.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index 338cf946d..33b57758e 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -149,6 +149,26 @@ static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>>>                  WARN_ON_ONCE(1);
>>>                  *end_pfn = max_sparsemem_pfn;
>>>          }
>>> +
>>> +       /*check vmemmap limits*/
>>> +       #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>> +
>>> +       unsigned long vmemmap_offset_start = (unsigned long) pfn_to_page(*start_pfn);
>>> +       unsigned long vmemmap_offset_end   = (unsigned long) pfn_to_page(*end_pfn);
>>> +
>>> +       if (vmemmap_offset_start < VMEMMAP_START) {
>>> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
>>> +                       "Start of range %lu -> %lu exceeds bounds of SPARSEMEM virtual memory map address range %lu -> %lu\n",
>>> +                       vmemmap_offset_start, vmemmap_offset_end, VMEMMAP_START,VMEMMAP_END);
>>> +               WARN_ON_ONCE(1);
>>> +
>>> +       } else if (vmemmap_offset_end > VMEMMAP_END ) {
>>> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
>>> +                       "End of range %lu -> %lu exceeds bounds of SPARSEMEM virtual memory map address range %lu -> %lu\n",
>>> +                       vmemmap_offset_start, vmemmap_offset_end, VMEMMAP_START,VMEMMAP_END);
>>> +               WARN_ON_ONCE(1);
>>> +       }
>>> +       #endif
>>>   }
>>>
>>>   /*
>>> --
>>> 2.39.2
>>>
>>
>> Since struct pages are only available for memory,  we could offset
>> vmemmap so that VMEMMAP_START actually points to the first pfn?
>
>> Hello Alexandre,
>> My first thought was to use a "better" offset for vmemmap as well.Since pfn is essential for pfn_to_page and page_to_pfn i think that maybe we could get a smaller number out of pfn to offset the vmemmap and ensure that it's  bounds are respected for pfn_to_page operation.
>> If we use only a part of the pfn for the offset we could get the  pfn from page_to_pfn by adding PAGE-VMEMMAP_START
>> to the DRAM base/PAGE_SIZE which is the first pfn.
>
> Let's keep the discussion here.
>
> IIUC you propose to change pfn_to_page()/page_to_pfn() but what I
> proposed was to directly offset vmemmap like this:
>
> #define vmemmap ((struct page *)VMEMMAP_START - phys_ram_base
>>> PAGE_SHIFT)
>
> So that the first page in vmemmap corresponds to the first page of
> physical memory, that avoids the burden of changing the conversion
> macros, WDYT?
>
> Thanks,
>
> Alex

