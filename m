Return-Path: <linux-kernel+bounces-46949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F154A8446C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226091C22CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F21350E6;
	Wed, 31 Jan 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cnQcIM6T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F712DDB6;
	Wed, 31 Jan 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724522; cv=none; b=r6HmkHn5fJcvfixAFW25IzFjQrxYil86h/P6MWQO7wUWfvZFQqfCaHQnfSigydEMwFCUZDIuI4m9EdMK696wu5Lq4OU110h2DFIOnUMZVz6cF6msQdYi1ugbjLVAZIqQZgfxLqaVv0/WT4bRWEUk8NDC1jAEmr19A8l0ApTNinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724522; c=relaxed/simple;
	bh=qo55Ya1zrMut/Ge9/eEA9XjoOSaLw2btqX7Iod2jOuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M15XzhLLwR/P0Na+tNCqp0b+OW+n8xNIdlXo4Ts+1R0QX7XcwaPTwizFEOzHdp4nap6dIclBhH3d3EtaAv+yPd9z/4lUvEstqaTMkd1fnwK2Q9BzmNawUD9wQfOKhLYGGerl6Es08ejQOxm1a/D0oQkeAKzxt6Fgt3k4xC1AEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cnQcIM6T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VHvOti024450;
	Wed, 31 Jan 2024 18:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K988A/nCvY7++Ns1OTEX4DSJbSLU9SSwyLn1Bd2jd5E=; b=cn
	QcIM6TKbIyhDlbdSrs4mqm0RnHiSd+J1nvGHEEA+MzfmerKheIyh1R6hhUa4JlxK
	/Sys+DfUFEhke51NpUur1ICx6EvvR5YEJ1EowAK0kAH7Bjz2I1s08Vuqb5Ql3C52
	YxAeSTbBi4dUyqzvoDiUGJY0bNzXtqqq+XgE9hMwClfeFn5l5YOmqwz089o6flZf
	9iRqDPjxu6l0xu6G5ggI0talwMJQ00G88BmcId01IYnUcpzsXDMSNj7glUHs2+po
	qkd5QZxofbn6JdHYdwkHycPlFi6oA7KGYi6Gkzqi2jrispHKUG7Jq5k884u0PEFi
	PFBomjTsJKO+zDNsX/Ug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vypaq0rke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 18:08:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VI8Z4f014192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 18:08:35 GMT
Received: from [10.216.50.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 10:08:31 -0800
Message-ID: <47bf719c-a5c1-473b-9fa0-8cad84f0721c@quicinc.com>
Date: Wed, 31 Jan 2024 23:38:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
 <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z4UMFwPYct1wO3N9o3unHjTu6_3PUFNS
X-Proofpoint-GUID: z4UMFwPYct1wO3N9o3unHjTu6_3PUFNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=826 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310140



On 1/31/2024 10:33 PM, Maciej Żenczykowski wrote:
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index ca5d5f564998..8c314dc98952 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port,
>>               "Parsed NTB with %d frames\n", dgram_counter);
>>
>>          to_process -= block_len;
>> -       if (to_process != 0) {
>> +
>> +       if (to_process == 1 &&
>> +           (block_len % 512 == 0) &&
>> +           (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
> 

Hi Maciej,

> I'm unconvinced this (block_len % 512) works right...
> imagine you have 2 ntbs back to back (for example 400 + 624) that
> together add up to 1024,
> and then a padding null byte.
> I think block_len will be 624 then and not 1024.
>
> perhaps this actually needs to be:
>    (ntp_ptr + block_len - skb->data) % 512 == 0
> 
> The point is that AFAICT the multiple of 512/1024 that matters is in
> the size of the USB transfer,
> not the NTB block size itself.
> 

Ahh !!  So you mean, since this comes because the host doesn't want to 
send packets of size wMaxPacketSize on the wire, we need to consider the 
length of data parsed so far to be checked against 512/1024 and not 
block length.

But either ways, the implementation in the patch also the same thing in 
a different way right ? Process all NTB's present iteratively and while 
doing so, check if there is one byte left. So if there are multiple 
NTB's mixed up to form a packet of size 1024, even then, both the logics 
would converge onto the point where they find that one byte is left.

>> +               goto done;
>> +       } else if (to_process > 0) {
>>                  ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
> 
> note that ntb_ptr moves forward by block_len here,
> so it's *not* always the start of the packet, so block_len is not
> necessarily the actual on the wire size.
> 

Apologies, I didn't understand this comment. By moving the ntb_ptr by 
block length, we are pointing to the (last byte/ start of the next NTB) 
right as we are fixing in [1] ?

>>                  goto parse_ntb;
>>          }
>>
>> +done:
>>          dev_consume_skb_any(skb);
>>
>>          return 0;
>> --
>> 2.34.1
>>
> 
> But it would perhaps be worth confirming in the MS driver source what
> exactly they're doing...
> (maybe they never even generate multiple ntbs per usb segment...)
> 

Yes they do and we made a fix for that in [1].


> You may also want to mention in the commit message that 512 comes from
> USB2 block size, and also works for USB3 block size of 1024.
> 

Sure. Will update the commit message accordingly.

[1]: 
https://lore.kernel.org/all/20230927105858.12950-1-quic_kriskura@quicinc.com/

Regards,
Krishna,

