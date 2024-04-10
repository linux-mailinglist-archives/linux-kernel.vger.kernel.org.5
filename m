Return-Path: <linux-kernel+bounces-137897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4AE89E921
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48897B2248C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43B168DC;
	Wed, 10 Apr 2024 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hIHHOS9H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5BC8E0;
	Wed, 10 Apr 2024 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724079; cv=none; b=Wsyk5qWG8Vk4+k3+J8/pM5R5NS6kIc9OWZmL6Ry9TpHoYP/Ud+0akN3h/50N3YJ+ZRMYUD0Fs1MYjX+homH9zr8XTWcYhB/5pL7AdmmTUhlIp62TEtKr9cb92AFexcUZJMOcXV7pMEnAyr6NxS+lFzG5p8SwdgDL1kcGO58cZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724079; c=relaxed/simple;
	bh=CvANhkT3bjU8SGaWUSOMNC3pInbPa0QZUBUNA+Qsi5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=reK4I6KMmmh66XZM6MaxZoozsi3LBf9QbHwQoJAyho0yv20LdaJGIShaR5BzEY4XaISD1iMESJDTKW0MX1czhwVicPn5Dz2dZGV3N2kyoj3fU67d8fOv14mJ6MmGK6euePxmYi0fXr483L1VEX96SeGl+NxVF+O4KNauX1iEK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hIHHOS9H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A3VNlw031961;
	Wed, 10 Apr 2024 04:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vJX8hXgmI1cP9JeYXDNUwqcy/x7F81wYrlGr7moQXUA=; b=hI
	HHOS9HM6rxBD1rl75le+W0C4UZfPIzHVPfwv2q9aqatEFsOU60I7ybphe+cjJcGw
	8PKJMfzLuokD5b+HmFxoLj1GKVUQdFXns2Z+w5rXazHrfJJYJTKZ3CXWQZbCTlfi
	/pyYC/0Kj4GIGLIjCxRrV/Xs842wCWsAvZ05e6W16tH827CTfnIOsfHjBeIg8oqG
	1nGwtWvhHJby8dwu65d/CdDFjGch6hkTMEH7ZSxq04Kh5XkE3xUT0DuX9rQzfl/U
	sguyVWSLpMuUgWXh/15PQT6Yivb/dAg9IsxPxlC1ZllI3zQX1JYGmw+buq0UUR2D
	DNlN6eCocMueQqE3Clug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdjxh8axt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:41:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A4f3hH008190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:41:03 GMT
