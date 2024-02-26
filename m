Return-Path: <linux-kernel+bounces-81151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B110F86718E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C3B24AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA868200D5;
	Mon, 26 Feb 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cFIEi9BN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310D1CFBE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942724; cv=none; b=hPJmE6nZb4po5/H/CKzQG0G4u92Z5Gb7k7dq8sWlBCQsd8EfgdQqqElpiAWkOU4g/F5wmfO2bikDXHGVHWfxRsuNJX9Q41ezOzV7J1zmA0X4/sRHxwEmcHq6ktA7j9I/E0AEiQucKhGBequVVAjyLnyNsQiOWhwBrh6lKfGwPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942724; c=relaxed/simple;
	bh=3dY9v8pzYytwG1dhDWUFwhk6KVuyvtvg0hRzpm2/Tjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EpM1Hlr9dQJ2dhoRjHJcs8ubBCgIEkc4zmCoWPj+q85QlK2BMGw/oiiJYdjMtZbWjbvoE67c+vQ0Pvv709+b+ZbpMuoWufshAyVuejlVe2RMVS0uMf0w6djKiGTMto2OIJV1EQiblQNL/BVNAef+lhTHm3j3T06nw8YwKDb/RGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cFIEi9BN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5dJPw011612;
	Mon, 26 Feb 2024 10:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=O2DE/nIvS1ODn/CemR0wgKU5W8KOvSU+fm4XqxrMHec=; b=cF
	IEi9BN+DOccfzhedeCDBq6iogDL+oKI2f6dPou1pKel0osuznVYAR/1pia5oaXeI
	w2pSpGGd5S/r00B2jEMypKLeWRgIEDMf4kyNMhn00nn2XZLPK1cdwxd958Kvq7nL
	OBXxCVWwMvu5+yAb3OnFvKI3uV4/uRlM41uCchqXUtkoeLDGXreu12Gy+iH3tHbb
	kzO6EecwYdPx/HnMX+kAC6zx7hG51peyDWo8WUA+d8t8XSy9hLuIjB1AwgUKP7fT
	AcA3XI3/Jct+28T+pQ1swj/w4LBRWpWN7LA0Y3Kie78qu7dMF3nd4MH+NCLsftnd
	vFORyuNNHtIzvEbudlLQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxngk40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:18:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QAIO07010807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:18:24 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 02:18:21 -0800
Message-ID: <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
Date: Mon, 26 Feb 2024 15:47:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] printk: Add atomic context check inside console_unlock()
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, <pmladek@suse.com>,
        <rostedt@goodmis.org>, <senozhatsky@chromium.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <87plwo5z4k.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lzNiT9SrsIx7z_LR_XkQc73CMGh9MF2q
X-Proofpoint-GUID: lzNiT9SrsIx7z_LR_XkQc73CMGh9MF2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260078



On 2/22/2024 8:23 PM, John Ogness wrote:
> On 2024-02-22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>> Situation of schedule while atomic context can happen in a
>> scenario if CPU-Y executing a async probe of ufs and while
>> printing a line it is started spinning for console lock
>> after preemption disable on CPU-Y and later it got the handover
>> of console lock from CPU-X and in console_unlock() it get
>> schedule with preempt disable as console_may_schedule was one
>> and due to which do_cond_resched was one.
> 
> Nice catch. But I think the below patch is the appropriate fix:

Thanks for the change @john, would you be sending this as proper
patch.

-Mukesh
> 
> John Ogness
> 
> -------8<--------
> Subject: [PATCH] printk: Update @console_may_schedule in
>   console_trylock_spinning()
> 
> console_trylock_spinning() may takeover the console lock from a
> scheduable context. Update @console_may_schedule to make sure it
> reflects a trylock acquire.
> 
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Link: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@quicinc.com
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
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
> +	 * owner may have been scheduable.
> +	 */
> +	console_may_schedule = 0;
> +
>   	return 1;
>   }
>   
> 
> base-commit: e7081d5a9d976b84f61f497316d7c940a4a2e67a

