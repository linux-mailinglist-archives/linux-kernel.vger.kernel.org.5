Return-Path: <linux-kernel+bounces-107251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16C87F9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5F9B21409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1F5916D;
	Tue, 19 Mar 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JmfkNZQ1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474C22339;
	Tue, 19 Mar 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837194; cv=none; b=Dj1ckvNGfyyYqU+NZ7CD6/bE5F5/7cz2c/sGHR/xy3dNVP/Ph8jICQntocV2sCOzvoYrOq2wrZwz+1oV8UvIk16kWDZnVrRgfru0HcUvxlMArxbmAmGwnfqbHc68h7U45v8ZE01cj7IfkoJ5D9zUDuVl1nkBNEopM1wEXuMMyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837194; c=relaxed/simple;
	bh=1ou2XXyi1rO+bYtRHCGO1C0JLqxiv+m/3Ry65HoGOUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eBmNcoMMp1MUGLZHiupG7XTfInyGJzOxQ7irrEPZyxE/eH21ZXw3qNX9GCloPm05RAq8gCKTuHz0wKOBbWp5Ou3Z8zEl82wCtkZJWuCo4xzFZw9m0pUZ9yBIIvPkg87LNSy4pMUQsglWVK7fmN7ZYIfRNdpCSD3f2G2NFc7zP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JmfkNZQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J8K1JU007819;
	Tue, 19 Mar 2024 08:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3Zt1awt1T6SRasVEZXyc+5dhLlQCbvt7ACXvzKb1pVU=; b=Jm
	fkNZQ1NB6Ke/ftQmBcZBPRS2segsON8ZOAD+EMIo9qlXtw9X4XYUrXA/KE+NWLuT
	BUJxfID73hEx73VzlXp0DQV5/+ea4bNjeXVCYoePF9s+t2+Ysg6BeVP2pTCkQAfZ
	h+bpvsqREQd6WvLw0U/BO7AGtLaveFYM0nBxi03JZmV2HOBR4gt4qfNNJIv4ZPSj
	qdSuzXljJtyqLJQJDg/I/bwXQ5LAintlWSB3QlzDH+WaJuHhknhtxUEBaikbyxGm
	zUldViMt3iFA/hf5bcP7BoBJnycVRx7TzZXt/jqrxZNIW/aFPzHNh9Dd/UBJQYhc
	+LhumMvI1Je6n5DqMG7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2e9gjr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:32:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J8WufI014111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:32:56 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 01:32:52 -0700
Message-ID: <3e79ae3d-a032-75f7-48a4-513688ca139d@quicinc.com>
Date: Tue, 19 Mar 2024 14:02:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] arm64: dts: qcom: qdu1000: Add USB3 and PHY support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amrit Anand <quic_amrianan@quicinc.com>
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
 <20240311120859.18489-2-quic_kbajaj@quicinc.com>
 <db09be58-f6e4-40aa-b558-5b2472c94747@linaro.org>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <db09be58-f6e4-40aa-b558-5b2472c94747@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1AGmW-x0hAVgt46wkQLaCm6Vzc5shJLh
X-Proofpoint-ORIG-GUID: 1AGmW-x0hAVgt46wkQLaCm6Vzc5shJLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=653 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190065



On 3/11/2024 10:02 PM, Krzysztof Kozlowski wrote:
> On 11/03/2024 13:08, Komal Bajaj wrote:
>> @@ -6,6 +6,7 @@
>>   #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>>   #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -913,6 +914,124 @@ opp-384000000 {
>>   			};
>>   		};
>>
>> +		usb_1_hsphy: phy@88e3000 {
>> +			compatible = "qcom,qdu1000-usb-hs-phy",
>> +				     "qcom,usb-snps-hs-7nm-phy";
>> +			reg = <0x0 0x088e3000 0x0 0x120>;
>> +			#phy-cells = <0>;
>> +
>> +			clocks =<&gcc GCC_USB2_CLKREF_EN>;
>> +			clock-names = "ref";
>> +
>> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		usb_1_qmpphy: phy-wrapper@88e5000 {
> 
> That's a phy, isn't it? So node name "phy".

My mistake, will correct it.

Thanks
Komal

> 
> Best regards,
> Krzysztof
> 

