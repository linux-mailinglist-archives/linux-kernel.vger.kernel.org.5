Return-Path: <linux-kernel+bounces-96448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5663875C52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7E11C21467
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495623753;
	Fri,  8 Mar 2024 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ixC1+1yI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74E1D546;
	Fri,  8 Mar 2024 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864455; cv=none; b=pnETK4wtgiHz/8N6ZDTE3TTzGIUW/jys1brgzZtPk4C96FFL3XLmJuAlrf2OeT/xw49+4ugqNlfzT888v/rvj92jkyOUN+SOv9OBrQCZvYucjAkCEbC2wCwRSyf51l4cHCVGDx/5cQaX1vH3jCjatm45yPgT0L7wiTbXWBsewwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864455; c=relaxed/simple;
	bh=ONyQZRvCP/HCJWQwNXlfeB3yI66BgpAaTiy4XoDfdvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hk4LVlivYrylzR/z0lnG3Lcfx2KjfC7OxipvCz+8LHhoNwfOIUlO98VXzFZoh4F8K/t8r5hF2j3uLEswqJ2qJ4VAp9fjwhaC2RO3BQup5sCImJ9ycFh+fOlIe7JYCEVPsg+lV+bLZP/qHsCfGccIhT7y+ZjzbnT2s/wlrS83aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ixC1+1yI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4280b3ei013431;
	Fri, 8 Mar 2024 02:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ggn59+VUZ502eZ+yrhMbJy5kWfJjMolvlCfwK7wIMM0=; b=ix
	C1+1yIQtiVGZhnWV9g7uf/gA6xQ4ZAn4dDi+0NHDuTgQjrRcTD0GRGspIRIAsZka
	+IZ4FLQ9QRT14Z3es8Wmr2/iownBiBBLLP7Emk2qWgn7GG5XPU/0dOdp7tZqjh32
	lXVumCWNqyiYl/BChNTxNvNQrV90ZVCZJmcBsA2g/YXkZzLGvAyQm3/bgyaQd38F
	vrOJDGMZ0nccin8dGsDnsLl9aGqZurjm3TE2v9sjokNAAA4X+47cTqVwe4bUYf5P
	bVqzVjQ7CvXvSwDsIbdGOltAQ8KvGg3FgH7JudULRCD7bO+zFkOxe5iDSdaPtGI3
	8Tpaxw8VfCX37HMMyrAA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8mgh48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 02:20:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4282Ki7Y021303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 02:20:44 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 18:20:43 -0800
Message-ID: <2d1814fe-c44f-4b56-8b4a-039e30ee949a@quicinc.com>
Date: Fri, 8 Mar 2024 10:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: add function in event of
 workqueue_activate_work
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20240308010929.1955339-1-quic_yingangl@quicinc.com>
 <20240307205044.1caf9fe2@gandalf.local.home>
From: Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <20240307205044.1caf9fe2@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _74jKzR1yYcF4o4yXnG7LuFim4MLbZ_i
X-Proofpoint-ORIG-GUID: _74jKzR1yYcF4o4yXnG7LuFim4MLbZ_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080017



On 2024/3/8 9:50, Steven Rostedt wrote:
> On Fri, 8 Mar 2024 09:09:29 +0800
> Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>> The trace event "workqueue_activate_work" only print work struct.
>> However, function is the region of interest in a full sequence of work.
>> Current workqueue_activate_work trace event output:
>>
>>      workqueue_activate_work: work struct ffffff88b4a0f450
>>
>> With this change, workqueue_activate_work will print the function name,
>> align with workqueue_queue_work/execute_start/execute_end event.
>>
>> checkpatch.pl will report below error for the space:
>>
>> 	ERROR: space prohibited after that open parenthesis '('
>> 	#28: FILE: include/trace/events/workqueue.h:67:
>> 	+               __field( void *,        function)
>>
>> 	total: 1 errors, 0 warnings, 16 lines checked
>>
>> fix this error.
>>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   include/trace/events/workqueue.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
>> index 262d52021c23..a42c1a293459 100644
>> --- a/include/trace/events/workqueue.h
>> +++ b/include/trace/events/workqueue.h
>> @@ -63,14 +63,16 @@ TRACE_EVENT(workqueue_activate_work,
>>   	TP_ARGS(work),
>>   
>>   	TP_STRUCT__entry(
>> -		__field( void *,	work	)
>> +		__field(void *,	work)
>> +		__field(void *,	function)
> 
> Note, please do not follow checkpatch in TRACE_EVENT() macros. It simply
> doesn't understand it. The above is supposed to be similar to structure
> formatting.
> 
> ie:
> 	struct __entry {
> 		void		*work;
> 		void		*function;
> 	};
> 
> 	TP_STRUCT__entry(
> 		__field( void *,	work		)
> 		__field( void *,	function	)
>    	),
> 
> That looks much better.
> 
> -- Steve
> 

thanks for the remind.
send out the v2 as your suggest:
https://lore.kernel.org/all/20240308021818.2306176-1-quic_yingangl@quicinc.com/
> 
>>   
>>   	TP_fast_assign(
>>   		__entry->work		= work;
>> +		__entry->function	= work->func;
>>   	),
>>   
>> -	TP_printk("work struct %p", __entry->work)
>> +	TP_printk("work struct %p function=%ps ", __entry->work, __entry->function)
>>   );
>>   
>>   /**
> 

