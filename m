Return-Path: <linux-kernel+bounces-9382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B081C4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22A71F25B60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876888F7A;
	Fri, 22 Dec 2023 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b9KUqzWZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A28F5A;
	Fri, 22 Dec 2023 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM5odc6026871;
	Fri, 22 Dec 2023 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UocPOG5oicz+zONMdqSbtwpqDsjQA16Icn7wsNmaM4w=; b=b9
	KUqzWZyaeFCrBiRDm956+i5Izz0BO+nvRw/IRFknMasCFLJGFRCJlozaa2C5fdUm
	GIKt7LQ3nkHRJAXM5ygOvgwrvqaqSXrd+BQg0n6EoxLN22lIkkEdP0acdgIaSSaT
	Bfm5J6jL0jOZg8nThxYEThGUwU21O/kVG+nZfJVVJ1/z+pKXnbHkSYvc5FUztp6N
	ur/6ilWC6JJ01Wl3UP2C9OBm5i2/OsiDZySPvdfD3Gg3rKzF3r1i+xrCxBA11Hka
	V/Hr7vqIYBbIEZEKq0H3mNwcu3+5o3wsU9SXP28nlWKXAPZh0x6GtoLI1zP789nn
	jo1CFClCj83n2D/nXxZw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v52sbr7m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 05:59:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM5x75g012067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 05:59:07 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 21:59:05 -0800
Message-ID: <849d0ea9-d4f7-c568-968c-88835f64fadf@quicinc.com>
Date: Fri, 22 Dec 2023 11:29:01 +0530
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman
	<mathias.nyman@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
 <2023121518-uncharted-riddance-7c58@gregkh>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023121518-uncharted-riddance-7c58@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lWVMoZ0QbjR5H-HehkfsGZ4QsG3DIF0b
X-Proofpoint-ORIG-GUID: lWVMoZ0QbjR5H-HehkfsGZ4QsG3DIF0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220040



On 15-12-23 06:12 pm, Greg Kroah-Hartman wrote:
> On Tue, Dec 12, 2023 at 04:55:20PM +0530, Prashanth K wrote:
>> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
>> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
>> which fixes XHC timeout, which was seen on synopsys XHCs while
>> using SG buffers. But the support for this quirk isn't present
>> in the DWC3 layer.
>>
>> We will encounter this XHCI timeout/hung issue if we run iperf
>> loopback tests using RTL8156 ethernet adaptor on DWC3 targets
>> with scatter-gather enabled. This gets resolved after enabling
>> the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
>> the xhci device property since its needed for DWC3 controller.
>>
>> In Synopsys DWC3 databook,
>> Table 9-3: xHCI Debug Capability Limitations
>> Chained TRBs greater than TRB cache size: The debug capability
>> driver must not create a multi-TRB TD that describes smaller
>> than a 1K packet that spreads across 8 or more TRBs on either
>> the IN TR or the OUT TR.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> 
> What commit id does this fix?
>
This doesn't fix any commit as such, but adds the support for 
XHCI_SG_TRB_CACHE_SIZE_QUIRK (which is present in XHCI layer) to DWC3 
layer. I have CC'ed stable kernel for this to be back-ported to older 
kernels (#5.11).

> 
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
> 
> And this is ok if the entry is not present?
> 
We are intending to use this quirk for all the dwc3 based devices since 
the DWC3 XHC needs it. If the entry is not present then we will hit 
stall if certain conditions aren't met (have mentioned the condition in 
commit text).

Thanks,
Prashanth K

