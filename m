Return-Path: <linux-kernel+bounces-92804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B687262D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81411C2606F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11D17C73;
	Tue,  5 Mar 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CKEN8syb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF018C1A;
	Tue,  5 Mar 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661858; cv=none; b=oVHjrOZyTNANbap3LUdvKaDnQr1WlTDg7ptzGhLPLh9n9nXuvkx1kQzqhx58TYUJDdFpM0+0hZi0JfCbr7SFgwx3AF25FqKS8P8fenuyCVlNfUk+i37RO9KwJcArrSJcHlfY7KemNmAJO3/L2ARNaQ0yL0SeSLCp4Yc/KULfBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661858; c=relaxed/simple;
	bh=dqUZtPhfTjKsrHOwdWIkekVqHbIaeBImvR/LcJF7J0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SpEP7qvzAE+0Jhk4Uz4i3HZTg8DFy+2x7jvXbvvCcpkTTyIjZlVjRc/CeVmwOYJG7Jyl/p0x5YbA0pzlCzgGoDaMWS16R/deeq8jv5wgKTtHPCGgKKy69F7kmiAhTECIGdD4r3vW+ISHEt9ke2JYddPLrXcYo4/shghh6nisoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CKEN8syb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425E08hZ016953;
	Tue, 5 Mar 2024 18:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nS+/iN+G7XmHl6VDOkJtxXIt3NLLmUUH9/CYdvOJAW0=; b=CK
	EN8sybyvcBJJDspqfTVDQmxqlZsLJbZKh2ins91kOlUGOI0zydCckoaxx90c4bAQ
	y39wSXpGz19UStQ90xRibZqof9gMZIhr0OYZLX0hbdr9BSLOH3OFtuIus1/QGdk/
	LyUpwZQuyjabIDUcuIMVRCQ8SoBL6E/WOK8jgePZcCshxNSh62ecr9HSNTyKj+f3
	BtDcytt2pDQQHbM185JDoOh3GZB342A+LbzJPGZa4YXxVyxUyk9PbSCmHsXybdH0
	tQABHALvCrOsoHYfhauwPDiifqf7fgI+a6mBfi82Qe/cEd3sW2NWEJLBEwf5xaYs
	/ZOmljcSOc+hCQjBOptg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp04618cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:04:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425I41rw002672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:04:01 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 10:03:54 -0800
Message-ID: <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>
Date: Tue, 5 Mar 2024 23:33:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for
 firmware managed resources
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_psodagud@quicinc.com>, <quic_nkela@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <ulf.hansson@linaro.org>,
        <sudeep.holla@arm.com>, <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
 <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JFe8K7NNoxsjQ6Lf6KJd1yzrCnww_POq
X-Proofpoint-GUID: JFe8K7NNoxsjQ6Lf6KJd1yzrCnww_POq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403050143

On 3/5/2024 10:38 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 17:57, Sriram Dash wrote:
>> Establish the channel and domain mapping for the power domains to connect
>> with firmware, enabling the firmware to handle the assigned resources.
>> Since these delegated resources will remain invisible to the operating
>> system, ensure that any references to them are removed.
>>
>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
>>   1 file changed, 77 insertions(+), 19 deletions(-)
> 
> Do not mix DTS patches with submissions to netdev or USB.
> 
> Please put it inside your internal guides, so you will not be repeating
> this over and over.
> 

Sure. Will take care. Thanks.

>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> index 26ad05b..b6c9cac 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> @@ -764,8 +764,18 @@
>>   };
>>   
>>   &usb_0 {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&usb0_en_state>;
>> +	/delete-property/ clocks;
>> +	/delete-property/ clock-names;
>> +	/delete-property/ assigned-clocks;
>> +	/delete-property/ assigned-clock-rates;
>> +	/delete-property/ required-opps;
>> +	/delete-property/ resets;
>> +	/delete-property/ interconnects;
>> +	/delete-property/ interconnect-names;
>> +
>> +	power-domains = <TODO>, <TODO>;
> 
> This wasn't even tested.
> 

This is tested with the specific power domains in place
of <TODO>. SCMI interface is used for the power domains.

> Best regards,
> Krzysztof
> 

