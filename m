Return-Path: <linux-kernel+bounces-151192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441998AAAED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4167B21F21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311E74C09;
	Fri, 19 Apr 2024 08:52:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB6F9CD;
	Fri, 19 Apr 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516739; cv=none; b=W44DOny6MF+TdgvHx02ZhWAFtFjwYTl6wUJikJ4LCNiZsmWnwfR3sjlhxFBLVXzow5W0Btd9g3//UD6EUg9FkjqLVgFSBTXpqQCJudw/iM2MJe/YtUvVnDd+dtBYLxj9LhDprq5m/CFRWxfNHp7UfP8O4Gh0M4tD43yGdyUvvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516739; c=relaxed/simple;
	bh=4FFnkWokSaQu1tit/8C9PTelyo7m8d+6FKp7oVIIVp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AtVVnFeRz55wJ+Engl8ban69mbENE/poNf10Jy52fc6SfaEKwAkvbFLZJd7g/8bDjR01LbmtN1VvhLqJ1Kikn1KfsJ56O5flENHZxfqC2SGpKHHxOsjN03iaKoTIHA35//LzZXcAILgKow8uqcVARPX9tsPozpOwO0N5hBWI79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VLSxz1dkBzNsmw;
	Fri, 19 Apr 2024 16:49:43 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 15EEB18007E;
	Fri, 19 Apr 2024 16:52:09 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 16:51:56 +0800
Message-ID: <e0b48c67-abb6-18f1-86ba-a041ccb4e0b7@huawei.com>
Date: Fri, 19 Apr 2024 16:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <mingo@kernel.org>, <chrubis@suse.cz>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter
 Zijlstra <peterz@infradead.org>, <corbet@lwn.net>
References: <20240131123238.2332064-1-zhangqiao22@huawei.com>
 <Zhihch_S1_-1JhwK@archie.me>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Zhihch_S1_-1JhwK@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500001.china.huawei.com (7.192.104.163)



在 2024/4/12 10:50, Bagas Sanjaya 写道:
> On Wed, Jan 31, 2024 at 08:32:38PM +0800, Zhang Qiao wrote:
>> +2.4 RT_RUNTIME_SHARE sched feature
>> +----------------------------
> 
> htmldocs build reports new warning:
> 
> Documentation/scheduler/sched-rt-group.rst:151: WARNING: Title underline too short.
> 
> 2.4 RT_RUNTIME_SHARE sched feature
> ----------------------------
> 
> I have to extend the underline:
> 
> ---- >8 ----
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index 4d8eceb71f5ed8..751113fcd35850 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -148,7 +148,7 @@ For now, this can be simplified to just the following (but see Future plans):
>     \Sum_{i} runtime_{i} <= global_runtime
>  
>  2.4 RT_RUNTIME_SHARE sched feature
> -----------------------------
> +----------------------------------
>  
>  RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
>  out of its own rt-runtime.
> 
> Wording suggestions below.

Hi, Bagas，
Thanks for you suggestions, i will update in v2.


Zhang Qiao.

> 
>> +
>> +RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
> "... to borrow rt-runtime ..."
>> +out of its own rt-runtime.
>> +
>> +With this feature enabled, a rt-task probably hits 100% cpu usage and starves
> "... a rt-task may hit ... and can stall other per-cpu tasks ..."
>> +per-cpu tasks like kworkers, as a result, it may hang up the whole system.
> "..., which lead into system hang."
>> +Therefore, in order to avoid such exception, recommand to disable this feature
>> +by default unless you really know what you're up to.
> "Thus, it is advised to disable this feature by default to avoid aforementioned
> issue unless you know what you're doing."
> 
> Thanks.
> 

