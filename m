Return-Path: <linux-kernel+bounces-27010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB682E919
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724711C224DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F98831;
	Tue, 16 Jan 2024 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SYaLDxUM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070979C3;
	Tue, 16 Jan 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G1lWaC015163;
	Tue, 16 Jan 2024 05:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=V42Z8SUrbPqP5OhNb5NH6DJUc9wRjJ9wK6WKwXhCFSI=; b=SY
	aLDxUMjkTlMXNmVZP6yziJkG9OochgtQ1hHrIsnUmDEawXL3sf7PLnmOcBgb02t9
	R06xAh1Nc+nbZud+maufdqmS+W3+dMq9s2vZE9oXJ25jRr7vmFeqehMsZgztlU9/
	wf1Sttfmpi97UHGWguTp9eycmIYjWv6NdZcCwj55Auur9boe/zctpF77zg6KSb10
	SkB6vnKC4Un0FCil18+hvBvC3tVY5hYjI5jEDyB1T0Cy+SjtVeBLi3x2k1U26joo
	8QYiQ6K22hAxbw3UbUhkLU1osz6/0fZRjZ8RT+LvlNKnWmqsz54/y2Npi8t/Tq7k
	HbyqQ7WH6hkJSEfj1t2w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnb300tvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:09:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G59bnR007352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:09:38 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:09:35 -0800
Message-ID: <d4cbf53c-eb81-1b05-e393-39509aa99d90@quicinc.com>
Date: Tue, 16 Jan 2024 10:39:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
 <c62db276-289e-4a21-8e2f-6a6055e7c4ca@redhat.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <c62db276-289e-4a21-8e2f-6a6055e7c4ca@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YEttWUpq-nHMPwfOCpuZF3sZKzUiiZBk
X-Proofpoint-GUID: YEttWUpq-nHMPwfOCpuZF3sZKzUiiZBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401160037



On 11-01-24 03:46 pm, Hans de Goede wrote:
>> ---
>>   drivers/usb/dwc3/host.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index 61f57fe5bb78..31a496233d87 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>>   
>>   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>>   
>> +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
>> +
> 
> If you do this you also need to make the props array 1 entry bigger (increase
> it from 4 to 5 entries). Before this patch there are max 3 properties added
> and there needs to be an empty terminating property at the end (which
> is what the memset is for). So before this patch props[] needs to have
> 4 entries (which it does) and thus after this patch props[] needs to
> have 5 entire.s
> 
> Regards,
> 
> Hans
> 
Thanks for pointing this out Hans! Didn't change it from 4->5 since we 
had only 4 properties, wasn't aware of the terminating property. Will 
update the patch.

Thanks again
Prashanth K

