Return-Path: <linux-kernel+bounces-59068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2384F0BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F9A290012
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6057312;
	Fri,  9 Feb 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D0TY7ONo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CD657B1;
	Fri,  9 Feb 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463711; cv=none; b=j3rPL6Irpt2FoVH4N2oXHYc1t0avOv0bfPytLh9FcgD4mcs8rDuFSNYxfcWSfWCT27YzpDWr/kVc0VwpI+iGlQDOjvzsHvaLp7Y7N1AdhkzHynamj2ds4iYav23YIbr9SgBUR7mC7zJb9blWQPP0Z9AWR4J50hanwkFfx5fgUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463711; c=relaxed/simple;
	bh=P1xJ8sKPXwvCAM9GQOzqx5nOqlNR4AJfnRDwSoBHvqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PnjFCqcvh94FM2hRqVMxfurbVbOa2OzBPPJnRVWUoJ7PRi0MVR1Nls9ji9mOnsiZPMY2+EPb7yoGFORozZG68TBxXavIzKM+LJEJpv7G3izcdKrls+b3ETXENQE7mY4sHI96beIKvBHLn/SRqIiR71nRVTU48+H1GZnmybnIRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D0TY7ONo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4194PvMJ023980;
	Fri, 9 Feb 2024 07:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=v4t0e8PHCfrAGxEvMThUV11S+56I7Pcp7j/QBbTNNzg=; b=D0
	TY7ONo3So7UhI+Rs4SursYKISCY1d/WFdnmx63ontDxklDJqRROm4I4y4qCb4fgx
	YQdhnUJBgk1h3DfB0oW1em22CLjJM3EzUUgU5H3PX6pdLiR+RfZyYoJ+GXqbY+By
	gk6cUdCa6qyXuSGgZrDW+toQAPcs+++ywHCq02NX9djxsITrbB5pTBuV6PyHa2ot
	UORmysnI0je5SvNJRsILz07n03ezG7tszczgpqoDlJSVa073szGGdAvoKwW59h+m
	j4XqYN6f0AiE03EKloCVtrOObaV7D1fnnjKlD/gPG8/iro04g2UCnFCT9WdT7HHl
	yAmTdZHGA10tx8hxFp0g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk83ap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:28:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4197SOKk016252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 07:28:24 GMT
