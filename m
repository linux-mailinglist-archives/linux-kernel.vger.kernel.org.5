Return-Path: <linux-kernel+bounces-140423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FE8A1441
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235FE1C2222C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AE14D298;
	Thu, 11 Apr 2024 12:18:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389514C5B3;
	Thu, 11 Apr 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837880; cv=none; b=hc7GLVVrQM2kxnKAqdS6ZaKrH8iBNRksoOnpdTDtiiBzQX/aXNI3FF2LiP1EodFMliJGmpS5RO3f7wrQqI2zvwcFynet9AmN9bNKcSbalF3Lvuc4kiwR1CX6UggIp9YH6exVuKKBJ6WtH4oFpKnGAC5eCWDUCvxBRLM74yPk0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837880; c=relaxed/simple;
	bh=cy6vEhb31ERfN0BuM1JGJrIcuc7i0gndmm34/Zjc+/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K96DWQQekWHoW+K4l7Wq2I5WPPM1khDey28SCDlpOp0ZXtWZYV5ykXl6FMRTwAgNVHfXBBryQ/QN7E9mo5E0xqm2OxcjgVcuk5xr5qWakOyC/oh23pjmqJqVQJDq1kaBR8T/Gkwf4N4WXRvvHDt1Iv6DHc8qrPP+xkOuLdIbH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VFdtk2QZPztSG4;
	Thu, 11 Apr 2024 20:15:10 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B30D140E9F;
	Thu, 11 Apr 2024 20:17:55 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:17:54 +0800
Message-ID: <1f9f1ea8-0a94-4d4c-cae3-983f307e6840@huawei.com>
Date: Thu, 11 Apr 2024 20:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 6.6] Revert "dm-crypt, dm-verity: disable tasklets"
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <mpatocka@redhat.com>,
	<torvalds@linux-foundation.org>, <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<msnitzer@redhat.com>, <ignat@cloudflare.com>, <damien.lemoal@wdc.com>,
	<bob.liu@oracle.com>, <houtao1@huawei.com>, <nhuck@google.com>,
	<peterz@infradead.org>, <mingo@elte.hu>, <yukuai3@huawei.com>,
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20240411091539.361470-1-lilingfeng3@huawei.com>
 <2024041103-reputable-bobsled-585f@gregkh>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <2024041103-reputable-bobsled-585f@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100001.china.huawei.com (7.185.36.94)

There is no need to revert it in Linus's tree since the expanded 
workqueue can work like tasklet.
https://lore.kernel.org/lkml/20240130091300.2968534-1-tj@kernel.org/

I'm not sure if the problem described in [1] could be triggered by a 
scenario I haven't considered. So I only send the revert patch to 6.6 
mainly for comments.
Of course, I think the other branches need it too.

Thanks

在 2024/4/11 17:52, Greg KH 写道:
> On Thu, Apr 11, 2024 at 05:15:39PM +0800, Li Lingfeng wrote:
>> This reverts commit 5735a2671ffb70ea29ca83969fe01316ee2ed6fc which is
>> commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.
>>
>> Tasklet is thought to cause memory corruption [1], so it was disabled in
>> dm-crypt and dm-verity. However, memory corruption may not happen since
>> cc->io_queue is created without WQ_UNBOUND [2].
>> Revert commit 5735a2671ffb ("dm-crypt, dm-verity: disable tasklets") to
>> bring tasklet back.
>>
>> [1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
>> [2] https://lore.kernel.org/all/4d331659-badd-749d-fba1-271543631a8a@huawei.com/
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   drivers/md/dm-crypt.c         | 38 +++++++++++++++++++++++++++++++++--
>>   drivers/md/dm-verity-target.c | 26 ++++++++++++++++++++++--
>>   drivers/md/dm-verity.h        |  1 +
>>   3 files changed, 61 insertions(+), 4 deletions(-)
> What is the commit id of this in Linus's tree?  And why only 6.6.y?
>
> thanks,
>
> greg k-h
>

