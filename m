Return-Path: <linux-kernel+bounces-117605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81CE88AD12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2F91C370AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFA12F5A8;
	Mon, 25 Mar 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IlJCckWo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4512E1E5;
	Mon, 25 Mar 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387820; cv=none; b=lY7iecpmpuEjhRix9RdfUWOrnw5DWxr790kYXLiYlDpnMRbhiaxvo8C0XP15IRRfexWPWqN5C1t3tp9OmBKFAyNLUdyeKW5xUsuIW+FYR1CY4Qdc3OWfF/+n+o5QMdVnW+rvdj8YeNcUEfuTTSC9iAK+aHHdDghMCc4bK00WbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387820; c=relaxed/simple;
	bh=MZEKCbTRYkyqe+9HBejrDZkLY/jTlsFTwN+TfksBPzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XrxdHuTOdXJQtul1HrtUyL894s0fnR9WRo0ousF5ef+LT43clkIxFcAhu5oMrnok02DWQ2DNZ3RHrBkcPj1/F0n+xVH3qaC/6Jtx17LRGZ2HcPU3ciJdeo6VcVWq2otEbqnrXSfsTFp41l9cX/sjuWMwJPv/Sy7UTDqE4qhbsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IlJCckWo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PExqJv003871;
	Mon, 25 Mar 2024 17:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nKJL2glUN1khhJxllTuVn8romkg29EQEStQj/muOjcg=; b=Il
	JCckWoU67Kqz/FOZCLWvU4Rn+5yl56EFp1UkP+zz/ZHIg+SNYshi3oFgdkpEc6JH
	xZW4/w11pU2d9PYrNdJzbUo5jTLPw4Jc3FZsOunSXBx7ayv7LgKftX6aZoioodyi
	4IQpgAnQ/vNRceFOBjTRVDvC09kqPUNNopnCzvcAm32vTphYAsFTn55Lf/tRouG3
	zunuYK2uYsKTDrqq6eXCoeDm2pbI6iELnj4lUzCJsv8XUOP2NV1Zh8Lk9l/8lAa8
	vCbIDFt8vx3zDcwsJgWdBtzaHWhDcog2NVddYCHmFiOqFS/FOxGTrHMWJFXR11XH
	SxwiaNl+Iwt+0viozAbg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wssrrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 17:30:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PHUALv027223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 17:30:10 GMT
Received: from [10.216.25.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 10:30:04 -0700
Message-ID: <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
Date: Mon, 25 Mar 2024 22:59:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
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
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
 <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fv_zp3OmKnWSlRlXye2O5YSOpWEYu8CD
X-Proofpoint-ORIG-GUID: fv_zp3OmKnWSlRlXye2O5YSOpWEYu8CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_15,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=792 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250101



On 3/25/2024 6:53 PM, Johan Hovold wrote:
> On Mon, Mar 25, 2024 at 06:45:07PM +0530, Krishna Kurapati PSSNV wrote:
>>>> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>>>> +{
>>>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>> +	bool is_multiport;
>>>> +	int ret;
>>>> +	int i;
>>>> +
>>>> +	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
>>>> +	if (qcom->num_ports < 0)
>>>> +		return -ENOMEM;
>>>
>>> Just return 'ret' directly.
>>
>> Sure, will init ret to -ENOMEM and return ret here. >
Hi Johan,

> I meant that you should return whatever error dwc3_qcom_find_num_ports()
> returns, so perhaps something like:
> 

Got it. Any error that might come up in interrupt reading as well.
> 	
> 	ret = dwc3_qcom_find_num_ports(pdev);
> 	if (ret < 0)
> 		return ret;
> 
> 	qcom->num_ports = ret;
> 
> It looks like dwc3_qcom_find_num_ports() can also return 0 (e.g. on
> malformed DT), which also needs to be handled somehow. I missed that
> earlier.
> 

 From what I remember, Konrad mentioned that we might not need to 
support incomplete or improper DT [1]. Also since this is close to 
getting merged, can we take up any changes for Malformed DT handling 
later given that only one or two devices are present and less likely to 
be given a malformed DT.

[1]: 
https://lore.kernel.org/all/c8d77d4f-6696-4dc9-8030-daf1d10b114b@linaro.org/

Regards,
Krishna,

