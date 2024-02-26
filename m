Return-Path: <linux-kernel+bounces-81431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0AE8675E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F1D1C21A66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61085271;
	Mon, 26 Feb 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rk4ywl2T"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E280053;
	Mon, 26 Feb 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952347; cv=none; b=kIEOAhoZmd+HhqeDHuwlNgd1VQY7srfHqbia8lWbrIFnKqZ5ebSBnCZi3yGNj1POCvFaLNATl08qF7nqxXdTvlbUF8RTTeWZswu6hXf5lUb5wEhKE1uyQlc+4KK1mTgM6G10RlbcmDsJzY1dT5GY6VWwQ/NnECOyVu08kCxEY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952347; c=relaxed/simple;
	bh=CivS165SpOZxqTRi7Y0BERi3bxixI6EZFS1RildTF20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS3gQ5idw8AYMDTu3DwxuJOYYapuPLLIXQG6wa4GjA3CCWNrEaWKIrj1iV/VE5AV9xzvO7pPH6ChDMac/tIPd8yO2GlXK99w4i1XykwxulD5j6kJXFEOMW8Zy98KV47cl60yMoynX2P5FW+H80iIDzhRPMhUMtanQwwCqDhq/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rk4ywl2T; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708952342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cD5eT8WkRRrjceQq/anwpIvtg55UdVcwbYHTzVSwFEg=;
	b=rk4ywl2TJMeiUIy+03NU8clSRH/3GSgj3Kh2QEyogVEQMbhgmadBoiwhXV+cbgp06BqZ3l5RaI9YLlSeutbVYBOVgh/i1YEbkZ4HupKbxVv25e3+1/mi1lX9HrLfC4QmYxhWLGeLGhYdzjl4uz/YrPS69t76hbPixnpt2ntC3J0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W1JpswJ_1708952340;
Received: from 30.221.129.59(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W1JpswJ_1708952340)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 20:59:01 +0800
Message-ID: <253e7be2-5f31-45a6-9dce-b8080d2d2ebd@linux.alibaba.com>
Date: Mon, 26 Feb 2024 20:58:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/15] net/smc: introduce loopback-ism statistics
 attributes
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-10-guwen@linux.alibaba.com>
 <417a1b7c-4136-4f96-a614-9fd976dc884d@linux.ibm.com>
 <cac6192e-85d8-4289-b5af-bc8143e76004@linux.alibaba.com>
 <700198c8-e4dc-4974-9ebf-f819deaa785b@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <700198c8-e4dc-4974-9ebf-f819deaa785b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/23 22:13, Wenjia Zhang wrote:
> 
> 
> On 20.02.24 03:45, Wen Gu wrote:
>>
>>
>> On 2024/2/16 22:24, Wenjia Zhang wrote:
>>>
>>>
>>> On 11.01.24 13:00, Wen Gu wrote:
>>>> This introduces some statistics attributes of loopback-ism. They can be
>>>> read from /sys/devices/virtual/smc/loopback-ism/{xfer_tytes|dmbs_cnt}.
>>>>
>>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>>> ---
>>>>   net/smc/smc_loopback.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>>>>   net/smc/smc_loopback.h | 22 +++++++++++++
>>>>   2 files changed, 96 insertions(+)
>>>>
>>>
>>> I've read the comments from Jiri and your answer. I can understand your thought. However, from the perspective of the 
>>> end user, it makes more sense to integetrate the stats info into 'smcd stats'. Otherwise, it would make users 
>>> confused to find out with which tool to check which statisic infornation. Sure, some improvement of the smc-tools is 
>>> also needed
>>
>> Thank you Wenjia.
>>
>> Let's draw an analogy with RDMA devices, which is used in SMC-R. If we want
>> to check the RNIC status or statistics, we may use rdma statistic command, or
>> ibv_devinfo command, or check file under /sys/class/infiniband/mlx5_0. These
>> provide details or attributes related to *devices*.
>>
>> Since s390 ISM can be used out of SMC, I guess it also has its own way (other
>> than smc-tools) to check the statistic?
>>
>> What we can see in smcr stats or smcd stats command is about statistic or
>> status of SMC *protocol* layer, such as DMB status, Tx/Rx, connections, fallbacks.
>>
>> If we put the underlying devices's statistics into smc-tools, should we also
>> put RNIC statistics or s390 ISM statistics into smcr stat or smcd stat? and
>> for each futures device that can be used by SMC-R/SMC-D, should we update them
>> into smcr stat and smcd stat? And the attributes of each devices may be different,
>> should we add entries in smcd stat for each of them?
>>
>> After considering the above things, I believe that the details of the underlying
>> device should not be exposed to smc(smc-tools). What do you think?
>>
>> Thanks!
>>
> That is a very good point. It really depends on how we understand *devices* and how we want to use it. The more we are 
> thinking, the more complicated the thing is getting. I'm trying to find accurate definitions on modeling virtual devices 
> hoping that would make things eaiser. Unfortunately, it is not easy. Finally, I found this article: 
> https://lwn.net/Articles/645810/ (Heads up! It is even from nine years ago, I'm not sure how reliable it is.) With the 
> insight of this article, I'm trying to summarize my thought:
> 
> It looks good to put the loopback-ism under the /sys/devices/virtual, especially according to the article
> "
> ... it is simply a place to put things that don't belong anywhere else.
> "

Yes, it can also be reflected from the implementation of get_device_parent():

static struct kobject *get_device_parent(struct device *dev,
					 struct device *parent)
{
<...>
		/*
		 * If we have no parent, we live in "virtual".
		 * Class-devices with a non class-device as parent, live
		 * in a "glue" directory to prevent namespace collisions.
		 */
		if (parent == NULL)
			parent_kobj = virtual_device_parent(dev);
		else if (parent->class && !dev->class->ns_type) {
			subsys_put(sp);
			return &parent->kobj;
		} else {
			parent_kobj = &parent->kobj;
		}
<...>
}

> However, in practice we use this in the term of simulated ism, which includes not only loopback-ism, but also other 
> ones. Thus, does it not make sense to classify all of them together? E.g. same bus (just a half-baked idea)
> 
> Then the following questions are comig up:
> - How should we organize them?
> - Should it show up in the smc_rnics?
> - How should it be seen from the perspective of the container?
> - If we see this loopback-ism as a *device*, should we not only put the device related information under the /sys? Thus, 
> dmbs_cnt seems ok, but xfer_tytes not. Besides, we have a field in smd stat naming "Data transmitted (Bytes)", which 
> should be suitable for this information.

Actually I created 'smc' class under /sys/devices/virtual just to place
loopback-ism, since it doesn't seem to belong to a certain class of device
and serves only SMC. Other 'smc devices', e.g. RDMA device, s390 ISM and
other Emulated-ISM like virtio-ism, all belong to a certain class or bus,
so I have no intention of putting them under the same path.

But now looks like that the 'smc' class and /sys/devices/virtual/smc path
will lead people to mistakenly think that there is a class of 'SMC devices',
but in fact these 'SMC devices' belongs to different classes or buses. They
can be used by SMC and any other users. So I think it is better to avoid
creating such 'smc' class.

Alternatively, after referring to other examples in the kernel, I think
another choice is to to put loopback-ism under /sys/devices/virtual/misc/,
for devices which can't fit in a specific class. What do you think?

Thanks a lot!

