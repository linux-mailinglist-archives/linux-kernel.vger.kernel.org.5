Return-Path: <linux-kernel+bounces-61600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413F851417
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D01C210F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74913A1C5;
	Mon, 12 Feb 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YwMrvMOr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9C39FFD;
	Mon, 12 Feb 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743259; cv=none; b=TMjdrQY/pW9Y1BDwaQ7cyXcgV5CnTseU3tdgkdpnPQ9kVg70G1RJs4FPtTRb7TCwQVtnvDlZ2BOWB2wuYZwD+fcF/SCDP22yXSeZNF/PqK4CIRs7I28JH77WroazOHm6Ne32DcOZ/VUGGT5yyL0eIsmxMHz6HPdiiegOwPEa5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743259; c=relaxed/simple;
	bh=vZ+hSARcnLjxR8aMhf3FOMyEWNZPAUjXRDllNiuoaY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GRm37julXdSze1tEw4E9RozCrVWoO6pQSPHweKLL0XIrCXFwrJ2OamtX4IGLb6ESnPin5qxOreie/R669j4MOHwDweD0OUnivaBXJQcJwZypyDDMSpXTSu1jr/j0+k3mMFHTCFpHESp5fniErriz+Uj8qwiuO/bcwf/dAzOqW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YwMrvMOr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8ePKF018491;
	Mon, 12 Feb 2024 13:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Jm/Rp6PYFPPRH1G1KAQNpPCE+cXaHQkYUggUJFrTmOs=; b=Yw
	MrvMOrctK/k5gm8oigBsvvpvXIWkvlr2+JYcOkGWNLcXetLcKEu8CAM2vWh26TbA
	Kr4pPz/02Wbxgy/CcPaA+NauY5SSP47kf9VoPgTNlBAwXyJaSi/0BpFy3zShvhzj
	rrF6ozZzw2tR9XPX5vOXW7AdrYZwe05IRZsfTPXbNQ88JJ6tYVzaFWUlTg2h2Qrr
	iV9Bs2lqq/wSiKESszKohEkT+3OGo57O/nUSX1Dd/ZC0fG6jFEtcNzQanOs3y8wj
	8vrfR1KiDv+nKlDgpAZcZvWr5GJ3tuH0yy3ueYUPhmmX8wsAbAx4BGb7pkPv7FT7
	QuSzOR+2+cckHEyl9COQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps3e2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:07:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CD7WSn023381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:07:32 GMT
