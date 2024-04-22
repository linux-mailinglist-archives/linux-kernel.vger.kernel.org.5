Return-Path: <linux-kernel+bounces-153251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835408ACB80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5D31F23528
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56B145FF6;
	Mon, 22 Apr 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hXbvKiMM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF49482C1;
	Mon, 22 Apr 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783497; cv=none; b=maV2D+2yuz3Kn+aZYKdy09KEbJAlrW6L/6pDqPYtE3RkXURBiCLSY2u/NNi64+BmSKy8X9SjpgsUpSOEJ9FfQ5WNgCYDbR8cWzSt0R3rKPBoIuLWgMZbsDRRatgWQHoTp7ovLJo1uijSI8rksgnGhcvOknkF1kp4npLDIG07gvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783497; c=relaxed/simple;
	bh=0rNt3QdClu+MsiAcTHPsILQpK5sBVa6rNFHj/WQ4GRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KdcYORfyVCuuSfcRceJAbvgIGp5dSmYq9NUazBd7FbWbPl4hHgoXqHvwm74oh5SiuUBIkdTy37eqgtPy8r6SYNFcJgSnCLR3Vcsc7W672NTP0UxgcJSFxbRl8BvEbKeLtBBy6y0FJSruHipzo5lv35zHRycZt3SpuLaHQWs9238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hXbvKiMM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M2lDBa014858;
	Mon, 22 Apr 2024 10:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2p0cjqRkP2V6AC42/7fG/rRA8VzQJI3JHBbxLYZfJSk=; b=hX
	bvKiMMrqOJt1gW9BL63MD+jIPJo3iN8wSrZQlSF6Mv7oZWKZhm2/Su9leegcBT/S
	9ExTmNNuVmUMS6NWBdsFCWIYKInA1hwF39PP84c/YqlUBngTW7JPJpZRN6Ym7oz5
	lXVzOM313CvebpBZCtUNV2Z4DqXGv6FuNf70E9233MNhATXeZgoPfoQjnS6hPyKE
	RnlKr77jyAHimyKHuouxbiLrygiQjMiDig2BdvnSs0oaUp6eDamFe/E0XyMZPhnR
	DAoT8EE2O1fTJX4J35OEs8kt7cbxl8SxzJ6g4Xhw/iC1rWNKAM8G7bSVNKdLuEAo
	7X2oDIsCO/IyKHLbAXcg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet792mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 10:58:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MAwA0T028661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 10:58:10 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 03:58:05 -0700
Message-ID: <4b2e0c76-e455-40f8-b652-a4b723cc8601@quicinc.com>
Date: Mon, 22 Apr 2024 16:27:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 5/6] clk: qcom: camcc-sm8650: Add SM8650 camera
 clock controller driver
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-6-quic_jkona@quicinc.com>
 <d3d3be20-7ec0-419c-b5a3-77047d8bc7bf@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <d3d3be20-7ec0-419c-b5a3-77047d8bc7bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tO_2aQsLXLe0gpglmVOZK7bt-DqU4HPo
X-Proofpoint-ORIG-GUID: tO_2aQsLXLe0gpglmVOZK7bt-DqU4HPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220050