Received: from [10.216.50.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 23:28:18 -0800
Message-ID: <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>
Date: Fri, 9 Feb 2024 12:58:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
 <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com>
 <CAA8EJprsm5Tw=vFpmfEKL8fxS-S+aW+YR0byfyL=v78k75TGEw@mail.gmail.com>
 <3ad77846-b4a8-80ee-e9e1-d5cbf4add6d8@quicinc.com>
 <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vy5LU8xy0StRrkh2EaO_UQTzZXxc-45Q
X-Proofpoint-ORIG-GUID: vy5LU8xy0StRrkh2EaO_UQTzZXxc-45Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_04,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090052



On 2/8/2024 8:49 PM, Dmitry Baryshkov wrote:
> On Thu, 8 Feb 2024 at 16:58, Krishna Chaitanya Chundru
> <quic_krichai@quicinc.com> wrote:
>> On 2/8/2024 12:21 PM, Dmitry Baryshkov wrote:
>>> On Thu, 8 Feb 2024 at 08:14, Krishna Chaitanya Chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
>>>>> <quic_krichai@quicinc.com> wrote:
>>>>>>
>>>>>> Enable PCIe1 controller and its corresponding PHY nodes on
>>>>>> qcs6490-rb3g2 platform.
>>>>>>
>>>>>> PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
>>>>>> connected. For each endpoint a unique BDF will be assigned and should
>>>>>> assign unique smmu id. So for each BDF add smmu id.
>>>>>>
>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
>>>>>>     1 file changed, 42 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>>>> index 8bb7d13d85f6..0082a3399453 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>>>> @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
>>>>>>            };
>>>>>>     };
>>>>>>
>>>>>> +&pcie1 {
>>>>>> +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>>>>> +
>>>>>> +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>>>>>> +       pinctrl-names = "default";
>>>>>> +
>>>>>> +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
>>>>>> +                   <0x100 &apps_smmu 0x1c81 0x1>,
>>>>>> +                   <0x208 &apps_smmu 0x1c84 0x1>,
>>>>>> +                   <0x210 &apps_smmu 0x1c85 0x1>,
>>>>>> +                   <0x218 &apps_smmu 0x1c86 0x1>,
>>>>>> +                   <0x300 &apps_smmu 0x1c87 0x1>,
>>>>>> +                   <0x400 &apps_smmu 0x1c88 0x1>,
>>>>>> +                   <0x500 &apps_smmu 0x1c89 0x1>,
>>>>>> +                   <0x501 &apps_smmu 0x1c90 0x1>;
>>>>>
>>>>> Is the iommu-map really board specific?
>>>>>
>>>> The iommu-map for PCIe varies if PCIe switch is connected.
>>>> For this platform a PCIe switch is connected and for that reason
>>>> we need to define additional smmu ID's for each BDF.
>>>>
>>>> For that reason we defined here as these ID's are applicable only
>>>> for this board.
>>>
>>> So, these IDs are the same for all boards, just being unused on
>>> devices which have no bridges / switches connected to this PCIe host.
>>> If this is correct, please move them to sc7280.dtsi.
>>>
>> Yes ID's will be same for all boards. we can move them sc7280.dtsi
>> but the BDF to smmu mapping will be specific to this board only.
>> if there is some other PCIe switch with different configuration is
>> connected to different board of same variant in future again these
>> mapping needs to updated.
> 
> Could you possibly clarify this? Are they assigned one at a time
> manually? Or is it somehow handled by the board's TZ code, which
> assigns them sequentially to the known endpoints? And is it done via
> probing the link or via some static configuration?

There is no assignment of SID's in TZ for PCIe.
PCIe controller has BDF to SID mapping table which we need to
program with the iommu map table.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?h=v6.8-rc3#n997

Based upon switch the BDF to SID table will change for example I had two 
switches with one switch has 2 PCIe ports and other has 3 ports one
embedded port which supports multiple functions.

For the first switch the BDF's are
	- 0x000(root complex),
	- 0x100(USP),
	- 0x208(DSP 0),
	- 0x210(DSP 1),
	- 0x300(endpoint connected to DSP 0),
	- 0x400( endpoint connected to DSP 1).

For 2nd switch the BDF's are
	- 0x000(root complex),
	- 0x100(USP),
	- 0x208(embeeded DSP 0),
	- 0x210(DSP 1),
	- 0x218 (DSP 2),
	- 0x300(embedded endpoint function 0),
	- 0x301 (embedded endpoint function 1)
	- 0x400( endpoint connected to DSP 1)
	- 0x500(endpoint connected to DSP2).

For these two switches we need different BDF to SID table so for that
reason we are keeping iommu map here as this is specific to this board.

- Krishna Chaitanya.

>>
>> For that reason I tried to add it here.
>>
>> - Krishna Chaitanya.
>>>>
>>>> - Krishna Chaitanya.
>>>>>> +
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&pcie1_phy {
>>>>>> +       vdda-phy-supply = <&vreg_l10c_0p88>;
>>>>>> +       vdda-pll-supply = <&vreg_l6b_1p2>;
>>>>>> +
>>>>>> +       status = "okay";
>>>>>> +};
>>>>>> +
>>>>>>     &qupv3_id_0 {
>>>>>>            status = "okay";
>>>>>>     };
>>>>>> @@ -420,6 +446,22 @@ &qupv3_id_0 {
>>>>>>     &tlmm {
>>>>>>            gpio-reserved-ranges = <32 2>, /* ADSP */
>>>>>>                                   <48 4>; /* NFC */
>>>>>> +
>>>>>> +       pcie1_reset_n: pcie1-reset-n-state {
>>>>>> +               pins = "gpio2";
>>>>>> +               function = "gpio";
>>>>>> +               drive-strength = <16>;
>>>>>> +               output-low;
>>>>>> +               bias-disable;
>>>>>> +       };
>>>>>> +
>>>>>> +       pcie1_wake_n: pcie1-wake-n-state {
>>>>>> +               pins = "gpio3";
>>>>>> +               function = "gpio";
>>>>>> +               drive-strength = <2>;
>>>>>> +               bias-pull-up;
>>>>>> +       };
>>>>>> +
>>>>>>     };
>>>>>>
>>>>>>     &uart5 {
>>>>>>
>>>>>> ---
>>>>>> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
>>>>>> change-id: 20240207-enable_pcie-95b1d6612b27
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 

