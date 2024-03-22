Return-Path: <linux-kernel+bounces-110861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B18864DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056C2282F33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E1184E;
	Fri, 22 Mar 2024 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a4N9YfKS"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3665C;
	Fri, 22 Mar 2024 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071588; cv=none; b=c/RlmPCf9hq0QXE4qhb3kC/8H7bn0eIj0ko7sI1eouN/LZDUG76mTab2JV9k7Ed45uj30VYq/MPkefL9V4sX74yxTrzTp2uDwZ34PnojP6SLLce2yZ2VBh0BcVS6Oss/rJ5VCDMSWh7JgjtC3DEvDZXmFyGR+Xds4tEkxb2heYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071588; c=relaxed/simple;
	bh=Ci83oNfPdQPjt/Qc0YrD0Nwu4bs0yCyv1L2fuvgDdVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzGeQFzaJH7dLuu4gqnfFxmXzRFqP3CT2xx2Sz/935P8UO/naeWizBZuj+8EOrrasG+IX9EdoX8+stAzB6tb95fppsJzSEkeR+DJCrr6Ye1xZIeOw8XUjlt6+C8Tfy9p4xW3YNWKPXWFknOfmlouqKwJLrXoou4F8ctCgqJRX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a4N9YfKS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711071583; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=po3aBGMuRH/3JxdDPn9VskA6LLyQZSnOhsGvbug9sUo=;
	b=a4N9YfKSW5uRD1McgVTo5P6QtSB4DBMl/EYLiGW9xVIZCNI9kYSQp7QW9jeCYd3NWJEAR5RllZcdNoJS1gnGeCdoVcCGNBHf68SfiQleS5px4RA86HWlzU4E6AWuKCOTnBz/IqIe4tdk2tKKmqPNo3mVtZfnJUfvlyfXkSsIvls=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W307.QH_1711071581;
Received: from 30.221.130.60(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W307.QH_1711071581)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 09:39:42 +0800
Message-ID: <d42c7545-4ff4-4337-9489-d9d757eee007@linux.alibaba.com>
Date: Fri, 22 Mar 2024 09:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 04/11] net/smc: implement some unsupported
 operations of loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-5-guwen@linux.alibaba.com>
 <f9bfbc0f-7cfc-47c0-b06c-23ee3e70a420@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <f9bfbc0f-7cfc-47c0-b06c-23ee3e70a420@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/21 16:12, Jan Karcher wrote:
> 
> 
> On 17/03/2024 11:05, Wen Gu wrote:
>> vlan operations are not supported currently since the need for vlan in
>> loopback-ism situation does not seem to be strong.
>>
>> signal_event operation is not supported since no event now needs to be
>> processed by loopback-ism device.
> 
> Hi Wen Gu,
> 
> Could we re-phrase this commit message please? I had some trouble reading it. Maybe something along:
> 
> Operations that loopback-ism does not support currently:
> - vlan operations, since there is no strong use-case for it
> - signal_event operations, since there are no events to be processed
>      by the loopback-ism device.
> 
> Thanks
> - Jan
> 
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

OK, it will be improved as you suggested. Thanks!

