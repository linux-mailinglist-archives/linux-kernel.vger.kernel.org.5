Return-Path: <linux-kernel+bounces-86424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3186C52D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23731C239D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CB95CDE5;
	Thu, 29 Feb 2024 09:29:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46C5B698
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198993; cv=none; b=cPFKw393IpCOAH3WyIFnZCWFkUn2YvBLn2B3WGBdaCTOwLCPhOMxbBRW5twHC/0+V+6jHWq0/Zd3LrqV5ZA8VciPWKB4Wz/4aHfW+SVXeA5M44a3q8ryewYiCgXN3Sz0ziXfmSodR5HGdx9Cce8n1QYdeUHDMeceE0NYXZHaEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198993; c=relaxed/simple;
	bh=/OH3YPYtC647ehj04e0so/bjPUXbp25AoYAGQn5WjcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWytCgqCYza44vl06pAyEnZDbpi9ugyG2bJ41g3oSrXtrl4nJqbPtOw3zSQ0C0F2hyFOcz7K3JNbnqxxNgnxckE/P+hXAbSnOBWerocgCweEyaqzTyuy33JcVBEgovV87lHQ+jG+EMzCYDAqPbC7bL0+3wyqqdRRTr3iGgUXxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24b017bdb2e34ae8b18dac649537834a-20240229
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:080b2373-30c8-484d-a9e2-158fffc50fff,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:080b2373-30c8-484d-a9e2-158fffc50fff,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:8dbe57ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240229172943HMO26OBX,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|64|6
	6|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 24b017bdb2e34ae8b18dac649537834a-20240229
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 619597757; Thu, 29 Feb 2024 17:29:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 66BB4E000EBC;
	Thu, 29 Feb 2024 17:29:41 +0800 (CST)
X-ns-mid: postfix-65E04E85-347519924
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 40885E000EBC;
	Thu, 29 Feb 2024 17:28:54 +0800 (CST)
Message-ID: <d0ac1160-13ae-4753-a4c8-4d78056e923e@kylinos.cn>
Date: Thu, 29 Feb 2024 17:28:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240125092624.537564-1-chentao@kylinos.cn>
 <87h6hva4b0.fsf@mail.lhotse>
 <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
 <87jzmq5tjr.fsf@mail.lhotse> <87bk80kjup.fsf@kernel.org>
 <87wmqng5dz.fsf@mail.lhotse>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <87wmqng5dz.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks all for the reply.
On 2024/2/29 14:18, Michael Ellerman wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Kunwu Chan <chentao@kylinos.cn> writes:
>>>> On 2024/2/26 18:49, Michael Ellerman wrote:
>>>>> Kunwu Chan <chentao@kylinos.cn> writes:
>>>>>> This part was commented from commit 6d492ecc6489
>>>>>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>>>>>> in about 11 years before.
>>>>>>
>>>>>> If there are no plans to enable this part code in the future,
>>>>>> we can remove this dead code.
>>>>>
>>>>> I agree the code can go. But I'd like it to be replaced with a comment
>>>>> explaining what the dead code was trying to say.
>>>
>>>> Thanks, i'll update a new patch with the following comment:
>>>>       /*
>>>>       * No CPU has hugepages but lacks no execute, so we
>>>>       * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
>>>>       */
>>>
>>> Maybe wait until we can get some input from Aneesh. I'm not sure the
>>> code/comment are really up to date.
>>
>> How about?
>>
>> modified   arch/powerpc/mm/book3s64/hash_hugepage.c
>> @@ -58,17 +58,13 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>>   		return 0;
>>   
>>   	rflags = htab_convert_pte_flags(new_pmd, flags);
>> +	/*
>> +	 * THPs are only supported on platforms that can do mixed page size
>> +	 * segments (MPSS) and all such platforms have coherent icache. Hence we
>> +	 * don't need to do lazy icache flush (hash_page_do_lazy_icache()) on
>> +	 * noexecute fault.
>> +	 */
> 
I'll use this comment in v2 patch.
And add two Suggested-by: label for you.

> Yeah thanks that looks good.
> 
> It could say "see eg. __hash_page_4K()", but that's probably unnecessary
> as it mentions hash_page_do_lazy_icache(), and anyone interested is just
> going to grep for that anyway.
> 
> cheers
-- 
Thanks,
   Kunwu


