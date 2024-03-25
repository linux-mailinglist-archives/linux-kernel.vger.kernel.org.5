Return-Path: <linux-kernel+bounces-117099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDE88A6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BD61F61EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392413D626;
	Mon, 25 Mar 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ctWqtS/t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FC13D521;
	Mon, 25 Mar 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372567; cv=none; b=YecCAVezIhmIj4LrhXxobSJPPRsw39yRnEImmQuQeTfaLjBs7ZgYc1vNfpkzFReIIhdc31eCeAJUrNOMGJC5mPDtf2Vd7btbZGTU3P4+XcyTs/MbAxRaMCIK7TqvUiNeZPLoiEJytbQZhLNTsqmdNjdhK1ZwgzoB74P60esTmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372567; c=relaxed/simple;
	bh=nNVOF1sg+KUd6DPKQy0g4jXiZcI1w7ZflrG+95c8XvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=He4ZfaCtNoPsDXiKWDL+dJOzLo42Iu/64eRFZhGAyc4PO1CVUVdKqQfkvZ9HCEufYWvdjcYczPvO84AE8wtcKurKaOcIoHeSHsED++Cgksf10x3enasVFGrbNDwzn1S1rIqXBgZyZZUFoL9KMICFLGySaUYeA/Hwiy6lgy2BS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ctWqtS/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PBDuHt024803;
	Mon, 25 Mar 2024 13:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yIWoiRzkhWTc07S1nW6rCSlMiBtnuUTRxfidhzxE9oQ=; b=ct
	WqtS/tYo7MBAiY7gTD1oXlDRxqRbPfKpOtXOBgE6SpfEs9U4drvLef6db8CdjqbI
	hWfl7aG7sVbyRVpip8Pec1KK0eLfKrgjdpNpW0rYGdAbKZsWV4oR8AplNhIADEzk
	j+1RAG+BYuLhiuaLN8u2xFBi4OYc96Qwlm17UzWx7qnPR8igqeIcrsZH9Bky/+BS
	ffe7zbzYH/aW3ejZKlhMFSquJKswJrpwGkcwq0oEZuf+roW6O9sTOAEb8NCa+wHu
	+hC2OWuqlLhxUnRb9zSfdpXWL1GiYRvkdBzM+SttMU0eEtCFCeu3FmuH68TPj/Gh
	wMZYEAgs+P0w/MfdsGhw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hsrw2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:15:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PDFw0h030262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:15:58 GMT
Received: from [10.216.25.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 06:15:53 -0700
Message-ID: <135446e7-5667-4ead-b2ab-78350100660d@quicinc.com>
Date: Mon, 25 Mar 2024 18:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
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
 <20240307062052.2319851-10-quic_kriskura@quicinc.com>
 <ZgFze1UXm5vwCjHc@hovoldconsulting.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZgFze1UXm5vwCjHc@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k9vb1_D6GEHZIxdoEmlrXp8dnBk2BcKS
X-Proofpoint-GUID: k9vb1_D6GEHZIxdoEmlrXp8dnBk2BcKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=811 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250073



On 3/25/2024 6:22 PM, Johan Hovold wrote:
> On Thu, Mar 07, 2024 at 11:50:52AM +0530, Krishna Kurapati wrote:
>> Power event IRQ is used for wakeup in cases:
>> a) where the controller is super speed capable and missing an
>> ss_phy interrupt.
>> b) where the GIC is not capable of detecting DP/DM hs phy irq's.
>>
>> Power event IRQ stat register indicates whether high speed phy
>> entered and exited L2 successfully during suspend and resume.
>> Indicate the same for all ports of multiport.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
>> @@ -471,9 +480,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>>   	if (ret)
>>   		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>>   
>> +	for (i = 0; i < qcom->num_ports; i++) {
>>   	/* Clear existing events from PHY related to L2 in/out */
> 
> This comment either needs to be moved above the for-loop or be indented
> one level in.

Ah yes, missed it.
Will move it out of the loop.

> 
>> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
>> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
>> +		dwc3_qcom_setbits(qcom->qscratch_base,
>> +				  pwr_evnt_irq_stat_reg[i],
>> +				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
>> +	}
>>   
>>   	qcom->is_suspended = false;
> 
> With the above fixed:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for the review.

Regards,
Krishna,

