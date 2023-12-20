Return-Path: <linux-kernel+bounces-6696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3AD819C48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139181F28F01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F920B21;
	Wed, 20 Dec 2023 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IGSuSdtw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1B20B03;
	Wed, 20 Dec 2023 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK95Ylu025177;
	Wed, 20 Dec 2023 10:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uhhFGihaGd26R0sRUHpGszdFchbJbZ+tsPToykepTJo=; b=IG
	SuSdtw+ZP626NqXnqQXcHE0lzWt8MxPJICiHAFPFll8qgiSrXQar2/s3+9WCimQ0
	Jpe8zDS/bqhcCpbIP2qMyzcuXl9YsjXMpLr8Xa4q1Pdqk6ZhZPc7xXEGJx5Pss7F
	U+3prl+KSaveyd1McldjNzRfEg4pfQbYVqoWSj2OfjdM8iUf/PSyZr5HUmg1d2oH
	xuuTt6UtmBpU9uLYEoLdNAQp9PauTqILA7FtDqzSLS9+lhTl0m+QzP7xcy47vBuN
	CbVsIMPge5k/1C9d4gOGDRsmgBFx7ClEDOVEI9PkgN0UVliYcyKZyOC5uGTMxJeU
	AAM/UdNUDOFSk3iTvgow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v338aca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:08:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKA81wb001394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:08:01 GMT
Received: from [10.253.32.162] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 02:07:55 -0800
Message-ID: <0c416e86-2fd3-4ace-a42f-83c7f4dd25b9@quicinc.com>
Date: Wed, 20 Dec 2023 18:07:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <20231215-gauze-sprinkled-172729f22b6c@spud>
 <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>
 <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
 <af1dff98-a63e-47b3-a709-6f4110a97529@quicinc.com>
 <20231219-childcare-sugar-d1ecde8bd0b0@spud>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231219-childcare-sugar-d1ecde8bd0b0@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BOZj3fUucv2hHInaerU2IgGZJQhhZ2du
X-Proofpoint-GUID: BOZj3fUucv2hHInaerU2IgGZJQhhZ2du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200071



On 12/19/2023 11:47 PM, Conor Dooley wrote:
> On Sat, Dec 16, 2023 at 11:37:08PM +0800, Jie Luo wrote:
>> On 12/16/2023 10:16 PM, Conor Dooley wrote:
>>> On Sat, Dec 16, 2023 at 09:16:49PM +0800, Jie Luo wrote:
>>>> On 12/15/2023 9:41 PM, Conor Dooley wrote:
>>>>> On Fri, Dec 15, 2023 at 08:40:20PM +0800, Jie Luo wrote:
>>>>>> On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 15/12/2023 12:42, Jie Luo wrote:
> 
>>>>>> There is also no enable control for the reference clocks since it is
>>>>>> inputted by the hardware PIN connection, i will update these description
>>>>>> in the DT to make it more clear.
>>>>>
>>>>> Again, this does not justify having custom properties for this clock,
>>>>> as it is no different to other platforms. As far as I can tell, the only
>>>>> thing that a standard "clocks" property cannot convey here is the
>>>>> internal reference. I would suggest that since there is only one
>>>>> internal clock frequency, the absence of this particular clock in the
>>>>> "clocks" property can be used to determine that the reference is the
>>>>> internal on
>>>
>>> I'm surprised you didn't pick up on this, but there are actually _2_
>>> internal references, which I have just noticed while double checking the
>>> binding patch.
>>
>> i noticed this, the reference clock source can be supported by clocks as
>> you suggested here, it is really helpful.
>>
>>> What is the impact of using the 48 MHz or 96 MHz internal reference?
>> They works on the different IPQ platform, 96MHZ internal reference is
>> used on IPQ5018, the internal 48MHZ is used on the IPQ5332, that is
>> same as what you describe above, the different clock source rate is
>> selected as the different register value, then the PLL can do the
>> corresponding config to output the correct clock rate, the external
>> clock source is also same if the clock rate is same, just the different
>> hardware PIN is selected if the external reference source is configured.
> 
> 
> Ah, so there is only one internal reference frequency per device. Then
> my suggestion to use the presence of the clock in the clocks property
> should work, just the fallback to the internal reference is going to
> depend on the compatible.
> 
> Thanks,
> Conor.

The reference clock source is configurable, normally there is the fix
reference clock configured per each IPQ platform, but we should keep
the reference clock source configurable in case of the reference clock
source switch needed in the future.

you are right, the reference clock source can be distinguished by
checking the clock rate and the compatible string.

