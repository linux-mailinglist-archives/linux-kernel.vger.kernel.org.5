Return-Path: <linux-kernel+bounces-130910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD3F897FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61807288C97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E26BB5C;
	Thu,  4 Apr 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SbuHiJYc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877463F9ED;
	Thu,  4 Apr 2024 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207640; cv=none; b=NIy1wJ6KCbEjsLu83lwzpzhivhvT+sn0rCmf4SGIZliON1zZvazwoggtYPzyD0KnBArc+t/Dzzb2nnfaeeXICEmFeL/kXqrRPTfD/tqCTCmJkxDee8kORIjLqKotZ9Km3mKDGtme9D/FjCyPPbzTKuQiBrdovGVsLhorUmdJVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207640; c=relaxed/simple;
	bh=OhTChy14p9wRne3qtAHp8KnxQ52DXKNP5bqvrfLzwOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/GFeVGIujnP68zXirzQRDtjhwpnN5fpn0Sc2P7sz8HR4JISPqPpAQ3nZg1p/kpWlVlDnqdCcR+mRbpxYoeGDlwLtz7i41cXwDWJ33V19H4zjvWNxh4QDvlOaisbLGoKDXdu13dwvc88sK0C4aGMMf0jFNXi/9Xi+eu4fJg1vF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SbuHiJYc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4343g7pR028500;
	Thu, 4 Apr 2024 05:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HnYROHPooLPttDFxZyDOIstc/a4IOpe2QkEH+FZFT4k=; b=Sb
	uHiJYcZgMHNzS5m77hi/NtLuVdScHZRGPl8SdJqM8dwIjU2GDjDVjagUdhSZFFyO
	X745jmBIwG1XjvrJqLSQEDMGKoNC7czHmvlMTXM0E++hWMCEILehdflSB9+Fqys0
	CPkXmWp+zBnPzYRoS0Z/Wl/WMu5uAkQ37Tf/BL5SlAFP819Tlg6b91DaYM1W2eMi
	CJnfbXcgX7pb2boh/ZfIPixWcpmsdROTXLXDFsfCFw4hHyykh4BxqhbgCca47Vzc
	m8+I4jL2VU4s3chdqbF+nzbHoRL6ixYzPe8eR+Q7WkMQcGMDp25wKbOXjk3sFGJE
	NCWH6kJobMdwEbkqhtEw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep0rmef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 05:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4345Drjw007887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 05:13:53 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 22:13:47 -0700
Message-ID: <fba2474e-31a6-4fef-acf9-7069933584c8@quicinc.com>
Date: Thu, 4 Apr 2024 10:43:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 6/6] arm64: dts: qcom: sm8650: Add video and
 camera clock controllers
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-7-quic_jkona@quicinc.com>
 <CAA8EJppHGS+W-aiXvJ2cE=jCbua8Y0Q+zv_QTs+C9V5+Y1vuZg@mail.gmail.com>
 <008d574f-9c9e-48c6-b64e-89fb469cbde4@quicinc.com>
 <b3464321-0c52-4c41-9198-e9e7b16aa419@quicinc.com>
 <CAA8EJpqDwCVAjDphnC-HdfseMJ-xd8VVxb5+9UcGEcKLcn-heg@mail.gmail.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqDwCVAjDphnC-HdfseMJ-xd8VVxb5+9UcGEcKLcn-heg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gr7qevEuh29CeJwu_US-xLn96ZMODM3
X-Proofpoint-GUID: 4gr7qevEuh29CeJwu_US-xLn96ZMODM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_01,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404040033



On 4/3/2024 9:24 PM, Dmitry Baryshkov wrote:
> On Wed, 3 Apr 2024 at 10:16, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 3/25/2024 11:38 AM, Jagadeesh Kona wrote:
>>>
>>>
>>> On 3/21/2024 6:43 PM, Dmitry Baryshkov wrote:
>>>> On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> wrote:
>>>>>
>>>>> Add device nodes for video and camera clock controllers on Qualcomm
>>>>> SM8650 platform.
>>>>>
>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sm8650.dtsi | 28 ++++++++++++++++++++++++++++
>>>>>    1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>>> index 32c0a7b9aded..d862aa6be824 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>>> @@ -4,6 +4,8 @@
>>>>>     */
>>>>>
>>>>>    #include <dt-bindings/clock/qcom,rpmh.h>
>>>>> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>>>>> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
>>>>> @@ -3110,6 +3112,32 @@ opp-202000000 {
>>>>>                           };
>>>>>                   };
>>>>>
>>>>> +               videocc: clock-controller@aaf0000 {
>>>>> +                       compatible = "qcom,sm8650-videocc";
>>>>> +                       reg = <0 0x0aaf0000 0 0x10000>;
>>>>> +                       clocks = <&bi_tcxo_div2>,
>>>>> +                                <&gcc GCC_VIDEO_AHB_CLK>;
>>>>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>>>>
>>>> The required-opps should no longer be necessary.
>>>>
>>>
>>> Sure, will check and remove this if not required.
>>
>>
>> I checked further on this and without required-opps, if there is no vote
>> on the power-domain & its peer from any other consumers, when runtime
>> get is called on device, it enables the power domain just at the minimum
>> non-zero level. But in some cases, the minimum non-zero level of
>> power-domain could be just retention and is not sufficient for clock
>> controller to operate, hence required-opps property is needed to specify
>> the minimum level required on power-domain for this clock controller.
> 
> In which cases? If it ends up with the retention vote, it is a bug
> which must be fixed.
> 

The minimum non-zero level(configured from bootloaders) of MMCX is 
retention on few chipsets but it can vary across the chipsets. Hence to 
be on safer side from our end, it is good to have required-opps in DT to 
specify the minimum level required for this clock controller.

Thanks,
Jagadeesh

>>
>> Thanks,
>> Jagadeesh
>>
>>>
>>>>> +                       #clock-cells = <1>;
>>>>> +                       #reset-cells = <1>;
>>>>> +                       #power-domain-cells = <1>;
>>>>> +               };
>>>>> +
>>>>> +               camcc: clock-controller@ade0000 {
>>>>> +                       compatible = "qcom,sm8650-camcc";
>>>>> +                       reg = <0 0x0ade0000 0 0x20000>;
>>>>> +                       clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>>>>> +                                <&bi_tcxo_div2>,
>>>>> +                                <&bi_tcxo_ao_div2>,
>>>>> +                                <&sleep_clk>;
>>>>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>>>>> +                       #clock-cells = <1>;
>>>>> +                       #reset-cells = <1>;
>>>>> +                       #power-domain-cells = <1>;
>>>>> +               };
>>>>> +
>>>>>                   mdss: display-subsystem@ae00000 {
>>>>>                           compatible = "qcom,sm8650-mdss";
>>>>>                           reg = <0 0x0ae00000 0 0x1000>;
>>>>> --
>>>>> 2.43.0
>>>>>
>>>>>
>>>>
>>>>
> 
> 
> 