Received: from [10.216.60.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 21:40:57 -0700
Message-ID: <60e569d7-0d63-4b62-b666-1dd7919c8af2@quicinc.com>
Date: Wed, 10 Apr 2024 10:10:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Johan Hovold
	<johan@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com"
	<quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com"
	<quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-5-quic_kriskura@quicinc.com>
 <20240409011046.zgjqvhewldch3snu@synopsys.com>
 <3ab9badd-2cf6-4fe0-aaf0-d08614418968@quicinc.com>
 <20240409181342.wmjvi6rwtxphnv3z@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240409181342.wmjvi6rwtxphnv3z@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d1lbR0JK5Ly33FsAvkn7ErNTNFCqjUpY
X-Proofpoint-GUID: d1lbR0JK5Ly33FsAvkn7ErNTNFCqjUpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100032



On 4/9/2024 11:43 PM, Thinh Nguyen wrote:
> On Tue, Apr 09, 2024, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 4/9/2024 6:41 AM, Thinh Nguyen wrote:
>>> On Mon, Apr 08, 2024, Krishna Kurapati wrote:
>>>> Currently the DWC3 driver supports only single port controller
>>>> which requires at least one HS PHY and at most one SS PHY.
>>>>
>>>> But the DWC3 USB controller can be connected to multiple ports and
>>>> each port can have their own PHYs. Each port of the multiport
>>>> controller can either be HS+SS capable or HS only capable
>>>> Proper quantification of them is required to modify GUSB2PHYCFG
>>>> and GUSB3PIPECTL registers appropriately.
>>>>
>>>> Add support for detecting, obtaining and configuring PHYs supported
>>>> by a multiport controller. Limit support to multiport controllers
>>>> with up to four ports for now (e.g. as needed for SC8280XP).
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 251 ++++++++++++++++++++++++++++------------
>>>>    drivers/usb/dwc3/core.h |  14 ++-
>>>>    drivers/usb/dwc3/drd.c  |  15 ++-
>>>>    3 files changed, 193 insertions(+), 87 deletions(-)
>>>>
>>>
>>> <snip>
>>>
>>>> @@ -1937,6 +2020,10 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
>>>>    	iounmap(base);
>>>> +	if (dwc->num_usb2_ports > DWC3_MAX_PORTS ||
>>>> +	    dwc->num_usb3_ports > DWC3_MAX_PORTS)
>>>> +		return -ENOMEM;
>>>
>>> This should be -EINVAL.
>>>
>>>> +
>>>>    	return 0;
>>>>    }
>>>
>>> <snip>
>>>
>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>> index 341e4c73cb2e..df2e111aa848 100644
>>>> --- a/drivers/usb/dwc3/core.h
>>>> +++ b/drivers/usb/dwc3/core.h
>>>> @@ -33,6 +33,12 @@
>>>>    #include <linux/power_supply.h>
>>>> +/*
>>>> + * Maximum number of ports currently supported for multiport
>>>> + * controllers.
>>>
>>> This macro here is being used per USB2 vs USB3 ports rather than USB2 +
>>> USB3, unlike the xHCI MAXPORTS. You can clarify in the comment and
>>> rename the macro to avoid any confusion. You can also create 2 separate
>>> macros for number of USB2 and USB3 ports even if they share the same
>>> value.
>>>
>>> As noted[*], we support have different max number of usb2 ports vs usb3
>>> ports. I would suggest splitting the macros.
>>>
>>
>> Hi Thinh,
>>
>>   This macro was intended only to identify how many USB2 (or USB3) Phy's were
>> serviced/operated by this driver, not how many logical ports present (like
> 
> That's not what you described in the comment right above the macro...
> 
>> in xHCI). I don't think it would be confusing currently given that it is
>> only used to identify number of generic phy instances to allocate and not
>> used for any other purpose. Once the num_usb2_ports and num_usb3_ports are
>> read by get_num_ports(...) call, they directly indicate how many ports are
> 
> Those fields are clear. But for DWC3_MAX_PORTS, based on the name and
> comment of the macro, it's not clear.
> 
>> HS and SS respectively. Keeping the same in mind, I returned ENOMEM above
>> (as you mentioned) because we don't allocate more than DWC3_MAX_PORTS and if
>> the number of hs or ss ports is more than that, we simply return ENOMEM
>> saying the driver doesn't support operating those many phy's.
> 
> The error code -ENOMEM indicates out of memory failure. The check
> condition dwc->num_usb2_ports > DWC3_MAX_PORTS indicates invalid config.
> There's no allocation in that check.
> 
>>
>>> [*] https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230801013031.ft3zpoatiyfegmh6@synopsys.com/__;!!A4F2R9G_pg!azHqgm92ENkFQrpv6Fhs6PCe210VGOAIrsuGFhrgmfaor8N_kWLu6rxkPpbeCBTLL4NbUpOWlQ0ufmP9DFwO9iFc0XdSEg$
>>>
>>>> + */
>>>> +#define DWC3_MAX_PORTS 4
>>>> +
>>>>
>>>
>>> But it's not a big issue whether you decided to push a new version or a
>>> create a separate patch for the comments above. Here's my Ack:
>>>
>>
>> Since this is not a bug, I would prefer to make a separate patch to rename
>> the macros. (If that is fine).
>>
> 
> That is fine with me. Thanks for your effort pursuing and continue
> working on this series.
> 

Thanks Thinh. If there are no other issues, I will wait till Greg picks 
the series up. Thanks for the reviews throughout the series.

Regards,
Krishna,

