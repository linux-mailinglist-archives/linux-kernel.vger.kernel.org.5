Return-Path: <linux-kernel+bounces-29127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F8830941
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495C22840B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7D21A1C;
	Wed, 17 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fjdCBTR5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A721347;
	Wed, 17 Jan 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504239; cv=none; b=awGkU0ztWMDKsPubNJDX/ssMLv6Uciv8oznu+KrJqODqYU5PsPsZFyr63QHrHf1v5lCN5uiM8V5Y1Hj05o4PAoxKEfjBu8H3ar43xZhq0Nn/ZztbxsCnpYNKyoIt60h7e0hF5osmQeUxnI3AEd7+LA8zloN9+BLmApCd7iZLxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504239; c=relaxed/simple;
	bh=ljl/r7N4mer6GGeIK822hYh6EtKqedkeGnD2+fL8RUs=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=UImkq70baC3D/Fx3Ln+HNYIXXVmFzJRbYOk9tOe4f6jQTUrSfBAPj5sUMIP5tO/5DzdVNBx7Q3nPvnWSz6I6w1Dx8eK76QztfxkUvobMfkONQqzPyy3x2QXxUx29t5AOFeML2SPIEiL8ROZNei5dDXNJ0LJbxiTvO/uskoZq0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fjdCBTR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HCHxjW021620;
	Wed, 17 Jan 2024 15:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5CHxUFZ0UAnMZavlQhDmkKevw/uLJ0P1vxfIWqalQFU=; b=fj
	dCBTR5oZZB8BJswD6gPon7YRsXJo1dh7nKi9JBV502mFFiD+Obm9aE8P/51Zc50h
	9BcFWWWXtR8Kjp3jgeq/0KGPjkQbX85XdzYZHSkQ8B4hhEmRKCQSC8RTWfZN1e/m
	UrUmCZVM+oTRyWCj4GstprVy1kN24OqApj9+klp4KRLfRxHTQtr5WUyEOjgSSep3
	5hD2aerGEvJfJeolAcJs4G4yl7iL7H++qONo0eo/FOgefy6WIKK9dG0lwpdd6GoO
	Ga0tP86BG9vy2YQIrJY474WHihcK/lwaNZWRW15R59aUq1cJqWhjelRnqxnURera
	xfiThoLiP9ajneKVSvgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3sc7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:10:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFAWC6028334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:10:32 GMT
Received: from [10.253.79.191] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:10:27 -0800
Message-ID: <2f9aef38-e1b1-4726-89bc-b2c31435984d@quicinc.com>
Date: Wed, 17 Jan 2024 23:10:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_soni@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_souravp@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-2-quic_luoj@quicinc.com>
 <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
 <de0ad768-05fa-4bb1-bcbc-0adb28cb2257@quicinc.com>
 <CAA8EJppeQdB4W8u0ux16pxBBwF_fpt1j-5aC0f849n9_iaaYtQ@mail.gmail.com>
 <6fc9e65a-709a-4923-b0b3-7c460199417a@quicinc.com>
 <1552D7D8-2D1B-4236-A5BF-02B68DC919CB@linaro.org>
Content-Language: en-US
In-Reply-To: <1552D7D8-2D1B-4236-A5BF-02B68DC919CB@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oVhv2JMGDPimJjoskdVFJDHym3chdDiu
X-Proofpoint-ORIG-GUID: oVhv2JMGDPimJjoskdVFJDHym3chdDiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170110



On 1/12/2024 11:03 PM, Dmitry Baryshkov wrote:
> On 12 January 2024 16:40:02 EET, Jie Luo <quic_luoj@quicinc.com> wrote:
>>
>>
>> On 1/12/2024 12:06 AM, Dmitry Baryshkov wrote:
>>> On Thu, 11 Jan 2024 at 17:31, Jie Luo <quic_luoj@quicinc.com> wrote:
>>
>>>>
>>>>>
>>>>>> +                    reg = <0x3a000000 0xb00000>;
>>>>>> +                    #address-cells = <1>;
>>>>>> +                    #size-cells = <1>;
>>>>>> +                    ranges;
>>>>>
>>>>> Put after reg.
>>>> Ok.
>>>>
>>>>>
>>>>>> +                    status = "okay";
>>>>>
>>>>> Drop
>>>> Ok.
>>>>
>>>>>
>>>>> All of above comments apply to your entire patchset and all places.
>>>>>
>>>>> Looking at code further, it does not look like suitable for mainline,
>>>>> but copy of downstream code. That's not what we expect upstream. Please
>>>>> go back to your bindings first. Also, I really insist you reaching out
>>>>> to other folks to help you in this process.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> We will do internal review of the gaps and update the patches as per
>>>> your comments.
>>>>
>>>> Thanks for the review comments.
>>>
>>>   From the first glance, the bindings do not follow upstream principles.
>>> You have all the settings (tdm, port config, etc) in the DT, while
>>> they should instead go to the driver. Well, unless you expect that the
>>> board might need to override them.
>>>
>> Hi Dmitry,
>> The TuratDM configion varies per SoC type, since the ethernet port capabilities of the SoCs vary. So we will have two different TDM configurations for IPQ5332 and IPQ9574 SoC. The driver also will
>> need to support future SoC, so we choose to configure this from the DTSI. The same reason applies to the port scheduler config as well.
> 
> If it differs from SoC to SoC only, it goes to the driver. Point. No other options. Thank you.

Understand it, Thanks for the advise, will move it to the driver code.

> 
>>
>> Thanks for review comments.
> 

