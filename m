Return-Path: <linux-kernel+bounces-72257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F1085B13A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FA6B233F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85BD4597A;
	Tue, 20 Feb 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p3/QCOep"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128951C2C;
	Tue, 20 Feb 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399196; cv=none; b=ink1I0h2x7AIVR1hzfQsSnvw3gNpvggeaBKfv3SGC6YjRMKLUr2NqJZAlXtP7PNGK5+mC2F02bw/cK71/U3aQwkc5FFOVoleFUhSro2MnKO9qMpt+8Kz/RkrwJKMRL+xnPy8KoOOUrFkfNyNEm1VeOTOmKGomEKou3df91zbt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399196; c=relaxed/simple;
	bh=trry4QTxdMtEqrS6zmYMXjvclDjxf7/p5OQ5P5jueNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll6TGBKXZS40aJ2gP2rlZpobKcjdnaAqfRA3Z6vGISFa+5Na4R2TyvkK2lP44R9W/1ihU2AtCOOuTK2CpDJ1rwZ/VEx4B5vACgr5/Cs8L3ITxeWLuWfSDo+X5S8rgJhx0HGxT63ilfG08lyrgI93ac5BbuhVgfVgwmMHV8XCKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p3/QCOep; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708399190; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vm9DUpMOnO65MkiOu9sTrxR8ynvGT3k7f5D5XqK7Uko=;
	b=p3/QCOepmb/S2eHI1wVAv6q0gwSsITnDgaaxWMA2teEa1LySeaNO+s8aiXwdyirJi5j/C5aX8kzn9dxj5AoPWMjQ3f7i2mwLWpqBAvf04Jsh3qm8g34MvCZmQaaKx4FJBcHNiLuoUCTSJL15IPZrZtoXmzgPQpQVVyalIaKhSNU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W0vE3Uz_1708399188;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0vE3Uz_1708399188)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 11:19:49 +0800
Message-ID: <442061eb-107a-421d-bc2e-13c8defb0f7b@linux.alibaba.com>
Date: Tue, 20 Feb 2024 11:19:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/15] net/smc: introduce loopback-ism DMB type
 control
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-14-guwen@linux.alibaba.com>
 <350f1cb8-b205-47be-a296-c610b9afe5fc@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <350f1cb8-b205-47be-a296-c610b9afe5fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/16 22:25, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This provides a way to {get|set} type of DMB offered by loopback-ism,
>> whether it is physically or virtually contiguous memory.
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_type # physically
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_type # virtually
>>
>> The settings take effect after re-activating loopback-ism by:
>>
>> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
>> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
>>
>> After this, the link group and DMBs related to loopback-ism will be
>> flushed and subsequent DMBs created will be of the desired type.
>>
>> The motivation of this control is that physically contiguous DMB has
>> best performance but is usually expensive, while the virtually
>> contiguous DMB is cheap and perform well in most scenarios, but if
>> sndbuf and DMB are merged, virtual DMB will be accessed concurrently
>> in Tx and Rx and there will be a bottleneck caused by lock contention
>> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
>> is set (see link below). So an option is provided.
>>
> I'm courious about why you say that physically contiguous DMB has best performance. Because we saw even a bit better 
> perfomance with the virtual one than the performance with the physical one.

Hi Wenjia, you can find examples from here:

https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/

Excerpted from above:
"
In 48 CPUs qemu environment, the Requests/s increased by 5 times:
- nginx
- wrk -c 1000 -t 96 -d 30 http://127.0.0.1:80

                  vzalloced shmem      vzalloced shmem(with this patch set)
Requests/sec          113536.56            583729.93


But it also has some overhead, compared to using kzalloced shared memory
or unsetting CONFIG_HARDENED_USERCOPY, which won't involve finding vmap area:

                  kzalloced shmem      vzalloced shmem(unset CONFIG_HARDENED_USERCOPY)
Requests/sec          831950.39            805164.78
"

Without CONFIG_HARDENED_USERCOPY, the performance of physical-DMB and
virtual-DMB is basically same (physical-DMB is a bit better), and with
CONFIG_HARDENED_USERCOPY, under many CPUs environment, such as 48 CPUs
here, if we merge sndbuf and DMB, the find_vmap_area lock contention is
heavy, and the performance is drop obviously. So I said physical-DMB has
best performance, since it can guarantee good performance under known
environments.


By the way, we discussed the memory cost before (see [1]), but I found
that when we use s390 ISM (or not merge sndbuf and DMB), the sndbuf also
costs physically contiguous memory.

static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
						bool is_dmb, int bufsize)
{
<...>
	if (is_dmb) {
<...>
	} else {
		buf_desc->cpu_addr = kzalloc(bufsize, GFP_KERNEL |
					     __GFP_NOWARN | __GFP_NORETRY |
					     __GFP_NOMEMALLOC);
		if (!buf_desc->cpu_addr) {
			kfree(buf_desc);
			return ERR_PTR(-EAGAIN);
		}
		buf_desc->len = bufsize;
	}
<...>
}

So I wonder is it really necessary to use virtual-DMB in loopback-ism? Maybe
we can always use physical-DMB in loopback-ism, then there is no need for the
dmb_type or dmb_copy knobs.

[1] https://lore.kernel.org/netdev/d6facfd5-e083-ffc7-05e5-2e8f3ef17735@linux.alibaba.com/


Thanks!

