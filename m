Return-Path: <linux-kernel+bounces-134751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324E89B661
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F883281F80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D74C187F;
	Mon,  8 Apr 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQOuYXaR"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A451851
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546670; cv=none; b=KzTCrksUGPUKVEW6sGBjxvA0ThF6q/zUvTJJQEw9F4fO0hvAN3+I3CkNC9trczbnQQuk960/jGSUlmPoQuUlE94ZypBsd1KRR93QQ1q4MpUtZfkDzYG1M8WEbTGaXEBeUckg0Pvwtf+EPX0lVtEPIhrr1jQwq89RK2wT5OE8sSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546670; c=relaxed/simple;
	bh=Y05FOC5+W6Vezmtr1ksBAQ+LJWeJHJo83YRIHBXFnA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dQeHS7TRjIM8LnWB+rRVs+DhW1NcbA7JtxHA4gm9088DboZZa5nf6tsWRyV9c+fZs5VTa2z3oa3oECmhpENs2LfzLuC5C6PYhEgqxV4kKq2MKxczMjozC6HkTzatRDfKj9zPM9IhRRNDyrZuYW1wVRfQUXLsurqupu0X1B3S8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQOuYXaR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712546664; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=4DeU/daQckt3PRGa/dQ2pRkCNkVFDkR75kWgqwFY7Q4=;
	b=uQOuYXaRsA1HVdHJw+M4jdoxTOAHT2IvGBqEiH/EQ02IFfZXhs4r8RSOonoyF0iOqbTs3plsj/6UVA/cJxIS2mgecbv6vK/b4sCw99T6XlTbQkfHMxf8OzLHbAKJc2SsHjLsvyHm65532OMUflK5rh3IlUT7hVl+TzzJ6az+MAE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W41xCQq_1712546662;
Received: from 30.97.48.217(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W41xCQq_1712546662)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 11:24:23 +0800
Message-ID: <295a4bb8-d133-49f0-8719-61a8dd1d1b80@linux.alibaba.com>
Date: Mon, 8 Apr 2024 11:24:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sched/eevdf: Minor fixes for reweight_entity()
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Abel Wu <wuyun.abel@bytedance.com>
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/6 10:21, Tianchen Ding wrote:

Gentle ping.

> According to the discussion in [1], fix a calculation bug in
> reweight_entity().
> 
> [1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/
> 
> v2:
> Add fixes tag to the 1st patch.
> 
> v1: https://lore.kernel.org/all/20240304030042.2690-1-dtcccc@linux.alibaba.com/
> 
> Tianchen Ding (2):
>    sched/eevdf: Always update V if se->on_rq when reweighting
>    sched/eevdf: Fix miscalculation in reweight_entity() when se is not
>      curr
> 
>   kernel/sched/fair.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 


