Return-Path: <linux-kernel+bounces-141875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACB8A247C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A611F22D28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69C17C7C;
	Fri, 12 Apr 2024 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jl1oJ0LP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1921FB2;
	Fri, 12 Apr 2024 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893268; cv=none; b=kcokscsdXMiv15C67qwN016Tn8/kAdgt/KXb0zBzOM9Xhd9l1H09t6CSSvo+vqIl6CD/Iw0l8rZfG88ONiJZwRThO6b649XRA/XknWGabh4xQdskuBroTqhr7DZL97XClv+EzZlGxRoh1x+UiumQULbUfzZjBGOW1D5UycPwXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893268; c=relaxed/simple;
	bh=9tQthn+WuwAFh21oeDvVu3RA7MtXUpZV4U0rHfmsASA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RzTyFzItqp+gNeY661OrPi8voGLXvxRBEfZPqVv9YTcEleXbp1VNPHc+//yDL9iDRiypoGRCVcv3Lb3J8TpU4erfo2g28f8CsMRCga9IEcOwR4QLQPQla+pJuFJmAkxeNwmRbNdtYMFa0OEc0tuM88imPhFll7w+TtzdEvPj5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jl1oJ0LP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C3Zhil025621;
	Fri, 12 Apr 2024 03:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fj9TE7Tah5pI7bwVBO6O9IC+pILPNJ+nxYjZRR9bq6c=; b=Jl
	1oJ0LPAMSQsJZcPnA2TvjmI00aTnljd+tqDe2NEYBtpgpRQOzEgHUAbahqk1kwgk
	xfTndYprS6UtzyGux9WaYsO9A8Q+tL+rpe51qUXsIM2iPZ7HEbIOMOYhnAwxP4f6
	at0rQV19XqvEzY0ZbaWOczpCWQOoDAJAvT8fRtqUifj45UgsFnf9WNXLseazodX0
	7QoiOUvXoQvyjUK5YXYpPEit7yXoHUST9ShGCI+MkNisve3bKUtOhZAUCZaFR9F7
	d4p+GokfXvxV6dk5N7zG5DdhuilMFPOYpKF7LD8W8cg4Jig86Xz1fBCUPaKz3+Tr
	avhczuusnMMTUeAH5Sxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer1trgx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 03:41:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C3f1mk017741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 03:41:01 GMT
Received: from [10.253.12.44] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 20:40:56 -0700
Message-ID: <00b8cea6-fed2-4224-8aeb-c731dc1b666f@quicinc.com>
Date: Fri, 12 Apr 2024 11:40:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <kernel@quicinc.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-2-7bf56cb92b28@quicinc.com>
 <CAA8EJpoL9vCAUgWmHcoxppo_gJqaw_xqdYqcJkS6Xza-5aSh3A@mail.gmail.com>
 <fa6c8b30-11f3-bd80-67cb-713e4348eccf@quicinc.com>
 <CAA8EJpqa=5yaTRHuEiYynTDFy53YPFk4R3q_EV8rmsBN1iR5fA@mail.gmail.com>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJpqa=5yaTRHuEiYynTDFy53YPFk4R3q_EV8rmsBN1iR5fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -2XnKRWx_gXOT_47-sjIb57XJJvoq4MN
X-Proofpoint-GUID: -2XnKRWx_gXOT_47-sjIb57XJJvoq4MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120024



On 4/11/2024 10:05 PM, Dmitry Baryshkov wrote:
> On Thu, 11 Apr 2024 at 16:45, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>>
>>
>>
>> On 2024/4/11 18:58, Dmitry Baryshkov wrote:
>>> On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
>>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>>>
>>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>
>>>> Currently, vibrator control register addresses are hard coded,
>>>> including the base address and offsets, it's not flexible to
>>>> support new SPMI vibrator module which is usually included in
>>>> different PMICs with different base address. Refactor it by using
>>>> the base address defined in devicetree.
>>>>
>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>> ---
>>>>    drivers/input/misc/pm8xxx-vibrator.c | 42 ++++++++++++++++++++++++------------
>>>>    1 file changed, 28 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
>>>> index 89f0f1c810d8..2959edca8eb9 100644
>>>> --- a/drivers/input/misc/pm8xxx-vibrator.c
>>>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
>>>> @@ -20,26 +20,26 @@
>>>>    #define MAX_FF_SPEED           0xff
>>>>
>>>>    struct pm8xxx_regs {
>>>> -       unsigned int enable_addr;
>>>> +       unsigned int enable_offset;
>>>>           unsigned int enable_mask;
>>>>
>>>> -       unsigned int drv_addr;
>>>> +       unsigned int drv_offset;
>>>>           unsigned int drv_mask;
>>>>           unsigned int drv_shift;
>>>>           unsigned int drv_en_manual_mask;
>>>>    };
>>>>
>>>>    static const struct pm8xxx_regs pm8058_regs = {
>>>> -       .drv_addr = 0x4A,
>>>> +       .drv_offset = 0x4A,
>>>
>>> If the DT already has reg = <0x4a> and you add drv_offset = 0x4a,
>>> which register will be used by the driver?
>>>
>>> Also, while we are at it, please downcase all the hex numbers that you
>>> are touching.
>>>
>> For SSBI vibrator, the "reg" value defined in DT is not used, see below.
>>
>>
>>>>           .drv_mask = 0xf8,
>>>>           .drv_shift = 3,
>>>>           .drv_en_manual_mask = 0xfc,
>>>>    };
>>>>
>>>>    static struct pm8xxx_regs pm8916_regs = {
>>>> -       .enable_addr = 0xc046,
>>>> +       .enable_offset = 0x46,
>>
>> [...]
>>
>>>> @@ -170,7 +173,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>>>           struct pm8xxx_vib *vib;
>>>>           struct input_dev *input_dev;
>>>>           int error;
>>>> -       unsigned int val;
>>>> +       unsigned int val, reg_base = 0;
>>>>           const struct pm8xxx_regs *regs;
>>>>
>>>>           vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
>>>> @@ -190,13 +193,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>>>
>>>>           regs = of_device_get_match_data(&pdev->dev);
>>>>
>>>> +       if (regs->enable_offset != 0) {
>>>> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
>>>> +               if (error < 0) {
>>>> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
>>>> +                       return error;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       vib->enable_addr = reg_base + regs->enable_offset;
>>>> +       vib->drv_addr = reg_base + regs->drv_offset;
>>
>> The reg_base is initialized as 0 and it is assigned as the "reg" value
>> defined in DT only for SPMI vibrators.
> 
> Please don't. This is counterintuitive. We have reg in DT. We should
> be using it.
> 
Hmm, the original driver doesn't use the reg value defined in DT at all, 
Anyway, I can make the SSBI offset to 0, so the base address defined in 
the DT will be always added regardless of SSBI or SPMI vibrator. Let me 
know.
Thanks

>>
>>>> +
>>>>           /* operate in manual mode */
>>>> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
>>>> +       error = regmap_read(vib->regmap, vib->drv_addr, &val);
>>>>           if (error < 0)
>>>>                   return error;
>>>>
>>>>           val &= regs->drv_en_manual_mask;
>>>> -       error = regmap_write(vib->regmap, regs->drv_addr, val);
>>>> +       error = regmap_write(vib->regmap, vib->drv_addr, val);
>>>>           if (error < 0)
>>>>                   return error;
>>>>
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>
>>>
> 
> 
> 

