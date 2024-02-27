Return-Path: <linux-kernel+bounces-82645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938886879D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD36FB21D85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2C1D524;
	Tue, 27 Feb 2024 03:14:50 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14491B949
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003690; cv=none; b=ZS6MsQXrUAlfq576RS7wD889XIxhWpE87E21FG2Ds4lVkfoED977LYsD9DlTJK0pOzhvipsJzH2H7hcHdyVMRpoVf/50LgJCCMkp594mqNFIQNLOdydhSZe+j4kgswCeagNZ6mf9wpX76OHZBvNRry1zTGxNYsInhw1ouoRRLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003690; c=relaxed/simple;
	bh=ah7zT0BOsyf1Fi3ykpA0V0G/4GdGmpeo3mumkB+XpYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1EIaYStRbdS48wp+1ot5cqv/MOlNEdywLxJezrRhHgGY5FzXNxRDazEIKFa3MAiCFShAi8MVzg4+fRfl5KnYBh+CvrKM27htixtO7xvnaX1weaHA4g3ElhI8Ns+50vkwVxdQYS4DsAJYKi8mWqBGIInik+94eaSAi3vEuKh5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8ede15c63dc4319b205f5b6728f9dcf-20240227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c3c17bce-c308-4406-879d-1df336acef54,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:c3c17bce-c308-4406-879d-1df336acef54,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:8a4cda80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240227111434QEHVDYUI,BulkQuantity:0,Recheck:0,SF:24|17|19|44|64|66|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: c8ede15c63dc4319b205f5b6728f9dcf-20240227
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1125639519; Tue, 27 Feb 2024 11:14:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4A023E000EBC;
	Tue, 27 Feb 2024 11:14:32 +0800 (CST)
X-ns-mid: postfix-65DD5398-216374431
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id E330FE000EBC;
	Tue, 27 Feb 2024 11:14:28 +0800 (CST)
Message-ID: <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
Date: Tue, 27 Feb 2024 11:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
Content-Language: en-US
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240125092624.537564-1-chentao@kylinos.cn>
 <87h6hva4b0.fsf@mail.lhotse>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <87h6hva4b0.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the reply.

On 2024/2/26 18:49, Michael Ellerman wrote:
> Kunwu Chan <chentao@kylinos.cn> writes:
>> This part was commented from commit 6d492ecc6489
>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>> in about 11 years before.
>>
>> If there are no plans to enable this part code in the future,
>> we can remove this dead code.
> 
> I agree the code can go. But I'd like it to be replaced with a comment
> explaining what the dead code was trying to say.
Thanks, i'll update a new patch with the following comment:
     /*
     * No CPU has hugepages but lacks no execute, so we
     * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
     */

> 
> cheers
> 
>> diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/book3s64/hash_hugepage.c
>> index c0fabe6c5a12..127a3a2c174b 100644
>> --- a/arch/powerpc/mm/book3s64/hash_hugepage.c
>> +++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
>> @@ -59,16 +59,6 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>>   
>>   	rflags = htab_convert_pte_flags(new_pmd, flags);
>>   
>> -#if 0
>> -	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
>> -
>> -		/*
>> -		 * No CPU has hugepages but lacks no execute, so we
>> -		 * don't need to worry about that case
>> -		 */
>> -		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
>> -	}
>> -#endif
>>   	/*
>>   	 * Find the slot index details for this ea, using base page size.
>>   	 */
>> -- 
>> 2.39.2
-- 
Thanks,
   Kunwu


