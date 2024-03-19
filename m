Return-Path: <linux-kernel+bounces-107253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A770B87FA01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499781F21E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A67B3EB;
	Tue, 19 Mar 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QyclQmQU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6222339;
	Tue, 19 Mar 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837287; cv=none; b=LzdVvrQdM45+UFQgIV30N/fd9lRFVLJgkTuZzZ7ZO80Rn1HuUlW5jghn0ZiPaySNcuaE7MJyxawWChm6pKNE9Ns8L6CvPchvAZpUQub+bF1uJ32DS2sWBEkIxLVITXYpXxTmVPS2FGSHtJm3b5zqvLRDSBIVlA1skt4+82dbszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837287; c=relaxed/simple;
	bh=pZCwEcBu5MwlxyM1kCa+BjpqXn0IzjmWygFH2xHMQG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b2MDgS1oC4QeBOXkvUGwzFVdAzWyQaCP+fSyCRYZcsmnaYdJiAJKHaCvRw9a85eCAEyTTPF73S/9SwsLkffBiCM52pIFWpNL6S2NK0MfSYxmek/DEM/vMmJUUNFvDoRYImecs8MyvQEZMJTd6q5QvPMeQeHsdjMiUj484lXy8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QyclQmQU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J6TTjU024457;
	Tue, 19 Mar 2024 08:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IVuU61o5Z0vG27BocK0lkfi/gc5Z+ncaUAAfauu0R3E=; b=Qy
	clQmQUpDIrL60LNQV9Ai7ZAzAYcyrBaOAj71s2pXUEnvUOOuLCOKT99J0qenlLhq
	2VulOvHprPZl2CeEXq00qb91RLmDrB3cwTGSaMgEZlbjuYKwG+GtAx/sDxMgJnoR
	ZsMIiMj9IKKbM0wsuSRheC3BdKvkOcSG0I99gBvD4TBfBd2v8DWqrQWg0uvLFTzD
	vIKPcI4ecwZ27cHuv3gJvqccwZeFh/grOHE/hgGH5E1asOV5XGzN9SXg3IKmEPx/
	90qLTS/mztPsUcvqMQNQjgrDMT7Pk3OaSlzCRFJNJuRTw/daAW6sf0aiKppKHYA/
	7gRyajBuOqvV15M41OxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2ea0jxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:34:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J8Yesq016125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:34:40 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 01:34:36 -0700
Message-ID: <3e9218a6-5fe7-5506-7ae4-09bace08f844@quicinc.com>
Date: Tue, 19 Mar 2024 14:04:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amrit Anand
	<quic_amrianan@quicinc.com>
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
 <20240311120859.18489-3-quic_kbajaj@quicinc.com>
 <CAA8EJpqMWBWAEUCiJXm0x7zjZYbP8SkRDgu+w+goYjB=8JBN0A@mail.gmail.com>
 <e787706d-b5ef-40bd-9fa8-fed784a9d7b7@linaro.org>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <e787706d-b5ef-40bd-9fa8-fed784a9d7b7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uWoXB43SlU8K_p1wwgxw5qumRekGUsoS
X-Proofpoint-GUID: uWoXB43SlU8K_p1wwgxw5qumRekGUsoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=617 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190065



On 3/12/2024 5:34 AM, Konrad Dybcio wrote:
> 
> 
> On 3/11/24 13:14, Dmitry Baryshkov wrote:
>> On Mon, 11 Mar 2024 at 14:10, Komal Bajaj <quic_kbajaj@quicinc.com> 
>> wrote:
>>>
>>> Enable both USB controllers and associated hsphy and qmp phy nodes
>>> on QDU1000 IDP.
>>>
>>> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
>>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts 
>>> b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> index 89b84fb0f70a..126bc71afd90 100644
>>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> @@ -500,3 +500,27 @@ &tlmm {
>>>   &uart7 {
>>>          status = "okay";
>>>   };
>>> +
>>> +&usb_1 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&usb_1_dwc3 {
>>> +       dr_mode = "peripheral";
>>
>> Are these ports really peripheral-only?

This was done for testing. Will add the usb-role-switch role.

>>
>>> +       maximum-speed = "high-speed";
> 
> More importantly, are these ports really HS-only?

Apologies for this, added it for testing purpose only, forgot to remove it.
Will remove it.

Thanks
Komal

> 
> Konrad

