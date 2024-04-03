Return-Path: <linux-kernel+bounces-129054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDC8963F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A8B1F243ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF70487B6;
	Wed,  3 Apr 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gQRGGJUB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8E645;
	Wed,  3 Apr 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121895; cv=none; b=GOS7b1rcEwPFhSNUrCpVdaNIOdS0Rx2AR4ij+nicb9OCg71zkV61YGgisIaOZwwl3SNdR1J4+NKV9J8yE8/8m3Az9YebrpfaszoMEZl1+bt0dEoyh3u9OZyzsKtnCMeeChSsBSKub2Ci/6JIca1B/u1Cy9z2JXe7dOqEW0bZhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121895; c=relaxed/simple;
	bh=Du0hVYDdHGGGFDiDuT8htJ0z77Z7XYzY9/952kknj2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JpbSymFtcFFLz1Gkc6ev/47fINUv6DPvTVaXpyRl6wZyBMQ7AYUj6MnYfTGuIW1dLPShOjr8QfDKzN4mv0uEIb43DsQg3530V9qmNBkRkhFkzDE+NQT9FwLpufVX3P+ORn6xL/0sBy0kYUbe0Xz2Xv8cXV6BeS6Sx19JQ3EF9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gQRGGJUB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4332l8Ul006839;
	Wed, 3 Apr 2024 05:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2Wc/XbMDySl7R/TtBB5r3KsAe9bMPmhTTdW6c2sQWGI=; b=gQ
	RGGJUBpduVpOwFaNd8HSBNq91NXpI6QaEiaDkOchfyz89Dp35ypuSOP5YaEpSWjn
	PHdaiJUeqeJXeKcxB30wIsQVvtPffw82cdr5EFWHQr12wWYvKfmbcRFAs3N6oDuC
	8J3EKyuWLOiim8UXgTwDHMCz4jkd9CxmfuoVgX6IG65A3XHkwI1oPyliNt/1iGVA
	5v/IVI9iLueCB6MyIt3lmFo3RIaLkgaN7zOjJ1oJAJJ6mJ76SdKLISyqBDPIsuRs
	B5xKzjx0X1a6099PiBwLx4V7Tc9EThnWYdBv5n9EvJJwj1DYnjYZmvHv1PBZ5vrK
	LnX+ZQnpdD7LgD5fTJlw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ua70jnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 05:24:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4335OYnn017242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 05:24:34 GMT
Received: from [10.216.63.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 22:24:28 -0700
Message-ID: <39010f95-b08f-4a57-b3af-f34eb1069865@quicinc.com>
Date: Wed, 3 Apr 2024 10:54:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Content-Language: en-US
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
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
 <20240326113253.3010447-3-quic_kriskura@quicinc.com>
 <20240402233218.5kngtj56qellnrmo@synopsys.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240402233218.5kngtj56qellnrmo@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XSgbQFluxKfjXYTIj7h0H3Llybu0LODQ
X-Proofpoint-GUID: XSgbQFluxKfjXYTIj7h0H3Llybu0LODQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030034



On 4/3/2024 5:02 AM, Thinh Nguyen wrote:
> On Tue, Mar 26, 2024, Krishna Kurapati wrote:
>> All DWC3 Multi Port controllers that exist today only support host mode.
>> Temporarily map XHCI address space for host-only controllers and parse
>> XHCI Extended Capabilities registers to read number of usb2 ports and
>> usb3 ports present on multiport controller. Each USB Port is at least HS
>> capable.
>>
>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>> and num_usb3_ports. The intention is as follows:
>>
>> Wherever we need to perform phy operations like:
>>
>> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
>> {
>> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>> }
>>
>> If number of usb2 ports is 3, loop can go from index 0-2 for
>> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
>> if the first 2 ports are SS capable or some other ports like (2 and 3)
>> are SS capable. So instead, num_usb2_ports is used to loop around all
>> phy's (both hs and ss) for performing phy operations. If any
>> usb3_generic_phy turns out to be NULL, phy operation just bails out.
>> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
>> phy's as we need to know how many SS capable ports are there for this.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>   drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/dwc3/core.h |  5 ++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 3e55838c0001..fab7664c12c0 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -39,6 +39,7 @@
>>   #include "io.h"
>>   
>>   #include "debug.h"
>> +#include "../host/xhci-ext-caps.h"
>>   
>>   #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>>   
>> @@ -1879,10 +1880,56 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>   	return 0;
>>   }
>>   
>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>> +{
>> +	void __iomem *base;
>> +	u8 major_revision;
>> +	u32 offset;
>> +	u32 val;
>> +
>> +	/*
>> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
>> +	 * needed to get information on number of ports present.
>> +	 */
>> +	base = ioremap(dwc->xhci_resources[0].start,
>> +		       resource_size(&dwc->xhci_resources[0]));
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
> 
> Looks like you forgot to address some of the comments you said you'd
> update previously if you submit a new version to the series.
> 
> [*] https://lore.kernel.org/linux-usb/af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com/
> 

Apologies. I agree. I was too much focused on acpi removal and interrupt 
cleanup, I forgot the last comment you gave.

Can I send in a separate patch for this ?

Regards,
Krishna,

