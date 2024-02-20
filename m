Return-Path: <linux-kernel+bounces-72223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF785B0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF65BB226BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F3D36102;
	Tue, 20 Feb 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZkIVs5tG"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE02C1B9;
	Tue, 20 Feb 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397127; cv=none; b=agtaWy4XMX4Bzrhsz0fp6SgYlR6SSRvlFV384JqufQZ/pvnOb8DR5mu1Y3xgbvfhdXdIKXqdrj5lgMT3VbLX2jeWq61zSTppQ/kR/NI1UBlW7nYAapk27BGkhVIr1k2MVOJBP6jCSGoo+uT+8vN1455AV/stHBo8cs4eDDqyX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397127; c=relaxed/simple;
	bh=BgI8KUUZGcJShWv42a+S7WU6a7VTrR2A3Zt6fAujEFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAI5T1ZGjJWAgk/sBCTBtsRTTXXcLSvCcGpdHlbE8NYJy2gJEM1AzN60YvNMuqrR+v86by7Do1CkOqaA+24eZDKf8yiQ8m6lje2Mngu2XXF1F18gD15Xlhv0FFeUxsdJvuHUgQ7TTqcZdknuFCkMTZUwI25BGqfbSsax/98D0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZkIVs5tG; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708397121; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=epsRxanowU+Rvzj769kG7rng4wSLzPgisiNp8zQ07Ng=;
	b=ZkIVs5tGRFpppVsmALZXF27NoJ9/Ezzs32Sii20jvWdKDKD5UOPqiuOM+Rk0AOSYQ9CKIGSoumvcqFNktl8d5Xs3ay9Z2KREsR9Ob/pWhBNA7PcgiN0XoKGhwtrPMWjzv2DbltBUzG5mkghuYL2LsVaxjBJxrnWMyFVuQcXGW8g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W0v2plx_1708397119;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0v2plx_1708397119)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 10:45:21 +0800
Message-ID: <cac6192e-85d8-4289-b5af-bc8143e76004@linux.alibaba.com>
Date: Tue, 20 Feb 2024 10:45:19 +0800
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
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <417a1b7c-4136-4f96-a614-9fd976dc884d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/16 22:24, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This introduces some statistics attributes of loopback-ism. They can be
>> read from /sys/devices/virtual/smc/loopback-ism/{xfer_tytes|dmbs_cnt}.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_loopback.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h | 22 +++++++++++++
>>   2 files changed, 96 insertions(+)
>>
> 
> I've read the comments from Jiri and your answer. I can understand your thought. However, from the perspective of the 
> end user, it makes more sense to integetrate the stats info into 'smcd stats'. Otherwise, it would make users confused 
> to find out with which tool to check which statisic infornation. Sure, some improvement of the smc-tools is also needed

Thank you Wenjia.

Let's draw an analogy with RDMA devices, which is used in SMC-R. If we want
to check the RNIC status or statistics, we may use rdma statistic command, or
ibv_devinfo command, or check file under /sys/class/infiniband/mlx5_0. These
provide details or attributes related to *devices*.

Since s390 ISM can be used out of SMC, I guess it also has its own way (other
than smc-tools) to check the statistic?

What we can see in smcr stats or smcd stats command is about statistic or
status of SMC *protocol* layer, such as DMB status, Tx/Rx, connections, fallbacks.

If we put the underlying devices's statistics into smc-tools, should we also
put RNIC statistics or s390 ISM statistics into smcr stat or smcd stat? and
for each futures device that can be used by SMC-R/SMC-D, should we update them
into smcr stat and smcd stat? And the attributes of each devices may be different,
should we add entries in smcd stat for each of them?

After considering the above things, I believe that the details of the underlying
device should not be exposed to smc(smc-tools). What do you think?

Thanks!

