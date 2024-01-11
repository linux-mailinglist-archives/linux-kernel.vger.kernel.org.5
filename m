Return-Path: <linux-kernel+bounces-23795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6382B1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E118B222D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A54CDFE;
	Thu, 11 Jan 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xj5PU+4T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AC4BAB0;
	Thu, 11 Jan 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDeICA013870;
	Thu, 11 Jan 2024 15:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tLmJlo9a7XOpcogJ276/ISRo79ph673bZD10y+Fx8EM=; b=Xj
	5PU+4TrVzZyncEd26+c6NVlxOQ49eA3PLOmanRaojLh2RWPvZAT09SPWWVftjt3A
	n0TL29mBXoPnAhGzXsJA26PyBYr/3LZSvYMvEvD1qfGPLVyzQErB3ygJaIeqPXXx
	M76HGIcInoeLs/D4ha3D1U8Tn+KZYgGEWCY/eOfzQvFkP86qfjY/gOUFM+vDF+Og
	gEoHGDFsot45kk/ggePlsUazxpyleLE9Jb3QzB9RrDsA3H1vvk0VUMOZYYM9mv+I
	hnzEZH+huEjBh7HVhewOZq+pvuUdHPBUbjcN63lqcIxXg2gLa8+7vAcBOgA7C3Jg
	FFnsFXvn8/HPv66HQoLQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcsk0xhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:30:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BFUu1H001016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:30:56 GMT
Received: from [10.253.37.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 07:30:52 -0800
Message-ID: <de0ad768-05fa-4bb1-bcbc-0adb28cb2257@quicinc.com>
Date: Thu, 11 Jan 2024 23:30:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-2-quic_luoj@quicinc.com>
 <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m18IytmkWCOaHnH4b1m_JtGxV9MuEBgm
X-Proofpoint-GUID: m18IytmkWCOaHnH4b1m_JtGxV9MuEBgm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110121



On 1/10/2024 7:40 PM, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:20, Luo Jie wrote:
>> The PPE device tree node includes the PPE initialization configurations
>> and UNIPHY instance configuration.
>>
>> Ther are 3 UNIPHYs(PCS) on the platform ipq9574, which register the
>> clock provider to output the clock for PPE port to work on the different
>> link speed.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 730 +++++++++++++++++++++++++-
>>   1 file changed, 724 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 810cda4a850f..5fa241e27c8b 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -775,16 +775,734 @@ nsscc: nsscc@39b00000 {
>>   				 <&bias_pll_nss_noc_clk>,
>>   				 <&bias_pll_ubi_nc_clk>,
>>   				 <&gcc_gpll0_out_aux>,
>> -				 <0>,
>> -				 <0>,
>> -				 <0>,
>> -				 <0>,
>> -				 <0>,
>> -				 <0>,
>> +				 <&uniphys 0>,
>> +				 <&uniphys 1>,
>> +				 <&uniphys 2>,
>> +				 <&uniphys 3>,
>> +				 <&uniphys 4>,
>> +				 <&uniphys 5>,
>>   				 <&xo_board_clk>;
>>   			#clock-cells = <1>;
>>   			#reset-cells = <1>;
>>   		};
>> +
>> +		qcom_ppe: qcom-ppe@3a000000 {
> 
> qcom is definitely not a generic name.
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Ok, will update to use a generic name in the link, Thanks for the
guidance and the link.
> 
> 
>> +			compatible = "qcom,ipq9574-ppe";
> 
> I don't see this documented. I don't see reference to posted bindings.

The DT bindings patch was part of the driver series as below. This
property was documented in the DT bindings patch. Attaching it to DTSI 
series should make it more clear. If this is fine, I will update the 
DTSI series with the DT bindings patch.
https://lore.kernel.org/netdev/20240110142428.52026d9e@kernel.org/

> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> Ignoring this warning is a sign you don't really check your patches
> before sending.

We have run the checkpatch.pl on the whole patch series including this
device tree patch set together with PPE driver patch set.
As mentioned above, I will add the DT bindings patch into the DTS
series. This should help with the checkpatch issue.

> 
>> +			reg = <0x3a000000 0xb00000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
> 
> Put after reg.
Ok.

> 
>> +			status = "okay";
> 
> Drop
Ok.

> 
> All of above comments apply to your entire patchset and all places.
> 
> Looking at code further, it does not look like suitable for mainline,
> but copy of downstream code. That's not what we expect upstream. Please
> go back to your bindings first. Also, I really insist you reaching out
> to other folks to help you in this process.
> 
> Best regards,
> Krzysztof
> 
We will do internal review of the gaps and update the patches as per
your comments.

Thanks for the review comments.

