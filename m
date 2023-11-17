Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6F7EF2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKQMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:43:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A5D52;
        Fri, 17 Nov 2023 04:43:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHBf75u031871;
        Fri, 17 Nov 2023 12:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EtUurOj+PAtGCdRjMWIiOk+m5UryLGuDlxyTcH/e8As=;
 b=VXf8cRbvd526HBV3LBjoRmK6hSAf/KsHTh64zGQDHVNkEfVoY3vAl85jY6TO8EtUdJne
 XVnu+BVRG3UfVF/eaGrX08w5X7DbLKe1Vky1KAQ6NA5Aiq2SFxWqLxYJgcqA7VB32P9w
 XJ9dVQ35gtu/29V8Q2iP5ZUnnMzzHVTzZEPc+Rmf7RtC2W6RRB7Ra4AKN6yRyQtbTwG3
 zL7iwVCfTC0eF8KCfI0qj2Qm4bvOJgvA+L5dHusGnm3ClGwKLI5IyAueRe8bb6WamgyG
 FKnuvHwrA/T87rAcKqdDPyCq6WvClD4vj8X2x0r6H6D12tmMdRkvy9Iu9xocx7XY71Kt 8g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8bspgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:43:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHCh9pj024463
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:43:09 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 04:43:05 -0800
Message-ID: <0116af05-bc55-0654-c341-a62bbb17047b@quicinc.com>
Date:   Fri, 17 Nov 2023 18:13:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nainmeht@quicinc.com>
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com>
 <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <4d8c094f-07b0-2b38-4680-145eb2d7c4f5@quicinc.com>
 <CAA8EJpr_PwD0kD0RdgcwLCGaCdau+3EUPAQd32hxccNbtoKaKg@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpr_PwD0kD0RdgcwLCGaCdau+3EUPAQd32hxccNbtoKaKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ptcGWJeVZ-aYicve1O6doz2WuN1kKSNv
X-Proofpoint-GUID: ptcGWJeVZ-aYicve1O6doz2WuN1kKSNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=640 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170094
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 3:03 PM, Dmitry Baryshkov wrote:
> On Fri, 17 Nov 2023 at 08:53, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> No HTML mail on kernel mailing lists, please. Some developers can have
> 'MIME => junk' mail filters.
> And replying to the HTML mail messes up quotation level.
>
>> On 11/4/2023 3:52 AM, Dmitry Baryshkov wrote:
>>
>> On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
>> platform. QCM6490 is derived from SC7280 meant for various
>> form factor including IoT.
>>
>> Supported features are, as of now:
>> * Debug UART
>> * eMMC (only in IDP)
>> * USB
>>
>> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   2 +
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  33 ++
>>   .../boot/dts/qcom/qcm6490-iot-common.dtsi     | 291 ++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/qcm6490-rb3.dts      |  26 ++
>>   4 files changed, 352 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
>>
>>
>> [...]
>>
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
>> new file mode 100644
>> index 000000000000..5b4c2826ac5c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-rb3.dts
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/* PM7250B is configured to use SID8/9 */
>> +#define PM7250B_SID 8
>> +#define PM7250B_SID1 9
>> +
>> +#include "qcm6490-iot-common.dtsi"
>> +#include "pm7250b.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. QCM6490 RB3";
>>
>> Is this a marketing name of the platform?
>>
>>
>> Sorry for the confusion, QCS6490 RB3gen2 is the correct marketing name for this board.
>> Will correct this in the next patchset.
> Then it is probably "Qualcomm Technologies, Inc. Robotics RB3gen2"?

Okay.

>
>> +       compatible = "qcom,qcm6490-rb3", "qcom,qcm6490";
>>
>> chassis-type = ?
>>
>>
>> No, this won't be needed as it is an evaluation board and will be used for multiple use cases.
>> So, we don't want to mark it to any specific type.
> Then it is "embedded". We should probably update existing
> dragonboards/RB boards to have this type too.

Okay, will chassis-type.

Thanks
Komal

>

