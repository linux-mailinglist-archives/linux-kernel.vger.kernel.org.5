Return-Path: <linux-kernel+bounces-74258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945C85D1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61945B24CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02583B2AD;
	Wed, 21 Feb 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hVSHjxQQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CA3AC1B;
	Wed, 21 Feb 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501737; cv=none; b=J/zeJmwUZflzAIl55YP87xRGyTy758q0yZfmLDOJXqlY4s8SHb0WaiNxrdvnfoD0O9JkhSMcQjB6rgVCmFeEEJTvY6tU1WPJsq4s1bcJf+ITaGrkvnqjrXNccNYQGBJy+BiKgJ1BQutgcnv2xmLliKy2bHojHme00sn/BiStauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501737; c=relaxed/simple;
	bh=DyefNGyJot+9bYQRJs7eQJj6qpNPNpJZyuKDTIqA+XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G08cAAzfCxDoO2IXE4FpHwjcVVD63jTqZDssIfPaLQE7QbyUhDABq/kuC+8zO7JBkn//CmkSeb+Gmc0AjJOu/HFn2m3BeZRWrTCP8GPZ+ovZhWpkCofKLIAaBcoOI2qjdZyoNA5AtPRhoXk0kXTK28Y6KOv5l45K4u7D4Wbs7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hVSHjxQQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7QmEn006711;
	Wed, 21 Feb 2024 07:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LtrBtft7kSK9yrD2hBrFQxjX8fgBwaWSgjgiv3Nz1Tw=; b=hV
	SHjxQQuOXIX9IO6hrf1bHrpGvhw4KJ8CdVHRVaWrFjxPUGGrY88b1DZW+s2Unp8Y
	M/lCX4IEIwNvFaeowpwSu0BLN/GGQlHsroJC9LhyTIsTQhy3dQ9m1cvh/AGJegso
	rttQYDPcK89xD3CHSf42sFrFlx/tWnCE6Wdl9yTXtWrsCDHtHND70ZoZ2W9azsFZ
	hdYeBb0F57orw+crzd1nZz3m070oUFOtvR46FgouPG/hAnip3q+buOFrV4/wyBRL
	7F3ahrLvLZVdwu28BAU2s5VYwso+8kCUCuaDsRiesEnsWbfOr2lWCm6XD31X5LZD
	e4/KgtFlPPEyG8XzlfKQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd23619dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 07:48:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L7mR1W024735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 07:48:27 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 23:48:22 -0800
Message-ID: <022d4f04-6392-4009-bf06-2781af9a44a0@quicinc.com>
Date: Wed, 21 Feb 2024 15:48:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: qcom: sm8550-aim300: add pmic glink
 port/endpoints
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-16-quic_tengfan@quicinc.com>
 <e3e27fec-8ab9-4331-a5aa-2958dd630b11@linaro.org>
 <420ce17d-279e-47ee-9935-35bc03b89f98@quicinc.com>
 <CAA8EJpqoUBbq52EHPK+TYC67RzRJt9pnDwLA1SrFdPmXxyG3dg@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpqoUBbq52EHPK+TYC67RzRJt9pnDwLA1SrFdPmXxyG3dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 44GA_E3_S5W-RwhkZRsoJIy-XHZL0KB_
X-Proofpoint-ORIG-GUID: 44GA_E3_S5W-RwhkZRsoJIy-XHZL0KB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=926 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210059



