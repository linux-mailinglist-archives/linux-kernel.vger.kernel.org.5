Return-Path: <linux-kernel+bounces-46475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C5844040
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B928CADC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B30E7BB19;
	Wed, 31 Jan 2024 13:14:59 +0000 (UTC)
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F327D400
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706898; cv=none; b=Md15itwAShxhTHBr76wFJjfoWihO2YRe5RNJTplDqDt6PnGVk2CiZrfRfCdyjOnPwrQhnjOdTVCD9FVZPdc/i+/QLuKih4fvs2J1PzWlrZw7A8gRsriB067m5l0yU7TzrjyRz+RmsdP0lyathln5QF/iX8ZrpkW4BDb3B8rp2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706898; c=relaxed/simple;
	bh=Wstx/8DrhppTB6uXTFZMfydw0I3FsGTGVc7YH8GLoDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpsfL958MD2tezS+cpsX9M3Lm+PI9JRRJw3kzQI7KcRKxbN+dofFaIF9YitwH2CVv7ciopAt+vOsea9aY72vrKaHDO27rgmcUetO1Wo+f4H/gEQCEk4nLZ57uWSOV2n+Dz91m4QbAz2etraLC+CTGs5LrWSx3VBrN7cHVVFyizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WKLJDvV_1706706888;
Received: from 30.120.166.155(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WKLJDvV_1706706888)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 21:14:49 +0800
Message-ID: <ae7ce03d-0938-44b9-a2b5-74842016f32b@antgroup.com>
Date: Wed, 31 Jan 2024 21:14:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To: Abel Wu <wuyun.abel@bytedance.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
 <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/31/24 8:28 PM, Abel Wu wrote:
> On 1/31/24 8:10 PM, Tiwei Bie Wrote:
>> On 1/30/24 6:13 PM, Abel Wu wrote:
>>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>>
>>>> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
>>>> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
>>>> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
>>>> [  512.082337][ T8305] *pde = 00000000
>>>> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
>>>> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
>>>> [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>>> [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
>>>
>>> There was actually a NULL-test in pick_eevdf() before this commit,
>>> but I removed it by intent as I found it impossible to be NULL after
>>> examining 'all' the cases.
>>>
>>> Also cc Tiwei who once proposed to add this check back.
>>> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
>>
>> Thanks for cc'ing me. That's the case I worried about and why I thought
>> it might be worthwhile to add the sanity check back. I just sent out a
>> new version of the above patch with updated commit log and error message.
> 
> I assuming the real problem is why it *can* be NULL at first place.
> IMHO the NULL check with a fallback selection doesn't solve this, but
> it indeed avoids kernel panic which is absolutely important.

I totally agree. The scheduling failure is unexpected and should be
addressed. And the sanity check is just to log the failures and avoid
unnecessary crashes in such situations. 

Regards,
Tiwei

