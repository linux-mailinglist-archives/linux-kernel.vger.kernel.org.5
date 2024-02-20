Return-Path: <linux-kernel+bounces-72773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CD85B891
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2351EB278F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F6612E2;
	Tue, 20 Feb 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="akx879lA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F760BBA;
	Tue, 20 Feb 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423610; cv=none; b=h+mQ9YnYxkx1sAmNwJ+RfURlqpHaH8H6yqmc9EqcO/BjBvseOefUxErflxscTQu0PSqpcRk306qUXzV/xBoZO52NGYFSCoo64nHJiE0wvoFDygJ34nrCYp325EpacjWEZrh5KzOp3Leu26RiuAfKfAuW0Q36PMi75wYr5GY7aZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423610; c=relaxed/simple;
	bh=A1T59MYZJClmyNBCTKG/d8Im+MbEcekXweyPWSjPzAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WwW+cz9Epf71e0SXLDdw+DyDufrO/G9+Jw8uQphP97RcFH70dkharFvPgjH6YT1NNnGEpTiH1Pv/KfMnasER8ndZqixx16jZYt7JufyxZHSYTuT+AINX/7c1wuLl3B5yhYSdnYbMIn9LUcuzKrD5Wc/KhwsDdLbK9pgWWA69fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=akx879lA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K7raC8008985;
	Tue, 20 Feb 2024 10:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RZtjP7+4AQzD+2iQOHv3+tBeqBCQ/GI4xVeGftVdfNc=; b=ak
	x879lAiMcj/dXF3n9jmdPdR6Xr39WRhLms0UFLHV5mj0VP2pbhXHNAAIWLQrsCHb
	+ipOZswAZoXreDJmklC081Cq2/XRWgk8GCKRm4KzcDuRARiN3gt20FJy3F1UwKe5
	JE1ndbm0I2fJp4VlnmA4Cp9cJpBWf4PZQtuyrXMXSzSaGr+Z0CIuUk1jLDM4pDUW
	MF4l3liCLSEYYjrN3BYP3T8mxX9AslOKwx/PtV4Xof/uAei/TW0YKMQwDqkeV7wQ
	OKJgp7qG9+rSbfvZ/Q1EJ9Wd4xnaaXbLFq0AghHcG0UgOo2DtG/zoUaL4bfrVuRi
	Y7AYFODxyhaysM5FCyPA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc54b2eck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:06:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KA6bv9024251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:06:37 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 02:06:32 -0800
Message-ID: <37f1cede-6d70-4443-be8e-ef12266531a0@quicinc.com>
Date: Tue, 20 Feb 2024 18:06:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@quicinc.com>, Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-6-quic_jingyw@quicinc.com>
 <CAA8EJpr7tHXZHcH1Sbcy0-MCZfMxKBjaPXGdpg3cqyyFjTZOeA@mail.gmail.com>
 <9685991e-6577-4f96-a17f-b0a65d8d1260@quicinc.com>
 <CAA8EJpqVQEktHuD5sYsRMiytPS+XfoHzVTBUuKqeavL4yW72Sg@mail.gmail.com>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <CAA8EJpqVQEktHuD5sYsRMiytPS+XfoHzVTBUuKqeavL4yW72Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o2MY1tz0ndZQUnGUnYtSDR9MDv9RV8hh
X-Proofpoint-ORIG-GUID: o2MY1tz0ndZQUnGUnYtSDR9MDv9RV8hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=981 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200071

Hi Dmitry,

On 2/20/2024 5:19 PM, Dmitry Baryshkov wrote:
> On Tue, 20 Feb 2024 at 11:17, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>
>> Hi Dmitry,
>>
>> On 2/5/2024 10:23 PM, Dmitry Baryshkov wrote:
>>> On Mon, 5 Feb 2024 at 14:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>>>
>>>> Introduce aim500 board dtsi.
>>>
>>> So, is it a board or a module?
>>>
>> aim500 is a module, will fix the descrption.
>>
>>>>
>>>> AIM500 Series is a highly optimized family of modules designed to
>>>> support AIoT and Generative AI applications based on sm8650p with
>>>> PMIC and bluetooth functions etc.
>>>>
>>>> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>>> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>>>>  1 file changed, 409 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>> new file mode 100644
>>>> index 000000000000..cb857da8653b
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>> @@ -0,0 +1,409 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>> +#include "sm8650p.dtsi"
>>>> +#include "pm8550.dtsi"
>>>> +#include "pm8550b.dtsi"
>>>> +#define PMK8550VE_SID 8
>>>> +#include "pm8550ve.dtsi"
>>>> +#include "pm8550vs.dtsi"
>>>> +#include "pmk8550.dtsi"
>>>> +
>>>> +/ {
>>>> +       aliases {
>>>> +               serial1 = &uart14;
>>>> +       };
>>>> +
>>>> +       vph_pwr: vph-pwr-regulator { };
>>>
>>> Is this regulator a part of the module or a part of the carrier board?
>>> If the latter is true, this must go to the carrier board DT file.
>>>
>>
>> the vph_pwr regulator is defined in the aim500-aiot carrier board and used
>> in aim500 module.
> 
> If it is defined in the carrier board, then please move it and
> corresponding supply entries to the carrier board dts. Other devices
> using the SoM can have different power tree.
> 
> While we are at it, could you please rename the node to regulator-vph-pwr?
> 
> 
will rename the node and move it to sm8650p-aim500-aiot.dts

Thanks,
Jingyi

