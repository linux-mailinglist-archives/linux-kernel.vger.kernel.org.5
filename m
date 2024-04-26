Return-Path: <linux-kernel+bounces-159678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E58B320A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DD11C220E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6C13C9AE;
	Fri, 26 Apr 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sm0X5f7R"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14440762EF;
	Fri, 26 Apr 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119021; cv=none; b=kGHEJWH6HfRsV1KxdBnuL9QYG8d9Yv+2TVM2Oz8BeISlAqK7toRgRxXzWAbF2qLOZlRH3TaQgB4h3cmrnqCO3qin24a2ZFJm5wSZRVYssi5KmEU8CebBKehIfktc/aPwxazdtbU/LxDTwuN4vpxx3mmA91+ceadCD9B6q7qmJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119021; c=relaxed/simple;
	bh=oMB+Km3ROuQXEtGaucBP0IGrOeqCJyyO49IIKi+QrCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy6biYwZv7fCogfE62Kj5Pz4JnYW5oFJZObuI0p0Oe6neDM10G3p7zDi8/1DxcVa9M8Qc4zUkclV84l5i5saxrDnlmojOJCRFFJyJpYhDIJAk14A1CMryVRcheb1yk7EE/u8/vUwk6T/cB5C+WJkNmVtFmeTP4Uv9f6zB+bTWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sm0X5f7R; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714119012; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LqTCDfOvqx5Lob56/bz2l5pUtBO3pVveHPT6+RnNkLw=;
	b=sm0X5f7Rvmy8A/Abb6O1/lfgwMo1zfKfvlTyCN40Hc8UP64TbgZaBiUqcMBseLrrQhJZ1eN8/0AgWoW4IW6aksFpRgjQFtTlx+g8jwhb/+XXFIT5Z2E1+N+98Ps8p4DyH7Gqx9XAuZtWH9sYuaOoBdrmiQRpKOt266drOMhGjLE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W5IVQN-_1714118996;
Received: from 30.221.129.216(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5IVQN-_1714118996)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 16:10:11 +0800
Message-ID: <3279bc99-0dc7-4cbe-b7a4-88e877b84251@linux.alibaba.com>
Date: Fri, 26 Apr 2024 16:09:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] net/smc: register loopback-ism into
 SMC-D device list
To: Wenjia Zhang <wenjia@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, twinkler@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-8-guwen@linux.alibaba.com>
 <ef936c58-e87c-4078-a4dc-ed7313dba2a3@linux.ibm.com>
 <23cff564-a65c-4db6-a386-2a7e56be84c8@linux.ibm.com>
 <d0b8e551-6330-4b1d-98bc-ef1b0e41fbb4@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <d0b8e551-6330-4b1d-98bc-ef1b0e41fbb4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/26 16:04, Wenjia Zhang wrote:
> 
> 
> On 25.04.24 15:29, Alexandra Winter wrote:
>>
>>
>> On 25.04.24 13:29, Wenjia Zhang wrote:
>>>> +    if (!smcd->pnetid[0]) {
>>>> +        fentry = list_first_entry_or_null(&smcd_dev_list.list,
>>>> +                          struct smcd_dev, list);
>>>> +        if (fentry && smc_ism_is_loopback(fentry))
>>>> +            list_add(&smcd->list, &fentry->list);
>>>> +        else
>>>> +            list_add(&smcd->list, &smcd_dev_list.list);
>>>> +    } else {
>>>>            list_add_tail(&smcd->list, &smcd_dev_list.list);
>>>> -    else
>>>> -        list_add(&smcd->list, &smcd_dev_list.list);
>>>> +    }
>>>
>>> Nit: here the pair of curly brackets are unnecessary.
>>
>> Actually
>> https://www.kernel.org/doc/html/latest/process/coding-style.html#codingstyle
>> tells you to use those braces.
> Thanks, @Alexandra!
> Then @Wen, forget my comments on this pls!

OK, Wenjia. Thanks!

