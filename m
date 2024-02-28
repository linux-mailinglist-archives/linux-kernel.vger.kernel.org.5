Return-Path: <linux-kernel+bounces-84817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB486ABF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491A3282B86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF20381D1;
	Wed, 28 Feb 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WF0LN4nb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BB3770C;
	Wed, 28 Feb 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115166; cv=none; b=X+YunkdejUYXkEJK5tuK6+NIhdQRIrHNDWAO+65lsgpw5c5t6aReu3eijrQ83+5qowVbK8TaxQN3j8TwV8mqHAcHavjJHi17ZmD13NMBROCz+YR2V20JW9ueOAwGT6WS7VHArE/DOz3ZLR/0Ubvhi1WN5vQCcGWlxdgskjX6qKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115166; c=relaxed/simple;
	bh=QtkybHA+dLfb/QVzUjDEIMZVXhkak6pmXpwwKXRPt+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YKXp+wSetyphyUvgbel7FWbAys2ioYoAO9D6eU22qdQBO5QjNKwt+w5EWE4Z22215pxCGLX8UIpMm9g9ESJKUCJAX8zOt00Q8+1SVRjclmWgjwwbQoU7D1OReHlU/bxP/7418S/nUbzXhcjsGHKSx2vbJ9Y4hiDdrFfgJkPIKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WF0LN4nb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S6KrNo022821;
	Wed, 28 Feb 2024 10:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eDhRFVyysNsDGN+FMhkZ93Dyyc7lx1J5zTtYdxW8Axo=; b=WF
	0LN4nbgJEokwn9Uy7ycFHIrs2p5K5ffHcwRvmYTkPvGD4dJbLxBsoK6RTAYrzXmd
	Nqfs46lrWE0UKe74b/7pVCs4cmx3hvcCj/JsPKJFYbK2yHnBChHuKYV+YNgFiF06
	/rARxo03EqRQiQhkkusP0HP6RG9+hcmGzdy7nLQsKDlfM9Dq8factDCd7rHqcgzG
	jXL2sVE3o5keoYXWLs7adIKB9XX0e8gunHoTLPypCH0y5JP00nP8AL7FJap8cz4o
	cQ3Lan/zTSFD1akBS8TMvxZ6UicPtiVXljNNPlgl4QIwJzWsHQ26Up4PZQIx2mu5
	LhfaWsLAnelcVth/1tVg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whuksruj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 10:12:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SACe1Q020988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 10:12:40 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 02:12:37 -0800
Message-ID: <e216ce10-c345-811a-2279-0ef248c9485f@quicinc.com>
Date: Wed, 28 Feb 2024 15:42:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: xhci: Add error handling in xhci_map_urb_for_dma
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240228083343.3101303-1-quic_prashk@quicinc.com>
 <e4f87b6b-4561-8058-3449-2ff9086c81a4@gmail.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <e4f87b6b-4561-8058-3449-2ff9086c81a4@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Mnyt1hv2vzWnDYJ_Yp88sZJ_-e3o_Gc
X-Proofpoint-ORIG-GUID: 8Mnyt1hv2vzWnDYJ_Yp88sZJ_-e3o_Gc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=659 clxscore=1011 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280080



On 28-02-24 02:31 pm, Sergei Shtylyov wrote:
> On 2/28/24 11:33 AM, Prashanth K wrote:
> 
>> Currently xhci_map_urb_for_dma() creates a temporary buffer
>> and copies the SG list to the new linear buffer. But if the
>> kzalloc_node() fails, then the following sg_pcopy_to_buffer()
>> can lead to crash since it tries to memcpy to NULL pointer.
>> So return -EAGAIN if kzalloc returns null pointer.
>>
>> Cc: <stable@vger.kernel.org> # 5.11
>> Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/host/xhci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index c057c42c36f4..0597a60bec34 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -1218,6 +1218,9 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
>>   	temp = kzalloc_node(buf_len, GFP_ATOMIC,
>>   			    dev_to_node(hcd->self.sysdev));
>>   
> 
>     I don't think we need an empty line here.
> 
>> +	if (!temp)
>> +		return -EAGAIN;
> 
>     Not -ENOMEM?
Yea that sounds better, will update in next patch.
Thanks!