On 12/13/2023 6:04 PM, Dmitry Baryshkov wrote:
> On Tue, 28 Nov 2023 at 10:11, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>>
>>
>> 在 11/17/2023 6:32 PM, Dmitry Baryshkov 写道:
>>> On 17/11/2023 12:18, Tengfei Fan wrote:
>>>> Add nodes to support Type-C USB/DP functionality.
>>>>
>>>> On this platform, a Type-C redriver is added to the SuperSpeed graph.
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 88 +++++++++++++++++++++-
>>>>    1 file changed, 87 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> index 6dc3040b9f76..f3c558dd40f1 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>> @@ -100,7 +100,15 @@
>>>>                        reg = <1>;
>>>>                        pmic_glink_ss_in: endpoint {
>>>> -                        remote-endpoint = <&usb_1_dwc3_ss>;
>>>> +                        remote-endpoint = <&redriver_ss_out>;
>>>> +                    };
>>>> +                };
>>>> +
>>>> +                port@2 {
>>>> +                    reg = <2>;
>>>> +
>>>> +                    pmic_glink_sbu: endpoint {
>>>> +                        remote-endpoint = <&fsa4480_sbu_mux>;
>>>>                        };
>>>>                    };
>>>>                };
>>>> @@ -519,6 +527,62 @@
>>>>        };
>>>>    };
>>>> +&i2c_master_hub_0 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&i2c_hub_2 {
>>>> +    status = "okay";
>>>> +
>>>> +    typec-mux@42 {
>>>> +        compatible = "fcs,fsa4480";
>>>> +        reg = <0x42>;
>>>> +
>>>> +        vcc-supply = <&vreg_bob1>;
>>>> +
>>>> +        mode-switch;
>>>> +        orientation-switch;
>>>> +
>>>> +        port {
>>>> +            fsa4480_sbu_mux: endpoint {
>>>> +                remote-endpoint = <&pmic_glink_sbu>;
>>>> +            };
>>>> +        };
>>>> +    };
>>>> +
>>>> +    typec-retimer@1c {
>>>> +        compatible = "onnn,nb7vpq904m";
>>>> +        reg = <0x1c>;
>>>> +
>>>> +        vcc-supply = <&vreg_l15b_1p8>;
>>>> +
>>>> +        orientation-switch;
>>>> +        retimer-switch;
>>>> +
>>>> +        ports {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +
>>>> +            port@0 {
>>>> +                reg = <0>;
>>>> +
>>>> +                redriver_ss_out: endpoint {
>>>> +                    remote-endpoint = <&pmic_glink_ss_in>;
>>>> +                };
>>>> +            };
>>>> +
>>>> +            port@1 {
>>>> +                reg = <1>;
>>>> +
>>>> +                redriver_ss_in: endpoint {
>>>> +                    data-lanes = <3 2 1 0>;
>>>> +                    remote-endpoint = <&usb_dp_qmpphy_out>;
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>>    &gcc {
>>>>        clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>>>             <&pcie0_phy>,
>>>> @@ -552,6 +616,16 @@
>>>>        status = "okay";
>>>>    };
>>>> +&mdss_dp0 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&mdss_dp0_out {
>>>> +    data-lanes = <0 1>;
>>>
>>> Why? Are you really limited to two lanes for DP by the hardware?
>> I got confirmation from a colleague that it is right that limited to two
>> lanes.
> 
> Excuse me, I missed your reply earlier. Is it 2 DP lanes and 2 SS USB
> lanes? Or are there just 2 lanes which are shared between DP and SS
> USB?

Excuse me, because the patch series of V2 has been sent before you reply 
to this, so I missed your message in this patch series.

I confirmed with my colleagues, there are just 2 lanes which are shared 
between DP and SS USB.

> 
>>>
>>>> +    remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>>>> +};
>>>> +
>>>> +
>>>>    &mdss_dsi0 {
>>>>        vdda-supply = <&vreg_l3e_1p2>;
>>>>        status = "okay";
>>>> @@ -861,6 +935,18 @@
>>>>        status = "okay";
>>>>    };
>>>> +&usb_dp_qmpphy_dp_in {
>>>> +    remote-endpoint = <&mdss_dp0_out>;
>>>> +};
>>>> +
>>>> +&usb_dp_qmpphy_out {
>>>> +    remote-endpoint = <&redriver_ss_in>;
>>>> +};
>>>> +
>>>> +&usb_dp_qmpphy_usb_ss_in {
>>>> +    remote-endpoint = <&usb_1_dwc3_ss>;
>>>> +};
>>>> +
>>>>    &xo_board {
>>>>        clock-frequency = <76800000>;
>>>>    };
>>>
>>
>> --
>> Thx and BRs,
>> Tengfei Fan
> 
> 
> 

-- 
Thx and BRs,
Tengfei Fan

