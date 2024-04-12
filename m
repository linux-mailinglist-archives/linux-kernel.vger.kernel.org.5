Return-Path: <linux-kernel+bounces-141797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA318A238C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92384B21897
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDFCD527;
	Fri, 12 Apr 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SToS/+cW"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B9523A;
	Fri, 12 Apr 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887366; cv=none; b=i3QnFML6UTopmxa92Ypxz9LeVTBvKHPi2HRUAkBe2e65bB0wzT5D0rS1cY2Xx0EfpG0oq9xDfGZctLUjZB9puZTM+z3T/BwLshggynmSSyk1RE8wt8r+FcU+5i7BPDGOtZV5dPKySPzrQNRMdUVDzTmrfA6AAmHH96RFN6b539o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887366; c=relaxed/simple;
	bh=+EZtMTU/ARwhQkmhBZM/lagfNPeu0TVZRPivRQMHV8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OicV7cyhoIoYvmBl6V5whNwuGya5Cgro69H/you89MgGArljo+SJACfluXTWc1XQ100Twww8c2t8cqldWV1CqJ7ngCx+N8Am2Nx3VuQNIA03F4y9cXx1f5bI5GRR/gAKLBcWolcbviHcxA4qPsx6s+rmXFyV9JdKu9zoWoWKLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SToS/+cW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712887360; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VKbsRDbyF9GBLUuAIXQgOv40gno2BZ2XnQ4Pd7U2cmA=;
	b=SToS/+cWNzr3GLsIw1Xqhr4XHHC+CzL6VhJbZKCNTBITfRvSH8F88zBTsdhvgtLyECQdH1yQucLuPVX+74hr3jh/60JYJQmYrpEFyG3e8X1UH8ahy2djfhb7o9mHMobKQifANp8g7hiV6R4c4XejoNgsPITsmgC6d9Fuf8Nt9IM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W4Mc7Bm_1712887358;
Received: from 30.221.129.174(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4Mc7Bm_1712887358)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:02:39 +0800
Message-ID: <44ea7d83-4fa7-427b-9d54-678f05fd09e9@linux.alibaba.com>
Date: Fri, 12 Apr 2024 10:02:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Alexandra Winter <wintera@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-5-guwen@linux.alibaba.com>
 <3122eece5b484abcf8d23f85d6c18c36f0b939ff.camel@linux.ibm.com>
 <1db6ccab-b49f-45d2-a93c-05b0f79371a3@linux.alibaba.com>
 <3b3ff37643e9030ec1246e67720683a2cf5660e5.camel@linux.ibm.com>
 <7a0fc481-658e-4c99-add7-ccbd5f9dce1e@linux.alibaba.com>
 <7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com>
 <46e8e227-8058-4062-a9db-6b9c774f63cc@linux.alibaba.com>
 <12ae995f-4af4-4c6b-9130-04672d157293@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <12ae995f-4af4-4c6b-9130-04672d157293@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/11 19:12, Alexandra Winter wrote:
> 
> 
> On 09.04.24 03:44, Wen Gu wrote:
>>
>>
>> On 2024/4/4 23:15, Niklas Schnelle wrote:
>>> On Thu, 2024-04-04 at 21:12 +0800, Wen Gu wrote:
>>>>
>>>> On 2024/4/4 19:42, Niklas Schnelle wrote:
>>>>> On Thu, 2024-04-04 at 17:32 +0800, Wen Gu wrote:
>>>>>>
>>>>>> On 2024/4/4 00:25, Gerd Bayer wrote:
>>>>>>> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>>>>>>>> This implements some operations that loopback-ism does not support
>>>>>>>> currently:
>>>>>>>>      - vlan operations, since there is no strong use-case for it.
>>>>>>>>      - signal_event operations, since there is no event to be processed
>>>>>>>> by the loopback-ism device.
>>>>>>>
>>>>>>> Hi Wen,
>>>>>>>
>>>>>>> I wonder if the these operations that are not supported by loopback-ism
>>>>>>> should rather be marked "optional" in the struct smcd_ops, and the
>>>>>>> calling code should call these only when they are implemented.
>>>>>>>
>>>>>>> Of course this would mean more changes to net/smc/smc_core.c - but
>>>>>>> loopback-ism could omit these "boiler-plate" functions.
>>>>>>>
>>>>>>
>>>>>> Hi Gerd.
>>>>>>
>>>>>> Thank you for the thoughts! I agree that checks like 'if(smcd->ops->xxx)'
>>>>>> can avoid the device driver from implementing unsupported operations. But I
>>>>>> am afraid that which operations need to be defined as 'optional' may differ
>>>>>> from different device perspectives (e.g. for loopback-ism they are vlan-related
>>>>>> opts and signal_event). So I perfer to simply let the smc protocol assume
>>>>>> that all operations have been implemented, and let drivers to decide which
>>>>>> ones are unsupported in implementation. What do you think?
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>
>>>>> I agree with Gerd, in my opinion it is better to document ops as
>>>>> optional and then allow their function pointers to be NULL and check
>>>>> for that. Acting like they are supported and then they turn out to be
>>>>> nops to me seems to contradict the principle of least surprises. I also
>>>>> think we can find a subset of mandatory ops without which SMC-D is
>>>>> impossible and then everything else should be optional.
>>>>
>>>> I see. If we all agree to classify smcd_ops into mandatory and optional ones,
>>>> I'll add a patch to mark the optional ops and check if they are implemented.
>>>
>>> Keep in mind I don't speak for the SMC maintainers but that does sound
>>> reasonable to me.
>>>
>>
>> Hi Wenjia and Jan, do you have any comments on this and [1]? Thanks!
>>
>> [1] https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/
>>
>>>>
>>>>>
>>>>> As a first guess I think the following options may be mandatory:
>>>>>
>>>>> * query_remote_gid()
>>>>> * register_dmb()/unregister_dmb()
>>>>> * move_data()
>>>>>      For this one could argue that either move_data() or
>>>>>      attach_dmb()/detach_dmb() is required though personally I would
>>>>>      prefer to always have move_data() as a fallback and simple API
>>>>> * supports_v2()
>>>>> * get_local_gid()
>>>>> * get_chid()
>>>>> * get_dev()
>>>> I agree with this classification. Just one point, maybe we can take
>>>> supports_v2() as an optional ops, like support_dmb_nocopy()? e.g. if
>>>> it is not implemented, we treat it as an ISMv1.
>>>>
>>>> Thanks!
>>>
>>> Interpreting a NULL supports_v2() as not supporting v2 sounds
>>> reasonable to me.
>>
> 
> Let me add my thoughts to the discussion:
> For the vlan operations and signal_event operations that loopback-ism does
> not support:
> I like the idea to set the ops to NULL and make sure the caller checks that
> and can live with it. That is readable and efficient.
> 
> I don't think there is a need to discuss a strategy now, which ops could be
> optional in the future. This is all inside the kernel. loopback-ism is even
> inside the smc module. Such comments in the code get outdated very easily.
> 
> I would propose to mark those as optional struct smcd_ops, where all callers can
> handle a NULL pointer and still be productive.
> Future support of other devices for SMC-D can update that.
> 
> 

Hi Sandy, just to confirm if I understand you correctly.

You are proposing that don't draw a conclusion about the classification now,
but supplementally mark which one become a optional operation in struct smcd_ops
during the introduction of new devices for SMC-D.

