Return-Path: <linux-kernel+bounces-117098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D288A6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4447325E15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0413D51E;
	Mon, 25 Mar 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ClTeA5Pl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2A450EE;
	Mon, 25 Mar 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372534; cv=none; b=BrYZ1L91yTv8GcfNUz09dHRnCZtDRjAOiURgkxvMSq5UqU6ED0Cexy07gVd050nDp8y3/o8iE9PPbRgGnjoM3z6Vi0Vk/qvGKpFpc33FWamHUE9gsdNgr7CPxOp3pv1cswGHJrON5PvZssZR264Lg/orF3m8F2k9E+6bl/kXwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372534; c=relaxed/simple;
	bh=5y3GcYhD+Ve12bEfH7L7G8tw0wf4DxrQppZ1pdLJirM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a6dhk7KBZJqrF+ZkA+w+uWCJcXKMATrLjnCzzUl7XJ6/ZoibA/r24JF0NECv6JRKZ4NrohT7MYlAlBX3G3RwYi7R1jSYo4zC5zGTwi2QRDG2SdgqAhUI/2qYMUmk5VgVX0cnkln6/J3bb3qLS7aAvM3loQZKJTpGgv5Di7XjsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ClTeA5Pl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PAUF9l021175;
	Mon, 25 Mar 2024 13:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6azWjmnjffihgzpQWtVpTkFxRLmZYV1rLUGMd3pxWlY=; b=Cl
	TeA5Pl09dWRxQeUfM+UDQ9vS0pNo+gbsZfz8G2UjrJ/SD32jlwDzH/ZqCjozsE3l
	RWfavQA4psZ4n+5M/3Hpe4LjCXHE9fktvQVLgHSM5NDCMQC5DKSYF0ru842ByusA
	m02jXfbiSPcdDAIB2NdoRA0U4/azT6V+BDCImwTdPFvcN30DWcVq274Nv68BgAma
	uav0vUyAKKaMN6Q4+rIIUDEBa58fO2tSK+6jukBMqQwusCIDphQM4ida0e5b3kxc
	pJN+yqZoOe1h2E+b4v3J1cTL1jvXXMzb7F4p3YhsRujeVf6kMURyDRjDrqxXxIyV
	u/7sDjjHFD5egSTlT2iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hp0v8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:15:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PDFQPt006955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:15:26 GMT
Received: from [10.216.25.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 06:15:21 -0700
Message-ID: <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
Date: Mon, 25 Mar 2024 18:45:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Content-Language: en-US
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
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PJMPZQSc9V_Y73u_UwQPfyE-qKV74QZa
X-Proofpoint-GUID: PJMPZQSc9V_Y73u_UwQPfyE-qKV74QZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250073



On 3/25/2024 6:18 PM, Johan Hovold wrote:
> On Thu, Mar 07, 2024 at 11:50:50AM +0530, Krishna Kurapati wrote:
>> On multiport supported controllers, each port has its own DP/DM
>> and SS (if super speed capable) interrupts. As per the bindings,
>> their interrupt names differ from standard ones having "_x" added
>> as suffix (x indicates port number). Identify from the interrupt
>> names whether the controller is a multiport controller or not.
>> Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
>> along with non-multiport ones accordingly..
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 146 +++++++++++++++++++++++++++--------
>>   1 file changed, 112 insertions(+), 34 deletions(-)
> 
> This is much better. Just a couple of nits below.
> 
>> +static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
>> +{
>> +	const char *irq_name;
>> +	int port_index;
>> +	int irq;
>> +
>> +	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
>> +	if (irq > 0)
>> +		return 1;
>> +
>> +	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
>> +	if (irq > 0)
>> +		return 1;
>> +
>> +	for (port_index = 0; port_index < DWC3_MAX_PORTS; port_index++) {
>> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_index + 1);
> 
> Please use a stack allocated buffer for these strings as we don't need
> them any more after this function returns.
> 

Sure. Will replace this with "char irq_name[14]".

>> +		if (!irq_name)
>> +			return -ENOMEM;
>> +
>> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
>> +		if (irq <= 0)
>> +			return port_index;
>> +	}
>> +
>> +	return port_index;
> 
> I think explicitly returning DWC3_MAX_PORTS here would be more readable.
> 

Will make this change.

>> +}
>> +
>> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	bool is_multiport;
>> +	int ret;
>> +	int i;
>> +
>> +	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
>> +	if (qcom->num_ports < 0)
>> +		return -ENOMEM;
> 
> Just return 'ret' directly.

Sure, will init ret to -ENOMEM and return ret here.

> 
>> +
>> +	is_multiport = (qcom->num_ports > 1) ? true : false;
> 
> And no need for the ternary operator:
ACK.

> 
> 	is_multiport = (qcom->num_ports > 1);
> 
>> +
>> +	for (i = 0; i < qcom->num_ports; i++) {
>> +		ret = dwc3_qcom_setup_port_irq(pdev, i, is_multiport);
>>   		if (ret)
>>   			return ret;
>> -		qcom->ss_phy_irq = irq;
>>   	}
>>   
>>   	return 0;
> 
> With that fixed:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for the review

Regards,
Krishna,

