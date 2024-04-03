Return-Path: <linux-kernel+bounces-129180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFD89669D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127F7B24D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA282C7D;
	Wed,  3 Apr 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iV76gXcb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF082D7C;
	Wed,  3 Apr 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129618; cv=none; b=VekOKK46ISUV0z0exHFGBu2X9tMI/3JSEDzrf73VBa7s1FsuzfzjLKeC0nhG1ZqgZbTfSr84ao2qhxPFmhcRuh2ibl7G7/ErIvSpiv82sK/MW5jOvQp+ZouHpGwaKuuZ+a2AA6mG1Wa6LlTxXyWaiq7Ilne4H/W2nuVhco/8Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129618; c=relaxed/simple;
	bh=A/OR6DO71iCj8J60e0zgSTpWmgsrZqjY3mHCSsVS3Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVAL+lr3z2FNzy5PXfaRYajskUpU8KbBIDtgFeSIMjYJQts5kvyMy1V4jQ7AZrQxbQ2dlTOkROxexQIbMVNU521NSj3hnP/Bedc0Ons4rFN5E57Rc5LaQuEcjS4dxOeyt5NNE+Pb2k3VpDAFkMH1OjfwLJOw0/8aM59w1qAsvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iV76gXcb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4334dt9q013313;
	Wed, 3 Apr 2024 07:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+Jw9NbToDRM5ffmq/HmPeRrtpdoCyhAFrW68RwEoAh8=; b=iV
	76gXcbODyTAEhYpCAF3yVID3NTVT6vNT3VFf4qT0sd8UbZCDsck0OlfNxNpfIkFP
	QkV/h95eyGtvqNV9VKIrtpHWgh3/Kx8dLNQqbcv9VXiD5VVDR7iU1MdMZ+99ktuf
	+LfXag/eXd9uVSduXaBWxZJorYFacTmS5XBzNNYfV1v2jNz1r+n0eXwbbJgIX+Z/
	gmaJL+ujz8uhsMy9Kk4KRzQPDRdPW7HtgtF3iueFn9nAHY6VZMMmPDJ3YMPKdnJI
	ev2WbsOaJlGZ8nkrX5CHyasnlhcxWjR+Ai1VyDl5Pqe94SjLBEDBuRhpJPadLnpj
	8/Swf/53OtItQlswyMXw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8xrx0er5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:33:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4337XUI1021948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 07:33:30 GMT
Received: from [10.216.63.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 00:33:24 -0700
Message-ID: <c30811e6-2a1e-4b26-8b94-7c67000b8568@quicinc.com>
Date: Wed, 3 Apr 2024 13:03:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To: Johan Hovold <johan@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>,
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
 <39010f95-b08f-4a57-b3af-f34eb1069865@quicinc.com>
 <Zgz_3AspRRfYqOwZ@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <Zgz_3AspRRfYqOwZ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0TmoQqVEfHcWGL7ekMy2hSYiQF2HMnKF
X-Proofpoint-ORIG-GUID: 0TmoQqVEfHcWGL7ekMy2hSYiQF2HMnKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=875
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030050



On 4/3/2024 12:36 PM, Johan Hovold wrote:
> On Wed, Apr 03, 2024 at 10:54:25AM +0530, Krishna Kurapati PSSNV wrote:
>   
>>>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>>>> +{
>>>> +	void __iomem *base;
>>>> +	u8 major_revision;
>>>> +	u32 offset;
>>>> +	u32 val;
>>>> +
>>>> +	/*
>>>> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
>>>> +	 * needed to get information on number of ports present.
>>>> +	 */
>>>> +	base = ioremap(dwc->xhci_resources[0].start,
>>>> +		       resource_size(&dwc->xhci_resources[0]));
>>>> +	if (IS_ERR(base))
>>>> +		return PTR_ERR(base);
>>>
>>> Looks like you forgot to address some of the comments you said you'd
>>> update previously if you submit a new version to the series.
>>>
>>> [*] https://lore.kernel.org/linux-usb/af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com/
>>>
>>
>> Apologies. I agree. I was too much focused on acpi removal and interrupt
>> cleanup, I forgot the last comment you gave.
>>
>> Can I send in a separate patch for this ?
> 
> The series has not been merged yet so you can address both issues in a
> v19. Perhaps wait a day or two in case Thinh has further comments.
> 

Sure Johan.

Also after making the following two changes:

1. Rename dwc3_read_port_info(...) to dwc3_get_num_ports(...)
2. Changing "if (IS_ERR(base))" to "if (!base)"

Can I still retain your RB tag ?

Regards,
Krishna,

