Return-Path: <linux-kernel+bounces-85747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8486BA44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DA1C22837
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277D72902;
	Wed, 28 Feb 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RnhB61uT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0517005A;
	Wed, 28 Feb 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157245; cv=none; b=ZQZ5qjY+P9XTQxPD0MkrLbNSUZcTTHatPI5+XxL/2O+2Xzqp/in9PM6ZqfeGxL1MhKfsP73FOBU/g5BZJU4rJPDqxKr5IbuCcrPXAh6UvyDeroVzzCaN7MHWBN+uQLgJZCmQ1bJiLs6buekGrDzj0n48MAWO+fbnxU9zEdIqi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157245; c=relaxed/simple;
	bh=+udCsYwCCLroqTJ3NW8T4zKSPlLtm2ihTeKdecE4u60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eew427jK8LomOfZiOjrDuzgk5Ygwse73IFcH/ovG0CemtRS62zn851uZv5ErIk83iL0P6P1XGd+2VFX7GJam9tmDvRsJDPJF8rR9bRyK2eGABDnmOeBoPYqKa+iFXP3V412V3/cGBHgA0tSVCozRcGbETuZvVNJoF4v8oq2QSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RnhB61uT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SLJT97011242;
	Wed, 28 Feb 2024 21:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JSVKryuam2bUhRANM9hEqbHjM26jbCrdVMAbYCzj5zk=; b=Rn
	hB61uTdV9vJHvSVXb0KqyGcQMGt0hXenK1PQr6M8JjfFd+wSTHTe+yBVdHDSypcJ
	/kBFHzejDt5Q8A4k3tptMkyYlqgl7OD2N/BHGpa6odBgqSqG7cH/ocsO5u39Hz6J
	ZXClemwhl+aTdMpKMAY+cXj1QshDsgLosAAAkxmAVVl2LNK2+/OkPRZbd2131rgZ
	07DnMAnWDrTYylI855hDo4thtyNI9BKb2PQ/KKmyoH2qiaMRsDLDoL4sdW18hWxf
	L0Vmcb1ll8Nx1XoILYAQcRJS1PhfmIhbywyss72FEucPs+e0Ww2fQdfR8GvbrLtB
	5e/ICk2l45FQ0ugx396w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wja0egdh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 21:53:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SLrlYU015855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 21:53:47 GMT
Received: from [10.110.100.241] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 13:53:44 -0800
Message-ID: <8a5d15aa-96e2-4d9c-9479-bf2ba8fb2a79@quicinc.com>
Date: Wed, 28 Feb 2024 13:53:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
CC: <kernel@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <f38efc6d-20af-4cc1-9b8a-5fcb676b2845@quicinc.com>
 <65df94185a2c1_b2ad829442@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <65df94185a2c1_b2ad829442@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: is35nZS8Glz5KFjqMaUUxVah4K7yuXRb
X-Proofpoint-ORIG-GUID: is35nZS8Glz5KFjqMaUUxVah4K7yuXRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=657
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280174



On 2/28/2024 12:14 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 2/28/2024 7:53 AM, Willem de Bruijn wrote:
>>> Abhishek Chauhan wrote:
>>>> Bridge driver today has no support to forward the userspace timestamp
>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>> time sensitive packets. These changes will allow userspace timestamps
>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>
>>>> Existing functionality of mono_delivery_time is not altered here
>>>> instead just extended with userspace tstamp support for bridge
>>>> forwarding path.
>>>>
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>> ---
>>>> Changes since v1 
>>>> - Changed the commit subject as i am modifying the mono_delivery_time 
>>>>   bit with clockid_delivery_time.
>>>> - Took care of suggestion mentioned by Willem to use the same bit for 
>>>>   userspace delivery time as there are no conflicts between TCP and 
>>>>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
>>>>   RAW and DGRAM sockets interprets it.
>>>
>>> The variable rename churn makes it hard to spot the functional
>>> changes. Perhaps it makes sense just keep the variable name as is,
>>> even though the "mono" is not always technically correct anymore.
>>>
>>   
>>
>> I think a better approach would be to keep the variable as ease and add
>> comments and documentation in the header file of skbuff.h like 
>> how i have done in this patch. The reason why i say this is
>> a. We can avoid alot of code churn just to solve this basic problem of 
>> propagating timestamp through forwarding bridge path 
>> b. Re-use the same variable name and have better documentation 
>> c. Complexity will be as minimal as possible.
>>
>> Let me know what you think. 
> 
> Agreed
> 

Okay i will make the changes accordingly. 
>>> Or else to split into two patches. One that renames the field.
>>> And one that adds the new behavior of setting the bit for SO_TXTIME.
>>>
>>
>> Regarding the sidenote. I dont see how they are using clock_id to determine 
>> if the skb->tstamp is set in monotonic. Please correct me or point me to 
>> the piece of code which is doing so.
> 
> That's really out of scope of this series anyway
> 

Sounds good. Really appreciate your review and discussion on this topic. 
 
>>
>> I hope the check against sock_flag is a better implementation as 
>> it clearly stats and is inline with the implementation that the tstamp is 
>> coming from userspace. 
>> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);
> 
> Enabling the socket flag is not sufficient to configure a delivery
> time on a packet. A transmit time must be communicated per packet
> with cork->transmit_time. And on top of that, it is cheaper to test.


So to re-use the same bit of mono_delivery_time. I want to set this bit 
when user-space sets the timestamps using SCM_TXTIME. 
Is it okay if i do the below when we make skb in ipv4/ipv6 and raw packets
to ensure that bridge doesn't reset the packet tstamp or do you have a better 
suggestion to set the bit so br_forward_finish does not reset the timestamp. 

skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);

