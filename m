Return-Path: <linux-kernel+bounces-15567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7D822E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC9B282369
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A2199A3;
	Wed,  3 Jan 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g6r72Mg7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE658199A1;
	Wed,  3 Jan 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403CodgQ024175;
	Wed, 3 Jan 2024 13:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UWJ90LIME1XzWO5cBDuJMoi+6benRWtHT0r3Z7pU7zU=; b=g6
	r72Mg7x9X1ptxDGTWNnlUhPUXWtk9n2esScmj+LV9mozQb8K2SzAHBYd/2Cqoboo
	ltxP5y9yTcQGLxzx4m7ZdRO8eTyoRXr15maWp1fJj5HHWhFPYfMHiaBalgWv3jfS
	RMjyJjbHpXvW5eIupUF8GoaBjffbbnVBToZyd536+5hw/u5RVfS1ME9vAkpCRCvU
	wxxloDc6HYbMtnLXrSLA4hCDp2u23I+Ux8vcV63fa7wMUM/Z3Xbq2W2X/Pf9SQLQ
	0lVAwwMjxguKpcVCCBw/WsrLnhMdfTJNmst2vIbdRz0p7DdQy/I/7SdgEl6b4OXN
	8Z5NdlzBBEHLQxYVd1OA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd37y8ust-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:27:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403DRVjD025869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:27:31 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:27:27 -0800
Message-ID: <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
Date: Wed, 3 Jan 2024 21:27:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <6593e0a3.050a0220.5c543.8e12@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xQI6xzDch7YyNhPSrVynq9UD-EAvcC7I
X-Proofpoint-ORIG-GUID: xQI6xzDch7YyNhPSrVynq9UD-EAvcC7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030111



On 1/2/2024 6:08 PM, Christian Marangi wrote:
> On Tue, Jan 02, 2024 at 09:57:48AM +0000, Russell King (Oracle) wrote:
>> On Mon, Dec 18, 2023 at 11:01:03AM +0800, Jie Luo wrote:
>>>
>>>
>>> On 12/17/2023 12:09 AM, Russell King (Oracle) wrote:
>>>> On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
>>>>>
>>>>>
>>>>> On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
>>>>>> On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
>>>>>>>> The following is the chip package, the chip can work on the switch mode
>>>>>>>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>>>>>>>> MAC1-MAC4 directly;
>>>>>>>
>>>>>>> Ah, that is new information, and has a big effect on the design.
>>>>>>
>>>>>> This QCA8084 that's being proposed in these patches is not a PHY in
>>>>>> itself, but is a SoC. I came across this:
>>>>>>
>>>>>>     https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
>>>>>
>>>>> The chip mentioned in the link you mentioned is SoC, which is not the
>>>>> chip that the qca8084 driver work for.
>>>>
>>>> So there's two chips called QCA8084 both produced by Qualcomm? I find
>>>> that hard to believe.
>>>>
>>>
>>> The SoC mentioned in the link you provided is the APQ8084 that is introduced
>>> in the link below:
>>> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-processors-805
>>
>> So the one mentioned in the rt-rk article and a load of CVEs is _not_
>> QCA8084 but is APQ8084. Sounds like a lot of people are getting stuff
>> wrong - which is hardly surprising as there are people that seem to
>> _enjoy_ getting the technical details wrong. I haven't worked out if
>> it's intentional malace, or they're just fundamentally lazy individuals
>> who just like to screw with other people.
>>
>> Sigh.
>>
> 
> Hoping to give some clarification with the naming.
> - APQ8084 ("Application" SoC for 8084 family)
> - IPQ8084 ("Internet" SoC version of APQ8084)
> - QCA8084 (Integrated PHYs in the IPQ8084 SoC)
> 
> I guess? >
> Considering QCA8084 is only in in IPQ8084 SoC, the confusion with
> referring to it is in the fact that it's all the same thing, and
> everything related to APQ is also related to IPQ since they are the same
> SoC with minor difference (different DSP, presence of NSS cores)
> 
> I can totally see sencente like "The IPQ8084 PHYs..." referencing the
> QCA8084 PHY.
> 
> (Just to put how the naming is confusing there are PMIC with the
> same exact naming)
> 

There should be NO IPQ8084.
Yes, APQ8084 is the application SoC.
QCA8084 is the pure PHY chip which has quad-phy.

The prefix QCA is the Ethernet device, like qca8081(PHY chip), qca8386(
switch chip) and qca8084(PHY chip).
The prefix IPQ is the internet processor SoC, like ipq5332.

