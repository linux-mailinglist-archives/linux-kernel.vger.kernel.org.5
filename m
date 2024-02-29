Return-Path: <linux-kernel+bounces-86661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDC86C898
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA32892AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A97CF23;
	Thu, 29 Feb 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="plda7Xki"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0917C0B4;
	Thu, 29 Feb 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207611; cv=none; b=KZnHaI2qkCaUC8/BtMiI7t7nMVJvLdyBqPp5jwmsRu95XpsKGsFAc8cN/7PYq7hd3ISmFy6iLlkWoefr67A1tPrcQZoFJYnOeXVg+KGC3Q2Q4junG4vSZ6XZ9cR3Au9oclD9tNQkJwMsje/CWAxRv5NOgk5yI4gRC/jB2qfW+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207611; c=relaxed/simple;
	bh=GvWVWLTquV50VeGS8lcdohSK4d8IPez41WUK4HwClnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aht4R8VCfxq6cm1+KorNXwpUtzp8iEevA7bKo9WC0+xiFyinjA4SFdKuiVrMRoj7DsSdxFWb0oXiVkeL2GdRIgZPjl4+n9hslW+Lt0/r1xDdOJfqBAy1Ssj8X+n/Yqu8zef/y0Ew771EyNS4sbhTJYufNxDAGup4mRAEzXJPRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=plda7Xki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T69mov007217;
	Thu, 29 Feb 2024 11:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5RofTZ6zZ5MPKdedsQVpM61DlKgL5LvLKNbxwtcXWmQ=; b=pl
	da7XkiSTb2aJ15oLzSoQemL33PMc2Uph7Ka9cbjcp07CLJGqwonICm/PQk7xqh3n
	IvypvqPd7fwHWSx6YkVJiqAZoBNEmYkmwvADNB9vCp0AjGZ+MMxmA5KEBNP6P7FL
	W9mHSiXjJw19ffhBaxXWPJ+kr0J1iDtB/0KM/BG2qPwkrAXsMi1x/76LG0vBagJf
	+q0i4whXIb2wwIB+lm9bNeT1gMnFfdG+5Rj3yT+6DPGsZQZaJYgKDzUNuBLpLgnF
	1+wG3CSlvcCIj/cdbp0HyYNZn1/xaBSWkTpYlTtAROdnKDc0Kbo6h3YQPIwGI7fO
	KqZ5yU+Ews2MzsTnCIAA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjmcx0x38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:53:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TBrIoA031022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:53:19 GMT
Received: from [10.216.13.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 03:53:13 -0800
Message-ID: <c4607aa4-7af7-443f-8ccc-aa4fe3ede3cc@quicinc.com>
Date: Thu, 29 Feb 2024 17:23:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To: Johan Hovold <johan@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-3-quic_kriskura@quicinc.com>
 <ZeBSp0EWnHo8Wbsv@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZeBSp0EWnHo8Wbsv@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8QmluQy7FslCBKekTlrJnCYfQ13XBYC1
X-Proofpoint-GUID: 8QmluQy7FslCBKekTlrJnCYfQ13XBYC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290091



On 2/29/2024 3:17 PM, Johan Hovold wrote:
> On Fri, Feb 16, 2024 at 06:27:49AM +0530, Krishna Kurapati wrote:
>> Currently Multiport DWC3 controllers are host-only capable.
> 
> I already asked you to rephrase this so that it becomes clear that you
> are describing a property of the current hardware (and similar
> throughout the series):
> 
> 	https://lore.kernel.org/all/ZTI7AtCJWgAnACSh@hovoldconsulting.com/

Hi Johan. Thanks for the review.

IMO, the statement is describing a property unique to current hardware, 
that "If it is a multiport controller, it is then host-only capable"

I used the word "Currently" to indicate that "Today, the multiport 
devices present...". Let me know if there is any ambiguity in the sentence.

In v13, I wrote:
"Currently host-only capable DWC3 controllers support Multiport."
You were right. It was ambiguous as it might refer to even single port 
controllers.

So I changed it saying all the DWC3 multiport controllers are host only 
capable.

How about:

"All the DWC3 Multi Port controllers that exist today only support host 
mode"

> 
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
>> +
>> +	offset = 0;
>> +	do {
>> +		offset = xhci_find_next_ext_cap(base, offset,
>> +						XHCI_EXT_CAPS_PROTOCOL);
>> +		if (!offset)
>> +			break;
>> +
>> +		val = readl(base + offset);
>> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
>> +
>> +		val = readl(base + offset + 0x08);
>> +		if (major_revision == 0x03) {
>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else if (major_revision <= 0x02) {
>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else {
>> +			dev_warn(dwc->dev,
>> +				 "unrecognized port major revision %d\n",
> 
> I still think you should merge this with the previous line even if you
> end up with 83 chars.
> 
>> +							major_revision);
>> +		}
>> +	} while (1);
>   
>> +	/*
>> +	 * Currently only DWC3 controllers that are host-only capable
>> +	 * support Multiport.
>> +	 */
> 
> So again, also here, rephrase the comment so that it is clear that you
> are referring to a property of the current hardware.

I put the comment this way to indicate that we don't want to check for 
existence of multiple ports if the controller is not "host-only" 
capable. We should only check for multport support only if we are 
host-only capable. I think the statement clearly tells that "check for 
host-only" configuration before proceeding to check for xhci register reads.

I replied the same on:
https://lore.kernel.org/all/279a54f2-7260-4270-83c7-d6f5c5ba0873@quicinc.com/

And since you didn't mention anything else at this part of code in your 
return reply in:
https://lore.kernel.org/all/ZTYyXhyZN3jBXEfm@hovoldconsulting.com/

I thought this statement was fine to go.

> 
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>> +		ret = dwc3_read_port_info(dwc);
>> +		if (ret)
>> +			goto err_disable_clks;
>> +	} else {
>> +		dwc->num_usb2_ports = 1;
>> +		dwc->num_usb3_ports = 1;
>> +	}
> 

Thanks for the review. Can you help let me know your review on the other 
patches as well.

Regards,
Krishna,

