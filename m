Return-Path: <linux-kernel+bounces-72275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F385B184
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB58B217F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65051009;
	Tue, 20 Feb 2024 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lvw5rR0n"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74A481B3;
	Tue, 20 Feb 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400193; cv=none; b=O1FGLSjZBG/Eddq2YUfRT7SZ8dYxW3MpfoOejz0DTFhw58yREymPjp/4S1YIakM8LO9pw1I7A7QMQVxjAEGHyf0wU23Xpt70twjoiz8lAWfjQG0G1Gw14OZWfH481lSoUY0fKYRS+Chr32gghFzOgvJg3adEw3UbeGXFPC8XFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400193; c=relaxed/simple;
	bh=aShSRLt3GevXA1Qx62ev9VFaOPlhkE/c4BBllw9Klyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frhOjJLnGhZfE63jOzgnu1tx7LxvJ1NoTi4EDRGq7c+1lT+pWgASbxkVmYXe7SnPr1V1j96fWral5Ljsg90zcbCCgjAmeb05PiqhK2U64b8yvarRz/rPuY/21TTKjFYv41smVwiAuDwPVTAPxkA1nLkXAVijAVhbXRPpo+UgTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lvw5rR0n; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708400182; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R/VW+J0LluQWcqmcYIaT+iX59/8UWwxw0zPEseH7/1A=;
	b=lvw5rR0nMV6BCpc2t3XXBrlKqbWk+WjYzGO2FrdY4o1GAN44lcWIpGTT1NVtKLEpNydcGcC12t/2W37HCH3MeSI0yUdN/YRaTQW54k8jWppOuiuIasdliJkmnE4z6xGDmLhpNnfxi+iJMo4+p80tugyDHW0sfaz3fPrFhbARNhk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W0v7u33_1708400180;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0v7u33_1708400180)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 11:36:21 +0800
Message-ID: <58f36cb7-7427-4ed7-9a8e-baaacdd774cb@linux.alibaba.com>
Date: Tue, 20 Feb 2024 11:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] net/smc: introduce loopback-ism DMB data
 copy control
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-15-guwen@linux.alibaba.com>
 <b3b71f26-239f-49c9-98e8-7eba2c4ecf69@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <b3b71f26-239f-49c9-98e8-7eba2c4ecf69@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/16 22:25, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This provides a way to {get|set} whether loopback-ism device supports
>> merging sndbuf with peer DMB to eliminate data copies between them.
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # support
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # not support
>>
> Besides the same confusing as Niklas already mentioned, the name of the option looks not clear enough to what it means. 
> What about:
> echo 1 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # merge mode
> echo 0 > /sys/devices/virtual/smc/loopback-ism/nocopy_support # copy mode
>

OK, if we decide to keep the knobs, I will improve the name. Thanks!

>> The settings take effect after re-activating loopback-ism by:
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
>>
>> After this, the link group related to loopback-ism will be flushed and
>> the sndbufs of subsequent connections will be merged or not merged with
>> peer DMB.
>>
>> The motivation of this control is that the bandwidth will be highly
>> improved when sndbuf and DMB are merged, but when virtually contiguous
>> DMB is provided and merged with sndbuf, it will be concurrently accessed
>> on Tx and Rx, then there will be a bottleneck caused by lock contention
>> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
>> is set (see link below). So an option is provided.
>>
>> Link: https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> We tried some simple workloads, and the performance of the no-copy case was remarkable. Thus, we're wondering if it is 
> necessary to have the tunable setting in this loopback case? Or rather, why do we need the copy option? Is that because 
> of the bottleneck caused by using the combination of the no-copy and virtually contiguours DMA? Or at least let no-copy 
> as the default one.

Yes, it is because the bottleneck caused by using the combination of the no-copy
and virtual-DMB. If we have to use virtual-DMB and CONFIG_HARDENED_USERCOPY is
set, then we may be forced to use copy mode in many CPUs environment, to get the
good latency performance (the bandwidth performance still drop because of copy mode).

But if we agree that physical-DMB is acceptable (it costs 1 physical buffer per conn side
in loopback-ism no-copy mode, same as what sndbuf costs when using s390 ISM), then
there is no such performance issue and the two knobs can be removed. (see also the reply
for 13/15 patch [1]).

[1] https://lore.kernel.org/netdev/442061eb-107a-421d-bc2e-13c8defb0f7b@linux.alibaba.com/

Thanks!

