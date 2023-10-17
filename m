Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0917CCEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjJQUtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:49:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE99F1;
        Tue, 17 Oct 2023 13:49:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJxL5w028802;
        Tue, 17 Oct 2023 20:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7hfYxqdaVSBGzCtP/S9qPiXdgv6XOO/NUMbd326UADE=;
 b=VG5j+iTWebHYLwK2gQ8QQ4IKW3s4u2Aa8eA7lCClCqgkEgalrkHaEwsezKnzFtZ2Z521
 2Y6gLrLr3DWfeuEPO6otJkMYbcs0dT4mPVLTr+yq0s02ZTTfBEQX44qvZNqk4uaVraNm
 MvG5yVfiRXTKgzWokkrTtQiiFLNFCYi6A94DhzHbdLtsoa46aTMi71UTaxukoUz9/2JX
 12m4w6yVy0jKEqKGcHrWQQqPqkmHT60gyr9QOlXo++YrFM/imow+by4Cz2BfPuFe86gt
 MAS322ySmZ/BRdJBlQ2L07yaRhQckw5WRBDoy3FsyEzGnpOkFS30vNkv/oJQthbnHZ5a aA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v0y87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:49:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HKmn3T030620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:48:49 GMT
Received: from [10.50.30.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 13:48:41 -0700
Message-ID: <2024130d-612e-9a3e-8c52-8982866e62f5@quicinc.com>
Date:   Wed, 18 Oct 2023 02:18:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 5/7] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_saahtoma@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-6-quic_devipriy@quicinc.com>
 <CAA8EJpr+Wwgot-PDRtj-LVi79aD13B9WVREmjTXiR-8XEEx-rQ@mail.gmail.com>
 <652b55cc-87dd-46d1-e480-e25f5f22b8d8@quicinc.com>
 <a4c9baae-f328-22b5-48d7-fc7df0b62a79@quicinc.com>
 <CAA8EJpq0uawrOBHA8XHygEpGYF--HyxJWxKG44iiFdAZZz7O2w@mail.gmail.com>
 <45f96567-553c-9214-eb7e-c75c6e09d78b@quicinc.com>
 <65b030c6-6fab-53ea-2774-48698905dd96@quicinc.com>
 <CAA8EJprSw4MGQKh01mZ5x5rBcRpgD7t4ph2617RhpR2Qg5SB=g@mail.gmail.com>
 <43aee0f9-3a83-3b90-5e3d-13a935f41b47@quicinc.com>
 <CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3zSnubBXBpPtv-axFdcQk1vC7QsHsCcC