Received: from [10.216.29.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 05:07:27 -0800
Message-ID: <d88f0f42-c9ec-4638-8090-055bc4806574@quicinc.com>
Date: Mon, 12 Feb 2024 18:36:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: videocc-sm8550: Add support for SM8650
 videocc
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-3-quic_jkona@quicinc.com>
 <CAA8EJpqbKQS7Bp28xNZ0twu7BFLdOES9qS5xBvoonux8Ma4q6Q@mail.gmail.com>
 <e90522c1-7a2d-40ff-bf4e-c8f974722ddf@quicinc.com>
 <CAA8EJpqCDOE_5vg+4ew8H0HbhQM1w8reqU6Pu0MAYJtMw8zXUw@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqCDOE_5vg+4ew8H0HbhQM1w8reqU6Pu0MAYJtMw8zXUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MZusrz6iviKqZhiYSYNZNQ-SuxQ5798z
X-Proofpoint-GUID: MZusrz6iviKqZhiYSYNZNQ-SuxQ5798z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120099



On 2/7/2024 12:49 PM, Dmitry Baryshkov wrote:
> On Wed, 7 Feb 2024 at 08:59, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 2/6/2024 5:24 PM, Dmitry Baryshkov wrote:
>>> On Tue, 6 Feb 2024 at 13:39, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>>
>>>> Add support to the SM8650 video clock controller by extending the
>>>> SM8550 video clock controller, which is mostly identical but SM8650
>>>> has few additional clocks and minor differences.
>>>
>>> In the past we tried merging similar clock controllers. In the end
>>> this results in the ugly source code. Please consider submitting a
>>> separate driver.
>>>
>>
>> Thanks Dmitry for your review. SM8650 has only few clock additions and
>> minor changes compared to SM8550, so I believe it is better to reuse
>> this existing driver and extend it.
> 
> I'd say, the final decision is on Bjorn and Konrad as maintainers.
> 
>>
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/videocc-sm8550.c | 160 +++++++++++++++++++++++++++++-
>>>>    1 file changed, 156 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
>>>> index f3c9dfaee968..cdc08f5900fc 100644
>>>> --- a/drivers/clk/qcom/videocc-sm8550.c
>>>> +++ b/drivers/clk/qcom/videocc-sm8550.c
>>>> @@ -1,6 +1,6 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /*
>>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>
>>>>    #include <linux/clk-provider.h>
>>>
>>> [skipping]
>>>
>>>>    static struct gdsc video_cc_mvs0c_gdsc = {
>>>>           .gdscr = 0x804c,
>>>>           .en_rest_wait_val = 0x2,
>>>> @@ -354,15 +481,20 @@ static struct clk_regmap *video_cc_sm8550_clocks[] = {
>>>>           [VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
>>>>           [VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
>>>>           [VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
>>>> +       [VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr,
>>>>           [VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
>>>>           [VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
>>>> +       [VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr,
>>>>           [VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
>>>>           [VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
>>>>           [VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
>>>> +       [VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr,
>>>>           [VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
>>>>           [VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
>>>> +       [VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr,
>>>>           [VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
>>>>           [VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
>>>> +       [VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
>>>>    };
>>>>
>>>>    static struct gdsc *video_cc_sm8550_gdscs[] = {
>>>> @@ -380,6 +512,7 @@ static const struct qcom_reset_map video_cc_sm8550_resets[] = {
>>>>           [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
>>>>           [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
>>>>           [VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
>>>> +       [VIDEO_CC_XO_CLK_ARES] = { 0x8124, 2 },
>>>
>>> Is this reset applicable to videocc-sm8550?
>>>
>>
>> SM8550 also has above reset support in hardware, hence it is safe to
>> model above reset for both SM8550 and SM8650.
> 
> Then, separate commit, Fixes tag.
> 

Sure, will separate and add Fixes tag in next series.

>>
>>>>    };
>>>>
>>>>    static const struct regmap_config video_cc_sm8550_regmap_config = {
>>>> @@ -402,6 +535,7 @@ static struct qcom_cc_desc video_cc_sm8550_desc = {
>>>>
>>>>    static const struct of_device_id video_cc_sm8550_match_table[] = {
>>>>           { .compatible = "qcom,sm8550-videocc" },
>>>> +       { .compatible = "qcom,sm8650-videocc" },
>>>>           { }
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
>>>> @@ -410,6 +544,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>>>    {
>>>>           struct regmap *regmap;
>>>>           int ret;
>>>> +       u32 offset;
>>>>
>>>>           ret = devm_pm_runtime_enable(&pdev->dev);
>>>>           if (ret)
>>>> @@ -425,6 +560,23 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>>>                   return PTR_ERR(regmap);
>>>>           }
>>>>
>>>> +       if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8550-videocc")) {
>>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = NULL;
>>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = NULL;
>>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = NULL;
>>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = NULL;
>>>> +               video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = NULL;
>>>
>>> Please invert the logic. Make video_cc_sm8550_clocks reflect SM8550
>>> and patch in new clocks in the SM8650-specific branch below.
>>>
>>
>> Sure, will add these clocks as NULL in video_cc_sm8550_clocks and patch
>> in new clocks here for SM8650. Then we can remove above check for SM8550.
> 
> No need to set them to NULL, it is the default value. Just add them to
> the sm8650 branch.
> 

The video_cc_sm8550_clocks[] array size is fixed and has memory 
allocated only for current sm8550 clocks. To be able to accommodate 
sm8650 clocks in the same array, we need to initialize the clocks to 
NULL as below snippet to increase the array size.

static struct clk_regmap *video_cc_sm8550_clocks[] = {
....
	[VIDEO_CC_XO_CLK_SRC] = NULL,
}

Thanks,
Jagadeesh

>>
>> Thanks,
>> Jagadeesh
>>
>>>> +               offset = 0x8140;
>>>> +       } else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
>>>> +               video_cc_pll0_config.l = 0x1e;
>>>> +               video_cc_pll0_config.alpha = 0xa000;
>>>> +               video_cc_pll1_config.l = 0x2b;
>>>> +               video_cc_pll1_config.alpha = 0xc000;
>>>> +               video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
>>>> +               video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
>>>> +               offset = 0x8150;
>>>> +       }
>>>> +
>>>>           clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>>>>           clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>>>>
>>>> @@ -435,7 +587,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>>>            *      video_cc_xo_clk
>>>>            */
>>>>           regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
>>>> -       regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
>>>> +       regmap_update_bits(regmap, offset, BIT(0), BIT(0));
>>>>           regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
>>>>
>>>>           ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>
>>>
> 
> 
> 

