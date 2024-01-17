Return-Path: <linux-kernel+bounces-29146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52861830991
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51DB1F21970
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC552233C;
	Wed, 17 Jan 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oSxqYj+U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6F21371;
	Wed, 17 Jan 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504629; cv=none; b=UFWSwQ27ArABEy6npPLuNFCtBog4vGarc8qxTN0pC1eWKRNoGm7WsA3hnGkbWHSjIEZ1x6JfjKLAGNSDvy1lxsZo/ybjgj1LXc2xe071MQSCkPzf8oVBukCNX8KPjlnGuXCqvO7mTlsIIEDbSWSGMS2kJXBcatyYaO3nVgMTITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504629; c=relaxed/simple;
	bh=3ZdEKXypmmbGB3+jzQVl4S97Ul5EvkwQQ5lyyqMBHKA=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=S1ZOk5gH76mE/vl6BKp/VytWYx5zgCto+gzoifdhsUvy4PnJbBwkqM4Nmd3h/dVptvCmp1XnNop8F8k/G6cDn9LYXVWbMPPDXzq/f8vJYtoaSg/C4UZmrvazcQbHP3CGCbRRbpSNTEazhJGSJUY8Mx3uSBFg5YqJ6Pdk1h5t9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oSxqYj+U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HDF4OG016847;
	Wed, 17 Jan 2024 15:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=H/urUpIu5jHJviAAMDVnD9ckX9EiLfGNKKbJdBY8XjI=; b=oS
	xqYj+UMlPcvRTVCKFJx2hNpBn6IYIz39mjLSVAsIrRr2nkxWtF36a/hiIKhuvWRP
	00yt8gt/3j0zJlJ8DH4rvG23nPMPuZQvAnEoXfKI3o5mtSZJLELQ0xWsN+rPd5V9
	gP1wzGHF30PXwezDUx3pgDE2VS6+ZI/Zd+8hTAyeRa9bixxG0gSWDQ1IgiyZI8e7
	/nMTd5R5vzfwPXOZU1SaOBOyEo7kWa4r2DaFwZdrw+/67i+is6SF2tOW+wr5DfEf
	B3n1VTbOAEU0hRUA9PdzCORZ8Gq49SlG1YNMMMKqqKLS1zqBCW9KNAXeOrToDOhD
	3vnS41sB2er2KzGQdohw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak1nfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:17:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFH3Gr021555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:17:03 GMT
Received: from [10.253.12.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:16:58 -0800
Message-ID: <01bfb0f6-d657-4007-94ea-df1486ae302e@quicinc.com>
Date: Wed, 17 Jan 2024 23:16:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lei Wei <quic_leiwei@quicinc.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add RDP441 board device
 tree
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luo Jie
	<quic_luoj@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-6-quic_luoj@quicinc.com>
 <3f18b997-46a7-466c-ad89-10dbafe2708d@linaro.org>
Content-Language: en-US
In-Reply-To: <3f18b997-46a7-466c-ad89-10dbafe2708d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6UqnO4Ye5yUUQQAGMw1DLOCrJhmTXq5S
X-Proofpoint-GUID: 6UqnO4Ye5yUUQQAGMw1DLOCrJhmTXq5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=932 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170110



On 1/10/2024 7:57 PM, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:20, Luo Jie wrote:
>> From: Lei Wei <quic_leiwei@quicinc.com>
>>
>> RDP441 board has onboard QCA8386 switch and 10G SFP port.
>>
>> Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 51 +++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> index 846413817e9a..d51968e9d601 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> @@ -12,6 +12,15 @@
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
>>   	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
>> +
>> +	soc@0 {
> 
> Nope, DTS does not define soc nodes.
>
OK, I will remove the soc node in the DTS file. SFP node should not be 
inside the soc node.

>> +		sfp1: sfp-1 {
> 
> Why is this soc? Where is the MMIO address?

Sure, SoC node should not be required. I will remove the soc node.

> 
>> +			compatible = "sff,sfp";
>> +			i2c-bus = <&blsp1_i2c1>;
>> +			los-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
>> +			tx-disable-gpios = <&tlmm 24 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>>   };
>>   
>>   &blsp1_i2c1 {
>> @@ -63,3 +72,45 @@ data-pins {
>>   		};
>>   	};
>>   };
>> +
>> +&qcom_ppe {
>> +	qcom,port_phyinfo {
> 
> Eh... We talk now about basics: please don't post downstream code, but
> first clean it up from all the junk. All the basic issues which you have
> in downstream and which we do not accept upstream.
> 
> I do not believe that this code passed internal review.
> 
> NAK.

Sure, got it. I will follow the upstream principles to use generic node 
name.

> 
> Best regards,
> Krzysztof
> 

