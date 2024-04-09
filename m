Return-Path: <linux-kernel+bounces-136349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5889D2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D171C21651
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144757BB11;
	Tue,  9 Apr 2024 07:25:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F91537E6;
	Tue,  9 Apr 2024 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647544; cv=none; b=e7+gSWERbvo3Yw+R0fArG+bd15yMlShp67iQw+dL/+B0ZJgK3LuILwXW5EjnPbcTy9Ovu7jHQ3J4Apiwuf8qaeg8nevbSZR+fAa5CUXkdTDg45y6Me2kuCvqPaYaIjBRufrfFMOHrfrpjC9zSUIDvW+pQDBoXf0NTp5ndriy5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647544; c=relaxed/simple;
	bh=9x+TfeQHYbAC2ZOOl4tIe41PHvzWIyJ7rn56eOmWHqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qhMcgLW6KH6Sp9KO7wuuJow2mJnyYKjR8nC8aayUcVz2FUVKt2Xq/W278g1QYStPVk6ZXo2R2t+ADrfz85rcPj3/BgH+Xvk8YTB9bCnDHBk+4uHrucFeOrjjFc5MkjDq1xp6cMm8WatddtxWglzBTTPy3dFa2IjF82eOKV9HDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VDHVD6BvczwRVJ;
	Tue,  9 Apr 2024 15:22:44 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F11218007D;
	Tue,  9 Apr 2024 15:25:39 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:25:38 +0800
Message-ID: <ca6c46d8-52a3-0f5a-c848-5401296a4f5f@huawei.com>
Date: Tue, 9 Apr 2024 15:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
To: <corbet@lwn.net>
CC: <mingo@kernel.org>, <chrubis@suse.cz>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter
 Zijlstra <peterz@infradead.org>
References: <20240131123238.2332064-1-zhangqiao22@huawei.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240131123238.2332064-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500001.china.huawei.com (7.192.104.163)

Ping.

+cc Peter, Steven.

在 2024/1/31 20:32, Zhang Qiao 写道:
> RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
> we should document this sched feature.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  Documentation/scheduler/sched-rt-group.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index d685609ed3d7..4d8eceb71f5e 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -12,6 +12,7 @@ Real-Time group scheduling
>       2.1 System-wide settings
>       2.2 Default behaviour
>       2.3 Basis for grouping tasks
> +     2.4 RT_RUNTIME_SHARE sched feature
>     3. Future plans
>  
>  
> @@ -146,6 +147,16 @@ For now, this can be simplified to just the following (but see Future plans):
>  
>     \Sum_{i} runtime_{i} <= global_runtime
>  
> +2.4 RT_RUNTIME_SHARE sched feature
> +----------------------------
> +
> +RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
> +out of its own rt-runtime.
> +
> +With this feature enabled, a rt-task probably hits 100% cpu usage and starves
> +per-cpu tasks like kworkers, as a result, it may hang up the whole system.
> +Therefore, in order to avoid such exception, recommand to disable this feature
> +by default unless you really know what you're up to.
>  
>  3. Future plans
>  ===============
> 

