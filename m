Return-Path: <linux-kernel+bounces-10349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA781D332
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1F1F22DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9771BA32;
	Sat, 23 Dec 2023 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="odI4NINX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849CB67E;
	Sat, 23 Dec 2023 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BN8RC7G020528;
	Sat, 23 Dec 2023 08:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d2+7u/3bqorXkghsvV/QI+xuUdz3o4SvpsRMeqbpgNI=; b=od
	I4NINXkUz8RrhoPqPnyx6b5IM8/Va8AWit0HeTPnXhZ3S8vMLY46rQYdUhdtz5VB
	SxLk14Bu0ca1YeSU8LWiTbiECesX4LIm8t5H5rWzXjpNVYgtBM49T9KYtJWIwaeT
	cTmmIGQiOueiDQPGUJZlYVpBvCax408gBU0+vyk76C8j2h/ZroATAhK3qzDNehUx
	7B+lvBa489uqQD/lsRecZwhKtdS5VGtEVNNUJBsnKNi917eXiRTz1DHy0H6lxcJB
	BMk9m+fBokMBCQPPaxH2QwAVeTE8GNyhUyWlc4cN3OeRE/4GsXA8NCco8uwRQ6wi
	HNCVa5xxl93e6Cmao3FA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5pgv8e6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Dec 2023 08:36:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BN8acRf005836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Dec 2023 08:36:38 GMT
Received: from [10.216.46.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 23 Dec
 2023 00:36:35 -0800
Message-ID: <883d18cd-909a-472d-b96f-4f985e092d23@quicinc.com>
Date: Sat, 23 Dec 2023 14:06:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20231219041559.15789-1-quic_kriskura@quicinc.com>
 <20231222223143.kbbni2uqwf4nt3yi@synopsys.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20231222223143.kbbni2uqwf4nt3yi@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IsW2fq0VyBIjNFe8568Q4wq80-zFzXH9
X-Proofpoint-ORIG-GUID: IsW2fq0VyBIjNFe8568Q4wq80-zFzXH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312230065



On 12/23/2023 4:01 AM, Thinh Nguyen wrote:
> On Tue, Dec 19, 2023, Krishna Kurapati wrote:
>> Currently for dwc3_usb31 controller, if maximum_speed is limited to
>> super-speed in DT, then device mode is limited to SS, but host mode
>> still works in SSP.
>>
>> The documentation for max-speed property is as follows:
>>
>> "Tells USB controllers we want to work up to a certain speed.
>> Incase  this isn't passed via DT, USB controllers should default to
>> their maximum HW capability."
>>
>> It doesn't specify that the property is only for device mode.
>> There are cases where we need to limit the host's maximum speed to
>> SuperSpeed only. Use this property for host mode to contrain host's
>> speed to SuperSpeed.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Link to v2: https://urldefense.com/v3/__https://lore.kernel.org/all/20230514145118.20973-1-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!d8OsArNeKYrQqDG89M-Lh-1_c7zIMZp0x1CX6X_m_D2maHEA3QM3qiQV-g4mpb12ZOPT6F8D-ESuCwHxM26peHqe5jtIkQ$
>> Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20230512170107.18821-1-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!d8OsArNeKYrQqDG89M-Lh-1_c7zIMZp0x1CX6X_m_D2maHEA3QM3qiQV-g4mpb12ZOPT6F8D-ESuCwHxM26peHoSWlLDaw$
>>
>> Discussion regarding the same at:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/__;!!A4F2R9G_pg!d8OsArNeKYrQqDG89M-Lh-1_c7zIMZp0x1CX6X_m_D2maHEA3QM3qiQV-g4mpb12ZOPT6F8D-ESuCwHxM26peHqdyS2ZMQ$
>> ---
>>   drivers/usb/dwc3/core.c | 12 ++++++++++++
>>   drivers/usb/dwc3/core.h |  5 +++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index b101dbf8c5dc..056ba95d9295 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1367,6 +1367,18 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   
>>   	dwc3_config_threshold(dwc);
>>   
>> +	/*
>> +	 * Modify this for all supported Super Speed ports when
>> +	 * multiport support is added.
>> +	 */
>> +	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
>> +	    (DWC3_IP_IS(DWC31)) &&
> 
>> +	    dwc->maximum_speed == USB_SPEED_SUPER) {
>> +		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
>> +		reg |= DWC3_LLUCTL_FORCE_GEN1;
>> +		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
>> +	}
>> +
>>   	return 0;
>>   
>>   err_power_off_phy:
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index efe6caf4d0e8..e120611a5174 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -172,6 +172,8 @@
>>   #define DWC3_OEVTEN		0xcc0C
>>   #define DWC3_OSTS		0xcc10
>>   
>> +#define DWC3_LLUCTL		0xd024
>> +
>>   /* Bit fields */
>>   
>>   /* Global SoC Bus Configuration INCRx Register 0 */
>> @@ -657,6 +659,9 @@
>>   #define DWC3_OSTS_VBUSVLD		BIT(1)
>>   #define DWC3_OSTS_CONIDSTS		BIT(0)
>>   
>> +/* Force Gen1 speed on Gen2 link */
>> +#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
>> +
>>   /* Structures */
>>   
>>   struct dwc3_trb;
>> -- 
>> 2.42.0
>>
> 
> I believe you can also loop through and apply to all 16 offsets of
> register LLUCTL without affecting the controller. Regardless whether you
> will apply that for v2 or keep this version:
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 

Thanks for the review Thinh.

Multiport isn't merged yet. It will be rebased after interrupt cleanup 
and flattening device tree v2 of Bjorn. Once it is merged, I will modify 
this for logic multiple ports.

Regards,
Krishna,