X-Proofpoint-GUID: 3zSnubBXBpPtv-axFdcQk1vC7QsHsCcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_04,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170177
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2023 2:51 AM, Dmitry Baryshkov wrote:
> On Thu, 5 Oct 2023 at 12:56, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>>
>>
>> On 10/5/2023 12:49 PM, Dmitry Baryshkov wrote:
>>> On Thu, 5 Oct 2023 at 09:26, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/22/2023 5:31 PM, Devi Priya wrote:
>>>>>
>>>>>
>>>>> On 9/20/2023 1:50 PM, Dmitry Baryshkov wrote:
>>>>>> On Wed, 20 Sept 2023 at 09:39, Devi Priya <quic_devipriy@quicinc.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/12/2023 7:38 PM, Devi Priya wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/25/2023 5:14 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574
>>>>>>>>>> based
>>>>>>>>>> devices.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>>      Changes in V2:
>>>>>>>>>>             - Added depends on ARM64 || COMPILE_TEST in Kconfig
>>>>>>>>>>             - Added module_platform_driver
>>>>>>>>>>             - Dropped patch [2/6] - clk: qcom: gcc-ipq9574: Mark nssnoc
>>>>>>>>>> clocks as critical
>>>>>>>>>>                & added pm_clk for nssnoc clocks
>>>>>>>>>>             - Updated the uniphy clock names
>>>>>>>>>>
>>>>>>>>>>      drivers/clk/qcom/Kconfig         |    7 +
>>>>>>>>>>      drivers/clk/qcom/Makefile        |    1 +
>>>>>>>>>>      drivers/clk/qcom/nsscc-ipq9574.c | 3109
>>>>>>>>>> ++++++++++++++++++++++++++++++
>>>>>>>>>>      3 files changed, 3117 insertions(+)
>>>>>>>>>>      create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>>>>>>>>> index bd9bfb11b328..3ecc11e2c8e3 100644
>>>>>>>>>> --- a/drivers/clk/qcom/Kconfig
>>>>>>>>>> +++ b/drivers/clk/qcom/Kconfig
>>>>>>>>>> @@ -203,6 +203,13 @@ config IPQ_GCC_9574
>>>>>>>>>>               i2c, USB, SD/eMMC, etc. Select this for the root clock
>>>>>>>>>>               of ipq9574.
>>>>>>>>>>
>>>>>>>>>> +config IPQ_NSSCC_9574
>>>>>>>>>> +       tristate "IPQ9574 NSS Clock Controller"
>>>>>>>>>> +       depends on ARM64 || COMPILE_TEST
>>>>>>>>>> +       depends on IPQ_GCC_9574
>>>>>>>>>> +       help
>>>>>>>>>> +         Support for NSS clock controller on ipq9574 devices.
>>>>>>>>>> +
>>>>>>>>>>      config MSM_GCC_8660
>>>>>>>>>>             tristate "MSM8660 Global Clock Controller"
>>>>>>>>>>             depends on ARM || COMPILE_TEST
>>>>>>>>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>>>>>>>>> index 4790c8cca426..3f084928962e 100644
>>>>>>>>>> --- a/drivers/clk/qcom/Makefile
>>>>>>>>>> +++ b/drivers/clk/qcom/Makefile
>>>>>>>>>> @@ -30,6 +30,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>>>>>>>>>>      obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>>>>>>>>>>      obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>>>>>>>>>>      obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
>>>>>>>>>> +obj-$(CONFIG_IPQ_NSSCC_9574)   += nsscc-ipq9574.o
>>>>>>>>>>      obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>>>>>>>>>      obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>>>>>>>>>>      obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>>>>>>>>>> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c
>>>>>>>>>> b/drivers/clk/qcom/nsscc-ipq9574.c
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..65bdb449ae5f
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
>>>>>>>>>> @@ -0,0 +1,3109 @@
>>>>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>>>>>> +/*
>>>>>>>>>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>>>>>>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights
>>>>>>>>>> reserved.
>>>>>>>>>> + */
>>>>>>>>>> +
>>>>>>>>>> +#include <linux/clk-provider.h>
>>>>>>>>>> +#include <linux/err.h>
>>>>>>>>>> +#include <linux/kernel.h>
>>>>>>>>>> +#include <linux/module.h>
>>>>>>>>>> +#include <linux/of.h>
>>>>>>>>>> +#include <linux/of_device.h>
>>>>>>>>>> +#include <linux/regmap.h>
>>>>>>>>>> +#include <linux/pm_clock.h>
>>>>>>>>>> +#include <linux/pm_runtime.h>
>>>>>>>>>> +
>>>>>>>>>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
>>>>>>>>>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>>>>>>>>>> +
>>>>>>>>>> +#include "clk-alpha-pll.h"
>>>>>>>>>> +#include "clk-branch.h"
>>>>>>>>>> +#include "clk-pll.h"
>>>>>>>>>> +#include "clk-rcg.h"
>>>>>>>>>> +#include "clk-regmap.h"
>>>>>>>>>> +#include "clk-regmap-divider.h"
>>>>>>>>>> +#include "clk-regmap-mux.h"
>>>>>>>>>> +#include "common.h"
>>>>>>>>>> +#include "reset.h"
>>>>>>>>>> +
>>>>>>>>>> +/* Need to match the order of clocks in DT binding */
>>>>>>>>>> +enum {
>>>>>>>>>> +       DT_NSSNOC_NSSCC_CLK,
>>>>>>>>>> +       DT_NSSNOC_SNOC_CLK,
>>>>>>>>>> +       DT_NSSNOC_SNOC_1_CLK,
>>>>>>>>>
>>>>>>>>> Not using the index makes it seem that these clocks are not used,
>>>>>>>>> until one scrolls down to pm_clks.
>>>>>>>> Okay, got it
>>>>>>>>>
>>>>>>>>> BTW: The NSSNOC_SNOC clocks make it look like there is an interconnect
>>>>>>>>> here (not a simple NIU).
>>>>>>>>
>>>>>>>> Hi Dmitry, We are exploring on the ICC driver. In the meantime to
>>>>>>>> unblock PCIe/NSS changes getting merged, shall we use
>>>>>>>> regmap_update_bits
>>>>>>>> and turn on the critical NSSNOC clocks, ANOC & SNOC pcie clocks in the
>>>>>>>> probe function of the gcc driver itself as like sm8550 driver to get
>>>>>>>> the
>>>>>>>> changes merged?
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/qcom/gcc-sm8550.c#n3347
>>>>>>>
>>>>>>> Hi Dmitry,
>>>>>>> Just curious to know if we could send out the next series with the
>>>>>>> proposed approach if that holds good.
>>>>>>
>>>>>> The answer really depends on the structure of your hardware. The issue
>>>>>> is that once you commit the device bindings,you have to support them
>>>>>> forever. So, if you commit the NSS clock support without interconnects
>>>>>> in place, you have to keep this ANOC/SNOC/etc code forever, even after
>>>>>> you land the interconnect. So I'd suggest landing the icc driver first
>>>>>> (or at least implementing and sending to the mailing list), so that we
>>>>>> can see how all these pieces fit together.
>>>>>
>>>>> Hi Dmitry,
>>>>> Unlike MSM chipsets, IPQ chipsets does not have any use case wherein the
>>>>> NOC clocks have to be scaled. So if these clocks can be enabled in the
>>>>> probe, there is no need for an interconnect driver at all. The same
>>>>> applies to both ipq9574 and ipq5332 SoCs.
>>>>>
>>>>
>>>> Hi Dmitry,
>>>> Just curious to know if we can go ahead with the proposed solution of
>>>> enabling the NOC clocks in the probe as these clocks need not be scaled
>>>> in IPQ chipsets & hence there would be no need for an ICC driver in
>>>> ipq9574 & ipq5332 targets.
>>>
>>> In the probe of which driver?
>> GCC driver of ipq9574 & ipq5332 targets.
> 
> Would you need to handle these clocks additionally in the
> suspend/resume path? Will this increase the power consumption of the
> board?
> 
> Generally, I'd say this looks like a bad idea. Consider all the
> troubles we are undergoing now while sorting out the NIU clocks on RPM
> and RPMH platforms.
> So, unless you are 100% sure that this is a permanent solution (like
> AHB clocks being always on), I'd kindly suggest implementing the NoC
> attachment properly. In the end, other Qualcomm platforms use ICC
> drivers, so by following this pattern we will have more common code
> paths.
> 
Hi Dmitry,

Having these clocks always on seems to be a permanent solution and
we do not foresee any issues in our SoCs.

Thanks,
Devi Priya
