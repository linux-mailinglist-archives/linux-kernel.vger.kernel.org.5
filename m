Return-Path: <linux-kernel+bounces-61545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D1585138D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2BEB230F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D039FE4;
	Mon, 12 Feb 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QARv9sdM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158191864C;
	Mon, 12 Feb 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740941; cv=none; b=bsGsq+81TSQ8ZEROHS5QT+ViRmkUsiKMqrObCMOly7HItD7zgW2j2bQhvLBZ6k/TE4Fudx8eEWOQZo7MK3Pj/mc1l/M5KBk4ZfGeOaoiwb7ptrj6/uduaPduv+Ncy4KaD0EfGdvMNg77Sp4M+lzz17uZj0o6wgQKfys4dJKR6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740941; c=relaxed/simple;
	bh=7PJj2msmk4dQMXOL4dv5NOIOGOF0PXOzFte4+3Icwfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d2RuBj23oZ2gwcO6uFwYjuaFGuVoEEoKoHGK+2fEZCYYyXjR9/NDe+7XLjqRLQtNgC65OJRdO97O5/gaSIYla3gaaqBK0a/C4Nge3lnmdtT8DS7Ykj2oVDGZTMWTFCqYQC2+bz5D63iQhL9MUWUHsbsG9VkcnigYK8lGsQ2uH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QARv9sdM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBcwY7028412;
	Mon, 12 Feb 2024 12:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LyAR9Ky0LhG2Wb408/zQXSn+8a0n2Xf9kdFtUVe/EH0=; b=QA
	Rv9sdMCt1eM7klTxSydUAnffWPU32OVqBENpWdlH/xJPmZ/BHRbE3TmBUtDV6yuj
	8tXPKlLDPXAvPc4pURbvgOrbjCUVlcnDtbIbUnaqfgyw9/+rSv+BrduCh/7Bi59x
	IDvpJhX0HSXYu0K/hFeWMTpW9KlhcAvjlULXVKSwe7748ghd1uJySWFm7ij8hMez
	7w4rpilbNhCSB+iJBDPfXI57g5D/5nhuBpItL/pPPkMzcrT8+6kRxKVdsUgptzYm
	pJ2S9XSzQJg1xuN1vTh434OYOWMxlaXJQ7P8BafWPGVFRU8hRF3HpNmRNe//5p9i
	5XWDwNbB7RS0ubtGqgzg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62nwk90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:28:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CCScEA014931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:28:38 GMT
