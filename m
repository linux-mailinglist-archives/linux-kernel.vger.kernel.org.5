Return-Path: <linux-kernel+bounces-39518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B903883D243
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0311F28F09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5B17E9;
	Fri, 26 Jan 2024 01:51:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679D79C1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233902; cv=none; b=O4EIf1WQL4tTp/krdqr8tIH+7lconMd/WDUl+KliOqZiggpjm3z3UQFilKP4lY5M+XnAWKLoJYHcgSyF5jVzUOvI0A/gUy4AXpztqhX9Y6oxYY6zxhDXfkhkQO+R2Z1WxrJZGkWt0INYV304VGkvXEthkh5lXivSb2mCsAL0UZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233902; c=relaxed/simple;
	bh=Y4osc/ruCnhjCW5uJHM9uYUe2NSVUbIsuaySsQwMffU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc/gUqiZ+BsTy0bCgrAGqazAAfihDN//hOD/DbQYssW1cOThKCbiOQh+JVfJuHNFxaNo9hllYV9D9vEPjESF9pKc6iaKGdusQex83eQs3CP2hw5tmpI7KX9zRW3MPLXkYSHaLc1EwK6RGzRHx60HHo26F/yYuO1w7cUxF/vz5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a7b8463e0a645f28ededf1d58389596-20240126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:59037ac4-36cb-470d-b716-35c6b8b38542,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:59037ac4-36cb-470d-b716-35c6b8b38542,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:96a14483-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240125214804HZSUUVB8,BulkQuantity:5,Recheck:0,SF:38|24|17|19|44|64|6
	6|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6a7b8463e0a645f28ededf1d58389596-20240126
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 446807232; Fri, 26 Jan 2024 09:51:23 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3F65EE000EB9;
	Fri, 26 Jan 2024 09:51:23 +0800 (CST)
X-ns-mid: postfix-65B3101B-180436399
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id E878EE000EB9;
	Fri, 26 Jan 2024 09:51:15 +0800 (CST)
Message-ID: <e27dfc1a-ec0a-4b04-b7dd-9e664595ef8d@kylinos.cn>
Date: Fri, 26 Jan 2024 09:51:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm/hash: Code cleanup
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240125094636.539372-1-chentao@kylinos.cn>
 <e017718b-d385-41de-9139-0265cf3e6149@kernel.org>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <e017718b-d385-41de-9139-0265cf3e6149@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/25 21:47, Aneesh Kumar K.V wrote:
> On 1/25/24 3:16 PM, Kunwu Chan wrote:
>> This part was commented in about 17 years before.
>> If there are no plans to enable this part code in the future,
>> we can remove this dead code.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu-hash.h | 22 -------------------
>>   1 file changed, 22 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> index 1c4eebbc69c9..d39ec7134a78 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -731,26 +731,6 @@ struct hash_mm_context {
>>   #endif /* CONFIG_PPC_SUBPAGE_PROT */
>>   };
>>   
>> -#if 0
>> -/*
>> - * The code below is equivalent to this function for arguments
>> - * < 2^VSID_BITS, which is all this should ever be called
>> - * with.  However gcc is not clever enough to compute the
>> - * modulus (2^n-1) without a second multiply.
>> - */
>> -#define vsid_scramble(protovsid, size) \
>> -	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
>> -
>> -/* simplified form avoiding mod operation */
>> -#define vsid_scramble(protovsid, size) \
>> -	({								 \
>> -		unsigned long x;					 \
>> -		x = (protovsid) * VSID_MULTIPLIER_##size;		 \
>> -		x = (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
>> -		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
>> -	})
>> -
>> -#else /* 1 */
>>   static inline unsigned long vsid_scramble(unsigned long protovsid,
>>   				  unsigned long vsid_multiplier, int vsid_bits)
>>   {
>> @@ -764,8 +744,6 @@ static inline unsigned long vsid_scramble(unsigned long protovsid,
>>   	return (vsid + ((vsid + 1) >> vsid_bits)) & vsid_modulus;
>>   }
>>   
>> -#endif /* 1 */
>> -
>>   /* Returns the segment size indicator for a user address */
>>   static inline int user_segment_size(unsigned long addr)
>>   {
> 
> That was done to make sure one can follow the actual compiled code better.
Thanks for your explanation. It's my bad.
> 
> -aneesh
> 
-- 
Thanks,
   Kunwu


