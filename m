Return-Path: <linux-kernel+bounces-24833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AC82C32D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309591F251B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC817316A;
	Fri, 12 Jan 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kbxrpbff"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F36EB6E;
	Fri, 12 Jan 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CFvDN5008091;
	Fri, 12 Jan 2024 15:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=umIvhVQFdfu5j7yWCR+DT9vrCGxIx/eDKZ2S7nS+Eb0=; b=Kb
	xrpbffFOHy8048S/g5bL/2xCxnnqJiPew3btiOGGJJ0Qq2g3FK+378RAxxeCQSCP
	FzEWoaoCmz97io1lwXDylAwu443axuuMTkDVv0pl+g6epHlJGV968zYnr1hxdof/
	gwXJnkwXm1xrCE8kU+d8KfeMHH7ZWA74m7RAMVZLWXFeAr2WVc+fyGBxtpC/6K/2
	geLrzrtHyooraSXtu247LBpNGZZ2B6qm2/RhqHAy2sRIkK+Ok5YvXQHSAwXcXanu
	NvhNUZ/Krirn85LingM7Iy1qczEKVYR7eybTdgWYTSOJmu/XkaV97AF6MXXMzuK0
	PVypmCjxxD450bdYNwmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk43xgjm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:58:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CFwbbU026499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:58:37 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 07:58:33 -0800
Message-ID: <73b3b6c5-5196-49fd-8e42-cc2d3dfbd30c@quicinc.com>
Date: Fri, 12 Jan 2024 23:58:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
 <CAA8EJppB4cDGv1BEfeacPpi37Ut+PLgWvCDeOSj4DU4Q5uC-1g@mail.gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <CAA8EJppB4cDGv1BEfeacPpi37Ut+PLgWvCDeOSj4DU4Q5uC-1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XMZxN6kV2EgeScVyB3cSmk0lnzEPHDhP
X-Proofpoint-GUID: XMZxN6kV2EgeScVyB3cSmk0lnzEPHDhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=687 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120125



On 1/12/2024 12:13 AM, Dmitry Baryshkov wrote:
> On Thu, 11 Jan 2024 at 18:00, Jie Luo <quic_luoj@quicinc.com> wrote:
>>
>>
>>
>> On 1/10/2024 9:35 PM, Andrew Lunn wrote:
>>> On Wed, Jan 10, 2024 at 07:20:56PM +0800, Luo Jie wrote:
>>>> Add the MDIO device tree of ipq5332.
>>>>
>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/ipq5332.dtsi | 44 +++++++++++++++++++++++++++
>>>>    1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> index bc89480820cb..e6c780e69d6e 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> @@ -214,6 +214,38 @@ serial_0_pins: serial0-state {
>>>>                               drive-strength = <8>;
>>>>                               bias-pull-up;
>>>>                       };
>>>> +
>>>> +                    mdio0_pins: mdio0-state {
>>>> +                            mux_0 {
>>>> +                                    pins = "gpio25";
>>>> +                                    function = "mdc0";
>>>> +                                    drive-strength = <8>;
>>>> +                                    bias-disable;
>>>> +                            };
>>>> +
>>>> +                            mux_1 {
>>>> +                                    pins = "gpio26";
>>>> +                                    function = "mdio0";
>>>> +                                    drive-strength = <8>;
>>>> +                                    bias-pull-up;
>>>> +                            };
>>>> +                    };
>>>> +
>>>> +                    mdio1_pins: mdio1-state {
>>>> +                            mux_0 {
>>>> +                                    pins = "gpio27";
>>>> +                                    function = "mdc1";
>>>> +                                    drive-strength = <8>;
>>>> +                                    bias-disable;
>>>> +                            };
>>>> +
>>>> +                            mux_1 {
>>>> +                                    pins = "gpio28";
>>>> +                                    function = "mdio1";
>>>> +                                    drive-strength = <8>;
>>>> +                                    bias-pull-up;
>>>> +                            };
>>>
>>> I don't know why i'm asking this, because i don't really expect a
>>> usable answer. What sort of MUX is this? Should you be using one of
>>> the muxes in drivers/net/mdio/mdio-mux-* or something similar?
>>>
>>>       Andrew
>>
>> Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
>> PINs are used by the dedicated hardware MDIO block in the SoC. I will
>> update the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear.
>> The driver for this node is drivers/net/mdio/mdio-ipq4019.c, it is not
>> related to the mdio-mux-* code.
> 
> Have you read Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
> ? Have you validated your DTSI files against DT schema? How many
> warnings will you observe if you rename the mux_0 node to MDC?
> 
Sorry for this error, we will follow the DTSI validation process and 
update the patch with the right updates after validation, when the patch 
series resumes.

Thanks for correction and the pointer to the tlmm YAML file.


