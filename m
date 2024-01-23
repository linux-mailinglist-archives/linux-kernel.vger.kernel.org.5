Return-Path: <linux-kernel+bounces-35397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD85E83905D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DAD1C223AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8E5F556;
	Tue, 23 Jan 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o855QV/e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227E5F840;
	Tue, 23 Jan 2024 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017439; cv=none; b=GheOyaGKzoqyzVN4v4cEvran/KHYjs/jWoCpZHWC7al0hQ3nrAt8AGwpseED4/xUBQ8i6/XXLlrjJRfz+U2mplOTTKqe4BdOW2v04pKD9mGMgCyWBgA9T2EYKZJuAItttEB6+D+dulFwqgiajBOg2hchTFkeMDfW70yiyxnuqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017439; c=relaxed/simple;
	bh=LhPh2JflSkf4Eh9L4wigdSNPjwvTJS+d6yoBjqkQUu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/qwaK1P769iTLxYFYYcetJgJ8Y+dmXhqGNv62NGGU1CpOjzDM1noT9RMLL8oPGr9WVaU5MOYFMQhXotTLfr9hadLEVEvM2Q+x1/hwZgtpydlmNdUf0rnV166iqvAXYoz9sIkSGHGElUVsWUJNcnWiARoVot91nXGD0kLyKmXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o855QV/e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N9svH4025268;
	Tue, 23 Jan 2024 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jCQOtSJ9PoUIcSjoiIspfcchAoWUzG5bAaJvDSmlONY=; b=o8
	55QV/eNfSUXYbsetOlNX40v7eRtXBjRlAWnV2lfd9neGmAXXvYJ89pb3KSbMOmBl
	6j0lmqYLb0u3mlDnVBnpIAKlfcUS4zSLPIRseaoS9bjIlv9/sTsqH/rW6sMxn2UV
	JOCTfYo+1O3gryeOTi4HtqRPcqiPki0YKl4Q2E73rZbsi4cw0lddRbAolDIaBxnh
	wX+kLBPg74JKD9APD/NUakhvc+u/XmMRZe7wFLmgeij+9/0SSq+fimYJCR0mNLdP
	s7BtyOkSUotzq4KTp5sSAzJuu0oPi8QDxy0gxIPprsnWfjFya5AyqyHekRDPLVzp
	eykkoXQBcWhXIESyP93w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt9un8r0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 13:43:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NDhZXO025227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 13:43:35 GMT
Received: from [10.216.46.55] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 05:43:27 -0800
Message-ID: <99a9a562-9f6f-411c-be1c-0a28fc2524dd@quicinc.com>
Date: Tue, 23 Jan 2024 19:13:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
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
From: Ritesh Kumar <quic_riteshk@quicinc.com>
In-Reply-To: <CAA8EJpqQVuS+yqXQ2y5sNQrRVg7tcQAJ3ywsEjg+O=7TkUZWLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RvR87RTdicsPBy4455whRNbg-5dkbgAK
X-Proofpoint-GUID: RvR87RTdicsPBy4455whRNbg-5dkbgAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230100


On 1/16/2024 6:27 PM, Dmitry Baryshkov wrote:

> On Tue, 16 Jan 2024 at 14:06, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 1/16/24 10:49, Ritesh Kumar wrote:
>>> Enable Display Subsystem with Novatek NT36672E Panel
>>> on qcm6490 idp platform.
>>>
>>> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
>>>    1 file changed, 100 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> index 2a6e4907c5ee..efa5252130a1 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> @@ -9,6 +9,7 @@
>>>    #define PM7250B_SID 8
>>>    #define PM7250B_SID1 9
>>>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>    #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>    #include "sc7280.dtsi"
>>>    #include "pm7250b.dtsi"
>>> @@ -38,6 +39,25 @@
>>>                stdout-path = "serial0:115200n8";
>>>        };
>>>
>>> +     lcd_disp_bias: lcd-disp-bias-regulator {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "lcd_disp_bias";
>>> +             regulator-min-microvolt = <5500000>;
>>> +             regulator-max-microvolt = <5500000>;
>>> +             gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&lcd_disp_bias_en>;
>> property-n
>> property-names
>>
>> all throughout the patch

Thanks, I will update in the new version.

>>> +&gpu {
>>> +     status = "disabled";
>>> +};
>> Hm.. generally we disable the GPU in the SoC DT, but that doesn't
>> seem to have happened here..
>>
>> Thinking about it more, is disabling it here necessary? Does it
>> not fail gracefully?
> Missed this.
>
> I'd say, I don't see a reason to disable it at all. The GPU should be
> working on sc7280 / qcm4290.

With GPU device node enabled, adreno_bind failure is seen as the 
"speed_bin" was not populated on QCM6490 target which leads to display 
bind failure.
Spoke with GPU team and on QCM6490 board, only CPU rendering is 
supported for now and there is no plan to enable GPU rendering in near 
future.

In this regard, what do you suggest

1) Disable GPU in QCM6490 DT (as per the current patch)
2) Disable GPU in the SoC DT, but enable it in other platform DTs. (This 
will prompt change in all the dt's and we don't have all the devices to 
test)

Please let me know your views on it.


Thanks,
Ritesh

