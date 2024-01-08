Return-Path: <linux-kernel+bounces-19275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C6826AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9481C21D36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80575125C1;
	Mon,  8 Jan 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivMW7d9X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4911715;
	Mon,  8 Jan 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086SBET016678;
	Mon, 8 Jan 2024 09:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+F8oN0qma4p6Z1qwuUBJZxhgmsCOj1+a0cZVSG0F6nA=; b=iv
	MW7d9XQ6s90oKbPs5g3fCeBUJj9sng8+PNoHZmBTJrBx4z0K0BNX1uBa6aO36R3R
	YlJzrPInLUN5FCRMpq4fGMwDhg48/zCCy8sUr9qrz2Daoa2TpPJYexncSdIn4Lds
	OizWKhKL2YyhVsArW673EQak1Q0NQfreNV4vWIikntUVM0SqoWUrj/m8wbcZa2kg
	2GMS6QScsf7t3dWa+HoChTDF6jrvtOojE9ZEsWH9IjK7mJyhzqft0gxstuNvq9oz
	X7OiTcyQLKcefVBfBqdKGEATVVbVJwQM8QFG6WhZQiBJeqJJOjCbRQieJe+MoVXp
	asEL+uA7y2dmQaeMpTow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg97b0jtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:30:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4089UgPb018611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 09:30:42 GMT
Received: from [10.253.76.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 01:30:35 -0800
Message-ID: <f0ccabbd-29db-4a4f-9490-c2ce2cf3e46d@quicinc.com>
Date: Mon, 8 Jan 2024 17:30:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <8ef607b9-1fc6-485b-a6fb-a8d468cc1954@lunn.ch>
 <d639824c-74e2-45f4-bd8a-7e20fad8d61b@gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <d639824c-74e2-45f4-bd8a-7e20fad8d61b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dQOIm-i8d_uHfkJhTNceF3j9HV6VVDc8
X-Proofpoint-ORIG-GUID: dQOIm-i8d_uHfkJhTNceF3j9HV6VVDc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080080



On 1/6/2024 4:14 AM, Sergey Ryazanov wrote:
> Hi Andrew,
> 
> On 05.01.2024 15:52, Andrew Lunn wrote:
>> On Fri, Jan 05, 2024 at 04:48:31AM +0200, Sergey Ryazanov wrote:
>>> Hi Luo,
>>>
>>> thank you for explaining the case in such details. I also have 
>>> checked the
>>> related DTSs in the Linaro repository to be more familiar with the 
>>> I/O mem
>>> layout. Specifically I checked these two, hope they are relevant to the
>>> discussion:
>>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>
>>> Please find my comments below.
>>
>> Hi Sergey
>>
>> There is a second thread going on, focused around the quad PHY. See:
>>
>> https://lore.kernel.org/netdev/60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch/
> 
> Yeah. I had read your discussion yesterday before coming back to this 
> clock discussion. It is a monster chip and looks like you have a hard 
> time figuring out how it works and looking for a good code/DT model.

qca8084 is indeed a little complex, unlike other qcom PHY chips, qca8084
also includes the integrated clock controller that generates the
different clocks for the link of quad PHYs, which leads to some
misunderstanding of the clocks and resets used by qca8084.

i will refer to Christian's code and base on that to propose the DT
model of qca8084 for the review.

I am really sorry for the annoyance and misunderstanding caused by my
patches and replies.

> 
>> Since it is very hard to get consistent information out of Luo, he has
>> annoyed nearly all the PHY maintainers and all the DT maintainers, i'm
>> going back to baby steps, focusing on just the quad pure PHY, and
>> trying to get that understood and correctly described in DT.
>>
>> However, does Linaro have any interest in just taking over this work,
>> or mentoring Luo?
> 
> I should clarify here a bit. I found this discussion while looking for a 
> way to port one open source firmware to my router based on previous IPQ 
> generation. And since I am a bit familiar with this chip family, I chose 
> to put my 2c to make implementation discussion more structured. Long 
> story short, I have no idea about Linaro's plans :)
> 
> If I am allowed to speak, the chosen baby steps approach to focus on 
> pure PHY seems to be the only sane method in that case. Considering 
> Alex's promise, we can assume that the next release will support this PHY.
> 
> -- 
> Sergey

Thanks for help and guidance.

