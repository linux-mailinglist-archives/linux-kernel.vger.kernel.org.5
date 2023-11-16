Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EBA7EDB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKPGat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:30:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD78A4;
        Wed, 15 Nov 2023 22:30:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG5fPto019356;
        Thu, 16 Nov 2023 06:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lJBWb0DFVaqBPn5WS2xIqEkp3Evqw9zDxdFgf67KCDo=;
 b=P41VhJ4FWvC3R/tlx2/fjOppb0a7ygI7oPFOOnIq3PGdAUBFnQLz0KLwh5RDpJB+sOH2
 /Hiop52rgGkF7KB5IMwl1Q9p18e1dlqqAsrE6SWoFTZU80N0NlgFK6PpKa78V2oRvW0k
 njcJM+hKtKcKEaWsv5rMc22+B7OSvSfU2LyTccaXV2vWhEtxa9k65fRvdasTgT3im0bH
 8CfpUO9pJ3D+e0M8m1X+3dFcoasXryjHVc7kyiw+xOawV8rhXlNHAHaBFHbkiL9WOudY
 iM5JRfL8rwLo/9DoSyPurWF50/j3Xioqi2dU23v3Jr5JbvFseUTv/fIkkp6wQOOZMh/N dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6ecgtwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:30:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG6UGH3014552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:30:16 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 22:30:02 -0800
Message-ID: <5a476b51-5916-74f8-0395-60d94f210aa0@quicinc.com>
Date:   Thu, 16 Nov 2023 11:59:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <daniel.lezcano@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <lars@metafoo.de>, <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <cros-qcom-dts-watchers@chromium.org>,
        <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <kernel@quicinc.com>
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <CAA8EJprJuiFq5UXc9weNr1hy2vW_10TaQweN_ZW5XW=3LKrgtA@mail.gmail.com>
Content-Language: en-US
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <CAA8EJprJuiFq5UXc9weNr1hy2vW_10TaQweN_ZW5XW=3LKrgtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DV90G0dLrhL99O234ZHLt0xsMNWcxz9J
X-Proofpoint-ORIG-GUID: DV90G0dLrhL99O234ZHLt0xsMNWcxz9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_03,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160049
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 11/16/2023 10:52 AM, Dmitry Baryshkov wrote:
> On Thu, 16 Nov 2023 at 05:26, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS. The major difference is
>> that the register interface used here is that of an SDAM present on
>> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
>> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
>> be used for either immediate reads (same functionality as previous PMIC5 and
>> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
>> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
>> combined into the same driver.
>>
>> Patches 1 adds bindings for ADC5 Gen3 peripheral.
>>
>> Patches 2 adds driver support for ADC5 Gen3.
> For some reason I don't see this patch in my inbox. Maybe it will
> arrive later. Immediate response: please add
> devm_thermal_add_hwmon_sysfs().


Yes, I'll check and add this in the next patch series, I'll wait for 
some more comments on the existing patches for now.

I ran into some error after sending the first two mails (cover letter 
and patch 1), so I sent patches 2 and 3 separately after it, I think you 
may have received them separately.


>
>> Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
>> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
>> specifically for ADC devices. It also fixes all compilation errors
>> with this change in driver and devicetree files and similar errors
>> in documentation for dtbinding check.
> NAK. The kernel is expected to build and work after each commit.
> Otherwise git-bisecting the kernel becomes impossible.
> So, please rework your series in a way that there are no compilation
> errors after any of the patches. The easiest way would be to rearrange
> your patches in 3-1-2 order.


I think you may have misunderstood the meaning here, I had verified 
compilation works each time after applying each of the three patches in 
this series. It's not that this last patch fixes compilation errors 
caused by the first two, this is a completely separate patch which 
affects existing QCOM ADC code (driver and devicetree) including ADC5 Gen3.


This patch does two things mainly:

Move the ADC binding files from dt-bindings/iio folder to 
dt-bindings/iio/adc folder (this would naturally cause some errors in 
driver and devicetree code due to path update)

Fix all compilation and dtbinding errors generated by the move


I added this change at the end of the series as I was not completely 
sure if it could get picked, just wanted to make it easier to drop if 
that is the final decision.


Thanks,

Jishnu


>
>
>> Changes since v1:
>> - Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
>> - Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
>> - Combined patches 8-11 into a single patch as requested by reviewers to make
>>    the change clearer and made all fixes required in same patch.
>>
>>   .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
>>   .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
>>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
>>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    0
>>   .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
>>   46 files changed, 1725 insertions(+), 61 deletions(-)
>>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
>>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
>>
>> --
>> 2.25.1
>>
>
> --
> With best wishes
> Dmitry