On 4/19/2024 3:00 AM, Vladimir Zapolskiy wrote:
> Hello Jagadeesh,
> 
> thank you for submitting the clock driver.
> 
> On 3/21/24 11:25, Jagadeesh Kona wrote:
>> Add support for the camera clock controller for camera clients to
>> be able to request for camcc clocks on SM8650 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/clk/qcom/Kconfig        |    8 +
>>   drivers/clk/qcom/Makefile       |    1 +
>>   drivers/clk/qcom/camcc-sm8650.c | 3591 +++++++++++++++++++++++++++++++
>>   3 files changed, 3600 insertions(+)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8650.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 8ab08e7b5b6c..6257f4a02ec4 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -826,6 +826,14 @@ config SM_CAMCC_8550
>>         Support for the camera clock controller on SM8550 devices.
>>         Say Y if you want to support camera devices and camera 
>> functionality.
>> +config SM_CAMCC_8650
>> +    tristate "SM8650 Camera Clock Controller"
>> +    depends on ARM64 || COMPILE_TEST
>> +    select SM_GCC_8650
>> +    help
>> +      Support for the camera clock controller on SM8650 devices.
>> +      Say Y if you want to support camera devices and camera 
>> functionality.
>> +
>>   config SM_DISPCC_6115
>>       tristate "SM6115 Display Clock Controller"
>>       depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index dec5b6db6860..28bffa1eb8dd 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -109,6 +109,7 @@ obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>>   obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>>   obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
>>   obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
>> +obj-$(CONFIG_SM_CAMCC_8650) += camcc-sm8650.o
>>   obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>>   obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>>   obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
>> diff --git a/drivers/clk/qcom/camcc-sm8650.c 
>> b/drivers/clk/qcom/camcc-sm8650.c
>> new file mode 100644
>> index 000000000000..1b28e086e519
>> --- /dev/null
>> +++ b/drivers/clk/qcom/camcc-sm8650.c
>> @@ -0,0 +1,3591 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "common.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +    DT_IFACE,
>> +    DT_BI_TCXO,
>> +    DT_BI_TCXO_AO,
>> +    DT_SLEEP_CLK,
>> +};
>> +
>> +enum {
>> +    P_BI_TCXO,
>> +    P_BI_TCXO_AO,
>> +    P_CAM_CC_PLL0_OUT_EVEN,
>> +    P_CAM_CC_PLL0_OUT_MAIN,
>> +    P_CAM_CC_PLL0_OUT_ODD,
>> +    P_CAM_CC_PLL1_OUT_EVEN,
>> +    P_CAM_CC_PLL2_OUT_EVEN,
>> +    P_CAM_CC_PLL2_OUT_MAIN,
>> +    P_CAM_CC_PLL3_OUT_EVEN,
>> +    P_CAM_CC_PLL4_OUT_EVEN,
>> +    P_CAM_CC_PLL5_OUT_EVEN,
>> +    P_CAM_CC_PLL6_OUT_EVEN,
>> +    P_CAM_CC_PLL7_OUT_EVEN,
>> +    P_CAM_CC_PLL8_OUT_EVEN,
>> +    P_CAM_CC_PLL9_OUT_EVEN,
>> +    P_CAM_CC_PLL9_OUT_ODD,
>> +    P_CAM_CC_PLL10_OUT_EVEN,
>> +    P_SLEEP_CLK,
>> +};
>> +
>> +static const struct pll_vco lucid_ole_vco[] = {
>> +    { 249600000, 2300000000, 0 },
>> +};
> 
> I've noticed that a downstream Android kernel v6.1.25 defines this clock as
> 
>      static const struct pll_vco lucid_ole_vco[] = {
>          { 249600000, 2100000000, 0 },
>      };
> 
> Do you know any particular reason why here the clock frequencies are 
> different?
> 

Thanks Vladimir for your review!

The min and max supported frequencies of PLL mentioned above are taken 
from the HW specification, and as per the latest HW spec, the maximum 
supported frequency for lucid OLE PLL is 2300MHz, hence used 2300MHz above.

>> +
>> +static const struct pll_vco rivian_ole_vco[] = {
>> +    { 777000000, 1285000000, 0 },
>> +};
>> +
> 
> <snip>
> 
>> +static struct clk_rcg2 cam_cc_bps_clk_src = {
>> +    .cmd_rcgr = 0x10050,
>> +    .mnd_width = 0,
>> +    .hid_width = 5,
>> +    .parent_map = cam_cc_parent_map_2,
>> +    .freq_tbl = ftbl_cam_cc_bps_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "cam_cc_bps_clk_src",
>> +        .parent_data = cam_cc_parent_data_2,
>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
>> +    },
>> +};
> 
> Please let me ask after Dmitry about your rationale to select
> &clk_rcg2_shared_ops here and below for all *_src clocks introduced in
> the driver, I do remember you've did it in v1, could you please
> elaborate it a bit more?
> 
> I have a concern that it's not possible to get an .is_enabled status
> of the shared clocks, however at least in this particular case of
> camcc clocks it seems to be technically possible.
> 
> It might indicate that there is an incompleteness in clk-rcg2.c driver
> also, if it's really possible to get is_enabled runtime status at least
> for some of the shared clocks.
> 

The recommendation from HW team is to park the RCG's at XO clock source 
when RCG is in disabled state and clk_rcg2_shared_ops is the closest 
implementation for achieving the same, hence used clk_rcg2_shared_ops 
for all the RCG's.

I will check if .is_enabled callback can be added to shared_ops and post 
a separate series for it based on the requirement.

>> +
>> +static const struct freq_tbl ftbl_cam_cc_camnoc_axi_rt_clk_src[] = {
>> +    F(300000000, P_CAM_CC_PLL0_OUT_EVEN, 2, 0, 0),
>> +    F(400000000, P_CAM_CC_PLL0_OUT_ODD, 1, 0, 0),
>> +    { }
>> +};
>> +
> 
> <snip>
> 
> Other than two my open questions above I don't see any issues with the
> driver, if you be kind to provide the answers, please feel free to add
> my
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 

Thanks, sure will add these tags in next series.

Thanks,
Jagadeesh

> -- 
> Best wishes,
> Vladimir
> 

