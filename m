Return-Path: <linux-kernel+bounces-112571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A445887B96
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C7B21135
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43794439;
	Sun, 24 Mar 2024 03:54:28 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279B17C8;
	Sun, 24 Mar 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252468; cv=none; b=MlZLK+8+P+d0huvuCk4uK09YXO26CpfaP5MY1KK9ffvheIHFVrTXFy7iMN0cN9y3ukoAT3EasZNnvKU6xzBDb+3nO5Ktg7BGqjgyyTv2ckcCpyKngjkRtcV3hwwVmrgH30p0l7s12xgrh0BuMX8xp/qjb55n2+zyPmpmlA9YjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252468; c=relaxed/simple;
	bh=ayNdQuVZRkPZpCePlEJE3PJTt5J3o7h2x+1Z4CfsE4U=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=QeL6JuE6E5SO2JCTOpLx6Yb1EmBpu0zw45XcT22DGOry3tTPlj1FvA738A288ul2Yx6bZ4yLXmVoOh2BbloHtykxTQVnhx1IKc+A6qymKF991cI1QVU2P62R54h/vmC17n/aHakHHfzZkjRQo+vUyxOhF8ynP+TUVXE9FgMhKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V2MZ402H8z1R7KD;
	Sun, 24 Mar 2024 11:51:40 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (unknown [7.185.36.186])
	by mail.maildlp.com (Postfix) with ESMTPS id 05E561A016C;
	Sun, 24 Mar 2024 11:54:17 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 11:54:16 +0800
Message-ID: <df37e340-211a-66c0-2383-f07e287bea8d@huawei.com>
Date: Sun, 24 Mar 2024 11:54:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
To: <corbet@lwn.net>
CC: <chrubis@suse.cz>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@kernel.org>, <zhangqiao22@huawei.com>
References: <875xy8p5tt.fsf@meer.lwn.net>
Subject: Re: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <875xy8p5tt.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)

hi, Jonathan,

在 2024/3/24 10:47, Zhang Qiao 写道:
>
> Zhang Qiao <zhangqiao22@huawei.com> writes:
>
>> RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
>> we should document this sched feature.
>>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>  Documentation/scheduler/sched-rt-group.rst | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
>> index d685609ed3d7..4d8eceb71f5e 100644
>> --- a/Documentation/scheduler/sched-rt-group.rst
>> +++ b/Documentation/scheduler/sched-rt-group.rst
>> @@ -12,6 +12,7 @@ Real-Time group scheduling
>>       2.1 System-wide settings
>>       2.2 Default behaviour
>>       2.3 Basis for grouping tasks
>> +     2.4 RT_RUNTIME_SHARE sched feature
>>     3. Future plans
>>
>>
>> @@ -146,6 +147,16 @@ For now, this can be simplified to just the following (but see Future plans):
>>
>>     \Sum_{i} runtime_{i} <= global_runtime
>>
>> +2.4 RT_RUNTIME_SHARE sched feature
>> +----------------------------
>> +
>> +RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
>> +out of its own rt-runtime.
>> +
>> +With this feature enabled, a rt-task probably hits 100% cpu usage and starves
>> +per-cpu tasks like kworkers, as a result, it may hang up the whole system.
>> +Therefore, in order to avoid such exception, recommand to disable this feature
>> +by default unless you really know what you're up to.
>
> So this doesn't appear to have been picked up by anybody...should I
> carry it in docs, or is there some other reason why it hasn't gone in?
>

I'm not exactly sure why it wasn't added in docs before.

In my opinion, the RT_RUNTIME_SHARE sched features and sched_rt_period_us/sched_rt_runtime_us
parameters are both important parameters of rt bandwidth,it will affect the quota of rt tasks,
and improper configuration may cause the system hang up. So I think it's necessary to add it
in Documentation/scheduler/sched-rt-group.rst.

Thanks,

Qiao.

> Thanks,
>
> jon
> .
>

