Return-Path: <linux-kernel+bounces-52380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E405F849755
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C781F22C68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5714A9D;
	Mon,  5 Feb 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="szDkV6Hc"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259F12B9D;
	Mon,  5 Feb 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127567; cv=none; b=WSn+4nx+s5UYwurH19QDhP+Nlnp6HDyUePgejck7a2OogTGE6c3TIqAkv4IKNv3aGAunJRpf2YCQy0HXyKuYeSFC9X/Vo7sfNrWcK1q118BTPl2RW5J+DgLuNf8fSbCU2gMlk3X575lVpRg3Vw1h/XmXHWna/MXWrnGJ6yf8mcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127567; c=relaxed/simple;
	bh=xgBwL14gsjbyBxLm9I9rKQf8AqB0FAer5tOUDFLoh7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bx7Qb3h+r+RW9C6toZhK6zVph/NwqHyh697vK3ZmCArHh1SQUI0ESDIYUBGnRXpca1ifbIEMmoetlud7bkW0bYY/4SDkycZkYZrw+o8RubZ1bbP6Ek6T2oS1nhF6RD2MdwgepKxRAYvik3oB5Xl0HNGg85dw7tvmZYJ1AMYe+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=szDkV6Hc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707127554; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=FTxuB/9pVV6+BKydMw7NaZh54dsfrIIZGvhhGbnCB7g=;
	b=szDkV6HcQRWGnwM06PpbPLiBqWOgL+rH8bCaTJOU1wTpkhp4MVfpx2fDv2Iy2Jy630nyFIa8PfWmQ2238o2nyu8VcBJ333oIki7apNQnXx0miPpcVzUMa7uiobYezmIQ2mzyL35FYNlyiLnASGd/LPlaxXLkXcrqWmDCgWGdOSk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W08RJ8u_1707127552;
Received: from 30.221.129.101(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W08RJ8u_1707127552)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 18:05:53 +0800
Message-ID: <a29ead38-7a39-4bbb-80cc-619c1b0dfd62@linux.alibaba.com>
Date: Mon, 5 Feb 2024 18:05:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
From: Wen Gu <guwen@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
 <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
 <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
 <3c51c969-3884-4104-b38d-570c61525214@linux.ibm.com>
 <47c1b777-6d4e-40ac-9297-61240c126d6a@linux.alibaba.com>
In-Reply-To: <47c1b777-6d4e-40ac-9297-61240c126d6a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/1/24 14:33, Wen Gu wrote:
> 
> 
> On 2024/1/23 22:03, Alexandra Winter wrote:
>> Hello Wen Gu and others,
>>
>> I just wanted to let you know that unfortunately both Wenjia and Jan have called in sick and we don't know
>> when they will be back at work.
>> So I'm sorry but there may be mroe delays in the review of this patchset.
>>
>> Kind regards
>> Alexandra Winter
> 
> Hi Alexandra,
> 
> Thank you for the update. Health comes first. Wishing Wenjia and Jan
> both make a swift recovery.
> 
> Best regards,
> Wen Gu

Hi, Wenjia and Jan

I would like to ask if I should wait for the review of this version
or send a v2 (with some minor changes) ?

Thanks!

