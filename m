Return-Path: <linux-kernel+bounces-86408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D186C4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1745F28D791
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB15D492;
	Thu, 29 Feb 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WYNyfzIi"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8B5CDFE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198704; cv=none; b=l0qfKkBc4ekobxpEHlnjIZz4/CjrhoXCRteqX/SimlWomE+KLtxomX+FnQrqQPBxOs/gWAA16FHUB3M41NKgdhpkWFeS3CRyCqPB4NMet5AFsn9LMpYCIr0iaHkFeoKvPh5gVyhk9w1NfJN5M0RcWHvXUDUbn3Fyv/INuKS0CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198704; c=relaxed/simple;
	bh=ap434ylnovvGoNc9bOD0j+ivUkfSULpZe6TqskBZLug=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=oggqno17uOaPoZyCJAsZr34PGsZyflS2TQBmuNYVKeijqHyEZyhVa+FZxQdVElb1qovbBkyarEY/XTMmQBoi5zJf/0QIuoVsICi9DvM/kYrEgSJUrcLkjAdIyI4rTsxUdJg9tYTn38iaAEFrze7W6N1WrVIJeHXPlP+Jlo6QWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WYNyfzIi; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709198700; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=qNgAuU6gKGgHxYrfvaLiJzr9i3yPJIyisWcGeQJQ9UI=;
	b=WYNyfzIiMjfhHdaR22KulxUm/7Z6uKsLOTVWB+NY1mmdh8Hm6kPdFw4OD3N2SR3PsFswxoTR67MJbVeRXwWpYGcj/E8rVYskTU+GYakoTOepM6e+Q2P005AiHXjpF6MYVA+Xb6s0lpPqJjpIepw62ReHIh1lPGAZPLWEuAJtXbc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W1SXNeZ_1709198671;
Received: from 30.97.48.162(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1SXNeZ_1709198671)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:24:59 +0800
Message-ID: <c2ceff07-e1b4-4dbc-b945-f91a9076375e@linux.alibaba.com>
Date: Thu, 29 Feb 2024 17:24:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20231107090510.71322-2-wuyun.abel@bytedance.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Barry Song <21cnbao@gmail.com>, Benjamin Segall <bsegall@google.com>,
 Chen Yu <yu.c.chen@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mike Galbraith <efault@gmx.de>,
 Qais Yousef <qyousef@layalina.io>, Tim Chen <tim.c.chen@linux.intel.com>,
 Yicong Yang <yangyicong@huawei.com>,
 Youssef Esmat <youssefesmat@chromium.org>, linux-kernel@vger.kernel.org
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abel:

I'm not so familiar with eevdf and still learning. Here I've some questions 
about this patch.

1. You did proof that V will not change during reweight (COROLLARY #2). However, 
according to the original paper, the new V will be:
V' = V + lag(j)/(W - w_j) - lag(j)/(W - w_j + w'_j)
So the V' in paper will change (when lag is not zero).
Is the V in Linux code slightly different from the paper?

2. I print some log around reweight_entity(), mainly want to print V by calling 
avg_vruntime(cfs_rq). I found your algorithm only keeps the V unchanged during 
reweight_eevdf(), but not reweight_entity().

In detail:
If curr is true (i.e., cfs_rq->curr == se), we will directly run 
reweight_eevdf(), and the V is not changed.
If curr is false, we will have __dequeue_entity() -> reweight_eevdf() -> 
__enqueue_entity(). The V is finally changed due to dequeue and enqueue. So the 
result of reweight_entity() will be impacted by "cfs_rq->curr == se", is this 
expected?

Thanks!

