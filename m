Return-Path: <linux-kernel+bounces-72824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783685B906
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1641C222E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1141C9D;
	Tue, 20 Feb 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Aq+LnfDV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373760EE3;
	Tue, 20 Feb 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424906; cv=none; b=p7uOzub7JFRZQIJi9e5QBP9KlmfJ4Vva7Syur6wz1An1RLyCJFAEsKvOeHgxVWytxo8tdfn8mZ8qfsKZLeFrbi8iNji+raCFS1zdKz/2TRzm8lGbk4xJ53MEHCIfjOXn1jwsmij3Q6MVp/UuHAmk/iHl0FLge9pHfCiI9biTPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424906; c=relaxed/simple;
	bh=l7otL2gscSgJ64bCvC033YalS/+yUmZ93WpIuL3Dwu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkXodb0sjJdyThHd/xi4p87c9x2kP6ni5YkpYqFdwapnAZhER6u9kvXuTZZtJJEJHhssxZI+r0/dZyMS8OUKqSkthQqX31UtXYQknv0VkXDn+iEGB0DpfBkzQIoM7ImtJl/sQKWFbMWhmQXb43uez8nSUT5bS7Je3n3YX26J0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Aq+LnfDV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KABgW2026869;
	Tue, 20 Feb 2024 10:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DD8EzjWrMUK+IIZqpHAfw0rT3BUw8IO2gwpFPRrgBD8=; b=Aq
	+LnfDVuhHMQHv2uBCF6Kjaqsz4Z5xjSyuQCxYW67mbszq0MPv2KIjqT1SJtdhv4y
	uwML35qc/tVHEhW24L0OEPZGmMiEinZ82ePiBoXTmy9FYcLehe2qizVjL/Ery60y
	MPkBRyvrO0s6co2mZqHzuyQFWXQjDB21mi1u+WlAcpxX3QDgznhgLSHBXnIf9YEQ
	YndZSZWWg5rgSEWbwZulztcHWrXg114kWSfRsTct/4YJz/ZpY7u5iat78hcJZNFd
	VhAZQThFqhQOVgYqOjTKbyWsC+U6HvCglp44CR8oyYRQNlw3FpGXFNXzEpDW7KaX
	u7fShwMwCQ9p97/nLr9A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3d015j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:28:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KASJjM022610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:28:19 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 02:28:13 -0800
Message-ID: <374902c2-b1c4-42bd-aa34-fbb188b8428a@quicinc.com>
Date: Tue, 20 Feb 2024 18:28:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
Content-Language: en-US
To: Jingyi Wang <quic_jingyw@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
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
 <37f1cede-6d70-4443-be8e-ef12266531a0@quicinc.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <37f1cede-6d70-4443-be8e-ef12266531a0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qeGl04L0-GnX52yBAdRy_jMqx_1w1xgd
X-Proofpoint-GUID: qeGl04L0-GnX52yBAdRy_jMqx_1w1xgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200075



On 2/20/2024 6:06 PM, Jingyi Wang wrote:
> Hi Dmitry,
> 
> On 2/20/2024 5:19 PM, Dmitry Baryshkov wrote:
>> On Tue, 20 Feb 2024 at 11:17, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>>
>>> Hi Dmitry,
>>>
>>> On 2/5/2024 10:23 PM, Dmitry Baryshkov wrote:
>>>> On Mon, 5 Feb 2024 at 14:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>>>>
>>>>> Introduce aim500 board dtsi.
>>>>
>>>> So, is it a board or a module?
>>>>
>>> aim500 is a module, will fix the descrption.
>>>
>>>>>
>>>>> AIM500 Series is a highly optimized family of modules designed to
>>>>> support AIoT and Generative AI applications based on sm8650p with
>>>>> PMIC and bluetooth functions etc.
>>>>>
>>>>> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>>>> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>>>>>   1 file changed, 409 insertions(+)
>>>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..cb857da8653b
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>>> @@ -0,0 +1,409 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>> +#include "sm8650p.dtsi"
>>>>> +#include "pm8550.dtsi"
>>>>> +#include "pm8550b.dtsi"
>>>>> +#define PMK8550VE_SID 8
>>>>> +#include "pm8550ve.dtsi"
>>>>> +#include "pm8550vs.dtsi"
>>>>> +#include "pmk8550.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +       aliases {
>>>>> +               serial1 = &uart14;
>>>>> +       };
>>>>> +
>>>>> +       vph_pwr: vph-pwr-regulator { };
>>>>
>>>> Is this regulator a part of the module or a part of the carrier board?
>>>> If the latter is true, this must go to the carrier board DT file.
>>>>
>>>
>>> the vph_pwr regulator is defined in the aim500-aiot carrier board and used
>>> in aim500 module.
>>
>> If it is defined in the carrier board, then please move it and
>> corresponding supply entries to the carrier board dts. Other devices
>> using the SoM can have different power tree.
>>
>> While we are at it, could you please rename the node to regulator-vph-pwr?
>>
>>
> will rename the node and move it to sm8650p-aim500-aiot.dts

Shall we have the VPH_PWR implementation inside the board dts file, and 
have the supply entries which used the VPH_PWR inside the SOM.dtsi file?

The VPH_PWR is an input IO of SOM. And the corresponding supply entries 
is inside the SOM hardware design as well.

The VPH_PWR as a fixed regulator implementation is the board design, it 
can be changed to other design from different boards.

Here is a simple diagram to show the hardware description of the VPH_PWR 
related design:

+------------------------------------------------------+ 
 

|                 Board                                | 
 

|                                                      | 
 

|           +-----------------+                        | 
 

|power----->| Fixed regulator-----------+              | 
 

|           +-----------------+         |              | 
 

|                                       |              | 
 

|                                       v VPH_PWR      | 
 

|                  +------|----------------------+     | 
 

|                  |      |    SOM       |       |     | 
 

|                  |      |              |       |     | 
 

|                  |      vVPH_PWR       vVPM_PWR|     | 
 

|                  |  +------+       +------+    |     | 
 

|                  |  | pmic1|       |pmic2 |    |     | 
 

|                  |  +------+       +------+    |     | 
 

|                  |                             |     | 
 

|                  +-----------------------------+     | 
 

+------------------------------------------------------+ 
 



> 
> Thanks,
> Jingyi

-- 
Thx and BRs,
Aiqun(Maria) Yu

