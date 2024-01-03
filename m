Return-Path: <linux-kernel+bounces-15672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA13822FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8211C213ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759081A737;
	Wed,  3 Jan 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kzSq1G1N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165C1A5BA;
	Wed,  3 Jan 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403CVfJe030588;
	Wed, 3 Jan 2024 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=t3ywbodv99MLGzJ90Zc5rriRMeJOoLGuSei3ncrMzv4=; b=kz
	Sq1G1N7XkK0i0nDevXJy3TWQp1er+JeZZZ3RB9EUQuPk70sb/PsLjpjSrUGIPB4M
	ireRq9WlDVooPw62ipRxlJJ9SUMvrsyBWrlYD8PdHNoQbx5uxwBQ1DJemhpwjtBM
	DKv3uTDksj3TX14oI1s/9c9LUtcU27iKDWHVtq32o1/XqMT6QCgiAQZoJYO5yXbN
	CCxT5NJr0N+PiNrH8jAcACb5WXkh0Bz0g8GwlDErnFL538a4+Mv0Brem3JtzlXA1
	FfyQEjWtSYOu8kidsfxboSx3m2kxEOHVtm/vFCymmeNOp+EahJyeX+USCD29RS25
	Pz64L6bbjkrFH2/967iw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcum1235h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 14:52:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403EqOSg027425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 14:52:24 GMT
Received: from [10.216.35.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 06:52:19 -0800
Message-ID: <814824d9-9509-4b5d-84ad-de0cbf5808a0@quicinc.com>
Date: Wed, 3 Jan 2024 20:22:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andy Gross
	<agross@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
 <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z7O5ULuuphWKyvnzm97uhQPzQJuAP6_L
X-Proofpoint-GUID: z7O5ULuuphWKyvnzm97uhQPzQJuAP6_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=429 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030122


>>>>            interrupt-names:
>>>> -          minItems: 3
>>>>              items:
>>>> +            - const: pwr_event
>>>>                - const: hs_phy_irq
>>>> -            - const: dp_hs_phy_irq
>>>> -            - const: dm_hs_phy_irq
>>>> +            - const: qusb2_phy
>>>
>>> Why qusb2_phy is after hs_phy_irq? In the earlier if:then: it is the
>>> second one.
>>>
>>
>> In v3 as well, the hs_phy_irq is before qusb2_phy interrupt:
>> https://lore.kernel.org/all/20231211121124.4194-2-quic_kriskura@quicinc.com/
> 
> ? How v3 matters?
> 

I was thinking whether I modified the order between v3 and v5 and didn't 
mention in change log and hence I compared with v3. Thanks for the catch.

I made qusb2_phy the second one in the list and pushed v6: 
https://lore.kernel.org/all/20231227091951.685-1-quic_kriskura@quicinc.com/

Can you help provide you review on v6 as well.

Regards,
Krishna,

