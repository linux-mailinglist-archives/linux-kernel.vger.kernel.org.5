Return-Path: <linux-kernel+bounces-118743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93C88BEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADADD1C2CA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6A6BFDE;
	Tue, 26 Mar 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kekSt440"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122F679E1;
	Tue, 26 Mar 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447613; cv=none; b=JVdXVH14bCQa64TB36WZ1K7+/ZfZE7O2bvN9cPPOLARf138iCRcxb5njpFb28aHxsWonDlkQC/kjbuBMr9pjSnn6dCnyRRToLxwwj70uP88yQfFh8gmQeDgyv/JoDLjOoaNy2MIyVrczBnY1tJleC1MSluAFbzdTMk5Y+CnhRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447613; c=relaxed/simple;
	bh=e9rjLhsGUsOfk2IfGhHzXVHO0YjmBd4tuhNPwoR2aA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RIs+Nmt0HdCSMGEpqxo+p7sdnUy1UARp4nRI28Iyvj3d1Hvo9594GlwfeUI0gnfDo/yaTuzWBA8peWiWbYYeQKggM+jOghvzis2o7k/npJ1o9SlY3NP9FcPEweu1R7F77SsfxR4fbdWgPERQz5p8hPwytVRwh7Xaa8/tki03hwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kekSt440; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q4H3uq021424;
	Tue, 26 Mar 2024 10:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nl4E2X95msSqYDli7PLf4WrJbHQU3ND3a3UYloS/oY8=; b=ke
	kSt440rECrd8T6/8n7n9ZQFmXiDICyfH8wsdTwmek1033Dsg8BuM9jGNFritb6s2
	T33+P1fu9S3vRs7rS9ZYssojKzCpGDoUyKV9ha8WB7Etwrp7imLntJGl+ItpbrSb
	z/sA8LBlfbYbgjjNywkNxFcab1ayKpiFbATUZQqgWQMMosvqiWF/awGlObxpua6g
	SSdhupI7rUSl2PCA5EKpL/MvnTZHfhDR+WH0MSdnAVz+GQghSnj06kXqVGTw7wb4
	ZNoDCsQiInfKFAU2NDYje+RChAWX4lNjxf4PZ1cvS/vVs3+DlNU/Enqd7pbZTQXQ
	Osnx14AAamMMPVDnVLqw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3j54hf6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:06:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QA6b13017468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:06:37 GMT
Received: from [10.216.2.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 03:06:31 -0700
Message-ID: <ec3bf11a-0dc2-4313-ba93-c81494c4cc38@quicinc.com>
Date: Tue, 26 Mar 2024 15:36:27 +0530
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
 <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
 <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
 <7b4a6d7f-76ad-471f-a178-dc598fbc0e22@quicinc.com>
 <ZgKHNuziNtBhGO9V@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZgKHNuziNtBhGO9V@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zaJxAJd3PocZS3YQVLxelHTILjtXeGGj
X-Proofpoint-ORIG-GUID: zaJxAJd3PocZS3YQVLxelHTILjtXeGGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=867
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260068



On 3/26/2024 1:58 PM, Johan Hovold wrote:
> On Tue, Mar 26, 2024 at 01:41:52PM +0530, Krishna Kurapati PSSNV wrote:
>> On 3/26/2024 1:15 AM, Johan Hovold wrote:
>>
>>> Just change the logic in dwc3_qcom_find_num_ports() so that it returns 1
>>> if "dp_hs_phy_1" is missing, and otherwise you determine the number of
>>> ports by iterating from 2 to DWC3_MAX_PORTS - 1.
> 
>> I made this change and it works. Removed any return value check for the
>> find_num_ports call as it can return only 1/2/3/4 now.
>>
>> ---
>>       irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
>>           if (irq > 0)
>>                   return 1;
>>
>>           irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
>>           if (irq > 0)
>>                   return 1;
> 
> As I mentioned above, these two lookups are no longer needed and should
> be removed.
>   
>>           irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
>>           if (irq <= 0)
>>                   return 1;
> 
> Just assume it's a single port controller unless "dp_hs_phy_1" is
> present.
>   
>>           for (port_index = 1; port_index < DWC3_MAX_PORTS - 1;
>> port_index++) {
> 
> I think this would be more readable if you use port (num) as iterator
> (2..DWC3_MAX_PORTS) as you're returning a number of ports.
> 
>>                   sprintf(irq_name, "dp_hs_phy_%d", port_index + 1);
> 
> Then this would use just "port";
> 
>>
>>                   irq = platform_get_irq_byname_optional(pdev, irq_name);
>>                   if (irq <= 0)
>>                           return port_index;
> 
> And return "port - 1" here.
> 
>>           }
>>
>>           return DWC3_MAX_PORTS;

Ok,Thanks.

With the above fixed, can I put your RB tag given on [1] or will you be 
providing another one. Asking because when you gave that RB, this 
malformed DT thing wasn't there. So wanted to check with you before 
pushing the code.

[1]: https://lore.kernel.org/all/ZgFyukBXIIwZo7v-@hovoldconsulting.com/

Regards,
Krishna,

