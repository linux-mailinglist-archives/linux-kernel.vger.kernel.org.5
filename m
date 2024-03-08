Return-Path: <linux-kernel+bounces-96424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1190875BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF889283651
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A922619;
	Fri,  8 Mar 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ITwLt15h"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296645C99;
	Fri,  8 Mar 2024 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860992; cv=none; b=IGwNHjuUcAVfKTqKuO3NXQQ5E/CHo9aMOv8ElnjZHAC5PzDCnXJSR0xOBPplQPxJ7C2HX05s7Th61UQRuNRgIKiE31CEs+tlT1NjQZKzuU8lot0Xxz8hBmz7o7qDfjxEDdTG+rfR9VK9iyUd7rF3UhPSP7/gxtBOmj/1qjWfITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860992; c=relaxed/simple;
	bh=0dv3xxWZmDNpXTtAWUNhAAV8ATrbMSOq1nB+QBhfrBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JqtqJORSnEaFytuz3yzI9VgdldDmbvj/xofS4xc656q3mlhvX7U/AXKwPGCt4wanT0+1f9jzfwy5k2YeNOaNg/l/xJFsJAmBqr6zjNBhk+6qmwzJVKvU1wB2d3xuofvcoViO28x+NxustMtW26pnm3vX6hraGjN6sNVm6/uv/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ITwLt15h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4280MBlm024727;
	Fri, 8 Mar 2024 01:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H1WYce/8MFs5Q989GTZBqxx9XcmYVYcVdgqiDXSu6nk=;
 b=ITwLt15hfORD2M5JLe5WafX7Yd+/Wnl8YAM1AOJTJEwOVKuGz0OhCxYpmaTAY0zx9wd5
 gAqRrBiP5fh2kyv707BJyzG3Sx1UnU92OnpsF29hciMae1al2JlAqdP/aoLuDtteYuvH
 YYMbrk7W0okBYCS/Y+6NA2mtS+v4lh8W5IvwiCDDVibHD0KcZdDV2+lqi7Wf0B0ZJdY3
 ArN93E2kkujqJU9GbqjhePMrxQ74CP7PICe2RRLz1PKAqrfQehGum+qHvwILdezI/xGg
 yqnl23SWPtSPTE/ojQTqtvhOEMeMdx4Te5fMM6qRq8KesGThRuERYsKtDm6RZbxn4x4J Wg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqr2sgvq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:23:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4281LN3x026183;
	Fri, 8 Mar 2024 01:22:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep9bhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:22:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4281Msjs34537948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 01:22:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB992004F;
	Fri,  8 Mar 2024 01:22:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821EE20043;
	Fri,  8 Mar 2024 01:22:53 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 01:22:53 +0000 (GMT)
Received: from [10.61.2.106] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7200360235;
	Fri,  8 Mar 2024 11:53:13 +1100 (AEDT)
Message-ID: <66a2c8b3-b1e8-4d2c-8a19-09e62099a2d7@linux.ibm.com>
Date: Fri, 8 Mar 2024 11:53:13 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: fix uninitialized read of rtc_wkalrm.time
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129073647.2624497-1-nicholas@linux.ibm.com>
 <20240229215850a1990100@mail.local>
From: Nicholas Miehlbradt <nicholas@linux.ibm.com>
In-Reply-To: <20240229215850a1990100@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KQdH1YjVq4O2PEIylo0dRelwFwy3FeDS
X-Proofpoint-ORIG-GUID: KQdH1YjVq4O2PEIylo0dRelwFwy3FeDS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_18,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080009



On 1/3/2024 8:58 am, Alexandre Belloni wrote:
> Hello,
> 
> On 29/11/2023 07:36:47+0000, Nicholas Miehlbradt wrote:
>> If either of the first two branches of the if statement in
>> rtc_read_alarm_internal are taken the fields of alarm->time are not
>> initialized but are subsequently read by the call to rtc_tm_to_time64.
>>
>> Refactor so that the time field is only read if the final branch of the
>> if statment which initializes the field is taken.
>>
> 
> While the problem description is correct, the solution is not because
> you have no guarantee that the fields have been initialized if
> ->read_alarm returns a value different from 0
> 
> So, instead of avoiding the conversion unless the final branch is taken,
> it should be avoided as long as err != 0.
> 
> But, I'm also wondering whether there is actually an issue. mktime64
> can be fed whatever value without bugging out and the value of err will
> be part of the trace so userspace knows that it shouldn't trust the
> value.
> 
> So, what is the actual issue? :)

Thank you for your feedback.
I found this issue during my implementation of KMSAN for powerpc. The 
goal with this patch is to eliminate use of undefined memory which leads 
to undefined behaviour, I should have made this more clear in my 
original message. You can find the KMSAN patch series here:
https://lore.kernel.org/linuxppc-dev/20231214055539.9420-1-nicholas@linux.ibm.com/

I can make the changes suggested and fold this patch into the next 
version of my KMSAN series if that would help to add context as to why I 
am submitting this patch?
> 
>> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>> ---
>>   drivers/rtc/interface.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>> index 1b63111cdda2..f40e76d2fe2b 100644
>> --- a/drivers/rtc/interface.c
>> +++ b/drivers/rtc/interface.c
>> @@ -179,6 +179,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
>>   				   struct rtc_wkalrm *alarm)
>>   {
>>   	int err;
>> +	time64_t trace_time = -1;
>>   
>>   	err = mutex_lock_interruptible(&rtc->ops_lock);
>>   	if (err)
>> @@ -201,11 +202,12 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
>>   		alarm->time.tm_yday = -1;
>>   		alarm->time.tm_isdst = -1;
>>   		err = rtc->ops->read_alarm(rtc->dev.parent, alarm);
>> +		trace_time = rtc_tm_to_time64(&alarm->time);
>>   	}
>>   
>>   	mutex_unlock(&rtc->ops_lock);
>>   
>> -	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
>> +	trace_rtc_read_alarm(trace_time, err);
>>   	return err;
>>   }
>>   
>> -- 
>> 2.37.2
>>
> 

