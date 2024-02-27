Return-Path: <linux-kernel+bounces-82964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6C868C53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E611F27D82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC96135A75;
	Tue, 27 Feb 2024 09:33:02 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257E136679
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026382; cv=none; b=MswD1JXUI11EONZ62+9xMAFL1mmZ4x7yndSlMlzzbOv+7x21Z23YNm0p97Hx6NOqfsQVEmpB8FHby4/b2eL+TWlMJ81DqfHhdaqkq2I1DAI2W15wTgGlCjF2HFX1Kd6I0dTcS2kMHcmvLnkGr2ugKlSgdMS5qvjOybnBq9SMpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026382; c=relaxed/simple;
	bh=2h0nx1cF+DwxLkNt5bJX8BNPfGrW589/B4rzt8Hzcsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzX4r8BuzqwuttETglQ8vYl7gXyVYPNz3/qZSwPxfQl/qVoWTvtA5XdraHvqkQ/d+YMe4tA3NRMVAFfo5z4V5x+JBqb/liSnCfM9+8yJ/edSxqnqDNifIcpAMqPajyfGpXLOlcCTbCKvhT/XLgVqKcY3xwhNVuAMe3AR4sAaCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04dd6100f9db49eca84d0368d5430b66-20240227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:18887999-32c5-4984-a351-bdc40445c46d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:18887999-32c5-4984-a351-bdc40445c46d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:d9a243ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240227111434QEHVDYUI,BulkQuantity:10,Recheck:0,SF:19|44|64|66|38|24|
	17|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,
	TF_CID_SPAM_SNR
X-UUID: 04dd6100f9db49eca84d0368d5430b66-20240227
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 357849804; Tue, 27 Feb 2024 17:32:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3BA63E000EBC;
	Tue, 27 Feb 2024 17:32:51 +0800 (CST)
X-ns-mid: postfix-65DDAC43-1699361025
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 78E8EE000EBC;
	Tue, 27 Feb 2024 17:32:47 +0800 (CST)
Message-ID: <407d25db-6302-49bb-952b-c53739fc4202@kylinos.cn>
Date: Tue, 27 Feb 2024 17:32:47 +0800
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
 <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
 <87jzmq5tjr.fsf@mail.lhotse>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <87jzmq5tjr.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the reply.
On 2024/2/27 14:07, Michael Ellerman wrote:
> Kunwu Chan <chentao@kylinos.cn> writes:
>> Thanks for the reply.
>>
>> On 2024/2/26 18:49, Michael Ellerman wrote:
>>> Kunwu Chan <chentao@kylinos.cn> writes:
>>>> This part was commented from commit 6d492ecc6489
>>>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>>>> in about 11 years before.
>>>>
>>>> If there are no plans to enable this part code in the future,
>>>> we can remove this dead code.
>>>
>>> I agree the code can go. But I'd like it to be replaced with a comment
>>> explaining what the dead code was trying to say.
> 
>> Thanks, i'll update a new patch with the following comment:
>>       /*
>>       * No CPU has hugepages but lacks no execute, so we
>>       * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
>>       */
> 
> Maybe wait until we can get some input from Aneesh. I'm not sure the
> code/comment are really up to date.
I won't do anything until I get a reply.
I'll wait for the latest msg.

> 
> cheers
-- 
Thanks,
   Kunwu


