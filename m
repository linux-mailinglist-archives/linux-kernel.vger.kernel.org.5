Return-Path: <linux-kernel+bounces-81350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E54867495
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D56D1F26C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAF604BB;
	Mon, 26 Feb 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aovJkjdE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221E604B2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949864; cv=none; b=YuF43pNO8uN5weROie4BXW5dduv9rkD9ObNF5lh+7jZw3bKnK2Vb0hL6qQvwP9jnP2YJzbV9H0eV53WcnMgTX6/yrzIuZLi85M+bIPpMt7PxTDwtRcI4UZg8z2KSL9n36GWEtByftDOxguocK/FyDtIXfATJotmxTV9dO7dOMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949864; c=relaxed/simple;
	bh=WGeo6qnoboUERIHqNJST+QKIpGkQmdNxz9VFuuqXo2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AsOyBZiy8a4mbCu6hijIz69IvMM8OWlSZmNu3hYtp1SEK8j3ZPXiKClD8x4Ct6yuSgmwPsNDRiyxuGXRIIW9rmanBV6Pj2ovODiQUPi3MusHoQ+cGOaGr6hcVgjB+hXVjlQ1TTnnZHBbC7EVJgoldQ93KmgWXic1MtLmq0KzqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aovJkjdE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QBt3Aq030684;
	Mon, 26 Feb 2024 12:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+ck1cGPT8wQdRyOq1xAh80rblR+xVHtFwav9WBUrvac=; b=ao
	vJkjdEzuhg5SZhodTAy921birYvHdD+HJWVBCYhddHZKmvWkbaCrroVgzcC7K0iW
	3+1kQpSBlfF7od+8FGNxu5jsT1qWeZtHv9WRTmYA+Fl1CywGp7PKobdFb2GFR/ph
	nG+QqDGpgGOfUuA9eUZu43Y6zWgIF2qzK223zxz+/7gxdB8yxnkFcLtXrekRhlMQ
	NhaPL/036WTvmwbwCGdJ7pvEpAPN0vq4vKIF7rppkHx2/s+cihYTsk1ZGZvmMh43
	jpRodVNouYONYhIRFPzKVOKWdIFbsP5mlzJbNMuRSkYClIXQ6idH8O8FoZWD1c8M
	4ZkpliRNgCJmxkxUonsg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxn8u3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 12:17:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QCHOZN019226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 12:17:24 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 04:17:22 -0800
Message-ID: <44648e78-d117-2f6a-8ecd-f0a29327fa4f@quicinc.com>
Date: Mon, 26 Feb 2024 17:47:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, <pmladek@suse.com>,
        <rostedt@goodmis.org>, <senozhatsky@chromium.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
 <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
 <875xybmo2z.fsf@jogness.linutronix.de>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <875xybmo2z.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v-Xbi2X_9t16yhmOmMMrKRLRp_NprqUl
X-Proofpoint-GUID: v-Xbi2X_9t16yhmOmMMrKRLRp_NprqUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_08,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260091



On 2/26/2024 5:31 PM, John Ogness wrote:
> console_trylock_spinning() may takeover the console lock from a
> schedulable context. Update @console_may_schedule to make sure it
> reflects a trylock acquire.
> 
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Link: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@quicinc.com
> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for prompt response..

Yes, this looks fine..
As spinning code runs with preemption disabled context
and should reset the console_may_schedule to 0 .

what if console_trylock_spinning() gets the lock which makes 
console_may_schedule =1 and it is still schedulable ?

-Mukesh

> ---
>   kernel/printk/printk.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1685a71f3f71..1612b50b2374 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2020,6 +2020,12 @@ static int console_trylock_spinning(void)
>   	 */
>   	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
>   
> +	/*
> +	 * Update @console_may_schedule for trylock because the previous
> +	 * owner may have been schedulable.
> +	 */
> +	console_may_schedule = 0;
> +
>   	return 1;
>   }
>   
> 
> base-commit: e7081d5a9d976b84f61f497316d7c940a4a2e67a

