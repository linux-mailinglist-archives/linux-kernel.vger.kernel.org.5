Return-Path: <linux-kernel+bounces-110182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFD885B37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D3B24285
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151A85959;
	Thu, 21 Mar 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJnomz2X"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73285277;
	Thu, 21 Mar 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032962; cv=none; b=AW1oVUxDi6krKlpqK+JWB13jzsvSBK+p8mN9SthOnWWOjIwGtA+E5WwYM8AM/+vQiW8pUmlDDJqc5MVqiNNBNUzd9//NL06UEalaKfJ4fMteAYUjMekG5J764qiPlD/VhVumFjhSvMKzVP3D/azqI5520rLtWKeA0b/GtE1LIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032962; c=relaxed/simple;
	bh=YIvwI/ubALPTOjiASGYwPfTxbIpOyTtWPsq7rVi4Ouk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPhau35rarxUC0koxxlr82lfG5vqQIn82GuvWt//5YI1QI2O/x4zxyYl9HRdZgdQlUd/i05xGcPbe1DM27dDPG/V11utmYIPOs3wuyWpUhkwSd+A8NM6GJFbvml0NaBwzsH9kvgp50pKBki0eHEumpuQ+pOihtlFTks/aueAxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IJnomz2X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Pt7JRhzkFkAG/rLFiDKcpKdOtFvAnzfioukjLqTNjvk=; b=IJnomz2XUUqpjVlE/eptJzumLf
	P1RunKY09PLsVPwOLQY8l7/bVMnvQZrGO24zM/XTCZ9XFM+tjyfDrTmD4UdfW8iKrSNTTYNj+zSj0
	rIJSIYlqPS3vYmQVM2a0g2OdekyvSpdRJeTPrrhYQdeBAeChTm2owHAqkistbR4Bsw/7/UuoQMxZ2
	hlAC9+ZT2KHJl0bw0S2Sl5cwLCa5A0/1hP2HU/ggrBEnb25VxhTa5Rtgk0gpTtAZKVb8xEu6DJmPo
	og1yi4YLO8ugbJMwXMZIEsGdngVubBVWYUWdhwnj0OQZSEvou/19bcHRox+g4nV5mqhcm8nlgkgeJ
	oBzyPgKA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnJpl-00000003MZx-1k70;
	Thu, 21 Mar 2024 14:55:57 +0000
Message-ID: <51d825a3-46a7-42eb-a413-4beb37b7656d@infradead.org>
Date: Thu, 21 Mar 2024 07:55:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/doc: Update documentation for base_slice_ns and
 CONFIG_HZ relation
Content-Language: en-US
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, mingo@kernel.org, linux-kernel@vger.kernel.org
References: <20240320173815.927637-2-mchauras@linux.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240320173815.927637-2-mchauras@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/20/24 10:38, Mukesh Kumar Chaurasiya wrote:
> The tunable base_slice_ns is dependent on CONFIG_HZ (i.e. TICK_NSEC)
> for any significant performance improvement. The reason being the
> scheduler tick is not frequent enough to force preemption when
> base_slice expires in case of
> 
>            base_slice_ns < TICK_NSEC
> 
> The below data is of stress-ng
> Number of CPU: 1
> Stressor threads: 4
> Time: 30sec
> 
> On CONFIG_HZ=1000
> 
> | base_slice | avg-run (msec) | context-switches |
> | ---------- | -------------- | ---------------- |
> | 3ms        | 2.914          | 10342            |
> | 6ms        | 4.857          | 6196             |
> | 9ms        | 6.754          | 4482             |
> | 12ms       | 7.872          | 3802             |
> | 22ms       | 11.294         | 2710             |
> | 32ms       | 13.425         | 2284             |
> 
> On CONFIG_HZ=100
> 
> | base_slice | avg-run (msec) | context-switches |
> | ---------- | -------------- | ---------------- |
> | 3ms        | 9.144          | 3337             |
> | 6ms        | 9.113          | 3301             |
> | 9ms        | 8.991          | 3315             |
> | 12ms       | 12.935         | 2328             |
> | 22ms       | 16.031         | 1915             |
> | 32ms       | 18.608         | 1622             |
> 
> base_slice: the value of base_slice in ms
> avg-run (msec): average time of the stressor threads got on cpu before
> it got preempted
> context-switches: number of context switches for the stress-ng process
> 
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> ---
>  Documentation/scheduler/sched-design-CFS.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
> index 6cffffe26500..82985d675554 100644
> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -100,6 +100,9 @@ which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
>  "server" (i.e., good batching) workloads.  It defaults to a setting suitable
>  for desktop workloads.  SCHED_BATCH is handled by the CFS scheduler module too.
>  
> +In case the CONFIG_HZ leads to base_slice_ns < TICK_NSEC. The settings of

                                                  TICK_NSEC, the {setting, value}

> +base_slice_ns will have little to no impact on the workloads.
> +
>  Due to its design, the CFS scheduler is not prone to any of the "attacks" that
>  exist today against the heuristics of the stock scheduler: fiftyp.c, thud.c,
>  chew.c, ring-test.c, massive_intr.c all work fine and do not impact

-- 
#Randy