Received: from [10.204.67.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 04:28:32 -0800
Message-ID: <7932ccbb-3b41-49e2-bb88-9c2633002a0d@quicinc.com>
Date: Mon, 12 Feb 2024 17:58:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com>
 <20a8efd1-e243-434e-8f75-aa786ac8014f@linaro.org>
 <CAA8EJpqQVuS+yqXQ2y5sNQrRVg7tcQAJ3ywsEjg+O=7TkUZWLQ@mail.gmail.com>
 <99a9a562-9f6f-411c-be1c-0a28fc2524dd@quicinc.com>
 <CAA8EJppj+cDnw7p4yANvF0FmEhX3+L5xUq8w3TeevAGhcpo1Yg@mail.gmail.com>
 <9d1c684f-51ac-4d9c-a189-940ff65e0cab@linaro.org>
From: Ritesh Kumar <quic_riteshk@quicinc.com>
In-Reply-To: <9d1c684f-51ac-4d9c-a189-940ff65e0cab@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ERe9fjQUvxdTw12Qkc_kIo02E4PHDDAu
X-Proofpoint-ORIG-GUID: ERe9fjQUvxdTw12Qkc_kIo02E4PHDDAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120092


On 1/23/2024 11:34 PM, Konrad Dybcio wrote:
>
>
> On 1/23/24 16:12, Dmitry Baryshkov wrote:
>> On Tue, 23 Jan 2024 at 15:43, Ritesh Kumar <quic_riteshk@quicinc.com> 
>> wrote:
>>>
>>>
>>> On 1/16/2024 6:27 PM, Dmitry Baryshkov wrote:
>>>
>>>> On Tue, 16 Jan 2024 at 14:06, Konrad Dybcio 
>>>> <konrad.dybcio@linaro.org> wrote:
>>>>>
>>>>>
>>>>> On 1/16/24 10:49, Ritesh Kumar wrote:
>>>>>> Enable Display Subsystem with Novatek NT36672E Panel
>>>>>> on qcm6490 idp platform.
>>>>>>
>>>>>> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 
>>>>>> +++++++++++++++++++++++
>>>>>>     1 file changed, 100 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts 
>>>>>> b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>>> index 2a6e4907c5ee..efa5252130a1 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>>>>> @@ -9,6 +9,7 @@
>>>>>>     #define PM7250B_SID 8
>>>>>>     #define PM7250B_SID1 9
>>>>>>
>>>>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>>>>     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>>>     #include "sc7280.dtsi"
>>>>>>     #include "pm7250b.dtsi"
>>>>>> @@ -38,6 +39,25 @@
>>>>>>                 stdout-path = "serial0:115200n8";
>>>>>>         };
>>>>>>
>>>>>> +     lcd_disp_bias: lcd-disp-bias-regulator {
>>>>>> +             compatible = "regulator-fixed";
>>>>>> +             regulator-name = "lcd_disp_bias";
>>>>>> +             regulator-min-microvolt = <5500000>;
>>>>>> +             regulator-max-microvolt = <5500000>;
>>>>>> +             gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
>>>>>> +             enable-active-high;
>>>>>> +             pinctrl-names = "default";
>>>>>> +             pinctrl-0 = <&lcd_disp_bias_en>;
>>>>> property-n
>>>>> property-names
>>>>>
>>>>> all throughout the patch
>>>
>>> Thanks, I will update in the new version.
>>>
>>>>>> +&gpu {
>>>>>> +     status = "disabled";
>>>>>> +};
>>>>> Hm.. generally we disable the GPU in the SoC DT, but that doesn't
>>>>> seem to have happened here..
>>>>>
>>>>> Thinking about it more, is disabling it here necessary? Does it
>>>>> not fail gracefully?
>>>> Missed this.
>>>>
>>>> I'd say, I don't see a reason to disable it at all. The GPU should be
>>>> working on sc7280 / qcm4290.
>>>
>>> With GPU device node enabled, adreno_bind failure is seen as the
>>> "speed_bin" was not populated on QCM6490 target which leads to display
>>> bind failure.
>>
>> Excuse me please. The GPU node for sc7280 already has speed_bin, which
>> points to qfprom + 0x1e9, bits 5 to 9.
>>
>> Do you mean that qcm6490 uses different speed bin location? Or
>> different values for the speed bins?
>>
>>> Spoke with GPU team and on QCM6490 board, only CPU rendering is
>>> supported for now and there is no plan to enable GPU rendering in near
>>> future.
>>
>> This sounds like having the feature disabled for no particular reason.
>> Both the kernel and Mesa have supported the Adreno 635 for quite a
>> while.
>
> 643 [1], [2]
>
>>
>>> In this regard, what do you suggest
>>>
>>> 1) Disable GPU in QCM6490 DT (as per the current patch)
>>> 2) Disable GPU in the SoC DT, but enable it in other platform DTs. 
>>> (This
>>> will prompt change in all the dt's and we don't have all the devices to
>>> test)
>>
>> The second option definitely follows what is present on other platforms.
>>
>>> Please let me know your views on it.
>>
>> Please enable the GPU instead.
>
> +1
>
> Konrad
>
> [1] 
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25408/diffs?commit_id=b1e851d66c3a3e53f1a464023f675f3f6cbd3503
> [2] 
> https://patches.linaro.org/project/linux-arm-msm/cover/20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org/

Thanks for the help. After applying missing patches from series 
https://patches.linaro.org/project/linux-arm-msm/cover/20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org/
in my local build, GPU is working fine. GPU disablement change is not 
needed. I will send new version of patch removing GPU part and 
addressing other review comments.

Thanks,
Ritesh

